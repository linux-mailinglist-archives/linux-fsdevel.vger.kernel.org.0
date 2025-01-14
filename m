Return-Path: <linux-fsdevel+bounces-39184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B8A112E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D288C3A23B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83DD2080DF;
	Tue, 14 Jan 2025 21:20:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-11.prod.sxb1.secureserver.net (sxb1plsmtpa01-11.prod.sxb1.secureserver.net [188.121.53.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15011ADC72
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889600; cv=none; b=awOdg6fCvtESRLbIkwHXuagkuuRgsoB4yS/3Kk7hRqyIzEnh9HToKd66f/Iq98vU2vjReFaMDoafTAqp2yd+y/lkOw9NqUvlsh4fSfsmges+l9M+TaFV9cMJk8ZrKsofc6kdnK0j/L5Jrp9VoA/13aGisRrAXUmMl21lmcTyRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889600; c=relaxed/simple;
	bh=neAaSvJvhh4YzHwuC+sg0RBE6/i5vfsFlk2Xx3W4Cvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKJsKNRNURX4y1kcvH5J96KuWFtGN4IVDLEXHPmjgzsau32R3oxn2KLsUIOjzlOd9zD3FgDHX+LKfIqs7smKhXYzzl20ZAt13tTprUd0HxLzhVaPqs4rrUxczkX0zlZf4lBaETGglsQzAHX9xYdpRPnhB/QxJWYfCidbyVK4JFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoCxtHqWoyuW9XoCxtO3SX; Tue, 14 Jan 2025 14:12:19 -0700
X-CMAE-Analysis: v=2.4 cv=JoYLrN4C c=1 sm=1 tr=0 ts=6786d333
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=LwKSgBnj7Ks5V7603F0A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <84318429-1677-4a2b-9cd7-5abbb15f2acd@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:11:53 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] squashfs: Convert squashfs_readpage_block() to
 take a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-3-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241220224634.723899-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPblwQbBMGzT+lDtLRn8PCM3CzkMbHRCSX3Ui7a76/4Vo9Ejbf7SDCNTWmuvwg68u0ooYbQh76Cnir/z2Fpz5FOGCNG1gWtrwN9TuLL62PQBHfWV2J62
 Hrg3xsdLOUMftp/T80e5KccbvG1smbd0PGBvqchue6meFXnXAPI986rjyHo6VO6il1ROGv2x+XUkvcFf2qckO6iKdRDbRWvVVdT1TIDy3o74qXkYVdgC9myk
 awap1JOsqUP7Q+KFpFuC+6EQJIBzkxiN71avVgJ+ZwE=



On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
> Remove a few accesses to page->mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/file.c        |  2 +-
>   fs/squashfs/file_cache.c  |  6 +++---
>   fs/squashfs/file_direct.c | 11 +++++------
>   fs/squashfs/squashfs.h    |  2 +-
>   4 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 6bd16e12493b..5b81e26b1226 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -472,7 +472,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   		if (res == 0)
>   			res = squashfs_readpage_sparse(&folio->page, expected);
>   		else
> -			res = squashfs_readpage_block(&folio->page, block, res, expected);
> +			res = squashfs_readpage_block(folio, block, res, expected);
>   	} else
>   		res = squashfs_readpage_fragment(folio, expected);
>   
> diff --git a/fs/squashfs/file_cache.c b/fs/squashfs/file_cache.c
> index 54c17b7c85fd..0360d22a77d4 100644
> --- a/fs/squashfs/file_cache.c
> +++ b/fs/squashfs/file_cache.c
> @@ -18,9 +18,9 @@
>   #include "squashfs.h"
>   
>   /* Read separately compressed datablock and memcopy into page cache */
> -int squashfs_readpage_block(struct page *page, u64 block, int bsize, int expected)
> +int squashfs_readpage_block(struct folio *folio, u64 block, int bsize, int expected)
>   {
> -	struct inode *i = page->mapping->host;
> +	struct inode *i = folio->mapping->host;
>   	struct squashfs_cache_entry *buffer = squashfs_get_datablock(i->i_sb,
>   		block, bsize);
>   	int res = buffer->error;
> @@ -29,7 +29,7 @@ int squashfs_readpage_block(struct page *page, u64 block, int bsize, int expecte
>   		ERROR("Unable to read page, block %llx, size %x\n", block,
>   			bsize);
>   	else
> -		squashfs_copy_cache(page, buffer, expected, 0);
> +		squashfs_copy_cache(&folio->page, buffer, expected, 0);
>   
>   	squashfs_cache_put(buffer);
>   	return res;
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index d19d4db74af8..2c3e809d6891 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -19,12 +19,11 @@
>   #include "page_actor.h"
>   
>   /* Read separately compressed datablock directly into page cache */
> -int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
> -	int expected)
> -
> +int squashfs_readpage_block(struct folio *folio, u64 block, int bsize,
> +		int expected)
>   {
> -	struct folio *folio = page_folio(target_page);
> -	struct inode *inode = target_page->mapping->host;
> +	struct page *target_page = &folio->page;
> +	struct inode *inode = folio->mapping->host;
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   	loff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
>   	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> @@ -48,7 +47,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	/* Try to grab all the pages covered by the Squashfs block */
>   	for (i = 0, index = start_index; index <= end_index; index++) {
>   		page[i] = (index == folio->index) ? target_page :
> -			grab_cache_page_nowait(target_page->mapping, index);
> +			grab_cache_page_nowait(folio->mapping, index);
>   
>   		if (page[i] == NULL)
>   			continue;
> diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
> index 5a756e6790b5..0f5373479516 100644
> --- a/fs/squashfs/squashfs.h
> +++ b/fs/squashfs/squashfs.h
> @@ -72,7 +72,7 @@ void squashfs_copy_cache(struct page *, struct squashfs_cache_entry *, int,
>   				int);
>   
>   /* file_xxx.c */
> -extern int squashfs_readpage_block(struct page *, u64, int, int);
> +int squashfs_readpage_block(struct folio *, u64 block, int bsize, int expected);
>   
>   /* id.c */
>   extern int squashfs_get_id(struct super_block *, unsigned int, unsigned int *);

