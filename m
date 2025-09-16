Return-Path: <linux-fsdevel+bounces-61706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3DB590AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE06418991F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592B2ED87F;
	Tue, 16 Sep 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B1Lgn0ri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882732EB853
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011384; cv=none; b=pZev/2jBLD9h7wr6HGv5hZ3Hbr1XCcto+7oRufMW/CkY45glE+TUnQtWf/yvUyrwRoxiNnt67f5uW0+tzopbKRPSra0zD8j8ejIUm5SX6lsZLRpD4IusjO+lF/i/oZQZ3bZi4A8orRlDE558bjAsmjjX5s0ny3JrJDhqi1HVggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011384; c=relaxed/simple;
	bh=RhnMnSiyE5w7nQ2hNx+e79D7ApOroWPIWatouF+Y99Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIn/YV8+qnOZ4Lt0Y9djMJeFeCst0K78wiMxzsEWpfV+gzdJPt8v9CQtyVjHnOTNvswOhHEk4Pdd+rsZonqzcwrgBkp+BXP8S2jcYRirjVLvIyoHVDaS77Qgr4QAX+TVepxQX16EDrJEy/MaEJKm3YktdX3Qj//ZtBRvQPcYYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B1Lgn0ri; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so46947095e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758011380; x=1758616180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbJSoOKen5SxomC3r8FovjHSg2UWh6anxEf3JfwaO64=;
        b=B1Lgn0riAHMcofE5qbhUugKk1DFqEycte6y1xg4FuFAyoMwkrWaN8Wsc8Ev5FEMxwn
         KJ5BvVrEadU6vqSCvQaOsn9AN4dAJBXgHQ2T/vcWRzknb6oOr5xz+RjEqbE7VQP0bKQt
         +kNJw/9SmHHCF1wCmW6uATFfF+iO55SHSXHo7y15BZbyirbfTnft1WND6uW3qLb5PyJA
         nhAoOQNwVDIk0HS8YYP6otIMlxM3eOz+/CJURxBYnzXFb61cknnGE/i1z8MXNCv8Hfqn
         UgLJ85eWfdSRV/d387oXbV9Q18IvfGXmjw2N++282bz6MbBlt8jFr7DRIcOkyC/vbvMr
         0fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758011380; x=1758616180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbJSoOKen5SxomC3r8FovjHSg2UWh6anxEf3JfwaO64=;
        b=eZryNROfmXzmQufhA/m/mtj+zsFBv+cmZH5ZuM8CpdJhx3jIAJ+QyZq3N4RZgXqXl8
         1/uyqO/gyhYd7T4NDU5BjYYcQPrl/OGyrCNiP28JfpkO+hasCJK1YJexUIaQmpL6Q+2A
         vqU5XvMmcNOZOdggIJznibiJwkSEnlzarYBg+CKLjV2uRw/Rf3h2fk7nKmQ7aCBufdUL
         Se/FldoB99q+4zpF42LgtPkieq1sC8JxUhRWA6LwGXwOR0pc0QDVoFB0+wHPQacCi8zR
         HYC+94lFP8bM4yYQq/hwic6paXpnfxxxyoWMClsA9cMtjIuc/IkKavGnFA1DneYtJ01i
         Z+7A==
X-Forwarded-Encrypted: i=1; AJvYcCWUPVOWfePP54IQLTCkuffaVgFNyWZDBIPX2oaZKw4uoBfTxwOTNsWeMUrUqzaGPeTMuORUdkIs3CnCRMSY@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDcBB83SwjLSkS1I8f3jZ1kFHvC/DACD2jKafgd9MytY6jI/2
	f+OhKzPYVz7KdovSSTrQcdAyEfADfCRFLgaKSi+QVYqE7KcrddCuZDqKnWgQEme43FE=
X-Gm-Gg: ASbGnctt8BnPj0xOE/o62cDs0+LwqnqRATIW34TnDwQTwO1t8C160HtxYW6uoyJhka+
	utZaCDGSaYtj5c4Hh3jsd6DjeybXvy//1ohkvBNnqHRz4KqbnCeBED09chEHJNJ5MliOAtciL2F
	8o+CmMxMgOpbioN8uvrPBbkkdmPtS/dgcIUAdWt/+QRx0YD/AqkMhQBuIPnj8ZAQNveXeo4jeIU
	Gg6fSzeBU9YhogQCEeXhHzAPThutwizYNItYW543z04SPSPm1bDrErg+Xz0pjrMyxnsng3co2qz
	BLRh/1OECcdav9wG0qbkccivAOXmj79h90row6GA5MdeiStTwjQ59O1K9FnpNy+EzwEq+0cq1I3
	XUiyn9srurw2LjbViJ2QrBC50mc2VsC+k8l5vZ8g69y6Alss=
X-Google-Smtp-Source: AGHT+IHWxjvmEys/piSSod/WbbNumEjg8pRUdu6ibUWhdUADnxmqtO01su2HmjDVUPND5X+nSqa2ug==
X-Received: by 2002:a05:6000:2c07:b0:3d3:494b:4e5d with SMTP id ffacd0b85a97d-3e765532afdmr12067163f8f.0.1758011379635;
        Tue, 16 Sep 2025 01:29:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm11006125f8f.32.2025.09.16.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:29:39 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 3/3] fs: WQ_PERCPU added to alloc_workqueue users
Date: Tue, 16 Sep 2025 10:29:06 +0200
Message-ID: <20250916082906.77439-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916082906.77439-1-marco.crivellari@suse.com>
References: <20250916082906.77439-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to all the fs subsystem users to
explicitly request the use of the per-CPU behavior. Both flags coexist
for one release cycle to allow callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/afs/main.c                  |  4 ++--
 fs/bcachefs/super.c            | 10 +++++-----
 fs/btrfs/disk-io.c             |  2 +-
 fs/ceph/super.c                |  2 +-
 fs/dlm/lowcomms.c              |  2 +-
 fs/dlm/main.c                  |  2 +-
 fs/fs-writeback.c              |  2 +-
 fs/gfs2/main.c                 |  5 +++--
 fs/gfs2/ops_fstype.c           |  6 ++++--
 fs/ocfs2/dlm/dlmdomain.c       |  3 ++-
 fs/ocfs2/dlmfs/dlmfs.c         |  3 ++-
 fs/smb/client/cifsfs.c         | 16 +++++++++++-----
 fs/smb/server/ksmbd_work.c     |  2 +-
 fs/smb/server/transport_rdma.c |  3 ++-
 fs/super.c                     |  3 ++-
 fs/verity/verify.c             |  2 +-
 fs/xfs/xfs_log.c               |  3 +--
 fs/xfs/xfs_mru_cache.c         |  3 ++-
 fs/xfs/xfs_super.c             | 15 ++++++++-------
 19 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/fs/afs/main.c b/fs/afs/main.c
index 02475d415d88..e6bb8237db98 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -169,13 +169,13 @@ static int __init afs_init(void)
 
 	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1 registering.\n");
 
-	afs_wq = alloc_workqueue("afs", 0, 0);
+	afs_wq = alloc_workqueue("afs", WQ_PERCPU, 0);
 	if (!afs_wq)
 		goto error_afs_wq;
 	afs_async_calls = alloc_workqueue("kafsd", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!afs_async_calls)
 		goto error_async;
-	afs_lock_manager = alloc_workqueue("kafs_lockd", WQ_MEM_RECLAIM, 0);
+	afs_lock_manager = alloc_workqueue("kafs_lockd", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!afs_lock_manager)
 		goto error_lockmgr;
 
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index c46b1053a02c..f2417d298b84 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -801,13 +801,13 @@ int bch2_fs_init_rw(struct bch_fs *c)
 	if (!(c->btree_update_wq = alloc_workqueue("bcachefs",
 				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_UNBOUND, 512)) ||
 	    !(c->btree_write_complete_wq = alloc_workqueue("bcachefs_btree_write_complete",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 1)) ||
+				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_PERCPU, 1)) ||
 	    !(c->copygc_wq = alloc_workqueue("bcachefs_copygc",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 1)) ||
+				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE|WQ_PERCPU, 1)) ||
 	    !(c->btree_write_submit_wq = alloc_workqueue("bcachefs_btree_write_sumit",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 1)) ||
+				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_PERCPU, 1)) ||
 	    !(c->write_ref_wq = alloc_workqueue("bcachefs_write_ref",
-				WQ_FREEZABLE, 0)))
+				WQ_FREEZABLE|WQ_PERCPU, 0)))
 		return bch_err_throw(c, ENOMEM_fs_other_alloc);
 
 	int ret = bch2_fs_btree_interior_update_init(c) ?:
@@ -975,7 +975,7 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts *opts,
 		sizeof(struct sort_iter_set);
 
 	if (!(c->btree_read_complete_wq = alloc_workqueue("bcachefs_btree_read_complete",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 512)) ||
+				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_PERCPU, 512)) ||
 	    enumerated_ref_init(&c->writes, BCH_WRITE_REF_NR,
 				bch2_writes_disabled) ||
 	    mempool_init_kmalloc_pool(&c->fill_iter, 1, iter_size) ||
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70fc4e7cc5a0..aa4393eba997 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1958,7 +1958,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 {
 	u32 max_active = fs_info->thread_pool_size;
 	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
-	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE;
+	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c3eb651862c5..2dc64515f259 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -862,7 +862,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	fsc->inode_wq = alloc_workqueue("ceph-inode", WQ_UNBOUND, 0);
 	if (!fsc->inode_wq)
 		goto fail_client;
-	fsc->cap_wq = alloc_workqueue("ceph-cap", 0, 1);
+	fsc->cap_wq = alloc_workqueue("ceph-cap", WQ_PERCPU, 1);
 	if (!fsc->cap_wq)
 		goto fail_inode_wq;
 
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index e4373bce1bc2..9a0b6c2b6b01 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1703,7 +1703,7 @@ static int work_start(void)
 		return -ENOMEM;
 	}
 
-	process_workqueue = alloc_workqueue("dlm_process", WQ_HIGHPRI | WQ_BH, 0);
+	process_workqueue = alloc_workqueue("dlm_process", WQ_HIGHPRI | WQ_BH | WQ_PERCPU, 0);
 	if (!process_workqueue) {
 		log_print("can't start dlm_process");
 		destroy_workqueue(io_workqueue);
diff --git a/fs/dlm/main.c b/fs/dlm/main.c
index 4887c8a05318..a44d16da7187 100644
--- a/fs/dlm/main.c
+++ b/fs/dlm/main.c
@@ -52,7 +52,7 @@ static int __init init_dlm(void)
 	if (error)
 		goto out_user;
 
-	dlm_wq = alloc_workqueue("dlm_wq", 0, 0);
+	dlm_wq = alloc_workqueue("dlm_wq", WQ_PERCPU, 0);
 	if (!dlm_wq) {
 		error = -ENOMEM;
 		goto out_plock;
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 21aaed728929..4f64971f8c70 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1180,7 +1180,7 @@ void cgroup_writeback_umount(struct super_block *sb)
 
 static int __init cgroup_writeback_init(void)
 {
-	isw_wq = alloc_workqueue("inode_switch_wbs", 0, 0);
+	isw_wq = alloc_workqueue("inode_switch_wbs", WQ_PERCPU, 0);
 	if (!isw_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 0727f60ad028..9d65719353fa 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -151,7 +151,8 @@ static int __init init_gfs2_fs(void)
 
 	error = -ENOMEM;
 	gfs2_recovery_wq = alloc_workqueue("gfs2_recovery",
-					  WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+					  WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU,
+					  0);
 	if (!gfs2_recovery_wq)
 		goto fail_wq1;
 
@@ -160,7 +161,7 @@ static int __init init_gfs2_fs(void)
 	if (!gfs2_control_wq)
 		goto fail_wq2;
 
-	gfs2_freeze_wq = alloc_workqueue("gfs2_freeze", 0, 0);
+	gfs2_freeze_wq = alloc_workqueue("gfs2_freeze", WQ_PERCPU, 0);
 
 	if (!gfs2_freeze_wq)
 		goto fail_wq3;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..05f936cc5db7 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1193,13 +1193,15 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = -ENOMEM;
 	sdp->sd_glock_wq = alloc_workqueue("gfs2-glock/%s",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE, 0,
+			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE | WQ_PERCPU,
+			0,
 			sdp->sd_fsname);
 	if (!sdp->sd_glock_wq)
 		goto fail_iput;
 
 	sdp->sd_delete_wq = alloc_workqueue("gfs2-delete/%s",
-			WQ_MEM_RECLAIM | WQ_FREEZABLE, 0, sdp->sd_fsname);
+			WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU, 0,
+			sdp->sd_fsname);
 	if (!sdp->sd_delete_wq)
 		goto fail_glock_wq;
 
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 2018501b2249..2347a50f079b 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -1876,7 +1876,8 @@ static int dlm_join_domain(struct dlm_ctxt *dlm)
 	dlm_debug_init(dlm);
 
 	snprintf(wq_name, O2NM_MAX_NAME_LEN, "dlm_wq-%s", dlm->name);
-	dlm->dlm_worker = alloc_workqueue(wq_name, WQ_MEM_RECLAIM, 0);
+	dlm->dlm_worker = alloc_workqueue(wq_name, WQ_MEM_RECLAIM | WQ_PERCPU,
+					  0);
 	if (!dlm->dlm_worker) {
 		status = -ENOMEM;
 		mlog_errno(status);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5130ec44e5e1..0b730535b2c8 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -595,7 +595,8 @@ static int __init init_dlmfs_fs(void)
 	}
 	cleanup_inode = 1;
 
-	user_dlm_worker = alloc_workqueue("user_dlm", WQ_MEM_RECLAIM, 0);
+	user_dlm_worker = alloc_workqueue("user_dlm",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!user_dlm_worker) {
 		status = -ENOMEM;
 		goto bail;
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e1848276bab4..c99f3916cab2 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1895,7 +1895,9 @@ init_cifs(void)
 		cifs_dbg(VFS, "dir_cache_timeout set to max of 65000 seconds\n");
 	}
 
-	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	cifsiod_wq = alloc_workqueue("cifsiod",
+				     WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+				     0);
 	if (!cifsiod_wq) {
 		rc = -ENOMEM;
 		goto out_clean_proc;
@@ -1923,28 +1925,32 @@ init_cifs(void)
 	}
 
 	cifsoplockd_wq = alloc_workqueue("cifsoplockd",
-					 WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					 WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					 0);
 	if (!cifsoplockd_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_fileinfo_put_wq;
 	}
 
 	deferredclose_wq = alloc_workqueue("deferredclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					   0);
 	if (!deferredclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsoplockd_wq;
 	}
 
 	serverclose_wq = alloc_workqueue("serverclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					   0);
 	if (!serverclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_deferredclose_wq;
 	}
 
 	cfid_put_wq = alloc_workqueue("cfid_put_wq",
-				      WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				      WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+				      0);
 	if (!cfid_put_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_serverclose_wq;
diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 72b00ca6e455..4a71f46d7020 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -78,7 +78,7 @@ int ksmbd_work_pool_init(void)
 
 int ksmbd_workqueue_init(void)
 {
-	ksmbd_wq = alloc_workqueue("ksmbd-io", 0, 0);
+	ksmbd_wq = alloc_workqueue("ksmbd-io", WQ_PERCPU, 0);
 	if (!ksmbd_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 5466aa8c39b1..4f89a7a33a26 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2177,7 +2177,8 @@ int ksmbd_rdma_init(void)
 	 * for lack of credits
 	 */
 	smb_direct_wq = alloc_workqueue("ksmbd-smb_direct-wq",
-					WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+					WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
+					0);
 	if (!smb_direct_wq)
 		return -ENOMEM;
 
diff --git a/fs/super.c b/fs/super.c
index 7f876f32343a..5cb3f41e42ca 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2314,7 +2314,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
 {
 	struct workqueue_struct *old;
 	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
-						      WQ_MEM_RECLAIM, 0,
+						      WQ_MEM_RECLAIM | WQ_PERCPU,
+						      0,
 						      sb->s_id);
 	if (!wq)
 		return -ENOMEM;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index a1f00c3fd3b2..628c23710f9f 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -355,7 +355,7 @@ void __init fsverity_init_workqueue(void)
 	 * latency on ARM64.
 	 */
 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
-						  WQ_HIGHPRI,
+						  WQ_HIGHPRI | WQ_PERCPU,
 						  num_online_cpus());
 	if (!fsverity_read_workqueue)
 		panic("failed to allocate fsverity_read_queue");
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index c8a57e21a1d3..0da19472d603 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1489,8 +1489,7 @@ xlog_alloc_log(
 	log->l_iclog->ic_prev = prev_iclog;	/* re-write 1st prev ptr */
 
 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM |
-				    WQ_HIGHPRI),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU),
 			0, mp->m_super->s_id);
 	if (!log->l_ioend_workqueue)
 		goto out_free_iclog;
diff --git a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
index 866c71d9fbae..73b7e72944e4 100644
--- a/fs/xfs/xfs_mru_cache.c
+++ b/fs/xfs/xfs_mru_cache.c
@@ -293,7 +293,8 @@ int
 xfs_mru_cache_init(void)
 {
 	xfs_mru_reap_wq = alloc_workqueue("xfs_mru_cache",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 1);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU),
+			1);
 	if (!xfs_mru_reap_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bb0a82635a77..43e9aab71610 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -578,19 +578,19 @@ xfs_init_mount_workqueues(
 	struct xfs_mount	*mp)
 {
 	mp->m_buf_workqueue = alloc_workqueue("xfs-buf/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			1, mp->m_super->s_id);
 	if (!mp->m_buf_workqueue)
 		goto out;
 
 	mp->m_unwritten_workqueue = alloc_workqueue("xfs-conv/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			0, mp->m_super->s_id);
 	if (!mp->m_unwritten_workqueue)
 		goto out_destroy_buf;
 
 	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			0, mp->m_super->s_id);
 	if (!mp->m_reclaim_workqueue)
 		goto out_destroy_unwritten;
@@ -602,13 +602,14 @@ xfs_init_mount_workqueues(
 		goto out_destroy_reclaim;
 
 	mp->m_inodegc_wq = alloc_workqueue("xfs-inodegc/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			1, mp->m_super->s_id);
 	if (!mp->m_inodegc_wq)
 		goto out_destroy_blockgc;
 
 	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE), 0, mp->m_super->s_id);
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_PERCPU), 0,
+			mp->m_super->s_id);
 	if (!mp->m_sync_workqueue)
 		goto out_destroy_inodegc;
 
@@ -2596,8 +2597,8 @@ xfs_init_workqueues(void)
 	 * AGs in all the filesystems mounted. Hence use the default large
 	 * max_active value for this workqueue.
 	 */
-	xfs_alloc_wq = alloc_workqueue("xfsalloc",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 0);
+	xfs_alloc_wq = alloc_workqueue("xfsalloc", XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU),
+			0);
 	if (!xfs_alloc_wq)
 		return -ENOMEM;
 
-- 
2.51.0


