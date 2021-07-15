Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308783CAEB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhGOVoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhGOVoA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E15A9613C4;
        Thu, 15 Jul 2021 21:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626385267;
        bh=boeoRdAwNjY3dPChiEWxtb28FAMFJvybc2RVJmTuJ+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJqjvZ4qBb7X9gAyHeWJ58uumLKgqEEE7n0okAC0XG1em4DEqagD3RG7V7jUtyylG
         ZTr2gF11LZeIjK2bYO1sdgEz8aEYHG9S3/ahbXJUB/9PTlaNYL7kncOpQBQr3ssGzV
         zbVfus+wHhYi0w7loKcaPkIuL3wId/szIqvVaZxpCOxrpxNDEak9HR0gVOuPsV52EK
         5k6Umk3h7mLoKT+WlEb2hi15BSRDy1nptxF8o56xuDIbiTcFvMzRd0JFPaWhkDNjAU
         78DCO7gxENzzHiDVpr+OXHlq7hWJ5xxueMecA+oqBmqNGAg8T/ySuBuIXFu+k/2b+H
         htcpJsmXXgE/A==
Date:   Thu, 15 Jul 2021 14:41:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 101/138] iomap: Convert iomap_page_mkwrite to use a
 folio
Message-ID: <20210715214106.GL22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-102-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-102-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:27AM +0100, Matthew Wilcox (Oracle) wrote:
> If we write to any page in a folio, we have to mark the entire
> folio as dirty, and potentially COW the entire folio, because it'll
> all get written back as one unit.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7c702d6c2f64..a3fe0d36c739 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -951,23 +951,23 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  }
>  EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
> -static loff_t
> -iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> +static loff_t iomap_folio_mkwrite_actor(struct inode *inode, loff_t pos,
> +		loff_t length, void *data, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
> -	struct page *page = data;
> -	struct folio *folio = page_folio(page);
> +	struct folio *folio = data;
>  	int ret;
>  
>  	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
> +		ret = __block_write_begin_int(&folio->page, pos, length, NULL,
> +						iomap);
>  		if (ret)
>  			return ret;
> -		block_commit_write(page, 0, length);
> +		block_commit_write(&folio->page, 0, length);
>  	} else {
> -		WARN_ON_ONCE(!PageUptodate(page));
> +		WARN_ON_ONCE(!folio_test_uptodate(folio));
>  		iomap_page_create(inode, folio);
> -		set_page_dirty(page);
> +		folio_mark_dirty(folio);
>  	}
>  
>  	return length;
> @@ -975,33 +975,33 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  {
> -	struct page *page = vmf->page;
> +	struct folio *folio = page_folio(vmf->page);

If before the page fault the folio was a compound 2M page, will the
memory manager will have split it into 4k pages before passing it to us?

That's a roundabout way of asking if we should expect folio_mkwrite at
some point. ;)

The conversion looks pretty straightforward though.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> -	unsigned long length;
> -	loff_t offset;
> +	size_t length;
> +	loff_t pos;
>  	ssize_t ret;
>  
> -	lock_page(page);
> -	ret = page_mkwrite_check_truncate(page, inode);
> +	folio_lock(folio);
> +	ret = folio_mkwrite_check_truncate(folio, inode);
>  	if (ret < 0)
>  		goto out_unlock;
>  	length = ret;
>  
> -	offset = page_offset(page);
> +	pos = folio_pos(folio);
>  	while (length > 0) {
> -		ret = iomap_apply(inode, offset, length,
> -				IOMAP_WRITE | IOMAP_FAULT, ops, page,
> -				iomap_page_mkwrite_actor);
> +		ret = iomap_apply(inode, pos, length,
> +				IOMAP_WRITE | IOMAP_FAULT, ops, folio,
> +				iomap_folio_mkwrite_actor);
>  		if (unlikely(ret <= 0))
>  			goto out_unlock;
> -		offset += ret;
> +		pos += ret;
>  		length -= ret;
>  	}
>  
> -	wait_for_stable_page(page);
> +	folio_wait_stable(folio);
>  	return VM_FAULT_LOCKED;
>  out_unlock:
> -	unlock_page(page);
> +	folio_unlock(folio);
>  	return block_page_mkwrite_return(ret);
>  }
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
> -- 
> 2.30.2
> 
