Return-Path: <linux-fsdevel+bounces-39181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6207A112BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB93166A29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86720E6FF;
	Tue, 14 Jan 2025 21:11:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-02.prod.sxb1.secureserver.net (sxb1plsmtpa01-02.prod.sxb1.secureserver.net [188.121.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875A20CCE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889089; cv=none; b=MwdLr3s9TolzKkVLqRhk0+0iu5TEbFLE+hFFatD34Fe5gOZWAoRId8EsswgrkCVHhn0kih/6n7NQv3TIcXGlNhpE3A0vk2dybyCwm+Vw9tX9PB36P9TmosvOa1ZgJ/J9uXFnZfTi5l26f6wGVLFbmzePch44F9d+OGeBzuKxDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889089; c=relaxed/simple;
	bh=Vb7qBG+WHO3HhYJGS4k9UFw9x3AgHnRkFWRY2Rbhzno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkK9g7TSPpWEMYNLbUY1UURHrXRcRStfVE+YYV57O6BiAsHlPOJx8ctbDGuoipMfUV/RorriAzlwqbhkUwXUFuLVkpIflXsm39SIganmVqiFlp6vzmOAbJlAG6FoS3eT35bLweesMMHiWXQVBldaUB6IX2jEMvepK1Ps5KuKTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id Xo9gtGd7iwNr3Xo9gtVvbc; Tue, 14 Jan 2025 14:08:57 -0700
X-CMAE-Analysis: v=2.4 cv=L4LnQ/T8 c=1 sm=1 tr=0 ts=6786d269
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=YMrt_mpcskI9137y0l4A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <0f6aefda-b616-40f9-9ccd-bb5eabad4e27@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:08:31 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] squashfs; Convert squashfs_copy_cache() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-4-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241216162701.57549-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKZ/ag7YFn83X3UpOTOBUlGZoIWbzXzp7sr0lnOgdg1P4M1liOEAcRsVPSc/3oAIBXlZHplfGmiacjCIKeyVUd5a7+91oh1IZ1Ha94NT4v4hdOBh4+Oq
 523JT6pb6tGhtn3M242FOwGTrO8Be43gHqvoiVQNZ9DfqQkk8po9u4SPJgk6feon6D80AJqPIConuJyUd9qLSPmm5iyXoXc7NdJstu76iP2A775JCW0ySlgi
 iYeGH1Rnoh/BdH6ATs7FxmX8vIQLjX3xjAkXaaS8vNHsusF5v57DpAG6x4ACb2Xpe6IdsZDuWXgvoULRH9VNbA==



On 12/16/24 16:26, Matthew Wilcox (Oracle) wrote:
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

