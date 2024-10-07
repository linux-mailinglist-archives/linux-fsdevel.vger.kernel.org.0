Return-Path: <linux-fsdevel+bounces-31194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC814992F07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6737128249B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0A1D6DBC;
	Mon,  7 Oct 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQoBbQdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AF1D363A
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311079; cv=none; b=X0WYb6G23Z4YYTR39RAvYd3AzIDdihBXm8zNNerCG8ueP2N2iR3ikUsA6kYkcs1A+p2i01m8R4YvkUdr5xkQ5dr0lKLMFMqlqgFXyg9JAqkVl8cWPyxsKVyC0kD44kNXSTh/ucMjUXhb2o5Wgn9dKk8HS47z/MwbelVBvECNmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311079; c=relaxed/simple;
	bh=T8BdlNMwGOH0eH5b3vG8bzxvjfeXxvor6pS00DLD0BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDJsLpsf2VFaGxHs30iYR9AioaGdFV3cpUcTkO83fPf8glB6trty8+XIMzSmDhJr2yRkWfcnqPCAlcZYAXYhncje2Ux5563ZHc3ssG6lIQIqptUpRMkTG8AdaPoE+Z7ytvtAed8MvXcWuyLPtN7ogrzg3lJ9XpUahiykJKYhhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQoBbQdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B7FC4CECC;
	Mon,  7 Oct 2024 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311079;
	bh=T8BdlNMwGOH0eH5b3vG8bzxvjfeXxvor6pS00DLD0BU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UQoBbQdjuOLZVVkaAcV8UYNQYi/LRFRo+ULub+hCQ3vVyJBViHCyOZR27brykaBA9
	 1FoRpBRqcYzOLnsib0UIOj4IfxY1l52LKDeVo+qH19/juRnHjlaJ3X3fKYJGvpC54h
	 8yziSGcjzHde5363Q2++TRZLpEVlbPD16mKESssSLz7YC53YgpGtwnUkyaELTXb9FK
	 wh+0beGsGu3QwXcK91CAciSOlussqSH+WSvMfh+gsYm+Y5tish792TN4EETa85k/bg
	 zi27LEerNI/Jx66dmOVDDbgAdhbE1Qa687G5hBLpI+1pb4ZC9A3IlEAQrQhcE0dDMI
	 8F/BUJb+AZwlg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Oct 2024 16:23:59 +0200
Subject: [PATCH v2 3/3] fs: port files to file_ref
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
In-Reply-To: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6109; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T8BdlNMwGOH0eH5b3vG8bzxvjfeXxvor6pS00DLD0BU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzv1f0MvN/8Mt6ezxvh+r/kJfSp52SV6fs9TCb67aEn
 yPmSKdWRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWP2P4p+j/MpLhksWZ1J8b
 Q6/dkk3dcGFv8ZvwwD23TiifrBe49Z2R4cO7f6EfjhVPW/3j3M+tHWefMngo/cuQ4ym58CQlbrV
 1KQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port files to rely on file_ref reference to improve scaling and gain
overflow protection.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/gpu/drm/i915/gt/shmem_utils.c |  2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c   |  2 +-
 fs/eventpoll.c                        |  2 +-
 fs/file.c                             | 14 +++++++-------
 fs/file_table.c                       |  6 +++---
 include/linux/fs.h                    |  9 +++++----
 6 files changed, 18 insertions(+), 17 deletions(-)

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
index 3353e97687d1d5d0e05bdc8f26ae4b0aae53a997..a17e62867f3b33cd1aafade244d387b43bb66b51 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -471,7 +471,7 @@ void ttm_object_device_release(struct ttm_object_device **p_tdev)
  */
 static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
 {
-	return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
+	return file_ref_get(&dmabuf->file->f_ref);
 }
 
 /**
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd88b07e323d0dd75be6c0fe9fff54f..212383cefe6c9fe13a38061c2c81e5b6ff857925 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1002,7 +1002,7 @@ static struct file *epi_fget(const struct epitem *epi)
 	struct file *file;
 
 	file = epi->ffd.file;
-	if (!atomic_long_inc_not_zero(&file->f_count))
+	if (!file_ref_get(&file->f_ref))
 		file = NULL;
 	return file;
 }
diff --git a/fs/file.c b/fs/file.c
index 1b5fc867d8ddff856501ba49d8c751f888810330..f4df09e92b6158ee40a794a4e0462f57acf595cf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -972,7 +972,7 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	if (!file)
 		return NULL;
 
-	if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
+	if (unlikely(!file_ref_get(&file->f_ref)))
 		return ERR_PTR(-EAGAIN);
 
 	file_reloaded = rcu_dereference_raw(*f);
@@ -986,8 +986,8 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
 
 	/*
-	 * atomic_long_inc_not_zero() above provided a full memory
-	 * barrier when we acquired a reference.
+	 * file_ref_get() above provided a full memory barrier when we
+	 * acquired a reference.
 	 *
 	 * This is paired with the write barrier from assigning to the
 	 * __rcu protected file pointer so that if that pointer still
@@ -1085,11 +1085,11 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 * We need to confirm it by incrementing the refcount
 		 * and then check the lookup again.
 		 *
-		 * atomic_long_inc_not_zero() gives us a full memory
-		 * barrier. We only really need an 'acquire' one to
-		 * protect the loads below, but we don't have that.
+		 * file_ref_get() gives us a full memory barrier. We
+		 * only really need an 'acquire' one to protect the
+		 * loads below, but we don't have that.
 		 */
-		if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
+		if (unlikely(!file_ref_get(&file->f_ref)))
 			continue;
 
 		/*
diff --git a/fs/file_table.c b/fs/file_table.c
index 4b23eb7b79dd9d4ec779f4c01ba2e902988895dc..3f5dc4176b21ff82cc9440ed92a0ad962fdb2046 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -178,7 +178,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * fget-rcu pattern users need to be able to handle spurious
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
-	atomic_long_set(&f->f_count, 1);
+	file_ref_init(&f->f_ref, 1);
 	return 0;
 }
 
@@ -483,7 +483,7 @@ static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
 void fput(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
+	if (file_ref_put(&file->f_ref)) {
 		struct task_struct *task = current;
 
 		if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
@@ -516,7 +516,7 @@ void fput(struct file *file)
  */
 void __fput_sync(struct file *file)
 {
-	if (atomic_long_dec_and_test(&file->f_count))
+	if (file_ref_put(&file->f_ref))
 		__fput(file);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337650d562405500013f5c4cfed8eb6..fece097d41a8fb47a1483e5418f1e7319405bba2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/maple_tree.h>
 #include <linux/rw_hint.h>
+#include <linux/file_ref.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1030,7 +1031,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_freeptr: Pointer used by SLAB_TYPESAFE_BY_RCU file cache (don't touch.)
  */
 struct file {
-	atomic_long_t			f_count;
+	file_ref_t			f_ref;
 	spinlock_t			f_lock;
 	fmode_t				f_mode;
 	const struct file_operations	*f_op;
@@ -1078,15 +1079,15 @@ struct file_handle {
 
 static inline struct file *get_file(struct file *f)
 {
-	long prior = atomic_long_fetch_inc_relaxed(&f->f_count);
-	WARN_ONCE(!prior, "struct file::f_count incremented from zero; use-after-free condition present!\n");
+	WARN_ONCE(!file_ref_get(&f->f_ref),
+		  "struct file::f_ref incremented from zero; use-after-free condition present!\n");
 	return f;
 }
 
 struct file *get_file_rcu(struct file __rcu **f);
 struct file *get_file_active(struct file **f);
 
-#define file_count(x)	atomic_long_read(&(x)->f_count)
+#define file_count(f)	file_ref_read(&(f)->f_ref)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 

-- 
2.45.2


