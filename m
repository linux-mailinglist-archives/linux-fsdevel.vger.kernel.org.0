Return-Path: <linux-fsdevel+bounces-24676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAEF942CF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BEE28B557
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F64B1B012A;
	Wed, 31 Jul 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUX7HTcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FF1B011C
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424125; cv=none; b=X8NX2ELBpcbNiNXYGdrC9Gyz7OgGxuIOmYM6qB1M/nIioffKEQJvrSGXDjrb+h+6Io/hvOpI94ItqIDAwQ/hyrKU3qpfQcp5+v8NJfsRk16H+Lcq5oeFF1G2lRIRBf50uxvysxErzpq/JzBoZHJqTdE770t4QJpK1wqL/F4bRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424125; c=relaxed/simple;
	bh=KRh9FK3wi8H0l6x+G/Rtg0vuIc52ntkBob7tpdUmLHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9NqZzzcOWzENOe4UTT73Ck5XczbCH0o/kQ4UPyvt5dPJEFc4ZFtIGryaiq67NV9/bHUr6GKQJG/nqCsvoL/Of0ENqbHtQs0nafUICmJwdDtPVBRn3C8dv+Hf4lVd1L3SsJU6BqLEpL/Rr7llytenNUvq6tDyOFdd5JZROlKo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUX7HTcD; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5a37b858388so5770327a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722424122; x=1723028922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrgHW/5cESuP+kjWNXTSTboxQ+urhfmcmyZf/F9Cpak=;
        b=DUX7HTcDzVZm9FN0pXCEp5YKYyZfPE022375+dKNfZEfDf1vxUGqBzHvq4O3S/dAbV
         jMjq5TyJEya1dy0yrSyCUzI5N3qbcKkaWXiXUJG2Kuy4jaY0H4WWCxiboM2bNUX6+0y2
         PC7ifshqMkePtz/GwazSXVklyqAmvgMO+1/Lvv9/254fVbPjJ7O+gN/6FsWWTubH91DZ
         BfzkhXmMELGW0ggHcF5fhq6TJNuaBboLBdnazMiAT4Gq8MoV5vusIS92XZpGr2K1DTe7
         faqY+KVgaOHM/RURPCkrB2Xn4um0dWdgc8yx46qJNamQ+/lq0O9awI6rio0Z/F1zwu3P
         jotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424122; x=1723028922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrgHW/5cESuP+kjWNXTSTboxQ+urhfmcmyZf/F9Cpak=;
        b=XbzLJb1UeDtgtD7BPRBVwINDbpF7Rkgh2SDSDrLy5HeNHEGcPe+c9ijyHCjryQbv9m
         ujn95a5ZOHpGHVSO4qdpMbT7eG7DulDIu/aDTmcZtzcdX3ASW5DEFp/A8mAHO37zwJ/m
         MaQ4cFV7xK+AvkXyPIIGt14iYRVxDnIjYlJC/Bs3+W5jYmY0BP1uUJONxzptZ3ROVijT
         He1rNhEcxE2fBNhjLa69xSk/exqXccSCHHaYZ0noFlgnbmIWMbpCxz31GIFtp239r/h9
         0jNbViv1N2Mmi8U/9wFa9YeyrqajeNBfT53eksSFmTbekzMuTdiEehomP63o3AHtGl2Z
         N2bg==
X-Forwarded-Encrypted: i=1; AJvYcCWSQ8gk5xea3zuM97lcfz62l1mxbjR9UBI7hAuHYf4vbtwYfeVIb6Ja+PRbjsCwsLraDhdegNUgM7NAxS+eJZydQOqZ4X9nE8PCycgwZQ==
X-Gm-Message-State: AOJu0YzcPVbhoTxUIVWw1uoBpcPcPbLei9WVkofehzng4nNKPlgjmIVQ
	AB6+PkRn3lk+1eESeNVBjs1l6ATuhEafn+810y4PSYJCARBKQiQ9off3SQo0puH3R/aLTXVp7yB
	cF0rJhYV0/mjYcMToraxp/J0I5Kk2SQ==
X-Google-Smtp-Source: AGHT+IFJBKL8n7wZ0lCx1sMrin4NqrPjTzHi5ybm344X7Xql1of7QH9vE4u5ZDAKPIGQ7GGt/CweyxF9OHYlwjB0w6lz
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a05:6402:b7a:b0:58e:4bfc:70da with
 SMTP id 4fb4d7f45d1cf-5b0227af84bmr11731a12.8.1722424121761; Wed, 31 Jul 2024
 04:08:41 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:08:31 +0000
In-Reply-To: <20240731110833.1834742-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731110833.1834742-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240731110833.1834742-2-mattbobrowski@google.com>
Subject: [PATCH v4 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
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
legacy bpf_d_path() BPF helper's susceptability to memory corruption
issues [0, 1, 2] by ensuring to only operate on supplied arguments
which are deemed trusted by the BPF verifier. Typically, this means
that only pointers to a struct path which have been referenced counted
may be supplied.

In addition to the new bpf_path_d_path() BPF kfunc, we also add a
KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
counterpart BPF kfunc bpf_put_file(). This is so that the new
bpf_path_d_path() BPF kfunc can be used more flexibily from within the
context of a BPF LSM program. It's rather common to ascertain the
backing executable file for the calling process by performing the
following walk current->mm->exe_file while instrumenting a given
operation from the context of the BPF LSM program. However, walking
current->mm->exe_file directly is never deemed to be OK, and doing so
from both inside and outside of BPF LSM program context should be
considered as a bug. Using bpf_get_task_exe_file() and in turn
bpf_put_file() will allow BPF LSM programs to reliably get and put
references to current->mm->exe_file.

As of now, all the newly introduced BPF kfuncs within this patch are
limited to BPF LSM program types. These can be either sleepable or
non-sleepable variants of BPF LSM program types.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/Makefile        |   1 +
 fs/bpf_fs_kfuncs.c | 127 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
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
index 000000000000..2a66331d8921
--- /dev/null
+++ b/fs/bpf_fs_kfuncs.c
@@ -0,0 +1,127 @@
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
+
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
+ * This BPF kfunc may only be called from BPF LSM programs.
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
+ * This BPF kfunc may only be called from BPF LSM programs.
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
+ * This BPF kfunc may only be called from BPF LSM programs.
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
+	if (!buf__sz)
+		return -EINVAL;
+
+	ret = d_path(path, buf, buf__sz);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	len = buf + buf__sz - ret;
+	memmove(buf, ret, len);
+	return len;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_task_exe_file,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
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
2.46.0.rc2.264.g509ed76dc8-goog


