Return-Path: <linux-fsdevel+bounces-18031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE18B4E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 00:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D43B1C208C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72F10A2E;
	Sun, 28 Apr 2024 22:01:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-16.prod.sxb1.secureserver.net (sxb1plsmtpa01-16.prod.sxb1.secureserver.net [188.121.53.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F601BF2F
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341716; cv=none; b=IrzVq7ohnFVXTrBf5bQtoa5ennhkGuZIJbP5p+7izFOU8vNuPhkASLSiW9+x3v0zFDqcs4EblT8UmzyyLSuON0GG3qax+FrXfYweuEZseFuVqEsN66HccRnUlZhE5kWz4iUjlwP2BzOtwi6DRWoisZ7/ib6cDJ6yMki2aBY3lV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341716; c=relaxed/simple;
	bh=RFtje+rkmJJWE6uTR4No/mTJ53J23Hs5xUMKjFJIzcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=m1deXAvILz1JzbtBW3FmcGl2lGR4WDv9aH7R6B4avOKEQWdqbX+qov6HGbcowWues0E7ck3ytoVxviwl+Pq+QyAbErJG8yLX7NdxSIp/q7YU7HJ3w4VXCU5bvg0SyW7CMTjuanIljdeHxGpNKQe4oMu8Pycuw7HrM7yKzZpofmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 1CIHshlkTnpx01CIJsNcnH; Sun, 28 Apr 2024 14:42:49 -0700
X-CMAE-Analysis: v=2.4 cv=P7HxhTAu c=1 sm=1 tr=0 ts=662ec2da
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=FXvPX3liAAAA:8 a=JfrnYn6hAAAA:8 a=C6Q84UaGWwNiS6ldWDQA:9
 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <0b5808e9-4dd6-4f85-866d-357bce39d85f@squashfs.org.uk>
Date: Sun, 28 Apr 2024 22:42:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/30] squashfs: Remove calls to set the folio error flag
Content-Language: en-GB
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-24-willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20240420025029.2166544-24-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfN+IAVAZT5vdIfz3ChjvCh7CeMBlJYpKBEI7J9qrZjinbkeNUvko4uJilNgrUHPHFXsbXblY7iCuIXEQxyuE5RlImfNX+rXTG8J3H6YgT0/ihTdDjaYy
 1Y16gCDAHUE1/wZBIlESGYPvzdxSoi3Yw3bkZWM9z8Nqjsba6HOx081BA6vTlr43evSx9cHaW/GDc0suYX9miu65VGMJwgOB+FUIwHnJ/6AmgfWxlVpIarts
 B0o7oVEtB3PMDKm4iPoybK6SIjMkS1ja085Th/SkxEU=

On 20/04/2024 03:50, Matthew Wilcox (Oracle) wrote:
> Nobody checks the error flag on squashfs folios, so stop setting it.
> 
> Cc: Phillip Lougher <phillip@squashfs.org.uk>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Tested-by: Phillip Lougher <phillip@squashfs.org.uk>
Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

You've mentioned a couple of times you prefer the patches in
the series to go through the fs maintainers.  Andrew Morton is
currently handling submission of Squashfs patches for me, and
I'm happy with either Andrew or you merging it.

CC'ing Andrew.

Regards

Phillip

> ---
>   fs/squashfs/file.c        | 6 +-----
>   fs/squashfs/file_direct.c | 3 +--
>   2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e8df6430444b..a8c1e7f9a609 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -375,8 +375,6 @@ void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer,
>   	flush_dcache_page(page);
>   	if (copied == avail)
>   		SetPageUptodate(page);
> -	else
> -		SetPageError(page);
>   }
>   
>   /* Copy data into page cache  */
> @@ -471,7 +469,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   
>   		res = read_blocklist(inode, index, &block);
>   		if (res < 0)
> -			goto error_out;
> +			goto out;
>   
>   		if (res == 0)
>   			res = squashfs_readpage_sparse(page, expected);
> @@ -483,8 +481,6 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   	if (!res)
>   		return 0;
>   
> -error_out:
> -	SetPageError(page);
>   out:
>   	pageaddr = kmap_atomic(page);
>   	memset(pageaddr, 0, PAGE_SIZE);
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index 763a3f7a75f6..2a689ce71de9 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -106,14 +106,13 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	return 0;
>   
>   mark_errored:
> -	/* Decompression failed, mark pages as errored.  Target_page is
> +	/* Decompression failed.  Target_page is
>   	 * dealt with by the caller
>   	 */
>   	for (i = 0; i < pages; i++) {
>   		if (page[i] == NULL || page[i] == target_page)
>   			continue;
>   		flush_dcache_page(page[i]);
> -		SetPageError(page[i]);
>   		unlock_page(page[i]);
>   		put_page(page[i]);
>   	}


