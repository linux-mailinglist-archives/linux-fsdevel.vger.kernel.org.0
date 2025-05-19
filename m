Return-Path: <linux-fsdevel+bounces-49389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B544ABBA8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626643A883E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AF26AAAE;
	Mon, 19 May 2025 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS1yxkpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812233086
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649026; cv=none; b=g5NQD0muzp3mfP1k4R/ruk/njnyFl4mziey2zOh19ePuFnU2kCpYhclv0/MNY4cV2mKH7Kgp0xsIV69fGu77tLwTUcarNl5IBkVrHRbFE42cF6IqNmHrfJJJ+sP2EPt5U9+/hn6idr06m7AI/2EgVSmtFWPSzq5aR+ECPrWuV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649026; c=relaxed/simple;
	bh=HvNFBNrvCpOqenMj+y0gHg6qiKoEtIeRQHRXZEVHP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNWC3NsehzDrMfYY0NqUgWzeHmUFC0kPIphop9mh8JyMxaZQrDcL+1B8nITAK7QVPQhsCfKZ2YXhQmAL3HrwtyvYkiCiv+CpM68muz03/Pqf5V+si/CTSg+IeANpigqJe+cTf/kvePbzYvL+pnEL23U6e/112g29X3DmHZ9kQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS1yxkpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E9AC4CEE4;
	Mon, 19 May 2025 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747649025;
	bh=HvNFBNrvCpOqenMj+y0gHg6qiKoEtIeRQHRXZEVHP0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hS1yxkpx/8cuidkfjGLJf+sp6v7ghd4WY9fdliWWcgKMBE0YbQc/4az2WxpWBxREm
	 a8Wryg7BQEOpWpBIyp+jwK8I9H3kQk2yOfJLwFkTg7KE+W75tDXB6u9V7/wBFgFMrL
	 URqPwS6gMl9NJZVnfKe5GN9KrdDvfcFExtomJkYbhXniIAQd6pB2n++Ik/2PsObejO
	 wVADuyu34kKXUhZkCRR7msAQUHG2khIKgS6BUr3klOLXFP1IIsv7uhm5tioUv9E5ef
	 TTrgQuRKCTIzKRQAAQ9EDvuZElv9QbUfDOAcChT0B4Nl36g074AVz51TzGpAwOofPE
	 68600cx8pIRTg==
Date: Mon, 19 May 2025 12:03:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
Message-ID: <20250519-faust-umrunden-47d15c4b288d@brauner>
References: <20250419100657.2654744-1-amir73il@gmail.com>
 <20250419100657.2654744-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250419100657.2654744-3-amir73il@gmail.com>

On Sat, Apr 19, 2025 at 12:06:57PM +0200, Amir Goldstein wrote:
> An unprivileged user is allowed to create an fanotify group and add
> inode marks, but not filesystem, mntns and mount marks.
> 
> Add limited support for setting up filesystem, mntns and mount marks by
> an unprivileged user under the following conditions:
> 
> 1.   User has CAP_SYS_ADMIN in the user ns where the group was created
> 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
>      mounted (implies FS_USERNS_MOUNT)
>   OR (in case setting up a mntns or mount mark)
> 2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns

So the crux of the problem is that we need to be sure that for all
options we need to be sure that the scope of the permission guarantees
necessary privileges over all the associated objects are held.

CAP_SYS_ADMIN in the owning user namespace of the filesystem (1.) seems
trivially ok because it means that the caller has privileges to mount
that filesystem.

If the caller is just privileged over the owning user namespace of the
mount namespace (2.b) then they are able to listen for mount
notifications starting with v6.15. Note how that the permissions are
specifically scoped to mount objects in that api.

But what you're trying to do here is not scoped to mounts. You're using
that permission check to delegate privileges over non-mount objects such
as directories accessible from that mount as well.

IOW, if I set up a mount mark on a mount based on the fact that I have
privileges over that mount's owning users namespace then it reads to me
that if I have:

mount --bind-into-unprvileged-container /etc /my/container/rootfs/etc

such that the new bind-mount for /etc that gets plugging into the
container is owned by the unprivileged containers's mount namespace then
the container can see write/open/read events on /etc/passwd and
/etc/shadow? But that bind-mount exposes the host's /etc/shadow and
/etc/passwd. That seems like a no go to me.

> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 36 +++++++++++++++++++++---------
>  include/linux/fanotify.h           |  5 ++---
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6d386080faf2..060d9bee34bd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -1009,6 +1009,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  
>  static void fanotify_free_group_priv(struct fsnotify_group *group)
>  {
> +	put_user_ns(group->user_ns);
>  	kfree(group->fanotify_data.merge_hash);
>  	if (group->fanotify_data.ucounts)
>  		dec_ucount(group->fanotify_data.ucounts,
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 471c57832357..b4255b661bda 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1499,6 +1499,7 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
>  /* fanotify syscalls */
>  SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  {
> +	struct user_namespace *user_ns = current_user_ns();
>  	struct fsnotify_group *group;
>  	int f_flags, fd;
>  	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
> @@ -1513,10 +1514,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  		/*
>  		 * An unprivileged user can setup an fanotify group with
>  		 * limited functionality - an unprivileged group is limited to
> -		 * notification events with file handles and it cannot use
> -		 * unlimited queue/marks.
> +		 * notification events with file handles or mount ids and it
> +		 * cannot use unlimited queue/marks.
>  		 */
> -		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
> +		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> +		    !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
>  			return -EPERM;
>  
>  		/*
> @@ -1595,8 +1597,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	}
>  
>  	/* Enforce groups limits per user in all containing user ns */
> -	group->fanotify_data.ucounts = inc_ucount(current_user_ns(),
> -						  current_euid(),
> +	group->fanotify_data.ucounts = inc_ucount(user_ns, current_euid(),
>  						  UCOUNT_FANOTIFY_GROUPS);
>  	if (!group->fanotify_data.ucounts) {
>  		fd = -EMFILE;
> @@ -1605,6 +1606,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  
>  	group->fanotify_data.flags = flags | internal_flags;
>  	group->memcg = get_mem_cgroup_from_mm(current->mm);
> +	group->user_ns = get_user_ns(user_ns);
>  
>  	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
>  	if (!group->fanotify_data.merge_hash) {
> @@ -1804,6 +1806,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	struct fsnotify_group *group;
>  	struct path path;
>  	struct fan_fsid __fsid, *fsid = NULL;
> +	struct user_namespace *user_ns = NULL;
>  	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
>  	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
> @@ -1897,12 +1900,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	}
>  
>  	/*
> -	 * An unprivileged user is not allowed to setup mount nor filesystem
> -	 * marks.  This also includes setting up such marks by a group that
> -	 * was initialized by an unprivileged user.
> +	 * A user is allowed to setup sb/mount/mntns marks only if it is
> +	 * capable in the user ns where the group was created.
>  	 */
> -	if ((!capable(CAP_SYS_ADMIN) ||
> -	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
> +	if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
>  	    mark_type != FAN_MARK_INODE)
>  		return -EPERM;
>  
> @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		obj = inode;
>  	} else if (obj_type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>  		obj = path.mnt;
> +		user_ns = real_mount(obj)->mnt_ns->user_ns;
>  	} else if (obj_type == FSNOTIFY_OBJ_TYPE_SB) {
>  		obj = path.mnt->mnt_sb;
> +		user_ns = path.mnt->mnt_sb->s_user_ns;
>  	} else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
>  		obj = mnt_ns_from_dentry(path.dentry);
> +		user_ns = ((struct mnt_namespace *)obj)->user_ns;
>  	}
>  
> +	/*
> +	 * In addition to being capable in the user ns where group was created,
> +	 * the user also needs to be capable in the user ns associated with
> +	 * the marked filesystem (for FS_USERNS_MOUNT filesystems) or in the
> +	 * user ns associated with the mntns (when marking a mount or mntns).
> +	 * This is aligned with the required permissions to open_by_handle_at()
> +	 * a directory fid provided with the events.
> +	 */
> +	ret = -EPERM;
> +	if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
> +		goto path_put_and_out;
> +
>  	ret = -EINVAL;
>  	if (!obj)
>  		goto path_put_and_out;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 3c817dc6292e..879cff5eccd4 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -38,8 +38,7 @@
>  					 FAN_REPORT_PIDFD | \
>  					 FAN_REPORT_FD_ERROR | \
>  					 FAN_UNLIMITED_QUEUE | \
> -					 FAN_UNLIMITED_MARKS | \
> -					 FAN_REPORT_MNT)
> +					 FAN_UNLIMITED_MARKS)
>  
>  /*
>   * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
> @@ -48,7 +47,7 @@
>   * so one of the flags for reporting file handles is required.
>   */
>  #define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
> -					 FANOTIFY_FID_BITS | \
> +					 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
>  					 FAN_CLOEXEC | FAN_NONBLOCK)
>  
>  #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index fc27b53c58c2..d4034ddaf392 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -250,6 +250,7 @@ struct fsnotify_group {
>  						 * full */
>  
>  	struct mem_cgroup *memcg;	/* memcg to charge allocations */
> +	struct user_namespace *user_ns;	/* user ns where group was created */
>  
>  	/* groups can define private fields here or use the void *private */
>  	union {
> -- 
> 2.34.1
> 

