Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819C62523C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 00:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHYWrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 18:47:31 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:38057 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgHYWr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:47:27 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id A3EF5D5C5D3;
        Wed, 26 Aug 2020 08:47:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kAhir-0000YA-VI; Wed, 26 Aug 2020 08:47:21 +1000
Date:   Wed, 26 Aug 2020 08:47:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v6 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20200825224721.GU12131@dread.disaster.area>
References: <20200824014234.7109-1-laoar.shao@gmail.com>
 <20200824014234.7109-3-laoar.shao@gmail.com>
 <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org>
 <20200824205647.GG17456@casper.infradead.org>
 <20200825053233.GN12131@dread.disaster.area>
 <CALOAHbAhhGXn3N7BTBqh336q0_P1WJH5xXtnBhdsBdS516NAvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAhhGXn3N7BTBqh336q0_P1WJH5xXtnBhdsBdS516NAvA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8
        a=nJcYd_7gk-7Rvg5WbY0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:22:08PM +0800, Yafang Shao wrote:
> On Tue, Aug 25, 2020 at 1:32 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Aug 24, 2020 at 09:56:47PM +0100, Matthew Wilcox wrote:
> > > On Mon, Aug 24, 2020 at 01:09:25PM -0700, Andrew Morton wrote:
> > > > On Mon, 24 Aug 2020 09:42:34 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > > --- a/include/linux/iomap.h
> > > > > +++ b/include/linux/iomap.h
> > > > > @@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
> > > > >  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)   (-EIO)
> > > > >  #endif /* CONFIG_SWAP */
> > > > >
> > > > > +/* Use the journal_info to indicate current is in a transaction */
> > > > > +static inline bool
> > > > > +fstrans_context_active(void)
> > > > > +{
> > > > > + return current->journal_info != NULL;
> > > > > +}
> > > >
> > > > Why choose iomap.h for this?
> > >
> > > Because it gets used in iomap/buffered-io.c
> > >
> > > I don't think this is necessarily a useful abstraction, to be honest.
> > > I'd just open-code 'if (current->journal_info)' or !current->journal_info,
> > > whichever way round the code is:
> > >
> > > fs/btrfs/delalloc-space.c:              if (current->journal_info)
> > > fs/ceph/xattr.c:                if (current->journal_info) {
> > > fs/gfs2/bmap.c:         if (current->journal_info) {
> > > fs/jbd2/transaction.c:  if (WARN_ON(current->journal_info)) {
> > > fs/reiserfs/super.c:    if (!current->journal_info) {
> >
> > /me wonders idly if any of the other filesystems that use
> > current->journal_info can have an active transaction while calling
> > ->writepages...
> >
> > .... and if so, whether this patchset has taken the wrong path in
> > trying to use current->journal_info for XFS to re-implement this
> > warning.....
> >
> > .... so we'll have to remove or rework this yet again when other
> > filesystems are converted to use iomap....
> >
> > /me suspects the btrfs_write_and_wait_transaction() is a path where
> > this can actually happen...
> >
> 
> How about adding a flag in struct writeback_control ?
> struct writeback_control {
>     ...
>     unsigned fstrans_check:1; /* Whether to check the current is in fstrans */
> };
> 
> Then we can set it in xfs_vm_writepage(s), for example,
> 
> xfs_vm_writepage
> {
>     wbc->fstrans_check = 1;  // set it for XFS only.
>     return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
> }

Yeah, but if we are doing that then I think we should just remove
the check completely from iomap_writepage() and move it up into
xfs_vm_writepage() and xfs_vm_writepages().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
