Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689521E7BD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 13:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgE2LbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgE2LbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 07:31:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E0C03E969;
        Fri, 29 May 2020 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tnwqW11y4jVBf49PnvhY1DXeLkmbR7HR6dDulQvUyRA=; b=HkdQMrjVdH7XpcTqRQ8NMg+fOM
        0mWgnWkv3I4jR8+cCpt4qT+XfqXGXKjt1PkjVsQVVO9Uhz/B1ZUo7jo/tY9vYr+wihSl7R4LGu+CU
        pb285F1IL/Cox8ObuhpLmo4G+qM3eS96yKJ6MBS8CstpCXIccpznaNCgUGtZsdtdbyFDJZEgH3LbY
        Jn7zLOl6Xv6BDdbfGQQkvUbbXMDEufQUMytQjRTx/U/eFTRw1iH/kygSXwXUax7WVVRT9gHK5QA15
        5GK4vyBna/YchVxNRa+Pjekq/KgET7MEgtNjWSU4uXbf1UVPXUdtGY3axrd2/s4hThYQ8EISqEv6j
        lGyoLP7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jedEK-0006cL-Hq; Fri, 29 May 2020 11:31:19 +0000
Date:   Fri, 29 May 2020 04:31:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200529113116.GU17206@bombadil.infradead.org>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
 <CAL3q7H4Mit=P9yHsZXKsVxMN0=7m7gS2ZqiGTbyFz5Aid9t3hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4Mit=P9yHsZXKsVxMN0=7m7gS2ZqiGTbyFz5Aid9t3hQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:55:33AM +0100, Filipe Manana wrote:
> On Fri, May 29, 2020 at 1:23 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > >
> > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > because pages could be locked as a part of the extent. Return zero
> >
> > Locked for what?  filemap_write_and_wait_range should have just cleaned
> > them off.
> 
> Yes, it will be confusing even for someone more familiar with btrfs.
> The changelog could be more detailed to make it clear what's happening and why.
> 
> So what happens:
> 
> 1) iomap_dio_rw() calls filemap_write_and_wait_range().
>     That starts delalloc for all dirty pages in the range and then
> waits for writeback to complete.
>     This is enough for most filesystems at least (if not all except btrfs).
> 
> 2) However, in btrfs once writeback finishes, a job is queued to run
> on a dedicated workqueue, to execute the function
> btrfs_finish_ordered_io().
>     So that job will be run after filemap_write_and_wait_range() returns.
>     That function locks the file range (using a btrfs specific data
> structure), does a bunch of things (updating several btrees), and then
> unlocks the file range.
> 
> 3) While iomap calls invalidate_inode_pages2_range(), which ends up
> calling the btrfs callback btfs_releasepage(),
>     btrfs_finish_ordered_io() is running and has the file range locked
> (this is what Goldwyn means by "pages could be locked", which is
> confusing because it's not about any locked struct page).
> 
> 4) Because the file range is locked, btrfs_releasepage() returns 0
> (page can't be released), this happens in the helper function
> try_release_extent_state().
>     Any page in that range is not dirty nor under writeback anymore
> and, in fact, btrfs_finished_ordered_io() doesn't do anything with the
> pages, it's only updating metadata.
> 
>     btrfs_releasepage() in this case could release the pages, but
> there are other contextes where the file range is locked, the pages
> are still not dirty and not under writeback, where this would not be
> safe to do.

Isn't this the bug, though?  Rather than returning "page can't be
released", shouldn't ->releasepage sleep on the extent state, at least
if the GFP mask indicates you can sleep?

> 5) So because of that invalidate_inode_pages2_range() returns
> non-zero, the iomap code prints that warning message and then proceeds
> with doing a direct IO write anyway.
> 
> What happens currently in btrfs, before Goldwyn's patchset:
> 
> 1) generic_file_direct_write() also calls filemap_write_and_wait_range().
> 2) After that it calls invalidate_inode_pages2_range() too, but if
> that returns non-zero, it doesn't print any warning and falls back to
> a buffered write.
> 
> So Goldwyn here is effectively adding that behaviour from
> generic_file_direct_write() to iomap.
> 
> Thanks.
> 
> >
> > > in case a page cache invalidation is unsuccessful so filesystems can
> > > fallback to buffered I/O. This is similar to
> > > generic_file_direct_write().
> > >
> > > This takes care of the following invalidation warning during btrfs
> > > mixed buffered and direct I/O using iomap_dio_rw():
> > >
> > > Page cache invalidation failure on direct I/O.  Possible data
> > > corruption due to collision with buffered I/O!
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > >
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index e4addfc58107..215315be6233 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >        */
> > >       ret = invalidate_inode_pages2_range(mapping,
> > >                       pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > -     if (ret)
> > > -             dio_warn_stale_pagecache(iocb->ki_filp);
> > > -     ret = 0;
> > > +     /*
> > > +      * If a page can not be invalidated, return 0 to fall back
> > > +      * to buffered write.
> > > +      */
> > > +     if (ret) {
> > > +             if (ret == -EBUSY)
> > > +                     ret = 0;
> > > +             goto out_free_dio;
> >
> > XFS doesn't fall back to buffered io when directio fails, which means
> > this will cause a regression there.
> >
> > Granted mixing write types is bogus...
> >
> > --D
> >
> > > +     }
> > >
> > >       if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> > >           !inode->i_sb->s_dio_done_wq) {
> > >
> > > --
> > > Goldwyn
> 
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
