Return-Path: <linux-fsdevel+bounces-39218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B033A11643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAF188AEF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0341C6B4;
	Wed, 15 Jan 2025 00:54:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-05.prod.sxb1.secureserver.net (sxb1plsmtpa01-05.prod.sxb1.secureserver.net [188.121.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BE35949
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736902480; cv=none; b=GK2QVpYEYWJibd55A1QKF0Rng5X7KII8XtkSfbc1wNPrP51qsqKM2nCvK4BVrOofClnkRwXH2L4BvVDhrzWoENV8+GuB4O28LsarpXN4cpIJy74wf42RfoHmQfZTNHr3wLBBU2OKo0P+fgI76pwrE9HWcKJ7Xm85lAcP2R/O22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736902480; c=relaxed/simple;
	bh=o35pa9NZLWd81wYpH+LrK4WK9cy7JAEdvwWMflduqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljlaoo2K7rV/70NJZ1LZJ1d/7To6x2OvA/CG75gfX6FNQ9WuJ0woj/k5Dj5UXjFpT+K00XwP8Q3qIYnxcZvPABRRVNxnus8/c9lxZ0A+4VvavySGJtUF82aX3yq4noDwhTxaycHPKmj0LVpb3+0BGahzY70fd+I9xfbVthQFpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoCgtLAdw767nXoCgtB5Ct; Tue, 14 Jan 2025 14:12:02 -0700
X-CMAE-Analysis: v=2.4 cv=Qa6cvtbv c=1 sm=1 tr=0 ts=6786d322
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=JNY8Ar4d4c2H7_UTjzkA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <0b7c8157-d292-4462-888b-e63076a380d7@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:11:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] squashfs: Pass a folio to
 squashfs_readpage_fragment()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-2-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241220224634.723899-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGLf3QpBacvre59dOIDqjrly8iFtaiSYLx7cbsRwFLL1LakNxkZ5PpyTN3Jcrtg9nqvwAK0+joyR/YzCvkL39Op7/YZrL03y1uhI9vA/EkKZ/fkkxVX1
 FKQd9eB0UbXKsNAKcYkqx7hyS8vX2jsOiuRcZuyf4PrTasxEvM9JCaK+cgN6qQx9YL1JZmAtur0wPawD2TA9dxKR66CRxFm30p4LO2Ge4o16/++U/E0buzjW
 xUvcP0asEGaQrOCFgwcNCCGnKuT6fU3F7Y4WoKAziXs=



On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
> Remove an access to page->mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/file.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index bc6598c3a48f..6bd16e12493b 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -417,9 +417,9 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
>   }
>   
>   /* Read datablock stored packed inside a fragment (tail-end packed block) */
> -static int squashfs_readpage_fragment(struct page *page, int expected)
> +static int squashfs_readpage_fragment(struct folio *folio, int expected)
>   {
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>   	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
>   		squashfs_i(inode)->fragment_block,
>   		squashfs_i(inode)->fragment_size);
> @@ -430,7 +430,7 @@ static int squashfs_readpage_fragment(struct page *page, int expected)
>   			squashfs_i(inode)->fragment_block,
>   			squashfs_i(inode)->fragment_size);
>   	else
> -		squashfs_copy_cache(page, buffer, expected,
> +		squashfs_copy_cache(&folio->page, buffer, expected,
>   			squashfs_i(inode)->fragment_offset);
>   
>   	squashfs_cache_put(buffer);
> @@ -474,7 +474,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   		else
>   			res = squashfs_readpage_block(&folio->page, block, res, expected);
>   	} else
> -		res = squashfs_readpage_fragment(&folio->page, expected);
> +		res = squashfs_readpage_fragment(folio, expected);
>   
>   	if (!res)
>   		return 0;

