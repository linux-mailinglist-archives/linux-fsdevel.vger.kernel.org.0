Return-Path: <linux-fsdevel+bounces-42412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE98A422DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E30F167C9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C1C15350B;
	Mon, 24 Feb 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ftlTK7Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BE1519B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406489; cv=none; b=kH+yWrpbvmLlsEWafCnTFwQRdHZYt8R1Mx7h8PfvxWIhcahdbRttJJs7BXm+qkK1MgRx8kgaaOzUtSZ5N3DaaRg08Nm/Wvjp9WsEOpSPzgDa4cSCklOB4vYeP9Wget5LorxkMtQNY0Uc2ztT+0TRzraP+qrcKQXHMoBeexTljE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406489; c=relaxed/simple;
	bh=3JhP7BB3nypZVkURIeOoX2Pp0nUBLgGSUvan1MN+cxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNVRE1SJFkauxSIiB98Kx+B0sXLQ86nuZWkUoeysF8xbkDwPbmBM8mB4XeV2jdG3akNQNdBD+awGtxvjp/2/9AVUWem525exoT0oxfvVp6Q48qTWAyyvLYq7GJXzgt1/TEnE3epz3cD3ldfQz4K8lwJfpSwZJMM+uVWZar0ZI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ftlTK7Fo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VUkHUqtZBxfAfUGKyXLDWDKHo3ll9G/6glAvmQT2iRY=; b=ftlTK7FoGMtHNjJOLtobg/BoR1
	1qsASk3wvtR3J2DyYfX//twhxuHRIo8nSsvSlp5nNZeuGw6y8CCWEtR7vIHGSkzL36GWnwbhRympM
	/HCPreIxD4k8GoNlokRekbBxG1uBfpd9WgGHW79yDNRhEyB9PJo2c35gUX0BW7Gm+566p7ND8Favm
	nVfet4o5Tc5c8N+WoYrhr1zmsX+m7lfkEAVEiOffgj1z6yWjV6BaOy/jYi7/tfKRHgArCLRjlJJC+
	mRqgBp+GsEvwihUviO1elSYvJTKL2mxOsJFMxmXDRvTNZ4XEM52UgVrbV9DHtyZWtyM6Bjz/KWPH5
	++4T6p1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZEK-000000072oe-2iwv;
	Mon, 24 Feb 2025 14:14:44 +0000
Date: Mon, 24 Feb 2025 14:14:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] dentry->d_flags locking
Message-ID: <20250224141444.GX1977892@ZenIV>
References: <20250224010624.GT1977892@ZenIV>
 <20250224013844.GU1977892@ZenIV>
 <20250224-attribut-singen-e29c9a49ee56@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-attribut-singen-e29c9a49ee56@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 11:35:47AM +0100, Christian Brauner wrote:

> I think it would be worthwhile to mark dentries of such filesystems as
> always unhashed and then add an assert into fs/dcache.c whenever such a
> dentry should suddenly become hashed.
> 
> That would not just make it very easy to see for the reviewer that the
> dentries of this filesystem are always unhashed it would also make it
> possible to spot bugs.

Not sure that's useful, really...  Details are tied into the tree-in-dcache
rework, and I'll need to finish resurrecting that; should post in a week
or so.

For this series, see viro/vfs.git#work.dcache - it's a WIP at the moment,
and it's going to get reordered (if nothing else, d_alloc_parallel()
side needs an audit of tree-walkers to prove that it won't get confused
by seeing DCACHE_PAR_LOOKUP on the stuff that hasn't yet reached in-lookup
hash chains, and that might add prereqs that would need to go early in
queue), but that at least fleshes out what I described upthread.

I'll post individual patches for review in a few hours.

