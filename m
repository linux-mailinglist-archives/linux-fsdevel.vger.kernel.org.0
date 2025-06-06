Return-Path: <linux-fsdevel+bounces-50838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3BFAD0110
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CD7188BD2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6D287513;
	Fri,  6 Jun 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RgxR09BG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EC286405
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208266; cv=none; b=bwVktUMfRQSfZ/FIHK1K59CvKyRs2P+mcYhufmR9TEQ7Ji9PJr0x9dAjj++2BOd0DIvFERdiG/ojpl3t+K2PM8budpUtFON+9Bd6QZMatPIE75UVbFQlZrHfJgB4mY8klO/tstae+9nw8y16Rwg/HcdnasZongnkx6GXXdpcPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208266; c=relaxed/simple;
	bh=HjIlCtToBX0793ETmjSGkQ3kuPJXvm4Zz5or687MsQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGyf/8dXdHT4EPpiPlKXUpQqQfqrOlB4KRFNdkwsjbY6X6KfX/7J4wKlKo58JaeZzrf2rTS8bCLMrxO8ReElCIws/S2RxG9dFZ8vBQ9GqoEs0AS2EWSYFBQnY6B3p9duR+rP8BrZYNhviSLE+UB0MiMB497gkH2pysHG0Ncz5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RgxR09BG; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bDJXH3y9mz9Kx;
	Fri,  6 Jun 2025 13:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749208255;
	bh=GOulkok+KExfCKo8WPt2m9yynYFekTZ9q95jHQcC2jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgxR09BGQ3TSIRLg9SVZJ0OuHx5aAwd4k1EnNLr/ue6nMG8BGy54CtP4S9PsaJj4R
	 JWYTALIIv4FOMs0uOannuNbx8vZDFHs0o8c//quSYFHV7LKlMeV0g4ipq46jKbTGkV
	 Iq8SrXlPaN5CPev7ZJn6tJrIC4U7JEKYETNxFLp4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bDJXG4l6LzPSt;
	Fri,  6 Jun 2025 13:10:54 +0200 (CEST)
Date: Fri, 6 Jun 2025 13:10:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v2 bpf-next 1/4] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <20250606.ayaib4feaGae@digikod.net>
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603065920.3404510-2-song@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, Jun 02, 2025 at 11:59:17PM -0700, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
> 
> This will be used by landlock, and BPF LSM.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namei.c            | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  2 ++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..7d5bf2bb604f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1424,6 +1424,58 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
>  	return found;
>  }
>  
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
> + * The logic of path_walk_parent() is similar to follow_dotdot(), except
> + * that path_walk_parent() will continue walking for !path_connected case.
> + * This effectively means we are walking from disconnectedbind mount to the
> + * original mount point. If this behavior is not desired, the caller can
> + * add a check like:
> + *
> + *   if (path_walk_parent(&path) && !path_connected(path.mnt, path.dentry)
> + *           // continue walking
> + *   else
> + *           // stop walking
> + *
> + * Returns:
> + *  true  - if @path is updated to its parent.
> + *  false - if @path is already the root (real root or @root).
> + */
> +bool path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	if (path_equal(path, root))
> +		return false;
> +
> +	if (unlikely(path->dentry == path->mnt->mnt_root)) {
> +		struct path p;
> +
> +		if (!choose_mountpoint(real_mount(path->mnt), root, &p))
> +			return false;
> +		path_put(path);
> +		*path = p;
> +		return true;

It should not return here but continue with the following checks until
the potential dget_parent() call.

I sent a test to check this issue:
https://lore.kernel.org/r/20250606110811.211297-1-mic@digikod.net


> +	}
> +
> +	if (unlikely(IS_ROOT(path->dentry)))
> +		return false;
> +
> +	parent = dget_parent(path->dentry);
> +	dput(path->dentry);
> +	path->dentry = parent;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(path_walk_parent);
> +
>  /*
>   * Perform an automount
>   * - return -EISDIR to tell follow_managed() to stop and return the path we
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..cba5373ecf86 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
>  
> +bool path_walk_parent(struct path *path, const struct path *root);
> +
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> -- 
> 2.47.1
> 
> 

