Return-Path: <linux-fsdevel+bounces-57252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEDEB1FF8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9A917A8E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A12D94B5;
	Mon, 11 Aug 2025 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WD5wFglP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0429ACF1;
	Mon, 11 Aug 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894811; cv=none; b=uuhQ8w+dW0/bxCHA68t6DCL9m5p2IfjKlzYZptGe8g09cska0uAC89JSCvUT4j2gyuiDl91g44R0u0d8tSc0aBvIh3GnC0NiAmjamzON/j4mweAyEPgpYYFtwiistFAjbY3nMYY3MGD68tubIC/ENbnfOcynalkBm1wBH16D59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894811; c=relaxed/simple;
	bh=kwzvmUCeDFltarqI/Z5MsL+v8LDSQOj5p9vYq8dEeUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLUEuYP0K13K9yBQV5jAPJeB3UatvD7cQRrvpjKqnqzDp4GqDIEPCAJZbNPNjUTHmegjAGRFGXk/UY1nsoc9u6fCGjigx/meGa62P4Cpm3H0JPtFunG3rx3MsKUFvAdSpWpscTXDPVuJykI9fLhql59/biCP/xtHU0kav4is46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WD5wFglP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p3YLpECXdbcYOBzZCmc2ouR98BYE30o8gVoPq5b+72I=; b=WD5wFglPsqsJKjqBLG3OdwdT7V
	41PMGUdf5CKAvyTBi+fnxRKVKfGm4V7Lh3v3unkEkZapvxBos/JTl4L6XGDROb9ltYEyPm+URWhV9
	sBEK4Iam2Z9mkqEyMnduB/DEQrcRorCnqtVuTWjXoi6c8jST5A3HniTiExnaG9h/cvCYkH95ZNdhU
	szjgdpni5zCxHUivwlxV4O1GspQ4cg7xB09ijsGKn1yNUgpFsXpixDNW6zcSKy1q72B1ziqHn7utd
	Ol/frwRbK/yWOx6b+va+P6lFVAOj0BjtaBnVBpsiL9s8fAFCSfiksVuQgNA9WML9DO/fLN/ij4Nlo
	B3GNMfIw==;
Received: from [223.233.69.163] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulMIu-00Cdun-Pd; Mon, 11 Aug 2025 08:46:45 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	kees@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
Date: Mon, 11 Aug 2025 12:16:08 +0530
Message-Id: <20250811064609.918593-4-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250811064609.918593-1-bhupesh@igalia.com>
References: <20250811064609.918593-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Linus mentioned in [1], we should get rid of 'get_task_comm()'
entirely and replace it with 'strscpy_pad()' implementation.

'strscpy_pad()' will already make sure comm is NUL-terminated, so
we won't need the explicit final byte termination done in
'get_task_comm()'.

The relevant 'get_task_comm()' users were identified using the
following search pattern:
 $ git grep 'get_task_comm*'

[1]. https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 drivers/connector/cn_proc.c                   |  2 +-
 drivers/dma-buf/sw_sync.c                     |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  2 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  2 +-
 drivers/gpu/drm/lima/lima_ctx.c               |  2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c         |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  2 +-
 drivers/hwtracing/stm/core.c                  |  2 +-
 drivers/tty/tty_audit.c                       |  2 +-
 fs/bcachefs/thread_with_file.c                |  2 +-
 fs/binfmt_elf.c                               |  2 +-
 fs/binfmt_elf_fdpic.c                         |  2 +-
 fs/ocfs2/cluster/netdebug.c                   |  1 -
 fs/proc/array.c                               |  2 +-
 include/linux/sched.h                         | 19 -------------------
 kernel/audit.c                                |  6 ++++--
 kernel/auditsc.c                              |  6 ++++--
 kernel/sys.c                                  |  2 +-
 mm/kmemleak.c                                 |  6 ------
 net/bluetooth/hci_sock.c                      |  2 +-
 net/netfilter/nf_tables_api.c                 |  2 +-
 security/integrity/integrity_audit.c          |  3 ++-
 security/ipe/audit.c                          |  2 +-
 security/landlock/domain.c                    |  2 +-
 security/lsm_audit.c                          |  7 ++++---
 30 files changed, 38 insertions(+), 58 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e696176..3c1b07198e10 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -278,7 +278,7 @@ void proc_comm_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_COMM;
 	ev->event_data.comm.process_pid  = task->pid;
 	ev->event_data.comm.process_tgid = task->tgid;
-	get_task_comm(ev->event_data.comm.comm, task);
+	strscpy_pad(ev->event_data.comm.comm, task->comm);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 3c20f1d31cf5..1f2ddf00799b 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -311,7 +311,7 @@ static int sw_sync_debugfs_open(struct inode *inode, struct file *file)
 	struct sync_timeline *obj;
 	char task_comm[TASK_COMM_LEN];
 
-	get_task_comm(task_comm, current);
+	strscpy_pad(task_comm, current->comm);
 
 	obj = sync_timeline_create(task_comm);
 	if (!obj)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..ea2b99fde425 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -73,7 +73,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 	/* This reference gets released in amdkfd_fence_release */
 	mmgrab(mm);
 	fence->mm = mm;
-	get_task_comm(fence->timeline_name, current);
+	strscpy_pad(fence->timeline_name, current->comm);
 	spin_lock_init(&fence->lock);
 	fence->svm_bo = svm_bo;
 	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..3e2ad72cafc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -166,7 +166,7 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
 		return NULL;
 
 	ev_fence->evf_mgr = evf_mgr;
-	get_task_comm(ev_fence->timeline_name, current);
+	strscpy_pad(ev_fence->timeline_name, current->comm);
 	spin_lock_init(&ev_fence->lock);
 	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
 			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 25bade9a5e95..8a4a4c03bbcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4169,7 +4169,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	}
 
 	con->init_task_pid = task_pid_nr(current);
-	get_task_comm(con->init_task_comm, current);
+	strscpy_pad(con->init_task_comm, current->comm);
 
 	mutex_init(&con->critical_region_lock);
 	INIT_LIST_HEAD(&con->critical_region_head);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c2a983ff23c9..73aa37f65e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -92,7 +92,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 
 	fence_drv->adev = adev;
 	fence_drv->context = dma_fence_context_alloc(1);
-	get_task_comm(fence_drv->timeline_name, current);
+	strscpy_pad(fence_drv->timeline_name, current->comm);
 
 	xa_lock_irqsave(&adev->userq_xa, flags);
 	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 39b4250ede0f..83b5d5f5775c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2516,13 +2516,13 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 		return;
 
 	vm->task_info->task.pid = current->pid;
-	get_task_comm(vm->task_info->task.comm, current);
+	strscpy_pad(vm->task_info->task.comm, current->comm);
 
 	if (current->group_leader->mm != current->mm)
 		return;
 
 	vm->task_info->tgid = current->group_leader->pid;
-	get_task_comm(vm->task_info->process_name, current->group_leader);
+	strscpy_pad(vm->task_info->process_name, current->group_leader->comm);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 77ce9cf28051..7e2f0d28b7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -598,7 +598,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	}
 
 	vres->task.pid = task_pid_nr(current);
-	get_task_comm(vres->task.comm, current);
+	strscpy_pad(vres->task.comm, current->comm);
 	list_add_tail(&vres->vres_node, &mgr->allocated_vres_list);
 
 	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size) {
diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
index 0e668fc1e0f9..7536288ec93b 100644
--- a/drivers/gpu/drm/lima/lima_ctx.c
+++ b/drivers/gpu/drm/lima/lima_ctx.c
@@ -29,7 +29,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 		goto err_out0;
 
 	ctx->pid = task_pid_nr(current);
-	get_task_comm(ctx->pname, current);
+	strscpy_pad(ctx->pname, current->comm);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index bb73f2a68a12..b6575fc43ee4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -17,7 +17,7 @@ static void panfrost_gem_debugfs_bo_add(struct panfrost_device *pfdev,
 					struct panfrost_gem_object *bo)
 {
 	bo->debugfs.creator.tgid = current->group_leader->pid;
-	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
+	strscpy_pad(bo->debugfs.creator.process_name, current->group_leader->comm);
 
 	mutex_lock(&pfdev->debugfs.gems_lock);
 	list_add_tail(&bo->debugfs.node, &pfdev->debugfs.gems_list);
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index a123bc740ba1..ba2b80c760c9 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -27,7 +27,7 @@ static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo)
 						    struct panthor_device, base);
 
 	bo->debugfs.creator.tgid = current->group_leader->pid;
-	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
+	strscpy_pad(bo->debugfs.creator.process_name, current->group_leader->comm);
 
 	mutex_lock(&ptdev->gems.lock);
 	list_add_tail(&bo->debugfs.node, &ptdev->gems.node);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c33c057365f8..d2bf221e8f01 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -50,7 +50,7 @@ static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
 	} else {
 		char dbgname[TASK_COMM_LEN];
 
-		get_task_comm(dbgname, current);
+		strscpy_pad(dbgname, current->comm);
 		virtio_gpu_cmd_context_create(vgdev, vfpriv->ctx_id,
 					      vfpriv->context_init, strlen(dbgname),
 					      dbgname);
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index cdba4e875b28..f07784c8751c 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -634,7 +634,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 		char comm[sizeof(current->comm)];
 		char *ids[] = { comm, "default", NULL };
 
-		get_task_comm(comm, current);
+		strscpy_pad(comm, current->comm);
 
 		err = stm_assign_first_policy(stmf->stm, &stmf->output, ids, 1);
 		/*
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 75542333c54a..2724341edda0 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -77,7 +77,7 @@ static void tty_audit_log(const char *description, dev_t dev,
 	audit_log_format(ab, "%s pid=%u uid=%u auid=%u ses=%u major=%d minor=%d comm=",
 			 description, pid, uid, loginuid, sessionid,
 			 MAJOR(dev), MINOR(dev));
-	get_task_comm(name, current);
+	strscpy_pad(name, current->comm);
 	audit_log_untrustedstring(ab, name);
 	audit_log_format(ab, " data=");
 	audit_log_n_hex(ab, data, size);
diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index c2eae0ab7765..eda1b6b5e3b7 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -35,7 +35,7 @@ int bch2_run_thread_with_file(struct thread_with_file *thr,
 		fd_flags |= O_WRONLY;
 
 	char name[TASK_COMM_LEN];
-	get_task_comm(name, current);
+	strscpy_pad(name, current->comm);
 
 	thr->ret = 0;
 	thr->task = kthread_create(fn, thr, "%s", name);
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 264fba0d44bd..6ea946656403 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1540,7 +1540,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	get_task_comm(psinfo->pr_fname, p);
+	strscpy_pad(psinfo->pr_fname, p->comm);
 
 	return 0;
 }
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48fd2de3bca0..605d09d3c36f 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1365,7 +1365,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	get_task_comm(psinfo->pr_fname, p);
+	strscpy_pad(psinfo->pr_fname, p->comm);
 
 	return 0;
 }
diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index bc27301eab6d..ab94ab55111e 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -122,7 +122,6 @@ static int nst_seq_show(struct seq_file *seq, void *v)
 	send = ktime_to_us(ktime_sub(now, nst->st_send_time));
 	status = ktime_to_us(ktime_sub(now, nst->st_status_time));
 
-	/* get_task_comm isn't exported.  oh well. */
 	seq_printf(seq, "%p:\n"
 		   "  pid:          %lu\n"
 		   "  tgid:         %lu\n"
diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..c65a4c2994c2 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 	else if (p->flags & PF_KTHREAD)
 		get_kthread_comm(tcomm, sizeof(tcomm), p);
 	else
-		get_task_comm(tcomm, p);
+		strscpy_pad(tcomm, p->comm);
 
 	if (escape)
 		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87e9dfaf61ac..97ea2ac2a97a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1966,25 +1966,6 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
 	__set_task_comm(tsk, from, false);		\
 })
 
-/*
- * - Why not use task_lock()?
- *   User space can randomly change their names anyway, so locking for readers
- *   doesn't make sense. For writers, locking is probably necessary, as a race
- *   condition could lead to long-term mixed results.
- *   The logic inside __set_task_comm() should ensure that the task comm is
- *   always NUL-terminated and zero-padded. Therefore the race condition between
- *   reader and writer is not an issue.
- *
- * - BUILD_BUG_ON() can help prevent the buf from being truncated.
- *   Since the callers don't perform any return value checks, this safeguard is
- *   necessary.
- */
-#define get_task_comm(buf, tsk) ({			\
-	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
-	strscpy_pad(buf, (tsk)->comm);			\
-	buf;						\
-})
-
 static __always_inline void scheduler_ipi(void)
 {
 	/*
diff --git a/kernel/audit.c b/kernel/audit.c
index 61b5744d0bb6..64623f186fc6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1621,7 +1621,8 @@ static void audit_log_multicast(int group, const char *op, int err)
 	audit_put_tty(tty);
 	audit_log_task_context(ab); /* subj= */
 	audit_log_format(ab, " comm=");
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	strscpy_pad(comm, current->comm);
+	audit_log_untrustedstring(ab, comm);
 	audit_log_d_path_exe(ab, current->mm); /* exe= */
 	audit_log_format(ab, " nl-mcgrp=%d op=%s res=%d", group, op, !err);
 	audit_log_end(ab);
@@ -2270,7 +2271,8 @@ void audit_log_task_info(struct audit_buffer *ab)
 			 audit_get_sessionid(current));
 	audit_put_tty(tty);
 	audit_log_format(ab, " comm=");
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	strscpy_pad(comm, current->comm);
+	audit_log_untrustedstring(ab, comm);
 	audit_log_d_path_exe(ab, current->mm);
 	audit_log_task_context(ab);
 }
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index eb98cd6fe91f..67a132114329 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2930,7 +2930,8 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 	audit_log_format(ab, " pid=%u", task_tgid_nr(current));
 	audit_log_task_context(ab); /* subj= */
 	audit_log_format(ab, " comm=");
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	strscpy_pad(comm, current->comm);
+	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
 }
 EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
@@ -2953,7 +2954,8 @@ static void audit_log_task(struct audit_buffer *ab)
 			 sessionid);
 	audit_log_task_context(ab);
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	strscpy_pad(comm, current->comm);
+	audit_log_untrustedstring(ab, comm);
 	audit_log_d_path_exe(ab, current->mm);
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 0d5d27cb9cbe..cb5cce753e71 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2535,7 +2535,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		proc_comm_connector(me);
 		break;
 	case PR_GET_NAME:
-		get_task_comm(comm, me);
+		strscpy_pad(comm, me->comm);
 		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
 			return -EFAULT;
 		break;
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 84265983f239..42e67c03cb7d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -682,12 +682,6 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 		strscpy(object->comm, "softirq");
 	} else {
 		object->pid = current->pid;
-		/*
-		 * There is a small chance of a race with set_task_comm(),
-		 * however using get_task_comm() here may cause locking
-		 * dependency issues with current->alloc_lock. In the worst
-		 * case, the command line is not correct.
-		 */
 		strscpy(object->comm, current->comm);
 	}
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc866759910d..759a508024be 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -106,7 +106,7 @@ static bool hci_sock_gen_cookie(struct sock *sk)
 			id = 0xffffffff;
 
 		hci_pi(sk)->cookie = id;
-		get_task_comm(hci_pi(sk)->comm, current);
+		strscpy_pad(hci_pi(sk)->comm, current->comm);
 		return true;
 	}
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 13d0ed9d1895..e3a73ca4e9c3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9658,7 +9658,7 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 
 	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
-	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
+	    nla_put_string(skb, NFTA_GEN_PROC_NAME, strscpy_pad(buf, current->comm)))
 		goto nla_put_failure;
 
 	nlmsg_end(skb, nlh);
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 0ec5e4c22cb2..28c203f0cdb7 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -54,7 +54,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 			 audit_get_sessionid(current));
 	audit_log_task_context(ab);
 	audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
-	audit_log_untrustedstring(ab, get_task_comm(name, current));
+	strscpy_pad(name, current->comm);
+	audit_log_untrustedstring(ab, name);
 	if (fname) {
 		audit_log_format(ab, " name=");
 		audit_log_untrustedstring(ab, fname);
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index de5fed62592e..b4318988c65d 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -144,7 +144,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
 	audit_log_format(ab, "ipe_op=%s ipe_hook=%s enforcing=%d pid=%d comm=",
 			 op, audit_hook_names[ctx->hook], READ_ONCE(enforce),
 			 task_tgid_nr(current));
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	audit_log_untrustedstring(ab, strscpy_pad(comm, current->comm));
 
 	if (ctx->file) {
 		audit_log_d_path(ab, " path=", &ctx->file->f_path);
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index a647b68e8d06..77b678f0f469 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -102,7 +102,7 @@ static struct landlock_details *get_current_details(void)
 	memcpy(details->exe_path, path_str, path_size);
 	details->pid = get_pid(task_tgid(current));
 	details->uid = from_kuid(&init_user_ns, current_uid());
-	get_task_comm(details->comm, current);
+	strscpy_pad(details->comm, current->comm);
 	return details;
 }
 
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 7d623b00495c..b4d3b8a69cfe 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -276,8 +276,8 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 			if (pid) {
 				char tskcomm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
-				audit_log_untrustedstring(ab,
-				    get_task_comm(tskcomm, tsk));
+				strscpy_pad(tskcomm, tsk->comm);
+				audit_log_untrustedstring(ab, tskcomm);
 			}
 		}
 		break;
@@ -417,7 +417,8 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	char comm[sizeof(current->comm)];
 
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	strscpy_pad(comm, current->comm);
+	audit_log_untrustedstring(ab, comm);
 	audit_log_lsm_data(ab, a);
 }
 
-- 
2.38.1


