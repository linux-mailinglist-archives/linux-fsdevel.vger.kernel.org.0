Return-Path: <linux-fsdevel+bounces-12135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA785B766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5FB23438
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A060867;
	Tue, 20 Feb 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoEGGpT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3B5FDB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421284; cv=none; b=FvFdljCR38RtBkTf/FzaeJwkCenOlmH6cDx86NDyDf/gvmVteyeFZwTsr3kl//dSNyyeYYNvT9lu7PC5ldeDl7wiG0cIVyxgwJpR/8Sm+Kmu6Xjl223hHa8Wte2fWGGISLF5AfE74C+9pG4MNfuTy/i55A64U/eh0MIbRc+eX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421284; c=relaxed/simple;
	bh=xyujBvXum3UlmVDv38rdAkOo5btSybwxbuNuxnw9+8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER0CtMDqjhEd1Uf+qTPDzckRwVJlI0Fj594u+Rn+875nve8pxIV+5rh9a+3ZnDBqFm6MnnRw5+bkio+CbULmUGEWxWQ8vEZckA3Z39YSllk0bCyPgD2HuHzzbt+B38W5PHqTTjz/6gNEH8cMsIO1lYaCFwdetke0kiWosc7V+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoEGGpT/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso206625666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421281; x=1709026081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8XADQWdbtL6TzlHk6jI8Rohfxav5CYgO71BwjhKPiQ=;
        b=SoEGGpT/SDbQKrP4MR3A3E9JNwSzXbeoyAObgXnzpYupTk6I9RTUnd84gwGmkOcxWR
         CyLdt8u+cHJmV35uk70NnCigfzAKOuPUlFhgPndNSIuYEuHNXgsZnr9e0u9D3B3vedHN
         T4bxOnWDQCOeBzi+WkOldaIzlaOP/Cy+ZnHPSmEy1WAkILVFjG3rKxUXBGHSvZfYIXyV
         CVYQI8StCjTTLRmNAGhw53ylj2K/Z7YtjtAoPcTMGlojKrE6iWRsSLZqwIoAdNiMFkKF
         NPpuf52YMPdLEJcIBXU790H9zwxXSDFrlYnKTwikI/JPej0x+YCl+ARLuqe7uQxtYJcq
         0oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421281; x=1709026081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8XADQWdbtL6TzlHk6jI8Rohfxav5CYgO71BwjhKPiQ=;
        b=XKJvtnuCIifogAaYUlm/klGc5PD0WbB6SacfyEwJ16DmTYFWXcQ8p8SwTIOaLmctLM
         12+oFfqaZKrJ2+Ik5DYV48wxcVxMuZNC1UX97ac5Q1hBt73ICtzvyqNeJyaLV3D9XdTH
         WZuyAkAKfAv1Z10c1jJwv3KT6rvWuHLCDhFhhr/Bn4e4meTDuNPeOFNpHu0ebTFEX7eM
         ITqG/PatKaeOxJHObu5d6RVd7jvHUWj1xyj0eU2HMKfguAm+16RUv9m3q0Bb74ywZMPX
         kt2leXuSc7NmeJ673+bg7TY/pGSkJo0SCcFk6YDexBTxnRLMkUzwUbRRVWEXUZ10ENQR
         gBqg==
X-Forwarded-Encrypted: i=1; AJvYcCU5+DdoelA1hj8DpCW3jrxlL5F5nV+CB++k8ef7c2Gu3cDlv0DAeIUX6RMOEfdZAG5/atcc0iXaifx/66nvl/by3PMAZICKqtSxRs7tHQ==
X-Gm-Message-State: AOJu0YwnM7MKeiWca1Co+EYmtnPi4I/1+9F6REO/5NTc396Kmer9c/dM
	i6RWb3yOa9Bh7PGIrINbRZPLZqzCtHWIx+8ofDzsLbfYsqnamTCXE4Utb0KSHw==
X-Google-Smtp-Source: AGHT+IG6DBO9pTBCpfeSrUfztxUsQ8peP2QTW/fPaF8CQmyYXocw8drxpjYga4ytiZkuVZEVMSE2Fg==
X-Received: by 2002:a17:906:5297:b0:a3d:de7f:2827 with SMTP id c23-20020a170906529700b00a3dde7f2827mr6505802ejm.14.1708421281034;
        Tue, 20 Feb 2024 01:28:01 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id gc24-20020a170906c8d800b00a3e4d2d99adsm2870810ejb.219.2024.02.20.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:00 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:56 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 05/11] bpf/selftests: add selftests for mm_struct
 acquire/release BPF kfuncs
Message-ID: <2f5099cd6b2ec1594c1215f15f7a484e4989315e.1708377880.git.mattbobrowski@google.com>
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

Add a new mm_kfunc test suite that is responsible for verifying the
behaviour of the newly added mm_struct based BPF kfuncs. As of now,
these selftests cover the operability of the following:

struct mm_struct *bpf_task_mm_grab(struct task_struct *task);
void bpf_mm_drop(struct mm_struct *mm);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/mm_kfunc.c       |  48 ++++++++
 .../selftests/bpf/progs/mm_kfunc_common.h     |  19 ++++
 .../selftests/bpf/progs/mm_kfunc_failure.c    | 103 ++++++++++++++++++
 .../selftests/bpf/progs/mm_kfunc_success.c    |  30 +++++
 4 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mm_kfunc.c b/tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
new file mode 100644
index 000000000000..aece5c25486d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+
+#include "mm_kfunc_failure.skel.h"
+#include "mm_kfunc_success.skel.h"
+
+static void run_test(const char *prog_name)
+{
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct mm_kfunc_success *skel;
+
+	skel = mm_kfunc_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "mm_kfunc_success__open_and_load"))
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
+	mm_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"task_mm_grab_drop_from_argument",
+	"task_mm_acquire_release_from_current",
+};
+
+void test_mm_kfunc(void)
+{
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
+			continue;
+		run_test(success_tests[i]);
+	}
+
+	RUN_TESTS(mm_kfunc_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/mm_kfunc_common.h b/tools/testing/selftests/bpf/progs/mm_kfunc_common.h
new file mode 100644
index 000000000000..043d74d4148b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mm_kfunc_common.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#ifndef _MM_KFUNC_COMMON_H
+#define _MM_KFUNC_COMMON_H
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
+char _license[] SEC("license") = "GPL";
+
+#endif /* _MM_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/mm_kfunc_failure.c b/tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
new file mode 100644
index 000000000000..d818dfcab20e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "mm_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(task_mm_grab_null_kfunc)
+{
+	struct mm_struct *acquired;
+
+	/* Can't pass a NULL pointer to bpf_task_mm_grab(). */
+	acquired = bpf_task_mm_grab(NULL);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm/task_free")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(task_mm_grab_from_lsm_task_free_kfunc, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	/* The task_struct supplied to this LSM hook isn't trusted. */
+	acquired = bpf_task_mm_grab(task);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point")
+int BPF_PROG(task_mm_grab_fp_kfunc, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *fp;
+	struct mm_struct *acquired;
+
+	fp = (struct task_struct *)&clone_flags;
+	/* Can't pass random frame pointer to bpf_task_mm_grab(). */
+	acquired = bpf_task_mm_grab(fp);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("Unreleased reference")
+int BPF_PROG(task_mm_grab_unreleased_kfunc, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	acquired = bpf_task_mm_grab(task);
+	__sink(acquired);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(task_mm_drop_untrusted_kfunc, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	/* task->mm from struct task_struct yields an untrusted pointer. */
+	acquired = task->mm;
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm/vm_enough_memory")
+__failure __msg("release kernel function bpf_mm_drop expects")
+int BPF_PROG(mm_drop_unacquired_kfunc, struct mm_struct *mm)
+{
+	/* Can't release an unacquired pointer. */
+	bpf_mm_drop(mm);
+
+	return 0;
+}
+
+SEC("lsm/vm_enough_memory")
+__failure __msg("arg#0 pointer type STRUCT mm_struct must point")
+int BPF_PROG(mm_drop_fp_kfunc, struct mm_struct *mm, long pages)
+{
+	struct mm_struct *fp;
+
+	fp = (struct mm_struct *)&pages;
+
+	/* Can't release random frame pointer. */
+	bpf_mm_drop(fp);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/mm_kfunc_success.c b/tools/testing/selftests/bpf/progs/mm_kfunc_success.c
new file mode 100644
index 000000000000..5400abd2ee2d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mm_kfunc_success.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "mm_kfunc_common.h"
+
+SEC("lsm.s/task_alloc")
+int BPF_PROG(task_mm_grab_drop_from_argument, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	acquired = bpf_task_mm_grab(task);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(task_mm_acquire_release_from_current)
+{
+	struct mm_struct *acquired;
+
+	acquired = bpf_task_mm_grab(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

