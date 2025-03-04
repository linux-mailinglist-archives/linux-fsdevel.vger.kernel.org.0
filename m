Return-Path: <linux-fsdevel+bounces-43153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F800A4ECEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42826880CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792724C079;
	Tue,  4 Mar 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSPV15fP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB41F4196;
	Tue,  4 Mar 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113323; cv=none; b=aRtKPum0vrMf/AY6IP6VUZJvCuENMmj/bufFpi3oFmW+HWGpS6iLcRShG7X+GicWyifx2anT0IJBP30+vqbOBXH83XEqqdQnTnF9j8WWt4IpVESAy3Cx3ZzzgeoZTkDRFuX8jbN+tHVylDMQeh6D/vOQFZ5hRPw3b0hq3PPyu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113323; c=relaxed/simple;
	bh=Lp4VXQGfoBUso5dKviW7w81LZOeoVklp8AokStkVwcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8DCDM21unXL8EE1P2kKVTQCsVK11xnsJXzAO0p7nrlA2GxztMN3DLgVR6sKZq7TkpLMh8Oe5kY0ELW4mR4Q0RpZ9KR5b0bMgDedeN8WYLPb1xj0tZ1OBsvOTalok9NwQxBy6dzT+Q5aefmkiE2Dm8gFGe8uElD1ZWhPqEny8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSPV15fP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf3cf3d142so533602566b.2;
        Tue, 04 Mar 2025 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113320; x=1741718120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nihpqcFG4iovnE+f5kR4Ra8aRkWB1EWCR4XgUiQDEE=;
        b=WSPV15fP3ILW6MpPP6qQAMqgs1U2MiLSauzucPGxhKO1GTVg+2W4dez5fDc95yhr87
         4qJjUhaIhlXO6nt1qIUoGzRYVUPrlpnMNAvt2wi30xnxmNZv1tjGYZOmgYUEMoudqB/v
         q/B2O0JkE8iJXp6luFMWeVSumlqvgzADdxhnCus+WHIHswPGyeHpeHDLBpSbGuXzMljd
         sGRUfaCguDN8ZxZF39lE49BHU4H/eusM/OfR9qtXpYglZNpPCyAKw4B3Yt+jMepE5Qev
         HzeNFupfwRgzh0h4Gmi0AWatk7E9YCYjfQxVaaMqILCsAyIr9iLxADBbveLMfC3Dy0w4
         b7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113320; x=1741718120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nihpqcFG4iovnE+f5kR4Ra8aRkWB1EWCR4XgUiQDEE=;
        b=bNHKhS+TmeBNh6NcShxJPTQlcahP8chdKk6dBo9Mm42AVcIhuKYmncJQ0KRBOgWC+l
         Kc1r3SmWKwFwWdkmPDC61oZwjcSKOA79nQUuhUr5HL1VwoszyLrEW/hQLfhU6+P5oKwP
         khteChZTp1xRV8/WFnqbrJwYVKFyAbVIyWMKh/W/Y6S6q31yMpV1QMODhGRc19PClD1W
         7KsSayFSF9IHh7jqokd9COf64Knre8Q3LuqSJ6w5TRhotxjupwaV6tdms/lx/ygeGrcD
         +UIqqUaFKrSEPW3IcfYsBup5YhhdKPjPMI9MfD7Ti35yVj2YLhGUtuq3YUybVaTg9vgr
         zW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW73rofBlK7OkuV62pYlSDInU+GU1Thfjc/wQckPI45lMRGhDKj1p9aOORz7gkobCUZlCq3vHW+Eg6khhVv@vger.kernel.org, AJvYcCXN9Z6l/Fzg5UCu7os7JbWZg7gyUHwBlABsL2N+QdTWKxeONHVwITLnF1rJ7VSMW9RJhHu0rkEfFP0Y4yXg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvu0Tuu/brxiZ+Ohxn5PewFVOdgxWF3nyUR11oJO7ANsKdt9b+
	i9sbovyDA+h4yhuTOgnIsLe4fdwFMNI74UruWCRWfrKQ2KDTkkp4
X-Gm-Gg: ASbGnctMwQBhwyJS5DEFi1IG36DoF/lWl/bTRWWCaki0VNwcZSIAqafQ/JdnaDGdASJ
	nI/bp23VTn0P9myp9htjOuFDkdDbyTO7fe6fGxWcfMdxp7hkkAlGJPZpip2Wc1AJZJ+a/jnv3cP
	ODdtCjd94nFmy2sNN91UDmw+LAV6j87aGXUHNxFSAnLycX197S6AzDREBZDt+2SaZuF1+jR4ak0
	3oKwG3rEoGzc3zAUfpJc3xejOoDWPCToC61aT2a796lsswl+OPcZH7j65kZsUW4MxdI3E5x7J0X
	bFPN/5LNFegZlkqmdEwjnwCGqXtwW4ZQn91DU1ykVA+3plQCaQqYhZ8Sjs7O
X-Google-Smtp-Source: AGHT+IF4zRw0FRVDleT8LploK2usAg9P6iuZ1sytq0iXVwxaQIV/p3Ad2n4tPgTFudBQVPF+cEovBA==
X-Received: by 2002:a05:6402:90e:b0:5e0:7510:5787 with SMTP id 4fb4d7f45d1cf-5e59f3f46e7mr171424a12.19.1741113319561;
        Tue, 04 Mar 2025 10:35:19 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb747csm8691328a12.42.2025.03.04.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:35:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/4] file: add fput and file_ref_put routines optimized for use when closing a fd
Date: Tue,  4 Mar 2025 19:35:03 +0100
Message-ID: <20250304183506.498724-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304183506.498724-1-mjguzik@gmail.com>
References: <20250304183506.498724-1-mjguzik@gmail.com>
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
index 5c00dc38558d..4189c682eb06 100644
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
+	if (unlikely(file_ref_put_close(&file->f_ref)))
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


