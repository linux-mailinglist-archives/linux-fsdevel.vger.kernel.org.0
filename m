Return-Path: <linux-fsdevel+bounces-52758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBB6AE64B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645D74C13AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E3296160;
	Tue, 24 Jun 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDNdCMeX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xr2OQc0R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDNdCMeX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xr2OQc0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0226A1BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767502; cv=none; b=SV6O8yTBqpJAeJ10B9FEsMKGLRqROWP335xzXH0iDkenbyRIZTIegeWd78K5nzP5GHTTOnM0QvYHI0raj+2VutH8cTiBkJ4U98IBwXsCuFFOaGrmQVLt+znXW86u60j+SyCOV1WVUw1dEeVXQw0HAEB7lszKjywVVQX9uS7O0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767502; c=relaxed/simple;
	bh=DndF2H368R7JPID8W7hu9MaxsrUk7MRsMn8Na9FB5fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVoT61hsucBMNhYuR8fnYEBHH3P2E3/DTaQNgnjAQMlOn8t02zr4OWx+PrUYC3+xltEOWpZ4OxlwhHTa7fPm5JbKs+vt6jSH6YwhCxfG1Mbrsebf0sp3ZJRW8pogwssZBeSfv7xRYxJ3+cypd8rho8pZg9W60Nc+EtmvEpsZQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDNdCMeX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xr2OQc0R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDNdCMeX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xr2OQc0R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9988421196;
	Tue, 24 Jun 2025 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750767498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA3tRkj5bq2qJ1oYxd2kuL6Q5137FwnQ2VWJigyeHsA=;
	b=ZDNdCMeXK/1oA+bef4O2b+2HxklGaRVCsy2kSfRa5ucgAySjN7S6x7HNrNC4pMMuoljttS
	ACQdOe9mF1WcJMmAU9ft37YLfrQbRj03sN/lk2xGSkDrbAZF8GfnGqHJdKJ8rtF8+wmJ/3
	jglvkWRB1dEPMUJ5VSn1aVDyJyd6fg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750767498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA3tRkj5bq2qJ1oYxd2kuL6Q5137FwnQ2VWJigyeHsA=;
	b=xr2OQc0RWNXx0QTWhShMnXJHZMJB68lXh2PptWgP3oFy3q1pxfl8F4KFCEWKM2pLltBm9t
	GQqvjJuzdhVACiAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750767498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA3tRkj5bq2qJ1oYxd2kuL6Q5137FwnQ2VWJigyeHsA=;
	b=ZDNdCMeXK/1oA+bef4O2b+2HxklGaRVCsy2kSfRa5ucgAySjN7S6x7HNrNC4pMMuoljttS
	ACQdOe9mF1WcJMmAU9ft37YLfrQbRj03sN/lk2xGSkDrbAZF8GfnGqHJdKJ8rtF8+wmJ/3
	jglvkWRB1dEPMUJ5VSn1aVDyJyd6fg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750767498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA3tRkj5bq2qJ1oYxd2kuL6Q5137FwnQ2VWJigyeHsA=;
	b=xr2OQc0RWNXx0QTWhShMnXJHZMJB68lXh2PptWgP3oFy3q1pxfl8F4KFCEWKM2pLltBm9t
	GQqvjJuzdhVACiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8906813A24;
	Tue, 24 Jun 2025 12:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5CpxIYqXWmihUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 12:18:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C73FDA0A03; Tue, 24 Jun 2025 14:18:17 +0200 (CEST)
Date: Tue, 24 Jun 2025 14:18:17 +0200
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, m@maowtm.org, neil@brown.name
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <htn4tupeslsrhyzrqt7pi34tye7tpp7amziiwflfpluj3u2nhs@e2axcpfuucv5>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617061116.3681325-2-song@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,meta.com,kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com,maowtm.org,brown.name];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 16-06-25 23:11:12, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
> 
> This will be used by landlock, and BPF LSM.
> 
> Suggested-by: Neil Brown <neil@brown.name>
> Signed-off-by: Song Liu <song@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One note below:

> -static struct dentry *follow_dotdot(struct nameidata *nd)
> +/**
> + * __path_walk_parent - Find the parent of the given struct path
> + * @path  - The struct path to start from
> + * @root  - A struct path which serves as a boundary not to be crosses.
> + *        - If @root is zero'ed, walk all the way to global root.
> + * @flags - Some LOOKUP_ flags.
> + *
> + * Find and return the dentry for the parent of the given path
> + * (mount/dentry). If the given path is the root of a mounted tree, it
> + * is first updated to the mount point on which that tree is mounted.
> + *
> + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new
> + * mount, the error EXDEV is returned.
> + *
> + * If no parent can be found, either because the tree is not mounted or
> + * because the @path matches the @root, then @path->dentry is returned
> + * unless @flags contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
> + *
> + * Returns: either an ERR_PTR() or the chosen parent which will have had
> + * the refcount incremented.
> + */

The behavior with LOOKUP_NO_XDEV is kind of odd (not your fault) and
interestingly I wasn't able to find a place that would depend on the path
being updated in that case. So either I'm missing some subtle detail (quite
possible) or we can clean that up in the future.

								Honza

> +static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
>  {
> -	struct dentry *parent;
> -
> -	if (path_equal(&nd->path, &nd->root))
> +	if (path_equal(path, root))
>  		goto in_root;
> -	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
> -		struct path path;
> +	if (unlikely(path->dentry == path->mnt->mnt_root)) {
> +		struct path new_path;
>  
> -		if (!choose_mountpoint(real_mount(nd->path.mnt),
> -				       &nd->root, &path))
> +		if (!choose_mountpoint(real_mount(path->mnt),
> +				       root, &new_path))
>  			goto in_root;
> -		path_put(&nd->path);
> -		nd->path = path;
> -		nd->inode = path.dentry->d_inode;
> -		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
> +		path_put(path);
> +		*path = new_path;
> +		if (unlikely(flags & LOOKUP_NO_XDEV))
>  			return ERR_PTR(-EXDEV);
>  	}
>  	/* rare case of legitimate dget_parent()... */
> -	parent = dget_parent(nd->path.dentry);
> +	return dget_parent(path->dentry);
> +
> +in_root:
> +	if (unlikely(flags & LOOKUP_BENEATH))
> +		return ERR_PTR(-EXDEV);
> +	return dget(path->dentry);
> +}
> +
> +/**
> + * path_walk_parent - Walk to the parent of path
> + * @path: input and output path.
> + * @root: root of the path walk, do not go beyond this root. If @root is
> + *        zero'ed, walk all the way to real root.
> + *
> + * Given a path, find the parent path. Replace @path with the parent path.
> + * If we were already at the real root or a disconnected root, @path is
> + * not changed.
> + *
> + * Returns:
> + *  0  - if @path is updated to its parent.
> + *  <0 - if @path is already the root (real root or @root).
> + */
> +int path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	parent = __path_walk_parent(path, root, LOOKUP_BENEATH);
> +
> +	if (IS_ERR(parent))
> +		return PTR_ERR(parent);
> +
> +	if (parent == path->dentry) {
> +		dput(parent);
> +		return -ENOENT;
> +	}
> +	dput(path->dentry);
> +	path->dentry = parent;
> +	return 0;
> +}
> +
> +static struct dentry *follow_dotdot(struct nameidata *nd)
> +{
> +	struct dentry *parent = __path_walk_parent(&nd->path, &nd->root, nd->flags);
> +
> +	if (IS_ERR(parent))
> +		return parent;
>  	if (unlikely(!path_connected(nd->path.mnt, parent))) {
>  		dput(parent);
>  		return ERR_PTR(-ENOENT);
>  	}
> +	nd->inode = nd->path.dentry->d_inode;
>  	return parent;
> -
> -in_root:
> -	if (unlikely(nd->flags & LOOKUP_BENEATH))
> -		return ERR_PTR(-EXDEV);
> -	return dget(nd->path.dentry);
>  }
>  
>  static const char *handle_dots(struct nameidata *nd, int type)
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..ca68fa4089e0 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
>  
> +int path_walk_parent(struct path *path, const struct path *root);
> +
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> -- 
> 2.47.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

