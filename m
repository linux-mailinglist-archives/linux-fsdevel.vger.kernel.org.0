Return-Path: <linux-fsdevel+bounces-24555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6E94073B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102C81F224DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A81974FA;
	Tue, 30 Jul 2024 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egpOoGcy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F6195FE5;
	Tue, 30 Jul 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316508; cv=none; b=NZ3vWRW1u308PHM7MiRjfU03isLGpC7EiiqRCNedNVSOQ4SmGiXUzyj+51d7qXQx5rwIFStMT4OYdWKPneWXb9VPIjLCDvFrOPNqDQmL1l6qPNo9kTThGlYaEIENt6nmb5kLiWshTag6B/ePLj3HomTqTSZEAbRL2Xmaf6M9pOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316508; c=relaxed/simple;
	bh=2un/7GpGhtxvLqtsXU2IXZXJg/WCupX8uqYZa5hD7ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UW8v6LKaG/vJQZgkVqNfCeuJ9WTxiMYUkL3RmqYp+Ew5vgQURsbgluf00RDNKwv1Qouu9Dw4EfjlTNgOZtzGMUZE2hAowl3cnLGLkfa+g/EKUusWoN0dmoKoWyXh6WxTWnpSlWNGaXLs+eI+aFZHw/wdPmqjHjooiNHb7ePFRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egpOoGcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB2FC4AF0C;
	Tue, 30 Jul 2024 05:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316508;
	bh=2un/7GpGhtxvLqtsXU2IXZXJg/WCupX8uqYZa5hD7ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egpOoGcyXVSKH6nbnbsIoS0wUoDuFqyPX01es4jdFM+6Od+YXKq/hYgPpTfZ0yFAr
	 0EPA2LjZE8YSygSG4JZdHyF+PTcw+JdKjACDHN6zDA1eDXECvrcVQ45HmmxoDZxZ/H
	 VMGTpUsSxDw9lToQ52mJlGJL3QLJ4jo3rHOxjf8zAHDoIR04Mdg5OuaCZoXsSZAO5+
	 9B8fsJ2bqW2qxTVZyT99VJzyoBjMR+rywumzg3U5a7DoK05Ihc+T5blgJBMYVrE9qZ
	 bUN4sVEY9fiUBIvCvrnF+qHHxI7/Jq3zI2fm8rlnzcQuJeLepYpCL7rMLaCISfm1AD
	 X+SifrA+42qRQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 23/39] fdget(), trivial conversions
Date: Tue, 30 Jul 2024 01:16:09 -0400
Message-Id: <20240730051625.14349-23-viro@kernel.org>
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

fdget() is the first thing done in scope, all matching fdput() are
immediately followed by leaving the scope.

[conflict in fs/fhandle.c and a trival one in kernel/bpf/syscall.c]
[conflict in fs/xattr.c]

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
 fs/xattr.c                                 | 35 ++++++++-----------
 io_uring/sqpoll.c                          | 29 +++++-----------
 kernel/bpf/btf.c                           | 11 ++----
 kernel/bpf/syscall.c                       | 10 ++----
 kernel/bpf/token.c                         |  9 ++---
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
 35 files changed, 187 insertions(+), 381 deletions(-)

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
index d01deb386395..d91284001162 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -893,19 +893,15 @@ static struct miscdevice sgx_dev_provision = {
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
index 0e38b5223263..65d6670a5969 100644
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
 
@@ -2796,23 +2787,21 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 
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
@@ -2855,8 +2844,6 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 
 e_unlock:
 	sev_unlock_two_vms(kvm, source_kvm);
-e_source_fput:
-	fdput(f);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index a9298cb8d19a..570634654489 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -36,21 +36,19 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
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
@@ -58,7 +56,6 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		amdgpu_ctx_priority_override(ctx, priority);
 	mutex_unlock(&mgr->lock);
 
-	fdput(f);
 	return 0;
 }
 
@@ -67,31 +64,25 @@ static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
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
index 7fb31ca3b5fc..4eaebd69253b 100644
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
index b8dfd530fab7..af6337489d21 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -816,28 +816,23 @@ void __exit lirc_dev_exit(void)
 
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
index 32ddd3d31719..04bee97a1ca0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1310,9 +1310,9 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
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
@@ -1343,7 +1343,6 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
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
index 28d1a754cf33..4609f7342005 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2259,25 +2259,22 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
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
@@ -2396,12 +2393,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
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
index 3f07b52874a8..5996fd47a6f7 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -124,12 +124,11 @@ static int get_path_from_fd(int fd, struct path *root)
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
index 13454e5fd3fb..64b1adc75fe5 100644
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
index c7e451d5bd51..711830b73275 100644
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
index 624c173a0270..6d7dd58ce095 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -350,14 +350,12 @@ EXPORT_SYMBOL_GPL(vfs_fallocate);
 
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
@@ -667,14 +665,12 @@ int vfs_fchmod(struct file *file, umode_t mode)
 
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
@@ -861,14 +857,12 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group)
 
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
index 7e5a2e50e12b..b3743e7dd93f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1570,36 +1570,32 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
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
@@ -1621,12 +1617,6 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
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
index 777e889ab0e8..b1844e0f58eb 100644
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
diff --git a/fs/xattr.c b/fs/xattr.c
index 05ec7e7d9e87..0fc813cb005c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -697,9 +697,9 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	int error;
 
 	CLASS(fd, f)(fd);
-	if (!fd_file(f))
-		return -EBADF;
 
+	if (fd_empty(f))
+		return -EBADF;
 	audit_file(fd_file(f));
 	error = setxattr_copy(name, &ctx);
 	if (error)
@@ -809,16 +809,13 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	struct fd f = fdget(fd);
-	ssize_t error = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
-		return error;
+	if (fd_empty(f))
+		return -EBADF;
 	audit_file(fd_file(f));
-	error = getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentry,
+	return getxattr(file_mnt_idmap(fd_file(f)), fd_file(f)->f_path.dentry,
 			 name, value, size);
-	fdput(f);
-	return error;
 }
 
 /*
@@ -885,15 +882,12 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	struct fd f = fdget(fd);
-	ssize_t error = -EBADF;
+	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
-		return error;
+	if (fd_empty(f))
+		return -EBADF;
 	audit_file(fd_file(f));
-	error = listxattr(fd_file(f)->f_path.dentry, list, size);
-	fdput(f);
-	return error;
+	return listxattr(fd_file(f)->f_path.dentry, list, size);
 }
 
 /*
@@ -950,12 +944,12 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	char kname[XATTR_NAME_MAX + 1];
-	int error = -EBADF;
+	int error;
 
-	if (!fd_file(f))
-		return error;
+	if (fd_empty(f))
+		return -EBADF;
 	audit_file(fd_file(f));
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
@@ -970,7 +964,6 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 				    fd_file(f)->f_path.dentry, kname);
 		mnt_drop_write_file(fd_file(f));
 	}
-	fdput(f);
 	return error;
 }
 
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index ffa7d341bd95..26b1c14d5967 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -105,29 +105,21 @@ static struct io_sq_data *io_attach_sq_data(struct io_uring_params *p)
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
 
@@ -415,16 +407,11 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4de1e3dc2284..8afcffefbb56 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7673,21 +7673,16 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 struct btf *btf_get_by_fd(int fd)
 {
 	struct btf *btf;
-	struct fd f;
+	CLASS(fd, f)(fd);
 
-	f = fdget(fd);
-
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
-	if (fd_file(f)->f_op != &btf_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &btf_fops)
 		return ERR_PTR(-EINVAL);
-	}
 
 	btf = fd_file(f)->private_data;
 	refcount_inc(&btf->refcnt);
-	fdput(f);
 
 	return btf;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 807042c643c8..4b39a1ea63e2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3197,20 +3197,16 @@ int bpf_link_new_fd(struct bpf_link *link)
 
 struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_link *link;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_link_fops && fd_file(f)->f_op != &bpf_link_fops_poll) {
-		fdput(f);
+	if (fd_file(f)->f_op != &bpf_link_fops && fd_file(f)->f_op != &bpf_link_fops_poll)
 		return ERR_PTR(-EINVAL);
-	}
 
 	link = fd_file(f)->private_data;
 	bpf_link_inc(link);
-	fdput(f);
-
 	return link;
 }
 EXPORT_SYMBOL(bpf_link_get_from_fd);
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 9a1d356e79ed..9b92cb886d49 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -232,19 +232,16 @@ int bpf_token_create(union bpf_attr *attr)
 
 struct bpf_token *bpf_token_get_from_fd(u32 ufd)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_token *token;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_token_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &bpf_token_fops)
 		return ERR_PTR(-EINVAL);
-	}
 
 	token = fd_file(f)->private_data;
 	bpf_token_inc(token);
-	fdput(f);
 
 	return token;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dae815c30514..81c3c926e938 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -930,22 +930,20 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
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
@@ -959,8 +957,6 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
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
index a4be1e568ff5..243d58916899 100644
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
index e83fe1c6e5ac..fa881c55646e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -641,29 +641,22 @@ EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
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
index 18b7c8f31234..f4334aa5ef1f 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -708,20 +708,18 @@ EXPORT_SYMBOL_GPL(get_net_ns);
 
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
index 9689169ad5cc..c7edb2b590d5 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -234,31 +234,21 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
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
2.39.2


