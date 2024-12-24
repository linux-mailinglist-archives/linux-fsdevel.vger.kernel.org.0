Return-Path: <linux-fsdevel+bounces-38089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37699FB951
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 05:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B148D188452F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 04:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827491487D5;
	Tue, 24 Dec 2024 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BP/p1VWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7366DDC5;
	Tue, 24 Dec 2024 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735015459; cv=none; b=Eu4OZg5MaSJ/X2wRO8lejIhh3dEAN0OmWFZMTy3KRpEHS4FXjxEHR1/89M4F0s/Nfj3a4aM6zRYEfR73a+K3c4LvINz+iNeo80Eiq0+jeXG4+qF7p9aZw4R2hzaOHQtJ8SsIY+3SybJqVGkTBFYcatrsuMZN84YoZUPq0YQXDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735015459; c=relaxed/simple;
	bh=ZBIO/fbLNMs7HsX5yLcRM5qva7vrj7Rb96EFhq/st2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBMDbipDR9cozQBXflR/biYukiSLc1u8TO2T3lBy5L+zlIKy4qIFbB7C6uoTBJF/BHNuwLhZPeoTXi/VbCH3QUDzRb/m8JuAs9HHP9uab7PFEI41lqv5BzTomgFA+HWWmdqIpnBarAo9u9/U0qiNf3cEnD9jagcYxcS5vrQ92q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BP/p1VWu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/qXFdkzo2A5QPDuYdZZ5isI8Y5K6t0BFlIlqTTNwZVc=; b=BP/p1VWuKtI7JAkaXGv34KEb71
	kSvQ+xmeeFV1i4kbJ3fjsF80Nat7iGu7a2dC7FXWkV6O5hbu6pVPacamTsu4x8SFY3GhINX7pE5EY
	x31JQKjcv559Kc6Efn1KLeiDcFTlIcZClfA8293wAzJ1FABckOhsntjhGwxLS2wqkLYleQwoE/+Kd
	A8WIy2NGVSIdzt+QkQyx85O6HIBAq/GpDJ1ePbKbvfQ4x1elwQmfnDkeNfUl/GiamxFYs2RbxCJ8H
	DroJ2Ts9VxhvH1t+7fPkexsgjpsBNZJCQrB4UWrPWQhHBW0FtIzut3H4mtGpMlCCcAlpS3iZh++KA
	UgWZDk8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPwmE-0000000BWvu-3TZs;
	Tue, 24 Dec 2024 04:44:14 +0000
Date: Tue, 24 Dec 2024 04:44:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable leaving
 remnants
Message-ID: <20241224044414.GR1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
 <20241223200513.GO1977892@ZenIV>
 <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
 <20241223231218.GQ1977892@ZenIV>
 <41df6ecc304101b688f4b23040859d6b21ed15d8.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41df6ecc304101b688f4b23040859d6b21ed15d8.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 11:04:58PM -0500, James Bottomley wrote:

> +static int efivarfs_file_release(struct inode *inode, struct file *file)
> +{
> +	if (i_size_read(inode) == 0)
> +		simple_recursive_removal(file->f_path.dentry, NULL);
> +
> +	return 0;
> +}

What happens if you have

	fd = creat(name, 0700);
	fd2 = open(name, O_RDONLY);
	close(fd2);
	write(fd, "barf", 4);

or, better yet, if open()/close() pair happens in an unrelated thread
poking around?

I mean, having that logics in ->release() feels very awkward...

For that matter, what about
	fd = creat(name, 0700);
	fd2 = open(name, O_RDWR);
	close(fd);
	write(fd2, "barf", 4);

I'm not asking about the implementation; what behaviour do you want
to see in userland?

