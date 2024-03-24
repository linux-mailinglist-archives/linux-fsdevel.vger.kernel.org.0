Return-Path: <linux-fsdevel+bounces-15171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BB6887BDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 07:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D546E2819F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6748714A99;
	Sun, 24 Mar 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KAS2qNon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28860EDF;
	Sun, 24 Mar 2024 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711261887; cv=none; b=DNuScgRL+CvpdR7TmSLRhehvFRELgRJh5ev503LF1XNHp4qMoMdiRxjCtb0sztgZQPihKQaOe6kdaf9vrnQvqoZp8R/gzyqnPEFhLjKNQ8uVz6DJ6v/cimn1+ThA7qzMbaxMIBMozjtvQK2CtvmuMebBMIuWwOj6K8TkNpSTHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711261887; c=relaxed/simple;
	bh=cLlni/sYFCp4yZq/4zZObQlCIwkr407x59M6hzBGL2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEJTAlgfvoL/S+kEp1jlbeE7INKC59G06cCF43yNINBLYHXm1fvLwIPgau3BfeGABv5cOoOYSqTtpwUnlzCEvv26BxXpw7BDa7ouKHtjsTEBAI46XFvt1cR/jtOg0qhP8tYXt5HjPHf31iZ+Hr+4wc1Xr9cviQR8QObkSyfUXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KAS2qNon; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1bRjI31Kru6q2HzYlM9QQ8aib/DK+l7dXD005qCESDc=; b=KAS2qNonaaHiNFt7HnXin8g1Mj
	3MR9tCC7z1JEUdg1aWaEgPxHQLhRwJpDn9zUsWB7BzIzv7tryw2lsy28FddJrNHazuUQcirhz2MYF
	t8mm2efxaaSnv4sWaR3p55MxRNrgukP1FETVXeKw7qyO0YITo1ZSWIzkj84erVGLrkMLMCpZ4DS6L
	nbrGJHuK3lJ3sU73G1zyzRlaYuKe7CaDna8ZVjHr77Z/1IMrUmGy5gIXi7AbAqYBnjdImgNJNVaq3
	uBw5lROORECsYvMJRBnw3elDVg8iPBRytmga+ZWbGztyFrJZguAdalMmH7qeAHpd9oXexDM/yDPJI
	riD6/wsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1roHO4-00FeGb-2J;
	Sun, 24 Mar 2024 06:31:20 +0000
Date: Sun, 24 Mar 2024 06:31:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	CIFS <linux-cifs@vger.kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: kernel crash in mknod
Message-ID: <20240324063120.GU538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324054636.GT538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Mar 24, 2024 at 05:46:36AM +0000, Al Viro wrote:
> On Sun, Mar 24, 2024 at 12:00:15AM -0500, Steve French wrote:
> > Anyone else seeing this kernel crash in do_mknodat (I see it with a
> > simple "mkfifo" on smb3 mount).  I started seeing this in 6.9-rc (did
> > not see it in 6.8).   I did not see it with the 3/12/23 mainline
> > (early in the 6.9-rc merge Window) but I do see it in the 3/22 build
> > so it looks like the regression was introduced by:
> 
> 	FWIW, successful ->mknod() is allowed to return 0 and unhash
> dentry, rather than bothering with lookups.  So commit in question
> is bogus - lack of error does *NOT* mean that you have struct inode
> existing, let alone attached to dentry.  That kind of behaviour
> used to be common for network filesystems more than just for ->mknod(),
> the theory being "if somebody wants to look at it, they can bloody
> well pay the cost of lookup after dcache miss".
> 
> Said that, the language in D/f/vfs.rst is vague as hell and is very easy
> to misread in direction of "you must instantiate".
> 
> Thankfully, there's no counterpart with mkdir - *there* it's not just
> possible, it's inevitable in some cases for e.g. nfs.
> 
> What the hell is that hook doing in non-S_IFREG cases, anyway?  Move it
> up and be done with it...

PS: moving the call site up to S_IFREG case deals with the immediate
problem (->create() *IS* required to make dentry uptodate), but the other
side of what had lead to that bug needs to be dealt with separately.

It needs to be documented clearly (for all object-creating methods) and
we need to decide what their behaviours should be.  Right now it's
	successful ->create() must make positive
	successful ->mkdir() may leave negative unhashed (and it might be forced to)
	successful ->tmpfile() must make positive
->mknod() and ->symlink() are uncertain.  VFS doesn't give a damn;
other users might.  FWIW, ecryptfs is fine with either behaviour.
nfsd and overlayfs might or might not break.  AF_UNIX bind()
probably *does* break on such ->mknod() behaviour and unless I'm
misreading the history it had been that way since way back.

From a quick look through ->mknod() instances it looks like
CIFS_MOUNT_UNX_EMUL case in cifs is the odd man out at the moment.

Could you check it AF_UNIX bind() with ->sun_path containing
a pathname that resolves to (inexistent) file on your filesystem
breaks with your setup?
setup?

