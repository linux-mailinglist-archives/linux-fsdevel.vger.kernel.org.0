Return-Path: <linux-fsdevel+bounces-12137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECE85B76C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0481C24656
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376060EFF;
	Tue, 20 Feb 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTZ1Oxza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B55FDC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421298; cv=none; b=ZGlQMpmfYkkvQH0i94yhjA9D0WUPbwtk3Ym8Q7R9R7diBB/NGWq9m8gBFytdsjUBMkH01EHLFuFQv+Dx57S3rPcRY0kdGLODWlPJEWgWPuHb0JQQqxjkIxRl99iPUM2X2ZBkrL5tPwm+F5fpSh9W18ZGWggKMvPoZ2VmFsrnAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421298; c=relaxed/simple;
	bh=Z0nB72JxcKjIXXvJDvWsGLXhIPmER9IAfA2zYyBQDjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jF85FhHFHv67wkvbdwxS7XQW/aqMERCwXERVYdG4HqB9CiAzQmSAUk5pOSWIj7y1c5c0tIZTitQaUIoJV/+Wa7tCk9zzWpn7iN6Q/t0nkHXHnmgB1YgPonx9PZGJSL1Y6pHiX2a5d6m1uoVU7rTxvs56ZxGVv9pXAFb3PGhAR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTZ1Oxza; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563e330351dso4311890a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421294; x=1709026094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww1kRCbb77gPR6bbg0oXjgtFW9i+IxSISo3GWSzvNhk=;
        b=KTZ1Oxzavw7+iHL1mBcvja4KAXeTDROMF59KEDdcAVhypaFsszlo6UOtQEGJLdY9NV
         KcYPk+7DtogbF9xYQ8KXBGhMgGisyhpc/t+l0tcA1okQEstOJ0kuunD22/HlddRJyiJH
         Z+V04Yc51Vr3XGAG3BJJQ4kHnt5VmQbOEfvei8FLIvAOdKBkJUig1Q3a4zK11M9I/vBA
         HfvSwnzzXu/0eFy7PJ9ZJvtQq3mbEybudM/inlPAKGRphzv6eGzt9TUHYLB03XlvFhMl
         Q6DhaC2dSHse4xlOM+ip175QKG5Rhj2sUWU8pAF2Ky5idhGCYwhakCgZgAUK89IgYrXP
         QiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421294; x=1709026094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww1kRCbb77gPR6bbg0oXjgtFW9i+IxSISo3GWSzvNhk=;
        b=BET+sv64deBIEvTT8lPxNsf+iAAOlDOnADRjgCmZvTJz5NZdDTBn3Qy0mbSDBweImd
         GRfRQyDxckMXmR2pu6EWwmyedoI+X3j4Yc4C7uPzURNyQrpU/tqpsOkvfWHfoHFS96id
         4F30DVkxp1XNpv1scXjDCU/bytDXZ83ipxIesdpjC+HxLqvEfQhTg+PY7TovBd6eoGTh
         FdEBB/55nhcvh1XOrs8TpKDV0od6mZAvbLDzV/va9NBpFVSZZ3UtJF81GkTG4gZDx8La
         pujLH8V0RbCUhSaXnqB2Kib0A66AHSKSN5t7N5bzFrBgKR+o6+4Q3LDfu0pZSJ8VEw6O
         EA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB9p7I9x+9AS/8ITq17JKodduknbO59vjIJBwh9DTjwrzzDPrSXuCBpWgrgtRxkp/pkdAmigF3XP2txPom0yDYC+n2RJ0z8YRPBcr9tA==
X-Gm-Message-State: AOJu0Yw6TZ9EBOiO6hjHwpNxGgSqshNSfvGP5RQaqqszHT/+DaJLAC6N
	QBz+HHjWtHbevshuiPTSngERoD0eHCXbNrb0O/ok3gG2yMzh7Gg8A/udO+gCbg==
X-Google-Smtp-Source: AGHT+IFBzsGQ6n9VgZgbPf9DtIsSJDiR8P+32R2NW+JannbmTLotC54Na1fk3iFKaIff0u+7p0GHLw==
X-Received: by 2002:aa7:c655:0:b0:561:548e:e4c4 with SMTP id z21-20020aa7c655000000b00561548ee4c4mr10341708edr.19.1708421294265;
        Tue, 20 Feb 2024 01:28:14 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b0055fba4996d9sm3461914edb.71.2024.02.20.01.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:13 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:10 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 07/11] bpf/selftests: add selftests for exe_file
 acquire/release BPF kfuncs
Message-ID: <c626e45e0d6bf37e81c6581f66b9f82fb6a19d1d.1708377880.git.mattbobrowski@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708377880.git.mattbobrowski@google.com>

Add a new exe_file_kfunc test suite that is responsible for verifying
the behaviour of the newly added exe_file based BPF kfuncs.

For now, this new exe_file_kfunc test suite covers the following BPF
kfuncs:

struct file *bpf_get_task_exe_file(struct task_struct *task);
struct file *bpf_get_mm_exe_file(struct mm_struct *mm);
void bpf_put_file(struct file *f);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/exe_file_kfunc.c |  49 +++++
 .../bpf/progs/exe_file_kfunc_common.h         |  23 +++
 .../bpf/progs/exe_file_kfunc_failure.c        | 181 ++++++++++++++++++
 .../bpf/progs/exe_file_kfunc_success.c        |  52 +++++
 4 files changed, 305 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exe_file_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exe_file_kfunc.c b/tools/testing/selftests/bpf/prog_tests/exe_file_kfunc.c
new file mode 100644
index 000000000000..5900c1d4e820
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exe_file_kfunc.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+
+#include "exe_file_kfunc_failure.skel.h"
+#include "exe_file_kfunc_success.skel.h"
+
+static void run_test(const char *prog_name)
+{
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct exe_file_kfunc_success *skel;
+
+	skel = exe_file_kfunc_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "file_kfunc_success__open_and_load"))
+		return;
+
+	link = NULL;
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	ASSERT_OK_PTR(link, "bpf_program__attach");
+cleanup:
+	bpf_link__destroy(link);
+	exe_file_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"get_task_exe_file_and_put_kfunc_from_current",
+	"get_task_exe_file_and_put_kfunc_from_argument",
+	"get_mm_exe_file_and_put_kfunc_from_current",
+};
+
+void test_exe_file_kfunc(void)
+{
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
+			continue;
+		run_test(success_tests[i]);
+	}
+
+	RUN_TESTS(exe_file_kfunc_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/exe_file_kfunc_common.h b/tools/testing/selftests/bpf/progs/exe_file_kfunc_common.h
new file mode 100644
index 000000000000..6623bcc130c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exe_file_kfunc_common.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#ifndef _FILE_KFUNC_COMMON_H
+#define _FILE_KFUNC_COMMON_H
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+struct mm_struct *bpf_task_mm_grab(struct task_struct *task) __ksym;
+void bpf_mm_drop(struct mm_struct *mm) __ksym;
+
+struct file *bpf_get_task_exe_file(struct task_struct *task) __ksym;
+struct file *bpf_get_mm_exe_file(struct mm_struct *mm) __ksym;
+void bpf_put_file(struct file *f) __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+#endif /* _FILE_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/exe_file_kfunc_failure.c b/tools/testing/selftests/bpf/progs/exe_file_kfunc_failure.c
new file mode 100644
index 000000000000..8a4464481531
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exe_file_kfunc_failure.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "exe_file_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_task_exe_file_kfunc_null)
+{
+	struct file *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(NULL);
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_mm_exe_file_kfunc_null)
+{
+	struct file *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_mm_exe_file(). */
+	acquired = bpf_get_mm_exe_file(NULL);
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/inode_getxattr")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point to scalar, or struct with scalar")
+int BPF_PROG(get_task_exe_file_kfunc_fp)
+{
+	u64 x;
+	struct file *acquired;
+	struct task_struct *fp;
+
+	fp = (struct task_struct *)&x;
+	/* Can't pass random frame pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(fp);
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/inode_getxattr")
+__failure __msg("arg#0 pointer type STRUCT mm_struct must point to scalar, or struct with scalar")
+int BPF_PROG(get_mm_exe_file_kfunc_fp)
+{
+	int x;
+	struct file *acquired;
+	struct mm_struct *fp;
+
+	fp = (struct mm_struct *)&x;
+	/* Can't pass random frame pointer to bpf_get_mm_exe_file(). */
+	acquired = bpf_get_mm_exe_file(fp);
+	if (!acquired)
+		return 0;
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_task_exe_file_kfunc_untrusted)
+{
+	struct file *acquired;
+	struct task_struct *parent;
+
+	/* Walking a trusted struct task_struct returned from
+	 * bpf_get_current_task_btf() yields an untrusted pointer. */
+	parent = bpf_get_current_task_btf()->parent;
+	/* Can't pass untrusted pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(parent);
+	if (!acquired)
+		return 0;
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_mm_exe_file_kfunc_untrusted)
+{
+	struct file *acquired;
+	struct mm_struct *mm;
+
+	/* Walking a struct task_struct obtained from bpf_get_current_task_btf()
+	 * yields an untrusted pointer. */
+	mm = bpf_get_current_task_btf()->mm;
+	/* Can't pass untrusted pointer to bpf_get_mm_exe_file(). */
+	acquired = bpf_get_mm_exe_file(mm);
+	if (!acquired)
+		return 0;
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(get_task_exe_file_kfunc_unreleased)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	__sink(acquired);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(get_mm_exe_file_kfunc_unreleased)
+{
+	struct file *acquired;
+	struct mm_struct *mm;
+
+	mm = bpf_task_mm_grab(bpf_get_current_task_btf());
+	if (!mm)
+		return 0;
+
+	acquired = bpf_get_mm_exe_file(mm);
+	if (!acquired) {
+		bpf_mm_drop(mm);
+		return 0;
+	}
+	__sink(acquired);
+	bpf_mm_drop(mm);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_put_file")
+int BPF_PROG(put_file_kfunc_not_sleepable, struct file *f)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	/* Can't call bpf_put_file() from non-sleepable BPF program. */
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("release kernel function bpf_put_file expects")
+int BPF_PROG(put_file_kfunc_unacquired, struct file *f)
+{
+	/* Can't release an unacquired pointer. */
+	bpf_put_file(f);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("calling kernel function bpf_get_task_exe_file is not allowed")
+int BPF_PROG(get_task_exe_file_kfunc_not_lsm_prog, struct task_struct *task)
+{
+	struct file *acquired;
+
+	/* bpf_get_task_exe_file() can only be called from BPF LSM program. */
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_put_file(acquired);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/exe_file_kfunc_success.c b/tools/testing/selftests/bpf/progs/exe_file_kfunc_success.c
new file mode 100644
index 000000000000..ae789cb0a9ae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exe_file_kfunc_success.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "exe_file_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_current)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_argument,
+	     struct task_struct *task)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(task);
+	if (!acquired)
+		return 0;
+	bpf_put_file(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(get_mm_exe_file_and_put_kfunc_from_current)
+{
+	struct file *acquired;
+	struct mm_struct *mm;
+
+	mm = bpf_task_mm_grab(bpf_get_current_task_btf());
+	if (!mm)
+		return 0;
+
+	acquired = bpf_get_mm_exe_file(mm);
+	if (!acquired) {
+		bpf_mm_drop(mm);
+		return 0;
+	}
+	bpf_put_file(acquired);
+	bpf_mm_drop(mm);
+
+	return 0;
+}
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

