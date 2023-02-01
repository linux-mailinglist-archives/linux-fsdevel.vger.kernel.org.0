Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB516867C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjBAN7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjBAN64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:58:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFCB9743;
        Wed,  1 Feb 2023 05:58:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB38617BA;
        Wed,  1 Feb 2023 13:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA6EC433EF;
        Wed,  1 Feb 2023 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675259914;
        bh=9vGidv5KK+VK6x+sZbtxgG6kbbBhATOZQnveCyOWlzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJ3SKUrQ3KRicKqjZGSlmATsqBY/2uxl+ittryw9F94qxr3IHhp8yiAmNVgZV4F28
         BvIzPZXif+N2jAVTa87Q4OyhJ+2kVDPKOU/IfJHNjiICJ3BTzDoCKr81v0+8jZF2/3
         tyG7KooQLVd33ycGsDNsM+PVm4rVb8RcSASZfDR52CRsHXcm23iTtf32iutEA3ibfw
         mw2MTKI3hM/tHgLmqSy652HghxvCdCrkKNsbVbt5x3rkV5FjD4Jg+YJvC+SdbAj0nR
         i3tcDShTPNAaM96Nt1HVkQOA9p15tNuJ5D77H274EWMbGtBD12KW7WqTpQGtJ9TkDo
         L9AEDZVsw0XpA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC 4/5] selftests/bpf: Add file_build_id test
Date:   Wed,  1 Feb 2023 14:57:36 +0100
Message-Id: <20230201135737.800527-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
References: <20230201135737.800527-1-jolsa@kernel.org>
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
and gets build of executed file from bprm->file object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/file_build_id.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/file_build_id.c       | 34 +++++++++
 tools/testing/selftests/bpf/trace_helpers.c   | 35 ++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  1 +
 4 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c

diff --git a/tools/testing/selftests/bpf/prog_tests/file_build_id.c b/tools/testing/selftests/bpf/prog_tests/file_build_id.c
new file mode 100644
index 000000000000..a7b6307cc0f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_build_id.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <unistd.h>
+#include <test_progs.h>
+#include "file_build_id.skel.h"
+#include "trace_helpers.h"
+
+#define BUILDID_STR_SIZE (BPF_BUILD_ID_SIZE*2 + 1)
+
+void test_file_build_id(void)
+{
+	int go[2], err, child_pid, child_status, c = 1, i;
+	char bpf_build_id[BUILDID_STR_SIZE] = {};
+	struct file_build_id *skel;
+	char *bid = NULL;
+
+	skel = file_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "file_build_id__open_and_load"))
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
+		execle("/bin/bash", "bash", "-c", "exit 0", NULL, NULL);
+		exit(errno);
+	}
+
+	/* parent, update child's pid and kick it */
+	skel->bss->pid = child_pid;
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
+	if (!ASSERT_EQ(WEXITSTATUS(child_status), 0, "child_exit_value"))
+		goto out;
+
+	if (!ASSERT_OK(read_buildid("/bin/bash", &bid), "read_buildid"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->build_id_size, strlen(bid)/2, "build_id_size");
+
+	/* Convert bpf build id to string, so we can compare it later. */
+	for (i = 0; i < skel->bss->build_id_size; i++) {
+		sprintf(bpf_build_id + i*2, "%02x",
+			(unsigned char) skel->bss->build_id[i]);
+	}
+	ASSERT_STREQ(bpf_build_id, bid, "build_id_data");
+
+out:
+	file_build_id__destroy(skel);
+	free(bid);
+}
diff --git a/tools/testing/selftests/bpf/progs/file_build_id.c b/tools/testing/selftests/bpf/progs/file_build_id.c
new file mode 100644
index 000000000000..639a7217a927
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_build_id.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/string.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+u32 build_id_size;
+char build_id[20];
+
+SEC("tp_btf/sched_process_exec")
+int BPF_PROG(prog, struct task_struct *p, pid_t old_pid, struct linux_binprm *bprm)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct build_id *bid;
+
+	if (pid != cur_pid)
+		return 0;
+
+	if (!bprm->file || !bprm->file->f_bid)
+		return 0;
+
+	bid = bprm->file->f_bid;
+	build_id_size = bid->sz;
+
+	if (build_id_size > 20)
+		return 0;
+
+	memcpy(build_id, bid->data, 20);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 09a16a77bae4..f5557890e383 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -9,6 +9,7 @@
 #include <poll.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
+#include <linux/limits.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
 
@@ -230,3 +231,37 @@ ssize_t get_rel_offset(uintptr_t addr)
 	fclose(f);
 	return -EINVAL;
 }
+
+int read_buildid(const char *path, char **build_id)
+{
+	char tmp[] = "/tmp/dataXXXXXX";
+	char buf[PATH_MAX + 200];
+	int err, fd;
+	FILE *f;
+
+	fd = mkstemp(tmp);
+	if (fd == -1)
+		return -1;
+	close(fd);
+
+	snprintf(buf, sizeof(buf),
+		"readelf -n %s 2>/dev/null | grep 'Build ID' | awk '{print $3}' > %s",
+		path, tmp);
+
+	err = system(buf);
+	if (err)
+		goto out;
+
+	f = fopen(tmp, "r");
+	if (f) {
+		if (fscanf(f, "%ms$*\n", build_id) != 1) {
+			*build_id = NULL;
+			err = -1;
+		}
+		fclose(f);
+	}
+
+out:
+	unlink(tmp);
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 53efde0e2998..1a38c808b6c2 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -23,4 +23,5 @@ void read_trace_pipe(void);
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 
+int read_buildid(const char *path, char **build_id);
 #endif
-- 
2.39.1

