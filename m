Return-Path: <linux-fsdevel+bounces-33529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113329B9D23
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4680284323
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3E15F40B;
	Sat,  2 Nov 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O1EQeMwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F5149DF4;
	Sat,  2 Nov 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524115; cv=none; b=cg4WOI2q1V7lLCXO1LaphBME2d5MX0sLYN8QMoqSw0bTZzhOfQT9cGW+tDImTyk4TbBQPobaxRPR/ePg49fA24qwHFkaLQL7+lPpERB6BQZg4zChI1JsFDiJOZsHFCEzRxh7m7NiMKLoMc3rcyVs8GhOi66sgOrhC21A+v+AvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524115; c=relaxed/simple;
	bh=YAOI0Bms1NyzCK21gEK9b6nfGpEC8zFEszG3umJsMm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM944SifXB5orV2w2d9LXD5fY0S4T1LyyRlzSPweiEeQWmfHn9fyoIJqK/0Q9sRYYXmIQZiBkJs+xoRkpYnDwryN/+Xop2JTdO/YrjsA4i90IYjORYFE3A0TbOo5c73vWnzDscniFUA/XURGbJXoPdQ4rmuxWhKA4qMQJS9ZQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=O1EQeMwb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gJeBjPaJqIDGTtuoDnaO4yl4cURpz4gw6IFQHbZ2UFQ=; b=O1EQeMwbwGBcMgWqHtq/SRZ3Dh
	/Q005YZDvFLx/sZEdY2aeP2MxeUv2mV28je0n2WsouiEXtwigQI50lehuE/90Ml759WzMeCIKEHLI
	a9RJQa4llshvxPRZGDZs2VMTeFCK12Efx5Nu990rvorSi5opOuE3qXC/dtIp7iNgFbYWmNQkc3vxY
	QJiE3Ok/WSJnqgiUpoVmdjBndlfRmn2Lpyn6nrnyMGhzR67gy4+3E0rLCr8CYSvpc3QWyw7Qym3Qa
	PBumULVWu/yTW6FXMu2yg/tgP2+A6vtLZZkE87P3aZMEzD316EeLiE2kNqUNO79IvR4BsyVMFM2Wx
	7hy/uoww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NB-0000000AHn6-04Eo;
	Sat, 02 Nov 2024 05:08:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 14/28] fdget(), trivial conversions
Date: Sat,  2 Nov 2024 05:08:12 +0000
Message-ID: <20241102050827.2451599-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdget() is the first thing done in scope, all matching fdput() are
immediately followed by leaving the scope.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kvm/book3s_64_vio.c           | 21 +++---------
 arch/powerpc/kvm/powerpc.c                 | 24 ++++---------
 arch/powerpc/platforms/cell/spu_syscalls.c |  6 ++--
 arch/x86/kernel/cpu/sgx/main.c             | 10 ++----
 arch/x86/kvm/svm/sev.c                     | 39 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  | 23 ++++---------
 drivers/gpu/drm/drm_syncobj.c              |  9 ++---
 drivers/media/rc/lirc_dev.c                | 13 +++-----
 fs/btrfs/ioctl.c                           |  5 ++-
 fs/eventfd.c                               |  9 ++---
 fs/eventpoll.c                             | 23 ++++---------
 fs/fhandle.c                               |  5 ++-
 fs/ioctl.c                                 | 23 +++++--------
 fs/kernel_read_file.c                      | 12 +++----
 fs/notify/fanotify/fanotify_user.c         | 15 +++------
 fs/notify/inotify/inotify_user.c           | 17 +++-------
 fs/open.c                                  | 36 +++++++++-----------
 fs/read_write.c                            | 28 +++++-----------
 fs/signalfd.c                              |  9 ++---
 fs/sync.c                                  | 29 ++++++----------
 io_uring/sqpoll.c                          | 29 +++++-----------
 kernel/events/core.c                       | 14 +++-----
 kernel/nsproxy.c                           |  5 ++-
 kernel/pid.c                               |  7 ++--
 kernel/sys.c                               | 15 +++------
 kernel/watch_queue.c                       |  6 ++--
 mm/fadvise.c                               | 10 ++----
 mm/readahead.c                             | 17 +++-------
 net/core/net_namespace.c                   | 10 +++---
 security/landlock/syscalls.c               | 26 +++++----------
 virt/kvm/vfio.c                            |  8 ++---
 31 files changed, 164 insertions(+), 339 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 34c0adb9fdbf..742aa58a7c7e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -115,10 +115,9 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	struct iommu_table_group *table_group;
 	long i;
 	struct kvmppc_spapr_tce_iommu_table *stit;
-	struct fd f;
+	CLASS(fd, f)(tablefd);
 
-	f = fdget(tablefd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	rcu_read_lock();
@@ -130,16 +129,12 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	}
 	rcu_read_unlock();
 
-	if (!found) {
-		fdput(f);
+	if (!found)
 		return -EINVAL;
-	}
 
 	table_group = iommu_group_get_iommudata(grp);
-	if (WARN_ON(!table_group)) {
-		fdput(f);
+	if (WARN_ON(!table_group))
 		return -EFAULT;
-	}
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
 		struct iommu_table *tbltmp = table_group->tables[i];
@@ -160,10 +155,8 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			break;
 		}
 	}
-	if (!tbl) {
-		fdput(f);
+	if (!tbl)
 		return -EINVAL;
-	}
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
@@ -174,7 +167,6 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 			/* stit is being destroyed */
 			iommu_tce_table_put(tbl);
 			rcu_read_unlock();
-			fdput(f);
 			return -ENOTTY;
 		}
 		/*
@@ -182,7 +174,6 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 		 * its KVM reference counter and can return.
 		 */
 		rcu_read_unlock();
-		fdput(f);
 		return 0;
 	}
 	rcu_read_unlock();
@@ -190,7 +181,6 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	stit = kzalloc(sizeof(*stit), GFP_KERNEL);
 	if (!stit) {
 		iommu_tce_table_put(tbl);
-		fdput(f);
 		return -ENOMEM;
 	}
 
@@ -199,7 +189,6 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 
 	list_add_rcu(&stit->next, &stt->iommu_tables);
 
-	fdput(f);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index f14329989e9a..b3b37ea77849 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1933,12 +1933,11 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 #endif
 #ifdef CONFIG_KVM_MPIC
 	case KVM_CAP_IRQ_MPIC: {
-		struct fd f;
+		CLASS(fd, f)(cap->args[0]);
 		struct kvm_device *dev;
 
 		r = -EBADF;
-		f = fdget(cap->args[0]);
-		if (!fd_file(f))
+		if (fd_empty(f))
 			break;
 
 		r = -EPERM;
@@ -1946,18 +1945,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		if (dev)
 			r = kvmppc_mpic_connect_vcpu(dev, vcpu, cap->args[1]);
 
-		fdput(f);
 		break;
 	}
 #endif
 #ifdef CONFIG_KVM_XICS
 	case KVM_CAP_IRQ_XICS: {
-		struct fd f;
+		CLASS(fd, f)(cap->args[0]);
 		struct kvm_device *dev;
 
 		r = -EBADF;
-		f = fdget(cap->args[0]);
-		if (!fd_file(f))
+		if (fd_empty(f))
 			break;
 
 		r = -EPERM;
@@ -1968,34 +1965,27 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			else
 				r = kvmppc_xics_connect_vcpu(dev, vcpu, cap->args[1]);
 		}
-
-		fdput(f);
 		break;
 	}
 #endif /* CONFIG_KVM_XICS */
 #ifdef CONFIG_KVM_XIVE
 	case KVM_CAP_PPC_IRQ_XIVE: {
-		struct fd f;
+		CLASS(fd, f)(cap->args[0]);
 		struct kvm_device *dev;
 
 		r = -EBADF;
-		f = fdget(cap->args[0]);
-		if (!fd_file(f))
+		if (fd_empty(f))
 			break;
 
 		r = -ENXIO;
-		if (!xive_enabled()) {
-			fdput(f);
+		if (!xive_enabled())
 			break;
-		}
 
 		r = -EPERM;
 		dev = kvm_device_from_filp(fd_file(f));
 		if (dev)
 			r = kvmppc_xive_native_connect_vcpu(dev, vcpu,
 							    cap->args[1]);
-
-		fdput(f);
 		break;
 	}
 #endif /* CONFIG_KVM_XIVE */
diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index cd7d42fc12a6..da4fad7fc8bf 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -64,12 +64,10 @@ SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 		return -ENOSYS;
 
 	if (flags & SPU_CREATE_AFFINITY_SPU) {
-		struct fd neighbor = fdget(neighbor_fd);
+		CLASS(fd, neighbor)(neighbor_fd);
 		ret = -EBADF;
-		if (fd_file(neighbor)) {
+		if (!fd_empty(neighbor))
 			ret = calls->create_thread(name, flags, mode, fd_file(neighbor));
-			fdput(neighbor);
-		}
 	} else
 		ret = calls->create_thread(name, flags, mode, NULL);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9ace84486499..eb5848d1851a 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -901,19 +901,15 @@ static struct miscdevice sgx_dev_provision = {
 int sgx_set_attribute(unsigned long *allowed_attributes,
 		      unsigned int attribute_fd)
 {
-	struct fd f = fdget(attribute_fd);
+	CLASS(fd, f)(attribute_fd);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EINVAL;
 
-	if (fd_file(f)->f_op != &sgx_provision_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &sgx_provision_fops)
 		return -EINVAL;
-	}
 
 	*allowed_attributes |= SGX_ATTR_PROVISIONKEY;
-
-	fdput(f);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0b851ef937f2..34304f6c36be 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -530,17 +530,12 @@ static int sev_bind_asid(struct kvm *kvm, unsigned int handle, int *error)
 
 static int __sev_issue_cmd(int fd, int id, void *data, int *error)
 {
-	struct fd f;
-	int ret;
+	CLASS(fd, f)(fd);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
-	ret = sev_issue_cmd_external_user(fd_file(f), id, data, error);
-
-	fdput(f);
-	return ret;
+	return sev_issue_cmd_external_user(fd_file(f), id, data, error);
 }
 
 static int sev_issue_cmd(struct kvm *kvm, int id, void *data, int *error)
@@ -2073,23 +2068,21 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
 	struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
 	struct kvm_sev_info *src_sev, *cg_cleanup_sev;
-	struct fd f = fdget(source_fd);
+	CLASS(fd, f)(source_fd);
 	struct kvm *source_kvm;
 	bool charged = false;
 	int ret;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f))) {
-		ret = -EBADF;
-		goto out_fput;
-	}
+	if (!file_is_kvm(fd_file(f)))
+		return -EBADF;
 
 	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
-		goto out_fput;
+		return ret;
 
 	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
 	    sev_guest(kvm) || !sev_guest(source_kvm)) {
@@ -2136,8 +2129,6 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	cg_cleanup_sev->misc_cg = NULL;
 out_unlock:
 	sev_unlock_two_vms(kvm, source_kvm);
-out_fput:
-	fdput(f);
 	return ret;
 }
 
@@ -2798,23 +2789,21 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
-	struct fd f = fdget(source_fd);
+	CLASS(fd, f)(source_fd);
 	struct kvm *source_kvm;
 	struct kvm_sev_info *source_sev, *mirror_sev;
 	int ret;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f))) {
-		ret = -EBADF;
-		goto e_source_fput;
-	}
+	if (!file_is_kvm(fd_file(f)))
+		return -EBADF;
 
 	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
-		goto e_source_fput;
+		return ret;
 
 	/*
 	 * Mirrors of mirrors should work, but let's not get silly.  Also
@@ -2857,8 +2846,6 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 
 e_unlock:
 	sev_unlock_two_vms(kvm, source_kvm);
-e_source_fput:
-	fdput(f);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b0a8abc7a8ec..341beec59537 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -35,21 +35,19 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 						  int fd,
 						  int32_t priority)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EINVAL;
 
 	r = amdgpu_file_to_fpriv(fd_file(f), &fpriv);
-	if (r) {
-		fdput(f);
+	if (r)
 		return r;
-	}
 
 	mgr = &fpriv->ctx_mgr;
 	mutex_lock(&mgr->lock);
@@ -57,7 +55,6 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		amdgpu_ctx_priority_override(ctx, priority);
 	mutex_unlock(&mgr->lock);
 
-	fdput(f);
 	return 0;
 }
 
@@ -66,31 +63,25 @@ static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
 						  unsigned ctx_id,
 						  int32_t priority)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_ctx *ctx;
 	int r;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EINVAL;
 
 	r = amdgpu_file_to_fpriv(fd_file(f), &fpriv);
-	if (r) {
-		fdput(f);
+	if (r)
 		return r;
-	}
 
 	ctx = amdgpu_ctx_get(fpriv, ctx_id);
 
-	if (!ctx) {
-		fdput(f);
+	if (!ctx)
 		return -EINVAL;
-	}
 
 	amdgpu_ctx_priority_override(ctx, priority);
 	amdgpu_ctx_put(ctx);
-	fdput(f);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8e3d2d7060f8..4f2ab8a7b50f 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -712,16 +712,14 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 				    int fd, u32 *handle)
 {
 	struct drm_syncobj *syncobj;
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	int ret;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EINVAL;
 
-	if (fd_file(f)->f_op != &drm_syncobj_file_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &drm_syncobj_file_fops)
 		return -EINVAL;
-	}
 
 	/* take a reference to put in the idr */
 	syncobj = fd_file(f)->private_data;
@@ -739,7 +737,6 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 	} else
 		drm_syncobj_put(syncobj);
 
-	fdput(f);
 	return ret;
 }
 
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index f042f3f14afa..a2257dc2f25d 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -815,28 +815,23 @@ void __exit lirc_dev_exit(void)
 
 struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct lirc_fh *fh;
 	struct rc_dev *dev;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
-	if (fd_file(f)->f_op != &lirc_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &lirc_fops)
 		return ERR_PTR(-EINVAL);
-	}
 
-	if (write && !(fd_file(f)->f_mode & FMODE_WRITE)) {
-		fdput(f);
+	if (write && !(fd_file(f)->f_mode & FMODE_WRITE))
 		return ERR_PTR(-EPERM);
-	}
 
 	fh = fd_file(f)->private_data;
 	dev = fh->rc;
 
 	get_device(&dev->dev);
-	fdput(f);
 
 	return dev;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 226c91fe31a7..adb591b1d071 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1308,9 +1308,9 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 		ret = btrfs_mksubvol(&file->f_path, idmap, name,
 				     namelen, NULL, readonly, inherit);
 	} else {
-		struct fd src = fdget(fd);
+		CLASS(fd, src)(fd);
 		struct inode *src_inode;
-		if (!fd_file(src)) {
+		if (fd_empty(src)) {
 			ret = -EINVAL;
 			goto out_drop_write;
 		}
@@ -1341,7 +1341,6 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 					       BTRFS_I(src_inode)->root,
 					       readonly, inherit);
 		}
-		fdput(src);
 	}
 out_drop_write:
 	mnt_drop_write_file(file);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 22c934f3a080..76129bfcd663 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -347,13 +347,10 @@ EXPORT_SYMBOL_GPL(eventfd_fget);
  */
 struct eventfd_ctx *eventfd_ctx_fdget(int fd)
 {
-	struct eventfd_ctx *ctx;
-	struct fd f = fdget(fd);
-	if (!fd_file(f))
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
-	ctx = eventfd_ctx_fileget(fd_file(f));
-	fdput(f);
-	return ctx;
+	return eventfd_ctx_fileget(fd_file(f));
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_fdget);
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..4607dcbc2851 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2254,25 +2254,22 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 {
 	int error;
 	int full_check = 0;
-	struct fd f, tf;
 	struct eventpoll *ep;
 	struct epitem *epi;
 	struct eventpoll *tep = NULL;
 
-	error = -EBADF;
-	f = fdget(epfd);
-	if (!fd_file(f))
-		goto error_return;
+	CLASS(fd, f)(epfd);
+	if (fd_empty(f))
+		return -EBADF;
 
 	/* Get the "struct file *" for the target file */
-	tf = fdget(fd);
-	if (!fd_file(tf))
-		goto error_fput;
+	CLASS(fd, tf)(fd);
+	if (fd_empty(tf))
+		return -EBADF;
 
 	/* The target file descriptor must support poll */
-	error = -EPERM;
 	if (!file_can_poll(fd_file(tf)))
-		goto error_tgt_fput;
+		return -EPERM;
 
 	/* Check if EPOLLWAKEUP is allowed */
 	if (ep_op_has_event(op))
@@ -2391,12 +2388,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		loop_check_gen++;
 		mutex_unlock(&epnested_mutex);
 	}
-
-	fdput(tf);
-error_fput:
-	fdput(f);
-error_return:
-
 	return error;
 }
 
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 82df28d45cd7..5f801139358e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -139,12 +139,11 @@ static int get_path_from_fd(int fd, struct path *root)
 		path_get(root);
 		spin_unlock(&fs->lock);
 	} else {
-		struct fd f = fdget(fd);
-		if (!fd_file(f))
+		CLASS(fd, f)(fd);
+		if (fd_empty(f))
 			return -EBADF;
 		*root = fd_file(f)->f_path;
 		path_get(root);
-		fdput(f);
 	}
 
 	return 0;
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 6e0c954388d4..638a36be31c1 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -231,11 +231,11 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 			     u64 off, u64 olen, u64 destoff)
 {
-	struct fd src_file = fdget(srcfd);
+	CLASS(fd, src_file)(srcfd);
 	loff_t cloned;
 	int ret;
 
-	if (!fd_file(src_file))
+	if (fd_empty(src_file))
 		return -EBADF;
 	cloned = vfs_clone_file_range(fd_file(src_file), off, dst_file, destoff,
 				      olen, 0);
@@ -245,7 +245,6 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 		ret = -EINVAL;
 	else
 		ret = 0;
-	fdput(src_file);
 	return ret;
 }
 
@@ -892,22 +891,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 
 SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	int error;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = security_file_ioctl(fd_file(f), cmd, arg);
 	if (error)
-		goto out;
+		return error;
 
 	error = do_vfs_ioctl(fd_file(f), fd, cmd, arg);
 	if (error == -ENOIOCTLCMD)
 		error = vfs_ioctl(fd_file(f), cmd, arg);
 
-out:
-	fdput(f);
 	return error;
 }
 
@@ -950,15 +947,15 @@ EXPORT_SYMBOL(compat_ptr_ioctl);
 COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 		       compat_ulong_t, arg)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	int error;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	error = security_file_ioctl_compat(fd_file(f), cmd, arg);
 	if (error)
-		goto out;
+		return error;
 
 	switch (cmd) {
 	/* FICLONE takes an int argument, so don't use compat_ptr() */
@@ -1009,10 +1006,6 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 			error = -ENOTTY;
 		break;
 	}
-
- out:
-	fdput(f);
-
 	return error;
 }
 #endif
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 9ff37ae650ea..de32c95d823d 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -175,15 +175,11 @@ ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
 				 size_t buf_size, size_t *file_size,
 				 enum kernel_read_file_id id)
 {
-	struct fd f = fdget(fd);
-	ssize_t ret = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (!fd_file(f) || !(fd_file(f)->f_mode & FMODE_READ))
-		goto out;
+	if (fd_empty(f) || !(fd_file(f)->f_mode & FMODE_READ))
+		return -EBADF;
 
-	ret = kernel_read_file(fd_file(f), offset, buf, buf_size, file_size, id);
-out:
-	fdput(f);
-	return ret;
+	return kernel_read_file(fd_file(f), offset, buf, buf_size, file_size, id);
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9644bc72e457..07c5ffc8523b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1003,22 +1003,17 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 		 dfd, filename, flags);
 
 	if (filename == NULL) {
-		struct fd f = fdget(dfd);
+		CLASS(fd, f)(dfd);
 
-		ret = -EBADF;
-		if (!fd_file(f))
-			goto out;
+		if (fd_empty(f))
+			return -EBADF;
 
-		ret = -ENOTDIR;
 		if ((flags & FAN_MARK_ONLYDIR) &&
-		    !(S_ISDIR(file_inode(fd_file(f))->i_mode))) {
-			fdput(f);
-			goto out;
-		}
+		    !(S_ISDIR(file_inode(fd_file(f))->i_mode)))
+			return -ENOTDIR;
 
 		*path = fd_file(f)->f_path;
 		path_get(path);
-		fdput(f);
 	} else {
 		unsigned int lookup_flags = 0;
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 0794dcaf1e47..dc645af2a6ad 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -794,33 +794,26 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
 {
 	struct fsnotify_group *group;
 	struct inotify_inode_mark *i_mark;
-	struct fd f;
-	int ret = -EINVAL;
+	CLASS(fd, f)(fd);
 
-	f = fdget(fd);
-	if (unlikely(!fd_file(f)))
+	if (fd_empty(f))
 		return -EBADF;
 
 	/* verify that this is indeed an inotify instance */
 	if (unlikely(fd_file(f)->f_op != &inotify_fops))
-		goto out;
+		return -EINVAL;
 
 	group = fd_file(f)->private_data;
 
 	i_mark = inotify_idr_find(group, wd);
 	if (unlikely(!i_mark))
-		goto out;
-
-	ret = 0;
+		return -EINVAL;
 
 	fsnotify_destroy_mark(&i_mark->fsn_mark, group);
 
 	/* match ref taken by inotify_idr_find */
 	fsnotify_put_mark(&i_mark->fsn_mark);
-
-out:
-	fdput(f);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/fs/open.c b/fs/open.c
index a0c1fa3f60d5..24d22f4222f0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -349,14 +349,12 @@ EXPORT_SYMBOL_GPL(vfs_fallocate);
 
 int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
-	struct fd f = fdget(fd);
-	int error = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (fd_file(f)) {
-		error = vfs_fallocate(fd_file(f), mode, offset, len);
-		fdput(f);
-	}
-	return error;
+	if (fd_empty(f))
+		return -EBADF;
+
+	return vfs_fallocate(fd_file(f), mode, offset, len);
 }
 
 SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
@@ -666,14 +664,12 @@ int vfs_fchmod(struct file *file, umode_t mode)
 
 SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 {
-	struct fd f = fdget(fd);
-	int err = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (fd_file(f)) {
-		err = vfs_fchmod(fd_file(f), mode);
-		fdput(f);
-	}
-	return err;
+	if (fd_empty(f))
+		return -EBADF;
+
+	return vfs_fchmod(fd_file(f), mode);
 }
 
 static int do_fchmodat(int dfd, const char __user *filename, umode_t mode,
@@ -860,14 +856,12 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group)
 
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 {
-	struct fd f = fdget(fd);
-	int error = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (fd_file(f)) {
-		error = vfs_fchown(fd_file(f), user, group);
-		fdput(f);
-	}
-	return error;
+	if (fd_empty(f))
+		return -EBADF;
+
+	return vfs_fchown(fd_file(f), user, group);
 }
 
 SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
diff --git a/fs/read_write.c b/fs/read_write.c
index ef3ee3725714..5e3df2d39283 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1663,36 +1663,32 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 {
 	loff_t pos_in;
 	loff_t pos_out;
-	struct fd f_in;
-	struct fd f_out;
 	ssize_t ret = -EBADF;
 
-	f_in = fdget(fd_in);
-	if (!fd_file(f_in))
-		goto out2;
+	CLASS(fd, f_in)(fd_in);
+	if (fd_empty(f_in))
+		return -EBADF;
 
-	f_out = fdget(fd_out);
-	if (!fd_file(f_out))
-		goto out1;
+	CLASS(fd, f_out)(fd_out);
+	if (fd_empty(f_out))
+		return -EBADF;
 
-	ret = -EFAULT;
 	if (off_in) {
 		if (copy_from_user(&pos_in, off_in, sizeof(loff_t)))
-			goto out;
+			return -EFAULT;
 	} else {
 		pos_in = fd_file(f_in)->f_pos;
 	}
 
 	if (off_out) {
 		if (copy_from_user(&pos_out, off_out, sizeof(loff_t)))
-			goto out;
+			return -EFAULT;
 	} else {
 		pos_out = fd_file(f_out)->f_pos;
 	}
 
-	ret = -EINVAL;
 	if (flags != 0)
-		goto out;
+		return -EINVAL;
 
 	ret = vfs_copy_file_range(fd_file(f_in), pos_in, fd_file(f_out), pos_out, len,
 				  flags);
@@ -1714,12 +1710,6 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 			fd_file(f_out)->f_pos = pos_out;
 		}
 	}
-
-out:
-	fdput(f_out);
-out1:
-	fdput(f_in);
-out2:
 	return ret;
 }
 
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 736bebf93591..d1a5f43ce466 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -288,20 +288,17 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 
 		fd_install(ufd, file);
 	} else {
-		struct fd f = fdget(ufd);
-		if (!fd_file(f))
+		CLASS(fd, f)(ufd);
+		if (fd_empty(f))
 			return -EBADF;
 		ctx = fd_file(f)->private_data;
-		if (fd_file(f)->f_op != &signalfd_fops) {
-			fdput(f);
+		if (fd_file(f)->f_op != &signalfd_fops)
 			return -EINVAL;
-		}
 		spin_lock_irq(&current->sighand->siglock);
 		ctx->sigmask = *mask;
 		spin_unlock_irq(&current->sighand->siglock);
 
 		wake_up(&current->sighand->signalfd_wqh);
-		fdput(f);
 	}
 
 	return ufd;
diff --git a/fs/sync.c b/fs/sync.c
index 67df255eb189..2955cd4c77a3 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -148,11 +148,11 @@ void emergency_sync(void)
  */
 SYSCALL_DEFINE1(syncfs, int, fd)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct super_block *sb;
 	int ret, ret2;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 	sb = fd_file(f)->f_path.dentry->d_sb;
 
@@ -162,7 +162,6 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 
 	ret2 = errseq_check_and_advance(&sb->s_wb_err, &fd_file(f)->f_sb_err);
 
-	fdput(f);
 	return ret ? ret : ret2;
 }
 
@@ -205,14 +204,12 @@ EXPORT_SYMBOL(vfs_fsync);
 
 static int do_fsync(unsigned int fd, int datasync)
 {
-	struct fd f = fdget(fd);
-	int ret = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (fd_file(f)) {
-		ret = vfs_fsync(fd_file(f), datasync);
-		fdput(f);
-	}
-	return ret;
+	if (fd_empty(f))
+		return -EBADF;
+
+	return vfs_fsync(fd_file(f), datasync);
 }
 
 SYSCALL_DEFINE1(fsync, unsigned int, fd)
@@ -355,16 +352,12 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags)
 {
-	int ret;
-	struct fd f;
+	CLASS(fd, f)(fd);
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (fd_file(f))
-		ret = sync_file_range(fd_file(f), offset, nbytes, flags);
+	if (fd_empty(f))
+		return -EBADF;
 
-	fdput(f);
-	return ret;
+	return sync_file_range(fd_file(f), offset, nbytes, flags);
 }
 
 SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index a26593979887..d5f0c3d9c35f 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -106,29 +106,21 @@ static struct io_sq_data *io_attach_sq_data(struct io_uring_params *p)
 {
 	struct io_ring_ctx *ctx_attach;
 	struct io_sq_data *sqd;
-	struct fd f;
+	CLASS(fd, f)(p->wq_fd);
 
-	f = fdget(p->wq_fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-ENXIO);
-	if (!io_is_uring_fops(fd_file(f))) {
-		fdput(f);
+	if (!io_is_uring_fops(fd_file(f)))
 		return ERR_PTR(-EINVAL);
-	}
 
 	ctx_attach = fd_file(f)->private_data;
 	sqd = ctx_attach->sq_data;
-	if (!sqd) {
-		fdput(f);
+	if (!sqd)
 		return ERR_PTR(-EINVAL);
-	}
-	if (sqd->task_tgid != current->tgid) {
-		fdput(f);
+	if (sqd->task_tgid != current->tgid)
 		return ERR_PTR(-EPERM);
-	}
 
 	refcount_inc(&sqd->refs);
-	fdput(f);
 	return sqd;
 }
 
@@ -417,16 +409,11 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 	/* Retain compatibility with failing for an invalid attach attempt */
 	if ((ctx->flags & (IORING_SETUP_ATTACH_WQ | IORING_SETUP_SQPOLL)) ==
 				IORING_SETUP_ATTACH_WQ) {
-		struct fd f;
-
-		f = fdget(p->wq_fd);
-		if (!fd_file(f))
+		CLASS(fd, f)(p->wq_fd);
+		if (fd_empty(f))
 			return -ENXIO;
-		if (!io_is_uring_fops(fd_file(f))) {
-			fdput(f);
+		if (!io_is_uring_fops(fd_file(f)))
 			return -EINVAL;
-		}
-		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		struct task_struct *tsk;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 85b209626dd7..075ce7299973 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -966,22 +966,20 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 {
 	struct perf_cgroup *cgrp;
 	struct cgroup_subsys_state *css;
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	int ret = 0;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	css = css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
 					 &perf_event_cgrp_subsys);
-	if (IS_ERR(css)) {
-		ret = PTR_ERR(css);
-		goto out;
-	}
+	if (IS_ERR(css))
+		return PTR_ERR(css);
 
 	ret = perf_cgroup_ensure_storage(event, css);
 	if (ret)
-		goto out;
+		return ret;
 
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
@@ -995,8 +993,6 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 		perf_detach_cgroup(event);
 		ret = -EINVAL;
 	}
-out:
-	fdput(f);
 	return ret;
 }
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..c9d97ed20122 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -545,12 +545,12 @@ static void commit_nsset(struct nsset *nsset)
 
 SYSCALL_DEFINE2(setns, int, fd, int, flags)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct ns_common *ns = NULL;
 	struct nsset nsset = {};
 	int err = 0;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	if (proc_ns_file(fd_file(f))) {
@@ -580,7 +580,6 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	}
 	put_nsset(&nsset);
 out:
-	fdput(f);
 	return err;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..b5bbc1a8a6e4 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -536,11 +536,10 @@ EXPORT_SYMBOL_GPL(find_ge_pid);
 
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 {
-	struct fd f;
+	CLASS(fd, f)(fd);
 	struct pid *pid;
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
 	pid = pidfd_pid(fd_file(f));
@@ -548,8 +547,6 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 		get_pid(pid);
 		*flags = fd_file(f)->f_flags;
 	}
-
-	fdput(f);
 	return pid;
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda8..ebe10c27a9f4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1911,12 +1911,11 @@ SYSCALL_DEFINE1(umask, int, mask)
 
 static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 {
-	struct fd exe;
+	CLASS(fd, exe)(fd);
 	struct inode *inode;
 	int err;
 
-	exe = fdget(fd);
-	if (!fd_file(exe))
+	if (fd_empty(exe))
 		return -EBADF;
 
 	inode = file_inode(fd_file(exe));
@@ -1926,18 +1925,14 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	 * sure that this one is executable as well, to avoid breaking an
 	 * overall picture.
 	 */
-	err = -EACCES;
 	if (!S_ISREG(inode->i_mode) || path_noexec(&fd_file(exe)->f_path))
-		goto exit;
+		return -EACCES;
 
 	err = file_permission(fd_file(exe), MAY_EXEC);
 	if (err)
-		goto exit;
+		return err;
 
-	err = replace_mm_exe_file(mm, fd_file(exe));
-exit:
-	fdput(exe);
-	return err;
+	return replace_mm_exe_file(mm, fd_file(exe));
 }
 
 /*
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d36242fd4936..1895fbc32bcb 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -663,16 +663,14 @@ struct watch_queue *get_watch_queue(int fd)
 {
 	struct pipe_inode_info *pipe;
 	struct watch_queue *wqueue = ERR_PTR(-EINVAL);
-	struct fd f;
+	CLASS(fd, f)(fd);
 
-	f = fdget(fd);
-	if (fd_file(f)) {
+	if (!fd_empty(f)) {
 		pipe = get_pipe_info(fd_file(f), false);
 		if (pipe && pipe->watch_queue) {
 			wqueue = pipe->watch_queue;
 			kref_get(&wqueue->usage);
 		}
-		fdput(f);
 	}
 
 	return wqueue;
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 532dee205c6e..588fe76c5a14 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -190,16 +190,12 @@ EXPORT_SYMBOL(vfs_fadvise);
 
 int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
 {
-	struct fd f = fdget(fd);
-	int ret;
+	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
-	ret = vfs_fadvise(fd_file(f), offset, len, advice);
-
-	fdput(f);
-	return ret;
+	return vfs_fadvise(fd_file(f), offset, len, advice);
 }
 
 SYSCALL_DEFINE4(fadvise64_64, int, fd, loff_t, offset, loff_t, len, int, advice)
diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..9a807727d809 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -673,29 +673,22 @@ EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
 ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 {
-	ssize_t ret;
-	struct fd f;
+	CLASS(fd, f)(fd);
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (!fd_file(f) || !(fd_file(f)->f_mode & FMODE_READ))
-		goto out;
+	if (fd_empty(f) || !(fd_file(f)->f_mode & FMODE_READ))
+		return -EBADF;
 
 	/*
 	 * The readahead() syscall is intended to run only on files
 	 * that can execute readahead. If readahead is not possible
 	 * on this file, then we must return -EINVAL.
 	 */
-	ret = -EINVAL;
 	if (!fd_file(f)->f_mapping || !fd_file(f)->f_mapping->a_ops ||
 	    (!S_ISREG(file_inode(fd_file(f))->i_mode) &&
 	    !S_ISBLK(file_inode(fd_file(f))->i_mode)))
-		goto out;
+		return -EINVAL;
 
-	ret = vfs_fadvise(fd_file(f), offset, count, POSIX_FADV_WILLNEED);
-out:
-	fdput(f);
-	return ret;
+	return vfs_fadvise(fd_file(f), offset, count, POSIX_FADV_WILLNEED);
 }
 
 SYSCALL_DEFINE3(readahead, int, fd, loff_t, offset, size_t, count)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index e39479f1c9a4..b231b27d8268 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -694,20 +694,18 @@ EXPORT_SYMBOL_GPL(get_net_ns);
 
 struct net *get_net_ns_by_fd(int fd)
 {
-	struct fd f = fdget(fd);
-	struct net *net = ERR_PTR(-EINVAL);
+	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
 	if (proc_ns_file(fd_file(f))) {
 		struct ns_common *ns = get_proc_ns(file_inode(fd_file(f)));
 		if (ns->ops == &netns_operations)
-			net = get_net(container_of(ns, struct net, ns));
+			return get_net(container_of(ns, struct net, ns));
 	}
-	fdput(f);
 
-	return net;
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_fd);
 #endif
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f32eb38abd0f..f937f748d9e8 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -241,31 +241,21 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
 						    const fmode_t mode)
 {
-	struct fd ruleset_f;
+	CLASS(fd, ruleset_f)(fd);
 	struct landlock_ruleset *ruleset;
 
-	ruleset_f = fdget(fd);
-	if (!fd_file(ruleset_f))
+	if (fd_empty(ruleset_f))
 		return ERR_PTR(-EBADF);
 
 	/* Checks FD type and access right. */
-	if (fd_file(ruleset_f)->f_op != &ruleset_fops) {
-		ruleset = ERR_PTR(-EBADFD);
-		goto out_fdput;
-	}
-	if (!(fd_file(ruleset_f)->f_mode & mode)) {
-		ruleset = ERR_PTR(-EPERM);
-		goto out_fdput;
-	}
+	if (fd_file(ruleset_f)->f_op != &ruleset_fops)
+		return ERR_PTR(-EBADFD);
+	if (!(fd_file(ruleset_f)->f_mode & mode))
+		return ERR_PTR(-EPERM);
 	ruleset = fd_file(ruleset_f)->private_data;
-	if (WARN_ON_ONCE(ruleset->num_layers != 1)) {
-		ruleset = ERR_PTR(-EINVAL);
-		goto out_fdput;
-	}
+	if (WARN_ON_ONCE(ruleset->num_layers != 1))
+		return ERR_PTR(-EINVAL);
 	landlock_get_ruleset(ruleset);
-
-out_fdput:
-	fdput(ruleset_f);
 	return ruleset;
 }
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 388ae471d258..53262b8a7656 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -190,11 +190,10 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
-	struct fd f;
+	CLASS(fd, f)(fd);
 	int ret;
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	ret = -ENOENT;
@@ -220,9 +219,6 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 	kvm_vfio_update_coherency(dev);
 
 	mutex_unlock(&kv->lock);
-
-	fdput(f);
-
 	return ret;
 }
 
-- 
2.39.5


