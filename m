Return-Path: <linux-fsdevel+bounces-24678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B1942CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E351F2103F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21BD1B140E;
	Wed, 31 Jul 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ojvdezd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBC1B011C
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424130; cv=none; b=DW6lZ4LCSr5QDCLWNJpPEREfWDwH5IM3TeTloOOIcvTmFKDil/K5HtC8XfK2bwVZPFY4dA3H2jgGgSSjhDgJTEATRMKtOt3+Dtz0Kcb3qoheWWuIFI40X16rPDatBTHix4gZKRLLxs7Ho2k9nnPN7PeNFDtCKmbsslseXr1l6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424130; c=relaxed/simple;
	bh=EJtCRHtH1p/hjlUWkZ8EbfQRy8r091jo0UWRQrvZ63o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdKdAXCTWMWrQiTMLQUBiiXE8KIJ+6/Q+l8mfU2e4SFUG27QjUHxCJ7+86y57D6XZAUChBnGQh/ozXiQ9btF5yr5CbJxQFYBRe8fwf3u3wAm8Gf8vd9MOhVR+aMFFSB9hGgzZkUx0TzAmPdUdkukEIbrirbyirjgxGnsOtdxgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ojvdezd; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5a7c6a0f440so4013263a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 04:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722424127; x=1723028927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhX9Dn2dYEGADnEd43YjYu7LsCt2U3qbeJk9GZJbyfc=;
        b=4OjvdezdCMygLHYXegdZ/7QyaZUe0Fy/TWn0h3+YV9PqvV68uWHtegMs8oA5nzGUGj
         TuQh0t/J06hcJUc51RsBvAOi0EqSWJmd5FfLqF2WW3bW/a1s/oKEucdH0cROaU8zowFc
         DjNbWeZUCvueb0JG5/7hsNatOYipuYqeQK3x2L6qQvk8AUXsq9H50HMpMVEvVc1IJzja
         cctOgTI+hutZ7YwpPWHDxImJyCy3qWEYMdgxHylBGgV3nOP7czv5g8BwYrbvJ7qV0zNF
         I+C1yOGqLjvf6Y3NPhRc+u+1TLng6vWipqu2UL1eLnhAImSgiW5tMg77zlWnfmu1+4JF
         yBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424127; x=1723028927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhX9Dn2dYEGADnEd43YjYu7LsCt2U3qbeJk9GZJbyfc=;
        b=KnEarGba8rtw2uyzWlBgjV5vYObhXgYaPSRejIbCzrBSgh4JxQSC2rbnT4iprvFTSF
         noSh+6Qp5cJqZjSJ5EmTLE7jFF/XX533epnrzAZWBaT6iyPRa9Eszp61pZGDKKNju+p0
         dHHNL+f9d6xfXjq/wjs0LGMV+J8meYQFhuxPWBCVnj+TW0gshpWema4QCNX2VCuxn7eh
         9BWjihUm7FA9GUT1veyyM1tg69IbQw92AFRftUyaMTxKETEJg0isQyVlZX0iRHWfUsyE
         HEp7ofFpLZ4bjtLOWfMJ3d4B7RGnnYeHN/alXdp4Dly29uT2NTjuZGxGtboN9Ztfm47Q
         VNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBeG49NGiBpNtHzRvbXN6kOw7+eQwZ3F+mtrVoqFAEcRI2uP1Ykt5XLBUdy0zppEVCjcXFtjuz31onlnlh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywenq+EZ9Ge15kcjt5YXfJ5cBO1s9CGp03MQimHU386QtsLN119
	kBwuKxfDY3EGKioAjmEBZz3MSPnTri1USRBCjljSkmKwUks/BOWnCEBs83IrlCAWyeKZVl5foVC
	GM7t4ydCQMbPToB5BBGbM4JOEKYb/Ag==
X-Google-Smtp-Source: AGHT+IGCB+7ciM2k4Zjt08zrdkD3kcN3lYfivH9lne4+HMvrKuhy34WlVwIVIlUXGKTKxhboqxq3+M/a7HwgV3FC7PAp
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a05:6402:d43:b0:57d:505c:f4a1 with
 SMTP id 4fb4d7f45d1cf-5b01ff137d9mr12252a12.2.1722424126642; Wed, 31 Jul 2024
 04:08:46 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:08:33 +0000
In-Reply-To: <20240731110833.1834742-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731110833.1834742-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240731110833.1834742-4-mattbobrowski@google.com>
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: add positive tests for new VFS
 based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a bunch of positive selftests which extensively cover the various
contexts and parameters in which the new VFS based BPF kfuncs may be
used from.

Again, the following VFS based BPF kfuncs are thoroughly tested within
this new selftest:
* struct file *bpf_get_task_exe_file(struct task_struct *);
* void bpf_put_file(struct file *);
* int bpf_path_d_path(struct path *, char *, size_t);

Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_vfs_accept.c | 85 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 14d74ba2188e..f8f546eba488 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -85,6 +85,7 @@
 #include "verifier_value_or_null.skel.h"
 #include "verifier_value_ptr_arith.skel.h"
 #include "verifier_var_off.skel.h"
+#include "verifier_vfs_accept.skel.h"
 #include "verifier_vfs_reject.skel.h"
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
@@ -206,6 +207,7 @@ void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
+void test_verifier_vfs_accept(void)	      { RUN(verifier_vfs_accept); }
 void test_verifier_vfs_reject(void)	      { RUN(verifier_vfs_reject); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
new file mode 100644
index 000000000000..a7c0a553aa50
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+static char buf[64];
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_current_sleepable)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__success
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_current_non_sleepable, struct file *file)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__success
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_argument,
+	     struct task_struct *task)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(task);
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/inode_getattr")
+__success
+int BPF_PROG(path_d_path_from_path_argument, struct path *path)
+{
+	int ret;
+
+	ret = bpf_path_d_path(path, buf, sizeof(buf));
+	__sink(ret);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(path_d_path_from_file_argument, struct file *file)
+{
+	int ret;
+	struct path *path;
+
+	/* The f_path member is a path which is embedded directly within a
+	 * file. Therefore, a pointer to such embedded members are still
+	 * recognized by the BPF verifier as being PTR_TRUSTED as it's
+	 * essentially PTR_TRUSTED w/ a non-zero fixed offset.
+	 */
+	path = &file->f_path;
+	ret = bpf_path_d_path(path, buf, sizeof(buf));
+	__sink(ret);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.46.0.rc2.264.g509ed76dc8-goog


