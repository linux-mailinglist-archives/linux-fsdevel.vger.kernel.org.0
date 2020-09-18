Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3101426FDEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIRNNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 09:13:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgIRNNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:13:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A077ABF4;
        Fri, 18 Sep 2020 13:13:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ABB001E12E1; Fri, 18 Sep 2020 15:13:17 +0200 (CEST)
Date:   Fri, 18 Sep 2020 15:13:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: the "read" syscall sees partial effects of the "write" syscall
Message-ID: <20200918131317.GH18920@quack2.suse.cz>
References: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
 <alpine.LRH.2.02.2009180509370.19302@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009180509370.19302@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-09-20 08:25:28, Mikulas Patocka wrote:
> I'd like to ask about this problem: when we write to a file, the kernel 
> takes the write inode lock. When we read from a file, no lock is taken - 
> thus the read syscall can read data that are halfway modified by the write 
> syscall.
> 
> The standard specifies the effects of the write syscall are atomic - see 
> this:
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07

Yes, but no Linux filesystem (except for XFS AFAIK) follows the POSIX spec
in this regard. Mostly because the mixed read-write performance sucks when
you follow it (not that it would absolutely have to suck - you can use
clever locking with range locks but nobody does it currently). In practice,
the read-write atomicity works on Linux only on per-page basis for buffered
IO.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
