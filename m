Return-Path: <linux-fsdevel+bounces-36131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BB9DC170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B719283A42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB516176228;
	Fri, 29 Nov 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg7W+sQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945E14F135
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872360; cv=none; b=QfIrHxPzCilgr5WDPoAzzQ7ccVkvjaIWVzmtGtTGmjXW/JWng5uq6BMlpHnq7sJaK3urY489YVv9wdhG4q+boY0TL5a0zDvuXk9Ka8xN7b/+/lZou+AT8ZLDiiLWHw+FhaC6JCXL5inR53BmZVX6C/mgqi1hjBEcFnleTWjP/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872360; c=relaxed/simple;
	bh=8IovsWKkNs/rD6qisGy195EDlaChwA5AtSRo/P05NfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq7htzA7VV0zQCZ0zIx/5LKFerxMDQCki52fdNxebp6H6fc88mQrbMc2GjtG24U2k2EZnaGQlFXJLRmpBHo1BYksYHI5Cw3WM1P+Hr0jhW2Ra1LsQyiP/HtblOjN5yv5lk3Eru2xIO9vD7r7F5yZNJow5scScHPmZVrGjS3BN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg7W+sQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35C0C4CECF;
	Fri, 29 Nov 2024 09:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872358;
	bh=8IovsWKkNs/rD6qisGy195EDlaChwA5AtSRo/P05NfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kg7W+sQ0JUH5Mns4Zy/WcM/EDu2PbmDZLH7ZPHfS0PXwn5rAogHCHyhfu7kX7WRmz
	 aqFTC8iCyXgbeNKXlwM673CvMiPXMREApxXF0PNAbIOqv89jr5I1H323U69xxnLFsd
	 pMSiwX1hKa/EPBjqLpjGcWHTl2Ljv4QX53LU3uNq2S9mvryJV6LHU2FlqexlrGGKa7
	 we6qoRDq6hP+evrX0zqG0wdFHzUdMh4gSFNg/pa5QEe0DRfsPgFqSvm6hdvNzoYi98
	 L0iFmyO0rip0uohmWJnj0YVNe84Z38yTlgnJStGbMSa23E4qw67K6j/WYYMTixii6N
	 ZwVvBEapxbxCg==
Date: Fri, 29 Nov 2024 10:25:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
Message-ID: <20241129-laken-gefunden-7c4795340279@brauner>
References: <20241128144002.42121-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128144002.42121-1-mszeredi@redhat.com>

On Thu, Nov 28, 2024 at 03:39:59PM +0100, Miklos Szeredi wrote:
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
> 
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
> 
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
> these fields identifying the affected mounts:
> 
>   __u64 mnt_id    - the attached or detached mount
>   __u64 parent_id - where the mount was attached to or detached from
> 
> The mountpoint object (file or directory) is also contained in the event
> either as an FD or a FID.
> 
> Adding marks with FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM both work.
> 
> FAN_MARK_INODE doesn't, not sure why.  I think it might make sense to make
> it work, i.e. allow watching a single mountpoint.
> 
> Prior to this patch mount namespace changes could be monitored by polling
> /proc/self/mountinfo, which did not convey any information about what
> changed.
> 
> To monitor an entire mount namespace with this new interface, watches need
> to be added to all existing mounts.  This can be done by performing
> listmount()/statmount() recursively at startup and when a new mount is
> added.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/namespace.c                     | 23 +++++++++++++++++
>  fs/notify/fanotify/fanotify.c      | 10 +++++++-
>  fs/notify/fanotify/fanotify.h      |  7 +++++
>  fs/notify/fanotify/fanotify_user.c | 41 ++++++++++++++++++++++++++++++
>  fs/notify/fsnotify.c               |  2 +-
>  include/linux/fanotify.h           |  7 +++--
>  include/linux/fsnotify.h           | 18 +++++++++++++
>  include/linux/fsnotify_backend.h   | 30 +++++++++++++++++++++-
>  include/uapi/linux/fanotify.h      |  9 +++++++
>  9 files changed, 142 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6b0a17487d0f..7724c78df945 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -988,12 +988,24 @@ static void __touch_mnt_namespace(struct mnt_namespace *ns)
>  	}
>  }
>  
> +static inline void __fsnotify_mnt_detach(struct mount *mnt)
> +{
> +	struct path mountpoint = {
> +		.mnt = &mnt->mnt_parent->mnt,
> +		.dentry = mnt->mnt_mountpoint,
> +	};
> +	fsnotify_mnt_detach(&mountpoint, &mnt->mnt);
> +}
> +
>  /*
>   * vfsmount lock must be held for write
>   */
>  static struct mountpoint *unhash_mnt(struct mount *mnt)
>  {
>  	struct mountpoint *mp;
> +
> +	__fsnotify_mnt_detach(mnt);
> +
>  	mnt->mnt_parent = mnt;
>  	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
>  	list_del_init(&mnt->mnt_child);
> @@ -1027,6 +1039,15 @@ void mnt_set_mountpoint(struct mount *mnt,
>  	hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
>  }
>  
> +static inline void __fsnotify_mnt_attach(struct mount *mnt)
> +{
> +	struct path mountpoint = {
> +		.mnt = &mnt->mnt_parent->mnt,
> +		.dentry = mnt->mnt_mountpoint,
> +	};
> +	fsnotify_mnt_attach(&mountpoint, &mnt->mnt);
> +}
> +
>  /**
>   * mnt_set_mountpoint_beneath - mount a mount beneath another one
>   *
> @@ -1059,6 +1080,8 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
>  	hlist_add_head_rcu(&mnt->mnt_hash,
>  			   m_hash(&parent->mnt, mnt->mnt_mountpoint));
>  	list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
> +
> +	__fsnotify_mnt_attach(mnt);
>  }

It was already mentioned in the thread but unhash_mnt() and
__attach_mnt() are called under lock_mnt_hash() which is problematic.

I do like that we seem to be getting away without a lot of aweful custom
machinery in the mount specific code. So that seems promising to me.

You shouldn't need to call that under lock_mount_hash(). Calling that
under namespace_sem should be perfectly fine as that needs to be held to
add or remove mounts into any namespace anyway.

One possibility would be to use the real_mount(mnt)->mnt_fsnotify_marks
struct and add a list_head or similar in there and link all new mounts
in attach_recursive_mnt() to a list. So basically:

diff --git a/fs/namespace.c b/fs/namespace.c
index dc789f2751d7..b4a150f76bf6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2475,6 +2475,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 {
        struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
        HLIST_HEAD(tree_list);
+       HLIST_HEAD(fsnotify_list);
        struct mnt_namespace *ns = top_mnt->mnt_ns;
        struct mountpoint *smp;
        struct mount *child, *dest_mnt, *p;
@@ -2508,6 +2509,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
                        goto out;
                err = propagate_mnt(dest_mnt, dest_mp, source_mnt, &tree_list);
        }
+
+       // Add all mounts from tree_list to fsnotify_list.
+
        lock_mount_hash();
        if (err)
                goto out_cleanup_ids;
@@ -2539,6 +2543,8 @@ static int attach_recursive_mnt(struct mount *source_mnt,
                commit_tree(source_mnt);
        }

+       // Now add "main" mount to the beginning of the list.
+
        hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
                struct mount *q;
                hlist_del_init(&child->mnt_hash);
@@ -2555,6 +2561,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
        put_mountpoint(smp);
        unlock_mount_hash();

+       // We know that namespace_sem is held, walk through fsnotify_list and
+       // send mount notifications.
+
        return 0;

>  /**
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 24c7c5df4998..9a93c9b58bd4 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -16,6 +16,7 @@
>  #include <linux/stringhash.h>
>  
>  #include "fanotify.h"
> +#include "../../mount.h"
>  
>  static bool fanotify_path_equal(const struct path *p1, const struct path *p2)
>  {
> @@ -715,6 +716,9 @@ static struct fanotify_event *fanotify_alloc_event(
>  					      fid_mode);
>  	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
>  	const struct path *path = fsnotify_data_path(data, data_type);
> +	struct vfsmount *mnt = fsnotify_data_mnt(data, data_type);
> +	u64 mnt_id = mnt ? real_mount(mnt)->mnt_id_unique : 0;
> +	u64 parent_id = path ? real_mount(path->mnt)->mnt_id_unique : 0;
>  	struct mem_cgroup *old_memcg;
>  	struct dentry *moved = NULL;
>  	struct inode *child = NULL;
> @@ -824,8 +828,12 @@ static struct fanotify_event *fanotify_alloc_event(
>  
>  	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
>  	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
> +	hash ^= hash_64(mnt_id, FANOTIFY_EVENT_HASH_BITS);
> +	hash ^= hash_64(parent_id, FANOTIFY_EVENT_HASH_BITS);
>  	fanotify_init_event(event, hash, mask);
>  	event->pid = pid;
> +	event->mnt_id = mnt_id;
> +	event->parent_id = parent_id;
>  
>  out:
>  	set_active_memcg(old_memcg);
> @@ -910,7 +918,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index e5ab33cae6a7..71cc9cb2335a 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -261,6 +261,8 @@ struct fanotify_event {
>  		unsigned int hash : FANOTIFY_EVENT_HASH_BITS;
>  	};
>  	struct pid *pid;
> +	u64 mnt_id;
> +	u64 parent_id;
>  };
>  
>  static inline void fanotify_init_event(struct fanotify_event *event,
> @@ -456,6 +458,11 @@ static inline bool fanotify_is_error_event(u32 mask)
>  	return mask & FAN_FS_ERROR;
>  }
>  
> +static inline bool fanotify_is_mnt_event(u32 mask)
> +{
> +	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +}
> +
>  static inline const struct path *fanotify_event_path(struct fanotify_event *event)
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2d85c71717d6..adf19e1a10bd 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -122,6 +122,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
>  	sizeof(struct fanotify_event_info_pidfd)
>  #define FANOTIFY_ERROR_INFO_LEN \
>  	(sizeof(struct fanotify_event_info_error))
> +#define FANOTIFY_MNT_INFO_LEN \
> +	(sizeof(struct fanotify_event_info_mnt))
>  
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -159,6 +161,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  	int fh_len;
>  	int dot_len = 0;
>  
> +	if (fanotify_is_mnt_event(event->mask))
> +		event_len += FANOTIFY_MNT_INFO_LEN;
> +
>  	if (!info_mode)
>  		return event_len;
>  
> @@ -380,6 +385,26 @@ static int process_access_response(struct fsnotify_group *group,
>  	return -ENOENT;
>  }
>  
> +static size_t copy_mnt_info_to_user(struct fanotify_event *event,
> +				    char __user *buf, int count)
> +{
> +	struct fanotify_event_info_mnt info = { };
> +
> +	info.hdr.info_type = FAN_EVENT_INFO_TYPE_MNT;
> +	info.hdr.len = FANOTIFY_MNT_INFO_LEN;
> +
> +	if (WARN_ON(count < info.hdr.len))
> +		return -EFAULT;
> +
> +	info.mnt_id = event->mnt_id;
> +	info.parent_id = event->parent_id;
> +
> +	if (copy_to_user(buf, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return info.hdr.len;
> +}
> +
>  static size_t copy_error_info_to_user(struct fanotify_event *event,
>  				      char __user *buf, int count)
>  {
> @@ -656,6 +681,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
>  	struct file *f = NULL, *pidfd_file = NULL;
>  	int ret, pidfd = -ESRCH, fd = -EBADF;
> +	int total_bytes = 0;
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> @@ -755,14 +781,29 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  
>  	buf += FAN_EVENT_METADATA_LEN;
>  	count -= FAN_EVENT_METADATA_LEN;
> +	total_bytes += FAN_EVENT_METADATA_LEN;
>  
>  	if (info_mode) {
>  		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
>  						buf, count);
>  		if (ret < 0)
>  			goto out_close_fd;
> +
> +		buf += ret;
> +		count -= ret;
> +		total_bytes += ret;
> +	}
> +
> +	if (fanotify_is_mnt_event(event->mask)) {
> +		ret = copy_mnt_info_to_user(event, buf, count);
> +		if (ret < 0)
> +			goto out_close_fd;
> +
> +		total_bytes += ret;
>  	}
>  
> +	WARN_ON(metadata.event_len != total_bytes);
> +
>  	if (f)
>  		fd_install(fd, f);
>  
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index f976949d2634..1d5831b127e6 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -627,7 +627,7 @@ static __init int fsnotify_init(void)
>  {
>  	int ret;
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
>  
>  	ret = init_srcu_struct(&fsnotify_mark_srcu);
>  	if (ret)
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..84e6f81bdb1b 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -90,7 +90,7 @@
>  				 FAN_RENAME)
>  
>  /* Events that can be reported with event->fd */
> -#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
> +#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS | FANOTIFY_MOUNT_EVENTS)
>  
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
>  #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
> @@ -99,10 +99,13 @@
>  /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
>  #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
>  
> +#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
>  				 FANOTIFY_INODE_EVENTS | \
> -				 FANOTIFY_ERROR_EVENTS)
> +				 FANOTIFY_ERROR_EVENTS | \
> +				 FANOTIFY_MOUNT_EVENTS )
>  
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 278620e063ab..4129347e4f16 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -463,4 +463,22 @@ static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
>  			NULL, NULL, NULL, 0);
>  }
>  
> +static inline void fsnotify_mnt_attach(struct path *mountpoint, struct vfsmount *mnt)
> +{
> +	struct fsnotify_mnt data = {
> +		.path = mountpoint,
> +		.mnt = mnt,
> +	};
> +	fsnotify(FS_MNT_ATTACH, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
> +}
> +
> +static inline void fsnotify_mnt_detach(struct path *mountpoint, struct vfsmount *mnt)
> +{
> +	struct fsnotify_mnt data = {
> +		.path = mountpoint,
> +		.mnt = mnt,
> +	};
> +	fsnotify(FS_MNT_DETACH, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
> +}
> +
>  #endif	/* _LINUX_FS_NOTIFY_H */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 3ecf7768e577..1e9c15ad64b6 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -56,6 +56,9 @@
>  #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
>  #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
>  
> +#define FS_MNT_ATTACH		0x00100000	/* Mount was attached */
> +#define FS_MNT_DETACH		0x00200000	/* Mount was detached */
> +
>  /*
>   * Set on inode mark that cares about things that happen to its children.
>   * Always set for dnotify and inotify.
> @@ -102,7 +105,7 @@
>  			     FS_EVENTS_POSS_ON_CHILD | \
>  			     FS_DELETE_SELF | FS_MOVE_SELF | \
>  			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
> -			     FS_ERROR)
> +			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
>  
>  /* Extra flags that may be reported with event or control handling of events */
>  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
> @@ -288,6 +291,7 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
>  	FSNOTIFY_EVENT_DENTRY,
> +	FSNOTIFY_EVENT_MNT,
>  	FSNOTIFY_EVENT_ERROR,
>  };
>  
> @@ -297,6 +301,11 @@ struct fs_error_report {
>  	struct super_block *sb;
>  };
>  
> +struct fsnotify_mnt {
> +	const struct path *path;
> +	struct vfsmount *mnt;
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  {
>  	switch (data_type) {
> @@ -306,6 +315,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  		return d_inode(data);
>  	case FSNOTIFY_EVENT_PATH:
>  		return d_inode(((const struct path *)data)->dentry);
> +	case FSNOTIFY_EVENT_MNT:
> +		return d_inode(((struct fsnotify_mnt *)data)->path->dentry);
>  	case FSNOTIFY_EVENT_ERROR:
>  		return ((struct fs_error_report *)data)->inode;
>  	default:
> @@ -321,6 +332,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
>  		return (struct dentry *)data;
>  	case FSNOTIFY_EVENT_PATH:
>  		return ((const struct path *)data)->dentry;
> +	case FSNOTIFY_EVENT_MNT:
> +		return ((const struct fsnotify_mnt *)data)->path->dentry;
>  	default:
>  		return NULL;
>  	}
> @@ -332,6 +345,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
>  	switch (data_type) {
>  	case FSNOTIFY_EVENT_PATH:
>  		return data;
> +	case FSNOTIFY_EVENT_MNT:
> +		return ((const struct fsnotify_mnt *)data)->path;
>  	default:
>  		return NULL;
>  	}
> @@ -347,6 +362,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
>  		return ((struct dentry *)data)->d_sb;
>  	case FSNOTIFY_EVENT_PATH:
>  		return ((const struct path *)data)->dentry->d_sb;
> +	case FSNOTIFY_EVENT_MNT:
> +		return ((const struct fsnotify_mnt *)data)->mnt->mnt_sb;
>  	case FSNOTIFY_EVENT_ERROR:
>  		return ((struct fs_error_report *) data)->sb;
>  	default:
> @@ -354,6 +371,17 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
>  	}
>  }
>  
> +static inline struct vfsmount *fsnotify_data_mnt(const void *data,
> +						 int data_type)
> +{
> +	switch (data_type) {
> +	case FSNOTIFY_EVENT_MNT:
> +		return ((const struct fsnotify_mnt *)data)->mnt;
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  static inline struct fs_error_report *fsnotify_data_error_report(
>  							const void *data,
>  							int data_type)
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 34f221d3a1b9..8b2d47947bc2 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -25,6 +25,8 @@
>  #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
>  #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
>  #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
> +#define FAN_MNT_ATTACH		0x00100000	/* Mount was attached */
> +#define FAN_MNT_DETACH		0x00200000	/* Mount was detached */
>  
>  #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
>  
> @@ -143,6 +145,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID	3
>  #define FAN_EVENT_INFO_TYPE_PIDFD	4
>  #define FAN_EVENT_INFO_TYPE_ERROR	5
> +#define FAN_EVENT_INFO_TYPE_MNT		6
>  
>  /* Special info types for FAN_RENAME */
>  #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
> @@ -189,6 +192,12 @@ struct fanotify_event_info_error {
>  	__u32 error_count;
>  };
>  
> +struct fanotify_event_info_mnt {
> +	struct fanotify_event_info_header hdr;
> +	__u64 mnt_id;
> +	__u64 parent_id;
> +};

Hm, I wonder whether we should indicate to the caller whether the mount
they received a notification for was propagated or not or whether they
should just infer this from statmount(). Probably enough to let them
infer this from statmount() via mnt_ns_id.

