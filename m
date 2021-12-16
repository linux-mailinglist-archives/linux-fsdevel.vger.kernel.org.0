Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7294E477CA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 20:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhLPTgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLPTgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:36:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505AC061574;
        Thu, 16 Dec 2021 11:36:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85A461F56;
        Thu, 16 Dec 2021 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2F0C36AE7;
        Thu, 16 Dec 2021 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639683375;
        bh=XYnENVWX+t/nsTdqIGGKpVqYRQAVeLyh8aT//mTOS3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtTcM8L2QH3VtjpGERJHzEPIkwXHyY2Sudl0Zyby7cdQBbKU5euOKAcvzA25//NJ1
         wmpamRKgynzun8QhHV0OLeUcMYKYRF6n1qYvlBRzTQjHu9IVZuNCmIlsIdIt5LuSru
         pE3xACQEux175tL2tmo+RtFd/dM93rUW0fSX2pf486n0FXChi+/n65CzCabtzeSN7s
         mhBQpBwE1Xi7RljJdPk7yB4u0WwPO/l8qfvVQDWsqNaDFpDVJdxE4w4TKyb4zpO8bp
         qBd+ax17pif9NKjxBQ7HTATUU8eQs2mpj7YRvGRvL8utUbyf0XPOBT7oeCMcmztvZd
         OCMHHoLSMweAA==
Date:   Thu, 16 Dec 2021 11:36:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <20211216193614.GA27676@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
 <YbJ3O1qf+9p/HWka@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJ3O1qf+9p/HWka@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:38:03PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 08, 2021 at 04:05:42AM +0000, Matthew Wilcox (Oracle) wrote:
> > +++ b/fs/iomap/buffered-io.c
> > @@ -881,17 +881,20 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
> >  
> >  static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
> >  {
> > +	struct folio *folio;
> >  	struct page *page;
> >  	int status;
> > -	unsigned offset = offset_in_page(pos);
> > -	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> > +	size_t offset, bytes;
> >  
> > -	status = iomap_write_begin(iter, pos, bytes, &page);
> > +	status = iomap_write_begin(iter, pos, length, &page);
> 
> This turned out to be buggy.  Darrick and I figured out why his tests
> were failing and mine weren't; this only shows up with a 4kB block
> size filesystem and I was only testing with 1kB block size filesystems.
> (at least on x86; I haven't figured out why it passes with 1kB block size
> filesystems, so I'm not sure what would be true on other filesystems).
> iomap_write_begin() is not prepared to deal with a length that spans a
> page boundary.  So I'm replacing this patch with the following patches
> (whitespace damaged; pick them up from
> https://git.infradead.org/users/willy/linux.git/tag/refs/tags/iomap-folio-5.17c
> if you want to compile them):
> 
> commit 412212960b72
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Thu Dec 9 15:47:44 2021 -0500
> 
>     iomap: Allow iomap_write_begin() to be called with the full length
> 
>     In the future, we want write_begin to know the entire length of the
>     write so that it can choose to allocate large folios.  Pass the full
>     length in from __iomap_zero_iter() and limit it where necessary.
> 
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index d67108489148..9270db17c435 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -968,6 +968,9 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
>         struct gfs2_sbd *sdp = GFS2_SB(inode);
>         unsigned int blocks;
> 
> +       /* gfs2 does not support large folios yet */
> +       if (len > PAGE_SIZE)
> +               len = PAGE_SIZE;

This is awkward -- gfs2 doesn't set the mapping flag to indicate that it
supports large folios, so it should never be asked to deal with more
than a page at a time.  Shouldn't iomap_write_begin clamp its len
argument to PAGE_SIZE at the start if the mapping doesn't have the large
folios flag set?

--D

>         blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
>         return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
>  }
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d7a67655b60..67fcd3b9928d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -632,6 +632,8 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>                 goto out_no_page;
>         }
>         folio = page_folio(page);
> +       if (pos + len > folio_pos(folio) + folio_size(folio))
> +               len = folio_pos(folio) + folio_size(folio) - pos;
> 
>         if (srcmap->type == IOMAP_INLINE)
>                 status = iomap_write_begin_inline(iter, page);
> @@ -891,16 +893,19 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff
> _t pos, u64 length)
>         struct page *page;
>         int status;
>         unsigned offset = offset_in_page(pos);
> -       unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> 
> -       status = iomap_write_begin(iter, pos, bytes, &page);
> +       if (length > UINT_MAX)
> +               length = UINT_MAX;
> +       status = iomap_write_begin(iter, pos, length, &page);
>         if (status)
>                 return status;
> +       if (length > PAGE_SIZE - offset)
> +               length = PAGE_SIZE - offset;
> 
> -       zero_user(page, offset, bytes);
> +       zero_user(page, offset, length);
>         mark_page_accessed(page);
> 
> -       return iomap_write_end(iter, pos, bytes, bytes, page);
> +       return iomap_write_end(iter, pos, length, length, page);
>  }
> 
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> 
> 
> commit 78c747a1b3a1
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Fri Nov 5 14:24:09 2021 -0400
> 
>     iomap: Convert __iomap_zero_iter to use a folio
>     
>     The zero iterator can work in folio-sized chunks instead of page-sized
>     chunks.  This will save a lot of page cache lookups if the file is cached
>     in large folios.
>     
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 67fcd3b9928d..bbde6d4f27cd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -890,20 +890,23 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
>  static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
> +       struct folio *folio;
>         struct page *page;
>         int status;
> -       unsigned offset = offset_in_page(pos);
> +       size_t offset;
>  
>         if (length > UINT_MAX)
>                 length = UINT_MAX;
>         status = iomap_write_begin(iter, pos, length, &page);
>         if (status)
>                 return status;
> -       if (length > PAGE_SIZE - offset)
> -               length = PAGE_SIZE - offset;
> +       folio = page_folio(page);
>  
> -       zero_user(page, offset, length);
> -       mark_page_accessed(page);
> +       offset = offset_in_folio(folio, pos);
> +       if (length > folio_size(folio) - offset)
> +               length = folio_size(folio) - offset;
> +       folio_zero_range(folio, offset, length);
> +       folio_mark_accessed(folio);
>  
>         return iomap_write_end(iter, pos, length, length, page);
>  }
> 
> 
> The xfstests that Darrick identified as failing all passed.  Running a
> full sweep now; then I'll re-run with a 1kB filesystem to be sure that
> still passes.  Then I'll send another pull request.
