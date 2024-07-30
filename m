Return-Path: <linux-fsdevel+bounces-24556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E3940740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17435B22F39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE419882B;
	Tue, 30 Jul 2024 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzHfKmH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFD197543;
	Tue, 30 Jul 2024 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316509; cv=none; b=uj4PFkODOFrTbeGs/QdAK5recZbpyzoFOoVwOW4A/F6TxEu1huH99DlXs6kaUnHK8X2vl86RourzvVwynZKFifjejktUe1IXA/M0b7HPoMX7dlNCizLbW6JVTXv/mZh9Ouqg0fDq7aDVzoNea1C8T6WdS4updGW7UqbrfcGxvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316509; c=relaxed/simple;
	bh=rnRxpbarcqCbwBQ8CVq9qd7EMBsqOfwvDjMmhuIEN28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npaHeKPxKk88qvNhoKTrGDyQRXpFXB2oK7JbLbhsHT+yNcqizjMglEleAvKIajVPjTCC0aMSeQdVXlSfLjjMl0FxwOINroBu9XKXX/i4nal4Sy91Phc40CEcGc2wprU4f4SjDE+fVMfvU0Oh5HVHQE04mIOrm8JNJNZjMRdAgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzHfKmH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FE8C4AF0A;
	Tue, 30 Jul 2024 05:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316509;
	bh=rnRxpbarcqCbwBQ8CVq9qd7EMBsqOfwvDjMmhuIEN28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzHfKmH6jXYscVurWHWcwcOWnt8VhClj+IwrEdXDCiu/CyF86PFR0xU4y8UMGMXHV
	 qdjxRPRYXs6m2tvYwS7JCBvQjjPbIerjqd9t5MKKN3+RVXD55zLWo9OgAQ/6FQIclM
	 6hM/4u1w+PbOXZWQ6GmZBztXAL9ZVvNdaVUOzRWwZ5lcaBiE1LZm56s0kQatTNFXcy
	 xhyxEEkeZ00hELCBcaA8J+d7GzQ9LFCZQAmzdSizH+YZwpfroWEazQziTLlPvZMgeP
	 xj9mGuaC0gdWJ1rgJuluTWaRvfHiMRuAw9tFu2YJHOY1kc//2m9gkHLNWZsclJR4gY
	 uH/WdLIBD0zUQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 24/39] fdget(), more trivial conversions
Date: Tue, 30 Jul 2024 01:16:10 -0400
Message-Id: <20240730051625.14349-24-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

all failure exits prior to fdget() leave the scope, all matching fdput()
are immediately followed by leaving the scope.

[trivial conflicts in fs/fsopen.c and kernel/bpf/syscall.c]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/core/ucma.c     | 19 +++-----
 drivers/vfio/group.c               |  6 +--
 fs/eventpoll.c                     | 15 ++----
 fs/ext4/ioctl.c                    | 21 +++------
 fs/f2fs/file.c                     | 15 ++----
 fs/fsopen.c                        | 19 +++-----
 fs/fuse/dev.c                      |  6 +--
 fs/locks.c                         | 15 ++----
 fs/namespace.c                     | 47 ++++++------------
 fs/notify/fanotify/fanotify_user.c | 29 +++++-------
 fs/notify/inotify/inotify_user.c   | 21 +++------
 fs/ocfs2/cluster/heartbeat.c       | 13 ++---
 fs/open.c                          | 12 ++---
 fs/read_write.c                    | 71 ++++++++++------------------
 fs/splice.c                        | 45 +++++++-----------
 fs/utimes.c                        | 11 ++---
 fs/xfs/xfs_exchrange.c             | 10 ++--
 fs/xfs/xfs_ioctl.c                 | 69 +++++++++------------------
 ipc/mqueue.c                       | 76 +++++++++---------------------
 kernel/bpf/syscall.c               | 22 +++------
 kernel/module/main.c               | 11 ++---
 kernel/pid.c                       | 13 ++---
 kernel/signal.c                    | 29 ++++--------
 kernel/taskstats.c                 | 18 +++----
 security/integrity/ima/ima_main.c  |  7 +--
 security/loadpin/loadpin.c         |  8 +---
 virt/kvm/vfio.c                    |  6 +--
 27 files changed, 207 insertions(+), 427 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index dc57d07a1f45..cc95718fd24b 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1615,7 +1615,6 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 	struct ucma_event *uevent, *tmp;
 	struct ucma_context *ctx;
 	LIST_HEAD(event_list);
-	struct fd f;
 	struct ucma_file *cur_file;
 	int ret = 0;
 
@@ -1623,21 +1622,17 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 		return -EFAULT;
 
 	/* Get current fd to protect against it being closed */
-	f = fdget(cmd.fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(cmd.fd);
+	if (fd_empty(f))
 		return -ENOENT;
-	if (fd_file(f)->f_op != &ucma_fops) {
-		ret = -EINVAL;
-		goto file_put;
-	}
+	if (fd_file(f)->f_op != &ucma_fops)
+		return -EINVAL;
 	cur_file = fd_file(f)->private_data;
 
 	/* Validate current fd and prevent destruction of id. */
 	ctx = ucma_get_ctx(cur_file, cmd.id);
-	if (IS_ERR(ctx)) {
-		ret = PTR_ERR(ctx);
-		goto file_put;
-	}
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	rdma_lock_handler(ctx->cm_id);
 	/*
@@ -1678,8 +1673,6 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 err_unlock:
 	rdma_unlock_handler(ctx->cm_id);
 	ucma_put_ctx(ctx);
-file_put:
-	fdput(f);
 	return ret;
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 95b336de8a17..49559605177e 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -104,15 +104,14 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 {
 	struct vfio_container *container;
 	struct iommufd_ctx *iommufd;
-	struct fd f;
 	int ret;
 	int fd;
 
 	if (get_user(fd, arg))
 		return -EFAULT;
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	mutex_lock(&group->group_lock);
@@ -153,7 +152,6 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 
 out_unlock:
 	mutex_unlock(&group->group_lock);
-	fdput(f);
 	return ret;
 }
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4609f7342005..1e63f3b03ca5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2420,8 +2420,6 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 			 int maxevents, struct timespec64 *to)
 {
-	int error;
-	struct fd f;
 	struct eventpoll *ep;
 
 	/* The maximum number of event must be greater than zero */
@@ -2433,17 +2431,16 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 		return -EFAULT;
 
 	/* Get the "struct file *" for the eventpoll file */
-	f = fdget(epfd);
-	if (!fd_file(f))
+	CLASS(fd, f)(epfd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	/*
 	 * We have to check that the file structure underneath the fd
 	 * the user passed to us _is_ an eventpoll file.
 	 */
-	error = -EINVAL;
 	if (!is_file_epoll(fd_file(f)))
-		goto error_fput;
+		return -EINVAL;
 
 	/*
 	 * At this point it is safe to assume that the "private_data" contains
@@ -2452,11 +2449,7 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	ep = fd_file(f)->private_data;
 
 	/* Time to fish for events ... */
-	error = ep_poll(ep, events, maxevents, to);
-
-error_fput:
-	fdput(f);
-	return error;
+	return ep_poll(ep, events, maxevents, to);
 }
 
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1c77400bd88e..7b9ce71c1c81 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1330,7 +1330,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case EXT4_IOC_MOVE_EXT: {
 		struct move_extent me;
-		struct fd donor;
 		int err;
 
 		if (!(filp->f_mode & FMODE_READ) ||
@@ -1342,30 +1341,26 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		me.moved_len = 0;
 
-		donor = fdget(me.donor_fd);
-		if (!fd_file(donor))
+		CLASS(fd, donor)(me.donor_fd);
+		if (fd_empty(donor))
 			return -EBADF;
 
-		if (!(fd_file(donor)->f_mode & FMODE_WRITE)) {
-			err = -EBADF;
-			goto mext_out;
-		}
+		if (!(fd_file(donor)->f_mode & FMODE_WRITE))
+			return -EBADF;
 
 		if (ext4_has_feature_bigalloc(sb)) {
 			ext4_msg(sb, KERN_ERR,
 				 "Online defrag not supported with bigalloc");
-			err = -EOPNOTSUPP;
-			goto mext_out;
+			return -EOPNOTSUPP;
 		} else if (IS_DAX(inode)) {
 			ext4_msg(sb, KERN_ERR,
 				 "Online defrag not supported with DAX");
-			err = -EOPNOTSUPP;
-			goto mext_out;
+			return -EOPNOTSUPP;
 		}
 
 		err = mnt_want_write_file(filp);
 		if (err)
-			goto mext_out;
+			return err;
 
 		err = ext4_move_extents(filp, fd_file(donor), me.orig_start,
 					me.donor_start, me.len, &me.moved_len);
@@ -1374,8 +1369,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((struct move_extent __user *)arg,
 				 &me, sizeof(me)))
 			err = -EFAULT;
-mext_out:
-		fdput(donor);
 		return err;
 	}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 903337f8d21a..4682d83ab6b4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3006,32 +3006,27 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 static int __f2fs_ioc_move_range(struct file *filp,
 				struct f2fs_move_range *range)
 {
-	struct fd dst;
 	int err;
 
 	if (!(filp->f_mode & FMODE_READ) ||
 			!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	dst = fdget(range->dst_fd);
-	if (!fd_file(dst))
+	CLASS(fd, dst)(range->dst_fd);
+	if (fd_empty(dst))
 		return -EBADF;
 
-	if (!(fd_file(dst)->f_mode & FMODE_WRITE)) {
-		err = -EBADF;
-		goto err_out;
-	}
+	if (!(fd_file(dst)->f_mode & FMODE_WRITE))
+		return -EBADF;
 
 	err = mnt_want_write_file(filp);
 	if (err)
-		goto err_out;
+		return err;
 
 	err = f2fs_move_file_range(filp, range->pos_in, fd_file(dst),
 					range->pos_out, range->len);
 
 	mnt_drop_write_file(filp);
-err_out:
-	fdput(dst);
 	return err;
 }
 
diff --git a/fs/fsopen.c b/fs/fsopen.c
index ee92ca58429e..ff807662a41c 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -350,7 +350,6 @@ SYSCALL_DEFINE5(fsconfig,
 		int, aux)
 {
 	struct fs_context *fc;
-	struct fd f;
 	int ret;
 	int lookup_flags = 0;
 
@@ -393,12 +392,11 @@ SYSCALL_DEFINE5(fsconfig,
 		return -EOPNOTSUPP;
 	}
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
-	ret = -EINVAL;
 	if (fd_file(f)->f_op != &fscontext_fops)
-		goto out_f;
+		return -EINVAL;
 
 	fc = fd_file(f)->private_data;
 	if (fc->ops == &legacy_fs_context_ops) {
@@ -408,17 +406,14 @@ SYSCALL_DEFINE5(fsconfig,
 		case FSCONFIG_SET_PATH_EMPTY:
 		case FSCONFIG_SET_FD:
 		case FSCONFIG_CMD_CREATE_EXCL:
-			ret = -EOPNOTSUPP;
-			goto out_f;
+			return -EOPNOTSUPP;
 		}
 	}
 
 	if (_key) {
 		param.key = strndup_user(_key, 256);
-		if (IS_ERR(param.key)) {
-			ret = PTR_ERR(param.key);
-			goto out_f;
-		}
+		if (IS_ERR(param.key))
+			return PTR_ERR(param.key);
 	}
 
 	switch (cmd) {
@@ -497,7 +492,5 @@ SYSCALL_DEFINE5(fsconfig,
 	}
 out_key:
 	kfree(param.key);
-out_f:
-	fdput(f);
 	return ret;
 }
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 991b9ae8e7c9..27826116a4fb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2315,13 +2315,12 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	int res;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
-	struct fd f;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
 
-	f = fdget(oldfd);
-	if (!fd_file(f))
+	CLASS(fd, f)(oldfd);
+	if (fd_empty(f))
 		return -EINVAL;
 
 	/*
@@ -2338,7 +2337,6 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 		mutex_unlock(&fuse_mutex);
 	}
 
-	fdput(f);
 	return res;
 }
 
diff --git a/fs/locks.c b/fs/locks.c
index 239759a356e9..ea56dc70d445 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2132,7 +2132,6 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 {
 	int can_sleep, error, type;
 	struct file_lock fl;
-	struct fd f;
 
 	/*
 	 * LOCK_MAND locks were broken for a long time in that they never
@@ -2151,19 +2150,18 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	if (type < 0)
 		return type;
 
-	error = -EBADF;
-	f = fdget(fd);
-	if (!fd_file(f))
-		return error;
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
 
 	if (type != F_UNLCK && !(fd_file(f)->f_mode & (FMODE_READ | FMODE_WRITE)))
-		goto out_putf;
+		return -EBADF;
 
 	flock_make_lock(fd_file(f), &fl, type);
 
 	error = security_file_lock(fd_file(f), fl.c.flc_type);
 	if (error)
-		goto out_putf;
+		return error;
 
 	can_sleep = !(cmd & LOCK_NB);
 	if (can_sleep)
@@ -2177,9 +2175,6 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 		error = locks_lock_file_wait(fd_file(f), &fl);
 
 	locks_release_private(&fl);
- out_putf:
-	fdput(f);
-
 	return error;
 }
 
diff --git a/fs/namespace.c b/fs/namespace.c
index c46d48bb38cd..876ab546feba 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4070,7 +4070,6 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	struct file *file;
 	struct path newmount;
 	struct mount *mnt;
-	struct fd f;
 	unsigned int mnt_flags = 0;
 	long ret;
 
@@ -4098,19 +4097,18 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		return -EINVAL;
 	}
 
-	f = fdget(fs_fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fs_fd);
+	if (fd_empty(f))
 		return -EBADF;
 
-	ret = -EINVAL;
 	if (fd_file(f)->f_op != &fscontext_fops)
-		goto err_fsfd;
+		return -EINVAL;
 
 	fc = fd_file(f)->private_data;
 
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
-		goto err_fsfd;
+		return ret;
 
 	/* There must be a valid superblock or we can't mount it */
 	ret = -EINVAL;
@@ -4177,8 +4175,6 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	path_put(&newmount);
 err_unlock:
 	mutex_unlock(&fc->uapi_mutex);
-err_fsfd:
-	fdput(f);
 	return ret;
 }
 
@@ -4629,10 +4625,8 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 				struct mount_kattr *kattr, unsigned int flags)
 {
-	int err = 0;
 	struct ns_common *ns;
 	struct user_namespace *mnt_userns;
-	struct fd f;
 
 	if (!((attr->attr_set | attr->attr_clr) & MOUNT_ATTR_IDMAP))
 		return 0;
@@ -4648,20 +4642,16 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	if (attr->userns_fd > INT_MAX)
 		return -EINVAL;
 
-	f = fdget(attr->userns_fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(attr->userns_fd);
+	if (fd_empty(f))
 		return -EBADF;
 
-	if (!proc_ns_file(fd_file(f))) {
-		err = -EINVAL;
-		goto out_fput;
-	}
+	if (!proc_ns_file(fd_file(f)))
+		return -EINVAL;
 
 	ns = get_proc_ns(file_inode(fd_file(f)));
-	if (ns->ops->type != CLONE_NEWUSER) {
-		err = -EINVAL;
-		goto out_fput;
-	}
+	if (ns->ops->type != CLONE_NEWUSER)
+		return -EINVAL;
 
 	/*
 	 * The initial idmapping cannot be used to create an idmapped
@@ -4672,22 +4662,15 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	 * result.
 	 */
 	mnt_userns = container_of(ns, struct user_namespace, ns);
-	if (mnt_userns == &init_user_ns) {
-		err = -EPERM;
-		goto out_fput;
-	}
+	if (mnt_userns == &init_user_ns)
+		return -EPERM;
 
 	/* We're not controlling the target namespace. */
-	if (!ns_capable(mnt_userns, CAP_SYS_ADMIN)) {
-		err = -EPERM;
-		goto out_fput;
-	}
+	if (!ns_capable(mnt_userns, CAP_SYS_ADMIN))
+		return -EPERM;
 
 	kattr->mnt_userns = get_user_ns(mnt_userns);
-
-out_fput:
-	fdput(f);
-	return err;
+	return 0;
 }
 
 static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 64b1adc75fe5..7b5abc1b8c8f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1677,7 +1677,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct inode *inode = NULL;
 	struct vfsmount *mnt = NULL;
 	struct fsnotify_group *group;
-	struct fd f;
 	struct path path;
 	struct fan_fsid __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
@@ -1747,14 +1746,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		umask = FANOTIFY_EVENT_FLAGS;
 	}
 
-	f = fdget(fanotify_fd);
-	if (unlikely(!fd_file(f)))
+	CLASS(fd, f)(fanotify_fd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	/* verify that this is indeed an fanotify instance */
-	ret = -EINVAL;
 	if (unlikely(fd_file(f)->f_op != &fanotify_fops))
-		goto fput_and_out;
+		return -EINVAL;
 	group = fd_file(f)->private_data;
 
 	/*
@@ -1762,23 +1760,21 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * marks.  This also includes setting up such marks by a group that
 	 * was initialized by an unprivileged user.
 	 */
-	ret = -EPERM;
 	if ((!capable(CAP_SYS_ADMIN) ||
 	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
 	    mark_type != FAN_MARK_INODE)
-		goto fput_and_out;
+		return -EPERM;
 
 	/*
 	 * Permission events require minimum priority FAN_CLASS_CONTENT.
 	 */
-	ret = -EINVAL;
 	if (mask & FANOTIFY_PERM_EVENTS &&
 	    group->priority < FSNOTIFY_PRIO_CONTENT)
-		goto fput_and_out;
+		return -EINVAL;
 
 	if (mask & FAN_FS_ERROR &&
 	    mark_type != FAN_MARK_FILESYSTEM)
-		goto fput_and_out;
+		return -EINVAL;
 
 	/*
 	 * Evictable is only relevant for inode marks, because only inode object
@@ -1786,7 +1782,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 */
 	if (flags & FAN_MARK_EVICTABLE &&
 	     mark_type != FAN_MARK_INODE)
-		goto fput_and_out;
+		return -EINVAL;
 
 	/*
 	 * Events that do not carry enough information to report
@@ -1798,7 +1794,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
-		goto fput_and_out;
+		return -EINVAL;
 
 	/*
 	 * FAN_RENAME uses special info type records to report the old and
@@ -1806,23 +1802,22 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * useful and was not implemented.
 	 */
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
-		goto fput_and_out;
+		return -EINVAL;
 
 	if (mark_cmd == FAN_MARK_FLUSH) {
-		ret = 0;
 		if (mark_type == FAN_MARK_MOUNT)
 			fsnotify_clear_vfsmount_marks_by_group(group);
 		else if (mark_type == FAN_MARK_FILESYSTEM)
 			fsnotify_clear_sb_marks_by_group(group);
 		else
 			fsnotify_clear_inode_marks_by_group(group);
-		goto fput_and_out;
+		return 0;
 	}
 
 	ret = fanotify_find_path(dfd, pathname, &path, flags,
 			(mask & ALL_FSNOTIFY_EVENTS), obj_type);
 	if (ret)
-		goto fput_and_out;
+		return ret;
 
 	if (mark_cmd == FAN_MARK_ADD) {
 		ret = fanotify_events_supported(group, &path, mask, flags);
@@ -1901,8 +1896,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 
 path_put_and_out:
 	path_put(&path);
-fput_and_out:
-	fdput(f);
 	return ret;
 }
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 711830b73275..f46ec6afee3c 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -732,7 +732,6 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	struct fsnotify_group *group;
 	struct inode *inode;
 	struct path path;
-	struct fd f;
 	int ret;
 	unsigned flags = 0;
 
@@ -752,21 +751,17 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	if (unlikely(!(mask & ALL_INOTIFY_BITS)))
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (unlikely(!fd_file(f)))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	/* IN_MASK_ADD and IN_MASK_CREATE don't make sense together */
-	if (unlikely((mask & IN_MASK_ADD) && (mask & IN_MASK_CREATE))) {
-		ret = -EINVAL;
-		goto fput_and_out;
-	}
+	if (unlikely((mask & IN_MASK_ADD) && (mask & IN_MASK_CREATE)))
+		return -EINVAL;
 
 	/* verify that this is indeed an inotify instance */
-	if (unlikely(fd_file(f)->f_op != &inotify_fops)) {
-		ret = -EINVAL;
-		goto fput_and_out;
-	}
+	if (unlikely(fd_file(f)->f_op != &inotify_fops))
+		return -EINVAL;
 
 	if (!(mask & IN_DONT_FOLLOW))
 		flags |= LOOKUP_FOLLOW;
@@ -776,7 +771,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	ret = inotify_find_inode(pathname, &path, flags,
 			(mask & IN_ALL_EVENTS));
 	if (ret)
-		goto fput_and_out;
+		return ret;
 
 	/* inode held in place by reference to path; group by fget on fd */
 	inode = path.dentry->d_inode;
@@ -785,8 +780,6 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	/* create/update an inode mark */
 	ret = inotify_update_watch(group, inode, mask);
 	path_put(&path);
-fput_and_out:
-	fdput(f);
 	return ret;
 }
 
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index bc55340a60c3..4200a0341343 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1765,7 +1765,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	long fd;
 	int sectsize;
 	char *p = (char *)page;
-	struct fd f;
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
@@ -1784,23 +1783,23 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (fd < 0 || fd >= INT_MAX)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f) == NULL)
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EINVAL;
 
 	if (reg->hr_blocks == 0 || reg->hr_start_block == 0 ||
 	    reg->hr_block_bytes == 0)
-		goto out2;
+		return -EINVAL;
 
 	if (!S_ISBLK(fd_file(f)->f_mapping->host->i_mode))
-		goto out2;
+		return -EINVAL;
 
 	reg->hr_bdev_file = bdev_file_open_by_dev(fd_file(f)->f_mapping->host->i_rdev,
 			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
 	if (IS_ERR(reg->hr_bdev_file)) {
 		ret = PTR_ERR(reg->hr_bdev_file);
 		reg->hr_bdev_file = NULL;
-		goto out2;
+		return ret;
 	}
 
 	sectsize = bdev_logical_block_size(reg_bdev(reg));
@@ -1906,8 +1905,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		fput(reg->hr_bdev_file);
 		reg->hr_bdev_file = NULL;
 	}
-out2:
-	fdput(f);
 	return ret;
 }
 
diff --git a/fs/open.c b/fs/open.c
index 6d7dd58ce095..45884ff7dead 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -187,19 +187,13 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
-	struct fd f;
-	int error;
-
 	if (length < 0)
 		return -EINVAL;
-	f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
 
-	error = do_ftruncate(fd_file(f), length, small);
-
-	fdput(f);
-	return error;
+	return do_ftruncate(fd_file(f), length, small);
 }
 
 SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
diff --git a/fs/read_write.c b/fs/read_write.c
index b3743e7dd93f..789ea6ecf147 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -652,21 +652,17 @@ SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 		     loff_t pos)
 {
-	struct fd f;
-	ssize_t ret = -EBADF;
-
 	if (pos < 0)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
-		ret = -ESPIPE;
-		if (fd_file(f)->f_mode & FMODE_PREAD)
-			ret = vfs_read(fd_file(f), buf, count, &pos);
-		fdput(f);
-	}
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
 
-	return ret;
+	if (fd_file(f)->f_mode & FMODE_PREAD)
+		return vfs_read(fd_file(f), buf, count, &pos);
+
+	return -ESPIPE;
 }
 
 SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
@@ -686,21 +682,17 @@ COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
 ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		      size_t count, loff_t pos)
 {
-	struct fd f;
-	ssize_t ret = -EBADF;
-
 	if (pos < 0)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
-		ret = -ESPIPE;
-		if (fd_file(f)->f_mode & FMODE_PWRITE)
-			ret = vfs_write(fd_file(f), buf, count, &pos);
-		fdput(f);
-	}
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
 
-	return ret;
+	if (fd_file(f)->f_mode & FMODE_PWRITE)
+		return vfs_write(fd_file(f), buf, count, &pos);
+
+	return -ESPIPE;
 }
 
 SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
@@ -1214,7 +1206,6 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 			   size_t count, loff_t max)
 {
-	struct fd in, out;
 	struct inode *in_inode, *out_inode;
 	struct pipe_inode_info *opipe;
 	loff_t pos;
@@ -1225,35 +1216,32 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	/*
 	 * Get input file, and verify that it is ok..
 	 */
-	retval = -EBADF;
-	in = fdget(in_fd);
-	if (!fd_file(in))
-		goto out;
+	CLASS(fd, in)(in_fd);
+	if (fd_empty(in))
+		return -EBADF;
 	if (!(fd_file(in)->f_mode & FMODE_READ))
-		goto fput_in;
-	retval = -ESPIPE;
+		return -EBADF;
 	if (!ppos) {
 		pos = fd_file(in)->f_pos;
 	} else {
 		pos = *ppos;
 		if (!(fd_file(in)->f_mode & FMODE_PREAD))
-			goto fput_in;
+			return -ESPIPE;
 	}
 	retval = rw_verify_area(READ, fd_file(in), &pos, count);
 	if (retval < 0)
-		goto fput_in;
+		return retval;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 
 	/*
 	 * Get output file, and verify that it is ok..
 	 */
-	retval = -EBADF;
-	out = fdget(out_fd);
-	if (!fd_file(out))
-		goto fput_in;
+	CLASS(fd, out)(out_fd);
+	if (fd_empty(out))
+		return -EBADF;
 	if (!(fd_file(out)->f_mode & FMODE_WRITE))
-		goto fput_out;
+		return -EBADF;
 	in_inode = file_inode(fd_file(in));
 	out_inode = file_inode(fd_file(out));
 	out_pos = fd_file(out)->f_pos;
@@ -1262,9 +1250,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
 
 	if (unlikely(pos + count > max)) {
-		retval = -EOVERFLOW;
 		if (pos >= max)
-			goto fput_out;
+			return -EOVERFLOW;
 		count = max - pos;
 	}
 
@@ -1283,7 +1270,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	if (!opipe) {
 		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
 		if (retval < 0)
-			goto fput_out;
+			return retval;
 		retval = do_splice_direct(fd_file(in), &pos, fd_file(out), &out_pos,
 					  count, fl);
 	} else {
@@ -1309,12 +1296,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	inc_syscw(current);
 	if (pos > max)
 		retval = -EOVERFLOW;
-
-fput_out:
-	fdput(out);
-fput_in:
-	fdput(in);
-out:
 	return retval;
 }
 
diff --git a/fs/splice.c b/fs/splice.c
index 29cd39d7f4a0..2898fa1e9e63 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1622,27 +1622,22 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
 		int, fd_out, loff_t __user *, off_out,
 		size_t, len, unsigned int, flags)
 {
-	struct fd in, out;
-	ssize_t error;
-
 	if (unlikely(!len))
 		return 0;
 
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
-	error = -EBADF;
-	in = fdget(fd_in);
-	if (fd_file(in)) {
-		out = fdget(fd_out);
-		if (fd_file(out)) {
-			error = __do_splice(fd_file(in), off_in, fd_file(out), off_out,
+	CLASS(fd, in)(fd_in);
+	if (fd_empty(in))
+		return -EBADF;
+
+	CLASS(fd, out)(fd_out);
+	if (fd_empty(out))
+		return -EBADF;
+
+	return __do_splice(fd_file(in), off_in, fd_file(out), off_out,
 					    len, flags);
-			fdput(out);
-		}
-		fdput(in);
-	}
-	return error;
 }
 
 /*
@@ -1992,25 +1987,19 @@ ssize_t do_tee(struct file *in, struct file *out, size_t len,
 
 SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
 {
-	struct fd in, out;
-	ssize_t error;
-
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
 	if (unlikely(!len))
 		return 0;
 
-	error = -EBADF;
-	in = fdget(fdin);
-	if (fd_file(in)) {
-		out = fdget(fdout);
-		if (fd_file(out)) {
-			error = do_tee(fd_file(in), fd_file(out), len, flags);
-			fdput(out);
-		}
- 		fdput(in);
- 	}
+	CLASS(fd, in)(fdin);
+	if (fd_empty(in))
+		return -EBADF;
 
-	return error;
+	CLASS(fd, out)(fdout);
+	if (fd_empty(out))
+		return -EBADF;
+
+	return do_tee(fd_file(in), fd_file(out), len, flags);
 }
diff --git a/fs/utimes.c b/fs/utimes.c
index 99b26f792b89..c7c7958e57b2 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -108,18 +108,13 @@ static int do_utimes_path(int dfd, const char __user *filename,
 
 static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 {
-	struct fd f;
-	int error;
-
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
-	error = vfs_utimes(&fd_file(f)->f_path, times);
-	fdput(f);
-	return error;
+	return vfs_utimes(&fd_file(f)->f_path, times);
 }
 
 /*
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 9790e0f45d14..35b9b58a4f6f 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -778,8 +778,6 @@ xfs_ioc_exchange_range(
 		.file2			= file,
 	};
 	struct xfs_exchange_range	args;
-	struct fd			file1;
-	int				error;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
 		return -EFAULT;
@@ -793,12 +791,10 @@ xfs_ioc_exchange_range(
 	fxr.length		= args.length;
 	fxr.flags		= args.flags;
 
-	file1 = fdget(args.file1_fd);
-	if (!fd_file(file1))
+	CLASS(fd, file1)(args.file1_fd);
+	if (fd_empty(file1))
 		return -EBADF;
 	fxr.file1 = fd_file(file1);
 
-	error = xfs_exchange_range(&fxr);
-	fdput(file1);
-	return error;
+	return xfs_exchange_range(&fxr);
 }
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 95641817370b..1bb89f85af1b 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1000,41 +1000,29 @@ xfs_ioc_swapext(
 	xfs_swapext_t	*sxp)
 {
 	xfs_inode_t     *ip, *tip;
-	struct fd	f, tmp;
-	int		error = 0;
 
 	/* Pull information for the target fd */
-	f = fdget((int)sxp->sx_fdtarget);
-	if (!fd_file(f)) {
-		error = -EINVAL;
-		goto out;
-	}
+	CLASS(fd, f)((int)sxp->sx_fdtarget);
+	if (fd_empty(f))
+		return -EINVAL;
 
 	if (!(fd_file(f)->f_mode & FMODE_WRITE) ||
 	    !(fd_file(f)->f_mode & FMODE_READ) ||
-	    (fd_file(f)->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_file;
-	}
+	    (fd_file(f)->f_flags & O_APPEND))
+		return -EBADF;
 
-	tmp = fdget((int)sxp->sx_fdtmp);
-	if (!fd_file(tmp)) {
-		error = -EINVAL;
-		goto out_put_file;
-	}
+	CLASS(fd, tmp)((int)sxp->sx_fdtmp);
+	if (fd_empty(tmp))
+		return -EINVAL;
 
 	if (!(fd_file(tmp)->f_mode & FMODE_WRITE) ||
 	    !(fd_file(tmp)->f_mode & FMODE_READ) ||
-	    (fd_file(tmp)->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_tmp_file;
-	}
+	    (fd_file(tmp)->f_flags & O_APPEND))
+		return -EBADF;
 
 	if (IS_SWAPFILE(file_inode(fd_file(f))) ||
-	    IS_SWAPFILE(file_inode(fd_file(tmp)))) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
+	    IS_SWAPFILE(file_inode(fd_file(tmp))))
+		return -EINVAL;
 
 	/*
 	 * We need to ensure that the fds passed in point to XFS inodes
@@ -1042,37 +1030,22 @@ xfs_ioc_swapext(
 	 * control over what the user passes us here.
 	 */
 	if (fd_file(f)->f_op != &xfs_file_operations ||
-	    fd_file(tmp)->f_op != &xfs_file_operations) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
+	    fd_file(tmp)->f_op != &xfs_file_operations)
+		return -EINVAL;
 
 	ip = XFS_I(file_inode(fd_file(f)));
 	tip = XFS_I(file_inode(fd_file(tmp)));
 
-	if (ip->i_mount != tip->i_mount) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	if (ip->i_ino == tip->i_ino) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
+	if (ip->i_mount != tip->i_mount)
+		return -EINVAL;
 
-	if (xfs_is_shutdown(ip->i_mount)) {
-		error = -EIO;
-		goto out_put_tmp_file;
-	}
+	if (ip->i_ino == tip->i_ino)
+		return -EINVAL;
 
-	error = xfs_swap_extents(ip, tip, sxp);
+	if (xfs_is_shutdown(ip->i_mount))
+		return -EIO;
 
- out_put_tmp_file:
-	fdput(tmp);
- out_put_file:
-	fdput(f);
- out:
-	return error;
+	return xfs_swap_extents(ip, tip, sxp);
 }
 
 static int
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4f1dec518fae..35b4f8659904 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1063,7 +1063,6 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 		size_t msg_len, unsigned int msg_prio,
 		struct timespec64 *ts)
 {
-	struct fd f;
 	struct inode *inode;
 	struct ext_wait_queue wait;
 	struct ext_wait_queue *receiver;
@@ -1084,37 +1083,27 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 
 	audit_mq_sendrecv(mqdes, msg_len, msg_prio, ts);
 
-	f = fdget(mqdes);
-	if (unlikely(!fd_file(f))) {
-		ret = -EBADF;
-		goto out;
-	}
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f))
+		return -EBADF;
 
 	inode = file_inode(fd_file(f));
-	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
-		ret = -EBADF;
-		goto out_fput;
-	}
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
+		return -EBADF;
 	info = MQUEUE_I(inode);
 	audit_file(fd_file(f));
 
-	if (unlikely(!(fd_file(f)->f_mode & FMODE_WRITE))) {
-		ret = -EBADF;
-		goto out_fput;
-	}
+	if (unlikely(!(fd_file(f)->f_mode & FMODE_WRITE)))
+		return -EBADF;
 
-	if (unlikely(msg_len > info->attr.mq_msgsize)) {
-		ret = -EMSGSIZE;
-		goto out_fput;
-	}
+	if (unlikely(msg_len > info->attr.mq_msgsize))
+		return -EMSGSIZE;
 
 	/* First try to allocate memory, before doing anything with
 	 * existing queues. */
 	msg_ptr = load_msg(u_msg_ptr, msg_len);
-	if (IS_ERR(msg_ptr)) {
-		ret = PTR_ERR(msg_ptr);
-		goto out_fput;
-	}
+	if (IS_ERR(msg_ptr))
+		return PTR_ERR(msg_ptr);
 	msg_ptr->m_ts = msg_len;
 	msg_ptr->m_type = msg_prio;
 
@@ -1172,9 +1161,6 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 out_free:
 	if (ret)
 		free_msg(msg_ptr);
-out_fput:
-	fdput(f);
-out:
 	return ret;
 }
 
@@ -1184,7 +1170,6 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 {
 	ssize_t ret;
 	struct msg_msg *msg_ptr;
-	struct fd f;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
 	struct ext_wait_queue wait;
@@ -1198,30 +1183,22 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 	audit_mq_sendrecv(mqdes, msg_len, 0, ts);
 
-	f = fdget(mqdes);
-	if (unlikely(!fd_file(f))) {
-		ret = -EBADF;
-		goto out;
-	}
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f))
+		return -EBADF;
 
 	inode = file_inode(fd_file(f));
-	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
-		ret = -EBADF;
-		goto out_fput;
-	}
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
+		return -EBADF;
 	info = MQUEUE_I(inode);
 	audit_file(fd_file(f));
 
-	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ))) {
-		ret = -EBADF;
-		goto out_fput;
-	}
+	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ)))
+		return -EBADF;
 
 	/* checks if buffer is big enough */
-	if (unlikely(msg_len < info->attr.mq_msgsize)) {
-		ret = -EMSGSIZE;
-		goto out_fput;
-	}
+	if (unlikely(msg_len < info->attr.mq_msgsize))
+		return -EMSGSIZE;
 
 	/*
 	 * msg_insert really wants us to have a valid, spare node struct so
@@ -1275,9 +1252,6 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 		}
 		free_msg(msg_ptr);
 	}
-out_fput:
-	fdput(f);
-out:
 	return ret;
 }
 
@@ -1437,21 +1411,18 @@ SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
 
 static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
 {
-	struct fd f;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
 
 	if (new && (new->mq_flags & (~O_NONBLOCK)))
 		return -EINVAL;
 
-	f = fdget(mqdes);
-	if (!fd_file(f))
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f))
 		return -EBADF;
 
-	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
-		fdput(f);
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
 		return -EBADF;
-	}
 
 	inode = file_inode(fd_file(f));
 	info = MQUEUE_I(inode);
@@ -1475,7 +1446,6 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
 	}
 
 	spin_unlock(&info->lock);
-	fdput(f);
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4b39a1ea63e2..abb15cdbc5a3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4911,33 +4911,25 @@ static int bpf_link_get_info_by_fd(struct file *file,
 static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 				  union bpf_attr __user *uattr)
 {
-	int ufd = attr->info.bpf_fd;
-	struct fd f;
-	int err;
-
 	if (CHECK_ATTR(BPF_OBJ_GET_INFO_BY_FD))
 		return -EINVAL;
 
-	f = fdget(ufd);
-	if (!fd_file(f))
+	CLASS(fd, f)(attr->info.bpf_fd);
+	if (fd_empty(f))
 		return -EBADFD;
 
 	if (fd_file(f)->f_op == &bpf_prog_fops)
-		err = bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
+		return bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
 					      uattr);
 	else if (fd_file(f)->f_op == &bpf_map_fops)
-		err = bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
+		return bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
 					     uattr);
 	else if (fd_file(f)->f_op == &btf_fops)
-		err = bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
+		return bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
 	else if (fd_file(f)->f_op == &bpf_link_fops || fd_file(f)->f_op == &bpf_link_fops_poll)
-		err = bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
+		return bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
 					      attr, uattr);
-	else
-		err = -EINVAL;
-
-	fdput(f);
-	return err;
+	return -EINVAL;
 }
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 93cc9fea9d9d..ea036fd737b5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3196,10 +3196,7 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
-	int err;
-	struct fd f;
-
-	err = may_init_module();
+	int err = may_init_module();
 	if (err)
 		return err;
 
@@ -3210,12 +3207,10 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_COMPRESSED_FILE))
 		return -EINVAL;
 
-	f = fdget(fd);
+	CLASS(fd, f)(fd);
 	if (fd_empty(f))
 		return -EBADF;
-	err = idempotent_init_module(fd_file(f), uargs, flags);
-	fdput(f);
-	return err;
+	return idempotent_init_module(fd_file(f), uargs, flags);
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
diff --git a/kernel/pid.c b/kernel/pid.c
index b5bbc1a8a6e4..115448e89c3e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -744,23 +744,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
-	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
+	CLASS(fd, f)(pidfd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	pid = pidfd_pid(fd_file(f));
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
-	return ret;
+	return pidfd_getfd(pid, fd);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index cc5d87cfa7c0..e555d22f8e42 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3908,7 +3908,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
@@ -3921,20 +3920,17 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
+	CLASS(fd, f)(pidfd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	/* Is this a pidfd? */
 	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
-	ret = -EINVAL;
 	if (!access_pidfd_pidns(pid))
-		goto err;
+		return -EINVAL;
 
 	switch (flags) {
 	case 0:
@@ -3958,28 +3954,23 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);
 		if (unlikely(ret))
-			goto err;
+			return ret;
 
-		ret = -EINVAL;
 		if (unlikely(sig != kinfo.si_signo))
-			goto err;
+			return -EINVAL;
 
 		/* Only allow sending arbitrary signals to yourself. */
-		ret = -EPERM;
 		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
-			goto err;
+			return -EPERM;
 	} else {
 		prepare_kill_siginfo(sig, &kinfo, type);
 	}
 
 	if (type == PIDTYPE_PGID)
-		ret = kill_pgrp_info(sig, &kinfo, pid);
+		return kill_pgrp_info(sig, &kinfo, pid);
 	else
-		ret = kill_pid_info_type(sig, &kinfo, pid, type);
-err:
-	fdput(f);
-	return ret;
+		return kill_pid_info_type(sig, &kinfo, pid, type);
 }
 
 static int
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 0700f40c53ac..0cd680ccc7e5 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -411,15 +411,14 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *na;
 	size_t size;
 	u32 fd;
-	struct fd f;
 
 	na = info->attrs[CGROUPSTATS_CMD_ATTR_FD];
 	if (!na)
 		return -EINVAL;
 
 	fd = nla_get_u32(info->attrs[CGROUPSTATS_CMD_ATTR_FD]);
-	f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return 0;
 
 	size = nla_total_size(sizeof(struct cgroupstats));
@@ -427,14 +426,13 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 	rc = prepare_reply(info, CGROUPSTATS_CMD_NEW, &rep_skb,
 				size);
 	if (rc < 0)
-		goto err;
+		return rc;
 
 	na = nla_reserve(rep_skb, CGROUPSTATS_TYPE_CGROUP_STATS,
 				sizeof(struct cgroupstats));
 	if (na == NULL) {
 		nlmsg_free(rep_skb);
-		rc = -EMSGSIZE;
-		goto err;
+		return -EMSGSIZE;
 	}
 
 	stats = nla_data(na);
@@ -443,14 +441,10 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 	rc = cgroupstats_build(stats, fd_file(f)->f_path.dentry);
 	if (rc < 0) {
 		nlmsg_free(rep_skb);
-		goto err;
+		return rc;
 	}
 
-	rc = send_reply(rep_skb, info);
-
-err:
-	fdput(f);
-	return rc;
+	return send_reply(rep_skb, info);
 }
 
 static int cmd_attr_register_cpumask(struct genl_info *info)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e7c1d3ae33fe..e6b4cdd6e84c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1062,19 +1062,16 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
  */
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
-	struct fd f;
-
 	if (!buf || !size)
 		return;
 
-	f = fdget(kernel_fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(kernel_fd);
+	if (fd_empty(f))
 		return;
 
 	process_buffer_measurement(file_mnt_idmap(fd_file(f)), file_inode(fd_file(f)),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
-	fdput(f);
 }
 
 /**
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 02144ec39f43..68252452b66c 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -283,7 +283,6 @@ enum loadpin_securityfs_interface_index {
 
 static int read_trusted_verity_root_digests(unsigned int fd)
 {
-	struct fd f;
 	void *data;
 	int rc;
 	char *p, *d;
@@ -295,8 +294,8 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 	if (!list_empty(&dm_verity_loadpin_trusted_root_digests))
 		return -EPERM;
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return -EINVAL;
 
 	data = kzalloc(SZ_4K, GFP_KERNEL);
@@ -359,7 +358,6 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 	}
 
 	kfree(data);
-	fdput(f);
 
 	return 0;
 
@@ -379,8 +377,6 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 	/* disallow further attempts after reading a corrupt/invalid file */
 	deny_reading_verity_digests = true;
 
-	fdput(f);
-
 	return rc;
 }
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 53262b8a7656..72aa1fdeb699 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -229,14 +229,13 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
 	struct kvm_vfio_spapr_tce param;
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
-	struct fd f;
 	int ret;
 
 	if (copy_from_user(&param, arg, sizeof(struct kvm_vfio_spapr_tce)))
 		return -EFAULT;
 
-	f = fdget(param.groupfd);
-	if (!fd_file(f))
+	CLASS(fd, f)(param.groupfd);
+	if (fd_empty(f))
 		return -EBADF;
 
 	ret = -ENOENT;
@@ -262,7 +261,6 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
 
 err_fdput:
 	mutex_unlock(&kv->lock);
-	fdput(f);
 	return ret;
 }
 #endif
-- 
2.39.2


