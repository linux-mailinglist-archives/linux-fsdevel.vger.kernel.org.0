Return-Path: <linux-fsdevel+bounces-33175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD609B5698
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BF1F233F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFF120C48C;
	Tue, 29 Oct 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5nMYoz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380320BB41;
	Tue, 29 Oct 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243616; cv=none; b=Xq9LBhTxLoyiWRUXPLE9HGlBILi2dGWtYiR9FuDFGnMP2Cqma8iLZsXg0ryJif6DhKjAMTKj7KY/twBe7QfUvxi1B1u4u0SD0Z3gb3hfzvDAlS6LBromLYVM1BlBzsGCkfoYcVE6LMA0U+U6U+f/wieEO+4TpwCX8/MST7Tr/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243616; c=relaxed/simple;
	bh=Dm2s2fcTkM92SSMD+7Lh75bKhbJpwc+561tVJlj3PmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utJsND+Ebi6+WC04rVmCl4rh04qqe+kC0hycoNJVuWu+EDOBIfp5n7f2uUfkZKwFzbQJGB55vY5FVuiUzn1sQ7bgPK0Kp8eGJmvPIk+fb4715xdg1uj3NMOzzcCN12eGhcbkH869rKWHpVhbxSTGukbBww8oB+YNFgX4SxfPRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5nMYoz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA87C4CEE3;
	Tue, 29 Oct 2024 23:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243615;
	bh=Dm2s2fcTkM92SSMD+7Lh75bKhbJpwc+561tVJlj3PmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5nMYoz+gETFkkdLvPuISJZxuGfbwh/bmg2t6I1tUY/mSFb5h2uJHJ6Z2hJ1RTL9E
	 pwXlSy6BiydxduzLn0wBCLeRNZuhaSnhuFhnWqwFScluV3f6OCf3oBMh0LsZWQrcUD
	 +Ot3XM/HCeiKJW1E7i+qJkWTCV9BnJ4pmNgRIkkbhZx1KZGUysy6KVlxrG6NO1ZP3c
	 TaXqv1j4UHMTiHpehTTiHUqr+4kiZl93Zp0myyZNDWJJGBeTkDvRykF0rZvMaAkI7S
	 c4mN6oeOIX19qpbgKYv0k6SHI8LP1L8zuo//kPbnmgl11ZrhcsD9iHOjBpi+BpmqaW
	 QCT9M3QUSgl0w==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	Song Liu <song@kernel.org>
Subject: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF based fanotify fastpath handler
Date: Tue, 29 Oct 2024 16:12:44 -0700
Message-ID: <20241029231244.2834368-6-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029231244.2834368-1-song@kernel.org>
References: <20241029231244.2834368-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test shows a simplified logic that monitors a subtree. This is
simplified as it doesn't handle all the scenarios, such as:

  1) moving a subsubtree into/outof the being monitoring subtree;
  2) mount point inside the being monitored subtree

Therefore, this is not to show a way to reliably monitor a subtree.
Instead, this is to test the functionalities of bpf based fastpath.
To really monitor a subtree reliably, we will need more complex logic.

Overview of the logic:
  1. fanotify is created for the whole file system (/tmp);
  2. A bpf map (inode_storage_map) is used to tag directories to
     monitor (starting from /tmp/fanotify_test);
  3. On fsnotify_mkdir, thee tag is propagated to newly created sub
     directories (/tmp/fanotify_test/subdir);
  4. The bpf fastpath checks whether the fanotify event happens in a
     directory with the tag. If yes, the event is sent to user space;
     otherwise, the event is dropped.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/prog_tests/fan_fp.c | 245 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/fan_fp.c    |  77 ++++++
 4 files changed, 327 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fan_fp.c
 create mode 100644 tools/testing/selftests/bpf/progs/fan_fp.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 2eb3483f2fb0..44dcf4991244 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -87,4 +87,8 @@ struct dentry;
  */
 extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym __weak;
+
+struct fanotify_fastpath_event;
+extern struct inode *bpf_fanotify_data_inode(struct fanotify_fastpath_event *event) __ksym __weak;
+extern void bpf_iput(struct inode *inode) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116..392cbcad8a8b 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -24,6 +24,7 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_FANOTIFY=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
diff --git a/tools/testing/selftests/bpf/prog_tests/fan_fp.c b/tools/testing/selftests/bpf/prog_tests/fan_fp.c
new file mode 100644
index 000000000000..ea57ed366647
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fan_fp.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/fanotify.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+
+#include <test_progs.h>
+
+#include "fan_fp.skel.h"
+
+#define TEST_FS "/tmp/"
+#define TEST_DIR "/tmp/fanotify_test/"
+
+static int create_test_subtree(void)
+{
+	int err;
+
+	err = mkdir(TEST_DIR, 0777);
+	if (err && errno != EEXIST)
+		return err;
+
+	return open(TEST_DIR, O_RDONLY);
+}
+
+static int create_fanotify_fd(void)
+{
+	int fanotify_fd, err;
+
+	fanotify_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME | FAN_REPORT_DIR_FID,
+				    O_RDONLY);
+
+	if (!ASSERT_OK_FD(fanotify_fd, "fanotify_init"))
+		return -1;
+
+	err = fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			    FAN_CREATE | FAN_OPEN | FAN_ONDIR | FAN_EVENT_ON_CHILD,
+			    AT_FDCWD, TEST_FS);
+	if (!ASSERT_OK(err, "fanotify_mark")) {
+		close(fanotify_fd);
+		return -1;
+	}
+
+	return fanotify_fd;
+}
+
+static int attach_global_fastpath(int fanotify_fd)
+{
+	struct fanotify_fastpath_args args = {
+		.name = "_tmp_test_sub_tree",
+		.version = 1,
+		.flags = 0,
+	};
+
+	if (ioctl(fanotify_fd, FAN_IOC_ADD_FP, &args))
+		return -1;
+
+	return 0;
+}
+
+#define EVENT_BUFFER_SIZE 4096
+struct file_access_result {
+	char name_prefix[16];
+	bool accessed;
+} access_results[3] = {
+	{"aa", false},
+	{"bb", false},
+	{"cc", false},
+};
+
+static void update_access_results(char *name)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		if (strstr(name, access_results[i].name_prefix))
+			access_results[i].accessed = true;
+	}
+}
+
+static void parse_event(char *buffer, int len)
+{
+	struct fanotify_event_metadata *event =
+		(struct fanotify_event_metadata *) buffer;
+	struct fanotify_event_info_header *info;
+	struct fanotify_event_info_fid *fid;
+	struct file_handle *handle;
+	char *name;
+	int off;
+
+	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
+		for (off = sizeof(*event) ; off < event->event_len;
+		     off += info->len) {
+			info = (struct fanotify_event_info_header *)
+				((char *) event + off);
+			switch (info->info_type) {
+			case FAN_EVENT_INFO_TYPE_DFID_NAME:
+				fid = (struct fanotify_event_info_fid *) info;
+				handle = (struct file_handle *)&fid->handle;
+				name = (char *)handle + sizeof(*handle) + handle->handle_bytes;
+				update_access_results(name);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+}
+
+static void touch_file(const char *path)
+{
+	int fd;
+
+	fd = open(path, O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666);
+	if (!ASSERT_OK_FD(fd, "open"))
+		goto cleanup;
+	close(fd);
+cleanup:
+	unlink(path);
+}
+
+static void generate_and_test_event(int fanotify_fd)
+{
+	char buffer[EVENT_BUFFER_SIZE];
+	int len, err;
+
+	/* access /tmp/fanotify_test/aa, this will generate event */
+	touch_file(TEST_DIR "aa");
+
+	/* create /tmp/fanotify_test/subdir, this will get tag from the
+	 * parent directory (added in the bpf program on fsnotify_mkdir)
+	 */
+	err = mkdir(TEST_DIR "subdir", 0777);
+	ASSERT_OK(err, "mkdir");
+
+	/* access /tmp/fanotify_test/subdir/bb, this will generate event */
+	touch_file(TEST_DIR "subdir/bb");
+
+	/* access /tmp/cc, this will NOT generate event, as the BPF
+	 * fastpath filtered this event out. (Because /tmp doesn't have
+	 * the tag.)
+	 */
+	touch_file(TEST_FS "cc");
+
+	/* read and parse the events */
+	len = read(fanotify_fd, buffer, EVENT_BUFFER_SIZE);
+	if (!ASSERT_GE(len, 0, "read event"))
+		goto cleanup;
+	parse_event(buffer, len);
+
+	/* verify we generated events for aa and bb, but filtered out the
+	 * event for cc.
+	 */
+	ASSERT_TRUE(access_results[0].accessed, "access aa");
+	ASSERT_TRUE(access_results[1].accessed, "access bb");
+	ASSERT_FALSE(access_results[2].accessed, "access cc");
+
+cleanup:
+	rmdir(TEST_DIR "subdir");
+	rmdir(TEST_DIR);
+}
+
+/* This test shows a simplified logic that monitors a subtree. This is
+ * simplified as it doesn't handle all the scenarios, such as:
+ *
+ *  1) moving a subsubtree into/outof the being monitoring subtree;
+ *  2) mount point inside the being monitored subtree
+ *
+ * Therefore, this is not to show a way to reliably monitor a subtree.
+ * Instead, this is to test the functionalities of bpf based fastpath.
+ *
+ * Overview of the logic:
+ * 1. fanotify is created for the whole file system (/tmp);
+ * 2. A bpf map (inode_storage_map) is used to tag directories to
+ *    monitor (starting from /tmp/fanotify_test);
+ * 3. On fsnotify_mkdir, thee tag is propagated to newly created sub
+ *    directories (/tmp/fanotify_test/subdir);
+ * 4. The bpf fastpath checks whether the event happens in a directory
+ *    with the tag. If yes, the event is sent to user space; otherwise,
+ *    the event is dropped.
+ */
+static void test_monitor_subtree(void)
+{
+	struct bpf_link *link;
+	struct fan_fp *skel;
+	int test_root_fd;
+	__u32 one = 1;
+	int err, fanotify_fd;
+
+	test_root_fd = create_test_subtree();
+
+	if (!ASSERT_OK_FD(test_root_fd, "create_test_subtree"))
+		return;
+
+	skel = fan_fp__open_and_load();
+
+	if (!ASSERT_OK_PTR(skel, "fan_fp__open_and_load"))
+		goto close_test_root_fd;
+
+	/* Add tag to /tmp/fanotify_test/ */
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.inode_storage_map),
+				  &test_root_fd, &one, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto destroy_skel;
+	link = bpf_map__attach_struct_ops(skel->maps.bpf_fanotify_fastpath_ops);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto destroy_skel;
+
+
+	fanotify_fd = create_fanotify_fd();
+	if (!ASSERT_OK_FD(fanotify_fd, "create_fanotify_fd"))
+		goto destroy_link;
+
+	err = attach_global_fastpath(fanotify_fd);
+	if (!ASSERT_OK(err, "attach_global_fastpath"))
+		goto close_fanotify_fd;
+
+	generate_and_test_event(fanotify_fd);
+
+	ASSERT_EQ(skel->bss->added_inode_storage, 1, "added_inode_storage");
+
+close_fanotify_fd:
+	close(fanotify_fd);
+
+destroy_link:
+	bpf_link__destroy(link);
+destroy_skel:
+	fan_fp__destroy(skel);
+
+close_test_root_fd:
+	close(test_root_fd);
+	rmdir(TEST_DIR);
+}
+
+void test_bpf_fanotify_fastpath(void)
+{
+	if (test__start_subtest("subtree"))
+		test_monitor_subtree();
+}
diff --git a/tools/testing/selftests/bpf/progs/fan_fp.c b/tools/testing/selftests/bpf/progs/fan_fp.c
new file mode 100644
index 000000000000..ee86dc189e38
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fan_fp.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define FS_CREATE		0x00000100	/* Subfile was created */
+#define FS_ISDIR		0x40000000	/* event occurred against dir */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, __u32);
+} inode_storage_map SEC(".maps");
+
+int added_inode_storage;
+
+SEC("struct_ops")
+int BPF_PROG(bpf_fp_handler,
+	     struct fsnotify_group *group,
+	     struct fanotify_fastpath_hook *fp_hook,
+	     struct fanotify_fastpath_event *fp_event)
+{
+	struct inode *dir;
+	__u32 *value;
+
+	dir = fp_event->dir;
+
+	value = bpf_inode_storage_get(&inode_storage_map, dir, 0, 0);
+
+	/* if dir doesn't have the tag, skip the event */
+	if (!value)
+		return FAN_FP_RET_SKIP_EVENT;
+
+	/* propagate tag to subdir on fsnotify_mkdir */
+	if (fp_event->mask == (FS_CREATE | FS_ISDIR) &&
+	    fp_event->data_type == FSNOTIFY_EVENT_DENTRY) {
+		struct inode *new_inode;
+
+		new_inode = bpf_fanotify_data_inode(fp_event);
+		if (!new_inode)
+			goto out;
+
+		value = bpf_inode_storage_get(&inode_storage_map, new_inode, 0,
+					      BPF_LOCAL_STORAGE_GET_F_CREATE);
+		if (value) {
+			*value = 1;
+			added_inode_storage++;
+		}
+		bpf_iput(new_inode);
+	}
+out:
+	return FAN_FP_RET_SEND_TO_USERSPACE;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_fp_init, struct fanotify_fastpath_hook *hook, const char *args)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_fp_free, struct fanotify_fastpath_hook *hook)
+{
+}
+
+SEC(".struct_ops.link")
+struct fanotify_fastpath_ops bpf_fanotify_fastpath_ops = {
+	.fp_handler = (void *)bpf_fp_handler,
+	.fp_init = (void *)bpf_fp_init,
+	.fp_free = (void *)bpf_fp_free,
+	.name = "_tmp_test_sub_tree",
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


