Return-Path: <linux-fsdevel+bounces-44564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF657A6A5E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB2498424C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A9221739;
	Thu, 20 Mar 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GExQ+Dr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4F2206B8;
	Thu, 20 Mar 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472338; cv=none; b=JLid+ZSbcTjxgCLJCST3LbDtutlxtbiK3TKjTDFlJjHO/Bf8W7EilyDAEvykO6TO0BepIIyeh4/YpZ9yhJu1BD9z0YGwil9LmulTu+4dpBMaoouoG8kBTCtRwjdriBSl+QeC18V/RgNuBCTlzTXQvh6jscTe8sZIaJm9sCps9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472338; c=relaxed/simple;
	bh=U4mknsH+VgtvoFIFRWx2XZhXVD1ocoQxpKl/lZzi8Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdnSH2FimokhNngF7lFsuLZoA/Xau7HrwvvJfuRstuB4HbPykE7CtM6erwpEhn7z/9Dqh+OOgHSPx0rEyQ1DLx5OKl41Dz59LHgD/HVB0ZWydJFh0iY2w7NeeHf/rTOQjs95g4ycUM8lUvqY66BRuFGLsTn/c51PNM8l7mqnecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GExQ+Dr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511A0C4CEDD;
	Thu, 20 Mar 2025 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742472337;
	bh=U4mknsH+VgtvoFIFRWx2XZhXVD1ocoQxpKl/lZzi8Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GExQ+Dr4nv7qbLUyq3shyQU3Shg1gP18e0Ded3U0vnR8BlD41xvs7IbdW8zlc+/9F
	 W7dPjsZgDCK++coE3U49DWq42LZM1TG8ubhel5MMMFYSfOBkqV0ya79YYxzbe2EhrJ
	 5KTZXhVfCH4zmqIGFaW0Crp9TSvtIe5ix0RblanHWcFud+zLMnItqOEgjcNmIcmE0H
	 HN2bh2DHtFo75qFuqRYjQe+3VOqE68r1iU3Qjo6PhSQ6nrvPGzj++OfpdO0KYwSq5/
	 iSkKBJD9ISAZ0IdO9j5n0eKKRA5MZwBq72xXRO/MJMhCLf53kKhmpm/z3Ti7KX0s5R
	 r8NEQYdczV4YA==
Date: Thu, 20 Mar 2025 13:05:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] cachefiles: Use lookup_one() rather than
 lookup_one_len()
Message-ID: <20250320-goldbarren-brauhaus-6d6ff0a7be72@brauner>
References: <20250319031545.2999807-1-neil@brown.name>
 <20250319031545.2999807-4-neil@brown.name>
 <ee36dab38583d28205c4b40a87126c44cab69dc9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee36dab38583d28205c4b40a87126c44cab69dc9.camel@kernel.org>

On Thu, Mar 20, 2025 at 06:22:08AM -0400, Jeff Layton wrote:
> On Wed, 2025-03-19 at 14:01 +1100, NeilBrown wrote:
> > From: NeilBrown <neilb@suse.de>
> > 
> > cachefiles uses some VFS interfaces (such as vfs_mkdir) which take an
> > explicit mnt_idmap, and it passes &nop_mnt_idmap as cachefiles doesn't
> > yet support idmapped mounts.
> > 
> > It also uses the lookup_one_len() family of functions which implicitly
> > use &nop_mnt_idmap.  This mixture of implicit and explicit could be
> > confusing.  When we eventually update cachefiles to support idmap mounts it
> 
> Is that something we ever plan to do?

It should be pretty easy to do. I just didn't see a reason to do it yet.

Fwiw, the cache paths that cachefiles uses aren't private mounts like overlayfs
does it, i.e., cachefiles doesn't do clone_private_mount() before stashing
cache->mnt. That means properties of the mount can simply change beneath
cachefilesd. And afaict cache->mnt isn't even opened for writing so the mount
could suddenly go read-only behind cachefilesd's back. It probably will ignore
that since it doesn't use mnt_want_write() apart for xattrs.

> 
> > would be best if all places which need an idmap determined from the
> > mount point were similar and easily found.
> > 
> > So this patch changes cachefiles to use lookup_one(), lookup_one_unlocked(),
> > and lookup_one_positive_unlocked(), passing &nop_mnt_idmap.
> > 
> > This has the benefit of removing the remaining user of the
> > lookup_one_len functions where permission checking is actually needed.
> > Other callers don't care about permission checking and using these
> > function only where permission checking is needed is a valuable
> > simplification.
> > 
> > This requires passing the name in a qstr.  This is easily done with
> > QSTR() as the name is always nul terminated, and often strlen is used
> > anyway.  ->d_name_len is removed as no longer useful.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/cachefiles/internal.h |  1 -
> >  fs/cachefiles/key.c      |  1 -
> >  fs/cachefiles/namei.c    | 14 +++++++-------
> >  3 files changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> > index 38c236e38cef..b62cd3e9a18e 100644
> > --- a/fs/cachefiles/internal.h
> > +++ b/fs/cachefiles/internal.h
> > @@ -71,7 +71,6 @@ struct cachefiles_object {
> >  	int				debug_id;
> >  	spinlock_t			lock;
> >  	refcount_t			ref;
> > -	u8				d_name_len;	/* Length of filename */
> >  	enum cachefiles_content		content_info:8;	/* Info about content presence */
> >  	unsigned long			flags;
> >  #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
> > diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
> > index bf935e25bdbe..4927b533b9ae 100644
> > --- a/fs/cachefiles/key.c
> > +++ b/fs/cachefiles/key.c
> > @@ -132,7 +132,6 @@ bool cachefiles_cook_key(struct cachefiles_object *object)
> >  success:
> >  	name[len] = 0;
> >  	object->d_name = name;
> > -	object->d_name_len = len;
> >  	_leave(" = %s", object->d_name);
> >  	return true;
> >  }
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 83a60126de0f..4fc6f3efd3d9 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -98,7 +98,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
> >  retry:
> >  	ret = cachefiles_inject_read_error();
> >  	if (ret == 0)
> > -		subdir = lookup_one_len(dirname, dir, strlen(dirname));
> > +		subdir = lookup_one(&nop_mnt_idmap, QSTR(dirname), dir);
> >  	else
> >  		subdir = ERR_PTR(ret);
> >  	trace_cachefiles_lookup(NULL, dir, subdir);
> > @@ -337,7 +337,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
> >  		return -EIO;
> >  	}
> >  
> > -	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
> > +	grave = lookup_one(&nop_mnt_idmap, QSTR(nbuffer), cache->graveyard);
> >  	if (IS_ERR(grave)) {
> >  		unlock_rename(cache->graveyard, dir);
> >  		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
> > @@ -629,8 +629,8 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
> >  	/* Look up path "cache/vol/fanout/file". */
> >  	ret = cachefiles_inject_read_error();
> >  	if (ret == 0)
> > -		dentry = lookup_positive_unlocked(object->d_name, fan,
> > -						  object->d_name_len);
> > +		dentry = lookup_one_positive_unlocked(&nop_mnt_idmap,
> > +						      QSTR(object->d_name), fan);
> >  	else
> >  		dentry = ERR_PTR(ret);
> >  	trace_cachefiles_lookup(object, fan, dentry);
> > @@ -682,7 +682,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
> >  	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> >  	ret = cachefiles_inject_read_error();
> >  	if (ret == 0)
> > -		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
> > +		dentry = lookup_one(&nop_mnt_idmap, QSTR(object->d_name), fan);
> >  	else
> >  		dentry = ERR_PTR(ret);
> >  	if (IS_ERR(dentry)) {
> > @@ -701,7 +701,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
> >  		dput(dentry);
> >  		ret = cachefiles_inject_read_error();
> >  		if (ret == 0)
> > -			dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
> > +			dentry = lookup_one(&nop_mnt_idmap, QSTR(object->d_name), fan);
> >  		else
> >  			dentry = ERR_PTR(ret);
> >  		if (IS_ERR(dentry)) {
> > @@ -750,7 +750,7 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
> >  
> >  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> >  
> > -	victim = lookup_one_len(filename, dir, strlen(filename));
> > +	victim = lookup_one(&nop_mnt_idmap, QSTR(filename), dir);
> >  	if (IS_ERR(victim))
> >  		goto lookup_error;
> >  	if (d_is_negative(victim))
> 
> Patch looks sane though.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

