Return-Path: <linux-fsdevel+bounces-54150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB2AFB9BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB473BF418
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03029552B;
	Mon,  7 Jul 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i8jVQ4YV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D4220F54;
	Mon,  7 Jul 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908661; cv=none; b=aqQ03pm8wbD6IXiBVmux/bg/WfnEstoGxyBJK5zHXPzrqEghvHxX09e5jjhI064rDURqrm9UUymxsE2zyQHNljTJ4BNHjy20Utm6qracTxR9d5/Xeu90ds/nO5vfiqaOxvaKmdXvUkMre0DQJ7wyPvCD+CHBJvGQmeoRuz9tU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908661; c=relaxed/simple;
	bh=UssDAlpKz8D6Ui7sh7/HNVQYyf4KRt93SHg7aDoETLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzxEy9bCQc87XXE+KCmf4XZahcuYjfngWaB3TONAZ2kB6Ea+k3K8ODGq/+sYl3ucKVo4clPAF1l8Nlc8N5pvYAZ9HjADdkrsmmbuJhLS7/9aRiY3c1oojOi6+gaS5Rn8t6mi93OJp8aw6JYL/NB3yWoJ7T2L02NR8tNOYo/t41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=i8jVQ4YV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KlMSQW5CMg3CMcgvZxr8OnxCx9OPgSqTzOTGBORN/Do=; b=i8jVQ4YVsbaQsvVtjFiunwTVjl
	EPJYqjOb3e9RPn/UJBKWrwzf15hhHxpHjBTkebB/VclPyBa8d3ZBsZ5z+nbWbV2ysb+9SKmL6pEW+
	9eT6RGCOSkKMITkP7CK/O5db+nrvzuK6BnwxmecNWdN+r2u2CuywAWQIkERlKVwov5grtUdnAxlLe
	b+TxpwCwAgtV04bAmz+iA5a+pvTCAJCo3w3F14j58VDCH4CV7O1tFGXfukZrQQDtczTPzD87yDW3S
	Od2zxiPJCLCjvkbU8yxzFrX+Xuq+RNZ30ipWLu8zdYNyfSnaCX5qGpAN6U/Hp2iIrEDG2R52Q/MaT
	X2YSfrFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYpTD-00000002MeO-0qFw;
	Mon, 07 Jul 2025 17:17:35 +0000
Date: Mon, 7 Jul 2025 18:17:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>,
	jack@suse.cz, kees@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] secretmem: use SB_I_NOEXEC
Message-ID: <20250707171735.GE1880847@ZenIV>
References: <20250707-tusche-umlaufen-6e96566552d6@brauner>
 <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 02:10:36PM +0200, Christian Brauner wrote:

>  static int secretmem_init_fs_context(struct fs_context *fc)
>  {
> -	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
> +	struct pseudo_fs_context *ctx;
> +
> +	ctx = init_pseudo(fc, SECRETMEM_MAGIC);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;
> +	return 0;
>  }

What's the point of doing that *after* init_pseudo()?  IOW, why not simply

static int secretmem_init_fs_context(struct fs_context *fc)
{
	fc->s_iflags |= SB_I_NOEXEC;
	fc->s_iflags |= SB_I_NODEV;
	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
}

seeing that init_pseudo() won't undo those?

