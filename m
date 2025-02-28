Return-Path: <linux-fsdevel+bounces-42830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EDDA49253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 08:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B003B8EB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EA1CAA88;
	Fri, 28 Feb 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSfhQlOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01F1C5D69
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728235; cv=none; b=VfJVTfzY7Rem2bm0BQp1r8MjMCAU0lX2RVxU421gL42q0WwK+vHV9jpzvkDcOjwOyEVhy8+y5hASODGANNdJXtHKsItPofavsBj1gHiHDeJ6VfAq05uJo8SofW9sIZ5Nwb+agA05BxLQ2BB9YToU8XgdUtxHdXO3Ry+sFIvmRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728235; c=relaxed/simple;
	bh=cDtlqKcwOFTEnTBTdNOJ0/fAqkcZEXUrqyrdJoyMgog=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=il7+4fxOwHRAJkv5grOjjLaDqKsgKQTjUGZhJMg5xtylpmGQYKQo63yVL2Bk1w8w3KMwKaubk29nj6wno0phzfGzkKmWLfSp3zFfpLwK238vBJGsoqcsGMpGQt7mGOGwSPFoLksPHt/PgdsnBsRnvir1jdDyErYmDvdn7XX5iaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSfhQlOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C22DC4CED6;
	Fri, 28 Feb 2025 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740728235;
	bh=cDtlqKcwOFTEnTBTdNOJ0/fAqkcZEXUrqyrdJoyMgog=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iSfhQlOjM1ViibQZykeckXFKezCn3C+wm+eXl1cknvmHFBbPNG9Bs+aYvMV9u3qrb
	 vnke4UX9T8jrLN6XBmaqBp4u/XuA1aqyqLxscKJmKhoGZXIfOOFN4QGRwhablh0pG0
	 v7vPyGB6mjDprkGyo9ZuoOlVLa0LNZ7NAjaMg59wjbUfTtYPCzMEr9iLEuTlzp+SDW
	 nP/6hL85P4zM6Aq3pBjjL32UWcBVT7yMYr+Ci+uvTyrDgo5m+qk+ZPU0fSt97ASgTV
	 PZr3HB8NRSDaersfdlw+9lkQ6vhd7teJXG3/n/yFGOKqCuzc/t28Rf+CvZieZUMLUB
	 7rpzdm0BYfbDw==
Message-ID: <4948a522-1302-462e-9256-1bb31d0ce7aa@kernel.org>
Date: Fri, 28 Feb 2025 15:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/27] f2fs: Add f2fs_get_read_data_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-22-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250218055203.591403-22-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/18 13:51, Matthew Wilcox (Oracle) wrote:
> Convert f2fs_get_read_data_page() into f2fs_get_read_data_folio() and
> add a compatibility wrapper.  Saves seven hidden calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/f2fs/data.c | 35 +++++++++++++++++------------------
>   fs/f2fs/f2fs.h | 14 ++++++++++++--
>   2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index fe7fa08b20c7..f0747c7f669d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1203,18 +1203,17 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
>   	return err;
>   }
>   
> -struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
> -				     blk_opf_t op_flags, bool for_write,
> -				     pgoff_t *next_pgofs)
> +struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
> +		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs)
>   {
>   	struct address_space *mapping = inode->i_mapping;
>   	struct dnode_of_data dn;
> -	struct page *page;
> +	struct folio *folio;
>   	int err;
>   
> -	page = f2fs_grab_cache_page(mapping, index, for_write);
> -	if (!page)
> -		return ERR_PTR(-ENOMEM);
> +	folio = f2fs_grab_cache_folio(mapping, index, for_write);
> +	if (IS_ERR(folio))
> +		return folio;
>   
>   	if (f2fs_lookup_read_extent_cache_block(inode, index,
>   						&dn.data_blkaddr)) {
> @@ -1249,9 +1248,9 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>   		goto put_err;
>   	}
>   got_it:
> -	if (PageUptodate(page)) {
> -		unlock_page(page);
> -		return page;
> +	if (folio_test_uptodate(folio)) {
> +		folio_unlock(folio);
> +		return folio;
>   	}
>   
>   	/*
> @@ -1262,21 +1261,21 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>   	 * f2fs_init_inode_metadata.
>   	 */
>   	if (dn.data_blkaddr == NEW_ADDR) {
> -		zero_user_segment(page, 0, PAGE_SIZE);
> -		if (!PageUptodate(page))
> -			SetPageUptodate(page);
> -		unlock_page(page);
> -		return page;
> +		folio_zero_segment(folio, 0, folio_size(folio));
> +		if (!folio_test_uptodate(folio))
> +			folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +		return folio;
>   	}
>   
> -	err = f2fs_submit_page_read(inode, page_folio(page), dn.data_blkaddr,
> +	err = f2fs_submit_page_read(inode, folio, dn.data_blkaddr,
>   						op_flags, for_write);
>   	if (err)
>   		goto put_err;
> -	return page;
> +	return folio;
>   
>   put_err:
> -	f2fs_put_page(page, 1);
> +	f2fs_folio_put(folio, true);
>   	return ERR_PTR(err);
>   }
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8f23bb082c6f..3e02df63499e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3895,8 +3895,8 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
>   int f2fs_reserve_new_block(struct dnode_of_data *dn);
>   int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index);
>   int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
> -struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
> -			blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
> +struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
> +		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
>   struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
>   							pgoff_t *next_pgofs);
>   struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
> @@ -3926,6 +3926,16 @@ int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
>   void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
>   extern const struct iomap_ops f2fs_iomap_ops;
>   
> +static inline struct page *f2fs_get_read_data_page(struct inode *inode,
> +		pgoff_t index, blk_opf_t op_flags, bool for_write,
> +		pgoff_t *next_pgofs)
> +{
> +	struct folio *folio = f2fs_get_read_data_folio(inode, index, op_flags,
> +			for_write, next_pgofs);
> +
	if (IS_ERR(folio))
		return ERR_CAST(folio));

> +	return &folio->page;
> +}
> +
>   /*
>    * gc.c
>    */


