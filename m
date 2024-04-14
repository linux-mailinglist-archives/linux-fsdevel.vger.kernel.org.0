Return-Path: <linux-fsdevel+bounces-16891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338318A4585
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 22:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6439C1C20EA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCA136E2E;
	Sun, 14 Apr 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="29HYk93m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BF41C68;
	Sun, 14 Apr 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713128338; cv=none; b=gNxJfFB1B4x1Ul+08ALAD18L6r9YUruBMrl73ZFwtgcfrr/AVgN95pyqH7C3KUOXcmrl7dMS4v3nTVZdzfyzuM5cvvdvnB3oeoAOIJMGsK3x5czMo6E2zkYJ2yuYQEJhmceAaFq9yqPCtn0sBdZoBCgKBcstBH6ozz8C0AOQoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713128338; c=relaxed/simple;
	bh=AiuoHRyfN8BIP74DeS4SwjEEoZsmO1qeZ+hZGF4ctHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1F2wYEarLcdRSbXJzwcE0/QIfzkAp9/jL64ilQZyKU5zLJfvbgJGIdXfCu1DLdEyWx0TKqgeAuU9536WKnQeCR40iqhZwShPJUyiZo0gACqA8qTjaYZkb+N57YtECfSIkt+NG/7YZlNXeBI/dblr0bbXeJDdDKX4CnDcOIW6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=29HYk93m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bbouK2i2QXvMiu/IXpjaD7CYpfqtLXdPv9/Xv/iKvVg=; b=29HYk93mBv9SUvTswYCrQyrCKd
	t6Lbb5P7anOATU4YvCzS+EiY1Z7EwrwprK5OH3QwOdhhxbpP9EbZgcbsHJF9sQfbxSFrrW5WYHlAI
	pN1reMoXbl6ThJM5poYbINbmP4+D9Bj2wqLa6OLFRMRrsUBZnfele5qVhlhVcZgtBk8RWaW26o/H/
	2SXhwsHFGl0qBAN6qqfR2fR9iW1FAIRun5L1PvwRi1buJw3Q03ZfdirjUa/uVrqFFCAfyi1yAVVMh
	XBSfvItoHm1Wf2Al5RpikTrYJKI4A6e1463HdYjZLWF6rkBJaVwcfUiEL/97Ui6UWxNalnldA5cqB
	VZzm4jzw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rw6wC-00000006OKI-00w4;
	Sun, 14 Apr 2024 20:58:56 +0000
Date: Sun, 14 Apr 2024 13:58:55 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <ZhxDj3vQFLy62Yow@bombadil.infradead.org>
References: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sun, Apr 14, 2024 at 10:05:05PM +0300, Alexey Dobriyan wrote:
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3616,4 +3616,12 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> +/*
> + * Use this if data from userspace end up as directory/filename on
> + * some virtual filesystem.
> + */
> +static inline bool string_is_vfs_ready(const char *s)
> +{
> +	return strcmp(s, ".") != 0 && strcmp(s, "..") != 0 && !strchr(s, '/');
> +}
>  #endif /* _LINUX_FS_H */
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2893,6 +2893,11 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	audit_log_kern_module(mod->name);
>  
> +	if (!string_is_vfs_ready(mod->name)) {
> +		err = -EINVAL;
> +		goto free_module;
> +	}
> +

Sensible change however to put string_is_vfs_ready() in include/linux/fs.h 
is a stretch if there really are no other users.

  Luis

