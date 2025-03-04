Return-Path: <linux-fsdevel+bounces-43131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC385A4E79D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4032D17DFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852A2C2CB4;
	Tue,  4 Mar 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEs+yn1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A2284B22;
	Tue,  4 Mar 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106211; cv=none; b=IukDLMxOr+AughMmNTXB49MgVX27ssQKkfs7MZcSRDEysfpBtHhUhZqe1rWN4KVpxaARrcktGlJZC3NGerHJjkVbVLnIa1C3FffIO+m8RRxgL6dUU3YXJ2LKyOaeU6tg3/KH1aWkBfSaS7CzWXkioqerOoPkCIxDJnhaF1c24TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106211; c=relaxed/simple;
	bh=SbQI9pTMf3lPQqupzGsHRb1g5450ijhBzSpJxvCgNns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyS3fKQtM3KZ274ZofTE8Gp9GdVdYsslEdmju+SgDxxfnhFt6T0M3AOPUZRtOKS6we27YYFiY6tCea3aifteAIBrALnAKPO0yIyd3WeWymxmNVAGbG3bbK7b3T/5AgSW3pzSXk6Dqq2CsBRFSeKcjkQwjRqpcifDR6TLI9dIRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEs+yn1K; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6804823a12.3;
        Tue, 04 Mar 2025 08:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106208; x=1741711008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIPb+e/x+8sDHS2bhbWUC7800IWMYNtI+fV8xWCTFZI=;
        b=QEs+yn1KIai0+hV7jvlsIkkKkVeL70g5wIfgViKZGg1mvtDuH8ZIPY5QkCcjPc0fNA
         H4cfVzehJmn1CPe1EupOIVsTtK/mqXxfA3VvCNpU76PdMt0wYdAGqbKHkYI/Ngd/xksy
         NdwBYZiEaVeolH2by8Aoq9r6qg6O6PxNpcyCS/mmZKrSSvwlAALXoXIroRhiTtDUcRGc
         /EKU1bVN/a+sjsCF+ifP523ah2K/1bqCTWRnPQnomZXYbyv+Pb3wb5tf/4HJk3LNXDZ1
         lDJTkNd/zfgGVVrlcTGafL1NeqzmYECVs9oyr7ubbY/nu7wlWavVPDDY+hhy/UKHPVkK
         5/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106208; x=1741711008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIPb+e/x+8sDHS2bhbWUC7800IWMYNtI+fV8xWCTFZI=;
        b=JEj8wfn7jPqf7fjRJ+Oqlfdpm4CKJ9UEW6lyWQhzzW5AF69SeeY8bFnUK84B3fh2bS
         m/p5+LvRPI9n5lyIZoPYlh6V0tjHDCj7vLeojyybsJqwv486bdTNdnrU2Lm5lZYVBmIk
         nhoFvm0Ipb7JsJZ98cAfvbQv3zpxede8r1DmyNKN6ugTqSuKO1VzVbYwug43Nchjgs9k
         bl38mwPZo7mgaDInyltqJuKDuwxXIpZJysbPXOhvdb+TFLfHKgh63aGp3t4IukA+bt1j
         tAulG8hxW1GFWhHA37dQ20Bs343SSa+d/+4hwL/3Ee9L+zzYzHcbok63U8ruWIbvhhZQ
         9h7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSyZjfc9Uv63qs8CQzvYHyYQOIrmqQ2seaUIGpP4rYrbve2IZzIGgWUeD/1rxcAuQ3O6I4VPV7lqABsAVs@vger.kernel.org, AJvYcCXZqfConFdafFmeTT/GUbuiwG0srg2GH6BNU/HVTw5u3f6QYkL5cohDVeIkpPGhW4gwqShQNPpQ3Pe3/d/c@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqFZ5HAai4K3lT5Oi0SnkRtFnjI4OgKD319/AmbYRe6ZvhFrT
	+sq7d3+3119PEzfp5Wg8qF+0Q4dQ7gbU72pwSDEQDoSla4oeJYTN
X-Gm-Gg: ASbGncvsIekVCvpz6XX05DjS1skehLNWCjp7owL/ezklBD7Ro5iNrxZyIuUCeCkB/WI
	hDlBKfpe1SXYJt0W5HaY362Azcktb973DrTwW1P2vZ0cqCtfcrjDlFgjjVznYK0epBliQ4Ate47
	4RG5ResPlXzEtr0+QeQsQVWiklbq3oF/BSRRm7PnEw7B+IK2JwIk1B08jQW9KoxeIUoPqXTQ8NR
	ib5oKDPRuqSHbzo6V7a3MGkNYCqlM8e8WE0pv+upRn2826ALYA9uaw7zlRjyPFkBKrb7ZhVFzkJ
	U7ywbXWoJ4HwUnY/LZP9+V+Lo2J/a3YtmZajdtFaSvndJkOtwVcGoF6BKDvO
X-Google-Smtp-Source: AGHT+IFL7DuKXrBb+vnVzvrZkZQWGjgPs6e+zFQbuMejQ/IF2K8aKfxGJ3l55SHVGiq+dhGDI7o0aw==
X-Received: by 2002:a05:6402:42c8:b0:5df:25e8:26d2 with SMTP id 4fb4d7f45d1cf-5e4d6ac58fdmr43293150a12.5.1741106204904;
        Tue, 04 Mar 2025 08:36:44 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm8246202a12.68.2025.03.04.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:36:44 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] file: add fput and file_ref_put routines optimized for use when closing a fd
Date: Tue,  4 Mar 2025 17:36:30 +0100
Message-ID: <20250304163631.490769-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304163631.490769-1-mjguzik@gmail.com>
References: <20250304163631.490769-1-mjguzik@gmail.com>
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
 fs/file.c                | 75 ++++++++++++++++++++++++++++++----------
 fs/file_table.c          | 72 +++++++++++++++++++++++++++-----------
 include/linux/file.h     |  2 ++
 include/linux/file_ref.h |  1 +
 4 files changed, 111 insertions(+), 39 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 44efdc8c1e27..ea753f9c8e08 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -26,6 +26,28 @@
 
 #include "internal.h"
 
+static bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
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
@@ -67,27 +89,44 @@ bool __file_ref_put(file_ref_t *ref, unsigned long cnt)
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
+bool file_ref_put_close(file_ref_t *ref)
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
+EXPORT_SYMBOL_GPL(file_ref_put_close);
+
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
 /* our min() is unusable in constant expressions ;-/ */
diff --git a/fs/file_table.c b/fs/file_table.c
index 5c00dc38558d..82d96ad141e2 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -511,31 +511,37 @@ void flush_delayed_fput(void)
 }
 EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
-void fput(struct file *file)
+static void __fput_defer_free(struct file *file)
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
+		__fput_defer_free(file);
+	}
+}
+EXPORT_SYMBOL(fput);
+
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
@@ -549,10 +555,34 @@ void __fput_sync(struct file *file)
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
+	if (file_ref_put_close(&file->f_ref))
+		__fput(file);
+}
+EXPORT_SYMBOL(fput_close_sync);
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
+		__fput_defer_free(file);
+}
+EXPORT_SYMBOL(fput_close);
+
 void __init files_init(void)
 {
 	struct kmem_cache_args args = {
diff --git a/include/linux/file.h b/include/linux/file.h
index 302f11355b10..7b04e87cbde6 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -124,6 +124,8 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
+void fput_close_sync(struct file *);
+void fput_close(struct file *);
 
 extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 9b3a8d9b17ab..f269299941aa 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -62,6 +62,7 @@ static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
 }
 
 bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
+bool file_ref_put_close(file_ref_t *ref);
 
 /**
  * file_ref_get - Acquire one reference on a file
-- 
2.43.0


