Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB236A55EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjB1Jef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjB1JeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:34:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1561CF52;
        Tue, 28 Feb 2023 01:34:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F0C61027;
        Tue, 28 Feb 2023 09:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555D7C433EF;
        Tue, 28 Feb 2023 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576849;
        bh=GuLnU0d3k2V6ZdWnoPW82USn52Mxiiw398+O8RnbxjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUEbZG/k7LV/1mLXHeWWy8ByEFwfH8vr4ZFgj6lyjUX85YnoF9O+2SNLVfQ+BFZCK
         /C8zbSyBs0+Fgcg9S3mJ2CLktdsdjmUgSUhzqdyNcv7ycvIZ0OCbJwonyDI4shyNV5
         ftTQF6r5HRAVPTY6qSwaMbTC+jiQDAFlvQxjT/tlM2rrxAwhsV4dC4XBD980wAL+mb
         tJpPPKnthTlBdWX5SGZewGddSsBTsAMcdvfZrdMbLb3WEcdYd1omjU9JoHFl2ZgqeI
         OJuG5BHYKrQ+D9+Yy/tYafMvA1FOw/NB91C6UneYdz+M7WN7WxroH3DaZIK9AeKVf7
         ICF2YvbB5G38w==
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
Subject: [PATCH RFC v2 bpf-next 9/9] selftests/bpf: Add iter_task_vma_buildid test
Date:   Tue, 28 Feb 2023 10:32:06 +0100
Message-Id: <20230228093206.821563-10-jolsa@kernel.org>
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

Testing iterator access to build id in vma->vm_file->f_inode
object by storing each binary with buildid into map and checking
it against buildid retrieved in user space.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 78 +++++++++++++++++++
 .../bpf/progs/bpf_iter_task_vma_buildid.c     | 60 ++++++++++++++
 2 files changed, 138 insertions(+)
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
index 000000000000..dc528a4783ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
@@ -0,0 +1,60 @@
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
+	struct seq_file *seq = ctx->meta->seq;
+	struct task_struct *task = ctx->task;
+	unsigned long file_key;
+	struct inode *inode;
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
+	inode = file->f_inode;
+	if (IS_ERR_OR_NULL(inode->i_build_id)) {
+		/* On error return empty build id. */
+		__builtin_memset(&build_id.data, 0x0, sizeof(build_id.data));
+		build_id.sz = 20;
+	} else {
+		__builtin_memcpy(&build_id, inode->i_build_id, sizeof(*inode->i_build_id));
+	}
+
+	bpf_map_update_elem(&files, &path, &build_id, 0);
+	return 0;
+}
-- 
2.39.2

