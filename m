Return-Path: <linux-fsdevel+bounces-57623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08111B23F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6977580DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54512BE05B;
	Wed, 13 Aug 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YQCCYbuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E2A2BD5BC;
	Wed, 13 Aug 2025 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058387; cv=none; b=YPTIU7AhZ5Pry3UeJBw1uAuTEfykKI5iaTKGkjnexyuTsQ5L4ZaK240mx/P7+MLzSbxTgsM9KnzCcqcWZiIrH3DD1Bb0IPD1ktgW5sXu4jTAY5Zp7HK+872biBStNq8LpyhDvpSqye1KSXMM3en0aOlFqG8i9e6xlD+AvSjYUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058387; c=relaxed/simple;
	bh=kWQO5Lqd1o2S4ATt5DSr1gP6e3PtNSFHfydfTqIjAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1KH071+PQpxNtgiOVnDXzus0zBIg0BF/17EVyUrnqt7HxtiuZIhePhrQdZliJE0XBA2R51WZ3umyAFterCRPFSuWp2yc08ZxdK5Ueu1Jj4QSkmWcFdxVA2xbxp8jjfdZEwe1QXiPMY8lmn7dwdv9Gd8gNtV6dG+kt8dKP6izW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YQCCYbuD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v3ScuYOGjprT7nms8nY1RfA6FgaAgRQtIpIoBDc3X7s=; b=YQCCYbuDIe3F8hUeNu3CpENq+5
	RC1sPWEp1eHhuGNVpes/WeuBfu9TEWvBP2vKabD+SvfYK9grq2iReRT0YxD/kdCyG2sJWTEBm90+K
	fdNc0bejRg954VZCjPQL0L2+YbIZrUIiqHC8FBG20nsggjdmoJVBQN2f3zILcX64xGRfCwnI+dHk0
	K07LR9uYgSLDE09+VMBD6j2qgQdxDYSyHJGYnq8Tj3qX2gqTBaZe+xKf8BakmsxcUG7BYql+yi6ej
	en+SZQV5sl25uPEpugYyGBMgZU059eb9vWp1Ni4bMgNbhTfsERbeB8nb34LVAUMB31GzmzjegSZKa
	7kgG+uUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2r7-00000005QRq-2rI6;
	Wed, 13 Aug 2025 04:12:53 +0000
Date: Wed, 13 Aug 2025 05:12:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] VFS: introduce dentry_lookup() and friends
Message-ID: <20250813041253.GY222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-3-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-3-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:05PM +1000, NeilBrown wrote:
> This patch is the first step in introducing a new API for locked
> operation on names in directories.  It supports operations that create or
> remove names.  Rename operations will also be part of this new API but
> require different specific interfaces.
> 
> The plan is to lock just the dentry (or dentries), not the whole
> directory.  dentry_lookup() combines locking the directory and
> performing a lookup prior to a change to the directory.  On success it
> returns a dentry which is consider to be locked, though at this stage
> the whole parent directory is actually locked.
> 
> dentry_lookup_noperm() does the same without needing a mnt_idmap and
> without checking permissions.  This is useful for internal filesystem
> management (e.g.  creating virtual files in response to events) and in
> other cases similar to lookup_noperm().

Details, please.  I seriously hope that simple_start_creating() will
end up used for all of those; your variant allows passing LOOKUP_...
flags and I would like to understand what the usecases will be.

What's more, IME the "intent" arguments are best avoided - better have
separate primitives; if internally they call a common helper with some
flags, etc., it's their business, but exposing that to callers ends
up with very unpleasant audits down the road.  As soon as you get
callers that pass something other than explicit constants, you get
data flow into the mix ("which values can end up passed in this one?")
and that's asking for trouble.

> __dentry_lookup() is a VFS-internal interface which does no permissions
> checking and assumes that the hash of the name has already been stored
> in the qstr.  This is useful following filename_parentat().
> 
> done_dentry_lookup() is provided which performs the inverse of putting
> the dentry and unlocking.

Not sure I like the name, TBH...

> Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
> LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
> -EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.
> 
> These functions replace all uses of lookup_one_qstr_excl() in namei.c
> except for those used for rename.
> 
> They also allow simple_start_creating() to be simplified into a
> static-inline.

Umm...  You've also moved it into linux/namei.h; we'd better verify that
it's included in all places that need that...

> A __free() class is provided to allow done_dentry_lookup() to be called
> transparently on scope exit.  dget() is extended to ignore ERR_PTR()s
> so that "return dget(dentry);" is always safe when dentry was provided
> by dentry_lookup() and the variable was declared __free(dentry_lookup).

Please separate RAII stuff from the rest of that commit.  Deciding if
it's worth doing in any given case is hard to do upfront.

> lookup_noperm_common() and lookup_one_common() are moved earlier in
> namei.c.

Again, separate commit - reduce the noise in less trivial ones.

> +struct dentry *dentry_lookup(struct mnt_idmap *idmap,
> +			     struct qstr *last,
> +			     struct dentry *base,
> +			     unsigned int lookup_flags)

Same problem with flags, *ESPECIALLY* if your endgame involves the
locking of result dependent upon those.

> -	dput(dentry);
> +	done_dentry_lookup(dentry);
>  	dentry = ERR_PTR(error);
> -unlock:
> -	inode_unlock(path->dentry->d_inode);

Incidentally, this combination (dput()+unlock+return ERR_PTR())
is common enough.  Might be worth a helper (taking error as argument;
that's one of the reasons why I'm not sure RAII is a good fit for this
problem space)

> +/* no_free_ptr() must not be used here - use dget() */
> +DEFINE_FREE(dentry_lookup, struct dentry *, if (_T) done_dentry_lookup(_T))

UGH.  Please, take that to the very end of the series.  And the comment
re no_free_ptr() and dget() is really insufficient - you will get a dentry
reference that outlives your destructor, except that locking environment will
change.  Which is subtle enough to warrant a discussion.

Besides, I'm not fond of mixing that with dget(); put another way, this
subset of dget() uses is worth being clearly marked as such.  A primitive
that calls dget() to do work?  Sure, no problem.

We have too many dget() callers with very little indication of what we are
doing there (besides "bump the refcount"); tree-in-dcache series will
at least peel off the ones that are about pinning a created object in
ramfs-style filesystems.  That's not going to cover everything (not even
close), but let's at least not add to the already messy pile...

