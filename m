Return-Path: <linux-fsdevel+bounces-57042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF367B1E470
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF74167656
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CF25484D;
	Fri,  8 Aug 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vGS2O7jo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD3EEB3
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641979; cv=none; b=uSvJ7Ty8+TUGZ+iDDxvKQNh5OiGYHInbNMgxqxHGGIS7fdrjcehBtdIYIlLPJ33ADPDbp7hFbNA+0TQFm468RWI483KeGqRRFSDVfXvHIWhRrc3fM4B5UoLwbb/8dQ6K7zV2K2PVNpHhLyE6G2o/CN7omudj3/cILUCy2XuXGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641979; c=relaxed/simple;
	bh=gT+txAt8nZe/co3LkaAWz8uEzYM6sGFZniHbs4hZqcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIpZyrrO4cLIcOR6/NNZwiwAi1ztifyC0rguP6+L8bRh8e6Iza+H1ouNZ0NiktkxJaikHf/YMlH8lHExlOBxizFFaj4R15nBYlE4gQ8Es53/aOVNgO68rJ3TcaFoUOtTRlUGGvmScsUewVGohXaLmD94C+1WtgmM1BwvIBgu0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vGS2O7jo; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4byy2k0fHbzYF1;
	Fri,  8 Aug 2025 10:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1754641965;
	bh=+4ctHB3moBCqTfP2FRQc6ZArCbvN42I0Tyrh1hPX3xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGS2O7jor5acY+JkeRvyLM4Ls760abARgX+2IG411SN+960bsUT6nqLH0ST+vBL0F
	 SA0E8DcnVXus/LwawkuHKshRrCLjUJ8KeYaQjj2Bsbujp+W9jdqKo3YJCAqJ3xlq16
	 TyjxpymCGpG8Ekg8LLjhqGiPwN/9ivNUrxnVW/BE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4byy2j05FJzwZg;
	Fri,  8 Aug 2025 10:32:44 +0200 (CEST)
Date: Fri, 8 Aug 2025 10:32:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	v9fs@lists.linux.dev, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for
 .L
Message-ID: <20250808.oog4xee5Pee2@digikod.net>
References: <cover.1743971855.git.m@maowtm.org>
 <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
 <20250705002536.GW1880847@ZenIV>
 <b32e2088-92c0-43e0-8c90-cb20d4567973@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b32e2088-92c0-43e0-8c90-cb20d4567973@maowtm.org>
X-Infomaniak-Routing: alpha

On Fri, Jul 11, 2025 at 08:11:44PM +0100, Tingmao Wang wrote:
> Hi Al, thanks for the review :)  I haven't had the chance to properly
> think about this until today, so apologies for the delay.
> 
> On 7/5/25 01:19, Al Viro wrote:
> > On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
> > 
> >> +struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
> >> +{
> >> +	struct v9fs_ino_path *path;
> >> +	size_t path_components = 0;
> >> +	struct dentry *curr = dentry;
> >> +	ssize_t i;
> >> +
> >> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> >> +
> >> +	rcu_read_lock();
> >> +
> >> +    /* Don't include the root dentry */
> >> +	while (curr->d_parent != curr) {
> >> +		path_components++;
> >> +		curr = curr->d_parent;
> >> +	}
> >> +	if (WARN_ON(path_components > SSIZE_MAX)) {
> 
> (Looking at this again I think this check is a bit bogus.  I don't know
> how would it be possible at all for us to have > SSIZE_MAX deep
> directories especially since each level requires a dentry allocation, but
> even if this check is actually useful, it should be in the while loop,
> before each path_components++)

WARN_ON_ONCE() would be better, especially in a while loop.  I avoid
using WARN_ON(), especially when that can be triggered by users.

> 
> >> +		rcu_read_unlock();
> >> +		return NULL;
> >> +	}
> >> +
> >> +	path = kmalloc(struct_size(path, names, path_components),
> >> +		       GFP_KERNEL);
> > 
> > Blocking allocation under rcu_read_lock().
> 
> I think my first instinct of how to fix this, if the original code is
> correct barring this allocation issue, would be to take rcu read lock
> twice (first walk to calculate how much to allocate, then second walk to
> actually take the snapshots).  We should be safe to rcu_read_unlock() in
> the middle as long as caller has a reference to the target dentry (this
> needs to be true even if we just do one rcu_read_lock() anyway), and we
> can start a parent walk again.  The v9fs rename_sem should ensure we see
> the same path again.
> 
> Alternatively, we can use dget_parent to do the walk, and not lock RCU at
> all.  We still need to walk twice tho, to know how much to allocate.  But
> for now I will keep the current approach.
> 
> New version:
> 
> /*
>  * Must hold rename_sem due to traversing parents.  Caller must hold
>  * reference to dentry.
>  */
> struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
> {
> 	struct v9fs_ino_path *path;
> 	size_t path_components = 0;
> 	struct dentry *curr = dentry;
> 	ssize_t i;
> 
> 	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> 	might_sleep(); /* Allocation below might block */
> 
> 	rcu_read_lock();
> 
> 	/* Don't include the root dentry */
> 	while (curr->d_parent != curr) {
> 		if (WARN_ON(path_components >= SSIZE_MAX)) {
> 			rcu_read_unlock();
> 			return NULL;
> 		}
> 		path_components++;
> 		curr = curr->d_parent;
> 	}
> 
> 	/*
> 	 * Allocation can block so don't do it in RCU (and because the
> 	 * allocation might be large, since name_snapshot leaves space for
> 	 * inline str, not worth trying GFP_ATOMIC)
> 	 */
> 	rcu_read_unlock();
> 
> 	path = kmalloc(struct_size(path, names, path_components), GFP_KERNEL);
> 	if (!path) {
> 		rcu_read_unlock();

This unlock is wrong.

> 		return NULL;
> 	}
> 
> 	path->nr_components = path_components;
> 	curr = dentry;
> 
> 	rcu_read_lock();
> 	for (i = path_components - 1; i >= 0; i--) {
> 		take_dentry_name_snapshot(&path->names[i], curr);
> 		curr = curr->d_parent;
> 	}
> 	WARN_ON(curr != curr->d_parent);
> 	rcu_read_unlock();
> 	return path;
> }
> 
> How does this look?

Looks good to me overall.  Please sent a new patch series.

> 
> On 7/5/25 01:25, Al Viro wrote:
> > On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
> >> +bool ino_path_compare(struct v9fs_ino_path *ino_path,
> >> +			     struct dentry *dentry)
> >> +{
> >> +	struct dentry *curr = dentry;
> >> +	struct qstr *curr_name;
> >> +	struct name_snapshot *compare;
> >> +	ssize_t i;
> >> +
> >> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> >> +
> >> +	rcu_read_lock();
> >> +	for (i = ino_path->nr_components - 1; i >= 0; i--) {
> >> +		if (curr->d_parent == curr) {
> >> +			/* We're supposed to have more components to walk */
> >> +			rcu_read_unlock();
> >> +			return false;
> >> +		}
> >> +		curr_name = &curr->d_name;
> >> +		compare = &ino_path->names[i];
> >> +		/*
> >> +		 * We can't use hash_len because it is salted with the parent
> >> +		 * dentry pointer.  We could make this faster by pre-computing our
> >> +		 * own hashlen for compare and ino_path outside, probably.
> >> +		 */
> >> +		if (curr_name->len != compare->name.len) {
> >> +			rcu_read_unlock();
> >> +			return false;
> >> +		}
> >> +		if (strncmp(curr_name->name, compare->name.name,
> >> +			    curr_name->len) != 0) {
> > 
> > ... without any kind of protection for curr_name.  Incidentally,
> > what about rename()?  Not a cross-directory one, just one that
> > changes the name of a subdirectory within the same parent?
> 
> As far as I can tell, in v9fs_vfs_rename, v9ses->rename_sem is taken for
> both same-parent and different parent renames, so I think we're safe here
> (and hopefully for any v9fs dentries, nobody should be causing d_name to
> change except for ourselves when we call d_move in v9fs_vfs_rename?  If
> yes then because we also take v9ses->rename_sem, in theory we should be
> fine here...?)

A lockdep_assert_held() or similar and a comment would make this clear.

> 
> (Let me know if I missed anything.  I'm assuming only the filesystem
> "owning" a dentry should d_move/d_exchange the dentry.)
> 
> However, I see that there is a d_same_name function in dcache.c which is
> slightly more careful (but still requires the caller to check the dentry
> seqcount, which we do not need to because of the reasoning above), and in
> hindsight I think that is probably the more proper way to do this
> comparison (and will also handle case-insensitivity, although I've not
> explored if this is applicable to 9pfs).
> 
> New version:
> 
> /*
>  * Must hold rename_sem due to traversing parents
>  */
> bool ino_path_compare(struct v9fs_ino_path *ino_path, struct dentry *dentry)
> {
> 	struct dentry *curr = dentry;
> 	struct name_snapshot *compare;
> 	ssize_t i;
> 
> 	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> 
> 	rcu_read_lock();
> 	for (i = ino_path->nr_components - 1; i >= 0; i--) {
> 		if (curr->d_parent == curr) {
> 			/* We're supposed to have more components to walk */
> 			rcu_read_unlock();
> 			return false;
> 		}
> 		compare = &ino_path->names[i];
> 		if (!d_same_name(curr, curr->d_parent, &compare->name)) {
> 			rcu_read_unlock();
> 			return false;
> 		}
> 		curr = curr->d_parent;
> 	}
> 	rcu_read_unlock();
> 	if (curr != curr->d_parent) {
> 		/* dentry is deeper than ino_path */
> 		return false;
> 	}
> 	return true;
> }

I like this new version.

> 
> If you think this is not enough, can you suggest what would be needed?
> I'm thinking maybe we can check dentry seqcount to be safe, but from
> earlier discussion in "bpf path iterator" my impression is that that is
> VFS internal data - can we use it here (if needed)?
> 
> (I assume, from looking at the code, just having a reference does not
> prevent d_name from changing)
> 
> 

