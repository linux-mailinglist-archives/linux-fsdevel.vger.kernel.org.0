Return-Path: <linux-fsdevel+bounces-79222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MneIvnopmnjZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:58:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8391F0E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A08030E1CCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90335BDBA;
	Tue,  3 Mar 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWvQx82R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810343570DF;
	Tue,  3 Mar 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545766; cv=none; b=IG+kcYU/3xxEc18eN08esP6mZqS8h4ONPz47b8y28tPu7pjFCPJiyrhaPDCawu0Sea5M/Avuv+xD3AGv3arQofzPerTOo8kvry4mLsfLieLt0eaYps2LcC7uQEx9q7b+I1RzNRLNQWlfmYfrJWwT1p9HASf1MHWbZnA8SKJw0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545766; c=relaxed/simple;
	bh=oQ8uKG3Ry2N/mgkkmA1tJCwU7ZWTHkTzQBPEwjHqMfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QM6RaSKbrZH3kW7b6U2VMewm3N28DVLUNE4BPI8ohQ6FXng9BHHC8TE7EqF53rWxSRUt7IqY7hzeQv5iS4l0nxXho+9ur13YhcWf6n1pRiwh9JGNEFo+wsib376MNW121Bk79RP1KoCHAC6yPKvT3GDU9QQoaUyxKxrJvYfNHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWvQx82R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED46C19422;
	Tue,  3 Mar 2026 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545765;
	bh=oQ8uKG3Ry2N/mgkkmA1tJCwU7ZWTHkTzQBPEwjHqMfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cWvQx82R/3Duwt+pSljwlzd9gVpbfNMQ+lrOooGZ0tiaVMjLI5jzIM3/Drbq/2Koi
	 DNdEMTOEhzvvk/8vCdvKJzt2XJWPL9ubGQ544/SrBRmnZI1S1BkPfdDDBeFfTo7n39
	 BSbEpCtmv2dqB+tw90vizoBSoONPSZRTFNOUTFpOeEkPuaJ8jeOI13dT6X4sp1C8Gy
	 G8GuinhdFmCZwoBYpeK6GIkiESYpWVyuug1NKNJr2PY1pnpu5c8/IOp22ny/xMGJo9
	 1i1Ys9GHHV9rzEwSqtokSGQPq0Flhs4Y0KsPdn8rzj16NG1Ktbs/XFvaMXcALctBoJ
	 x0HMPgWmWAPCw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:13 +0100
Subject: [PATCH RFC DRAFT POC 02/11] kthread: remove unused flags argument
 from kthread worker creation API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-2-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=28588; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oQ8uKG3Ry2N/mgkkmA1tJCwU7ZWTHkTzQBPEwjHqMfg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3bv2Mxfd+aXF6y/drDSuiKH8Wj4344/yzpyFbzXv
 Uk6/ZX7fkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDq1jZPi2+2pHEysb/03v
 fYc03ZbETN6tIJYTO791+lS7S/NZZ29h+Gd5YIXLDZHZ9xazfIs32/p90hXnHJapBYL1qpkyB5a
 6lLECAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 3D8391F0E00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79222-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Every caller of kthread_create_worker(), kthread_run_worker(),
kthread_create_worker_on_cpu(), and kthread_run_worker_on_cpu() passes
0 for the flags argument. The only defined flag, KTW_FREEZABLE, has no
users anywhere in the tree.

Remove the flags parameter from the entire kthread worker creation API,
the KTW_FREEZABLE enum, the flags field from struct kthread_worker, and
the dead set_freezable() call in kthread_worker_fn().

No functional change.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/x86/kvm/i8254.c                               |  2 +-
 crypto/crypto_engine.c                             |  2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  2 +-
 drivers/dpll/zl3073x/core.c                        |  2 +-
 drivers/gpu/drm/drm_vblank_work.c                  |  6 ++---
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  4 ++--
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |  2 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |  4 ++--
 drivers/gpu/drm/i915/gt/selftest_slpc.c            |  2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      | 12 +++++-----
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c       |  2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |  2 +-
 drivers/gpu/drm/msm/msm_kms.c                      |  2 +-
 .../media/platform/chips-media/wave5/wave5-vpu.c   |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  4 ++--
 drivers/net/ethernet/intel/ice/ice_gnss.c          |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  4 ++--
 drivers/platform/chrome/cros_ec_spi.c              |  2 +-
 drivers/ptp/ptp_clock.c                            |  2 +-
 drivers/spi/spi.c                                  |  2 +-
 drivers/usb/gadget/function/uvc_video.c            |  2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |  4 ++--
 drivers/watchdog/watchdog_dev.c                    |  2 +-
 fs/erofs/zdata.c                                   |  2 +-
 include/linux/kthread.h                            | 28 +++++++---------------
 kernel/kthread.c                                   | 13 +++-------
 kernel/rcu/tree.c                                  |  4 ++--
 kernel/sched/ext.c                                 |  2 +-
 kernel/workqueue.c                                 |  2 +-
 net/dsa/tag_ksz.c                                  |  4 ++--
 net/dsa/tag_ocelot_8021q.c                         |  2 +-
 net/dsa/tag_sja1105.c                              |  4 ++--
 35 files changed, 60 insertions(+), 77 deletions(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..4f1065c96e78 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -750,7 +750,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 	pid_nr = pid_vnr(pid);
 	put_pid(pid);
 
-	pit->worker = kthread_run_worker(0, "kvm-pit/%d", pid_nr);
+	pit->worker = kthread_run_worker("kvm-pit/%d", pid_nr);
 	if (IS_ERR(pit->worker))
 		goto fail_kthread;
 
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 3d07dd5de4fa..60023f485c7f 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -456,7 +456,7 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 	guard(spinlock_init)(&engine->queue_lock);
 	crypto_init_queue(&engine->queue, qlen);
 
-	engine->kworker = kthread_run_worker(0, "%s", engine->name);
+	engine->kworker = kthread_run_worker("%s", engine->name);
 	if (IS_ERR(engine->kworker)) {
 		dev_err(dev, "failed to create crypto request pump task\n");
 		return NULL;
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 011f35cb47b9..1cdd3ed9e7a3 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -225,7 +225,7 @@ static void cppc_fie_kworker_init(void)
 	};
 	int ret;
 
-	kworker_fie = kthread_run_worker(0, "cppc_fie");
+	kworker_fie = kthread_run_worker("cppc_fie");
 	if (IS_ERR(kworker_fie)) {
 		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
 			PTR_ERR(kworker_fie));
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 63bd97181b9e..55d0ee934246 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -966,7 +966,7 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 
 	/* Initialize monitoring thread */
 	kthread_init_delayed_work(&zldev->work, zl3073x_dev_periodic_work);
-	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldev->dev));
+	kworker = kthread_run_worker("zl3073x-%s", dev_name(zldev->dev));
 	if (IS_ERR(kworker)) {
 		rc = PTR_ERR(kworker);
 		goto error;
diff --git a/drivers/gpu/drm/drm_vblank_work.c b/drivers/gpu/drm/drm_vblank_work.c
index 70f0199251ea..f5a95dc5bb05 100644
--- a/drivers/gpu/drm/drm_vblank_work.c
+++ b/drivers/gpu/drm/drm_vblank_work.c
@@ -279,9 +279,9 @@ int drm_vblank_worker_init(struct drm_vblank_crtc *vblank)
 
 	INIT_LIST_HEAD(&vblank->pending_work);
 	init_waitqueue_head(&vblank->work_wait_queue);
-	worker = kthread_run_worker(0, "card%d-crtc%d",
-				       vblank->dev->primary->index,
-				       vblank->pipe);
+	worker = kthread_run_worker("card%d-crtc%d",
+				    vblank->dev->primary->index,
+				    vblank->pipe);
 	if (IS_ERR(worker))
 		return PTR_ERR(worker);
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 9d405098f9e7..8b55eeeabe8c 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -369,8 +369,8 @@ static int live_parallel_switch(void *arg)
 		if (!data[n].ce[0])
 			continue;
 
-		worker = kthread_run_worker(0, "igt/parallel:%s",
-					       data[n].ce[0]->engine->name);
+		worker = kthread_run_worker("igt/parallel:%s",
+					    data[n].ce[0]->engine->name);
 		if (IS_ERR(worker)) {
 			err = PTR_ERR(worker);
 			goto out;
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 21e5ed9f72a3..a6edb922b7e2 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -3577,7 +3577,7 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 			arg[id].batch = NULL;
 		arg[id].count = 0;
 
-		worker[id] = kthread_run_worker(0, "igt/smoke:%d", id);
+		worker[id] = kthread_run_worker("igt/smoke:%d", id);
 		if (IS_ERR(worker[id])) {
 			err = PTR_ERR(worker[id]);
 			break;
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 00dfc37221fa..91a0ab9d6158 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -1025,8 +1025,8 @@ static int __igt_reset_engines(struct intel_gt *gt,
 			threads[tmp].engine = other;
 			threads[tmp].flags = flags;
 
-			worker = kthread_run_worker(0, "igt/%s",
-						       other->name);
+			worker = kthread_run_worker("igt/%s",
+						    other->name);
 			if (IS_ERR(worker)) {
 				err = PTR_ERR(worker);
 				pr_err("[%s] Worker create failed: %d!\n",
diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
index c3c918248989..fb69773e89d4 100644
--- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
@@ -504,7 +504,7 @@ static int live_slpc_tile_interaction(void *arg)
 		return -ENOMEM;
 
 	for_each_gt(gt, i915, i) {
-		threads[i].worker = kthread_run_worker(0, "igt/slpc_parallel:%d", gt->info.id);
+		threads[i].worker = kthread_run_worker("igt/slpc_parallel:%d", gt->info.id);
 
 		if (IS_ERR(threads[i].worker)) {
 			ret = PTR_ERR(threads[i].worker);
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index e1a7c454a0a9..54b8f7be0bdd 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -493,7 +493,7 @@ static int mock_breadcrumbs_smoketest(void *arg)
 	for (n = 0; n < ncpus; n++) {
 		struct kthread_worker *worker;
 
-		worker = kthread_run_worker(0, "igt/%d", n);
+		worker = kthread_run_worker("igt/%d", n);
 		if (IS_ERR(worker)) {
 			ret = PTR_ERR(worker);
 			ncpus = n;
@@ -1646,8 +1646,8 @@ static int live_parallel_engines(void *arg)
 		for_each_uabi_engine(engine, i915) {
 			struct kthread_worker *worker;
 
-			worker = kthread_run_worker(0, "igt/parallel:%s",
-						       engine->name);
+			worker = kthread_run_worker("igt/parallel:%s",
+						    engine->name);
 			if (IS_ERR(worker)) {
 				err = PTR_ERR(worker);
 				break;
@@ -1805,7 +1805,7 @@ static int live_breadcrumbs_smoketest(void *arg)
 			unsigned int i = idx * ncpus + n;
 			struct kthread_worker *worker;
 
-			worker = kthread_run_worker(0, "igt/%d.%d", idx, n);
+			worker = kthread_run_worker("igt/%d.%d", idx, n);
 			if (IS_ERR(worker)) {
 				ret = PTR_ERR(worker);
 				goto out_flush;
@@ -3218,8 +3218,8 @@ static int perf_parallel_engines(void *arg)
 
 			memset(&engines[idx].p, 0, sizeof(engines[idx].p));
 
-			worker = kthread_run_worker(0, "igt:%s",
-						       engine->name);
+			worker = kthread_run_worker("igt:%s",
+						    engine->name);
 			if (IS_ERR(worker)) {
 				err = PTR_ERR(worker);
 				intel_engine_pm_put(engine);
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
index d99771684728..87f8063b7390 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
@@ -109,7 +109,7 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 
 	mutex_init(&kms->dump_mutex);
 
-	kms->dump_worker = kthread_run_worker(0, "%s", "disp_snapshot");
+	kms->dump_worker = kthread_run_worker("%s", "disp_snapshot");
 	if (IS_ERR(kms->dump_worker))
 		DRM_ERROR("failed to create disp state task\n");
 
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 87a91148a731..4c7d5fb0d914 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -115,7 +115,7 @@ int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
 	timer->kms = kms;
 	timer->crtc_idx = crtc_idx;
 
-	timer->worker = kthread_run_worker(0, "atomic-worker-%d", crtc_idx);
+	timer->worker = kthread_run_worker("atomic-worker-%d", crtc_idx);
 	if (IS_ERR(timer->worker)) {
 		int ret = PTR_ERR(timer->worker);
 		timer->worker = NULL;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 84d6c7f50c8d..7b5cf071d0f3 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -989,7 +989,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->funcs = funcs;
 	gpu->name = name;
 
-	gpu->worker = kthread_run_worker(0, "gpu-worker");
+	gpu->worker = kthread_run_worker("gpu-worker");
 	if (IS_ERR(gpu->worker)) {
 		ret = PTR_ERR(gpu->worker);
 		gpu->worker = NULL;
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..69df2b46402d 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -306,7 +306,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		/* initialize event thread */
 		ev_thread = &kms->event_thread[drm_crtc_index(crtc)];
 		ev_thread->dev = ddev;
-		ev_thread->worker = kthread_run_worker(0, "crtc_event:%d", crtc->base.id);
+		ev_thread->worker = kthread_run_worker("crtc_event:%d", crtc->base.id);
 		if (IS_ERR(ev_thread->worker)) {
 			ret = PTR_ERR(ev_thread->worker);
 			DRM_DEV_ERROR(dev, "failed to create crtc_event kthread\n");
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 76d57c6b636a..fea52a23b8c2 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -342,7 +342,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		dev->irq_thread = kthread_run(irq_thread, dev, "irq thread");
 		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_PINNED);
-		dev->worker = kthread_run_worker(0, "vpu_irq_thread");
+		dev->worker = kthread_run_worker("vpu_irq_thread");
 		if (IS_ERR(dev->worker)) {
 			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
 			ret = PTR_ERR(dev->worker);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6fcd7181116a..a7a59e5e99a2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -394,7 +394,7 @@ static int mv88e6xxx_irq_poll_setup(struct mv88e6xxx_chip *chip)
 	kthread_init_delayed_work(&chip->irq_poll_work,
 				  mv88e6xxx_irq_poll);
 
-	chip->kworker = kthread_run_worker(0, "%s", dev_name(chip->dev));
+	chip->kworker = kthread_run_worker("%s", dev_name(chip->dev));
 	if (IS_ERR(chip->kworker))
 		return PTR_ERR(chip->kworker);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 62f75701d652..8c03d14d8f83 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3776,8 +3776,8 @@ static int ice_dpll_init_worker(struct ice_pf *pf)
 	struct kthread_worker *kworker;
 
 	kthread_init_delayed_work(&d->work, ice_dpll_periodic_work);
-	kworker = kthread_run_worker(0, "ice-dplls-%s",
-					dev_name(ice_pf_to_dev(pf)));
+	kworker = kthread_run_worker("ice-dplls-%s",
+				     dev_name(ice_pf_to_dev(pf)));
 	if (IS_ERR(kworker))
 		return PTR_ERR(kworker);
 	d->kworker = kworker;
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 8fd954f1ebd6..b85a96d7cac8 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -182,7 +182,7 @@ static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
 	pf->gnss_serial = gnss;
 
 	kthread_init_delayed_work(&gnss->read_work, ice_gnss_read);
-	kworker = kthread_run_worker(0, "ice-gnss-%s", dev_name(dev));
+	kworker = kthread_run_worker("ice-gnss-%s", dev_name(dev));
 	if (IS_ERR(kworker)) {
 		kfree(gnss);
 		return NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 094e96219f45..cfc8daec3d50 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3207,8 +3207,8 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 	/* Allocate a kworker for handling work required for the ports
 	 * connected to the PTP hardware clock.
 	 */
-	kworker = kthread_run_worker(0, "ice-ptp-%s",
-					dev_name(ice_pf_to_dev(pf)));
+	kworker = kthread_run_worker("ice-ptp-%s",
+				     dev_name(ice_pf_to_dev(pf)));
 	if (IS_ERR(kworker))
 		return PTR_ERR(kworker);
 
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 28fa82f8cb07..0009659712ca 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -715,7 +715,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 	int err;
 
 	ec_spi->high_pri_worker =
-		kthread_run_worker(0, "cros_ec_spi_high_pri");
+		kthread_run_worker("cros_ec_spi_high_pri");
 
 	if (IS_ERR(ec_spi->high_pri_worker)) {
 		err = PTR_ERR(ec_spi->high_pri_worker);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d6f54ccaf93b..b9811ccc9147 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -382,7 +382,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
-		ptp->kworker = kthread_run_worker(0, "ptp%d", ptp->index);
+		ptp->kworker = kthread_run_worker("ptp%d", ptp->index);
 		if (IS_ERR(ptp->kworker)) {
 			err = PTR_ERR(ptp->kworker);
 			pr_err("failed to create ptp aux_worker %d\n", err);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 61f7bde8c7fb..c0a742290207 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2046,7 +2046,7 @@ static int spi_init_queue(struct spi_controller *ctlr)
 	ctlr->busy = false;
 	ctlr->queue_empty = true;
 
-	ctlr->kworker = kthread_run_worker(0, dev_name(&ctlr->dev));
+	ctlr->kworker = kthread_run_worker(dev_name(&ctlr->dev));
 	if (IS_ERR(ctlr->kworker)) {
 		dev_err(&ctlr->dev, "failed to create message pump kworker\n");
 		return PTR_ERR(ctlr->kworker);
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 7cea641b06b4..83a745e9b820 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -819,7 +819,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 		return -EINVAL;
 
 	/* Allocate a kthread for asynchronous hw submit handler. */
-	video->kworker = kthread_run_worker(0, "UVCG");
+	video->kworker = kthread_run_worker("UVCG");
 	if (IS_ERR(video->kworker)) {
 		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
 		return PTR_ERR(video->kworker);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1d2f3af034c5..9d9b8c202ffb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7836,7 +7836,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	mutex_init(&port->lock);
 	mutex_init(&port->swap_lock);
 
-	port->wq = kthread_run_worker(0, dev_name(dev));
+	port->wq = kthread_run_worker(dev_name(dev));
 	if (IS_ERR(port->wq))
 		return ERR_CAST(port->wq);
 	sched_set_fifo(port->wq->task);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8cb1cc2ea139..78434262bb49 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -229,8 +229,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	dev = &vdpasim->vdpa.dev;
 
 	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
-	vdpasim->worker = kthread_run_worker(0, "vDPA sim worker: %s",
-						dev_attr->name);
+	vdpasim->worker = kthread_run_worker("vDPA sim worker: %s",
+					     dev_attr->name);
 	if (IS_ERR(vdpasim->worker))
 		goto err_iommu;
 
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 834f65f4b59a..13fb68728022 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1224,7 +1224,7 @@ int __init watchdog_dev_init(void)
 {
 	int err;
 
-	watchdog_kworker = kthread_run_worker(0, "watchdogd");
+	watchdog_kworker = kthread_run_worker("watchdogd");
 	if (IS_ERR(watchdog_kworker)) {
 		pr_err("Failed to create watchdog kworker\n");
 		return PTR_ERR(watchdog_kworker);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3977e42b9516..2f68e2cf393a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -309,7 +309,7 @@ static void erofs_destroy_percpu_workers(void)
 static struct kthread_worker *erofs_init_percpu_worker(int cpu)
 {
 	struct kthread_worker *worker =
-		kthread_run_worker_on_cpu(cpu, 0, "erofs_worker/%u");
+		kthread_run_worker_on_cpu(cpu, "erofs_worker/%u");
 
 	if (IS_ERR(worker))
 		return worker;
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index a01a474719a7..2630791295ac 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -137,12 +137,7 @@ struct kthread_work;
 typedef void (*kthread_work_func_t)(struct kthread_work *work);
 void kthread_delayed_work_timer_fn(struct timer_list *t);
 
-enum {
-	KTW_FREEZABLE		= 1 << 0,	/* freeze during suspend */
-};
-
 struct kthread_worker {
-	unsigned int		flags;
 	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
@@ -207,39 +202,35 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 
 int kthread_worker_fn(void *worker_ptr);
 
-__printf(3, 4)
-struct kthread_worker *kthread_create_worker_on_node(unsigned int flags,
-						     int node,
+__printf(2, 3)
+struct kthread_worker *kthread_create_worker_on_node(int node,
 						     const char namefmt[], ...);
 
-#define kthread_create_worker(flags, namefmt, ...) \
-	kthread_create_worker_on_node(flags, NUMA_NO_NODE, namefmt, ## __VA_ARGS__);
+#define kthread_create_worker(namefmt, ...) \
+	kthread_create_worker_on_node(NUMA_NO_NODE, namefmt, ## __VA_ARGS__)
 
 /**
  * kthread_run_worker - create and wake a kthread worker.
- * @flags: flags modifying the default behavior of the worker
  * @namefmt: printf-style name for the thread.
  *
  * Description: Convenient wrapper for kthread_create_worker() followed by
  * wake_up_process().  Returns the kthread_worker or ERR_PTR(-ENOMEM).
  */
-#define kthread_run_worker(flags, namefmt, ...)					\
+#define kthread_run_worker(namefmt, ...)						\
 ({										\
 	struct kthread_worker *__kw						\
-		= kthread_create_worker(flags, namefmt, ## __VA_ARGS__);	\
+		= kthread_create_worker(namefmt, ## __VA_ARGS__);		\
 	if (!IS_ERR(__kw))							\
 		wake_up_process(__kw->task);					\
 	__kw;									\
 })
 
 struct kthread_worker *
-kthread_create_worker_on_cpu(int cpu, unsigned int flags,
-			     const char namefmt[]);
+kthread_create_worker_on_cpu(int cpu, const char namefmt[]);
 
 /**
  * kthread_run_worker_on_cpu - create and wake a cpu bound kthread worker.
  * @cpu: CPU number
- * @flags: flags modifying the default behavior of the worker
  * @namefmt: printf-style name for the thread. Format is restricted
  *	     to "name.*%u". Code fills in cpu number.
  *
@@ -248,12 +239,11 @@ kthread_create_worker_on_cpu(int cpu, unsigned int flags,
  * ERR_PTR(-ENOMEM).
  */
 static inline struct kthread_worker *
-kthread_run_worker_on_cpu(int cpu, unsigned int flags,
-			  const char namefmt[])
+kthread_run_worker_on_cpu(int cpu, const char namefmt[])
 {
 	struct kthread_worker *kw;
 
-	kw = kthread_create_worker_on_cpu(cpu, flags, namefmt);
+	kw = kthread_create_worker_on_cpu(cpu, namefmt);
 	if (!IS_ERR(kw))
 		wake_up_process(kw->task);
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 84d535c7a635..4c60c8082126 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1020,9 +1020,6 @@ int kthread_worker_fn(void *worker_ptr)
 	WARN_ON(worker->task && worker->task != current);
 	worker->task = current;
 
-	if (worker->flags & KTW_FREEZABLE)
-		set_freezable();
-
 repeat:
 	set_current_state(TASK_INTERRUPTIBLE);	/* mb paired w/ kthread_stop */
 
@@ -1073,7 +1070,6 @@ EXPORT_SYMBOL_GPL(kthread_worker_fn);
 
 /**
  * kthread_create_worker_on_node - create a kthread worker
- * @flags: flags modifying the default behavior of the worker
  * @node: task structure for the thread is allocated on this node
  * @namefmt: printf-style name for the kthread worker (task).
  *
@@ -1082,7 +1078,7 @@ EXPORT_SYMBOL_GPL(kthread_worker_fn);
  * when the caller was killed by a fatal signal.
  */
 struct kthread_worker *
-kthread_create_worker_on_node(unsigned int flags, int node, const char namefmt[], ...)
+kthread_create_worker_on_node(int node, const char namefmt[], ...)
 {
 	struct kthread_create_info info = {
 		.node		= node,
@@ -1100,7 +1096,6 @@ kthread_create_worker_on_node(unsigned int flags, int node, const char namefmt[]
 		return ERR_CAST(task);
 
 	worker = kthread_data(task);
-	worker->flags = flags;
 	worker->task = task;
 	return worker;
 }
@@ -1110,7 +1105,6 @@ EXPORT_SYMBOL(kthread_create_worker_on_node);
  * kthread_create_worker_on_cpu - create a kthread worker and bind it
  *	to a given CPU and the associated NUMA node.
  * @cpu: CPU number
- * @flags: flags modifying the default behavior of the worker
  * @namefmt: printf-style name for the thread. Format is restricted
  *	     to "name.*%u". Code fills in cpu number.
  *
@@ -1143,12 +1137,11 @@ EXPORT_SYMBOL(kthread_create_worker_on_node);
  * when the caller was killed by a fatal signal.
  */
 struct kthread_worker *
-kthread_create_worker_on_cpu(int cpu, unsigned int flags,
-			     const char namefmt[])
+kthread_create_worker_on_cpu(int cpu, const char namefmt[])
 {
 	struct kthread_worker *worker;
 
-	worker = kthread_create_worker_on_node(flags, cpu_to_node(cpu), namefmt, cpu);
+	worker = kthread_create_worker_on_node(cpu_to_node(cpu), namefmt, cpu);
 	if (!IS_ERR(worker))
 		kthread_bind(worker->task, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..7d8c6de2a232 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4186,7 +4186,7 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 	if (rnp->exp_kworker)
 		return;
 
-	kworker = kthread_create_worker(0, name, rnp_index);
+	kworker = kthread_create_worker(name, rnp_index);
 	if (IS_ERR_OR_NULL(kworker)) {
 		pr_err("Failed to create par gp kworker on %d/%d\n",
 		       rnp->grplo, rnp->grphi);
@@ -4206,7 +4206,7 @@ static void __init rcu_start_exp_gp_kworker(void)
 	const char *name = "rcu_exp_gp_kthread_worker";
 	struct sched_param param = { .sched_priority = kthread_prio };
 
-	rcu_exp_gp_kworker = kthread_run_worker(0, name);
+	rcu_exp_gp_kworker = kthread_run_worker(name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
 		pr_err("Failed to create %s!\n", name);
 		rcu_exp_gp_kworker = NULL;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 62b1f3ac5630..4d2fd73de353 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4863,7 +4863,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 		goto err_free_gdsqs;
 	}
 
-	sch->helper = kthread_run_worker(0, "sched_ext_helper");
+	sch->helper = kthread_run_worker("sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
 		ret = PTR_ERR(sch->helper);
 		goto err_free_pcpu;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeaec79bc09c..3670ea197327 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7954,7 +7954,7 @@ static void __init wq_cpu_intensive_thresh_init(void)
 	unsigned long thresh;
 	unsigned long bogo;
 
-	pwq_release_worker = kthread_run_worker(0, "pool_workqueue_release");
+	pwq_release_worker = kthread_run_worker("pool_workqueue_release");
 	BUG_ON(IS_ERR(pwq_release_worker));
 
 	/* if the user set it to a specific value, keep it */
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index d2475c3bbb7d..5285a076476c 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -66,8 +66,8 @@ static int ksz_connect(struct dsa_switch *ds)
 	if (!priv)
 		return -ENOMEM;
 
-	xmit_worker = kthread_run_worker(0, "dsa%d:%d_xmit",
-					    ds->dst->index, ds->index);
+	xmit_worker = kthread_run_worker("dsa%d:%d_xmit",
+					 ds->dst->index, ds->index);
 	if (IS_ERR(xmit_worker)) {
 		ret = PTR_ERR(xmit_worker);
 		kfree(priv);
diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index e89d9254e90a..c3d294a5149e 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -110,7 +110,7 @@ static int ocelot_connect(struct dsa_switch *ds)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->xmit_worker = kthread_run_worker(0, "felix_xmit");
+	priv->xmit_worker = kthread_run_worker("felix_xmit");
 	if (IS_ERR(priv->xmit_worker)) {
 		err = PTR_ERR(priv->xmit_worker);
 		kfree(priv);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index de6d4ce8668b..50c7f8fe7a5e 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -707,8 +707,8 @@ static int sja1105_connect(struct dsa_switch *ds)
 
 	spin_lock_init(&priv->meta_lock);
 
-	xmit_worker = kthread_run_worker(0, "dsa%d:%d_xmit",
-					    ds->dst->index, ds->index);
+	xmit_worker = kthread_run_worker("dsa%d:%d_xmit",
+					 ds->dst->index, ds->index);
 	if (IS_ERR(xmit_worker)) {
 		err = PTR_ERR(xmit_worker);
 		kfree(priv);

-- 
2.47.3


