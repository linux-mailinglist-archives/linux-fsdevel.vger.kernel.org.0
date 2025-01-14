Return-Path: <linux-fsdevel+bounces-39194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4882A11373
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C423188ADEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC520F091;
	Tue, 14 Jan 2025 21:53:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-02.prod.sxb1.secureserver.net (sxb1plsmtpa01-02.prod.sxb1.secureserver.net [188.121.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CE146590
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891603; cv=none; b=LAGmqHrbftpY89Gw+9ZUJ4ObBQEln86MS8vjKERtWBAlB9mvomUgdPxM0eyV/+xMgANM5bbF0LNyiEQN45K0qkVAKlQ/z1ws6tP/H5TneQyz5Q4N7hR0xtYxblYMfehfiFBPb/N/EugoEg9c/+LE4w/k4xlRqfovxEGqYBGZNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891603; c=relaxed/simple;
	bh=Fha+iD8K+UH3p6yrhgRQ+2KtWOOYZFYufPm8oVQzv8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbH8aWZZXbbX3ewvbWpARhqd+oQgbzJ4DKQf6k7gnelkm/vcwuS33cbVUI4DS961QRXHQq/LREXlpi1y4tvdB5MvM8Yoaeb8FEsuDL50l3TgYc/s0EeMmx2xEwxyraq4ILZoP+Gz2nWMxuLhTubzqxaYHC3KjkJLreYQycDH4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id Xo9JtGd3BwNr3Xo9JtVvbD; Tue, 14 Jan 2025 14:08:33 -0700
X-CMAE-Analysis: v=2.4 cv=L4LnQ/T8 c=1 sm=1 tr=0 ts=6786d251
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=JNY8Ar4d4c2H7_UTjzkA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <232624c9-2109-4c44-8d60-37b0f638f404@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:08:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] squashfs: Pass a folio to
 squashfs_readpage_fragment()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-2-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241216162701.57549-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJUJIkOjoebSM7UefT0ZS2tt8Lj3HQDhRTkAsG7HewRhYiLz/udViXEJXQ+6y/FFahzDkdZ6vnanu+ZaE2Kdt9LwbXC5v0+KH2WX3UbgbANjMbyS+hwi
 ARRNxHg3VdzL3nVnCRB+GYBdllsIr3NtUjOvN/LC12bHIhU7VrhF+8YCh1zaCp+a8Cq/i9UyxlGPlgM5nbKxxJuyBbMmp4k3A2KYi8oRgpWNwZhYC2Uewmvr
 bdxMFKn9+4ZOAwPwoXzJ7YO3LFM3a0KUYO3mzrvjDUOoHKNm5+c3cGfx9TKEn/FX3dLhl57D2k7Q56Pk6IJ61A==



On 12/16/24 16:26, Matthew Wilcox (Oracle) wrote:
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

