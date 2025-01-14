Return-Path: <linux-fsdevel+bounces-39197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301FFA11381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C768F3A4EED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF320F98F;
	Tue, 14 Jan 2025 21:57:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-13.prod.sxb1.secureserver.net (sxb1plsmtpa01-13.prod.sxb1.secureserver.net [188.121.53.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B620B1F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891841; cv=none; b=HaqknGc8ZI8C/3tdMoT8pUyvct8iFKMNkgG5ydMJH0tyCeBEOqnecv22iVgMQD0XZIoLs/Wnf9J+UxYFX8jmcGu3ctE5koY0xPda4CbIZCnOJzhjS8W092NygrlaxFI1nGKU+OeL/H+neOO7eDyGuIzwnV13y2QyP+SkQeJo8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891841; c=relaxed/simple;
	bh=Xvwa/m4jXWxEB4g5+0Wz6NrzFS2RMdeoxqIfwdjmh84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glvSb8Fe+EmxoC4BWyFAd8yIEypNyvjDlsNusJH1Z/15ndXVwQyZduWYnwi9PEugE841l2gTSt1St8atKasx6NK0Yt9Vx0JTKRBK/xb1sVn/SR/foaUts2jS8fF3JLNMjcdm8vIWHjm15Ok2ozDgFN+1oiP5leQ6Tt4D9+aovqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoD8tlti9dEQAXoD8tvQgz; Tue, 14 Jan 2025 14:12:30 -0700
X-CMAE-Analysis: v=2.4 cv=NvQrc9dJ c=1 sm=1 tr=0 ts=6786d33e
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=YMrt_mpcskI9137y0l4A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <f7fda655-2804-482f-b78f-0df4af267e33@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:12:04 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] squashfs; Convert squashfs_copy_cache() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-4-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241220224634.723899-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEqurCj75brZd9jqxpFMfzZWUVITt6O3POh9dmi+pGpeUBRDob7vyupZvYfzhbm5RI2TO7ejxpo2hZiZCjpWm2XtywoC59PR7qcpr6vTinHQ092XiIhT
 Bkvvlvqrb5GCFYPZEFDn34syFYDSe8uAe7ddfzstrlF5eT/rnSy8Nb/QqaUiWfenMMULeq2aB/bQdCs4oZYa0AH+j1lJnRuW8sZCXpxR5RFBgTCdLNtm+vxS
 Q2hXf5OqdXDDCgCJ5cH5TqHb9kjEhU0vS2IZmqHencM=



On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
> Remove accesses to page->index and page->mapping.  Also use folio
> APIs where available.  This code still assumes order 0 folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/file.c       | 46 ++++++++++++++++++++++------------------
>   fs/squashfs/file_cache.c |  2 +-
>   fs/squashfs/squashfs.h   |  4 ++--
>   3 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 5b81e26b1226..1f27e8161319 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -378,13 +378,15 @@ void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer,
>   }
>   
>   /* Copy data into page cache  */
> -void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
> -	int bytes, int offset)
> +void squashfs_copy_cache(struct folio *folio,
> +		struct squashfs_cache_entry *buffer, size_t bytes,
> +		size_t offset)
>   {
> -	struct inode *inode = page->mapping->host;
> +	struct address_space *mapping = folio->mapping;
> +	struct inode *inode = mapping->host;
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> -	int start_index = page->index & ~mask, end_index = start_index | mask;
> +	int start_index = folio->index & ~mask, end_index = start_index | mask;
>   
>   	/*
>   	 * Loop copying datablock into pages.  As the datablock likely covers
> @@ -394,25 +396,27 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
>   	 */
>   	for (i = start_index; i <= end_index && bytes > 0; i++,
>   			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
> -		struct page *push_page;
> -		int avail = buffer ? min_t(int, bytes, PAGE_SIZE) : 0;
> +		struct folio *push_folio;
> +		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
>   
> -		TRACE("bytes %d, i %d, available_bytes %d\n", bytes, i, avail);
> +		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> -		push_page = (i == page->index) ? page :
> -			grab_cache_page_nowait(page->mapping, i);
> +		push_folio = (i == folio->index) ? folio :
> +			__filemap_get_folio(mapping, i,
> +					FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
> +					mapping_gfp_mask(mapping));
>   
> -		if (!push_page)
> +		if (!push_folio)
>   			continue;
>   
> -		if (PageUptodate(push_page))
> -			goto skip_page;
> +		if (folio_test_uptodate(push_folio))
> +			goto skip_folio;
>   
> -		squashfs_fill_page(push_page, buffer, offset, avail);
> -skip_page:
> -		unlock_page(push_page);
> -		if (i != page->index)
> -			put_page(push_page);
> +		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
> +skip_folio:
> +		folio_unlock(push_folio);
> +		if (i != folio->index)
> +			folio_put(push_folio);
>   	}
>   }
>   
> @@ -430,16 +434,16 @@ static int squashfs_readpage_fragment(struct folio *folio, int expected)
>   			squashfs_i(inode)->fragment_block,
>   			squashfs_i(inode)->fragment_size);
>   	else
> -		squashfs_copy_cache(&folio->page, buffer, expected,
> +		squashfs_copy_cache(folio, buffer, expected,
>   			squashfs_i(inode)->fragment_offset);
>   
>   	squashfs_cache_put(buffer);
>   	return res;
>   }
>   
> -static int squashfs_readpage_sparse(struct page *page, int expected)
> +static int squashfs_readpage_sparse(struct folio *folio, int expected)
>   {
> -	squashfs_copy_cache(page, NULL, expected, 0);
> +	squashfs_copy_cache(folio, NULL, expected, 0);
>   	return 0;
>   }
>   
> @@ -470,7 +474,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   			goto out;
>   
>   		if (res == 0)
> -			res = squashfs_readpage_sparse(&folio->page, expected);
> +			res = squashfs_readpage_sparse(folio, expected);
>   		else
>   			res = squashfs_readpage_block(folio, block, res, expected);
>   	} else
> diff --git a/fs/squashfs/file_cache.c b/fs/squashfs/file_cache.c
> index 0360d22a77d4..40e59a43d098 100644
> --- a/fs/squashfs/file_cache.c
> +++ b/fs/squashfs/file_cache.c
> @@ -29,7 +29,7 @@ int squashfs_readpage_block(struct folio *folio, u64 block, int bsize, int expec
>   		ERROR("Unable to read page, block %llx, size %x\n", block,
>   			bsize);
>   	else
> -		squashfs_copy_cache(&folio->page, buffer, expected, 0);
> +		squashfs_copy_cache(folio, buffer, expected, 0);
>   
>   	squashfs_cache_put(buffer);
>   	return res;
> diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
> index 0f5373479516..9295556ecfd0 100644
> --- a/fs/squashfs/squashfs.h
> +++ b/fs/squashfs/squashfs.h
> @@ -68,8 +68,8 @@ extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
>   
>   /* file.c */
>   void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
> -void squashfs_copy_cache(struct page *, struct squashfs_cache_entry *, int,
> -				int);
> +void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *,
> +		size_t bytes, size_t offset);
>   
>   /* file_xxx.c */
>   int squashfs_readpage_block(struct folio *, u64 block, int bsize, int expected);

