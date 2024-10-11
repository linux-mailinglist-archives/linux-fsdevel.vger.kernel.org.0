Return-Path: <linux-fsdevel+bounces-31787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF899AEA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 00:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03D1B23F73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7061D2718;
	Fri, 11 Oct 2024 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dJJilou0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE11D1E8F;
	Fri, 11 Oct 2024 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685683; cv=none; b=totpt67XqoKOI7bythP9702yCgD26WIIPUbCvb7pRiwNd7AlSqKg1m+kLmGPKCHQBq4XUqGjuCoCTIU3vNwOBHPe32KmcOtqsvZWg8DmKZgq09tlBf/ujKeY1WhlBzBrLZwSuOoMg+596/atpNfDk8UAzPpQC+bu6vDELZje8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685683; c=relaxed/simple;
	bh=BHk9HwflKq8JhGuVP+CbTU1z+Bqrjofxzqy1aka9I2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVbRxtxYQWvyml6MtZf4NWfG0IwiJZksjhN9mw6y/ckGJLBdUcjwzgLalMqioZJUjvXQy8h+1pVzRWzZDHbWdXrAdOkJm1YEaenwAEJCrEJ/35QWEDKBEhUHbTvmVgsTrAlFJoGDlKS7r+JBnwc4dd+gKZiUY9UvfNR31fSBgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dJJilou0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6npxAbcpKyHFhtH5MiSoLTyN4tZ6wHTcIbmDFuyBZoU=; b=dJJilou07HnEZVM6X7ynpv1ggj
	Z+JPPdhAGI3skAvZVqWGHr7LRWjQL5nBhmBMRG327BQS76CVEv0cQpHunkkH+Vo92X9O18TeJdGXa
	Dv31xp5BgJDryJsLT6DCBGx+c01Ijtckz14ZeUxgTM2UUPgIQmwHRipclzi8T5n35viBdbwsFRQBR
	Yn6Z/js2Z8ItNoO5zHHzcY4KcXRf4tXXmPVMWDAYUUFJJQciEmG9E/uRldQnVTHgsd/zUQd/g+S/R
	SOR+XgUCwo3sbOD+NQQMqikAZly4zi7g1Yd586wEtiueP3vuxc+stlYLhPmm1xk4dqBAa9McvbIsk
	VsidhgpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szO71-00000002raJ-3CQU;
	Fri, 11 Oct 2024 22:27:55 +0000
Date: Fri, 11 Oct 2024 23:27:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] ovl: specify layers via file descriptors
Message-ID: <20241011222755.GF4017910@ZenIV>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
 <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 11, 2024 at 11:45:51PM +0200, Christian Brauner wrote:

> +static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
> +			   enum ovl_opt layer)
> +{
> +	struct path path __free(path_put) = {};
> +	char *buf __free(kfree) = NULL;

Move down to the scope where it's used.  And just initialize
with kmalloc().

> +	char *layer_name;
> +	int err = 0;
> +
> +	if (param->type == fs_value_is_file) {
> +		buf = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
> +		if (!buf)
> +			return -ENOMEM;

