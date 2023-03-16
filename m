Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5306BD6B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCPREl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjCPREY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:04:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0A7AB4;
        Thu, 16 Mar 2023 10:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A5BB8227B;
        Thu, 16 Mar 2023 17:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53045C433EF;
        Thu, 16 Mar 2023 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986232;
        bh=k3FKXivEZQL3axXlXOQ80+3Y8PlgcvRRWyE+8fiPDqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxOQsfSSGaoCqeogPae5AJUpOEd+YvVBDDuK+Eus7fUz8mbGY4O1QvXKR4yOLvQAA
         nn40HHqQ2kXbrnbDntkEm7qk9ztbPrj2IfSmKS+dfEEI+Uu8M/6aeuUXFhMI9axTfP
         HDkKdq5eKsi2Ix/bdr8XPpEslpQhCx7Qc5wgm0vwZYWd/45Z90H3PImim3RdiUWp1n
         5AUn7e7JXRtiwiY9hQqUpXrbHw+IgKDUBiY/nzwm5WhYqV3qjk9ekZS9C5Zo5hARmK
         RJnlCcshgQi3iZksY69nnMeEW9c1TC7Plz9AHRDpGFuWX1cgHLvO4Hr0DTwXMfFjRk
         Tj4UwPziJK8aA==
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
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCHv3 bpf-next 9/9] selftests/bpf: Add file_build_id test
Date:   Thu, 16 Mar 2023 18:01:49 +0100
Message-Id: <20230316170149.4106586-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316170149.4106586-1-jolsa@kernel.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test attaches bpf program to sched_process_exec tracepoint
and gets build of executed file from bprm->file object.

We use urandom_read as the test program and in addition we also
attach uprobe to liburandom_read.so:urandlib_read_without_sema
and retrieve and check build id of that shared library.

Also executing the no_build_id binary to verify the bpf program
gets the error properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  7 +-
 tools/testing/selftests/bpf/no_build_id.c     |  6 ++
 .../selftests/bpf/prog_tests/file_build_id.c  | 98 +++++++++++++++++++
 .../selftests/bpf/progs/file_build_id.c       | 70 +++++++++++++
 tools/testing/selftests/bpf/test_progs.h      | 10 ++
 5 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/no_build_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55811c448eb7..cf93a23c7962 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -88,7 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features
 
-TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
+TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file $(OUTPUT)/no_build_id
 TEST_GEN_FILES += liburandom_read.so
 
 # Emit succinct information message describing current building step
@@ -201,6 +201,10 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 		  $< -o $@ \
 		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
+$(OUTPUT)/no_build_id: no_build_id.c
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $^ -Wl,--build-id=none -o $@
+
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
@@ -564,6 +568,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
+		       $(OUTPUT)/no_build_id				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
diff --git a/tools/testing/selftests/bpf/no_build_id.c b/tools/testing/selftests/bpf/no_build_id.c
new file mode 100644
index 000000000000..a6f28f1c06d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/no_build_id.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+int main(void)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/file_build_id.c b/tools/testing/selftests/bpf/prog_tests/file_build_id.c
new file mode 100644
index 000000000000..cb233cfd58cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_build_id.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <unistd.h>
+#include <test_progs.h>
+#include "file_build_id.skel.h"
+#include "trace_helpers.h"
+
+static void
+test_build_id(const char *bin, const char *lib, long bin_err, long lib_err)
+{
+	int err, child_pid = 0, child_status, c = 1, sz;
+	char build_id[BPF_BUILD_ID_SIZE];
+	struct file_build_id *skel;
+	int go[2] = { -1, -1 };
+
+	if (!ASSERT_OK(pipe(go), "pipe"))
+		return;
+
+	skel = file_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "file_build_id__open_and_load"))
+		goto out;
+
+	child_pid = fork();
+	if (child_pid < 0)
+		goto out;
+
+	/* child */
+	if (child_pid == 0) {
+		close(go[1]);
+		/* wait for parent's pid update */
+		err = read(go[0], &c, 1);
+		if (!ASSERT_EQ(err, 1, "child_read_pipe"))
+			exit(err);
+
+		execle(bin, bin, NULL, NULL);
+		exit(errno);
+	}
+
+	/* parent, update child's pid and kick it */
+	skel->bss->pid = child_pid;
+
+	close(go[0]);
+
+	err = file_build_id__attach(skel);
+	if (!ASSERT_OK(err, "file_build_id__attach"))
+		goto out;
+
+	err = write(go[1], &c, 1);
+	if (!ASSERT_EQ(err, 1, "child_write_pipe"))
+		goto out;
+
+	/* wait for child to exit */
+	waitpid(child_pid, &child_status, 0);
+	child_pid = 0;
+	if (!ASSERT_EQ(WEXITSTATUS(child_status), 0, "child_exit_value"))
+		goto out;
+
+	/* test binary */
+	sz = read_build_id(bin, build_id);
+	err = sz > 0 ? 0 : sz;
+
+	ASSERT_EQ((long) err, bin_err, "read_build_id_bin_err");
+	ASSERT_EQ(skel->bss->build_id_bin_err, bin_err, "build_id_bin_err");
+
+	if (!err) {
+		ASSERT_EQ(skel->bss->build_id_bin_size, sz, "build_id_bin_size");
+		ASSERT_MEMEQ(skel->bss->build_id_bin, build_id, sz, "build_id_bin");
+	}
+
+	/* test library if present */
+	if (lib) {
+		sz = read_build_id(lib, build_id);
+		err = sz > 0 ? 0 : sz;
+
+		ASSERT_EQ((long) err, lib_err, "read_build_id_lib_err");
+		ASSERT_EQ(skel->bss->build_id_lib_err, lib_err, "build_id_lib_err");
+
+		if (!err) {
+			ASSERT_EQ(skel->bss->build_id_lib_size, sz, "build_id_lib_size");
+			ASSERT_MEMEQ(skel->bss->build_id_lib, build_id, sz, "build_id_lib");
+		}
+	}
+
+out:
+	close(go[1]);
+	close(go[0]);
+	if (child_pid)
+		waitpid(child_pid, &child_status, 0);
+	file_build_id__destroy(skel);
+}
+
+void test_file_build_id(void)
+{
+	if (test__start_subtest("present"))
+		test_build_id("./urandom_read", "./liburandom_read.so", 0, 0);
+	if (test__start_subtest("missing"))
+		test_build_id("./no_build_id", NULL, -EINVAL, 0);
+}
diff --git a/tools/testing/selftests/bpf/progs/file_build_id.c b/tools/testing/selftests/bpf/progs/file_build_id.c
new file mode 100644
index 000000000000..6dc10c8e17ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_build_id.c
@@ -0,0 +1,70 @@
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
+char build_id_bin[BUILD_ID_SIZE_MAX];
+char build_id_lib[BUILD_ID_SIZE_MAX];
+
+long build_id_bin_err;
+long build_id_lib_err;
+
+static int store_build_id(struct file *file, char *build_id, u32 *sz, long *err)
+{
+	struct build_id *bid;
+
+	bid = file->f_build_id;
+	if (IS_ERR_OR_NULL(bid)) {
+		*err = PTR_ERR(bid);
+		return 0;
+	}
+	*sz = bid->sz;
+	if (bid->sz > sizeof(bid->data)) {
+		*err = 1;
+		return 0;
+	}
+	__builtin_memcpy(build_id, bid->data, sizeof(bid->data));
+	*err = 0;
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
+	if (!bprm->file)
+		return 0;
+	return store_build_id(bprm->file, build_id_bin, &build_id_bin_size, &build_id_bin_err);
+}
+
+static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
+		      void *data)
+{
+	if (!vma || !vma->vm_file || !vma->vm_file)
+		return 0;
+	return store_build_id(vma->vm_file, build_id_lib, &build_id_lib_size, &build_id_lib_err);
+}
+
+SEC("uprobe/./liburandom_read.so:urandlib_read_without_sema")
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
index d91427bfe0d7..285dd5d91426 100644
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

