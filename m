Return-Path: <linux-fsdevel+bounces-24534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE59406CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56724B21EF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F716C697;
	Tue, 30 Jul 2024 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7kLiTYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65716A920;
	Tue, 30 Jul 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316489; cv=none; b=h03y8CEwAo4uxQqlxBr/MHG3IMNZpYGyWJZdlILWrsYNISFH0POPG67y983d6lJtOwM8nfDY85pZyqeiMVtTPGa/fMTebORNHTncnfKbQvic6uJAlXayd6YXUutDYx1GnvJcFaX25ZhLOi9kV2WjoRHyvVpqZeLb9vvNhAwr/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316489; c=relaxed/simple;
	bh=zNzCTwDQFuXeo7bkixHMFP9scjVGApjDH4VmUifBhvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQBTciwpeBGO1hIwzNIjeXzkrtmxQPZMA9JHvarGNd4+YClbOmTOrPUpz/HR2X0smh0z9VKtmbFPNUHJrZNIbUUsGMOvNl+6Xl4ZF4xyF/3BvdidCgf8sNChjwP1TBKzsbRuuyo2o2Jar/KezB8dnGQvPBlnC3KxGh7/kqPfBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7kLiTYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790C7C4AF0A;
	Tue, 30 Jul 2024 05:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316488;
	bh=zNzCTwDQFuXeo7bkixHMFP9scjVGApjDH4VmUifBhvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7kLiTYBOZ0Ft5w2lRJEYYljK5xyzrLpGFtv0jQbjyWHiq2MlN9TywCzPltLuBYVa
	 /8dhENjKpQLc9xq7xGjKwuyI+clkQeVz4m/eW9udcTuoGA0hifmX/FLTiRppe4nu0i
	 YUoO4CmAgBZ/rmDTEoDwX1R6jFBe7fmwX3q72Eeztvy+vI9uVWNyQhM0mB0Gh/4Tbe
	 Vn8W98TC1XiVT+CdTN1u2PtfHfuAxBR8vjN3ZLutJBXM4k6zh5bwFz9jP3ZbxtCdTg
	 g8d4HfJMfJM64/s+iHLAf3fKaQ3J40besxsOBH7H6GwFLfCQBEnQp8lJQ2/92iVK/h
	 EoRDK3IbB/wbQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 02/39] introduce fd_file(), convert all accessors to it.
Date: Tue, 30 Jul 2024 01:15:48 -0400
Message-Id: <20240730051625.14349-2-viro@kernel.org>
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

	For any changes of struct fd representation we need to
turn existing accesses to fields into calls of wrappers.
Accesses to struct fd::flags are very few (3 in linux/file.h,
1 in net/socket.c, 3 in fs/overlayfs/file.c and 3 more in
explicit initializers).
	Those can be dealt with in the commit converting to
new layout; accesses to struct fd::file are too many for that.
	This commit converts (almost) all of f.file to
fd_file(f).  It's not entirely mechanical ('file' is used as
a member name more than just in struct fd) and it does not
even attempt to distinguish the uses in pointer context from
those in boolean context; the latter will be eventually turned
into a separate helper (fd_empty()).

	NOTE: mass conversion to fd_empty(), tempting as it
might be, is a bad idea; better do that piecewise in commit
that convert from fdget...() to CLASS(...).

[conflicts in fs/fhandle.c, kernel/bpf/syscall.c, mm/memcontrol.c
caught by git; fs/stat.c one got caught by git grep]
[fs/xattr.c conflict]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/osf_sys.c                |   4 +-
 arch/arm/kernel/sys_oabi-compat.c          |  10 +-
 arch/powerpc/kvm/book3s_64_vio.c           |   4 +-
 arch/powerpc/kvm/powerpc.c                 |  12 +--
 arch/powerpc/platforms/cell/spu_syscalls.c |   8 +-
 arch/x86/kernel/cpu/sgx/main.c             |   4 +-
 arch/x86/kvm/svm/sev.c                     |  16 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |   8 +-
 drivers/gpu/drm/drm_syncobj.c              |   6 +-
 drivers/infiniband/core/ucma.c             |   6 +-
 drivers/infiniband/core/uverbs_cmd.c       |   8 +-
 drivers/media/mc/mc-request.c              |   6 +-
 drivers/media/rc/lirc_dev.c                |   8 +-
 drivers/vfio/group.c                       |   6 +-
 drivers/vfio/virqfd.c                      |   6 +-
 drivers/virt/acrn/irqfd.c                  |   6 +-
 drivers/xen/privcmd.c                      |  10 +-
 fs/btrfs/ioctl.c                           |   4 +-
 fs/coda/inode.c                            |   4 +-
 fs/eventfd.c                               |   4 +-
 fs/eventpoll.c                             |  30 +++---
 fs/ext4/ioctl.c                            |   6 +-
 fs/f2fs/file.c                             |   6 +-
 fs/fcntl.c                                 |  38 +++----
 fs/fhandle.c                               |   4 +-
 fs/fsopen.c                                |   6 +-
 fs/fuse/dev.c                              |   6 +-
 fs/ioctl.c                                 |  30 +++---
 fs/kernel_read_file.c                      |   4 +-
 fs/locks.c                                 |  14 +--
 fs/namei.c                                 |  10 +-
 fs/namespace.c                             |  12 +--
 fs/notify/fanotify/fanotify_user.c         |  12 +--
 fs/notify/inotify/inotify_user.c           |  12 +--
 fs/ocfs2/cluster/heartbeat.c               |   6 +-
 fs/open.c                                  |  24 ++---
 fs/overlayfs/file.c                        |  40 +++----
 fs/quota/quota.c                           |   8 +-
 fs/read_write.c                            | 118 ++++++++++-----------
 fs/readdir.c                               |  20 ++--
 fs/remap_range.c                           |   2 +-
 fs/select.c                                |   8 +-
 fs/signalfd.c                              |   6 +-
 fs/smb/client/ioctl.c                      |   8 +-
 fs/splice.c                                |  22 ++--
 fs/stat.c                                  |   8 +-
 fs/statfs.c                                |   4 +-
 fs/sync.c                                  |  14 +--
 fs/timerfd.c                               |   8 +-
 fs/utimes.c                                |   4 +-
 fs/xattr.c                                 |  36 +++----
 fs/xfs/xfs_exchrange.c                     |   4 +-
 fs/xfs/xfs_handle.c                        |   4 +-
 fs/xfs/xfs_ioctl.c                         |  28 ++---
 include/linux/cleanup.h                    |   2 +-
 include/linux/file.h                       |   6 +-
 io_uring/sqpoll.c                          |  10 +-
 ipc/mqueue.c                               |  50 ++++-----
 kernel/bpf/bpf_inode_storage.c             |  14 +--
 kernel/bpf/btf.c                           |   6 +-
 kernel/bpf/syscall.c                       |  42 ++++----
 kernel/bpf/token.c                         |  10 +-
 kernel/cgroup/cgroup.c                     |   4 +-
 kernel/events/core.c                       |  12 +--
 kernel/module/main.c                       |   2 +-
 kernel/nsproxy.c                           |  12 +--
 kernel/pid.c                               |  10 +-
 kernel/signal.c                            |   6 +-
 kernel/sys.c                               |  10 +-
 kernel/taskstats.c                         |   4 +-
 kernel/watch_queue.c                       |   4 +-
 mm/fadvise.c                               |   4 +-
 mm/filemap.c                               |   6 +-
 mm/memcontrol-v1.c                         |  12 +--
 mm/readahead.c                             |  10 +-
 net/core/net_namespace.c                   |   6 +-
 net/socket.c                               |  12 +--
 security/integrity/ima/ima_main.c          |   4 +-
 security/landlock/syscalls.c               |  22 ++--
 security/loadpin/loadpin.c                 |   4 +-
 sound/core/pcm_native.c                    |   6 +-
 virt/kvm/eventfd.c                         |   6 +-
 virt/kvm/vfio.c                            |   8 +-
 83 files changed, 504 insertions(+), 502 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index e5f881bc8288..56fea57f9642 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -160,10 +160,10 @@ SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
 		.count = count
 	};
 
-	if (!arg.file)
+	if (!fd_file(arg))
 		return -EBADF;
 
-	error = iterate_dir(arg.file, &buf.ctx);
+	error = iterate_dir(fd_file(arg), &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
 	if (count != buf.count)
diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index d00f4040a9f5..f5781ff54a5c 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -239,19 +239,19 @@ asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
 	struct flock64 flock;
 	long err = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		goto out;
 
 	switch (cmd) {
 	case F_GETLK64:
 	case F_OFD_GETLK:
-		err = security_file_fcntl(f.file, cmd, arg);
+		err = security_file_fcntl(fd_file(f), cmd, arg);
 		if (err)
 			break;
 		err = get_oabi_flock(&flock, argp);
 		if (err)
 			break;
-		err = fcntl_getlk64(f.file, cmd, &flock);
+		err = fcntl_getlk64(fd_file(f), cmd, &flock);
 		if (!err)
 		       err = put_oabi_flock(&flock, argp);
 		break;
@@ -259,13 +259,13 @@ asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
 	case F_SETLKW64:
 	case F_OFD_SETLK:
 	case F_OFD_SETLKW:
-		err = security_file_fcntl(f.file, cmd, arg);
+		err = security_file_fcntl(fd_file(f), cmd, arg);
 		if (err)
 			break;
 		err = get_oabi_flock(&flock, argp);
 		if (err)
 			break;
-		err = fcntl_setlk64(fd, f.file, cmd, &flock);
+		err = fcntl_setlk64(fd, fd_file(f), cmd, &flock);
 		break;
 	default:
 		err = sys_fcntl64(fd, cmd, arg);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 3ff3de9a52ac..34c0adb9fdbf 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -118,12 +118,12 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	struct fd f;
 
 	f = fdget(tablefd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt == f.file->private_data) {
+		if (stt == fd_file(f)->private_data) {
 			found = true;
 			break;
 		}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 5e6c7b527677..f14329989e9a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1938,11 +1938,11 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 
 		r = -EBADF;
 		f = fdget(cap->args[0]);
-		if (!f.file)
+		if (!fd_file(f))
 			break;
 
 		r = -EPERM;
-		dev = kvm_device_from_filp(f.file);
+		dev = kvm_device_from_filp(fd_file(f));
 		if (dev)
 			r = kvmppc_mpic_connect_vcpu(dev, vcpu, cap->args[1]);
 
@@ -1957,11 +1957,11 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 
 		r = -EBADF;
 		f = fdget(cap->args[0]);
-		if (!f.file)
+		if (!fd_file(f))
 			break;
 
 		r = -EPERM;
-		dev = kvm_device_from_filp(f.file);
+		dev = kvm_device_from_filp(fd_file(f));
 		if (dev) {
 			if (xics_on_xive())
 				r = kvmppc_xive_connect_vcpu(dev, vcpu, cap->args[1]);
@@ -1980,7 +1980,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 
 		r = -EBADF;
 		f = fdget(cap->args[0]);
-		if (!f.file)
+		if (!fd_file(f))
 			break;
 
 		r = -ENXIO;
@@ -1990,7 +1990,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		}
 
 		r = -EPERM;
-		dev = kvm_device_from_filp(f.file);
+		dev = kvm_device_from_filp(fd_file(f));
 		if (dev)
 			r = kvmppc_xive_native_connect_vcpu(dev, vcpu,
 							    cap->args[1]);
diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 87ad7d563cfa..cd7d42fc12a6 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -66,8 +66,8 @@ SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 	if (flags & SPU_CREATE_AFFINITY_SPU) {
 		struct fd neighbor = fdget(neighbor_fd);
 		ret = -EBADF;
-		if (neighbor.file) {
-			ret = calls->create_thread(name, flags, mode, neighbor.file);
+		if (fd_file(neighbor)) {
+			ret = calls->create_thread(name, flags, mode, fd_file(neighbor));
 			fdput(neighbor);
 		}
 	} else
@@ -89,8 +89,8 @@ SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 
 	ret = -EBADF;
 	arg = fdget(fd);
-	if (arg.file) {
-		ret = calls->spu_run(arg.file, unpc, ustatus);
+	if (fd_file(arg)) {
+		ret = calls->spu_run(fd_file(arg), unpc, ustatus);
 		fdput(arg);
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 27892e57c4ef..d01deb386395 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -895,10 +895,10 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 {
 	struct fd f = fdget(attribute_fd);
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EINVAL;
 
-	if (f.file->f_op != &sgx_provision_fops) {
+	if (fd_file(f)->f_op != &sgx_provision_fops) {
 		fdput(f);
 		return -EINVAL;
 	}
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a16c873b3232..0e38b5223263 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -534,10 +534,10 @@ static int __sev_issue_cmd(int fd, int id, void *data, int *error)
 	int ret;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	ret = sev_issue_cmd_external_user(f.file, id, data, error);
+	ret = sev_issue_cmd_external_user(fd_file(f), id, data, error);
 
 	fdput(f);
 	return ret;
@@ -2078,15 +2078,15 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	bool charged = false;
 	int ret;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	if (!file_is_kvm(f.file)) {
+	if (!file_is_kvm(fd_file(f))) {
 		ret = -EBADF;
 		goto out_fput;
 	}
 
-	source_kvm = f.file->private_data;
+	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		goto out_fput;
@@ -2801,15 +2801,15 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	struct kvm_sev_info *source_sev, *mirror_sev;
 	int ret;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	if (!file_is_kvm(f.file)) {
+	if (!file_is_kvm(fd_file(f))) {
 		ret = -EBADF;
 		goto e_source_fput;
 	}
 
-	source_kvm = f.file->private_data;
+	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		goto e_source_fput;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 863b2a34b2d6..a9298cb8d19a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -43,10 +43,10 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 	uint32_t id;
 	int r;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EINVAL;
 
-	r = amdgpu_file_to_fpriv(f.file, &fpriv);
+	r = amdgpu_file_to_fpriv(fd_file(f), &fpriv);
 	if (r) {
 		fdput(f);
 		return r;
@@ -72,10 +72,10 @@ static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
 	struct amdgpu_ctx *ctx;
 	int r;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EINVAL;
 
-	r = amdgpu_file_to_fpriv(f.file, &fpriv);
+	r = amdgpu_file_to_fpriv(fd_file(f), &fpriv);
 	if (r) {
 		fdput(f);
 		return r;
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index a0e94217b511..7fb31ca3b5fc 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -715,16 +715,16 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 	struct fd f = fdget(fd);
 	int ret;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EINVAL;
 
-	if (f.file->f_op != &drm_syncobj_file_fops) {
+	if (fd_file(f)->f_op != &drm_syncobj_file_fops) {
 		fdput(f);
 		return -EINVAL;
 	}
 
 	/* take a reference to put in the idr */
-	syncobj = f.file->private_data;
+	syncobj = fd_file(f)->private_data;
 	drm_syncobj_get(syncobj);
 
 	idr_preload(GFP_KERNEL);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f5ad8faf86e..dc57d07a1f45 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1624,13 +1624,13 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 
 	/* Get current fd to protect against it being closed */
 	f = fdget(cmd.fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -ENOENT;
-	if (f.file->f_op != &ucma_fops) {
+	if (fd_file(f)->f_op != &ucma_fops) {
 		ret = -EINVAL;
 		goto file_put;
 	}
-	cur_file = f.file->private_data;
+	cur_file = fd_file(f)->private_data;
 
 	/* Validate current fd and prevent destruction of id. */
 	ctx = ucma_get_ctx(cur_file, cmd.id);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 1b3ea71f2c33..3f85575cf971 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -584,12 +584,12 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	if (cmd.fd != -1) {
 		/* search for file descriptor */
 		f = fdget(cmd.fd);
-		if (!f.file) {
+		if (!fd_file(f)) {
 			ret = -EBADF;
 			goto err_tree_mutex_unlock;
 		}
 
-		inode = file_inode(f.file);
+		inode = file_inode(fd_file(f));
 		xrcd = find_xrcd(ibudev, inode);
 		if (!xrcd && !(cmd.oflags & O_CREAT)) {
 			/* no file descriptor. Need CREATE flag */
@@ -632,7 +632,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 		atomic_inc(&xrcd->usecnt);
 	}
 
-	if (f.file)
+	if (fd_file(f))
 		fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
@@ -648,7 +648,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	uobj_alloc_abort(&obj->uobject, attrs);
 
 err_tree_mutex_unlock:
-	if (f.file)
+	if (fd_file(f))
 		fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index addb8f2d8939..e064914c476e 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -254,12 +254,12 @@ media_request_get_by_fd(struct media_device *mdev, int request_fd)
 		return ERR_PTR(-EBADR);
 
 	f = fdget(request_fd);
-	if (!f.file)
+	if (!fd_file(f))
 		goto err_no_req_fd;
 
-	if (f.file->f_op != &request_fops)
+	if (fd_file(f)->f_op != &request_fops)
 		goto err_fput;
-	req = f.file->private_data;
+	req = fd_file(f)->private_data;
 	if (req->mdev != mdev)
 		goto err_fput;
 
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 717c441b4a86..b8dfd530fab7 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -820,20 +820,20 @@ struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 	struct lirc_fh *fh;
 	struct rc_dev *dev;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
 
-	if (f.file->f_op != &lirc_fops) {
+	if (fd_file(f)->f_op != &lirc_fops) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (write && !(f.file->f_mode & FMODE_WRITE)) {
+	if (write && !(fd_file(f)->f_mode & FMODE_WRITE)) {
 		fdput(f);
 		return ERR_PTR(-EPERM);
 	}
 
-	fh = f.file->private_data;
+	fh = fd_file(f)->private_data;
 	dev = fh->rc;
 
 	get_device(&dev->dev);
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index ded364588d29..95b336de8a17 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -112,7 +112,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 		return -EFAULT;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	mutex_lock(&group->group_lock);
@@ -125,13 +125,13 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 		goto out_unlock;
 	}
 
-	container = vfio_container_from_file(f.file);
+	container = vfio_container_from_file(fd_file(f));
 	if (container) {
 		ret = vfio_container_attach_group(container, group);
 		goto out_unlock;
 	}
 
-	iommufd = iommufd_ctx_from_file(f.file);
+	iommufd = iommufd_ctx_from_file(fd_file(f));
 	if (!IS_ERR(iommufd)) {
 		if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
 		    group->type == VFIO_NO_IOMMU)
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 532269133801..d22881245e89 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -134,12 +134,12 @@ int vfio_virqfd_enable(void *opaque,
 	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
 
 	irqfd = fdget(fd);
-	if (!irqfd.file) {
+	if (!fd_file(irqfd)) {
 		ret = -EBADF;
 		goto err_fd;
 	}
 
-	ctx = eventfd_ctx_fileget(irqfd.file);
+	ctx = eventfd_ctx_fileget(fd_file(irqfd));
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto err_ctx;
@@ -171,7 +171,7 @@ int vfio_virqfd_enable(void *opaque,
 	init_waitqueue_func_entry(&virqfd->wait, virqfd_wakeup);
 	init_poll_funcptr(&virqfd->pt, virqfd_ptable_queue_proc);
 
-	events = vfs_poll(irqfd.file, &virqfd->pt);
+	events = vfs_poll(fd_file(irqfd), &virqfd->pt);
 
 	/*
 	 * Check if there was an event already pending on the eventfd
diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index d4ad211dce7a..9994d818bb7e 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -125,12 +125,12 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	INIT_WORK(&irqfd->shutdown, hsm_irqfd_shutdown_work);
 
 	f = fdget(args->fd);
-	if (!f.file) {
+	if (!fd_file(f)) {
 		ret = -EBADF;
 		goto out;
 	}
 
-	eventfd = eventfd_ctx_fileget(f.file);
+	eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);
 		goto fail;
@@ -157,7 +157,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	mutex_unlock(&vm->irqfds_lock);
 
 	/* Check the pending event in this stage */
-	events = vfs_poll(f.file, &irqfd->pt);
+	events = vfs_poll(fd_file(f), &irqfd->pt);
 
 	if (events & EPOLLIN)
 		acrn_irqfd_inject(irqfd);
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 9563650dfbaf..54e4f285c0f4 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -959,12 +959,12 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	INIT_WORK(&kirqfd->shutdown, irqfd_shutdown);
 
 	f = fdget(irqfd->fd);
-	if (!f.file) {
+	if (!fd_file(f)) {
 		ret = -EBADF;
 		goto error_kfree;
 	}
 
-	kirqfd->eventfd = eventfd_ctx_fileget(f.file);
+	kirqfd->eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(kirqfd->eventfd)) {
 		ret = PTR_ERR(kirqfd->eventfd);
 		goto error_fd_put;
@@ -995,7 +995,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	 * Check if there was an event already pending on the eventfd before we
 	 * registered, and trigger it as if we didn't miss it.
 	 */
-	events = vfs_poll(f.file, &kirqfd->pt);
+	events = vfs_poll(fd_file(f), &kirqfd->pt);
 	if (events & EPOLLIN)
 		irqfd_inject(kirqfd);
 
@@ -1345,12 +1345,12 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
 		return -ENOMEM;
 
 	f = fdget(ioeventfd->event_fd);
-	if (!f.file) {
+	if (!fd_file(f)) {
 		ret = -EBADF;
 		goto error_kfree;
 	}
 
-	kioeventfd->eventfd = eventfd_ctx_fileget(f.file);
+	kioeventfd->eventfd = eventfd_ctx_fileget(fd_file(f));
 	fdput(f);
 
 	if (IS_ERR(kioeventfd->eventfd)) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..32ddd3d31719 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1312,12 +1312,12 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	} else {
 		struct fd src = fdget(fd);
 		struct inode *src_inode;
-		if (!src.file) {
+		if (!fd_file(src)) {
 			ret = -EINVAL;
 			goto out_drop_write;
 		}
 
-		src_inode = file_inode(src.file);
+		src_inode = file_inode(fd_file(src));
 		if (src_inode->i_sb != file_inode(file)->i_sb) {
 			btrfs_info(BTRFS_I(file_inode(file))->root->fs_info,
 				   "Snapshot src from another FS");
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 6898dc621011..7d56b6d1e4c3 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -127,9 +127,9 @@ static int coda_parse_fd(struct fs_context *fc, int fd)
 	int idx;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	inode = file_inode(f.file);
+	inode = file_inode(fd_file(f));
 	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
 		fdput(f);
 		return invalf(fc, "code: Not coda psdev");
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9afdb722fa92..22c934f3a080 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -349,9 +349,9 @@ struct eventfd_ctx *eventfd_ctx_fdget(int fd)
 {
 	struct eventfd_ctx *ctx;
 	struct fd f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
-	ctx = eventfd_ctx_fileget(f.file);
+	ctx = eventfd_ctx_fileget(fd_file(f));
 	fdput(f);
 	return ctx;
 }
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..28d1a754cf33 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2266,17 +2266,17 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 
 	error = -EBADF;
 	f = fdget(epfd);
-	if (!f.file)
+	if (!fd_file(f))
 		goto error_return;
 
 	/* Get the "struct file *" for the target file */
 	tf = fdget(fd);
-	if (!tf.file)
+	if (!fd_file(tf))
 		goto error_fput;
 
 	/* The target file descriptor must support poll */
 	error = -EPERM;
-	if (!file_can_poll(tf.file))
+	if (!file_can_poll(fd_file(tf)))
 		goto error_tgt_fput;
 
 	/* Check if EPOLLWAKEUP is allowed */
@@ -2289,7 +2289,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * adding an epoll file descriptor inside itself.
 	 */
 	error = -EINVAL;
-	if (f.file == tf.file || !is_file_epoll(f.file))
+	if (fd_file(f) == fd_file(tf) || !is_file_epoll(fd_file(f)))
 		goto error_tgt_fput;
 
 	/*
@@ -2300,7 +2300,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (ep_op_has_event(op) && (epds->events & EPOLLEXCLUSIVE)) {
 		if (op == EPOLL_CTL_MOD)
 			goto error_tgt_fput;
-		if (op == EPOLL_CTL_ADD && (is_file_epoll(tf.file) ||
+		if (op == EPOLL_CTL_ADD && (is_file_epoll(fd_file(tf)) ||
 				(epds->events & ~EPOLLEXCLUSIVE_OK_BITS)))
 			goto error_tgt_fput;
 	}
@@ -2309,7 +2309,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * At this point it is safe to assume that the "private_data" contains
 	 * our own data structure.
 	 */
-	ep = f.file->private_data;
+	ep = fd_file(f)->private_data;
 
 	/*
 	 * When we insert an epoll file descriptor inside another epoll file
@@ -2330,16 +2330,16 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	if (error)
 		goto error_tgt_fput;
 	if (op == EPOLL_CTL_ADD) {
-		if (READ_ONCE(f.file->f_ep) || ep->gen == loop_check_gen ||
-		    is_file_epoll(tf.file)) {
+		if (READ_ONCE(fd_file(f)->f_ep) || ep->gen == loop_check_gen ||
+		    is_file_epoll(fd_file(tf))) {
 			mutex_unlock(&ep->mtx);
 			error = epoll_mutex_lock(&epnested_mutex, 0, nonblock);
 			if (error)
 				goto error_tgt_fput;
 			loop_check_gen++;
 			full_check = 1;
-			if (is_file_epoll(tf.file)) {
-				tep = tf.file->private_data;
+			if (is_file_epoll(fd_file(tf))) {
+				tep = fd_file(tf)->private_data;
 				error = -ELOOP;
 				if (ep_loop_check(ep, tep) != 0)
 					goto error_tgt_fput;
@@ -2355,14 +2355,14 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	 * above, we can be sure to be able to use the item looked up by
 	 * ep_find() till we release the mutex.
 	 */
-	epi = ep_find(ep, tf.file, fd);
+	epi = ep_find(ep, fd_file(tf), fd);
 
 	error = -EINVAL;
 	switch (op) {
 	case EPOLL_CTL_ADD:
 		if (!epi) {
 			epds->events |= EPOLLERR | EPOLLHUP;
-			error = ep_insert(ep, epds, tf.file, fd, full_check);
+			error = ep_insert(ep, epds, fd_file(tf), fd, full_check);
 		} else
 			error = -EEXIST;
 		break;
@@ -2443,7 +2443,7 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 
 	/* Get the "struct file *" for the eventpoll file */
 	f = fdget(epfd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	/*
@@ -2451,14 +2451,14 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	 * the user passed to us _is_ an eventpoll file.
 	 */
 	error = -EINVAL;
-	if (!is_file_epoll(f.file))
+	if (!is_file_epoll(fd_file(f)))
 		goto error_fput;
 
 	/*
 	 * At this point it is safe to assume that the "private_data" contains
 	 * our own data structure.
 	 */
-	ep = f.file->private_data;
+	ep = fd_file(f)->private_data;
 
 	/* Time to fish for events ... */
 	error = ep_poll(ep, events, maxevents, to);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8bf5972dd47..1c77400bd88e 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1343,10 +1343,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		me.moved_len = 0;
 
 		donor = fdget(me.donor_fd);
-		if (!donor.file)
+		if (!fd_file(donor))
 			return -EBADF;
 
-		if (!(donor.file->f_mode & FMODE_WRITE)) {
+		if (!(fd_file(donor)->f_mode & FMODE_WRITE)) {
 			err = -EBADF;
 			goto mext_out;
 		}
@@ -1367,7 +1367,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (err)
 			goto mext_out;
 
-		err = ext4_move_extents(filp, donor.file, me.orig_start,
+		err = ext4_move_extents(filp, fd_file(donor), me.orig_start,
 					me.donor_start, me.len, &me.moved_len);
 		mnt_drop_write_file(filp);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..903337f8d21a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3014,10 +3014,10 @@ static int __f2fs_ioc_move_range(struct file *filp,
 		return -EBADF;
 
 	dst = fdget(range->dst_fd);
-	if (!dst.file)
+	if (!fd_file(dst))
 		return -EBADF;
 
-	if (!(dst.file->f_mode & FMODE_WRITE)) {
+	if (!(fd_file(dst)->f_mode & FMODE_WRITE)) {
 		err = -EBADF;
 		goto err_out;
 	}
@@ -3026,7 +3026,7 @@ static int __f2fs_ioc_move_range(struct file *filp,
 	if (err)
 		goto err_out;
 
-	err = f2fs_move_file_range(filp, range->pos_in, dst.file,
+	err = f2fs_move_file_range(filp, range->pos_in, fd_file(dst),
 					range->pos_out, range->len);
 
 	mnt_drop_write_file(filp);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..2b5616762354 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -340,7 +340,7 @@ static long f_dupfd_query(int fd, struct file *filp)
 	 * overkill, but given our lockless file pointer lookup, the
 	 * alternatives are complicated.
 	 */
-	return f.file == filp;
+	return fd_file(f) == filp;
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -479,17 +479,17 @@ SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 	struct fd f = fdget_raw(fd);
 	long err = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		goto out;
 
-	if (unlikely(f.file->f_mode & FMODE_PATH)) {
+	if (unlikely(fd_file(f)->f_mode & FMODE_PATH)) {
 		if (!check_fcntl_cmd(cmd))
 			goto out1;
 	}
 
-	err = security_file_fcntl(f.file, cmd, arg);
+	err = security_file_fcntl(fd_file(f), cmd, arg);
 	if (!err)
-		err = do_fcntl(fd, cmd, arg, f.file);
+		err = do_fcntl(fd, cmd, arg, fd_file(f));
 
 out1:
  	fdput(f);
@@ -506,15 +506,15 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 	struct flock64 flock;
 	long err = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		goto out;
 
-	if (unlikely(f.file->f_mode & FMODE_PATH)) {
+	if (unlikely(fd_file(f)->f_mode & FMODE_PATH)) {
 		if (!check_fcntl_cmd(cmd))
 			goto out1;
 	}
 
-	err = security_file_fcntl(f.file, cmd, arg);
+	err = security_file_fcntl(fd_file(f), cmd, arg);
 	if (err)
 		goto out1;
 	
@@ -524,7 +524,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 		err = -EFAULT;
 		if (copy_from_user(&flock, argp, sizeof(flock)))
 			break;
-		err = fcntl_getlk64(f.file, cmd, &flock);
+		err = fcntl_getlk64(fd_file(f), cmd, &flock);
 		if (!err && copy_to_user(argp, &flock, sizeof(flock)))
 			err = -EFAULT;
 		break;
@@ -535,10 +535,10 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 		err = -EFAULT;
 		if (copy_from_user(&flock, argp, sizeof(flock)))
 			break;
-		err = fcntl_setlk64(fd, f.file, cmd, &flock);
+		err = fcntl_setlk64(fd, fd_file(f), cmd, &flock);
 		break;
 	default:
-		err = do_fcntl(fd, cmd, arg, f.file);
+		err = do_fcntl(fd, cmd, arg, fd_file(f));
 		break;
 	}
 out1:
@@ -643,15 +643,15 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 	struct flock flock;
 	long err = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return err;
 
-	if (unlikely(f.file->f_mode & FMODE_PATH)) {
+	if (unlikely(fd_file(f)->f_mode & FMODE_PATH)) {
 		if (!check_fcntl_cmd(cmd))
 			goto out_put;
 	}
 
-	err = security_file_fcntl(f.file, cmd, arg);
+	err = security_file_fcntl(fd_file(f), cmd, arg);
 	if (err)
 		goto out_put;
 
@@ -660,7 +660,7 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 		err = get_compat_flock(&flock, compat_ptr(arg));
 		if (err)
 			break;
-		err = fcntl_getlk(f.file, convert_fcntl_cmd(cmd), &flock);
+		err = fcntl_getlk(fd_file(f), convert_fcntl_cmd(cmd), &flock);
 		if (err)
 			break;
 		err = fixup_compat_flock(&flock);
@@ -672,7 +672,7 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 		err = get_compat_flock64(&flock, compat_ptr(arg));
 		if (err)
 			break;
-		err = fcntl_getlk(f.file, convert_fcntl_cmd(cmd), &flock);
+		err = fcntl_getlk(fd_file(f), convert_fcntl_cmd(cmd), &flock);
 		if (!err)
 			err = put_compat_flock64(&flock, compat_ptr(arg));
 		break;
@@ -681,7 +681,7 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 		err = get_compat_flock(&flock, compat_ptr(arg));
 		if (err)
 			break;
-		err = fcntl_setlk(fd, f.file, convert_fcntl_cmd(cmd), &flock);
+		err = fcntl_setlk(fd, fd_file(f), convert_fcntl_cmd(cmd), &flock);
 		break;
 	case F_SETLK64:
 	case F_SETLKW64:
@@ -690,10 +690,10 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 		err = get_compat_flock64(&flock, compat_ptr(arg));
 		if (err)
 			break;
-		err = fcntl_setlk(fd, f.file, convert_fcntl_cmd(cmd), &flock);
+		err = fcntl_setlk(fd, fd_file(f), convert_fcntl_cmd(cmd), &flock);
 		break;
 	default:
-		err = do_fcntl(fd, cmd, arg, f.file);
+		err = do_fcntl(fd, cmd, arg, fd_file(f));
 		break;
 	}
 out_put:
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6e8cea16790e..3f07b52874a8 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -125,9 +125,9 @@ static int get_path_from_fd(int fd, struct path *root)
 		spin_unlock(&fs->lock);
 	} else {
 		struct fd f = fdget(fd);
-		if (!f.file)
+		if (!fd_file(f))
 			return -EBADF;
-		*root = f.file->f_path;
+		*root = fd_file(f)->f_path;
 		path_get(root);
 		fdput(f);
 	}
diff --git a/fs/fsopen.c b/fs/fsopen.c
index ed2dd000622e..ee92ca58429e 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -394,13 +394,13 @@ SYSCALL_DEFINE5(fsconfig,
 	}
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 	ret = -EINVAL;
-	if (f.file->f_op != &fscontext_fops)
+	if (fd_file(f)->f_op != &fscontext_fops)
 		goto out_f;
 
-	fc = f.file->private_data;
+	fc = fd_file(f)->private_data;
 	if (fc->ops == &legacy_fs_context_ops) {
 		switch (cmd) {
 		case FSCONFIG_SET_BINARY:
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..991b9ae8e7c9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2321,15 +2321,15 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 		return -EFAULT;
 
 	f = fdget(oldfd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EINVAL;
 
 	/*
 	 * Check against file->f_op because CUSE
 	 * uses the same ioctl handler.
 	 */
-	if (f.file->f_op == file->f_op)
-		fud = fuse_get_dev(f.file);
+	if (fd_file(f)->f_op == file->f_op)
+		fud = fuse_get_dev(fd_file(f));
 
 	res = -EINVAL;
 	if (fud) {
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 64776891120c..6e0c954388d4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -235,9 +235,9 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 	loff_t cloned;
 	int ret;
 
-	if (!src_file.file)
+	if (!fd_file(src_file))
 		return -EBADF;
-	cloned = vfs_clone_file_range(src_file.file, off, dst_file, destoff,
+	cloned = vfs_clone_file_range(fd_file(src_file), off, dst_file, destoff,
 				      olen, 0);
 	if (cloned < 0)
 		ret = cloned;
@@ -895,16 +895,16 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 	struct fd f = fdget(fd);
 	int error;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl(fd_file(f), cmd, arg);
 	if (error)
 		goto out;
 
-	error = do_vfs_ioctl(f.file, fd, cmd, arg);
+	error = do_vfs_ioctl(fd_file(f), fd, cmd, arg);
 	if (error == -ENOIOCTLCMD)
-		error = vfs_ioctl(f.file, cmd, arg);
+		error = vfs_ioctl(fd_file(f), cmd, arg);
 
 out:
 	fdput(f);
@@ -953,32 +953,32 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	struct fd f = fdget(fd);
 	int error;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = security_file_ioctl_compat(f.file, cmd, arg);
+	error = security_file_ioctl_compat(fd_file(f), cmd, arg);
 	if (error)
 		goto out;
 
 	switch (cmd) {
 	/* FICLONE takes an int argument, so don't use compat_ptr() */
 	case FICLONE:
-		error = ioctl_file_clone(f.file, arg, 0, 0, 0);
+		error = ioctl_file_clone(fd_file(f), arg, 0, 0, 0);
 		break;
 
 #if defined(CONFIG_X86_64)
 	/* these get messy on amd64 due to alignment differences */
 	case FS_IOC_RESVSP_32:
 	case FS_IOC_RESVSP64_32:
-		error = compat_ioctl_preallocate(f.file, 0, compat_ptr(arg));
+		error = compat_ioctl_preallocate(fd_file(f), 0, compat_ptr(arg));
 		break;
 	case FS_IOC_UNRESVSP_32:
 	case FS_IOC_UNRESVSP64_32:
-		error = compat_ioctl_preallocate(f.file, FALLOC_FL_PUNCH_HOLE,
+		error = compat_ioctl_preallocate(fd_file(f), FALLOC_FL_PUNCH_HOLE,
 				compat_ptr(arg));
 		break;
 	case FS_IOC_ZERO_RANGE_32:
-		error = compat_ioctl_preallocate(f.file, FALLOC_FL_ZERO_RANGE,
+		error = compat_ioctl_preallocate(fd_file(f), FALLOC_FL_ZERO_RANGE,
 				compat_ptr(arg));
 		break;
 #endif
@@ -998,13 +998,13 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	 * argument.
 	 */
 	default:
-		error = do_vfs_ioctl(f.file, fd, cmd,
+		error = do_vfs_ioctl(fd_file(f), fd, cmd,
 				     (unsigned long)compat_ptr(arg));
 		if (error != -ENOIOCTLCMD)
 			break;
 
-		if (f.file->f_op->compat_ioctl)
-			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
+		if (fd_file(f)->f_op->compat_ioctl)
+			error = fd_file(f)->f_op->compat_ioctl(fd_file(f), cmd, arg);
 		if (error == -ENOIOCTLCMD)
 			error = -ENOTTY;
 		break;
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index c429c42a6867..9ff37ae650ea 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -178,10 +178,10 @@ ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
 	struct fd f = fdget(fd);
 	ssize_t ret = -EBADF;
 
-	if (!f.file || !(f.file->f_mode & FMODE_READ))
+	if (!fd_file(f) || !(fd_file(f)->f_mode & FMODE_READ))
 		goto out;
 
-	ret = kernel_read_file(f.file, offset, buf, buf_size, file_size, id);
+	ret = kernel_read_file(fd_file(f), offset, buf, buf_size, file_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/fs/locks.c b/fs/locks.c
index 9afb16e0683f..239759a356e9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2153,15 +2153,15 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 
 	error = -EBADF;
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return error;
 
-	if (type != F_UNLCK && !(f.file->f_mode & (FMODE_READ | FMODE_WRITE)))
+	if (type != F_UNLCK && !(fd_file(f)->f_mode & (FMODE_READ | FMODE_WRITE)))
 		goto out_putf;
 
-	flock_make_lock(f.file, &fl, type);
+	flock_make_lock(fd_file(f), &fl, type);
 
-	error = security_file_lock(f.file, fl.c.flc_type);
+	error = security_file_lock(fd_file(f), fl.c.flc_type);
 	if (error)
 		goto out_putf;
 
@@ -2169,12 +2169,12 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	if (can_sleep)
 		fl.c.flc_flags |= FL_SLEEP;
 
-	if (f.file->f_op->flock)
-		error = f.file->f_op->flock(f.file,
+	if (fd_file(f)->f_op->flock)
+		error = fd_file(f)->f_op->flock(fd_file(f),
 					    (can_sleep) ? F_SETLKW : F_SETLK,
 					    &fl);
 	else
-		error = locks_lock_file_wait(f.file, &fl);
+		error = locks_lock_file_wait(fd_file(f), &fl);
 
 	locks_release_private(&fl);
  out_putf:
diff --git a/fs/namei.c b/fs/namei.c
index 5512cb10fa89..af86e3330594 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2492,25 +2492,25 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		struct fd f = fdget_raw(nd->dfd);
 		struct dentry *dentry;
 
-		if (!f.file)
+		if (!fd_file(f))
 			return ERR_PTR(-EBADF);
 
 		if (flags & LOOKUP_LINKAT_EMPTY) {
-			if (f.file->f_cred != current_cred() &&
-			    !ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
+			if (fd_file(f)->f_cred != current_cred() &&
+			    !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
 				fdput(f);
 				return ERR_PTR(-ENOENT);
 			}
 		}
 
-		dentry = f.file->f_path.dentry;
+		dentry = fd_file(f)->f_path.dentry;
 
 		if (*s && unlikely(!d_can_lookup(dentry))) {
 			fdput(f);
 			return ERR_PTR(-ENOTDIR);
 		}
 
-		nd->path = f.file->f_path;
+		nd->path = fd_file(f)->f_path;
 		if (flags & LOOKUP_RCU) {
 			nd->inode = nd->path.dentry->d_inode;
 			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..c46d48bb38cd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4099,14 +4099,14 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	}
 
 	f = fdget(fs_fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	ret = -EINVAL;
-	if (f.file->f_op != &fscontext_fops)
+	if (fd_file(f)->f_op != &fscontext_fops)
 		goto err_fsfd;
 
-	fc = f.file->private_data;
+	fc = fd_file(f)->private_data;
 
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret < 0)
@@ -4649,15 +4649,15 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 		return -EINVAL;
 
 	f = fdget(attr->userns_fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	if (!proc_ns_file(f.file)) {
+	if (!proc_ns_file(fd_file(f))) {
 		err = -EINVAL;
 		goto out_fput;
 	}
 
-	ns = get_proc_ns(file_inode(f.file));
+	ns = get_proc_ns(file_inode(fd_file(f)));
 	if (ns->ops->type != CLONE_NEWUSER) {
 		err = -EINVAL;
 		goto out_fput;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ec313e9f6e1..13454e5fd3fb 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1006,17 +1006,17 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 		struct fd f = fdget(dfd);
 
 		ret = -EBADF;
-		if (!f.file)
+		if (!fd_file(f))
 			goto out;
 
 		ret = -ENOTDIR;
 		if ((flags & FAN_MARK_ONLYDIR) &&
-		    !(S_ISDIR(file_inode(f.file)->i_mode))) {
+		    !(S_ISDIR(file_inode(fd_file(f))->i_mode))) {
 			fdput(f);
 			goto out;
 		}
 
-		*path = f.file->f_path;
+		*path = fd_file(f)->f_path;
 		path_get(path);
 		fdput(f);
 	} else {
@@ -1753,14 +1753,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	f = fdget(fanotify_fd);
-	if (unlikely(!f.file))
+	if (unlikely(!fd_file(f)))
 		return -EBADF;
 
 	/* verify that this is indeed an fanotify instance */
 	ret = -EINVAL;
-	if (unlikely(f.file->f_op != &fanotify_fops))
+	if (unlikely(fd_file(f)->f_op != &fanotify_fops))
 		goto fput_and_out;
-	group = f.file->private_data;
+	group = fd_file(f)->private_data;
 
 	/*
 	 * An unprivileged user is not allowed to setup mount nor filesystem
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 4ffc30606e0b..c7e451d5bd51 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -753,7 +753,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 		return -EINVAL;
 
 	f = fdget(fd);
-	if (unlikely(!f.file))
+	if (unlikely(!fd_file(f)))
 		return -EBADF;
 
 	/* IN_MASK_ADD and IN_MASK_CREATE don't make sense together */
@@ -763,7 +763,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	}
 
 	/* verify that this is indeed an inotify instance */
-	if (unlikely(f.file->f_op != &inotify_fops)) {
+	if (unlikely(fd_file(f)->f_op != &inotify_fops)) {
 		ret = -EINVAL;
 		goto fput_and_out;
 	}
@@ -780,7 +780,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 
 	/* inode held in place by reference to path; group by fget on fd */
 	inode = path.dentry->d_inode;
-	group = f.file->private_data;
+	group = fd_file(f)->private_data;
 
 	/* create/update an inode mark */
 	ret = inotify_update_watch(group, inode, mask);
@@ -798,14 +798,14 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
 	int ret = -EINVAL;
 
 	f = fdget(fd);
-	if (unlikely(!f.file))
+	if (unlikely(!fd_file(f)))
 		return -EBADF;
 
 	/* verify that this is indeed an inotify instance */
-	if (unlikely(f.file->f_op != &inotify_fops))
+	if (unlikely(fd_file(f)->f_op != &inotify_fops))
 		goto out;
 
-	group = f.file->private_data;
+	group = fd_file(f)->private_data;
 
 	i_mark = inotify_idr_find(group, wd);
 	if (unlikely(!i_mark))
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 1bde1281d514..4b9f45d7049e 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1785,17 +1785,17 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		goto out;
 
 	f = fdget(fd);
-	if (f.file == NULL)
+	if (fd_file(f) == NULL)
 		goto out;
 
 	if (reg->hr_blocks == 0 || reg->hr_start_block == 0 ||
 	    reg->hr_block_bytes == 0)
 		goto out2;
 
-	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
+	if (!S_ISBLK(fd_file(f)->f_mapping->host->i_mode))
 		goto out2;
 
-	reg->hr_bdev_file = bdev_file_open_by_dev(f.file->f_mapping->host->i_rdev,
+	reg->hr_bdev_file = bdev_file_open_by_dev(fd_file(f)->f_mapping->host->i_rdev,
 			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
 	if (IS_ERR(reg->hr_bdev_file)) {
 		ret = PTR_ERR(reg->hr_bdev_file);
diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..a388828ccd22 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -193,10 +193,10 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (length < 0)
 		return -EINVAL;
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = do_ftruncate(f.file, length, small);
+	error = do_ftruncate(fd_file(f), length, small);
 
 	fdput(f);
 	return error;
@@ -353,8 +353,8 @@ int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 	struct fd f = fdget(fd);
 	int error = -EBADF;
 
-	if (f.file) {
-		error = vfs_fallocate(f.file, mode, offset, len);
+	if (fd_file(f)) {
+		error = vfs_fallocate(fd_file(f), mode, offset, len);
 		fdput(f);
 	}
 	return error;
@@ -585,16 +585,16 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	int error;
 
 	error = -EBADF;
-	if (!f.file)
+	if (!fd_file(f))
 		goto out;
 
 	error = -ENOTDIR;
-	if (!d_can_lookup(f.file->f_path.dentry))
+	if (!d_can_lookup(fd_file(f)->f_path.dentry))
 		goto out_putf;
 
-	error = file_permission(f.file, MAY_EXEC | MAY_CHDIR);
+	error = file_permission(fd_file(f), MAY_EXEC | MAY_CHDIR);
 	if (!error)
-		set_fs_pwd(current->fs, &f.file->f_path);
+		set_fs_pwd(current->fs, &fd_file(f)->f_path);
 out_putf:
 	fdput(f);
 out:
@@ -675,8 +675,8 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	struct fd f = fdget(fd);
 	int err = -EBADF;
 
-	if (f.file) {
-		err = vfs_fchmod(f.file, mode);
+	if (fd_file(f)) {
+		err = vfs_fchmod(fd_file(f), mode);
 		fdput(f);
 	}
 	return err;
@@ -869,8 +869,8 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 	struct fd f = fdget(fd);
 	int error = -EBADF;
 
-	if (f.file) {
-		error = vfs_fchown(f.file, user, group);
+	if (fd_file(f)) {
+		error = vfs_fchown(fd_file(f), user, group);
 		fdput(f);
 	}
 	return error;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1a411cae57ed..c4963d0c5549 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -209,13 +209,13 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	 * files, so we use the real file to perform seeks.
 	 */
 	ovl_inode_lock(inode);
-	real.file->f_pos = file->f_pos;
+	fd_file(real)->f_pos = file->f_pos;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	ret = vfs_llseek(real.file, offset, whence);
+	ret = vfs_llseek(fd_file(real), offset, whence);
 	revert_creds(old_cred);
 
-	file->f_pos = real.file->f_pos;
+	file->f_pos = fd_file(real)->f_pos;
 	ovl_inode_unlock(inode);
 
 	fdput(real);
@@ -275,7 +275,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		return ret;
 
-	ret = backing_file_read_iter(real.file, iter, iocb, iocb->ki_flags,
+	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
 				     &ctx);
 	fdput(real);
 
@@ -314,7 +314,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-	ret = backing_file_write_iter(real.file, iter, iocb, ifl, &ctx);
+	ret = backing_file_write_iter(fd_file(real), iter, iocb, ifl, &ctx);
 	fdput(real);
 
 out_unlock:
@@ -339,7 +339,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 	if (ret)
 		return ret;
 
-	ret = backing_file_splice_read(real.file, ppos, pipe, len, flags, &ctx);
+	ret = backing_file_splice_read(fd_file(real), ppos, pipe, len, flags, &ctx);
 	fdput(real);
 
 	return ret;
@@ -348,7 +348,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
  * due to lock order inversion between pipe->mutex in iter_file_splice_write()
- * and file_start_write(real.file) in ovl_write_iter().
+ * and file_start_write(fd_file(real)) in ovl_write_iter().
  *
  * So do everything ovl_write_iter() does and call iter_file_splice_write() on
  * the real file.
@@ -373,7 +373,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	if (ret)
 		goto out_unlock;
 
-	ret = backing_file_splice_write(pipe, real.file, ppos, len, flags, &ctx);
+	ret = backing_file_splice_write(pipe, fd_file(real), ppos, len, flags, &ctx);
 	fdput(real);
 
 out_unlock:
@@ -397,9 +397,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
+	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		ret = vfs_fsync_range(real.file, start, end, datasync);
+		ret = vfs_fsync_range(fd_file(real), start, end, datasync);
 		revert_creds(old_cred);
 	}
 
@@ -439,7 +439,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 		goto out_unlock;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fallocate(real.file, mode, offset, len);
+	ret = vfs_fallocate(fd_file(real), mode, offset, len);
 	revert_creds(old_cred);
 
 	/* Update size */
@@ -464,7 +464,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		return ret;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(real.file, offset, len, advice);
+	ret = vfs_fadvise(fd_file(real), offset, len, advice);
 	revert_creds(old_cred);
 
 	fdput(real);
@@ -509,18 +509,18 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
 	switch (op) {
 	case OVL_COPY:
-		ret = vfs_copy_file_range(real_in.file, pos_in,
-					  real_out.file, pos_out, len, flags);
+		ret = vfs_copy_file_range(fd_file(real_in), pos_in,
+					  fd_file(real_out), pos_out, len, flags);
 		break;
 
 	case OVL_CLONE:
-		ret = vfs_clone_file_range(real_in.file, pos_in,
-					   real_out.file, pos_out, len, flags);
+		ret = vfs_clone_file_range(fd_file(real_in), pos_in,
+					   fd_file(real_out), pos_out, len, flags);
 		break;
 
 	case OVL_DEDUPE:
-		ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
-						real_out.file, pos_out, len,
+		ret = vfs_dedupe_file_range_one(fd_file(real_in), pos_in,
+						fd_file(real_out), pos_out, len,
 						flags);
 		break;
 	}
@@ -583,9 +583,9 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 	if (err)
 		return err;
 
-	if (real.file->f_op->flush) {
+	if (fd_file(real)->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		err = real.file->f_op->flush(real.file, id);
+		err = fd_file(real)->f_op->flush(fd_file(real), id);
 		revert_creds(old_cred);
 	}
 	fdput(real);
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 0e41fb84060f..290157bc7bec 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -980,7 +980,7 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 	int ret;
 
 	f = fdget_raw(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	ret = -EINVAL;
@@ -988,12 +988,12 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 		goto out;
 
 	if (quotactl_cmd_write(cmds)) {
-		ret = mnt_want_write(f.file->f_path.mnt);
+		ret = mnt_want_write(fd_file(f)->f_path.mnt);
 		if (ret)
 			goto out;
 	}
 
-	sb = f.file->f_path.mnt->mnt_sb;
+	sb = fd_file(f)->f_path.mnt->mnt_sb;
 	if (quotactl_cmd_onoff(cmds))
 		down_write(&sb->s_umount);
 	else
@@ -1007,7 +1007,7 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 		up_read(&sb->s_umount);
 
 	if (quotactl_cmd_write(cmds))
-		mnt_drop_write(f.file->f_path.mnt);
+		mnt_drop_write(fd_file(f)->f_path.mnt);
 out:
 	fdput(f);
 	return ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index 90e283b31ca1..59d6d0dee579 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -294,12 +294,12 @@ static off_t ksys_lseek(unsigned int fd, off_t offset, unsigned int whence)
 {
 	off_t retval;
 	struct fd f = fdget_pos(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	retval = -EINVAL;
 	if (whence <= SEEK_MAX) {
-		loff_t res = vfs_llseek(f.file, offset, whence);
+		loff_t res = vfs_llseek(fd_file(f), offset, whence);
 		retval = res;
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
@@ -330,14 +330,14 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 	struct fd f = fdget_pos(fd);
 	loff_t offset;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	retval = -EINVAL;
 	if (whence > SEEK_MAX)
 		goto out_putf;
 
-	offset = vfs_llseek(f.file, ((loff_t) offset_high << 32) | offset_low,
+	offset = vfs_llseek(fd_file(f), ((loff_t) offset_high << 32) | offset_low,
 			whence);
 
 	retval = (int)offset;
@@ -610,15 +610,15 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
 
-	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
+	if (fd_file(f)) {
+		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
 			ppos = &pos;
 		}
-		ret = vfs_read(f.file, buf, count, ppos);
+		ret = vfs_read(fd_file(f), buf, count, ppos);
 		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+			fd_file(f)->f_pos = pos;
 		fdput_pos(f);
 	}
 	return ret;
@@ -634,15 +634,15 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
 
-	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
+	if (fd_file(f)) {
+		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
 			ppos = &pos;
 		}
-		ret = vfs_write(f.file, buf, count, ppos);
+		ret = vfs_write(fd_file(f), buf, count, ppos);
 		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+			fd_file(f)->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -665,10 +665,10 @@ ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 		return -EINVAL;
 
 	f = fdget(fd);
-	if (f.file) {
+	if (fd_file(f)) {
 		ret = -ESPIPE;
-		if (f.file->f_mode & FMODE_PREAD)
-			ret = vfs_read(f.file, buf, count, &pos);
+		if (fd_file(f)->f_mode & FMODE_PREAD)
+			ret = vfs_read(fd_file(f), buf, count, &pos);
 		fdput(f);
 	}
 
@@ -699,10 +699,10 @@ ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		return -EINVAL;
 
 	f = fdget(fd);
-	if (f.file) {
+	if (fd_file(f)) {
 		ret = -ESPIPE;
-		if (f.file->f_mode & FMODE_PWRITE)  
-			ret = vfs_write(f.file, buf, count, &pos);
+		if (fd_file(f)->f_mode & FMODE_PWRITE)
+			ret = vfs_write(fd_file(f), buf, count, &pos);
 		fdput(f);
 	}
 
@@ -985,15 +985,15 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
 
-	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
+	if (fd_file(f)) {
+		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
 			ppos = &pos;
 		}
-		ret = vfs_readv(f.file, vec, vlen, ppos, flags);
+		ret = vfs_readv(fd_file(f), vec, vlen, ppos, flags);
 		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+			fd_file(f)->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -1009,15 +1009,15 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
 
-	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
+	if (fd_file(f)) {
+		loff_t pos, *ppos = file_ppos(fd_file(f));
 		if (ppos) {
 			pos = *ppos;
 			ppos = &pos;
 		}
-		ret = vfs_writev(f.file, vec, vlen, ppos, flags);
+		ret = vfs_writev(fd_file(f), vec, vlen, ppos, flags);
 		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+			fd_file(f)->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -1043,10 +1043,10 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 		return -EINVAL;
 
 	f = fdget(fd);
-	if (f.file) {
+	if (fd_file(f)) {
 		ret = -ESPIPE;
-		if (f.file->f_mode & FMODE_PREAD)
-			ret = vfs_readv(f.file, vec, vlen, &pos, flags);
+		if (fd_file(f)->f_mode & FMODE_PREAD)
+			ret = vfs_readv(fd_file(f), vec, vlen, &pos, flags);
 		fdput(f);
 	}
 
@@ -1066,10 +1066,10 @@ static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 		return -EINVAL;
 
 	f = fdget(fd);
-	if (f.file) {
+	if (fd_file(f)) {
 		ret = -ESPIPE;
-		if (f.file->f_mode & FMODE_PWRITE)
-			ret = vfs_writev(f.file, vec, vlen, &pos, flags);
+		if (fd_file(f)->f_mode & FMODE_PWRITE)
+			ret = vfs_writev(fd_file(f), vec, vlen, &pos, flags);
 		fdput(f);
 	}
 
@@ -1235,19 +1235,19 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	 */
 	retval = -EBADF;
 	in = fdget(in_fd);
-	if (!in.file)
+	if (!fd_file(in))
 		goto out;
-	if (!(in.file->f_mode & FMODE_READ))
+	if (!(fd_file(in)->f_mode & FMODE_READ))
 		goto fput_in;
 	retval = -ESPIPE;
 	if (!ppos) {
-		pos = in.file->f_pos;
+		pos = fd_file(in)->f_pos;
 	} else {
 		pos = *ppos;
-		if (!(in.file->f_mode & FMODE_PREAD))
+		if (!(fd_file(in)->f_mode & FMODE_PREAD))
 			goto fput_in;
 	}
-	retval = rw_verify_area(READ, in.file, &pos, count);
+	retval = rw_verify_area(READ, fd_file(in), &pos, count);
 	if (retval < 0)
 		goto fput_in;
 	if (count > MAX_RW_COUNT)
@@ -1258,13 +1258,13 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	 */
 	retval = -EBADF;
 	out = fdget(out_fd);
-	if (!out.file)
+	if (!fd_file(out))
 		goto fput_in;
-	if (!(out.file->f_mode & FMODE_WRITE))
+	if (!(fd_file(out)->f_mode & FMODE_WRITE))
 		goto fput_out;
-	in_inode = file_inode(in.file);
-	out_inode = file_inode(out.file);
-	out_pos = out.file->f_pos;
+	in_inode = file_inode(fd_file(in));
+	out_inode = file_inode(fd_file(out));
+	out_pos = fd_file(out)->f_pos;
 
 	if (!max)
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
@@ -1284,33 +1284,33 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	 * and the application is arguably buggy if it doesn't expect
 	 * EAGAIN on a non-blocking file descriptor.
 	 */
-	if (in.file->f_flags & O_NONBLOCK)
+	if (fd_file(in)->f_flags & O_NONBLOCK)
 		fl = SPLICE_F_NONBLOCK;
 #endif
-	opipe = get_pipe_info(out.file, true);
+	opipe = get_pipe_info(fd_file(out), true);
 	if (!opipe) {
-		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
+		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
 		if (retval < 0)
 			goto fput_out;
-		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
+		retval = do_splice_direct(fd_file(in), &pos, fd_file(out), &out_pos,
 					  count, fl);
 	} else {
-		if (out.file->f_flags & O_NONBLOCK)
+		if (fd_file(out)->f_flags & O_NONBLOCK)
 			fl |= SPLICE_F_NONBLOCK;
 
-		retval = splice_file_to_pipe(in.file, opipe, &pos, count, fl);
+		retval = splice_file_to_pipe(fd_file(in), opipe, &pos, count, fl);
 	}
 
 	if (retval > 0) {
 		add_rchar(current, retval);
 		add_wchar(current, retval);
-		fsnotify_access(in.file);
-		fsnotify_modify(out.file);
-		out.file->f_pos = out_pos;
+		fsnotify_access(fd_file(in));
+		fsnotify_modify(fd_file(out));
+		fd_file(out)->f_pos = out_pos;
 		if (ppos)
 			*ppos = pos;
 		else
-			in.file->f_pos = pos;
+			fd_file(in)->f_pos = pos;
 	}
 
 	inc_syscr(current);
@@ -1583,11 +1583,11 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 	ssize_t ret = -EBADF;
 
 	f_in = fdget(fd_in);
-	if (!f_in.file)
+	if (!fd_file(f_in))
 		goto out2;
 
 	f_out = fdget(fd_out);
-	if (!f_out.file)
+	if (!fd_file(f_out))
 		goto out1;
 
 	ret = -EFAULT;
@@ -1595,21 +1595,21 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 		if (copy_from_user(&pos_in, off_in, sizeof(loff_t)))
 			goto out;
 	} else {
-		pos_in = f_in.file->f_pos;
+		pos_in = fd_file(f_in)->f_pos;
 	}
 
 	if (off_out) {
 		if (copy_from_user(&pos_out, off_out, sizeof(loff_t)))
 			goto out;
 	} else {
-		pos_out = f_out.file->f_pos;
+		pos_out = fd_file(f_out)->f_pos;
 	}
 
 	ret = -EINVAL;
 	if (flags != 0)
 		goto out;
 
-	ret = vfs_copy_file_range(f_in.file, pos_in, f_out.file, pos_out, len,
+	ret = vfs_copy_file_range(fd_file(f_in), pos_in, fd_file(f_out), pos_out, len,
 				  flags);
 	if (ret > 0) {
 		pos_in += ret;
@@ -1619,14 +1619,14 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 			if (copy_to_user(off_in, &pos_in, sizeof(loff_t)))
 				ret = -EFAULT;
 		} else {
-			f_in.file->f_pos = pos_in;
+			fd_file(f_in)->f_pos = pos_in;
 		}
 
 		if (off_out) {
 			if (copy_to_user(off_out, &pos_out, sizeof(loff_t)))
 				ret = -EFAULT;
 		} else {
-			f_out.file->f_pos = pos_out;
+			fd_file(f_out)->f_pos = pos_out;
 		}
 	}
 
diff --git a/fs/readdir.c b/fs/readdir.c
index d6c82421902a..6d29cab8576e 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -225,10 +225,10 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 		.dirent = dirent
 	};
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = iterate_dir(f.file, &buf.ctx);
+	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (buf.result)
 		error = buf.result;
 
@@ -318,10 +318,10 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	int error;
 
 	f = fdget_pos(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = iterate_dir(f.file, &buf.ctx);
+	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
 	if (buf.prev_reclen) {
@@ -401,10 +401,10 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	int error;
 
 	f = fdget_pos(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = iterate_dir(f.file, &buf.ctx);
+	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
 	if (buf.prev_reclen) {
@@ -483,10 +483,10 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 		.dirent = dirent
 	};
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = iterate_dir(f.file, &buf.ctx);
+	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (buf.result)
 		error = buf.result;
 
@@ -569,10 +569,10 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	int error;
 
 	f = fdget_pos(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	error = iterate_dir(f.file, &buf.ctx);
+	error = iterate_dir(fd_file(f), &buf.ctx);
 	if (error >= 0)
 		error = buf.error;
 	if (buf.prev_reclen) {
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 28246dfc8485..4403d5c68fcb 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -537,7 +537,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
 		struct fd dst_fd = fdget(info->dest_fd);
-		struct file *dst_file = dst_fd.file;
+		struct file *dst_file = fd_file(dst_fd);
 
 		if (!dst_file) {
 			info->status = -EBADF;
diff --git a/fs/select.c b/fs/select.c
index 9515c3fa1a03..97e1009dde00 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -532,10 +532,10 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 					continue;
 				mask = EPOLLNVAL;
 				f = fdget(i);
-				if (f.file) {
+				if (fd_file(f)) {
 					wait_key_set(wait, in, out, bit,
 						     busy_flag);
-					mask = vfs_poll(f.file, wait);
+					mask = vfs_poll(fd_file(f), wait);
 
 					fdput(f);
 				}
@@ -864,13 +864,13 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 		goto out;
 	mask = EPOLLNVAL;
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		goto out;
 
 	/* userland u16 ->events contains POLL... bitmap */
 	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
 	pwait->_key = filter | busy_flag;
-	mask = vfs_poll(f.file, pwait);
+	mask = vfs_poll(fd_file(f), pwait);
 	if (mask & busy_flag)
 		*can_busy_poll = true;
 	mask &= filter;		/* Mask out unneeded events. */
diff --git a/fs/signalfd.c b/fs/signalfd.c
index ec7b2da2477a..777e889ab0e8 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -289,10 +289,10 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 		fd_install(ufd, file);
 	} else {
 		struct fd f = fdget(ufd);
-		if (!f.file)
+		if (!fd_file(f))
 			return -EBADF;
-		ctx = f.file->private_data;
-		if (f.file->f_op != &signalfd_fops) {
+		ctx = fd_file(f)->private_data;
+		if (fd_file(f)->f_op != &signalfd_fops) {
 			fdput(f);
 			return -EINVAL;
 		}
diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index 855ac5a62edf..94bf2e5014d9 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -90,23 +90,23 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 	}
 
 	src_file = fdget(srcfd);
-	if (!src_file.file) {
+	if (!fd_file(src_file)) {
 		rc = -EBADF;
 		goto out_drop_write;
 	}
 
-	if (src_file.file->f_op->unlocked_ioctl != cifs_ioctl) {
+	if (fd_file(src_file)->f_op->unlocked_ioctl != cifs_ioctl) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "src file seems to be from a different filesystem type\n");
 		goto out_fput;
 	}
 
-	src_inode = file_inode(src_file.file);
+	src_inode = file_inode(fd_file(src_file));
 	rc = -EINVAL;
 	if (S_ISDIR(src_inode->i_mode))
 		goto out_fput;
 
-	rc = cifs_file_copychunk_range(xid, src_file.file, 0, dst_file, 0,
+	rc = cifs_file_copychunk_range(xid, fd_file(src_file), 0, dst_file, 0,
 					src_inode->i_size, 0);
 	if (rc > 0)
 		rc = 0;
diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..06232d7e505f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1566,11 +1566,11 @@ static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 
 static int vmsplice_type(struct fd f, int *type)
 {
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	if (f.file->f_mode & FMODE_WRITE) {
+	if (fd_file(f)->f_mode & FMODE_WRITE) {
 		*type = ITER_SOURCE;
-	} else if (f.file->f_mode & FMODE_READ) {
+	} else if (fd_file(f)->f_mode & FMODE_READ) {
 		*type = ITER_DEST;
 	} else {
 		fdput(f);
@@ -1621,9 +1621,9 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 	if (!iov_iter_count(&iter))
 		error = 0;
 	else if (type == ITER_SOURCE)
-		error = vmsplice_to_pipe(f.file, &iter, flags);
+		error = vmsplice_to_pipe(fd_file(f), &iter, flags);
 	else
-		error = vmsplice_to_user(f.file, &iter, flags);
+		error = vmsplice_to_user(fd_file(f), &iter, flags);
 
 	kfree(iov);
 out_fdput:
@@ -1646,10 +1646,10 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
 
 	error = -EBADF;
 	in = fdget(fd_in);
-	if (in.file) {
+	if (fd_file(in)) {
 		out = fdget(fd_out);
-		if (out.file) {
-			error = __do_splice(in.file, off_in, out.file, off_out,
+		if (fd_file(out)) {
+			error = __do_splice(fd_file(in), off_in, fd_file(out), off_out,
 					    len, flags);
 			fdput(out);
 		}
@@ -2016,10 +2016,10 @@ SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
 
 	error = -EBADF;
 	in = fdget(fdin);
-	if (in.file) {
+	if (fd_file(in)) {
 		out = fdget(fdout);
-		if (out.file) {
-			error = do_tee(in.file, out.file, len, flags);
+		if (fd_file(out)) {
+			error = do_tee(fd_file(in), fd_file(out), len, flags);
 			fdput(out);
 		}
  		fdput(in);
diff --git a/fs/stat.c b/fs/stat.c
index 89ce1be56310..41e598376d7e 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -224,9 +224,9 @@ int vfs_fstat(int fd, struct kstat *stat)
 	int error;
 
 	f = fdget_raw(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	error = vfs_getattr(&f.file->f_path, stat, STATX_BASIC_STATS, 0);
+	error = vfs_getattr(&fd_file(f)->f_path, stat, STATX_BASIC_STATS, 0);
 	fdput(f);
 	return error;
 }
@@ -277,9 +277,9 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	CLASS(fd_raw, f)(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	return vfs_statx_path(&f.file->f_path, flags, stat, request_mask);
+	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask);
 }
 
 /**
diff --git a/fs/statfs.c b/fs/statfs.c
index 96d1c3edf289..9c7bb27e7932 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -116,8 +116,8 @@ int fd_statfs(int fd, struct kstatfs *st)
 {
 	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
-	if (f.file) {
-		error = vfs_statfs(&f.file->f_path, st);
+	if (fd_file(f)) {
+		error = vfs_statfs(&fd_file(f)->f_path, st);
 		fdput(f);
 	}
 	return error;
diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1ed..67df255eb189 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -152,15 +152,15 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	struct super_block *sb;
 	int ret, ret2;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	sb = f.file->f_path.dentry->d_sb;
+	sb = fd_file(f)->f_path.dentry->d_sb;
 
 	down_read(&sb->s_umount);
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 
-	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+	ret2 = errseq_check_and_advance(&sb->s_wb_err, &fd_file(f)->f_sb_err);
 
 	fdput(f);
 	return ret ? ret : ret2;
@@ -208,8 +208,8 @@ static int do_fsync(unsigned int fd, int datasync)
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
 
-	if (f.file) {
-		ret = vfs_fsync(f.file, datasync);
+	if (fd_file(f)) {
+		ret = vfs_fsync(fd_file(f), datasync);
 		fdput(f);
 	}
 	return ret;
@@ -360,8 +360,8 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 
 	ret = -EBADF;
 	f = fdget(fd);
-	if (f.file)
-		ret = sync_file_range(f.file, offset, nbytes, flags);
+	if (fd_file(f))
+		ret = sync_file_range(fd_file(f), offset, nbytes, flags);
 
 	fdput(f);
 	return ret;
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 4bf2f8bfec11..137523e0bb21 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -397,9 +397,9 @@ static const struct file_operations timerfd_fops = {
 static int timerfd_fget(int fd, struct fd *p)
 {
 	struct fd f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	if (f.file->f_op != &timerfd_fops) {
+	if (fd_file(f)->f_op != &timerfd_fops) {
 		fdput(f);
 		return -EINVAL;
 	}
@@ -482,7 +482,7 @@ static int do_timerfd_settime(int ufd, int flags,
 	ret = timerfd_fget(ufd, &f);
 	if (ret)
 		return ret;
-	ctx = f.file->private_data;
+	ctx = fd_file(f)->private_data;
 
 	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM)) {
 		fdput(f);
@@ -546,7 +546,7 @@ static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 	int ret = timerfd_fget(ufd, &f);
 	if (ret)
 		return ret;
-	ctx = f.file->private_data;
+	ctx = fd_file(f)->private_data;
 
 	spin_lock_irq(&ctx->wqh.lock);
 	if (ctx->expired && ctx->tintv) {
diff --git a/fs/utimes.c b/fs/utimes.c
index 3701b3946f88..99b26f792b89 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -115,9 +115,9 @@ static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 		return -EINVAL;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	error = vfs_utimes(&f.file->f_path, times);
+	error = vfs_utimes(&fd_file(f)->f_path, times);
 	fdput(f);
 	return error;
 }
diff --git a/fs/xattr.c b/fs/xattr.c
index 7672ce5486c5..05ec7e7d9e87 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -697,19 +697,19 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	int error;
 
 	CLASS(fd, f)(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	audit_file(f.file);
+	audit_file(fd_file(f));
 	error = setxattr_copy(name, &ctx);
 	if (error)
 		return error;
 
-	error = mnt_want_write_file(f.file);
+	error = mnt_want_write_file(fd_file(f));
 	if (!error) {
-		error = do_setxattr(file_mnt_idmap(f.file),
-				    f.file->f_path.dentry, &ctx);
-		mnt_drop_write_file(f.file);
+		error = do_setxattr(file_mnt_idmap(fd_file(f)),
+				    fd_file(f)->f_path.dentry, &ctx);
+		mnt_drop_write_file(fd_file(f));
 	}
 	kvfree(ctx.kvalue);
 	return error;
@@ -812,10 +812,10 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 	struct fd f = fdget(fd);
 	ssize_t error = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return error;
-	audit_file(f.file);
-	error = getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
+	audit_file(fd_file(f));
+	error = getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentry,
 			 name, value, size);
 	fdput(f);
 	return error;
@@ -888,10 +888,10 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 	struct fd f = fdget(fd);
 	ssize_t error = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return error;
-	audit_file(f.file);
-	error = listxattr(f.file->f_path.dentry, list, size);
+	audit_file(fd_file(f));
+	error = listxattr(fd_file(f)->f_path.dentry, list, size);
 	fdput(f);
 	return error;
 }
@@ -954,9 +954,9 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	char kname[XATTR_NAME_MAX + 1];
 	int error = -EBADF;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return error;
-	audit_file(f.file);
+	audit_file(fd_file(f));
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
 	if (error == 0 || error == sizeof(kname))
@@ -964,11 +964,11 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	if (error < 0)
 		return error;
 
-	error = mnt_want_write_file(f.file);
+	error = mnt_want_write_file(fd_file(f));
 	if (!error) {
-		error = removexattr(file_mnt_idmap(f.file),
-				    f.file->f_path.dentry, kname);
-		mnt_drop_write_file(f.file);
+		error = removexattr(file_mnt_idmap(fd_file(f)),
+				    fd_file(f)->f_path.dentry, kname);
+		mnt_drop_write_file(fd_file(f));
 	}
 	fdput(f);
 	return error;
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index c8a655c92c92..9790e0f45d14 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -794,9 +794,9 @@ xfs_ioc_exchange_range(
 	fxr.flags		= args.flags;
 
 	file1 = fdget(args.file1_fd);
-	if (!file1.file)
+	if (!fd_file(file1))
 		return -EBADF;
-	fxr.file1 = file1.file;
+	fxr.file1 = fd_file(file1);
 
 	error = xfs_exchange_range(&fxr);
 	fdput(file1);
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index cf5acbd3c7ca..7bcc4f519cb8 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -92,9 +92,9 @@ xfs_find_handle(
 
 	if (cmd == XFS_IOC_FD_TO_HANDLE) {
 		f = fdget(hreq->fd);
-		if (!f.file)
+		if (!fd_file(f))
 			return -EBADF;
-		inode = file_inode(f.file);
+		inode = file_inode(fd_file(f));
 	} else {
 		error = user_path_at(AT_FDCWD, hreq->path, 0, &path);
 		if (error)
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 4e933db75b12..95641817370b 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1005,33 +1005,33 @@ xfs_ioc_swapext(
 
 	/* Pull information for the target fd */
 	f = fdget((int)sxp->sx_fdtarget);
-	if (!f.file) {
+	if (!fd_file(f)) {
 		error = -EINVAL;
 		goto out;
 	}
 
-	if (!(f.file->f_mode & FMODE_WRITE) ||
-	    !(f.file->f_mode & FMODE_READ) ||
-	    (f.file->f_flags & O_APPEND)) {
+	if (!(fd_file(f)->f_mode & FMODE_WRITE) ||
+	    !(fd_file(f)->f_mode & FMODE_READ) ||
+	    (fd_file(f)->f_flags & O_APPEND)) {
 		error = -EBADF;
 		goto out_put_file;
 	}
 
 	tmp = fdget((int)sxp->sx_fdtmp);
-	if (!tmp.file) {
+	if (!fd_file(tmp)) {
 		error = -EINVAL;
 		goto out_put_file;
 	}
 
-	if (!(tmp.file->f_mode & FMODE_WRITE) ||
-	    !(tmp.file->f_mode & FMODE_READ) ||
-	    (tmp.file->f_flags & O_APPEND)) {
+	if (!(fd_file(tmp)->f_mode & FMODE_WRITE) ||
+	    !(fd_file(tmp)->f_mode & FMODE_READ) ||
+	    (fd_file(tmp)->f_flags & O_APPEND)) {
 		error = -EBADF;
 		goto out_put_tmp_file;
 	}
 
-	if (IS_SWAPFILE(file_inode(f.file)) ||
-	    IS_SWAPFILE(file_inode(tmp.file))) {
+	if (IS_SWAPFILE(file_inode(fd_file(f))) ||
+	    IS_SWAPFILE(file_inode(fd_file(tmp)))) {
 		error = -EINVAL;
 		goto out_put_tmp_file;
 	}
@@ -1041,14 +1041,14 @@ xfs_ioc_swapext(
 	 * before we cast and access them as XFS structures as we have no
 	 * control over what the user passes us here.
 	 */
-	if (f.file->f_op != &xfs_file_operations ||
-	    tmp.file->f_op != &xfs_file_operations) {
+	if (fd_file(f)->f_op != &xfs_file_operations ||
+	    fd_file(tmp)->f_op != &xfs_file_operations) {
 		error = -EINVAL;
 		goto out_put_tmp_file;
 	}
 
-	ip = XFS_I(file_inode(f.file));
-	tip = XFS_I(file_inode(tmp.file));
+	ip = XFS_I(file_inode(fd_file(f)));
+	tip = XFS_I(file_inode(fd_file(tmp)));
 
 	if (ip->i_mount != tip->i_mount) {
 		error = -EINVAL;
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d9e613803df1..a3d3e888cf1f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -98,7 +98,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
  *
  *	CLASS(fdget, f)(fd);
- *	if (!f.file)
+ *	if (!fd_file(f))
  *		return -EBADF;
  *
  *	// use 'f' without concern
diff --git a/include/linux/file.h b/include/linux/file.h
index 237931f20739..0f3f369f2450 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -42,10 +42,12 @@ struct fd {
 #define FDPUT_FPUT       1
 #define FDPUT_POS_UNLOCK 2
 
+#define fd_file(f) ((f).file)
+
 static inline void fdput(struct fd fd)
 {
 	if (fd.flags & FDPUT_FPUT)
-		fput(fd.file);
+		fput(fd_file(fd));
 }
 
 extern struct file *fget(unsigned int fd);
@@ -79,7 +81,7 @@ static inline struct fd fdget_pos(int fd)
 static inline void fdput_pos(struct fd f)
 {
 	if (f.flags & FDPUT_POS_UNLOCK)
-		__f_unlock_pos(f.file);
+		__f_unlock_pos(fd_file(f));
 	fdput(f);
 }
 
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index b3722e5275e7..ffa7d341bd95 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -108,14 +108,14 @@ static struct io_sq_data *io_attach_sq_data(struct io_uring_params *p)
 	struct fd f;
 
 	f = fdget(p->wq_fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-ENXIO);
-	if (!io_is_uring_fops(f.file)) {
+	if (!io_is_uring_fops(fd_file(f))) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	ctx_attach = f.file->private_data;
+	ctx_attach = fd_file(f)->private_data;
 	sqd = ctx_attach->sq_data;
 	if (!sqd) {
 		fdput(f);
@@ -418,9 +418,9 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		struct fd f;
 
 		f = fdget(p->wq_fd);
-		if (!f.file)
+		if (!fd_file(f))
 			return -ENXIO;
-		if (!io_is_uring_fops(f.file)) {
+		if (!io_is_uring_fops(fd_file(f))) {
 			fdput(f);
 			return -EINVAL;
 		}
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a7cbd69efbef..34fa0bd8bb11 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1085,20 +1085,20 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 	audit_mq_sendrecv(mqdes, msg_len, msg_prio, ts);
 
 	f = fdget(mqdes);
-	if (unlikely(!f.file)) {
+	if (unlikely(!fd_file(f))) {
 		ret = -EBADF;
 		goto out;
 	}
 
-	inode = file_inode(f.file);
-	if (unlikely(f.file->f_op != &mqueue_file_operations)) {
+	inode = file_inode(fd_file(f));
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		ret = -EBADF;
 		goto out_fput;
 	}
 	info = MQUEUE_I(inode);
-	audit_file(f.file);
+	audit_file(fd_file(f));
 
-	if (unlikely(!(f.file->f_mode & FMODE_WRITE))) {
+	if (unlikely(!(fd_file(f)->f_mode & FMODE_WRITE))) {
 		ret = -EBADF;
 		goto out_fput;
 	}
@@ -1138,7 +1138,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 	}
 
 	if (info->attr.mq_curmsgs == info->attr.mq_maxmsg) {
-		if (f.file->f_flags & O_NONBLOCK) {
+		if (fd_file(f)->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 		} else {
 			wait.task = current;
@@ -1199,20 +1199,20 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 	audit_mq_sendrecv(mqdes, msg_len, 0, ts);
 
 	f = fdget(mqdes);
-	if (unlikely(!f.file)) {
+	if (unlikely(!fd_file(f))) {
 		ret = -EBADF;
 		goto out;
 	}
 
-	inode = file_inode(f.file);
-	if (unlikely(f.file->f_op != &mqueue_file_operations)) {
+	inode = file_inode(fd_file(f));
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		ret = -EBADF;
 		goto out_fput;
 	}
 	info = MQUEUE_I(inode);
-	audit_file(f.file);
+	audit_file(fd_file(f));
 
-	if (unlikely(!(f.file->f_mode & FMODE_READ))) {
+	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ))) {
 		ret = -EBADF;
 		goto out_fput;
 	}
@@ -1242,7 +1242,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 	}
 
 	if (info->attr.mq_curmsgs == 0) {
-		if (f.file->f_flags & O_NONBLOCK) {
+		if (fd_file(f)->f_flags & O_NONBLOCK) {
 			spin_unlock(&info->lock);
 			ret = -EAGAIN;
 		} else {
@@ -1356,11 +1356,11 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 			/* and attach it to the socket */
 retry:
 			f = fdget(notification->sigev_signo);
-			if (!f.file) {
+			if (!fd_file(f)) {
 				ret = -EBADF;
 				goto out;
 			}
-			sock = netlink_getsockbyfilp(f.file);
+			sock = netlink_getsockbyfilp(fd_file(f));
 			fdput(f);
 			if (IS_ERR(sock)) {
 				ret = PTR_ERR(sock);
@@ -1379,13 +1379,13 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	}
 
 	f = fdget(mqdes);
-	if (!f.file) {
+	if (!fd_file(f)) {
 		ret = -EBADF;
 		goto out;
 	}
 
-	inode = file_inode(f.file);
-	if (unlikely(f.file->f_op != &mqueue_file_operations)) {
+	inode = file_inode(fd_file(f));
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		ret = -EBADF;
 		goto out_fput;
 	}
@@ -1460,31 +1460,31 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
 		return -EINVAL;
 
 	f = fdget(mqdes);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	if (unlikely(f.file->f_op != &mqueue_file_operations)) {
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		fdput(f);
 		return -EBADF;
 	}
 
-	inode = file_inode(f.file);
+	inode = file_inode(fd_file(f));
 	info = MQUEUE_I(inode);
 
 	spin_lock(&info->lock);
 
 	if (old) {
 		*old = info->attr;
-		old->mq_flags = f.file->f_flags & O_NONBLOCK;
+		old->mq_flags = fd_file(f)->f_flags & O_NONBLOCK;
 	}
 	if (new) {
 		audit_mq_getsetattr(mqdes, new);
-		spin_lock(&f.file->f_lock);
+		spin_lock(&fd_file(f)->f_lock);
 		if (new->mq_flags & O_NONBLOCK)
-			f.file->f_flags |= O_NONBLOCK;
+			fd_file(f)->f_flags |= O_NONBLOCK;
 		else
-			f.file->f_flags &= ~O_NONBLOCK;
-		spin_unlock(&f.file->f_lock);
+			fd_file(f)->f_flags &= ~O_NONBLOCK;
+		spin_unlock(&fd_file(f)->f_lock);
 
 		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	}
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index b0ef45db207c..0a79aee6523d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -80,10 +80,10 @@ static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 	struct bpf_local_storage_data *sdata;
 	struct fd f = fdget_raw(*(int *)key);
 
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
 
-	sdata = inode_storage_lookup(file_inode(f.file), map, true);
+	sdata = inode_storage_lookup(file_inode(fd_file(f)), map, true);
 	fdput(f);
 	return sdata ? sdata->data : NULL;
 }
@@ -94,14 +94,14 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 	struct bpf_local_storage_data *sdata;
 	struct fd f = fdget_raw(*(int *)key);
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
-	if (!inode_storage_ptr(file_inode(f.file))) {
+	if (!inode_storage_ptr(file_inode(fd_file(f)))) {
 		fdput(f);
 		return -EBADF;
 	}
 
-	sdata = bpf_local_storage_update(file_inode(f.file),
+	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
 					 value, map_flags, GFP_ATOMIC);
 	fdput(f);
@@ -126,10 +126,10 @@ static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 	struct fd f = fdget_raw(*(int *)key);
 	int err;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	err = inode_storage_delete(file_inode(f.file), map);
+	err = inode_storage_delete(file_inode(fd_file(f)), map);
 	fdput(f);
 	return err;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..4de1e3dc2284 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7677,15 +7677,15 @@ struct btf *btf_get_by_fd(int fd)
 
 	f = fdget(fd);
 
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
 
-	if (f.file->f_op != &btf_fops) {
+	if (fd_file(f)->f_op != &btf_fops) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	btf = f.file->private_data;
+	btf = fd_file(f)->private_data;
 	refcount_inc(&btf->refcnt);
 	fdput(f);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bf6c5f685ea2..3093bf2cc266 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -829,7 +829,7 @@ static int bpf_map_release(struct inode *inode, struct file *filp)
 
 static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 {
-	fmode_t mode = f.file->f_mode;
+	fmode_t mode = fd_file(f)->f_mode;
 
 	/* Our file permissions may have been overridden by global
 	 * map permissions facing syscall side.
@@ -1423,14 +1423,14 @@ static int map_create(union bpf_attr *attr)
  */
 struct bpf_map *__bpf_map_get(struct fd f)
 {
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
-	if (f.file->f_op != &bpf_map_fops) {
+	if (fd_file(f)->f_op != &bpf_map_fops) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	return f.file->private_data;
+	return fd_file(f)->private_data;
 }
 
 void bpf_map_inc(struct bpf_map *map)
@@ -1651,7 +1651,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_key;
 	}
 
-	err = bpf_map_update_value(map, f.file, key, value, attr->flags);
+	err = bpf_map_update_value(map, fd_file(f), key, value, attr->flags);
 	if (!err)
 		maybe_wait_bpf_programs(map);
 
@@ -2409,14 +2409,14 @@ int bpf_prog_new_fd(struct bpf_prog *prog)
 
 static struct bpf_prog *____bpf_prog_get(struct fd f)
 {
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
-	if (f.file->f_op != &bpf_prog_fops) {
+	if (fd_file(f)->f_op != &bpf_prog_fops) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	return f.file->private_data;
+	return fd_file(f)->private_data;
 }
 
 void bpf_prog_add(struct bpf_prog *prog, int i)
@@ -3259,14 +3259,14 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 	struct fd f = fdget(ufd);
 	struct bpf_link *link;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
-	if (f.file->f_op != &bpf_link_fops && f.file->f_op != &bpf_link_fops_poll) {
+	if (fd_file(f)->f_op != &bpf_link_fops && fd_file(f)->f_op != &bpf_link_fops_poll) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	link = f.file->private_data;
+	link = fd_file(f)->private_data;
 	bpf_link_inc(link);
 	fdput(f);
 
@@ -4982,19 +4982,19 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 		return -EINVAL;
 
 	f = fdget(ufd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADFD;
 
-	if (f.file->f_op == &bpf_prog_fops)
-		err = bpf_prog_get_info_by_fd(f.file, f.file->private_data, attr,
+	if (fd_file(f)->f_op == &bpf_prog_fops)
+		err = bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
 					      uattr);
-	else if (f.file->f_op == &bpf_map_fops)
-		err = bpf_map_get_info_by_fd(f.file, f.file->private_data, attr,
+	else if (fd_file(f)->f_op == &bpf_map_fops)
+		err = bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
 					     uattr);
-	else if (f.file->f_op == &btf_fops)
-		err = bpf_btf_get_info_by_fd(f.file, f.file->private_data, attr, uattr);
-	else if (f.file->f_op == &bpf_link_fops || f.file->f_op == &bpf_link_fops_poll)
-		err = bpf_link_get_info_by_fd(f.file, f.file->private_data,
+	else if (fd_file(f)->f_op == &btf_fops)
+		err = bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
+	else if (fd_file(f)->f_op == &bpf_link_fops || fd_file(f)->f_op == &bpf_link_fops_poll)
+		err = bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
 					      attr, uattr);
 	else
 		err = -EINVAL;
@@ -5215,7 +5215,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	else if (cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH)
 		BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch, map, attr, uattr);
 	else if (cmd == BPF_MAP_UPDATE_BATCH)
-		BPF_DO_BATCH(map->ops->map_update_batch, map, f.file, attr, uattr);
+		BPF_DO_BATCH(map->ops->map_update_batch, map, fd_file(f), attr, uattr);
 	else
 		BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
 err_put:
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index d6ccf8d00eab..9a1d356e79ed 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -122,10 +122,10 @@ int bpf_token_create(union bpf_attr *attr)
 	int err, fd;
 
 	f = fdget(attr->token_create.bpffs_fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	path = f.file->f_path;
+	path = fd_file(f)->f_path;
 	path_get(&path);
 	fdput(f);
 
@@ -235,14 +235,14 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd)
 	struct fd f = fdget(ufd);
 	struct bpf_token *token;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
-	if (f.file->f_op != &bpf_token_fops) {
+	if (fd_file(f)->f_op != &bpf_token_fops) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
 
-	token = f.file->private_data;
+	token = fd_file(f)->private_data;
 	bpf_token_inc(token);
 	fdput(f);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..b96489277f70 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6901,10 +6901,10 @@ struct cgroup *cgroup_v1v2_get_from_fd(int fd)
 {
 	struct cgroup *cgrp;
 	struct fd f = fdget_raw(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
 
-	cgrp = cgroup_v1v2_get_from_file(f.file);
+	cgrp = cgroup_v1v2_get_from_file(fd_file(f));
 	fdput(f);
 	return cgrp;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..17b19d3e74ba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -933,10 +933,10 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 	struct fd f = fdget(fd);
 	int ret = 0;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	css = css_tryget_online_from_dir(f.file->f_path.dentry,
+	css = css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
 					 &perf_event_cgrp_subsys);
 	if (IS_ERR(css)) {
 		ret = PTR_ERR(css);
@@ -5898,10 +5898,10 @@ static const struct file_operations perf_fops;
 static inline int perf_fget_light(int fd, struct fd *p)
 {
 	struct fd f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	if (f.file->f_op != &perf_fops) {
+	if (fd_file(f)->f_op != &perf_fops) {
 		fdput(f);
 		return -EBADF;
 	}
@@ -5961,7 +5961,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 			ret = perf_fget_light(arg, &output);
 			if (ret)
 				return ret;
-			output_event = output.file->private_data;
+			output_event = fd_file(output)->private_data;
 			ret = perf_event_set_output(event, output_event);
 			fdput(output);
 		} else {
@@ -12549,7 +12549,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		err = perf_fget_light(group_fd, &group);
 		if (err)
 			goto err_fd;
-		group_leader = group.file->private_data;
+		group_leader = fd_file(group)->private_data;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d9592195c5bb..6ed334eecc14 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3211,7 +3211,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		return -EINVAL;
 
 	f = fdget(fd);
-	err = idempotent_init_module(f.file, uargs, flags);
+	err = idempotent_init_module(fd_file(f), uargs, flags);
 	fdput(f);
 	return err;
 }
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 6ec3deec68c2..dc952c3b05af 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,15 +550,15 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	if (proc_ns_file(f.file)) {
-		ns = get_proc_ns(file_inode(f.file));
+	if (proc_ns_file(fd_file(f))) {
+		ns = get_proc_ns(file_inode(fd_file(f)));
 		if (flags && (ns->ops->type != flags))
 			err = -EINVAL;
 		flags = ns->ops->type;
-	} else if (!IS_ERR(pidfd_pid(f.file))) {
+	} else if (!IS_ERR(pidfd_pid(fd_file(f)))) {
 		err = check_setns_flags(flags);
 	} else {
 		err = -EINVAL;
@@ -570,10 +570,10 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (err)
 		goto out;
 
-	if (proc_ns_file(f.file))
+	if (proc_ns_file(fd_file(f)))
 		err = validate_ns(&nsset, ns);
 	else
-		err = validate_nsset(&nsset, pidfd_pid(f.file));
+		err = validate_nsset(&nsset, pidfd_pid(fd_file(f)));
 	if (!err) {
 		commit_nsset(&nsset);
 		perf_event_namespaces(current);
diff --git a/kernel/pid.c b/kernel/pid.c
index da76ed1873f7..2715afb77eab 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -540,13 +540,13 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 	struct pid *pid;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(f.file);
+	pid = pidfd_pid(fd_file(f));
 	if (!IS_ERR(pid)) {
 		get_pid(pid);
-		*flags = f.file->f_flags;
+		*flags = fd_file(f)->f_flags;
 	}
 
 	fdput(f);
@@ -755,10 +755,10 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		return -EINVAL;
 
 	f = fdget(pidfd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	pid = pidfd_pid(f.file);
+	pid = pidfd_pid(fd_file(f));
 	if (IS_ERR(pid))
 		ret = PTR_ERR(pid);
 	else
diff --git a/kernel/signal.c b/kernel/signal.c
index 60c737e423a1..cc5d87cfa7c0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3922,11 +3922,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		return -EINVAL;
 
 	f = fdget(pidfd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(f.file);
+	pid = pidfd_to_pid(fd_file(f));
 	if (IS_ERR(pid)) {
 		ret = PTR_ERR(pid);
 		goto err;
@@ -3939,7 +3939,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (f.file->f_flags & PIDFD_THREAD)
+		if (fd_file(f)->f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..a4be1e568ff5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1916,10 +1916,10 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	int err;
 
 	exe = fdget(fd);
-	if (!exe.file)
+	if (!fd_file(exe))
 		return -EBADF;
 
-	inode = file_inode(exe.file);
+	inode = file_inode(fd_file(exe));
 
 	/*
 	 * Because the original mm->exe_file points to executable file, make
@@ -1927,14 +1927,14 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	 * overall picture.
 	 */
 	err = -EACCES;
-	if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
+	if (!S_ISREG(inode->i_mode) || path_noexec(&fd_file(exe)->f_path))
 		goto exit;
 
-	err = file_permission(exe.file, MAY_EXEC);
+	err = file_permission(fd_file(exe), MAY_EXEC);
 	if (err)
 		goto exit;
 
-	err = replace_mm_exe_file(mm, exe.file);
+	err = replace_mm_exe_file(mm, fd_file(exe));
 exit:
 	fdput(exe);
 	return err;
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 4354ea231fab..0700f40c53ac 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -419,7 +419,7 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 
 	fd = nla_get_u32(info->attrs[CGROUPSTATS_CMD_ATTR_FD]);
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return 0;
 
 	size = nla_total_size(sizeof(struct cgroupstats));
@@ -440,7 +440,7 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 	stats = nla_data(na);
 	memset(stats, 0, sizeof(*stats));
 
-	rc = cgroupstats_build(stats, f.file->f_path.dentry);
+	rc = cgroupstats_build(stats, fd_file(f)->f_path.dentry);
 	if (rc < 0) {
 		nlmsg_free(rep_skb);
 		goto err;
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 03b90d7d2175..d36242fd4936 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -666,8 +666,8 @@ struct watch_queue *get_watch_queue(int fd)
 	struct fd f;
 
 	f = fdget(fd);
-	if (f.file) {
-		pipe = get_pipe_info(f.file, false);
+	if (fd_file(f)) {
+		pipe = get_pipe_info(fd_file(f), false);
 		if (pipe && pipe->watch_queue) {
 			wqueue = pipe->watch_queue;
 			kref_get(&wqueue->usage);
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 6c39d42f16dc..532dee205c6e 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -193,10 +193,10 @@ int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
 	struct fd f = fdget(fd);
 	int ret;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
-	ret = vfs_fadvise(f.file, offset, len, advice);
+	ret = vfs_fadvise(fd_file(f), offset, len, advice);
 
 	fdput(f);
 	return ret;
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..0b5cbd644fdd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4393,7 +4393,7 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	struct cachestat cs;
 	pgoff_t first_index, last_index;
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	if (copy_from_user(&csr, cstat_range,
@@ -4403,7 +4403,7 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	}
 
 	/* hugetlbfs is not supported */
-	if (is_file_hugepages(f.file)) {
+	if (is_file_hugepages(fd_file(f))) {
 		fdput(f);
 		return -EOPNOTSUPP;
 	}
@@ -4417,7 +4417,7 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	last_index =
 		csr.len == 0 ? ULONG_MAX : (csr.off + csr.len - 1) >> PAGE_SHIFT;
 	memset(&cs, 0, sizeof(struct cachestat));
-	mapping = f.file->f_mapping;
+	mapping = fd_file(f)->f_mapping;
 	filemap_cachestat(mapping, first_index, last_index, &cs);
 	fdput(f);
 
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 417c96f2da28..9725c731fb21 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1860,26 +1860,26 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	INIT_WORK(&event->remove, memcg_event_remove);
 
 	efile = fdget(efd);
-	if (!efile.file) {
+	if (!fd_file(efile)) {
 		ret = -EBADF;
 		goto out_kfree;
 	}
 
-	event->eventfd = eventfd_ctx_fileget(efile.file);
+	event->eventfd = eventfd_ctx_fileget(fd_file(efile));
 	if (IS_ERR(event->eventfd)) {
 		ret = PTR_ERR(event->eventfd);
 		goto out_put_efile;
 	}
 
 	cfile = fdget(cfd);
-	if (!cfile.file) {
+	if (!fd_file(cfile)) {
 		ret = -EBADF;
 		goto out_put_eventfd;
 	}
 
 	/* the process need read permission on control file */
 	/* AV: shouldn't we check that it's been opened for read instead? */
-	ret = file_permission(cfile.file, MAY_READ);
+	ret = file_permission(fd_file(cfile), MAY_READ);
 	if (ret < 0)
 		goto out_put_cfile;
 
@@ -1887,7 +1887,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	 * The control file must be a regular cgroup1 file. As a regular cgroup
 	 * file can't be renamed, it's safe to access its name afterwards.
 	 */
-	cdentry = cfile.file->f_path.dentry;
+	cdentry = fd_file(cfile)->f_path.dentry;
 	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
 		ret = -EINVAL;
 		goto out_put_cfile;
@@ -1939,7 +1939,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	if (ret)
 		goto out_put_css;
 
-	vfs_poll(efile.file, &event->pt);
+	vfs_poll(fd_file(efile), &event->pt);
 
 	spin_lock_irq(&memcg->event_list_lock);
 	list_add(&event->list, &memcg->event_list);
diff --git a/mm/readahead.c b/mm/readahead.c
index 517c0be7ce66..e83fe1c6e5ac 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -646,7 +646,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 
 	ret = -EBADF;
 	f = fdget(fd);
-	if (!f.file || !(f.file->f_mode & FMODE_READ))
+	if (!fd_file(f) || !(fd_file(f)->f_mode & FMODE_READ))
 		goto out;
 
 	/*
@@ -655,12 +655,12 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 * on this file, then we must return -EINVAL.
 	 */
 	ret = -EINVAL;
-	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    (!S_ISREG(file_inode(f.file)->i_mode) &&
-	    !S_ISBLK(file_inode(f.file)->i_mode)))
+	if (!fd_file(f)->f_mapping || !fd_file(f)->f_mapping->a_ops ||
+	    (!S_ISREG(file_inode(fd_file(f))->i_mode) &&
+	    !S_ISBLK(file_inode(fd_file(f))->i_mode)))
 		goto out;
 
-	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
+	ret = vfs_fadvise(fd_file(f), offset, count, POSIX_FADV_WILLNEED);
 out:
 	fdput(f);
 	return ret;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6a823ba906c6..18b7c8f31234 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -711,11 +711,11 @@ struct net *get_net_ns_by_fd(int fd)
 	struct fd f = fdget(fd);
 	struct net *net = ERR_PTR(-EINVAL);
 
-	if (!f.file)
+	if (!fd_file(f))
 		return ERR_PTR(-EBADF);
 
-	if (proc_ns_file(f.file)) {
-		struct ns_common *ns = get_proc_ns(file_inode(f.file));
+	if (proc_ns_file(fd_file(f))) {
+		struct ns_common *ns = get_proc_ns(file_inode(fd_file(f)));
 		if (ns->ops == &netns_operations)
 			net = get_net(container_of(ns, struct net, ns));
 	}
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..f77a42a74510 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -556,8 +556,8 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
 	struct socket *sock;
 
 	*err = -EBADF;
-	if (f.file) {
-		sock = sock_from_file(f.file);
+	if (fd_file(f)) {
+		sock = sock_from_file(fd_file(f));
 		if (likely(sock)) {
 			*fput_needed = f.flags & FDPUT_FPUT;
 			return sock;
@@ -2008,8 +2008,8 @@ int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 	struct fd f;
 
 	f = fdget(fd);
-	if (f.file) {
-		ret = __sys_accept4_file(f.file, upeer_sockaddr,
+	if (fd_file(f)) {
+		ret = __sys_accept4_file(fd_file(f), upeer_sockaddr,
 					 upeer_addrlen, flags);
 		fdput(f);
 	}
@@ -2070,12 +2070,12 @@ int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
 	struct fd f;
 
 	f = fdget(fd);
-	if (f.file) {
+	if (fd_file(f)) {
 		struct sockaddr_storage address;
 
 		ret = move_addr_to_kernel(uservaddr, addrlen, &address);
 		if (!ret)
-			ret = __sys_connect_file(f.file, &address, addrlen, 0);
+			ret = __sys_connect_file(fd_file(f), &address, addrlen, 0);
 		fdput(f);
 	}
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..e7c1d3ae33fe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1068,10 +1068,10 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 		return;
 
 	f = fdget(kernel_fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return;
 
-	process_buffer_measurement(file_mnt_idmap(f.file), file_inode(f.file),
+	process_buffer_measurement(file_mnt_idmap(fd_file(f)), file_inode(fd_file(f)),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
 	fdput(f);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index ccc8bc6c1584..00b63971ab64 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -238,19 +238,19 @@ static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
 	struct landlock_ruleset *ruleset;
 
 	ruleset_f = fdget(fd);
-	if (!ruleset_f.file)
+	if (!fd_file(ruleset_f))
 		return ERR_PTR(-EBADF);
 
 	/* Checks FD type and access right. */
-	if (ruleset_f.file->f_op != &ruleset_fops) {
+	if (fd_file(ruleset_f)->f_op != &ruleset_fops) {
 		ruleset = ERR_PTR(-EBADFD);
 		goto out_fdput;
 	}
-	if (!(ruleset_f.file->f_mode & mode)) {
+	if (!(fd_file(ruleset_f)->f_mode & mode)) {
 		ruleset = ERR_PTR(-EPERM);
 		goto out_fdput;
 	}
-	ruleset = ruleset_f.file->private_data;
+	ruleset = fd_file(ruleset_f)->private_data;
 	if (WARN_ON_ONCE(ruleset->num_layers != 1)) {
 		ruleset = ERR_PTR(-EINVAL);
 		goto out_fdput;
@@ -277,22 +277,22 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 
 	/* Handles O_PATH. */
 	f = fdget_raw(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 	/*
 	 * Forbids ruleset FDs, internal filesystems (e.g. nsfs), including
 	 * pseudo filesystems that will never be mountable (e.g. sockfs,
 	 * pipefs).
 	 */
-	if ((f.file->f_op == &ruleset_fops) ||
-	    (f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
-	    (f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
-	    d_is_negative(f.file->f_path.dentry) ||
-	    IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
+	if ((fd_file(f)->f_op == &ruleset_fops) ||
+	    (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
+	    (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
+	    d_is_negative(fd_file(f)->f_path.dentry) ||
+	    IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry))) {
 		err = -EBADFD;
 		goto out_fdput;
 	}
-	*path = f.file->f_path;
+	*path = fd_file(f)->f_path;
 	path_get(path);
 
 out_fdput:
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 93fd4d47b334..02144ec39f43 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -296,7 +296,7 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 		return -EPERM;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EINVAL;
 
 	data = kzalloc(SZ_4K, GFP_KERNEL);
@@ -305,7 +305,7 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 		goto err;
 	}
 
-	rc = kernel_read_file(f.file, 0, (void **)&data, SZ_4K - 1, NULL, READING_POLICY);
+	rc = kernel_read_file(fd_file(f), 0, (void **)&data, SZ_4K - 1, NULL, READING_POLICY);
 	if (rc < 0)
 		goto err;
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4057f9f10aee..cbb9c972cb93 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2250,12 +2250,12 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	bool nonatomic = substream->pcm->nonatomic;
 	CLASS(fd, f)(fd);
 
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADFD;
-	if (!is_pcm_file(f.file))
+	if (!is_pcm_file(fd_file(f)))
 		return -EBADFD;
 
-	pcm_file = f.file->private_data;
+	pcm_file = fd_file(f)->private_data;
 	substream1 = pcm_file->substream;
 
 	if (substream == substream1)
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 229570059a1b..65efb3735e79 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -327,12 +327,12 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	seqcount_spinlock_init(&irqfd->irq_entry_sc, &kvm->irqfds.lock);
 
 	f = fdget(args->fd);
-	if (!f.file) {
+	if (!fd_file(f)) {
 		ret = -EBADF;
 		goto out;
 	}
 
-	eventfd = eventfd_ctx_fileget(f.file);
+	eventfd = eventfd_ctx_fileget(fd_file(f));
 	if (IS_ERR(eventfd)) {
 		ret = PTR_ERR(eventfd);
 		goto fail;
@@ -419,7 +419,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	 * Check if there was an event already pending on the eventfd
 	 * before we registered, and trigger it as if we didn't miss it.
 	 */
-	events = vfs_poll(f.file, &irqfd->pt);
+	events = vfs_poll(fd_file(f), &irqfd->pt);
 
 	if (events & EPOLLIN)
 		schedule_work(&irqfd->inject);
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 76b7f6085dcd..388ae471d258 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -194,7 +194,7 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 	int ret;
 
 	f = fdget(fd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	ret = -ENOENT;
@@ -202,7 +202,7 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 	mutex_lock(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
-		if (kvf->file != f.file)
+		if (kvf->file != fd_file(f))
 			continue;
 
 		list_del(&kvf->node);
@@ -240,7 +240,7 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
 		return -EFAULT;
 
 	f = fdget(param.groupfd);
-	if (!f.file)
+	if (!fd_file(f))
 		return -EBADF;
 
 	ret = -ENOENT;
@@ -248,7 +248,7 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
 	mutex_lock(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
-		if (kvf->file != f.file)
+		if (kvf->file != fd_file(f))
 			continue;
 
 		if (!kvf->iommu_group) {
-- 
2.39.2


