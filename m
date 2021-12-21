Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265A547C6BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbhLUSlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:41:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53780 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbhLUSlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:41:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E73614BB;
        Tue, 21 Dec 2021 18:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216B2C36AE8;
        Tue, 21 Dec 2021 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640112076;
        bh=TcAhcmKPDJiTf+3xKMg5zwHb806xTj+Tx5tC6UoVrt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJeFxALm+X04MXxMeR+/iLZCr2Ze1PLGeIrjhiM8JAKWXe/ubcDnlUA/zXuq7WDkw
         o249ShRlKSXU305LCzwED3MYQ0n6za44JTnH9bdVz/k1uRcp0bax6RF69jC+hE2ym+
         XVezbO0IwYMeJOn2vHsP3FlksNah6vvfdXtHf6Fx+6RhFgjb7cVTdJZ5wleEDYJmSs
         LsowiGjeyCKq6572miX7HULT9a+6ZrISNzSf69nheee5X0t9wcDo6rnyOnDgF4WdOW
         dXe9do7Y3oPqAUc1JhNzNhlM5wk/2FTcqN24HGcgbKOD2lsMgjS5LTzUyZnvH9xNSo
         eWefCck6kuH5g==
Date:   Tue, 21 Dec 2021 10:41:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: iomap-folio & nvdimm merge
Message-ID: <20211221184115.GY27664@magnolia>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-17-willy@infradead.org>
 <YcIIbtKhOulAL4s4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcIIbtKhOulAL4s4@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:01:34PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 16, 2021 at 09:07:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > The zero iterator can work in folio-sized chunks instead of page-sized
> > chunks.  This will save a lot of page cache lookups if the file is cached
> > in large folios.
> 
> This patch (and a few others) end up conflicting with what Christoph did
> that's now in the nvdimm tree.  In an effort to make the merge cleaner,
> I took the next-20211220 tag and did the following:
> 
> Revert de291b590286
> Apply: https://lore.kernel.org/linux-xfs/20211221044450.517558-1-willy@infradead.org/
> (these two things are likely to happen in the nvdimm tree imminently)
> 
> I then checked out iomap-folio-5.17e and added this patch:
> 
>     iomap: Inline __iomap_zero_iter into its caller
> 
>     To make the merge easier, replicate the inlining of __iomap_zero_iter()
>     into iomap_zero_iter() that is currently in the nvdimm tree.
> 
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks like a reasonable function promotion to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ba80bedd9590..c6b3a148e898 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -895,27 +895,6 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
> -{
> -       struct folio *folio;
> -       int status;
> -       size_t offset;
> -       size_t bytes = min_t(u64, SIZE_MAX, length);
> -
> -       status = iomap_write_begin(iter, pos, bytes, &folio);
> -       if (status)
> -               return status;
> -
> -       offset = offset_in_folio(folio, pos);
> -       if (bytes > folio_size(folio) - offset)
> -               bytes = folio_size(folio) - offset;
> -
> -       folio_zero_range(folio, offset, bytes);
> -       folio_mark_accessed(folio);
> -
> -       return iomap_write_end(iter, pos, bytes, bytes, folio);
> -}
> -
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>         struct iomap *iomap = &iter->iomap;
> @@ -929,14 +908,34 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>                 return length;
>  
>         do {
> -               s64 bytes;
> +               struct folio *folio;
> +               int status;
> +               size_t offset;
> +               size_t bytes = min_t(u64, SIZE_MAX, length);
> +
> +               if (IS_DAX(iter->inode)) {
> +                       s64 tmp = dax_iomap_zero(pos, bytes, iomap);
> +                       if (tmp < 0)
> +                               return tmp;
> +                       bytes = tmp;
> +                       goto good;
> +               }
>  
> -               if (IS_DAX(iter->inode))
> -                       bytes = dax_iomap_zero(pos, length, iomap);
> -               else
> -                       bytes = __iomap_zero_iter(iter, pos, length);
> -               if (bytes < 0)
> -                       return bytes;
> +               status = iomap_write_begin(iter, pos, bytes, &folio);
> +               if (status)
> +                       return status;
> +
> +               offset = offset_in_folio(folio, pos);
> +               if (bytes > folio_size(folio) - offset)
> +                       bytes = folio_size(folio) - offset;
> +
> +               folio_zero_range(folio, offset, bytes);
> +               folio_mark_accessed(folio);
> +
> +               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +good:
> +               if (WARN_ON_ONCE(bytes == 0))
> +                       return -EIO;
>  
>                 pos += bytes;
>                 length -= bytes;
> 
> 
> 
> Then I did the merge, and the merge commit looks pretty sensible
> afterwards:
> 
>     Merge branch 'iomap-folio-5.17f' into fixup
> 
> diff --cc fs/iomap/buffered-io.c
> index 955f51f94b3f,c6b3a148e898..c938bbad075e
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@@ -888,19 -908,32 +907,23 @@@ static loff_t iomap_zero_iter(struct io
>                 return length;
> 
>         do {
> -               unsigned offset = offset_in_page(pos);
> -               size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> -               struct page *page;
> +               struct folio *folio;
>                 int status;
> +               size_t offset;
> +               size_t bytes = min_t(u64, SIZE_MAX, length);
> 
> -               status = iomap_write_begin(iter, pos, bytes, &page);
>  -              if (IS_DAX(iter->inode)) {
>  -                      s64 tmp = dax_iomap_zero(pos, bytes, iomap);
>  -                      if (tmp < 0)
>  -                              return tmp;
>  -                      bytes = tmp;
>  -                      goto good;
>  -              }
>  -
> +               status = iomap_write_begin(iter, pos, bytes, &folio);
>                 if (status)
>                         return status;
> 
> -               zero_user(page, offset, bytes);
> -               mark_page_accessed(page);
> +               offset = offset_in_folio(folio, pos);
> +               if (bytes > folio_size(folio) - offset)
> +                       bytes = folio_size(folio) - offset;
> +
> +               folio_zero_range(folio, offset, bytes);
> +               folio_mark_accessed(folio);
> 
> -               bytes = iomap_write_end(iter, pos, bytes, bytes, page);
> +               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
>  -good:

Assuming I'm reading the metadiff properly, I think this merge
resolution looks correct given what both patchsets are trying to do.

>                 if (WARN_ON_ONCE(bytes == 0))
>                         return -EIO;
> 
> 
> 
> Shall I push out a version of this patch series which includes the
> "iomap: Inline __iomap_zero_iter into its caller" patch I pasted above?

Yes.

I've been distracted for months with first a Huge Customer Escalation
and now a <embargoed>, which means that I've been and continue to be
very distracted.  I /think/ there are no other iomap patches being
proposed for inclusion -- Andreas' patches were applied as fixes during
5.16-rc, Christoph's DAX refactoring is now in the nvdimm tree, and that
leaves Matthew's folios refactoring.

So seeing as (I think?) there are no other iomap patches for 5.17, if
Matthew wants to add his branch to for-next and push directly to Linus
(rather than pushing to me to push the exact same branch to Linus) I
think that would be ... better than letting it block on me.  IIRC I've
RVB'd everything in the folios branch. :(

FWIW I ran the 5.17e branch through my fstests cloud and nothing fell
out, so I think it's in good enough shape to merge to for-next.

--D
