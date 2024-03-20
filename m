Return-Path: <linux-fsdevel+bounces-14875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF1D880DB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3901F2403B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A6481A0;
	Wed, 20 Mar 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l527pITV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B693481A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924471; cv=none; b=Dff8AnTEy81++JW52G9B+RHFNzymSHJpyxtZ2yR90UBzxmiJ1Et9ikTMkr9Umy4WXaUHFGrArLqX691cAm7SG4t9m932hMwA4UBVn2BZtP/uWgJuXXK0+B2BZ1aJlXpvj+XwKvjjmy+CBAfGQAw+V/3R4yJyR/1WeSUHEAHOSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924471; c=relaxed/simple;
	bh=ovbE1H/eafUl7JqqeQpmsR87BijtBtXTjBxJwG+RWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFyGqa2oMGh0mk9+ZM3hVAODqUCJ94ogkFG2sEPCgLhuPbUjOQtRID3x8BK/vUT/6NPfq1w9a6taeiFhq/4LvPkEzvZp1VMJmnOFW6OkVfqF0uWhTi6ScG4vvhTSIZwJSuPUql7UYuMvnoGADbF6abBTPLfmt7o5c/NSnWHPW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l527pITV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5402FC43390;
	Wed, 20 Mar 2024 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710924470;
	bh=ovbE1H/eafUl7JqqeQpmsR87BijtBtXTjBxJwG+RWpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l527pITVHtGBUWBa56xCjY7Y0qwKKmCVKX70VySfNyxt5fDuP4tARJGT5C35CeZl2
	 oEFQGhKksWF0KkGucA8dlYqN1v3BEOH98cMurIbBkDWLc2MVL/lHS7Lg/kAp6l0LZk
	 1SyG9PEW/9s1xY/w/mB8Y9THsoMfUxuGgO04+pUqQxGnr6XUYtA/cTXvjrle45NZJP
	 QogK39wI6MwnIIiClAkeI1MH5NqVYRgz9fP2ZrRq0WbusgMvIzmNKcl3ono7dE5aru
	 J4M2xhRMQFkaPO/uLe1/LJnVP7rR+FTsn+1JEcaJrJXdjeIVCx+zp0mFNoNAhQwCQb
	 xdtIW8+7BeKGw==
Date: Wed, 20 Mar 2024 09:47:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] fsnotify: lazy attach fsnotify_sb_info state to sb
Message-ID: <20240320-einblick-wimmeln-8fba6416c874@brauner>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <20240317184154.1200192-8-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240317184154.1200192-8-amir73il@gmail.com>

On Sun, Mar 17, 2024 at 08:41:51PM +0200, Amir Goldstein wrote:
> Define a container struct fsnotify_sb_info to hold per-sb state,
> including the reference to sb marks connector.
> 
> Allocate the fsnotify_sb_info state before attaching connector to any
> object on the sb and free it only when killing sb.
> 
> This state is going to be used for storing per priority watched objects
> counters.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c             | 16 +++++++++++++---
>  fs/notify/fsnotify.h             |  9 ++++++++-
>  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++++-
>  include/linux/fs.h               |  8 ++++----
>  include/linux/fsnotify_backend.h | 17 +++++++++++++++++
>  5 files changed, 73 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 503e7c75e777..fb3f36bc6ea9 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -89,11 +89,18 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  
>  void fsnotify_sb_delete(struct super_block *sb)
>  {
> +	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> +
> +	/* Were any marks ever added to any object on this sb? */
> +	if (!sbinfo)
> +		return;
> +
>  	fsnotify_unmount_inodes(sb);
>  	fsnotify_clear_marks_by_sb(sb);
>  	/* Wait for outstanding object references from connectors */
>  	wait_var_event(fsnotify_sb_watched_objects(sb),
>  		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
> +	kfree(sbinfo);
>  }
>  
>  /*
> @@ -489,6 +496,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  {
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	struct super_block *sb = fsnotify_data_sb(data, data_type);
> +	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
>  	struct fsnotify_iter_info iter_info = {};
>  	struct mount *mnt = NULL;
>  	struct inode *inode2 = NULL;
> @@ -525,7 +533,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	 * SRCU because we have no references to any objects and do not
>  	 * need SRCU to keep them "alive".
>  	 */
> -	if (!sb->s_fsnotify_marks &&
> +	if ((!sbinfo || !sbinfo->sb_marks) &&
>  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
>  	    (!inode || !inode->i_fsnotify_marks) &&
>  	    (!inode2 || !inode2->i_fsnotify_marks))
> @@ -552,8 +560,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  
>  	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
>  
> -	iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
> -		fsnotify_first_mark(&sb->s_fsnotify_marks);
> +	if (sbinfo) {
> +		iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
> +			fsnotify_first_mark(&sbinfo->sb_marks);
> +	}
>  	if (mnt) {
>  		iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
>  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 8b73ad45cc71..378f9ec6d64b 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -53,6 +53,13 @@ static inline struct super_block *fsnotify_connector_sb(
>  	return fsnotify_object_sb(conn->obj, conn->type);
>  }
>  
> +static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *sb)
> +{
> +	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
> +
> +	return sbinfo ? &sbinfo->sb_marks : NULL;
> +}
> +
>  /* destroy all events sitting in this groups notification queue */
>  extern void fsnotify_flush_notify(struct fsnotify_group *group);
>  
> @@ -78,7 +85,7 @@ static inline void fsnotify_clear_marks_by_mount(struct vfsmount *mnt)
>  /* run the list of all marks associated with sb and destroy them */
>  static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>  {
> -	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
> +	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
>  }
>  
>  /*
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 0b703f9e6344..db053e0e218d 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -105,7 +105,7 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj, int obj_type)
>  	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
>  		return &real_mount(obj)->mnt_fsnotify_marks;
>  	case FSNOTIFY_OBJ_TYPE_SB:
> -		return &((struct super_block *)obj)->s_fsnotify_marks;
> +		return fsnotify_sb_marks(obj);
>  	default:
>  		return NULL;
>  	}
> @@ -568,6 +568,26 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
>  	return -1;
>  }
>  
> +static int fsnotify_attach_info_to_sb(struct super_block *sb)
> +{
> +	struct fsnotify_sb_info *sbinfo;
> +
> +	/* sb info is freed on fsnotify_sb_delete() */
> +	sbinfo = kzalloc(sizeof(*sbinfo), GFP_KERNEL);
> +	if (!sbinfo)
> +		return -ENOMEM;
> +
> +	/*
> +	 * cmpxchg() provides the barrier so that callers of fsnotify_sb_info()
> +	 * will observe an initialized structure
> +	 */
> +	if (cmpxchg(&sb->s_fsnotify_info, NULL, sbinfo)) {
> +		/* Someone else created sbinfo for us */
> +		kfree(sbinfo);
> +	}

Alternatively, you could consider using wait_var_event() to let
concurrent attachers wait for s_fsnotify_info to be initialized using a
sentinel value to indicate that the caller should wait. But not sure if
it's worth it.

