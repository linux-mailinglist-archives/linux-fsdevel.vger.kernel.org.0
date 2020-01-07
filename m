Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3580131CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 01:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgAGAju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 19:39:50 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49793 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbgAGAju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:39:50 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B1B7B3A1347;
        Tue,  7 Jan 2020 11:39:44 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iocuO-0006tT-25; Tue, 07 Jan 2020 11:39:44 +1100
Date:   Tue, 7 Jan 2020 11:39:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200107003944.GN23195@dread.disaster.area>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
 <20200107001643.GA485121@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107001643.GA485121@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=CqsqYK7GuNR5ViALEa4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:16:43AM +0000, Chris Down wrote:
> Dave Chinner writes:
> > It took 15 years for us to be able to essentially deprecate
> > inode32 (inode64 is the default behaviour), and we were very happy
> > to get that albatross off our necks.  In reality, almost everything
> > out there in the world handles 64 bit inodes correctly
> > including 32 bit machines and 32bit binaries on 64 bit machines.
> > And, IMNSHO, there no excuse these days for 32 bit binaries that
> > don't using the *64() syscall variants directly and hence support
> > 64 bit inodes correctlyi out of the box on all platforms.
> > 
> > I don't think we should be repeating past mistakes by trying to
> > cater for broken 32 bit applications on 64 bit machines in this day
> > and age.
> 
> I'm very glad to hear that. I strongly support moving to 64-bit inums in all
> cases if there is precedent that it's not a compatibility issue, but from
> the comments on my original[0] patch (especially that they strayed from the
> original patches' change to use ino_t directly into slab reuse), I'd been
> given the impression that it was known to be one.
> 
> From my perspective I have no evidence that inode32 is needed other than the
> comment from Jeff above get_next_ino. If that turns out not to be a problem,
> I am more than happy to just wholesale migrate 64-bit inodes per-sb in
> tmpfs.

Well, that's my comment above about 32 bit apps using non-LFS
compliant interfaces in this day and age. It's essentially a legacy
interface these days, and anyone trying to access a modern linux
filesystem (btrfs, XFS, ext4, etc) ion 64 bit systems need to handle
64 bit inodes because they all can create >32bit inode numbers
in their default configurations.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
