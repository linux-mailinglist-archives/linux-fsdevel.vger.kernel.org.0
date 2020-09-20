Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA92718A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgITXlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 19:41:17 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45020 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgITXlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:41:16 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CCBD682561D;
        Mon, 21 Sep 2020 09:41:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kK8x5-0005ki-Rl; Mon, 21 Sep 2020 09:41:03 +1000
Date:   Mon, 21 Sep 2020 09:41:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: the "read" syscall sees partial effects of the "write" syscall
Message-ID: <20200920234103.GX12096@dread.disaster.area>
References: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
 <alpine.LRH.2.02.2009180509370.19302@file01.intranet.prod.int.rdu2.redhat.com>
 <20200918131317.GH18920@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918131317.GH18920@quack2.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=uZvujYp8AAAA:8 a=7-415B0cAAAA:8
        a=IhRoebVIs0TbUmjakS8A:9 a=CjuIK1q_8ugA:10 a=nv2HPNHG-XcA:10
        a=SLzB8X_8jTLwj6mN0q5r:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 03:13:17PM +0200, Jan Kara wrote:
> On Fri 18-09-20 08:25:28, Mikulas Patocka wrote:
> > I'd like to ask about this problem: when we write to a file, the kernel 
> > takes the write inode lock. When we read from a file, no lock is taken - 
> > thus the read syscall can read data that are halfway modified by the write 
> > syscall.
> > 
> > The standard specifies the effects of the write syscall are atomic - see 
> > this:
> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07
> 
> Yes, but no Linux filesystem (except for XFS AFAIK) follows the POSIX spec
> in this regard. Mostly because the mixed read-write performance sucks when
> you follow it (not that it would absolutely have to suck - you can use
> clever locking with range locks but nobody does it currently). In practice,
> the read-write atomicity works on Linux only on per-page basis for buffered
> IO.

We come across this from time to time with POSIX compliant
applications being ported from other Unixes that rely on a write
from one thread being seen atomically from a read from another
thread. There are quite a few custom enterprise apps around that
rely on this POSIX behaviour, especially stuff that has come from
different Unixes that actually provided Posix compliant behaviour.

IOWs, from an upstream POV, POSIX atomic write behaviour doesn't
matter very much. From an enterprise distro POV it's often a
different story....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
