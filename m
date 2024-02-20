Return-Path: <linux-fsdevel+bounces-12139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D5D85B776
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D740B215FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA26088A;
	Tue, 20 Feb 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hklmhTHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2454612CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421316; cv=none; b=cBl9NLGq4fW3ou39zHJl43tKwcpgIX2OVJXKHgofvm21AshuTQnjd5A+qrvjMeI+YubD99RdAFQFIvBePf+LnY0V0HmBBQnpLTKZbIxAblSUNKzxypMybfNC9RurrUtW1VQcUmrM+EWzyOd/gAJyAhoGx8xbu5dd/1y+l5eaRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421316; c=relaxed/simple;
	bh=SUs4twjkG/NT+xQtrF7hqn8/N6GJKznJtsrDmd2mx84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWs+udxbpA6xBqPxJXRVYB24yXO6N4PeuXUxgyQ5bcSPDWtPpQQiJogkHdxoeZ6VANfkEShjyTDhPiYzupv89aSOcZXVD8jqpRNGNcZAYoNy1jThq74oSuNZHyHyNBiwT/QeT9LB/jE22AeBQ0uKmlSIZv3P8ipAMkJLK7sqWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hklmhTHp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so1682114a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421313; x=1709026113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gkg6jmWVd42dKRaH6Zp1yxuMwQVLzUgdMybGYokBaX8=;
        b=hklmhTHphS1H3PiSZ40iFSPA81eKwX01ygXWYrRoilt2BArKKn4C335rV0IRjV2p9W
         zYjl4OyVDlLduWzOlBjmxLY5AVg6TElfFroJg2D3k3Ea4Qw9kKQ2jpkqzyomS/kZwF9f
         cabC8GT/FXH+N5l9NfNTQ51kGjxjdWlpfoKhjUfDmTT3l/vTXdXnD+/22Sr7orZPXkMy
         QHs/1NQiTQBN3P1hHO771RnfvATJLyYvjTiNfmjd8Sk7+XGShd1H4jb3G6zDspglizQ2
         0phCSS00BFOxUs+Mc/t2CU4j7ImXfpG2YRLekdjmOvPK2+Gt2o8+aG9rVfQCoer7+3wN
         Z29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421313; x=1709026113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gkg6jmWVd42dKRaH6Zp1yxuMwQVLzUgdMybGYokBaX8=;
        b=P03A+ql6EubCrfXPmNkbgTNpoKDGFFX/jmN2QudQZSbapLDW+cBJIxNtZH5+daW+j8
         5xb21Zio5ZGbyLIc+jJ9aRJE2SxcJHBeJvmCovZge/vT0tspKV4skfXLRyHsfh3UhVTm
         k1aK5i9JbA59U9+4cZd7evGTM2ts+Rl0pYKa1xCiFYiLGD3GhSNN2yti+NtGpGqyrUJY
         qqZQRZQGIhLFTGaAmdUlj3k2QKSEyciX0zHLTWm7EUP00G23ZVP9tPOK7yDtrrpt4C/3
         qzBSUd/Dm03W1u0MoWTwehHcEfs4I36Zyf5CgPSb/Kuqg1i/kbRe+vC9e1HyRbrNyhF4
         hoUg==
X-Forwarded-Encrypted: i=1; AJvYcCWYWzfAw0Z+66CZufTO8NAVIxWPo8KDtPg1KcN3b6JcS8htOkMbY6gIDGQdVPc5gqxhBLwwlrUTegN/DOlqj3De+8rCo361IZ/Oyq4aSw==
X-Gm-Message-State: AOJu0YxuZ5cygq9JpSYdk0vj1baXOTNsVfbva3rGwXRQ8qz4QmbsaCvw
	WFLqeu0wqYTbRQ3JIeImSTd6oZBSNQ9MXj34u/yqrvQR2kV3b+QCCLf3/bm3ZQ==
X-Google-Smtp-Source: AGHT+IEKYq2YhQbsGw9If+Nmvq/U37VhRsQ4MwUOAmeLljjhyFDj3agKWJkWI5zBOj37js1/VglOnA==
X-Received: by 2002:a17:906:378e:b0:a3e:fce7:9393 with SMTP id n14-20020a170906378e00b00a3efce79393mr645681ejc.10.1708421312983;
        Tue, 20 Feb 2024 01:28:32 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907890600b00a3e43b7e7b4sm3019627ejc.143.2024.02.20.01.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:32 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:28 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 09/11] bpf/selftests: add selftests for root/pwd
 path based BPF kfuncs
Message-ID: <0306f0c54b37afa67ab896d796ac150c90c027ea.1708377880.git.mattbobrowski@google.com>
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

Add a new path_kfunc test suite that is responsible for verifiying the
operability of the newly added root/pwd path based BPF kfuncs. This
test suite covers the following BPF kfuncs:

struct path *bpf_get_task_fs_root(struct task_struct *task);
struct path *bpf_get_task_fs_pwd(struct task_struct *task);
void bpf_put_path(struct path *path);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/path_kfunc.c     |  48 ++++++++
 .../selftests/bpf/progs/path_kfunc_common.h   |  20 +++
 .../selftests/bpf/progs/path_kfunc_failure.c  | 114 ++++++++++++++++++
 .../selftests/bpf/progs/path_kfunc_success.c  |  30 +++++
 4 files changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/path_kfunc.c b/tools/testing/selftests/bpf/prog_tests/path_kfunc.c
new file mode 100644
index 000000000000..9a8701a7999c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/path_kfunc.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Google LLC. */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+
+#include "path_kfunc_failure.skel.h"
+#include "path_kfunc_success.skel.h"
+
+static void run_test(const char *prog_name)
+{
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct path_kfunc_success *skel;
+
+	skel = path_kfunc_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "path_kfunc_success__open_and_load"))
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
+	path_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"get_task_fs_root_and_put_from_current",
+	"get_task_fs_pwd_and_put_from_current",
+};
+
+void test_path_kfunc(void)
+{
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
+			continue;
+		run_test(success_tests[i]);
+	}
+
+	RUN_TESTS(path_kfunc_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/path_kfunc_common.h b/tools/testing/selftests/bpf/progs/path_kfunc_common.h
new file mode 100644
index 000000000000..837dc03c136d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_kfunc_common.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Google LLC. */
+
+#ifndef _PATH_KFUNC_COMMON_H
+#define _PATH_KFUNC_COMMON_H
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct path *bpf_get_task_fs_root(struct task_struct *task) __ksym;
+struct path *bpf_get_task_fs_pwd(struct task_struct *task) __ksym;
+void bpf_put_path(struct path *path) __ksym;
+
+#endif /* _PATH_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/path_kfunc_failure.c b/tools/testing/selftests/bpf/progs/path_kfunc_failure.c
new file mode 100644
index 000000000000..a28797e245e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_kfunc_failure.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Google LLC. */
+
+#include "path_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_task_fs_root_kfunc_null)
+{
+	struct path *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_task_fs_root(). */
+	acquired = bpf_get_task_fs_root(NULL);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_task_fs_pwd_kfunc_null)
+{
+	struct path *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_task_fs_pwd(). */
+	acquired = bpf_get_task_fs_pwd(NULL);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_task_fs_root_kfunc_untrusted, struct task_struct *task)
+{
+	struct path *acquired;
+	struct task_struct *parent;
+
+	/* Walking the struct task_struct will yield an untrusted pointer. */
+	parent = task->parent;
+	if (!parent)
+		return 0;
+
+	acquired = bpf_get_task_fs_root(parent);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_task_fs_pwd_kfunc_untrusted, struct task_struct *task)
+{
+	struct path *acquired;
+	struct task_struct *parent;
+
+	/* Walking the struct task_struct will yield an untrusted pointer. */
+	parent = task->parent;
+	if (!parent)
+		return 0;
+
+	acquired = bpf_get_task_fs_pwd(parent);
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(get_task_fs_root_kfunc_unreleased)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_root(bpf_get_current_task_btf());
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
+int BPF_PROG(get_task_fs_pwd_kfunc_unreleased)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_pwd(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	__sink(acquired);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/inode_getattr")
+__failure __msg("release kernel function bpf_put_path expects refcounted PTR_TO_BTF_ID")
+int BPF_PROG(put_path_kfunc_unacquired, struct path *path)
+{
+	/* Can't release an unacquired pointer. */
+	bpf_put_path(path);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/path_kfunc_success.c b/tools/testing/selftests/bpf/progs/path_kfunc_success.c
new file mode 100644
index 000000000000..8fc8e3c51405
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/path_kfunc_success.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Google LLC. */
+
+#include "path_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+int BPF_PROG(get_task_fs_root_and_put_from_current)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_root(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(get_task_fs_pwd_and_put_from_current)
+{
+	struct path *acquired;
+
+	acquired = bpf_get_task_fs_pwd(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_put_path(acquired);
+
+	return 0;
+}
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

