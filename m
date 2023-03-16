Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5196BD6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCPRE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCPREL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:04:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2CC2007C;
        Thu, 16 Mar 2023 10:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4E28B8227C;
        Thu, 16 Mar 2023 17:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333CFC433EF;
        Thu, 16 Mar 2023 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986219;
        bh=BTNFjFR6qedMLNKodJS0I96kmDjan/r2p24kIgmK3/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8LC/I53yNMvhKiJ3Oq2YxbSToYguXOf9YL7kJ0By7G0BvjLuZlszeTUgYFPhKnB6
         KllaisUOamvTTtPjic6nqgztIrsZwVGjjWK7vG8ozFTcCgp2HkZJ6X4LbSKvyuVkjT
         qcXbW0Ckyvbgso20/1phg1107C1gTiClR3Hj+lRcjG0M0Ki2RtZMhnjx3Mmkobv12K
         Xx2SF6Fu+XDxUx7rHArRgUS80ARKH6R5eLB3AJkRH4Tn9g3ZGexQwoFvU3DWzsHOsF
         9xxpJNXwqQRN1HimKUC14dXXfdR2JKVwCqre7Kw9d/jzAuYtlvOVeUrVxp6AMWSvzO
         Dkxo8jLgLZv+w==
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
Subject: [PATCHv3 bpf-next 8/9] selftests/bpf: Add iter_task_vma_buildid test
Date:   Thu, 16 Mar 2023 18:01:48 +0100
Message-Id: <20230316170149.4106586-9-jolsa@kernel.org>
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

Testing iterator access to build id in vma->vm_file object by storing
each binary with build id into map and checking it against build id
retrieved in user space.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 78 +++++++++++++++++++
 .../bpf/progs/bpf_iter_task_vma_buildid.c     | 56 +++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..c7dd89e7cad0 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -33,6 +33,7 @@
 #include "bpf_iter_bpf_link.skel.h"
 #include "bpf_iter_ksym.skel.h"
 #include "bpf_iter_sockmap.skel.h"
+#include "bpf_iter_task_vma_buildid.skel.h"
 
 static int duration;
 
@@ -1536,6 +1537,81 @@ static void test_task_vma_dead_task(void)
 	bpf_iter_task_vma__destroy(skel);
 }
 
+#define D_PATH_BUF_SIZE	1024
+
+struct build_id {
+	u32 sz;
+	char data[BPF_BUILD_ID_SIZE];
+};
+
+static void test_task_vma_buildid(void)
+{
+	int err, iter_fd = -1, proc_maps_fd = -1, sz;
+	struct bpf_iter_task_vma_buildid *skel;
+	char key[D_PATH_BUF_SIZE], *prev_key;
+	char build_id[BPF_BUILD_ID_SIZE];
+	int len, files_fd, cnt = 0;
+	struct build_id val;
+	char c;
+
+	skel = bpf_iter_task_vma_buildid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma_buildid__open_and_load"))
+		return;
+
+	skel->links.proc_maps = bpf_program__attach_iter(
+		skel->progs.proc_maps, NULL);
+
+	if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) {
+		skel->links.proc_maps = NULL;
+		goto out;
+	}
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.proc_maps));
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+		goto out;
+
+	/* trigger the iterator, there's no output, just map */
+	len = read(iter_fd, &c, 1);
+	ASSERT_EQ(len, 0, "len_check");
+
+	files_fd = bpf_map__fd(skel->maps.files);
+
+	prev_key = NULL;
+
+	while (true) {
+		err = bpf_map_get_next_key(files_fd, prev_key, &key);
+		if (err) {
+			if (errno == ENOENT)
+				err = 0;
+			break;
+		}
+		if (bpf_map_lookup_elem(files_fd, key, &val))
+			break;
+		if (!ASSERT_LE(val.sz, BPF_BUILD_ID_SIZE, "buildid_size"))
+			break;
+
+		sz = read_build_id(key, build_id);
+		/* If there's an error, the build id is not present or malformed, kernel
+		 * should see the same result and bpf program pushed zero build id.
+		 */
+		if (sz < 0) {
+			memset(build_id, 0x0, BPF_BUILD_ID_SIZE);
+			sz = BPF_BUILD_ID_SIZE;
+		}
+		ASSERT_EQ(val.sz, sz, "build_id_size");
+		ASSERT_MEMEQ(val.data, build_id, sz, "build_id_data");
+
+		prev_key = key;
+		cnt++;
+	}
+
+	printf("checked %d files\n", cnt);
+out:
+	close(proc_maps_fd);
+	close(iter_fd);
+	bpf_iter_task_vma_buildid__destroy(skel);
+}
+
 void test_bpf_sockmap_map_iter_fd(void)
 {
 	struct bpf_iter_sockmap *skel;
@@ -1659,6 +1735,8 @@ void test_bpf_iter(void)
 		test_task_vma();
 	if (test__start_subtest("task_vma_dead_task"))
 		test_task_vma_dead_task();
+	if (test__start_subtest("task_vma_buildid"))
+		test_task_vma_buildid();
 	if (test__start_subtest("task_btf"))
 		test_task_btf();
 	if (test__start_subtest("tcp4"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
new file mode 100644
index 000000000000..11a59c0f1aba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bpf_iter.h"
+#include "err.h"
+#include <bpf/bpf_helpers.h>
+#include <string.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define VM_EXEC		0x00000004
+#define D_PATH_BUF_SIZE	1024
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10000);
+	__type(key, char[D_PATH_BUF_SIZE]);
+	__type(value, struct build_id);
+} files SEC(".maps");
+
+static char path[D_PATH_BUF_SIZE];
+static struct build_id build_id;
+
+SEC("iter/task_vma")
+int proc_maps(struct bpf_iter__task_vma *ctx)
+{
+	struct vm_area_struct *vma = ctx->vma;
+	struct task_struct *task = ctx->task;
+	struct file *file;
+
+	if (task == (void *)0 || vma == (void *)0)
+		return 0;
+
+	if (!(vma->vm_flags & VM_EXEC))
+		return 0;
+
+	file = vma->vm_file;
+	if (!file)
+		return 0;
+
+	__builtin_memset(path, 0x0, D_PATH_BUF_SIZE);
+	bpf_d_path(&file->f_path, (char *) &path, D_PATH_BUF_SIZE);
+
+	if (bpf_map_lookup_elem(&files, &path))
+		return 0;
+
+	if (IS_ERR_OR_NULL(file->f_build_id)) {
+		/* On error return empty build id. */
+		__builtin_memset(&build_id.data, 0x0, sizeof(build_id.data));
+		build_id.sz = BUILD_ID_SIZE_MAX;
+	} else {
+		__builtin_memcpy(&build_id, file->f_build_id, sizeof(*file->f_build_id));
+	}
+
+	bpf_map_update_elem(&files, &path, &build_id, 0);
+	return 0;
+}
-- 
2.39.2

