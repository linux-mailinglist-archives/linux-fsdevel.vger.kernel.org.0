Return-Path: <linux-fsdevel+bounces-50634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9DACE2D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F194B16F523
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D31ACEDA;
	Wed,  4 Jun 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kTwjp75w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0C141987
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057337; cv=none; b=lHYwoF4rB2wkEQWe3YJ0LY6NrGaqj94XalqB896PYorg1Smy2SoXBi4vkyuIooO6T/i4KaLwmFn+vXW8RKlkZQxw3xM4OYM+GO4yf9APJI2f6iblGyGiy5FP6+vBC9QXU4IZ5ayQvwTfs74fjsgBC+dGYvpi9w1PDBHZwe7IDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057337; c=relaxed/simple;
	bh=cIQqfZXoKhydcbMbrv4+UkJcjH1YVXRvwaPw2/nCtrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igyBOSqFtlAps9TIB+O9kT1skDLCMKF3OUjGquK1lMzmx2z+7gOvN1nw1Df1/1kpzoE7QLFfjApuWMoUiFlXkyMpqS/M+cwUwr2bJyPnFWP3/t/hJ1jNydPqA9aFF7M8e6AYMMQEqRFuSZE6yCoEpDP6iyVNAjgmlILU0rKqKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kTwjp75w; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bCDjr15M2zRcP;
	Wed,  4 Jun 2025 19:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749057328;
	bh=ASS5FXs8+B7pWw838kkGFm99zbv7aCt+80g4N+1hjJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTwjp75wMXeEnSafPGtu7mO15XFGX/XAGgrqxxyzLphpcMD2QbbetqNUUq9leykte
	 GRdkCE8ANBkCpPtJ4Y30i68KzitEqmu0qfz3LvFJ4Lt95a1C3oXDvAugSeai/u2TGe
	 A5uN7gePUaDpwCYeCoCMc9c80qJFb4unWPrRGu+0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bCDjq36jkzkCp;
	Wed,  4 Jun 2025 19:15:27 +0200 (CEST)
Date: Wed, 4 Jun 2025 19:15:26 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] landlock: walk parent dir without taking
 references
Message-ID: <20250604.ciecheo7EeNg@digikod.net>
References: <cover.1748997840.git.m@maowtm.org>
 <8cf726883f6dae564559e4aacdb2c09bf532fcc5.1748997840.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cf726883f6dae564559e4aacdb2c09bf532fcc5.1748997840.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, Jun 04, 2025 at 01:45:43AM +0100, Tingmao Wang wrote:
> This commit replaces dget_parent with a direct read of d_parent. By
> holding rcu read lock we should be safe in terms of not reading freed
> memory, but this is still problematic due to move+unlink, as will be shown
> with the test in the next commit.
> 
> Note that follow_up is still used when walking up a mountpoint.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/fs.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..923737412cfa 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -361,7 +361,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>   * Returns NULL if no rule is found or if @dentry is negative.
>   */
>  static const struct landlock_rule *
> -find_rule(const struct landlock_ruleset *const domain,
> +find_rule_rcu(const struct landlock_ruleset *const domain,
>  	  const struct dentry *const dentry)
>  {
>  	const struct landlock_rule *rule;
> @@ -375,10 +375,10 @@ find_rule(const struct landlock_ruleset *const domain,
>  		return NULL;
>  
>  	inode = d_backing_inode(dentry);
> -	rcu_read_lock();
> +	if (unlikely(!inode))
> +		return NULL;
>  	id.key.object = rcu_dereference(landlock_inode(inode)->object);
>  	rule = landlock_find_rule(domain, id);
> -	rcu_read_unlock();
>  	return rule;
>  }
>  
> @@ -809,9 +809,11 @@ static bool is_access_to_paths_allowed(
>  		is_dom_check = false;
>  	}
>  
> +	rcu_read_lock();
> +
>  	if (unlikely(dentry_child1)) {
>  		landlock_unmask_layers(
> -			find_rule(domain, dentry_child1),
> +			find_rule_rcu(domain, dentry_child1),
>  			landlock_init_layer_masks(
>  				domain, LANDLOCK_MASK_ACCESS_FS,
>  				&_layer_masks_child1, LANDLOCK_KEY_INODE),
> @@ -821,7 +823,7 @@ static bool is_access_to_paths_allowed(
>  	}
>  	if (unlikely(dentry_child2)) {
>  		landlock_unmask_layers(
> -			find_rule(domain, dentry_child2),
> +			find_rule_rcu(domain, dentry_child2),
>  			landlock_init_layer_masks(
>  				domain, LANDLOCK_MASK_ACCESS_FS,
>  				&_layer_masks_child2, LANDLOCK_KEY_INODE),
> @@ -831,7 +833,6 @@ static bool is_access_to_paths_allowed(
>  	}
>  
>  	walker_path = *path;
> -	path_get(&walker_path);
>  	/*
>  	 * We need to walk through all the hierarchy to not miss any relevant
>  	 * restriction.
> @@ -880,7 +881,7 @@ static bool is_access_to_paths_allowed(
>  				break;
>  		}
>  
> -		rule = find_rule(domain, walker_path.dentry);
> +		rule = find_rule_rcu(domain, walker_path.dentry);
>  		allowed_parent1 = allowed_parent1 ||
>  				  landlock_unmask_layers(
>  					  rule, access_masked_parent1,
> @@ -897,10 +898,14 @@ static bool is_access_to_paths_allowed(
>  			break;
>  jump_up:
>  		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> +			/* follow_up gets the parent and puts the passed in path */
> +			path_get(&walker_path);
>  			if (follow_up(&walker_path)) {
> +				path_put(&walker_path);

path_put() cannot be safely called in a RCU read-side critical section
because it can free memory which can sleep, and also because it can wait
for a lock.  However, we can call rcu_read_unlock() before and
rcu_read_lock() after (if we hold a reference).

>  				/* Ignores hidden mount points. */
>  				goto jump_up;
>  			} else {
> +				path_put(&walker_path);
>  				/*
>  				 * Stops at the real root.  Denies access
>  				 * because not all layers have granted access.
> @@ -920,11 +925,11 @@ static bool is_access_to_paths_allowed(
>  			}
>  			break;
>  		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> +		parent_dentry = walker_path.dentry->d_parent;
>  		walker_path.dentry = parent_dentry;
>  	}
> -	path_put(&walker_path);
> +
> +	rcu_read_unlock();
>  
>  	if (!allowed_parent1) {
>  		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
> @@ -1045,12 +1050,11 @@ static bool collect_domain_accesses(
>  					       layer_masks_dom,
>  					       LANDLOCK_KEY_INODE);
>  
> -	dget(dir);
> -	while (true) {
> -		struct dentry *parent_dentry;
> +	rcu_read_lock();
>  
> +	while (true) {
>  		/* Gets all layers allowing all domain accesses. */
> -		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
> +		if (landlock_unmask_layers(find_rule_rcu(domain, dir), access_dom,
>  					   layer_masks_dom,
>  					   ARRAY_SIZE(*layer_masks_dom))) {
>  			/*
> @@ -1065,11 +1069,11 @@ static bool collect_domain_accesses(
>  		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
>  			break;
>  
> -		parent_dentry = dget_parent(dir);
> -		dput(dir);
> -		dir = parent_dentry;
> +		dir = dir->d_parent;
>  	}
> -	dput(dir);
> +
> +	rcu_read_unlock();
> +
>  	return ret;
>  }
>  
> -- 
> 2.49.0
> 
> 

