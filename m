Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77850488D60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 00:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiAIXew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 18:34:52 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42555 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232177AbiAIXeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:34:50 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B2F7562BFE1;
        Mon, 10 Jan 2022 10:34:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n6hi1-00DOS4-Vx; Mon, 10 Jan 2022 10:34:46 +1100
Date:   Mon, 10 Jan 2022 10:34:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220109233445.GV945095@dread.disaster.area>
References: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
 <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
 <20220105224829.GO945095@dread.disaster.area>
 <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61db7118
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=8dnNa2oGcPcZme6KG7IA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 06, 2022 at 06:36:52PM +0000, Trond Myklebust wrote:
> On Thu, 2022-01-06 at 09:48 +1100, Dave Chinner wrote:
> > On Wed, Jan 05, 2022 at 08:45:05PM +0000, Trond Myklebust wrote:
> > > On Tue, 2022-01-04 at 21:09 -0500, Trond Myklebust wrote:
> > > > On Tue, 2022-01-04 at 12:22 +1100, Dave Chinner wrote:
> > > > > On Tue, Jan 04, 2022 at 12:04:23AM +0000, Trond Myklebust
> > > > > wrote:
> > > > > > We have different reproducers. The common feature appears to
> > > > > > be
> > > > > > the
> > > > > > need for a decently fast box with fairly large memory (128GB
> > > > > > in
> > > > > > one
> > > > > > case, 400GB in the other). It has been reproduced with HDs,
> > > > > > SSDs
> > > > > > and
> > > > > > NVME systems.
> > > > > > 
> > > > > > On the 128GB box, we had it set up with 10+ disks in a JBOD
> > > > > > configuration and were running the AJA system tests.
> > > > > > 
> > > > > > On the 400GB box, we were just serially creating large (>
> > > > > > 6GB)
> > > > > > files
> > > > > > using fio and that was occasionally triggering the issue.
> > > > > > However
> > > > > > doing
> > > > > > an strace of that workload to disk reproduced the problem
> > > > > > faster
> > > > > > :-
> > > > > > ).
> > > > > 
> > > > > Ok, that matches up with the "lots of logically sequential
> > > > > dirty
> > > > > data on a single inode in cache" vector that is required to
> > > > > create
> > > > > really long bio chains on individual ioends.
> > > > > 
> > > > > Can you try the patch below and see if addresses the issue?
> > > > > 
> > > > 
> > > > That patch does seem to fix the soft lockups.
> > > > 
> > > 
> > > Oops... Strike that, apparently our tests just hit the following
> > > when
> > > running on AWS with that patch.
> > 
> > OK, so there are also large contiguous physical extents being
> > allocated in some cases here.
> > 
> > > So it was harder to hit, but we still did eventually.
> > 
> > Yup, that's what I wanted to know - it indicates that both the
> > filesystem completion processing and the iomap page processing play
> > a role in the CPU usage. More complex patch for you to try below...
> > 
> > Cheers,
> > 
> > Dave.
> 
> Hi Dave,
> 
> This patch got further than the previous one. However it too failed on
> the same AWS setup after we started creating larger (in this case 52GB)
> files. The previous patch failed at 15GB.

Ok, so that indicates that the page cache pages are being allocated
at write() time from physically contiguous pages so that we are
ending up with a large number of bvec merges in the bio layeri
during writeback. i.e. we're building multipage bvecs in the bios
and so the segment count per bvec is low (maybe one per bio, instead
of ~256 if the pages are not physically contiguous).

I'd hoped that wasn't going to be an issue because, unless memory is
largely empty and the workload is completely single threaded, you
can't get continuous gigabyte scale runs of contiguous pages in the
page cache for sequential writes. Hence I figured the segment limits
would trigger long before we get into the "millions of pages to
complete" needed to trigger the soft lockup.

Ok, I'll ignore bio segments and the upcoming multi-page folio stuff
that will largely result in 1:1 bio segment:folio ratios and just
count pages instead...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
