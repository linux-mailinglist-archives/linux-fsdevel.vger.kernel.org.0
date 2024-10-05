Return-Path: <linux-fsdevel+bounces-31080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0017C9919DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8527028264C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB615F330;
	Sat,  5 Oct 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px89USbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F269231C90
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155851; cv=none; b=qr2ePwKuZ6eAUHPdam3+hlcyi+8SNYUUVZBiEZtjbzvv/r0adFD8zw2/F2cg0ogyoeDbQ1pPYxN3o/fzimqP1F7hGXU5fKuXoCLSw2Tj48Td2rbzUqZaDG4s28+kp1p0ptGTQoflEPk2pSskfktzMHkLQL0olfHewP+dLhlf34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155851; c=relaxed/simple;
	bh=TjrlFnpPUkZwMkMMge5NVd4X+MrjZzl6ohROuGT0tOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rtwj/cxyqfIODiuSbXl/SGk9gGGpwdovoD6cisnqoH1nLgc5AmKv1jzfxDCQCH1fOVEmNmUg+agyaWBIyFiRV6bSbnEpxLZ8JhHVGzkWC3ztZDPALJcEaza2KDiroGBW1D6m5FDOT1nhap9+NIgC6fTAQih6AJdegXJ6NYwrlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px89USbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC24FC4CECF;
	Sat,  5 Oct 2024 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728155850;
	bh=TjrlFnpPUkZwMkMMge5NVd4X+MrjZzl6ohROuGT0tOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=px89USbmBMrwLu4cmBM7MKLFPSA+gOW1Wir3Hg5Uvc6z4ImffRTN+PYIP2qcSP/43
	 fpqwG1ZUs3r0N2RYzTN20u9EH3r1KLRlSXwWzQi+NA5EtVqp7wsIAI0oOaCYGR+SOf
	 hAgBcIx0xDiyuwDf2WvI/ApxM2DEQc5dY3I4b0KbEP3+Ego39LNfDWIhx0YL69hzsu
	 CykH3WymLYVrcGTe0WeByk+AE06ksWWyXFcvYwiYG4Fg0fsMrktZKEBCHGzkGnOcF+
	 EYYil/BhsPBiAVi6mOVrdUZQ1A+Y0TGyQNq0xAVmmXuqwGhabF/5UVdDqLCtDb8crB
	 iW3T//aNTbulA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 05 Oct 2024 21:16:47 +0200
Subject: [PATCH RFC 4/4] fs: port files to rcuref_long_t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-brauner-file-rcuref-v1-4-725d5e713c86@kernel.org>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
In-Reply-To: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13005; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TjrlFnpPUkZwMkMMge5NVd4X+MrjZzl6ohROuGT0tOY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzTjhc9YPH+c3aHWZnj939df2L5tGcjdK7o4LCA+prv
 h48brR8VUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE4qUYGe7PNXpY+dFVfZLf
 nsKTN1TZz9v+EHR5IWd2+vUa+VerV8YxMlydlHykNHVLglGQVEsu398JJZ8ttmsVcr24USTZdsB
 zNx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

As atomic_inc_not_zero() is implemented with a try_cmpxchg() loop it has
O(N^2) behaviour under contention with N concurrent operations. The
rcuref infrastructure uses atomic_add_negative_relaxed() for the fast
path, which scales better under contention and we get overflow
protection for free.

I've been testing this with will-it-scale using fstat() on a machine
that Jens gave me access (thank you very much!):

processor       : 511
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 160
model name      : AMD EPYC 9754 128-Core Processor

and I consistently get a 3-5% improvement on 256+ threads.

Files are SLAB_TYPESAFE_BY_RCU and thus don't have "regular" rcu
protection. In short, freeing of files isn't delayed until a grace
period has elapsed. Instead, they are freed immediately and thus can be
reused (multiple times) within the same grace period.

So when picking a file from the file descriptor table via its file
descriptor number it is thus possible to see an elevated reference count
on file->f_count even though the file has already been recycled possibly
multiple times by another task. To guard against this the vfs will pick
the file from the file descriptor via its file descriptor number twice.
Once before the rcuref_long_get() and once after and compare the
pointers (grossly simplified). If they match then the file is still
valid. If not the caller needs to fput() it.

The rcuref infrastructure requires explicit rcu protection to handle the
following race:

> Deconstruction race
> ===================
>
> The release operation must be protected by prohibiting a grace period in
> order to prevent a possible use after free:
>
>      T1                              T2
>      put()                           get()
>      // ref->refcnt = ONEREF
>      if (!atomic_add_negative(-1, &ref->refcnt))
>              return false;                           <- Not taken
>
>      // ref->refcnt == NOREF
>      --> preemption
>                                      // Elevates ref->refcnt to ONEREF
>                                      if (!atomic_add_negative(1, &ref->refcnt))
>                                              return true;                    <- taken
>
>                                      if (put(&p->ref)) { <-- Succeeds
>                                              remove_pointer(p);
>                                              kfree_rcu(p, rcu);
>                                      }
>
>              RCU grace period ends, object is freed
>
>      atomic_cmpxchg(&ref->refcnt, NOREF, DEAD);      <- UAF
>
> [...] it prevents the grace period which keeps the object alive until
> all put() operations complete.

Having files by SLAB_TYPESAFE_BY_RCU shouldn't cause any problems for
the rcuref deconstruction race. Afaict, the only interesting case would
be someone freeing the file and someone immediately recycling it within
the same grace period and reinitializing file->f_count to ONEREF while a
concurrent fput() is doing atomic_cmpxchg(&ref->refcnt, NOREF, DEAD) as
in the race above.

But this seems safe from SLAB_TYPESAFE_BY_RCU's perspective and it
should be safe from rcuref's perspective.

      T1                              T2                                                    T3
      fput()                          fget()
      // f_count->refcnt = ONEREF
      if (!atomic_add_negative(-1, &f_count->refcnt))
              return false;                           <- Not taken

      // f_count->refcnt == NOREF
      --> preemption
                                      // Elevates f_count->refcnt to ONEREF
                                      if (!atomic_add_negative(1, &f_count->refcnt))
                                              return true;                    <- taken

                                      if (put(&f_count)) { <-- Succeeds
                                              remove_pointer(p);
                                              /*
                                               * Cache is SLAB_TYPESAFE_BY_RCU
                                               * so this is freed without a grace period.
                                               */
                                              kmem_cache_free(p);
                                      }

                                                                                             kmem_cache_alloc()
                                                                                             init_file() {
                                                                                                     // Sets f_count->refcnt to ONEREF
                                                                                                     rcuref_long_init(&f->f_count, 1);
                                                                                             }

                        Object has been reused within the same grace period
                        via kmem_cache_alloc()'s SLAB_TYPESAFE_BY_RCU.

      /*
       * With SLAB_TYPESAFE_BY_RCU this would be a safe UAF access and
       * it would probably work correctly because the atomic_cmpxchg()
       * will fail because the refcount has been reset to ONEREF by T3.
       */
      atomic_cmpxchg(&ref->refcnt, NOREF, DEAD);      <- UAF

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpu/drm/i915/gt/shmem_utils.c |  2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c   |  2 +-
 fs/eventpoll.c                        |  2 +-
 fs/file.c                             | 17 ++++++++---------
 fs/file_table.c                       |  7 ++++---
 include/linux/fs.h                    |  9 +++++----
 include/linux/rcuref_long.h           |  5 +++--
 7 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 1fb6ff77fd899111a0797dac0edd3f2cfa01f42d..bb696b29ee2c992c6b6d0ec5ae538f9ebbb9ed29 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -40,7 +40,7 @@ struct file *shmem_create_from_object(struct drm_i915_gem_object *obj)
 
 	if (i915_gem_object_is_shmem(obj)) {
 		file = obj->base.filp;
-		atomic_long_inc(&file->f_count);
+		get_file(file);
 		return file;
 	}
 
diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 3353e97687d1d5d0e05bdc8f26ae4b0aae53a997..539dfec0e623ec2be730924fe7b8e28a2ff1face 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -471,7 +471,7 @@ void ttm_object_device_release(struct ttm_object_device **p_tdev)
  */
 static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
 {
-	return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
+	return rcuref_long_get(&dmabuf->file->f_count);
 }
 
 /**
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd88b07e323d0dd75be6c0fe9fff54f..0a033950225af274c21e503a6ea4813e5bab5dc2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1002,7 +1002,7 @@ static struct file *epi_fget(const struct epitem *epi)
 	struct file *file;
 
 	file = epi->ffd.file;
-	if (!atomic_long_inc_not_zero(&file->f_count))
+	if (!rcuref_long_get(&file->f_count))
 		file = NULL;
 	return file;
 }
diff --git a/fs/file.c b/fs/file.c
index 5125607d040a2ff073e170d043124db5f444a90a..74e7a1cd709fc2147655d5e4b75cc2d8250bed88 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -866,10 +866,10 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	if (!file)
 		return NULL;
 
-	if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
+	if (unlikely(!rcuref_long_get(&file->f_count)))
 		return ERR_PTR(-EAGAIN);
 
-	file_reloaded = rcu_dereference_raw(*f);
+	file_reloaded = smp_load_acquire(f);
 
 	/*
 	 * Ensure that all accesses have a dependency on the load from
@@ -880,8 +880,8 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
 
 	/*
-	 * atomic_long_inc_not_zero() above provided a full memory
-	 * barrier when we acquired a reference.
+	 * smp_load_acquire() provided an acquire barrier when we loaded
+	 * the file pointer.
 	 *
 	 * This is paired with the write barrier from assigning to the
 	 * __rcu protected file pointer so that if that pointer still
@@ -979,11 +979,10 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 * We need to confirm it by incrementing the refcount
 		 * and then check the lookup again.
 		 *
-		 * atomic_long_inc_not_zero() gives us a full memory
-		 * barrier. We only really need an 'acquire' one to
-		 * protect the loads below, but we don't have that.
+		 * rcuref_long_get() doesn't provide a memory barrier so
+		 * we use smp_load_acquire() on the file pointer below.
 		 */
-		if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
+		if (unlikely(!rcuref_long_get(&file->f_count)))
 			continue;
 
 		/*
@@ -1000,7 +999,7 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 *
 		 * If so, we need to put our ref and try again.
 		 */
-		if (unlikely(file != rcu_dereference_raw(*fdentry)) ||
+		if (unlikely(file != smp_load_acquire(fdentry)) ||
 		    unlikely(rcu_dereference_raw(files->fdt) != fdt)) {
 			fput(file);
 			continue;
diff --git a/fs/file_table.c b/fs/file_table.c
index 9fc9048145ca023ef8af8769d5f1234a69f10df1..f4b96a9dade804a81347865625418a0fdc9a7c09 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -28,6 +28,7 @@
 #include <linux/task_work.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/rcuref_long.h>
 
 #include <linux/atomic.h>
 
@@ -175,7 +176,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * fget-rcu pattern users need to be able to handle spurious
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
-	atomic_long_set(&f->f_count, 1);
+	rcuref_long_init(&f->f_count, 1);
 	return 0;
 }
 
@@ -480,7 +481,7 @@ static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
 void fput(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
+	if (rcuref_long_put_rcusafe(&file->f_count)) {
 		struct task_struct *task = current;
 
 		if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
@@ -513,7 +514,7 @@ void fput(struct file *file)
  */
 void __fput_sync(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count))
+	if (rcuref_long_put_rcusafe(&file->f_count))
 		__fput(file);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337650d562405500013f5c4cfed8eb6..a7831eaf0edd13ebe9765e532602688b317da315 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/maple_tree.h>
 #include <linux/rw_hint.h>
+#include <linux/rcuref_long.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1030,7 +1031,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_freeptr: Pointer used by SLAB_TYPESAFE_BY_RCU file cache (don't touch.)
  */
 struct file {
-	atomic_long_t			f_count;
+	rcuref_long_t			f_count;
 	spinlock_t			f_lock;
 	fmode_t				f_mode;
 	const struct file_operations	*f_op;
@@ -1078,15 +1079,15 @@ struct file_handle {
 
 static inline struct file *get_file(struct file *f)
 {
-	long prior = atomic_long_fetch_inc_relaxed(&f->f_count);
-	WARN_ONCE(!prior, "struct file::f_count incremented from zero; use-after-free condition present!\n");
+	WARN_ONCE(!rcuref_long_get(&f->f_count),
+		  "struct file::f_count incremented from zero; use-after-free condition present!\n");
 	return f;
 }
 
 struct file *get_file_rcu(struct file __rcu **f);
 struct file *get_file_active(struct file **f);
 
-#define file_count(x)	atomic_long_read(&(x)->f_count)
+#define file_count(x)	rcuref_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
diff --git a/include/linux/rcuref_long.h b/include/linux/rcuref_long.h
index 7cedc537e5268e114f1a4221a4f1b0cb8d0e1241..10623119bb5038a1b171e31b8fd962a87e3670f5 100644
--- a/include/linux/rcuref_long.h
+++ b/include/linux/rcuref_long.h
@@ -85,11 +85,12 @@ __must_check bool rcuref_long_put_slowpath(rcuref_long_t *ref);
 
 /*
  * Internal helper. Do not invoke directly.
+ *
+ * Ideally we'd RCU_LOCKDEP_WARN() here but we can't since this api is
+ * used with SLAB_TYPSAFE_BY_RCU.
  */
 static __always_inline __must_check bool __rcuref_long_put(rcuref_long_t *ref)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() && preemptible(),
-			 "suspicious rcuref_put_rcusafe() usage");
 	/*
 	 * Unconditionally decrease the reference count. The saturation and
 	 * dead zones provide enough tolerance for this.

-- 
2.45.2


