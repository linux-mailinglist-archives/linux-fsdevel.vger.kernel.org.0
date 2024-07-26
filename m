Return-Path: <linux-fsdevel+bounces-24302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31793CFFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E63283D66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6E178364;
	Fri, 26 Jul 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gt+XWdrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BD176FA7
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984174; cv=none; b=RdPlFq1BQUm0rjGAPDlBThw0sBfXuC1Ao39poNBJ68rtEHN8v75W3oPsEI34J6F24olH5AqmIkTZHybHkG+bdZp0Babj1o7nIg0dFj2eyxpP1SeXtVx/9xIZt+K3/rD4Zq1GY3vjU5nBp83d0y3daTdQy74EW4GqLe0zSxioNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984174; c=relaxed/simple;
	bh=SYeM9jCzVVTE5g2DV4B2udUtCEGGnEOgB8F5kKycibA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJzY+b4R8wphJbh478+kOd5pgUkHFj8ILlYgTv7FUzRuILrVJv7poriMtJWlPG4Jwqcqn17Tf0QAHNsyZKsZRSdbfwYFkR5QyDUXrB4YTFmcd5N+ajLqD7WYXbJi2J578O6mmY3rjdA0BUFKQ7dssg9UVTqHuEn4v6yKM6Kpk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gt+XWdrr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66af35f84a3so51984587b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721984172; x=1722588972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DY88XCeUY3/6r+6OUV4QM/dNqQSBTZ9XU/Qu6D0C8Ys=;
        b=Gt+XWdrr56MZcMiq6hJbOOWd9efpTKmUZQbZVvEYLQEeT/D8Qy9TkKl0yZNZ7rViv+
         nFsgLBh5FOmjZLdIyRSrKmTCL7TS9cm18Cbcm0tKBhhaDgQ2u0GOpLMDoJDIUgD3GZ+a
         iLlwGcIotwwHysL9Uyx5a6xEhGlcn9VwlsBLW8sh0xbGKwyujMbOXslY8O98j/zZOlJi
         YFO1vRNJkeH7pWlA6ym5c9O4Xba6XiYGxn6HOa5vbpHFos+9psWjPjMqFl6wifXaMLCW
         GcMoKTFBRh+ZAa/EGAMlrzNIAPZ14xW/Y0Z1WjlWhYXk5Zyst7TzC3ufdJT0cety9xqi
         Sj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984172; x=1722588972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY88XCeUY3/6r+6OUV4QM/dNqQSBTZ9XU/Qu6D0C8Ys=;
        b=b3+Co/TcOHcUVt+9PIaztkYp6wFIjHuMOYW2FLHHgxjRNwjdrfvy21wt1K3lPG+LVd
         6fzhoF5kUbqoYWU8i3aY3++lLuwVJGAf+osyhqdVZoV1E3AmKKSu2t3KO0YPCDhdskmr
         Y/WHP4fO+9IkA/U3nw+75tXuqvT4IHlxrnjXz7K8C1RUbiyIcf4hQ6EhCHm1kIY+AGrl
         csR5dJ86IsDU5VCg+I2JjI0sSkPG5S1sd1ojJ5hwkWf+++08g0nmQnB34nLuJWmGVTK2
         2M9fMxvk+XZK79hmUgm0zBIHYK75R7Ek1LwuT4L2GXzT1LvnXY/RfWCqlbQJMDc6LOi2
         zbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3SqEojUegR56HdaAeGaAs7A5gMPpaYblyc7M85Ln5M9de0Orm7B1NDKqxG+HvISIbX4b6OapKyZI92eYSx+RaIEKRO3UImKorEfPOA==
X-Gm-Message-State: AOJu0YySwwDTYGoigzGcLYSnJ5wLnGqvPSMdBFs14WbmLbpk44h0/JpD
	Cg/uI4Rv/TBdxsGbxy2AQbize+ZSC9ARuGxRIbe39z28gpm7iJaK7krZoNP2Xl8PlAMFTotLPI1
	mT+O22cHclrhAba3aIe8snuIQusYpuA==
X-Google-Smtp-Source: AGHT+IGPCQfz5GgesjOv02pQevyMK1biadk5YbpA88Jjx/jL8lt/jfRwOt3uI+52VN+2UJhYlL0D5yWOf8MUn9AVjwbV
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a05:690c:660f:b0:66b:fb2f:1b7 with
 SMTP id 00721157ae682-675b8ce267fmr1406287b3.6.1721984172031; Fri, 26 Jul
 2024 01:56:12 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:56:02 +0000
In-Reply-To: <20240726085604.2369469-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726085604.2369469-2-mattbobrowski@google.com>
Subject: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new variant of bpf_d_path() named bpf_path_d_path() which takes
the form of a BPF kfunc and enforces KF_TRUSTED_ARGS semantics onto
its arguments.

This new d_path() based BPF kfunc variant is intended to address the
legacy bpf_d_path() BPF helper's susceptibility to memory corruption
issues [0, 1, 2] by ensuring to only operate on supplied arguments
which are deemed trusted by the BPF verifier. Typically, this means
that only pointers to a struct path which have been referenced counted
may be supplied.

In addition to the new bpf_path_d_path() BPF kfunc, we also add a
KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
counterpart BPF kfunc bpf_put_file(). This is so that the new
bpf_path_d_path() BPF kfunc can be used more flexibility from within
the context of a BPF LSM program. It's rather common to ascertain the
backing executable file for the calling process by performing the
following walk current->mm->exe_file while instrumenting a given
operation from the context of the BPF LSM program. However, walking
current->mm->exe_file directly is never deemed to be OK, and doing so
from both inside and outside of BPF LSM program context should be
considered as a bug. Using bpf_get_task_exe_file() and in turn
bpf_put_file() will allow BPF LSM programs to reliably get and put
references to current->mm->exe_file.

As of now, all the newly introduced BPF kfuncs within this patch are
limited to sleepable BPF LSM program types. Therefore, they may only
be called when a BPF LSM program is attached to one of the listed
attachment points defined within the sleepable_lsm_hooks BTF ID set.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/Makefile        |   1 +
 fs/bpf_fs_kfuncs.c | 133 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 fs/bpf_fs_kfuncs.c

diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..61679fd587b7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
new file mode 100644
index 000000000000..3813e2a83313
--- /dev/null
+++ b/fs/bpf_fs_kfuncs.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/sched.h>
+
+__bpf_kfunc_start_defs();
+/**
+ * bpf_get_task_exe_file - get a reference on the exe_file struct file member of
+ *                         the mm_struct that is nested within the supplied
+ *                         task_struct
+ * @task: task_struct of which the nested mm_struct exe_file member to get a
+ * reference on
+ *
+ * Get a reference on the exe_file struct file member field of the mm_struct
+ * nested within the supplied *task*. The referenced file pointer acquired by
+ * this BPF kfunc must be released using bpf_put_file(). Failing to call
+ * bpf_put_file() on the returned referenced struct file pointer that has been
+ * acquired by this BPF kfunc will result in the BPF program being rejected by
+ * the BPF verifier.
+ *
+ * This BPF kfunc may only be called from sleepable BPF LSM programs.
+ *
+ * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
+ * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
+ * directly in kernel context.
+ *
+ * Return: A referenced struct file pointer to the exe_file member of the
+ * mm_struct that is nested within the supplied *task*. On error, NULL is
+ * returned.
+ */
+__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
+{
+	return get_task_exe_file(task);
+}
+
+/**
+ * bpf_put_file - put a reference on the supplied file
+ * @file: file to put a reference on
+ *
+ * Put a reference on the supplied *file*. Only referenced file pointers may be
+ * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
+ * any other arbitrary pointer for that matter, will result in the BPF program
+ * being rejected by the BPF verifier.
+ *
+ * This BPF kfunc may only be called from sleepable BPF LSM programs. Though
+ * fput() can be called from IRQ context, we're enforcing sleepability here.
+ */
+__bpf_kfunc void bpf_put_file(struct file *file)
+{
+	fput(file);
+}
+
+/**
+ * bpf_path_d_path - resolve the pathname for the supplied path
+ * @path: path to resolve the pathname for
+ * @buf: buffer to return the resolved pathname in
+ * @buf__sz: length of the supplied buffer
+ *
+ * Resolve the pathname for the supplied *path* and store it in *buf*. This BPF
+ * kfunc is the safer variant of the legacy bpf_d_path() helper and should be
+ * used in place of bpf_d_path() whenever possible. It enforces KF_TRUSTED_ARGS
+ * semantics, meaning that the supplied *path* must itself hold a valid
+ * reference, or else the BPF program will be outright rejected by the BPF
+ * verifier.
+ *
+ * This BPF kfunc may only be called from sleepable BPF LSM programs.
+ *
+ * Return: A positive integer corresponding to the length of the resolved
+ * pathname in *buf*, including the NUL termination character. On error, a
+ * negative integer is returned.
+ */
+__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
+{
+	int len;
+	char *ret;
+
+	if (buf__sz <= 0)
+		return -EINVAL;
+
+	/* Usually, d_path() will never involuntarily put the calling thread to
+        * sleep. However, there could be exceptions to this as d_op->d_dname()
+        * has free rein over what it wants to do. Additionally, given that this
+        * new d_path() based BPF kfunc enforces KF_TRUSTED_ARGS, it'll likely
+        * only ever be called alongside or in similar contexts, to other
+        * supporting BPF kfuncs that may end up being put to sleep.
+        */
+	ret = d_path(path, buf, buf__sz);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	len = buf + buf__sz - ret;
+	memmove(buf, ret, len);
+	return len;
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_task_exe_file,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
+
+static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
+	    prog->type == BPF_PROG_TYPE_LSM)
+		return 0;
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_fs_kfunc_set_ids,
+	.filter = bpf_fs_kfuncs_filter,
+};
+
+static int __init bpf_fs_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+}
+
+late_initcall(bpf_fs_kfuncs_init);
-- 
2.46.0.rc1.232.g9752f9e123-goog


