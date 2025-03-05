Return-Path: <linux-fsdevel+bounces-43253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12191A4FEBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850CF7A6059
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65DB2459FC;
	Wed,  5 Mar 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KETT/Vsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5B24502C;
	Wed,  5 Mar 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178217; cv=none; b=J4VeZ6cGyze/DrO+JQeSLVtlL63mMA/wsUKtQBxxAQR6StM5vcdeDFYsVX5YDM+AWcHrMkwq6WBeJFnSdBaFBVm58Px9eIm6ugS+q1sPFFFnFGgWsndRNyZ9qsT6tGPy0h1YntLaPgaj7LAPz3S7ku6rIJw2vlvFHnwkkPXb7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178217; c=relaxed/simple;
	bh=xEVDPl2kN377zrXJhWPCpz+2x0VgvInSaATuymWLGDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxRQT5eD2Y2f6qf5cwHQh74p5w/q+mvX0qjX6dGD9aaSRrFc/6mTrqKReXbcNc0cu4zBLAtU62JLaYNrzAcbo1qZ6F9B/W0Jn4YEWDGp0IbCUykVHxpz5IKnQ8Q/t1Eb3uJYJVu2d/s9PhMYN8tch3M6hkPcel1bVOmqRAna9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KETT/Vsb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so7892829a12.3;
        Wed, 05 Mar 2025 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178213; x=1741783013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anP8qXS9SQZse5TfMTpPl4lEfNtcPXm3bkmpJGZKrtM=;
        b=KETT/VsbLgQ0Kx/KAhdE0sldW6a7Vp4oqAWvFh23OQ4UHE6XYBGy7TIK23ElgR13w9
         VSIvU3gkMZrvuBSO3IDOLB1TJwoKwD2mI9cj+Qijydn0ueEbWtAczYeGu+N1B5pMnGIH
         u8Y9T0BQqRPbNDxFqhLMFr/T0A8XLlGi0YKSSypS77QQoM/WbFMa0+TDLKKplCT4fLBJ
         8sasHgqN2gjVX7CNzMPBnhlOdkMft7rJnVc4SevD7+BVRs0yaX4OKyp6vb5/2izsIQNr
         5VRx1EDAg+JiHUAgu+8mj21EwqhcqEbgCEvTny8d5YRWfps2ggTq0j2KevtR62phdU08
         9dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178213; x=1741783013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anP8qXS9SQZse5TfMTpPl4lEfNtcPXm3bkmpJGZKrtM=;
        b=eU3CGsW4ODSqLLLRql/V0q+jWU0DBKnzIZSTdPxXewlWiC+0MoweRYulLZ9LMMyrly
         H97ZBCGF6eQrQ0M4704SCYyD3W+kU4Az/+J/vUqrWLhUS/zWdhjD32Rbw8eZu2nYohJ4
         qKy7SwBKch2sn/xi5aO0ShwApR3imPPe0e2OHxVlKM5Bb68OzpIyuUWndtuPg64IMlSc
         xDa+VPXjCm26MzDQLaRlmzqVRXhya8GeX6AmLDCclfvmv4U2dnCtI+ysxBXTjvOVhUe1
         sLfhhJEh0NRTK4SUwp0jOKxtdQ61VKvBQFx/NlUzjTvdJME1kAK4inOLPypJENYYwREQ
         sc4A==
X-Forwarded-Encrypted: i=1; AJvYcCXL1KtQgHRNHdVvbce/bkVnvq4MMfVXYYpTGT6g45WcSArmXbOgj6FlJMkdZwYkSVtoysNOok4GQOZuC/FI@vger.kernel.org, AJvYcCXmZJL324MxdROVmCh0pUcCcc0OcXnjDaC5VBmof20CkrkJTr4C3eGsDQPzHS95K/8vVbosqd78Y1Eet/32@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63kSNqw7jJLJgws0QpLGUUNBkU+SvFojl8w+47nfWAKEm5WoA
	k2p6FxJYUkE4+XcSLeqhlHSU8S6bFqzmJN4qHz/ReLV2VrAp90GV
X-Gm-Gg: ASbGncur2Wf8y2snHzEElh4C/8zlqDTKsJj7qPz/+OwSnxSgHMhrnkidtpyGDfssGom
	iH+kAs8Eq8g97KVjZz3rwGPgYU+nzWJeNv8QdJiit+a0JMfUTyjkiLqAKbqZzV2T/9115T7Go9D
	TO0DkT2wFujwJbLR+sY2X2asBe6vhr+EDs3+CTRGNsvdX7Y1hK448BIQ/mnqemBzfqgdorAOn3H
	mECe6crgQrD8QcexULd1PQKqOiF3HuD2QMl99AkxXoVtbuGdu/9uWi65Eh/57kL9rQ0KugRDmmZ
	5igv7PvrhG2d1E1enD0IvSzwUpPAB0brkt4QXNiKVvrDRnjME+AwCL+2w5pR
X-Google-Smtp-Source: AGHT+IEGirpBQDNJgftKFXJOzOjnh5H2UdYautPHPUmHvM339MGGjNyo5C2DAG9e+hg/ATcvESX55w==
X-Received: by 2002:a05:6402:5214:b0:5dc:5ada:e0c7 with SMTP id 4fb4d7f45d1cf-5e59f47cdd0mr7071820a12.26.1741178213240;
        Wed, 05 Mar 2025 04:36:53 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm9632068a12.18.2025.03.05.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:36:52 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/4] file: add fput and file_ref_put routines optimized for use when closing a fd
Date: Wed,  5 Mar 2025 13:36:41 +0100
Message-ID: <20250305123644.554845-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305123644.554845-1-mjguzik@gmail.com>
References: <20250305123644.554845-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vast majority of the time closing a file descriptor also operates on the
last reference, where a regular fput usage will result in 2 atomics.
This can be changed to only suffer 1.

See commentary above file_ref_put_close() for more information.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file.c                | 41 ++++++++++++-----------
 fs/file_table.c          | 70 ++++++++++++++++++++++++++++------------
 fs/internal.h            |  3 ++
 include/linux/file_ref.h | 34 +++++++++++++++++++
 4 files changed, 109 insertions(+), 39 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 44efdc8c1e27..6c159ede55f1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -26,6 +26,28 @@
 
 #include "internal.h"
 
+bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
+{
+	/*
+	 * If the reference count was already in the dead zone, then this
+	 * put() operation is imbalanced. Warn, put the reference count back to
+	 * DEAD and tell the caller to not deconstruct the object.
+	 */
+	if (WARN_ONCE(cnt >= FILE_REF_RELEASED, "imbalanced put on file reference count")) {
+		atomic_long_set(&ref->refcnt, FILE_REF_DEAD);
+		return false;
+	}
+
+	/*
+	 * This is a put() operation on a saturated refcount. Restore the
+	 * mean saturation value and tell the caller to not deconstruct the
+	 * object.
+	 */
+	if (cnt > FILE_REF_MAXREF)
+		atomic_long_set(&ref->refcnt, FILE_REF_SATURATED);
+	return false;
+}
+
 /**
  * __file_ref_put - Slowpath of file_ref_put()
  * @ref:	Pointer to the reference count
@@ -67,24 +89,7 @@ bool __file_ref_put(file_ref_t *ref, unsigned long cnt)
 		return true;
 	}
 
-	/*
-	 * If the reference count was already in the dead zone, then this
-	 * put() operation is imbalanced. Warn, put the reference count back to
-	 * DEAD and tell the caller to not deconstruct the object.
-	 */
-	if (WARN_ONCE(cnt >= FILE_REF_RELEASED, "imbalanced put on file reference count")) {
-		atomic_long_set(&ref->refcnt, FILE_REF_DEAD);
-		return false;
-	}
-
-	/*
-	 * This is a put() operation on a saturated refcount. Restore the
-	 * mean saturation value and tell the caller to not deconstruct the
-	 * object.
-	 */
-	if (cnt > FILE_REF_MAXREF)
-		atomic_long_set(&ref->refcnt, FILE_REF_SATURATED);
-	return false;
+	return __file_ref_put_badval(ref, cnt);
 }
 EXPORT_SYMBOL_GPL(__file_ref_put);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 5c00dc38558d..5884cc659ea4 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -511,31 +511,37 @@ void flush_delayed_fput(void)
 }
 EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
-void fput(struct file *file)
+static void __fput_deferred(struct file *file)
 {
-	if (file_ref_put(&file->f_ref)) {
-		struct task_struct *task = current;
+	struct task_struct *task = current;
 
-		if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
-			file_free(file);
+	if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
+		file_free(file);
+		return;
+	}
+	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+		init_task_work(&file->f_task_work, ____fput);
+		if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
 			return;
-		}
-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
-			init_task_work(&file->f_task_work, ____fput);
-			if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
-				return;
-			/*
-			 * After this task has run exit_task_work(),
-			 * task_work_add() will fail.  Fall through to delayed
-			 * fput to avoid leaking *file.
-			 */
-		}
-
-		if (llist_add(&file->f_llist, &delayed_fput_list))
-			schedule_delayed_work(&delayed_fput_work, 1);
+		/*
+		 * After this task has run exit_task_work(),
+		 * task_work_add() will fail.  Fall through to delayed
+		 * fput to avoid leaking *file.
+		 */
 	}
+
+	if (llist_add(&file->f_llist, &delayed_fput_list))
+		schedule_delayed_work(&delayed_fput_work, 1);
 }
 
+void fput(struct file *file)
+{
+	if (unlikely(file_ref_put(&file->f_ref))) {
+		__fput_deferred(file);
+	}
+}
+EXPORT_SYMBOL(fput);
+
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
@@ -549,10 +555,32 @@ void __fput_sync(struct file *file)
 	if (file_ref_put(&file->f_ref))
 		__fput(file);
 }
-
-EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(__fput_sync);
 
+/*
+ * Equivalent to __fput_sync(), but optimized for being called with the last
+ * reference.
+ *
+ * See file_ref_put_close() for details.
+ */
+void fput_close_sync(struct file *file)
+{
+	if (likely(file_ref_put_close(&file->f_ref)))
+		__fput(file);
+}
+
+/*
+ * Equivalent to fput(), but optimized for being called with the last
+ * reference.
+ *
+ * See file_ref_put_close() for details.
+ */
+void fput_close(struct file *file)
+{
+	if (file_ref_put_close(&file->f_ref))
+		__fput_deferred(file);
+}
+
 void __init files_init(void)
 {
 	struct kmem_cache_args args = {
diff --git a/fs/internal.h b/fs/internal.h
index 3d05a989e4fa..3b3f315394ba 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -118,6 +118,9 @@ static inline void put_file_access(struct file *file)
 	}
 }
 
+void fput_close_sync(struct file *);
+void fput_close(struct file *);
+
 /*
  * super.c
  */
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 9b3a8d9b17ab..6ef92d765a66 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -61,6 +61,7 @@ static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
 	atomic_long_set(&ref->refcnt, cnt - 1);
 }
 
+bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt);
 bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
 
 /**
@@ -160,6 +161,39 @@ static __always_inline __must_check bool file_ref_put(file_ref_t *ref)
 	return __file_ref_put(ref, cnt);
 }
 
+/**
+ * file_ref_put_close - drop a reference expecting it would transition to FILE_REF_NOREF
+ * @ref:	Pointer to the reference count
+ *
+ * Semantically it is equivalent to calling file_ref_put(), but it trades lower
+ * performance in face of other CPUs also modifying the refcount for higher
+ * performance when this happens to be the last reference.
+ *
+ * For the last reference file_ref_put() issues 2 atomics. One to drop the
+ * reference and another to transition it to FILE_REF_DEAD. This routine does
+ * the work in one step, but in order to do it has to pre-read the variable which
+ * decreases scalability.
+ *
+ * Use with close() et al, stick to file_ref_put() by default.
+ */
+static __always_inline __must_check bool file_ref_put_close(file_ref_t *ref)
+{
+	long old, new;
+
+	old = atomic_long_read(&ref->refcnt);
+	do {
+		if (unlikely(old < 0))
+			return __file_ref_put_badval(ref, old);
+
+		if (old == FILE_REF_ONEREF)
+			new = FILE_REF_DEAD;
+		else
+			new = old - 1;
+	} while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
+
+	return new == FILE_REF_DEAD;
+}
+
 /**
  * file_ref_read - Read the number of file references
  * @ref: Pointer to the reference count
-- 
2.43.0


