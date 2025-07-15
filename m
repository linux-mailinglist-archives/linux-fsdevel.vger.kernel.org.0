Return-Path: <linux-fsdevel+bounces-55022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5ECB0665F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0843BE1FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6AF2BE7B5;
	Tue, 15 Jul 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oKanVOmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CF23817A
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605907; cv=none; b=MPwvtbRm6NCofVCAETW4os09hIDm5H2aJZ/Al8H5awUjBFLq41cxpOpy6UhA4InS8k+4pLPhi1JeL7V89YHBVg0zddUt8TsKi/U9Fid1EAl/PhUnFs58t1QyVVxrWPWsn3/yeoovzeC2Uy9Fc8dOkS4sR/SJEmbrYZRcDuXEeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605907; c=relaxed/simple;
	bh=9Q21YQWM/kqUcQXIMbPHLgtp3QZpOuCqUhTrJ3iQKJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGYxBvThSCwq0ocsZTHC96BzyAxLE9lVsSrhAdKNCeyLadPmOQ5naw1tVPyo7I9xJmmLyUVpp19B//Wrr8fd9Z9BIDQPuWbpr9ppQ8Xvsas4hdQ2J5b08jRRYZ+ZmcqeyyRbBcOvTRejHZca9AqnTSc3SkQS1r8/eEXKTckWkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oKanVOmf; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bhSwm2nF6z3X5;
	Tue, 15 Jul 2025 20:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752605544;
	bh=UeOe+dfXu3Qf3uZbhoIuxiYMztJEpKfTjUIwqTSxVP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKanVOmf30YXMgXtUeGie7ocC5Bnx9ljrxvs2hNkWvn9cy0P+YNX+Jp924V9AWyvi
	 yBwYCVDoPElgld4XY6ryB9p6PgvDemvKI0EmDnYVsvkevSssQAlmSJwJbfAQETtzUi
	 GYd/1K4QPkAnWNG8fxR28sIcoL7y/wHxgti6VEnM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bhSwl48b7zxkK;
	Tue, 15 Jul 2025 20:52:23 +0200 (CEST)
Date: Tue, 15 Jul 2025 20:52:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, 
	Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] landlock: Fix handling of disconnected directories
Message-ID: <20250715.Alielah5eeh7@digikod.net>
References: <20250711191938.2007175-1-mic@digikod.net>
 <20250711191938.2007175-2-mic@digikod.net>
 <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jul 14, 2025 at 01:39:12PM +0100, Tingmao Wang wrote:
> On 7/11/25 20:19, Mickaël Salaün wrote:
> > [...]
> > @@ -800,6 +802,8 @@ static bool is_access_to_paths_allowed(
> >  		access_masked_parent1 = access_masked_parent2 =
> >  			landlock_union_access_masks(domain).fs;
> >  		is_dom_check = true;
> > +		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
> > +		       sizeof(_layer_masks_parent2_bkp));
> >  	} else {
> >  		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
> >  			return false;
> > @@ -807,6 +811,8 @@ static bool is_access_to_paths_allowed(
> >  		access_masked_parent1 = access_request_parent1;
> >  		access_masked_parent2 = access_request_parent2;
> >  		is_dom_check = false;
> > +		memcpy(&_layer_masks_parent1_bkp, layer_masks_parent1,
> > +		       sizeof(_layer_masks_parent1_bkp));
> 
> Is this memcpy meant to be in this else branch?  If parent2 is set, we
> will leave _layer_masks_parent1_bkp uninitialized right?
> 
> >  	}
> >  
> >  	if (unlikely(dentry_child1)) {
> > @@ -858,6 +864,14 @@ static bool is_access_to_paths_allowed(
> >  				     child1_is_directory, layer_masks_parent2,
> >  				     layer_masks_child2,
> >  				     child2_is_directory))) {
> > +			/*
> > +			 * Rewinds walk for disconnected directories before any other state
> > +			 * change.
> > +			 */
> > +			if (unlikely(!path_connected(walker_path.mnt,
> > +						     walker_path.dentry)))
> > +				goto reset_to_mount_root;
> > +
> >  			/*
> >  			 * Now, downgrades the remaining checks from domain
> >  			 * handled accesses to requested accesses.
> 
> I think reasoning about how the domain check interacts with
> reset_to_mount_root was very tricky, and I wonder if you could add some
> more comments explaining the various cases?

Yes, it's tricky, I'll add more comments.

> For example, one fact which
> took me a while to realize is that for renames, this function will never
> see the bottom-most child being disconnected with its mount, since we
> start walking from the mountpoint, and so it is really only handling the
> case of the mountpoint itself being disconnected.
> 
> Also, it was not very clear to me whether it would always be correct to
> reset to the backed up layer mask, if the backup was taken when we were
> still in domain check mode (and thus have the domain handled access bits
> set, not just the requested ones), but we then exit domain check mode, and
> before reaching the next mountpoint we suddenly found out the current path
> is disconnected, and thus resetting to the backup (but without going back
> into domain check mode, since we don't reset that).
> 
> Because of the !path_connected check within the if(is_dom_check ...)
> branch itself, the above situation would only happen in some race
> condition tho.

That's right.  There are potential race conditions after each
!path_connected() checks, but AFAICT it doesn't matter at that point
because the access state for the current dentry is valid.  This dentry
could be renamed after this check, but we always check with another
!path_connected() or mnt_root after that.  This means that we could have
partial access rights while a path is being renamed, but they should all
be consistent at time of checks, right?

> 
> I also wonder if there's another potential issue (although I've not tested
> it), where if the file being renamed itself is disconnected from its
> mountpoint, when we get to is_access_to_paths_allowed, the passed in
> layer_masks_parent1 would be empty (which is correct), but when we do the
> no_more_access check, we're still using layer_masks_child{1,2} which has
> access bits set according to rules attached directly to the child. I think
> technically if the child is disconnected from its mount, we're supposed to
> ignore any access rules it has on itself as well?  And so this
> no_more_access check would be a bit inconsistent, I think.

The layer_masks_child* accesses are only used to check if the moved file
(or directory) would not get more access rights on the destination
(excluding those directly moved with the child).  Once we know the move
would be safe, we check if the move is allowed according to the parent
source and the parent destination (but the child access rights are
ignored).

It should be tested with
layout4_disconnected_leafs.s1d41_s1d42_disconnected

Thanks for the review!

