Return-Path: <linux-fsdevel+bounces-15046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA30886532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 03:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C621F245C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 02:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B06138;
	Fri, 22 Mar 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OjhrExiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC81138C;
	Fri, 22 Mar 2024 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074923; cv=none; b=pM8cpO2WBon2l42DLQL3XyA+Pa88fRs6QKY/ZDej9dh+oItjkJDXToF6bx/IQStl5lw6a3Bu0XvJzqX91VU6oMy8lPJMwsiUvXBtOyvyEdZFLK84HkEyJwMsvhQEQfTV3xoR1tbcxHoqhOpKZ/1GfolFPAi80yH521wI3ssJ/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074923; c=relaxed/simple;
	bh=nB0QDypS2n9Nsn2FH/sqpS/3Wr6EHtgvGrCrJlul2Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOh1zCicwjSGxw2Ukhqa2J1nmhRxVxiAYvY9XsK8Gfy+PGPeVEdJCr42VJAt6C5G4FkAOx5wZPyK/fPe/WlYIDzE2GHWoOPcloSVDt+JVMDYzrnvEMJrn8CFeeUduPSsV1zsD4qwYKAJW6TZJo9RSTQkffQusRLwZToirdRJOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OjhrExiM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vjik512rUaEVFltmTlo5uRjlbgnvPI+ZtoSp05483d0=; b=OjhrExiMqssHwc8+LlNq3DD18s
	mTVDyk0TCBA6cxhek+tL+ArRd4M/9JX7+lNeAdOnVTIKfHJ3o3YLKoe/6LvV7vrLkcVq9vWEtx73p
	jfttgTZH45cPRqm6VL6fbLyQX7+/YkbFdTTULoXkgNYq2EWTlvgSfhHNagQsW8/qKS3zgsFDO6pWQ
	Vzdt0DYPMXRNG1ClUBrSVfiAUhq6r33cO+ef/5tZI//FUw0q01fuD+yTExOd3TxW1P7nuMjNl4kV2
	xZ15KlvHwgyF817PurOyZNLc5O8Jm/1LFy7PqEYKgl27Tto+Pf9hxI3kBwwze4+2cyvbfn8gfD5Pb
	7X+ege8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnUkV-00EDhl-1k;
	Fri, 22 Mar 2024 02:35:15 +0000
Date: Fri, 22 Mar 2024 02:35:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Christian Brauner <brauner@kernel.org>, ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] ntfs3: remove atomic_open
Message-ID: <20240322023515.GK538574@ZenIV>
References: <20240318-ntfs3-atomic-open-v1-1-57afed48fe86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-ntfs3-atomic-open-v1-1-57afed48fe86@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 18, 2024 at 02:28:50PM -0400, Jeff Layton wrote:
> atomic_open is an optional VFS operation, and is primarily for network
> filesystems. NFS (for instance) can just send an open call for the last
> path component rather than doing a lookup and then having to follow that
> up with an open when it doesn't have a dentry in cache.
> 
> ntfs3 is a local filesystem however, and its atomic_open just does a
> typical lookup + open, but in a convoluted way. atomic_open will also
> make directory leases more difficult to implement on the filesystem.

FWIW, I'm not sure they are actually doing it correctly, but in any
case - there's no reason whatsoever for implementing that sucker on
a local filesystem.  Kill it.

> -	inode = ntfs_create_inode(file_mnt_idmap(file), dir, dentry, uni,
> -				  mode, 0, NULL, 0, fnd);
> -	err = IS_ERR(inode) ? PTR_ERR(inode) :
> -			      finish_open(file, dentry, ntfs_file_open);

... incidentally, this ntfs_create_inode() thing should not have the
calling conventions it has.

It does create inode, all right - and attaches it to dentry.  Then it
proceeds to return the pointer to that new inode, with dentry->d_inode
being the only thing that keeps it alive.  That would be defendable
(we are holding a reference to dentry and nobody else could turn
it negative under us), but... look at the callers.

4 out of 5 are of the same form:
	inode = ntfs_create_inode(....);
	return IS_ERR(inode) ? PTR_ERR(inode) : 0;

The fifth one is the crap above and there we *also* never look at the
return value downstream of that IS_ERR(inode) ? PTR_ERR(inode) : ...;

Which is to say, all callers of that thing don't give a damn about
the pointer per se - they only want to know if it's ERR_PTR(-E...)
or not and if it is, what error had been wrapped into that ERR_PTR().

Simply make it return 0 or -E... - if some future caller really
wants a reference to struct inode that had been created, they can
bloody well pick it from dentry->d_inode.

In any case, this caller should simply die - ->atomic_open() instance
does not buy *anything* here.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

