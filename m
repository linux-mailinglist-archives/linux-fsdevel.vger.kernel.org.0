Return-Path: <linux-fsdevel+bounces-50832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A696EAD0053
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC1B3B10BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1B2874E7;
	Fri,  6 Jun 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGgOFtvB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B53286429;
	Fri,  6 Jun 2025 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205548; cv=none; b=HSyRFpMKaD3lqsM1EgDtc/dh5Pcs1coQCIp7IZloSm3CbLsTQCFLeAHnzTW2Tvg/9Q1Y+Ooa0Xx82SPAYibYdMYFc+oP2lDDVBnwbi8QX6Kiisoaa/l1XydvP0IlncXshcEqB+cflTFWzYR8UhqmvEEFq3aowjyRsu1XkgjCHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205548; c=relaxed/simple;
	bh=mbA+lngWZ9beJw17QPOnl7cGBwKaghlXmMthhixaP8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2lrLbbXv4FntAW8CJ6KD45Ut3iNUGGbb1+EUCNeZlJAmH44taZStTCHnwg1tknGqK9uCSS/PU3UOzAGQhHdCYI8RDyXux52yjFahTECAZr3UC7sVDCKsWXqTdxUtfhyCzD39TrxTjWY6fqp+rD0j+n7aIi8AS0aS27tJ9CyPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGgOFtvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0ACC4CEEB;
	Fri,  6 Jun 2025 10:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749205547;
	bh=mbA+lngWZ9beJw17QPOnl7cGBwKaghlXmMthhixaP8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGgOFtvBUGVoLu9xUxRWwb3M4MO6193gw9kZzBsVrxSaXl1sxr7b+ffkc6NYcyX6V
	 pyoHP5b225Gy8diFLATEROxrPTF1INQp3G2x6vZ900MWtuxttrI+TozVPRFyczYvbM
	 59iu9tnWHYTHeLUvUVz0fv9c4r//zpiwpsVbmigqXT1MVn86R8jEl6W7++2J2d+1O3
	 HQmUUGzcR7F6G+LnM+5GPJNJ5u2d+UUkEm6Bt2L94S8aqymH/8VvI3UALGkDY9WG7U
	 SR1GF2luX6rNmEtFW47iuTJrgDupb5Xj//XY+3OHlrNdfccHexWwbQP76k6W/jhzNt
	 F2GfpFK395w9Q==
Date: Fri, 6 Jun 2025 12:25:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Song Liu <song@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] landlock: walk parent dir without taking
 references
Message-ID: <20250606-ekstase-geloben-9d8916729756@brauner>
References: <cover.1748997840.git.m@maowtm.org>
 <8cf726883f6dae564559e4aacdb2c09bf532fcc5.1748997840.git.m@maowtm.org>
 <20250604.ciecheo7EeNg@digikod.net>
 <5c8476df-56c4-4dd1-b5c8-40cb604eae62@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c8476df-56c4-4dd1-b5c8-40cb604eae62@maowtm.org>

On Wed, Jun 04, 2025 at 10:05:01PM +0100, Tingmao Wang wrote:
> On 6/4/25 18:15, Mickaël Salaün wrote:
> > On Wed, Jun 04, 2025 at 01:45:43AM +0100, Tingmao Wang wrote:
> >> [..]
> >> @@ -897,10 +898,14 @@ static bool is_access_to_paths_allowed(
> >>  			break;
> >>  jump_up:
> >>  		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> >> +			/* follow_up gets the parent and puts the passed in path */
> >> +			path_get(&walker_path);
> >>  			if (follow_up(&walker_path)) {
> >> +				path_put(&walker_path);
> >
> > path_put() cannot be safely called in a RCU read-side critical section
> > because it can free memory which can sleep, and also because it can wait
> > for a lock.  However, we can call rcu_read_unlock() before and
> > rcu_read_lock() after (if we hold a reference).
> 
> Thanks for pointing this out.
> 
> Actually I think this might be even more tricky.  I'm not sure if we can
> always rely on the dentry still being there after rcu_read_unlock(),
> regardless of whether we do a path_get() before unlocking...  Even when
> we're inside a RCU read-side critical section, my understanding is that if
> a dentry reaches zero refcount and is selected to be freed (either
> immediately or by LRU) from another CPU, dentry_free will do
> call_rcu(&dentry->d_u.d_rcu, __d_free) which will cause the dentry to
> immediately be freed after our rcu_read_unlock(), regardless of whether we
> had a path_get() before that.
> 
> In fact because lockref_mark_dead sets the refcount to negative,
> path_get() would simply be wrong.  We could use lockref_get_not_dead()
> instead, and only continue if we actually acquired a reference, but then
> we have the problem of not being able to dput() the dentry acquired by
> follow_up(), without risking it getting killed before we can enter RCU
> again (although I do wonder if it's possible for it to be killed, given
> that there is an active mountpoint on it that we hold a reference for?).
> 
> While we could probably do something like "defer the dput() until we next
> reach a mountpoint and can rcu_read_unlock()", or use lockref_put_return()
> and assert that the dentry must still have refcount > 0 since it's an
> in-use mountpoint, after a lot of thinking it seems to me the only clean
> solution is to have a mechanism of walking up mounts completely
> reference-free.  Maybe what we actually need is choose_mountpoint_rcu().
> 
> That function is private, so I guess a question for Al and other VFS
> people here is, can we potentially expose an equivalent publicly?
> (Perhaps it would only do effectively what __prepend_path in d_path.c
> does, and we can track the mount_lock seqcount outside.  Also the fact
> that throughout all this we have a valid reference to the leaf dentry we
> started from, to me should mean that the mount can't disappear under us
> anyway)

I have a very hard time warming up to the idea that you're doing
reference less path walk out of sight of the core VFS. That smells like
a massive landmine. It's barely correct now and it won't get better if
this code bitrots when Al or I massage other codepaths. And that happens
a lot.

We're exposing new infrastructure for the BPF LSM layer that is targeted
also to help Landlock. Use the helper exposed for them. It makes things
easier for all of us.

> 
> >
> >>  				/* Ignores hidden mount points. */
> >>  				goto jump_up;
> >>  			} else {
> >> +				path_put(&walker_path);
> >>  				/*
> >>  				 * Stops at the real root.  Denies access
> >>  				 * because not all layers have granted access.
> >> @@ -920,11 +925,11 @@ static bool is_access_to_paths_allowed(
> >>  			}
> >>  			break;
> >>  		}
> >> -		parent_dentry = dget_parent(walker_path.dentry);
> >> -		dput(walker_path.dentry);
> >> +		parent_dentry = walker_path.dentry->d_parent;
> >>  		walker_path.dentry = parent_dentry;
> >>  	}
> >> -	path_put(&walker_path);
> >> +
> >> +	rcu_read_unlock();
> >>
> >>  	if (!allowed_parent1) {
> >>  		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
> >> @@ -1045,12 +1050,11 @@ static bool collect_domain_accesses(
> >>  					       layer_masks_dom,
> >>  					       LANDLOCK_KEY_INODE);
> >>
> >> -	dget(dir);
> >> -	while (true) {
> >> -		struct dentry *parent_dentry;
> >> +	rcu_read_lock();
> >>
> >> +	while (true) {
> >>  		/* Gets all layers allowing all domain accesses. */
> >> -		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
> >> +		if (landlock_unmask_layers(find_rule_rcu(domain, dir), access_dom,
> >>  					   layer_masks_dom,
> >>  					   ARRAY_SIZE(*layer_masks_dom))) {
> >>  			/*
> >> @@ -1065,11 +1069,11 @@ static bool collect_domain_accesses(
> >>  		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
> >>  			break;
> >>
> >> -		parent_dentry = dget_parent(dir);
> >> -		dput(dir);
> >> -		dir = parent_dentry;
> >> +		dir = dir->d_parent;
> >>  	}
> >> -	dput(dir);
> >> +
> >> +	rcu_read_unlock();
> >> +
> >>  	return ret;
> >>  }
> >>
> >> --
> >> 2.49.0
> >>
> >>

