Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE786A55E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjB1JeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjB1JeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:34:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934772069E;
        Tue, 28 Feb 2023 01:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DFDD61027;
        Tue, 28 Feb 2023 09:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4462DC433D2;
        Tue, 28 Feb 2023 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576836;
        bh=v7m3NBy45N+El792surZKP+8N2u7TLJVtr7h9aVoZ3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyNEGeiJh2hA0zwJNzVbvcRv6+QHDsr6iTjXBPAfvWILgkkPZYkyJWjabJgFTcgOz
         +tEugTlLcvM2FjUSspt2SZrIkU9+pvmpiBl5uTt7FuqPEN7vfyub3oHWfvuaqO9aSs
         Jmi26GTZAFipKJDW8bpPIsCZ4s20pU2eQaaPd6muUmEwKDazp16sZJLHI7p0M85fXk
         lS1p/MSgROM6HKQrNDqGsyhrIABsgqU4QshrTJNIVI519Tor+O7fWvS/tQkZoVR4wQ
         74c9LC0+Og9JHKP8WxKXm91ifBrX/0gdPSBVu9EEp1wdP2NDpBoUNtRyK17iMJLJ3c
         EeioIfex1Td4g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 8/9] selftests/bpf: Add inode_build_id test
Date:   Tue, 28 Feb 2023 10:32:05 +0100
Message-Id: <20230228093206.821563-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test attaches bpf program to sched_process_exec tracepoint
and gets build of executed file from bprm->file->f_inode object.

We use urandom_read as the test program and in addition we also
attach uprobe to liburandom_read.so:urandlib_read_without_sema
and retrieve and check build id of that shared library.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/inode_build_id.c | 68 +++++++++++++++++++
 .../selftests/bpf/progs/inode_build_id.c      | 62 +++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      | 10 +++
 3 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inode_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/inode_build_id.c

diff --git a/tools/testing/selftests/bpf/prog_tests/inode_build_id.c b/tools/testing/selftests/bpf/prog_tests/inode_build_id.c
new file mode 100644
index 000000000000..d0add90f187d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/inode_build_id.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <unistd.h>
+#include <test_progs.h>
+#include "inode_build_id.skel.h"
+#include "trace_helpers.h"
+
+void test_inode_build_id(void)
+{
+	int go[2], err, child_pid, child_status, c = 1, sz;
+	char build_id[BPF_BUILD_ID_SIZE];
+	struct inode_build_id *skel;
+
+	skel = inode_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "inode_build_id__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(pipe(go), "pipe"))
+		goto out;
+
+	child_pid = fork();
+	if (child_pid < 0)
+		goto out;
+
+	/* child */
+	if (child_pid == 0) {
+		/* wait for parent's pid update */
+		err = read(go[0], &c, 1);
+		if (!ASSERT_EQ(err, 1, "child_read_pipe"))
+			exit(err);
+
+		execle("./urandom_read", "urandom_read", NULL, NULL);
+		exit(errno);
+	}
+
+	/* parent, update child's pid and kick it */
+	skel->bss->pid = child_pid;
+
+	err = inode_build_id__attach(skel);
+	if (!ASSERT_OK(err, "inode_build_id__attach"))
+		goto out;
+
+	err = write(go[1], &c, 1);
+	if (!ASSERT_EQ(err, 1, "child_write_pipe"))
+		goto out;
+
+	/* wait for child to exit */
+	waitpid(child_pid, &child_status, 0);
+	if (!ASSERT_EQ(WEXITSTATUS(child_status), 0, "child_exit_value"))
+		goto out;
+
+	sz = read_build_id("./urandom_read", build_id);
+	if (!ASSERT_GT(sz, 0, "read_build_id"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->build_id_bin_size, sz, "build_id_bin_size");
+	ASSERT_MEMEQ(skel->bss->build_id_bin, build_id, sz, "build_id_bin");
+
+	sz = read_build_id("./liburandom_read.so", build_id);
+	if (!ASSERT_GT(sz, 0, "read_build_id"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->build_id_lib_size, sz, "build_id_lib_size");
+	ASSERT_MEMEQ(skel->bss->build_id_lib, build_id, sz, "build_id_lib");
+
+out:
+	inode_build_id__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/inode_build_id.c b/tools/testing/selftests/bpf/progs/inode_build_id.c
new file mode 100644
index 000000000000..eceb215b56b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/inode_build_id.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include "err.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/string.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+
+u32 build_id_bin_size;
+u32 build_id_lib_size;
+
+char build_id_bin[20];
+char build_id_lib[20];
+
+static int store_build_id(struct inode *inode, char *build_id, u32 *sz)
+{
+	struct build_id *bid;
+
+	bid = inode->i_build_id;
+	if (IS_ERR_OR_NULL(bid))
+		return 0;
+	*sz = bid->sz;
+	if (bid->sz > sizeof(bid->data))
+		return 0;
+	__builtin_memcpy(build_id, bid->data, sizeof(bid->data));
+	return 0;
+}
+
+SEC("tp_btf/sched_process_exec")
+int BPF_PROG(prog, struct task_struct *p, pid_t old_pid, struct linux_binprm *bprm)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != cur_pid)
+		return 0;
+	if (!bprm->file || !bprm->file->f_inode)
+		return 0;
+	return store_build_id(bprm->file->f_inode, build_id_bin, &build_id_bin_size);
+}
+
+static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
+		      void *data)
+{
+	if (!vma || !vma->vm_file || !vma->vm_file->f_inode)
+		return 0;
+	return store_build_id(vma->vm_file->f_inode, build_id_lib, &build_id_lib_size);
+}
+
+SEC("uprobe/liburandom_read.so:urandlib_read_without_sema")
+int BPF_UPROBE(urandlib_read_without_sema)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != cur_pid)
+		return 0;
+	return bpf_find_vma(task, ctx->ip, check_vma, NULL, 0);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 3825c2797a4b..8156d6d4cb3b 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -310,6 +310,16 @@ int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_MEMEQ(actual, expected, sz, name) ({			\
+	static int duration = 0;					\
+	const char *___act = actual;					\
+	const char *___exp = expected;					\
+	bool ___ok = memcmp(___act, ___exp, sz) == 0;			\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s does not match\n", (name));		\
+	___ok;								\
+})
+
 #define ASSERT_STRNEQ(actual, expected, len, name) ({			\
 	static int duration = 0;					\
 	const char *___act = actual;					\
-- 
2.39.2

