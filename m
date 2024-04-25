Return-Path: <linux-fsdevel+bounces-17832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16218B29CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871F51F21A69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029115573A;
	Thu, 25 Apr 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e7FJMtWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9F153BD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076758; cv=none; b=byxkWX6fCt0JC5KYztyqCVRR+c7i0beruHioPzUPB8lfWV4ihS3Km8PSzp2svWxl1MYX97hfSKAGqyaJFBgq4LO+W8ksQQyFAkHFI1MQp3n5t38iZkxGvEW4rEVqG8DIgVnVFW7AY4B+PqQABTfkgkxUJ6J2h3Y7dWjIoOgn8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076758; c=relaxed/simple;
	bh=Y8qHNrV7cXcb4+6m8eAsD639d+gNTwbr10Jd9WtSyiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDetCDNMADnonkcmNBkgxWzFrI4wmd4gVIvW5rsc2eVoYvO+fFDLrTAYII5kGTbUobZXakjMZga5L9dJx6bOwDnmJTs0qiZIBcAGVwPQ0KO4ttfDfOwCZiE4iEE/XhsCqtH+Dbr20ZdDbNbB/eTpEjL3jn3RIwiqXix1W0CqqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e7FJMtWM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eU4ScZ1Fc7yDTQrlp07KSRzAiZJJFKlSUXrLyEO6OLg=; b=e7FJMtWMoloHjsssDZKushJDXo
	crb9Xg4yTY5+8ztWBnuPVuUfprMKD4/q/iGNQDJDfjqpDLwpiIK8M2xCbjWRVudhSxXGkwu5gxCLs
	KJGGpZ5lUlk8IkUSnrCPQ2z1xLz6NUkxyMgxYOte1sd3+2P6rm3qNaIEPn/gUuTeT0Q7ymN8181vx
	L8T3+dIy3yqNiUPWh3WafIfLJnrolJtjTHznzBAaY3TiLvfpg8NvP/eMF3bvR0m5+1IwHInZTNq7j
	yEN/FtHqjf/HjSf3c7AGYQIN/6EI/EF1yCM+yO7Ow+RGM6aEhAvF76IF2hUenEOgVQfxdGAsxwY3O
	qghLSF1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05fC-004LHq-0a;
	Thu, 25 Apr 2024 20:25:50 +0000
Date: Thu, 25 Apr 2024 21:25:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Dawid Osuchowski <linux@osuchow.ski>, linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Subject: Re: [PATCH] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240425202550.GL2118490@ZenIV>
References: <20240424233859.7640-1-linux@osuchow.ski>
 <20240425-wohltat-galant-16b3360118d0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-wohltat-galant-16b3360118d0@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 25, 2024 at 11:57:12AM +0200, Christian Brauner wrote:
> On Thu, Apr 25, 2024 at 01:38:59AM +0200, Dawid Osuchowski wrote:
> > Creates an anon_inode_getfile_fmode() function that works similarly to
> > anon_inode_getfile() with the addition of being able to set the fmode
> > member.
> 
> And for what use-case exactly?

There are several places where we might want that -
arch/powerpc/platforms/pseries/papr-vpd.c:488:  file = anon_inode_getfile("[papr-vpd]", &papr_vpd_handle_ops,
fs/cachefiles/ondemand.c:233:   file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
fs/eventfd.c:412:       file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
in addition to vfio example Dawid mentions, as well as a couple of
borderline cases in
virt/kvm/kvm_main.c:4404:       file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
virt/kvm/kvm_main.c:5092:       file = anon_inode_getfile("kvm-vm-stats",

So something of that sort is probably a good idea.  Said that,
what the hell is __anon_inode_getfile_fmode() for?  It's identical
to exported variant, AFAICS.  And then there's this:

	if (IS_ERR(file))
		goto err;

	file->f_mode |= f_mode;

	return file;

err:
	return file;

a really odd way to spell

	if (!IS_ERR(file))
		file->f_mode |= f_mode;
	return file;

