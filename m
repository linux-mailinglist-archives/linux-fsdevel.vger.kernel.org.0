Return-Path: <linux-fsdevel+bounces-13690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9FD872FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB7AB26639
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028EA5C91A;
	Wed,  6 Mar 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnnULtZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B35C907
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710814; cv=none; b=QgrLQbMJLCJp8S1xWW6Zp1QtJC+bka86L2G7w+La0RxFGoQt9O7Ri2F3WQcNwIOhFKq0skshD7THr69V1WZJbdOcNuBqEOawhfjaEsvFGtEInPrDuYWD2NWJUEO6d3ukVVmspIubOAVSkuFTmv06JR7fWGewYKmRBsI+ro4Lnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710814; c=relaxed/simple;
	bh=nWQLHiPbnXEnGTDf/+TEtdNmum1UyFfr09ckYAnfdxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwfStoVagClpmMBrsyUA93hJYe+q2m/qna4L7xmgXkfyVfL2HwjxDKv0YsKUe3vH+5g87Es12EZ5KcYvn+uXGdsAuhnV+6dol75F8MdH8j/FHwWb1zdXsxt0KAT7jYEdlme6mbWIDWmeW4VlFDzvbULZMG9RwVs2Dek+1JhEDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnnULtZN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so6922996a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 23:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710811; x=1710315611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rljFKl8ue5u0Qxh8hXuWfy8iHr7ecePt00Q5/9obMrs=;
        b=KnnULtZNCKHVECbmCem2h3PkcWCYRXHodlQrL6f3BF8DfnSu7UWGhJAIfG0rsZpuwW
         P0NrM+xc3YztPi/6eYfl/7Keyrpv3JTQ7wLcDDGXm1iBVRHEeckPcQ7CDF9ce3/upVcO
         hHaNdsgDdvnf9XPbzebPh7/JbNgHwEBHrwET6RW3eYbWDEEQqiWmNKT87m0PnY6HYCpG
         IUaBRARR7hlEVqx3E22xMML87oTWzBt6XdWF5lRckVu6/TOhHl+fpDDA52+Zum5I4In4
         CfCiZUo9SmWKgLx4wXx0Evt7YKHc1DTgaU4ApN8VSEJCnB3CD6FbqO6JG0kHmO0wN22F
         dvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710811; x=1710315611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rljFKl8ue5u0Qxh8hXuWfy8iHr7ecePt00Q5/9obMrs=;
        b=PAWqIgBSMkg9/D6QIH0s/PohaSzX3v5EsqJVV7XR+TL0OaDGN2qKzy7W0R8b0nWK4a
         QQT1Dq3pvaNzpNiEaiGHILCODHgcfjwM8HQCHJmaC6pp2zOuVIdvVU/ypJIBuUVX0dC+
         9WOuKVhutpZfZixf6SajmAT8KYyEahM6hP/m1SUUk1Q7GvHSmh/Pnm5tWCQUgBcoV4s1
         zIVCV+5yzEOX3SRbYZyhwZhNYII7JBGRr4DSY+6m2gsuCCxiJk/XA+LmTDnwNJzSMXBw
         sGpFAZdI8BL8DSxL6PgvKJWIn5fuf7/JeZritSbOM6gsQCxux9ybqTAMy5IAWxly1wkL
         IlgA==
X-Forwarded-Encrypted: i=1; AJvYcCVOL9ByhhdiU9wPp4+Tq54kWae3Ldq1ygUmoG0phWmK8XRtFjXMveGusfGhSMYRlTFApLYxj6OuHYgiTw7lx/yLMxkq28ZbcuY+kwZrqw==
X-Gm-Message-State: AOJu0YyJL0zj1pRPAxoSXKmzQguMNr8z351HrX0BPD2xUmZPA//k3nb+
	+9w0OnhXjY1bHhUcHpQMCefI1PC+VeQVUbguJs6yXOlp00Mx1G2kMgmosVKtjg==
X-Google-Smtp-Source: AGHT+IHcz3ExqTFeTnEFmHSWRdYzDZyhuqU88ooD/ZKl4Jnz3VkgtVgt/N8SeENAomI8plBbvipaDw==
X-Received: by 2002:a05:6402:35cc:b0:566:f851:f53b with SMTP id z12-20020a05640235cc00b00566f851f53bmr11632189edc.35.1709710810715;
        Tue, 05 Mar 2024 23:40:10 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id z6-20020a05640240c600b005670d2c253csm4462526edb.13.2024.03.05.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:40:10 -0800 (PST)
Date: Wed, 6 Mar 2024 07:40:06 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 5/9] bpf/selftests: add selftests for exe_file
 acquire/release BPF kfuncs
Message-ID: <9c9a652a26671ce5d1278148e63bb8903024031e.1709675979.git.mattbobrowski@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

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
2.44.0.278.ge034bb2e1d-goog

/M

