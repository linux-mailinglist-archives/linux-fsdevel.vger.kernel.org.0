Return-Path: <linux-fsdevel+bounces-12141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0DD85B781
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D49288360
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB360ED0;
	Tue, 20 Feb 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyMHfHEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42964CD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421329; cv=none; b=PjY3ULZLmk3CRo6ynX4XT1oW+aJzUCo+8JvsXniYfFwjH+tzh8Sq9EDn9ETf3icpPaov3OymKkhHcxDx3tDHQYbT9MY4sUaJzTNQT4XDkN5McRZlZ4r3MixDV/cQsez0mP8zLvDoM9kyXXvMTWE01GvY4E03XuDJIwvAbT+c0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421329; c=relaxed/simple;
	bh=aENrpF6P2Li0J5c9iKSwwW15d0q+FsSRPaXVDh8H5nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEHgZTJ7WvR8H/tGJfgECGt+czR84Kl5fydWfjfek/iFqVOdJBLzzuYQnoWnT+S0sa6K5Mvv52xM51bJS48to5roiObozxoWhRS8MZsTlsXdyp7xRmrJyyFv1XVr3imjjnc+a+/ELyR0M4mwSXb/KTF48WGO0MWsWlkyWDJhnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyMHfHEA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so4746554a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421326; x=1709026126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+EkyM++YIrsW/V5CCx1zZ3Et3tMoJsoGeRD8+dlvMk=;
        b=CyMHfHEA/byw8Dq9IjsgKZ8V1uOLV9vb5FG9tH4AKug0FpQGiPnZ/GW26R+LjF5jW3
         1eO7+w9G4NoedRF7guSE/m/L+eONSbmmsxpH29OV8xsCLxG4ELqfN42GHCS0AQInTquY
         EDJbuLX+Wd1/K4pdzThzdjqc8I4+7xISUcf8w/FxSmPBbNo2cu2nBeuDiUZ+8D469v4O
         v3ARr/UcBUdtdvpAJB8sV5/Z79s1HpRj6rWogYg/UIdzW4PW8SCSilWTuJIdU+ey8V4B
         RlkxEgCFbr3YmvGY/vaMMUV16Tm6JeriMr9unKYS4V1E0kA0vaz9Jxlwln+KWc5lf1u+
         59nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421326; x=1709026126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+EkyM++YIrsW/V5CCx1zZ3Et3tMoJsoGeRD8+dlvMk=;
        b=uTrNcbi0ZnZQ7fTV6aX8wu8GafkVleGUhiI5FciLP1JQLqXENeYyENVPseT7zkp24t
         eLVj6AGO2h2PVD0rUSjvBlhQ8DKrqjoEtypTQd7FgyIvPYLPEudWaO+y67yjFPbMr2K1
         E3KCfgsK6Q/9vTlRlJujH0lZoshSO3KEdiSPRsyafzTeO6jWQ0O4hk5pSMdBQ7+5hTM7
         3GVDUm0iaJzG6z0Jvgg6cS06ulRLBVAf4U+Jyx7obAEJ3EGJdV2X7dMwn0DTxNrVF2oP
         B1pMkNCscuKloY4vwLIvg7FiXzPdlXGHhgQUPvQIeyb6ArEIHQa5wDPpFPRhTfVs77hh
         wcAg==
X-Forwarded-Encrypted: i=1; AJvYcCXZg9+JVzfBRXRlgR2vh6WtUzXDDP+cEe1PXsqFeeB0ro0LBuNzcWfOSKCuk0ZX+aZhPH4GPCtgmsABZ+YqE7Qe7PX/gzJDf7KOp89s+g==
X-Gm-Message-State: AOJu0YwsfGa/kFxiVUiEuqfigzsPmG9POgjTyO4tXPYC1InJEmwCUdhF
	eUXEcm5bpV7RdSq65H63f4X98pbi5u79+MhxHEPalwgifePHCO25L5jsCRcM45qXJb8aukTrCrE
	aAw==
X-Google-Smtp-Source: AGHT+IHWimJH/1mUsRr2jPvB6bYFOCJPTwnQWpocgIsq4PW29tPp7dLuh4wwcUsYAGpjbODnAgOU2g==
X-Received: by 2002:aa7:c493:0:b0:564:d24c:64b5 with SMTP id m19-20020aa7c493000000b00564d24c64b5mr597501edq.26.1708421325557;
        Tue, 20 Feb 2024 01:28:45 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id l15-20020a056402124f00b00564c8800f66sm373671edw.14.2024.02.20.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:45 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:41 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 11/11] bpf/selftests: adapt selftests test_d_path
 for BPF kfunc bpf_path_d_path()
Message-ID: <7e27b0d22d89253243fc676a6cd675e0e8ea93b1.1708377880.git.mattbobrowski@google.com>
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

Adapt the existing test_d_path test suite to cover the operability of
the newly added trusted d_path() based BPF kfunc bpf_path_d_path().

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 106 ++++++++++++++++--
 .../selftests/bpf/progs/d_path_common.h       |  34 ++++++
 .../bpf/progs/d_path_kfunc_failure.c          |  66 +++++++++++
 .../bpf/progs/d_path_kfunc_success.c          |  25 +++++
 .../testing/selftests/bpf/progs/test_d_path.c |  20 +---
 .../bpf/progs/test_d_path_check_rdonly_mem.c  |   6 +-
 .../bpf/progs/test_d_path_check_types.c       |   6 +-
 7 files changed, 222 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index d77ae1b1e6ba..893324d4d59f 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -11,6 +11,8 @@
 #include "test_d_path.skel.h"
 #include "test_d_path_check_rdonly_mem.skel.h"
 #include "test_d_path_check_types.skel.h"
+#include "d_path_kfunc_failure.skel.h"
+#include "d_path_kfunc_success.skel.h"
 
 /* sys_close_range is not around for long time, so let's
  * make sure we can call it on systems with older glibc
@@ -44,7 +46,7 @@ static int set_pathname(int fd, pid_t pid)
 	return readlink(buf, src.want[src.cnt++].path, MAX_PATH_LEN);
 }
 
-static int trigger_fstat_events(pid_t pid)
+static int trigger_fstat_events(pid_t pid, bool want_error)
 {
 	int sockfd = -1, procfd = -1, devfd = -1, mntnsfd = -1;
 	int localfd = -1, indicatorfd = -1;
@@ -85,25 +87,25 @@ static int trigger_fstat_events(pid_t pid)
 	 * safely resolve paths that are comprised of dentries that make use of
 	 * dynamic names. We expect to return -EOPNOTSUPP for such paths.
 	 */
-	src.want[src.cnt].err = true;
+	src.want[src.cnt].err = want_error;
 	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(pipefd[0], pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for pipe[0]\n"))
 		goto out_close;
 
-	src.want[src.cnt].err = true;
+	src.want[src.cnt].err = want_error;
 	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(pipefd[1], pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for pipe[1]\n"))
 		goto out_close;
 
-	src.want[src.cnt].err = true;
+	src.want[src.cnt].err = want_error;
 	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(sockfd, pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for socket\n"))
 		goto out_close;
 
-	src.want[src.cnt].err = true;
+	src.want[src.cnt].err = want_error;
 	src.want[src.cnt].err_code = -EOPNOTSUPP;
 	ret = set_pathname(mntnsfd, pid);
 	if (CHECK(ret < 0, "trigger", "set_pathname failed for mntnsfd\n"))
@@ -151,12 +153,19 @@ static int trigger_fstat_events(pid_t pid)
 	return ret;
 }
 
-static void test_d_path_basic(void)
+static void test_bpf_d_path_basic(void)
 {
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
 	int err;
 
+	/*
+	 * Carrying global state across test function invocations is super
+	 * gross, but it was late and I was tired and I just wanted to get the
+	 * darn test working. Zero'ing this out was a simple no brainer.
+	 */
+	memset(&src, 0, sizeof(src));
+
 	skel = test_d_path__open_and_load();
 	if (CHECK(!skel, "setup", "d_path skeleton failed\n"))
 		goto cleanup;
@@ -168,7 +177,7 @@ static void test_d_path_basic(void)
 	bss = skel->bss;
 	bss->my_pid = getpid();
 
-	err = trigger_fstat_events(bss->my_pid);
+	err = trigger_fstat_events(bss->my_pid, /*want_error=*/true);
 	if (err < 0)
 		goto cleanup;
 
@@ -225,7 +234,7 @@ static void test_d_path_basic(void)
 	test_d_path__destroy(skel);
 }
 
-static void test_d_path_check_rdonly_mem(void)
+static void test_bpf_d_path_check_rdonly_mem(void)
 {
 	struct test_d_path_check_rdonly_mem *skel;
 
@@ -235,7 +244,7 @@ static void test_d_path_check_rdonly_mem(void)
 	test_d_path_check_rdonly_mem__destroy(skel);
 }
 
-static void test_d_path_check_types(void)
+static void test_bpf_d_path_check_types(void)
 {
 	struct test_d_path_check_types *skel;
 
@@ -245,14 +254,87 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+static struct bpf_path_d_path_t {
+	const char *prog_name;
+} success_test_cases[] = {
+	{
+		.prog_name = "path_d_path_from_path_argument",
+	},
+};
+
+static void test_bpf_path_d_path(struct bpf_path_d_path_t *t)
+{
+	int i, ret;
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct d_path_kfunc_success__bss *bss;
+	struct d_path_kfunc_success *skel;
+
+	/*
+	 * Carrying global state across function invocations is super gross, but
+	 * it was late and I was tired and I just wanted to get the darn test
+	 * working. Zero'ing this out was a simple no brainer.
+	 */
+	memset(&src, 0, sizeof(src));
+
+	skel = d_path_kfunc_success__open();
+	if (!ASSERT_OK_PTR(skel, "d_path_kfunc_success__open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	ret = d_path_kfunc_success__load(skel);
+	if (CHECK(ret, "setup", "d_path_kfunc_success__load\n"))
+		goto cleanup;
+
+	link = NULL;
+	prog = bpf_object__find_program_by_name(skel->obj, t->prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	ret = trigger_fstat_events(bss->my_pid, /*want_error=*/false);
+	if (ret < 0)
+		goto cleanup;
+
+	for (i = 0; i < MAX_FILES; i++) {
+		struct want want = src.want[i];
+		CHECK(strncmp(want.path, bss->paths_stat[i], MAX_PATH_LEN),
+		      "check", "failed to get stat path[%d]: %s vs %s\n", i,
+		      want.path, bss->paths_stat[i]);
+		CHECK(bss->rets_stat[i] != strlen(bss->paths_stat[i]) + 1,
+		      "check",
+		      "failed to match stat return [%d]: %d vs %zd [%s]\n",
+		      i, bss->rets_stat[i], strlen(bss->paths_stat[i]) + 1,
+		      bss->paths_stat[i]);
+	}
+cleanup:
+	bpf_link__destroy(link);
+	d_path_kfunc_success__destroy(skel);
+}
+
 void test_d_path(void)
 {
+	int i = 0;
+
 	if (test__start_subtest("basic"))
-		test_d_path_basic();
+		test_bpf_d_path_basic();
 
 	if (test__start_subtest("check_rdonly_mem"))
-		test_d_path_check_rdonly_mem();
+		test_bpf_d_path_check_rdonly_mem();
 
 	if (test__start_subtest("check_alloc_mem"))
-		test_d_path_check_types();
+		test_bpf_d_path_check_types();
+
+	for (; i < ARRAY_SIZE(success_test_cases); i++) {
+		if (!test__start_subtest(success_test_cases[i].prog_name))
+			continue;
+		test_bpf_path_d_path(&success_test_cases[i]);
+	}
+
+	RUN_TESTS(d_path_kfunc_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/d_path_common.h b/tools/testing/selftests/bpf/progs/d_path_common.h
new file mode 100644
index 000000000000..42d0a28a94ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_common.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#ifndef _D_PATH_COMMON_H
+#define _D_PATH_COMMON_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+#define MAX_PATH_LEN 128
+#define MAX_FILES 8
+
+int bpf_path_d_path(struct path *path, char *buf, int buflen) __ksym;
+
+pid_t my_pid = 0;
+
+__u32 cnt_stat = 0;
+__u32 cnt_close = 0;
+
+char paths_stat[MAX_FILES][MAX_PATH_LEN] = {};
+char paths_close[MAX_FILES][MAX_PATH_LEN] = {};
+
+int rets_stat[MAX_FILES] = {};
+int rets_close[MAX_FILES] = {};
+
+int called_stat = 0;
+int called_close = 0;
+
+char _license[] SEC("license") = "GPL";
+
+#endif /* _D_PATH_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c b/tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
new file mode 100644
index 000000000000..9da5f0d395c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "d_path_common.h"
+
+char buf[MAX_PATH_LEN] = {};
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(path_d_path_kfunc_null)
+{
+	/* Can't pass NULL value to bpf_path_d_path() kfunc. */
+	bpf_path_d_path(NULL, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("fentry/vfs_open")
+__failure __msg("calling kernel function bpf_path_d_path is not allowed")
+int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
+{
+	/* Calling bpf_path_d_path() kfunc from a non-sleepable and non-LSM
+	 * based program isn't permitted.
+	 */
+	bpf_path_d_path(path, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_argument, struct task_struct *task)
+{
+	struct path *root;
+
+	/* Walking a trusted argument yields an untrusted pointer. */
+	root = &task->fs->root;
+	bpf_path_d_path(root, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
+{
+	struct path *pwd;
+	struct task_struct *current;
+
+	current = bpf_get_current_task_btf();
+	/* Walking a trusted pointer returned from bpf_get_current_task_btf()
+	 * yields and untrusted pointer. */
+	pwd = &current->fs->pwd;
+	bpf_path_d_path(pwd, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must have zero offset when passed to release func or trusted arg to kfunc")
+int BPF_PROG(path_d_path_kfunc_trusted_variable_offset, struct file *file)
+{
+	/* Passing variable offsets from a trusted aren't supported just yet,
+	 * despite being perfectly OK i.e. file->f_path. Once the BPF verifier
+	 * has been updated to handle this case, this test can be removed. For
+	 * now, ensure we reject the BPF program upon load if this is attempted.
+	 */
+	bpf_path_d_path(&file->f_path, buf, sizeof(buf));
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/d_path_kfunc_success.c b/tools/testing/selftests/bpf/progs/d_path_kfunc_success.c
new file mode 100644
index 000000000000..72d1a64618d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_kfunc_success.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "d_path_common.h"
+
+SEC("lsm.s/inode_getattr")
+int BPF_PROG(path_d_path_from_path_argument, struct path *path)
+{
+	u32 cnt = cnt_stat;
+	int ret;
+	pid_t pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != my_pid)
+		return 0;
+
+	if (cnt >= MAX_FILES)
+		return 0;
+
+	ret = bpf_path_d_path(path, paths_stat[cnt], MAX_PATH_LEN);
+	rets_stat[cnt] = ret;
+	cnt_stat++;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index fc2754f166ec..5bdfa4abb5f6 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -1,22 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-#define MAX_PATH_LEN		128
-#define MAX_FILES		8
-
-pid_t my_pid = 0;
-__u32 cnt_stat = 0;
-__u32 cnt_close = 0;
-char paths_stat[MAX_FILES][MAX_PATH_LEN] = {};
-char paths_close[MAX_FILES][MAX_PATH_LEN] = {};
-int rets_stat[MAX_FILES] = {};
-int rets_close[MAX_FILES] = {};
-
-int called_stat = 0;
-int called_close = 0;
+#include "d_path_common.h"
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
@@ -61,5 +45,3 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	cnt_close++;
 	return 0;
 }
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
index 27c27cff6a3a..76654dbf637e 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Google */
 
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
+#include "d_path_common.h"
 
 extern const int bpf_prog_active __ksym;
 
@@ -24,5 +22,3 @@ int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
 	}
 	return 0;
 }
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_types.c b/tools/testing/selftests/bpf/progs/test_d_path_check_types.c
index 7e02b7361307..c722754aedb0 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path_check_types.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path_check_types.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
+#include "d_path_common.h"
 
 extern const int bpf_prog_active __ksym;
 
@@ -28,5 +26,3 @@ int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
 	}
 	return 0;
 }
-
-char _license[] SEC("license") = "GPL";
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

