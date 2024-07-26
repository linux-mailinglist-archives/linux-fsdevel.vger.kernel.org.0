Return-Path: <linux-fsdevel+bounces-24304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0093CFFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C551C1F254B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D417837E;
	Fri, 26 Jul 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnRxFj6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2190178372
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984180; cv=none; b=G0hfxReNQ2zZwNp2A3yAkr+4d2OzqRNLTKVFJG1cKdprxAhAAHqihsqqFLC6w48Hur2aiDiE2gUpXihVVxtRYveeZJU94tiQo1GCFptJwf7vYWT17Vn+U99oSZIuQ533KoO8TOvm+sbK7bsC/liA7XgYTjhOWurS10VHJddQxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984180; c=relaxed/simple;
	bh=RVNBSjBqgj/6y6lyrajxl/PVAJAWndjeKfyDpCSBkrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HDlHwqpR7ZRj4mmt+toGJ8WMC8XQSJW17Mx1VlhxeZtZlo4PRtrpMtJ2DXKKia9ADJxRqsiUpwFdVrVuvR8PNtW/vepfGK/q7SqRRylEWq/qy4IFYo7/Ngy0Oyrv6jWfhAdwviD0O/dILb7PhxnIx9pWQkm5WraM0lk1EvOSSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnRxFj6M; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7ab4817f34so117810766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721984177; x=1722588977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq0OZln+RUILnwIv9j4pYi6OZYhyhT/7v/9YG1LoiO8=;
        b=hnRxFj6My/DXT+4GsAq3gK+TNKdReXX3ubhjEz1RdoyTv7ByOgblsI2DHXBu3HGnwg
         mzuiTUY4SoiigrkSX7aFFiGU8iAg6ufP2quITkFtPNz2/FIfPdGzh/AmaOgA2q9P4f4F
         ptz9PVHvnakRWxtLhkTwFyjj0zXd1ZJmmNQTcj3H67a3lnE8BBA83eQFrb+e4fGMC3ye
         kbw/mqdeHQx1IBXiI6WRW3MoiocpgZkf+zmwt3MMOJ3XEx8JYbOVrcNLwVd110ANOAQY
         c6Re/1PtAI4Lt9BlSU0xZWpFnThr2bkhs+Ka39JUZNYGdTV48xgUFUsJHh57q+wKUoLw
         vLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984177; x=1722588977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq0OZln+RUILnwIv9j4pYi6OZYhyhT/7v/9YG1LoiO8=;
        b=uVWifEKenzRdIFxYDcluizQRTk2OBa+AF1DlPXQmGwEChdvTVtkMOgx7b7shTnwg7S
         MVv4BGD4AxmWmsAH5jI3tMvH694BG0DB3ty5ULWthb67VpMBVAp5KHlLRx9z/U564Zdb
         6YjTHNCI8yKH8m4zLG1X/z/rhUxFtYof4a2p32jYKJsN0JNQFOq6GmKkI2oTQwQc6+4v
         uJazpDTCjKVNSfiF1eQLooWlUrnlG6LfBtA0l1yx0KlDhHwWI3vsXz9K2awOUbspo8Lx
         008x6agJIbxW9fg36hMMYl+2Mn9RUnXmxLWGUWktp5TALPxc099Apmbatd3cdbmyrRp/
         rphw==
X-Forwarded-Encrypted: i=1; AJvYcCUv0eMmxDZ+Vz8727ox7eNCEkz8UpEgTv6xka3uNpxsAIxshaD2pQQvxrYQJH1N2cxfGkzALNxB791WRMRhGnypx1gB+yBZb1jhrVfKqw==
X-Gm-Message-State: AOJu0YwMJsWhYL9h004nkZU+Zg+ZVHiAdOyqzpaDhLNMSaScsQgaz78i
	pR35Dprw6XSZC9RwUnQUTBwPofr03u/11P5Kzh3dq2WL804ZOcMMM/PNtnFIj3NG6ZsUHD1a2Ea
	fYXVIyd0S7Ik6NPwYXxcXAIL/0YGC3g==
X-Google-Smtp-Source: AGHT+IHAPnfPb4bZn0X4tZTpS1hqhadVq0TkVqX4dUZ4IJNrsF6esqiID4ehBuzvYaUqjmC6OwhuMKTDj7nC6SF2K4pu
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:3c55:b0:a7a:8d9b:14e6 with
 SMTP id a640c23a62f3a-a7ac527d38emr328966b.9.1721984177226; Fri, 26 Jul 2024
 01:56:17 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:56:04 +0000
In-Reply-To: <20240726085604.2369469-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726085604.2369469-4-mattbobrowski@google.com>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: add positive tests for new VFS
 based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a bunch of positive selftests which extensively cover the various
contexts and parameters in which the new VFS based BPF kfuncs may be
used from.

Again, the following VFS based BPF kfuncs are thoroughly tested within
this new selftest:
* struct file *bpf_get_task_exe_file(struct task_struct *);
* void bpf_put_file(struct file *);
* int bpf_path_d_path(struct path *, char *, size_t);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_vfs_accept.c | 71 +++++++++++++++++++
 2 files changed, 73 insertions(+)
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
index 000000000000..55deb96a4421
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -0,0 +1,71 @@
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
+int BPF_PROG(get_task_exe_file_and_put_kfunc_from_current)
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
2.46.0.rc1.232.g9752f9e123-goog


