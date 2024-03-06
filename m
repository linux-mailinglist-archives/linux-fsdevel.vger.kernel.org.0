Return-Path: <linux-fsdevel+bounces-13763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F9873A06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F5028BABF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528451350EF;
	Wed,  6 Mar 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxJ6vkQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145C28EC;
	Wed,  6 Mar 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737266; cv=none; b=qAuepCVH//Whx1Bz/It5X8ydmHMVjVKrsCYnEA5ptRd0lN5V0xJzgDQEaFSo91rj1vqYip/Kmwt45Tp6XxcrmJz03MvU6TfI0NrLCF3H5GioNAFQnav0XlGYmOdDkM4CD4CswF4AIrjMIxr3YRK5vltb42mXuAGfwsDnparXHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737266; c=relaxed/simple;
	bh=KYmer60mc8PcsnZd2TV+zzjoRykr0eBCuDN/h8vjbwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCSxLGHG/K4ZKea/GDgPHY0oJTY5RMvaSnrEvrT8jL7HG975LgU7mxlwAhhm87PQCcKuCn5n+Jsavnfb/PRwUonUZxx7fPjqWWGaDEdkU/5fYwT9CisJcVp4U3qGKiqw4P8I8Q+MPZ/w1YnV5rM0Jt2RTUKdnL3fwj4gRtKy0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KxJ6vkQd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ll+1Du/bb2u+urPB/fc9XN9sLdVfL/sTZ5PzpjIu2ds=; b=KxJ6vkQdfAHSJmbCDtoi/lGO1Y
	Ib/OUrM9LDmlM7/MldSzsq2idBKgrgV5yB+8p5yWpO3h8S9pUC/ndAbwOK/tyYXsb8fYz3eKdyvTj
	SlVEOcZzTSGTLONhy5cIk6xui/bdcLZe3J8mOEdSVQ2Z8PtlH9bIS3hX3U7SA6xCNC2cvvbEofgcz
	9woGMhw6c7FuVXuYI9DmYkSfOgkSRm8c7IsF/70Wzp016glqAfcDasFPivrftZjFq+QrsZdzv7JRX
	VvpiIn5/Rl8Z2OdZ6N4RmurFzMPBsqo57YhBkSdoeLn9iwixn/la+yJU0GooxiaFDGxd1wZfj9CTU
	5FNh4biQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhslP-000000071Iu-4BNe;
	Wed, 06 Mar 2024 15:01:00 +0000
Date: Wed, 6 Mar 2024 15:00:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hfsplus: remove dev_err message "xattr exists yet"
Message-ID: <ZeiFK0gfGrIcTx78@casper.infradead.org>
References: <20240306124054.1785697-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306124054.1785697-1-colin.i.king@gmail.com>

On Wed, Mar 06, 2024 at 12:40:54PM +0000, Colin Ian King wrote:
> While exercising hfsplus with stress-ng with xattr tests the kernel
> log was spammed with many "xattr exists yet" messages. The error
> EOPNOTSUPP is returned, so the need to emit these error messages is
> not necessary; removing them reduces kernel error spamming.

Isn't that the wrong errno though?  EOPNOTSUPP isn't listed as an errno
in the fsetxattr manpage.  ENOTSUP should be used for "xattrs are not
supported".  But this condition looks like EEXIST to me.

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/hfsplus/xattr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9c9ff6b8c6f7..57101524fff4 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -288,7 +288,6 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
>  
>  	if (!strcmp_xattr_finder_info(name)) {
>  		if (flags & XATTR_CREATE) {
> -			pr_err("xattr exists yet\n");
>  			err = -EOPNOTSUPP;
>  			goto end_setxattr;
>  		}
> @@ -335,7 +334,6 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
>  
>  	if (hfsplus_attr_exists(inode, name)) {
>  		if (flags & XATTR_CREATE) {
> -			pr_err("xattr exists yet\n");
>  			err = -EOPNOTSUPP;
>  			goto end_setxattr;
>  		}
> -- 
> 2.39.2
> 
> 

