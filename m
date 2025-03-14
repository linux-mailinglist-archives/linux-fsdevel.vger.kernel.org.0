Return-Path: <linux-fsdevel+bounces-44020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385CEA60F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3857A9B1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597751F4162;
	Fri, 14 Mar 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfUKyGEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6F1F1934;
	Fri, 14 Mar 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948744; cv=none; b=annqEmkVSYXqvKXbC5ldELaJXfLaErh2vgAl504ONY75qaAaMt102FcJeAWRLR9uUbWK+iYZMEJQvfQY7FaBMLu2XFybtgpPakJRLMK7Tu7g6UOazL/KkQ46H7K/tHlYgEA7DudlTKSkqNS5qyFk1YBZ/zoyf82PX/4gPs1RXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948744; c=relaxed/simple;
	bh=ViuVFqdum2mxJWZUNzKOl9aYIxyVR8GlAtNOhK+gL84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeQmqwOGheuZhSEZTYngiGW4TEBA+dS1tEH/YQi4adRdKNSMDXITScc22GEGQ+zoApNs+4WHeTtIdRb9Exk3n4eavveMqW5IruFxVuRWuwwQ4x91QSDjjO0AkD+6A306XRIotBc1oEh7qlXA3m6vIQwlncTQzUItvXNfl88bti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfUKyGEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F9EC4CEE3;
	Fri, 14 Mar 2025 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741948744;
	bh=ViuVFqdum2mxJWZUNzKOl9aYIxyVR8GlAtNOhK+gL84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfUKyGEpWdoJUFDyizWtcR6MTcBD03ipKELIl9a2+429VyrZo0qU+WNG81OB5RcXA
	 9NO4E/SWfO5gnwHwy1hyTciOFqNNpAL4qGVP7HhiQgVIOs/IR4VKfeLHdUGKbqOsjc
	 9UZFhi7GAwPSAd3nhcnN8Iu+KHaKEtlPLGykS+5mfdloi+auywWOQDbGYEos/8+Qq0
	 DHD/LPicakk5T/1iWPZ6GbiUzH8JSfEIjjEvT+IEfq2GT4xSquIYXnKKRQ6IpHTHqd
	 VDwXSeYRKED+917tj82eDvROJYfAs1PC4DjMHNgzQ0dXG87df0711wtnhbkEVI1eqm
	 yHS6q9D8PNVvg==
Date: Fri, 14 Mar 2025 11:38:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8 RFC] tidy up various VFS lookup functions
Message-ID: <20250314-geprobt-akademie-cae577d90899@brauner>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314045655.603377-1-neil@brown.name>

On Fri, Mar 14, 2025 at 11:34:06AM +1100, NeilBrown wrote:
> VFS has some functions with names containing "lookup_one_len" and others
> without the "_len".  This difference has nothing to do with "len".
> 
> The functions without "_len" take a "mnt_idmap" pointer.  This is found

When we added idmapped mounts there were all these *_len() helpers and I
orignally had just ported them to pass mnt_idmap. But we decided to not
do this. The argument might have been that most callers don't need to be
switched (I'm not actually sure if that's still true now that we have
quite a few filesystems that do support idmapped mounts.).

So then we added new helper and then we decided to use better naming
then that *_len() stuff. That's about it.

> in the "vfsmount" and that is an important question when choosing which
> to use: do you have a vfsmount, or are you "inside" the filesystem.  A
> related question is "is permission checking relevant here?".
> 
> nfsd and cachefiles *do* have a vfsmount but *don't* use the non-_len
> functions.  They pass nop_mnt_idmap which is not correct if the vfsmount
> is actually idmaped.  For cachefiles it probably (?) doesn't matter as
> the accesses to the backing filesystem are always does with elevated privileged (?).

Cachefiles explicitly refuse being mounted on top of an idmapped mount
and they require that the mount is attached (check_mnt()) and an
attached mount can never be idmapped as it has already been exposed in
the filesystem hierarchy.

> 
> For nfsd it would matter if anyone exported an idmapped filesystem.  I
> wonder if anyone has tried...

nfsd doesn't support exporting idmapped mounts. See check_export() where
that's explicitly checked.

If there are ways to circumvent this I'd be good to know.

> 
> These patches change the "lookup_one" functions to take a vfsmount
> instead of a mnt_idmap because I think that makes the intention clearer.

Please don't!

These internal lookup helpers intentionally do not take a vfsmount.
First, because they can be called in places where access to a vfsmount
isn't possible and we don't want to pass vfsmounts down to filesystems
ever!

Second, the mnt_idmap pointer is - with few safe exceptions - is
retrieved once in the VFS and then passed down so that e.g., permission
checking and file creation are guaranteed to use the same mnt_idmap
pointer.

A caller may start out with a non-idmapped detached mount (e.g., via
fsmount() or OPEN_TREE_CLONE) (nop_mnt_idmap) and call
inode_permission(). Now someone idmaps that mount. Now further down the
callchain someone calls lookup_one() which now retrieves the idmapping
again and now it's an idmapped mount. Now permission checking is out of
sync. That's an unlikely scenario but it's possible so lookup_one() is
not supposed to retrieve the idmapping again. Please keep passing it
explicitly. I've also written that down in the Documenation somewhere.

> 
> It also renames the "_one" functions to be "_noperm" and removes the
> permission checking completely.  In all cases where they are (correctly)
> used permission checking is irrelevant.

Ok, that sounds fine. Though I haven't taken the time to check the
callers yet. I'll try to do that during the weekend.

> 
> I haven't included changes to afs because there are patches in vfs.all
> which make a lot of changes to lookup in afs.  I think (if they are seen
> as a good idea) these patches should aim to land after the afs patches
> and any further fixup in afs can happen then.
> 
> The nfsd and cachefiles patches probably should be separate.  Maybe I
> should submit those to relevant maintainers first, and one afs,
> cachefiles, and nfsd changes have landed I can submit this series with
> appropriate modifications.
> 
> May main question for review is : have I understood mnt_idmap correctly?

I mean, you didn't ask semantic questions so much as syntactic, I think.
I hope I explained the reasoning sufficiently.

Thanks for the cleanups.

