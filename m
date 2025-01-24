Return-Path: <linux-fsdevel+bounces-40044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD2A1B96F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2AA188CADB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D30155CBF;
	Fri, 24 Jan 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQZWwMYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6D130A73;
	Fri, 24 Jan 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733112; cv=none; b=sj5Ddz8XUkJdo/SI5usMqyijX74deV0iet3vrFyEIrFkt+weXzYadlKHayDFXIxS9s40kYikL4cAaf+7oky/AeM05/N8edhibsZX1O7vHWZcW9QOr37bHL/CqH7pcZe1+n0U7SoSY3OumlzP4GBma3ZU/ikju9Pn2LNIIXAqzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733112; c=relaxed/simple;
	bh=0Q3+ZDPqlVznH2DBnB+hCmTQTK5hnVFuCIBqHXWe9m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaXzMrfasInZ8MiQaP+5NWAODi8OxWb7v+knnMb6owQJLRxx+Rca3HsPchEAdzRL73+5LjnD2dOOrXfn1ASs3zN4o+oNnW8CXOeoXPTOnW4syyYZ2qDauqTuupJkSHoIElf3wdsU5MN6ikk7L2VC0DA8qJm/FP2RPz13KW41/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQZWwMYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEA4C4CED2;
	Fri, 24 Jan 2025 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737733112;
	bh=0Q3+ZDPqlVznH2DBnB+hCmTQTK5hnVFuCIBqHXWe9m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQZWwMYlCEGLWHIPE8yWeUZUgZC+DJEXUSLseR58B8f++aqPNhjf0aMYLgkmdQbRS
	 zIzEtI8scp9h5R85cNXzGtt5/LMHDm6MrzjT0k9m1XPymsBzikIn/IwraY1bGCbNJR
	 UQCpjuJcpwme819TOAtK1xHO6SLC8+lLNFmfPDOlqrFQMDAucslQSceVm4T+D8MgK5
	 oAkscLynL9+ZdYSuM9RfgCjT67NAoycLzHXnGFrEUHibW+iZPddvlSj1N2EAqtfbB5
	 vla9ZmGapnfwZcuQGi7S9edwCrqY1cgsoS9nHYvP3+QXgy8THMWEWhJW7Bz/sZ3Cbq
	 E4udTKgN3hlQA==
Date: Fri, 24 Jan 2025 16:38:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v4 4/4] vfs: add notifications for mount attribute change
Message-ID: <20250124-abklopfen-orbit-287ed6b59c61@brauner>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
 <20250123194108.1025273-5-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123194108.1025273-5-mszeredi@redhat.com>

On Thu, Jan 23, 2025 at 08:41:07PM +0100, Miklos Szeredi wrote:
> Notify when mount flags, propagation or idmap changes.
> 
> Just like attach and detach, no details are given in the notification, only
> the mount ID.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

I think this is a good next step but I would first go with the minimal
functionality of notifying about mount topology changes for v6.15.

Btw, if we notify in do_remount() on the mount that triggered
superblock reconfiguration then we also need to trigger in
vfs_cmd_reconfigure() aka fsconfig(FSCONFIG_CMD_RECONFIGURE) but the
mount that was used to change superblock options is only available in
fspick() currently. That would need to be handled.

But I think this patch makes more sense in follow-up releases.

>  fs/namespace.c                   | 27 +++++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify.c    |  2 +-
>  fs/notify/fanotify/fanotify.h    |  2 +-
>  fs/notify/fsnotify.c             |  2 +-
>  include/linux/fanotify.h         |  2 +-
>  include/linux/fsnotify.h         |  5 +++++
>  include/linux/fsnotify_backend.h |  5 ++++-
>  include/uapi/linux/fanotify.h    |  1 +
>  8 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 948348a37f6c..9b9b13665dce 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2807,6 +2807,9 @@ static int do_change_type(struct path *path, int ms_flags)
>  		change_mnt_propagation(m, type);
>  	unlock_mount_hash();
>  
> +	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
> +		fsnotify_mnt_change(m->mnt_ns, &m->mnt);
> +
>   out_unlock:
>  	namespace_unlock();
>  	return err;
> @@ -3089,6 +3092,12 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
>  	unlock_mount_hash();
>  	up_read(&sb->s_umount);
>  
> +	if (!ret) {
> +		down_read(&namespace_sem);
> +		fsnotify_mnt_change(mnt->mnt_ns, &mnt->mnt);
> +		up_read(&namespace_sem);
> +	}
> +
>  	mnt_warn_timestamp_expiry(path, &mnt->mnt);
>  
>  	return ret;
> @@ -3141,6 +3150,13 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
>  		up_write(&sb->s_umount);
>  	}
>  
> +	if (!err) {
> +		down_read(&namespace_sem);
> +		fsnotify_mnt_change(mnt->mnt_ns, &mnt->mnt);
> +		up_read(&namespace_sem);
> +	}
> +
> +
>  	mnt_warn_timestamp_expiry(path, &mnt->mnt);
>  
>  	put_fs_context(fc);
> @@ -4708,6 +4724,8 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  				return err;
>  			}
>  		}
> +	} else {
> +		down_read(&namespace_sem);
>  	}
>  
>  	err = -EINVAL;
> @@ -4743,10 +4761,19 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  out:
>  	unlock_mount_hash();
>  
> +	if (!err) {
> +		struct mount *m;
> +
> +		for (m = mnt; m; m = kattr->recurse ? next_mnt(m, mnt) : NULL)
> +			fsnotify_mnt_change(m->mnt_ns, &m->mnt);
> +	}
> +
>  	if (kattr->propagation) {
>  		if (err)
>  			cleanup_group_ids(mnt, NULL);
>  		namespace_unlock();
> +	} else {
> +		up_read(&namespace_sem);
>  	}
>  
>  	return err;
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index b1937f92f105..c7ddd145f3d8 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -934,7 +934,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index f1a7cbedc9e3..8d6289da06f1 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -471,7 +471,7 @@ static inline bool fanotify_is_error_event(u32 mask)
>  
>  static inline bool fanotify_is_mnt_event(u32 mask)
>  {
> -	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +	return mask & FANOTIFY_MOUNT_EVENTS;
>  }
>  
>  static inline const struct path *fanotify_event_path(struct fanotify_event *event)
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 2b2c3fd907c7..5872dd27172d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -660,7 +660,7 @@ static __init int fsnotify_init(void)
>  {
>  	int ret;
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
>  
>  	ret = init_srcu_struct(&fsnotify_mark_srcu);
>  	if (ret)
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index fc142be2542d..61e112d25303 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -100,7 +100,7 @@
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
>  #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
>  
> -#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
> +#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH | FAN_MNT_CHANGE)
>  
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index ea998551dd0d..ba3e05c69aaa 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -483,4 +483,9 @@ static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *
>  	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
>  }
>  
> +static inline void fsnotify_mnt_change(struct mnt_namespace *ns, struct vfsmount *mnt)
> +{
> +	fsnotify_mnt(FS_MNT_CHANGE, ns, mnt);
> +}
> +
>  #endif	/* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 6c3e3a4a7b10..54e01803e309 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -58,6 +58,8 @@
>  
>  #define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
>  #define FS_MNT_DETACH		0x02000000	/* Mount was detached */
> +#define FS_MNT_CHANGE		0x04000000	/* Mount was changed */
> +
>  #define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
>  
>  /*
> @@ -106,7 +108,8 @@
>  			     FS_EVENTS_POSS_ON_CHILD | \
>  			     FS_DELETE_SELF | FS_MOVE_SELF | \
>  			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
> -			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
> +			     FS_ERROR | \
> +			     FS_MNT_ATTACH | FS_MNT_DETACH | FS_MNT_CHANGE )
>  
>  /* Extra flags that may be reported with event or control handling of events */
>  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 69340e483ae7..256fc5755b45 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -27,6 +27,7 @@
>  #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
>  #define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
>  #define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
> +#define FAN_MNT_CHANGE		0x04000000	/* Mount was changed */
>  
>  #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
>  
> -- 
> 2.47.1
> 

