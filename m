Return-Path: <linux-fsdevel+bounces-31136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E8992188
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18661C20A36
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4A18A6D9;
	Sun,  6 Oct 2024 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f4yW7p/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17943AB3;
	Sun,  6 Oct 2024 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728248672; cv=none; b=qOvltR/83L1OxScqYkhtkT/D5U2vRf8+xdGOSxXhaqcCEzxL8ZRy56ceH6aAGJRhoNO7fYBvz9wpIgRJlZWhmbbvgQc2G7ZeL8xxalY6h4kSrgXebAIhhwa9ApJRqf2NgCt6gPmRTqtRR8ztFy/KyAQHLhHrr9RwruQ6jRp1vlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728248672; c=relaxed/simple;
	bh=LFPOs77hp645yYvnX/4GodZEjj9N41KvHm1rmjuue3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO7g6dEl+HAbDK5hlBwo1Eu03cUfK/TV4TLVlKcAGQpGUh3Nx0yLmEqIiHD5kSrKU8jHcNjZUPClOYv5/OWeQTxo7k4z6NXnxLU5TTNCpgRRGr1+xzJw8/1TgQp9nl4oqTjALNhYqh6+x3T+DjQ5hMUGJSZb83mvC9rvcmpkD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f4yW7p/g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1zTw7SSQA0dXdZ3/2I7G1RP4313IWnciS4Sa7QIgu4=; b=f4yW7p/gtwnOn1c2TjIvq82DIG
	Sg579EWuuCKCaQJORLW6Oo6iXHKjJWea6QFodRQDV46uGOLPQJ8OFn5YFK7sFXGwpZL8SgOoO6bjT
	Q9e8jGSG/FFKSe3AAFqPG1WjsmWelff3t7YCA4ECZCXdUWN8Moml6o0iNI8RWwCzRHyheKqz6jiry
	JIinRY0qIUBmUizOtS4l44jceKDDM8dOOkLDAj9fFQSVOuBj3wFyaMUp22M2OwaKkaDVFOsvF5st9
	ZgAsNfedkEUwOm+5qMrE86Od/Q2iDVDZgjtbafWGj8KHn8u85d0mkpYcP6ILqYTObkNwmoa2iEBC9
	oQp8Bocg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxYQU-00000001Pn2-1fpp;
	Sun, 06 Oct 2024 21:04:26 +0000
Date: Sun, 6 Oct 2024 22:04:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ovl: stash upper real file in backing_file struct
Message-ID: <20241006210426.GG4017910@ZenIV>
References: <20241006082359.263755-1-amir73il@gmail.com>
 <20241006082359.263755-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006082359.263755-3-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 06, 2024 at 10:23:57AM +0200, Amir Goldstein wrote:
> +	/*
> +	 * Usually, if we operated on a stashed upperfile once, all following
> +	 * operations will operate on the stashed upperfile, but there is one
> +	 * exception - ovl_fsync(datasync = false) can populate the stashed
> +	 * upperfile to perform fsync on upper metadata inode.  In this case,
> +	 * following read/write operations will not use the stashed upperfile.
> +	 */
> +	if (upperfile && likely(ovl_is_real_file(upperfile, realpath))) {
> +		realfile = upperfile;
> +		goto checkflags;
>  	}
>  
> +	/*
> +	 * If realfile is lower and has been copied up since we'd opened it,
> +	 * open the real upper file and stash it in backing_file_private().
> +	 */
> +	if (unlikely(!ovl_is_real_file(realfile, realpath))) {
> +		struct file *old;
> +
> +		/* Either stashed realfile or upperfile must match realinode */
> +		if (WARN_ON_ONCE(upperfile))
> +			return -EIO;
> +
> +		upperfile = ovl_open_realfile(file, realpath);
> +		if (IS_ERR(upperfile))
> +			return PTR_ERR(upperfile);
> +
> +		old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
> +				      upperfile);
> +		if (old) {
> +			fput(upperfile);
> +			upperfile = old;
> +		}
> +
> +		/* Stashed upperfile that won the race must match realinode */
> +		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
> +			return -EIO;
> +
> +		realfile = upperfile;
> +	}
> +
> +checkflags:

Hmm...  That still feels awkward.  Question: can we reach that code with
	* non-NULL upperfile
	* false ovl_is_real_file(upperfile, realpath)
	* true ovl_is_real_file(realfile, realpath)
Is that really possible?

