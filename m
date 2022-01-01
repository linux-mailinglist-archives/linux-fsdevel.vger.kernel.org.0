Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A35482670
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 04:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiAADzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 22:55:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54542 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231981AbiAADzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 22:55:23 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A22358A82C3;
        Sat,  1 Jan 2022 14:55:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n3VUC-009v7v-U6; Sat, 01 Jan 2022 14:55:16 +1100
Date:   Sat, 1 Jan 2022 14:55:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220101035516.GE945095@dread.disaster.area>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61cfd0a9
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=8nJEP1OIZ-IA:10 a=DghFqjY3_ZEA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=TWvumlEzFTB4rAomDY4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021 at 06:16:53AM +0000, Trond Myklebust wrote:
> On Fri, 2021-12-31 at 01:42 +0000, Matthew Wilcox wrote:
> > On Thu, Dec 30, 2021 at 02:35:22PM -0500, trondmy@kernel.org wrote:
> > >  Workqueue: xfs-conv/md127 xfs_end_io [xfs]
> > >  RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
> > >  Code: 7c ff 48 29 e8 4c 39 e0 76 cf 80 0b 08 eb 8c 90 90 90 90 90
> > > 90 90 90 90 90 0f 1f 44 00 00 e8 e6 db 7e ff 66 90 48 89 f7 57 9d
> > > <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 07
> > >  RSP: 0018:ffffac51d26dfd18 EFLAGS: 00000202 ORIG_RAX:
> > > ffffffffffffff12
> > >  RAX: 0000000000000001 RBX: ffffffff980085a0 RCX: dead000000000200
> > >  RDX: ffffac51d3893c40 RSI: 0000000000000202 RDI: 0000000000000202
> > >  RBP: 0000000000000202 R08: ffffac51d3893c40 R09: 0000000000000000
> > >  R10: 00000000000000b9 R11: 00000000000004b3 R12: 0000000000000a20
> > >  R13: ffffd228f3e5a200 R14: ffff963cf7f58d10 R15: ffffd228f3e5a200
> > >  FS:  0000000000000000(0000) GS:ffff9625bfb00000(0000)
> > > knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 00007f5035487500 CR3: 0000000432810004 CR4: 00000000003706e0
> > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >  Call Trace:
> > >   wake_up_page_bit+0x8a/0x110
> > >   iomap_finish_ioend+0xd7/0x1c0
> > >   iomap_finish_ioends+0x7f/0xb0
> > 
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1052,9 +1052,11 @@ iomap_finish_ioend(struct iomap_ioend
> > > *ioend, int error)
> > >                         next = bio->bi_private;
> > >  
> > >                 /* walk each page on bio, ending page IO on them */
> > > -               bio_for_each_segment_all(bv, bio, iter_all)
> > > +               bio_for_each_segment_all(bv, bio, iter_all) {
> > >                         iomap_finish_page_writeback(inode, bv-
> > > >bv_page, error,
> > >                                         bv->bv_len);
> > > +                       cond_resched();
> > > +               }
> > >                 bio_put(bio);
> > >         }
> > >         /* The ioend has been freed by bio_put() */
> > 
> > As I recall, iomap_finish_ioend() can be called in softirq (or even
> > hardirq?) context currently.  I think we've seen similar things
> > before,
> > and the solution suggested at the time was to aggregate fewer
> > writeback
> > pages into a single bio.
> 
> I haven't seen any evidence that iomap_finish_ioend() is being called
> from anything other than a regular task context. Where can it be called
> from softirq/hardirq and why is that a requirement?

softirq based bio completion is possible, AFAIA. The path is
iomap_writepage_end_bio() -> iomap_finish_ioend() from the bio endio
completion callback set up by iomap_submit_bio(). This will happen
with gfs2 and zonefs, at least.

XFS, however, happens to override the generic bio endio completion
via it's ->prepare_ioend so instead we go xfs_end_bio -> work queue
-> xfs_end_io -> xfs_end_ioend -> iomap_finish_ioends ->
iomap_finish_ioend.

So, yeah, if all you are looking at is XFS IO completions, you'll
only see them run from workqueue task context. Other filesystems can
run them from softirq based bio completion context.

As it is, if you are getting soft lockups in this location, that's
an indication that the ioend chain that is being built by XFS is
way, way too long. IOWs, the completion latency problem is caused by
a lack of submit side ioend chain length bounding in combination
with unbound completion side merging in xfs_end_bio - it's not a
problem with the generic iomap code....

Let's try to address this in the XFS code, rather than hack
unnecessary band-aids over the problem in the generic code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
