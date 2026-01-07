Return-Path: <linux-fsdevel+bounces-72610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66FCFD508
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1699930FC0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489C327783;
	Wed,  7 Jan 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8gGwtwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE83246E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783240; cv=none; b=ESBR3aaertlfRFHeFy08bExWzQG2u6YyCVV8Fkyvj0bbH21NfXwdJ4gHKywxbejJVP0u2wDhBKT64On2/gmQEs0+mkaqao+uVKWRGY3MlhvlWAlAuMSyB/Cn6aCqh7zzwWnuOkIzJk0zO2GjgIJBe/wu4iF7mcChDZ9MmR11MZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783240; c=relaxed/simple;
	bh=qiVZpsJJgP4G7hqE0Zx0FI0uKDA2YicfpZ1g/tP1JbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmRiU8oe0VOmf8jzS5T8vhwe2BcgfetXImLAtPK3iKO0Cx4LGZGFDJIH6P3XjHWaPx9rGSDCGYfnZKvtQlpMy0ChmBY9Qp7NM+Kr5Jlw3lGCOHleCu2AeyIK+bf27JDvRJcLtgYY3QXVHSV19r073I/O97SitlJOJ298UGn3B/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8gGwtwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B587C16AAE;
	Wed,  7 Jan 2026 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767783240;
	bh=qiVZpsJJgP4G7hqE0Zx0FI0uKDA2YicfpZ1g/tP1JbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8gGwtwEljvCqeDVMen7knY7PDsz52mMFUH0S/DdQoZX5o0EH0byFkjApAHrW6YJk
	 DEq+AgK71/CwxpwqL49+5B3UKkJQidO6cxQ7nKcFf6+kWGt2nUZJaHrmsOyyGu/XCp
	 SiZDfjMXirTFkpSKNTkpSJaRyff5u9YlfcCHMDD1AZZT1z1wda3/9WsohA8KFWOOII
	 K9SZvS/qK+P6qHXjydtNLWOPpQsAI56Ff8g2SuskEpbCNApobtserg9rrcOxBIlx+O
	 4Jd2G9J3Oy2e79DhlUgHyJ3wTzrCRDP52QYo6TMA9+J+FuK166WAY+hdtz/jjP8XXk
	 VfN9GUm7BfXbg==
Date: Wed, 7 Jan 2026 11:53:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260107-harren-gesund-d6e4539325fc@brauner>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <20260104072743.GI1712166@ZenIV>
 <20260104074145.GJ1712166@ZenIV>
 <20260106-verpachten-antrag-5b610d1ec4d0@brauner>
 <20260106225917.GL1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106225917.GL1712166@ZenIV>

On Tue, Jan 06, 2026 at 10:59:17PM +0000, Al Viro wrote:
> On Tue, Jan 06, 2026 at 11:07:32PM +0100, Christian Brauner wrote:
> 
> > 
> > Afaict, FS_IMMUTABLE_FL can be cleared by a sufficiently privileged
> > process breaking the promise that this is a permanently immutable
> > rootfs.
> 
> Not on ramfs:
> 
> int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>                      struct file_kattr *fa)
> {
>         struct inode *inode = d_inode(dentry);
>         struct file_kattr old_ma = {};
>         int err;
>  
>         if (!inode->i_op->fileattr_set)
>                 return -ENOIOCTLCMD;
> 
> and that's it, priveleges do not matter.

Ugh, that relies on a current implementation detail of ramfs. I'm not
super convinced that this is great. Like, if you can swallow it I think
having a "nullfs" or "immutablefs" type with a separate magic number
does provide some value and frankly is just a lot cleaner than abusing
ramfs.

