Return-Path: <linux-fsdevel+bounces-34747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CF9C851A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A9E1F221AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC91F8F17;
	Thu, 14 Nov 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI3AJpw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F71F76AC;
	Thu, 14 Nov 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573898; cv=none; b=VYu5q0QVbRObGVkoY4Z+IZ4k7xYBFEla+LS6IDH1/FtY76nWp3JbhvzAaJIYFbM2oT5GPExDqBNl1CdO/5fkxpLyqulbF87xKaJdSqTlHH3a5j0B7XVQUAYz08Qj2VU3JOhqV4OFWR9QL9T0zzA6sZVhyvtcgVOMNEc9J0uTIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573898; c=relaxed/simple;
	bh=28xo/GcqXu7Noex43IdCT3nlsYOlGRCmbcULqotFvGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRNt5e4MLFRmXzBTqa4AefNEX1ju6U3G22UnDOvntle+32COSBrabD5YnZSsbWf2WOzopBDcDrbk45P+xYoaWc7ae/VMSkLwPtgh6AM6fgzoe5B/rRc+GoLe74Ou41a6rTnR0TSgmsT0CrAJzbFqJAh9kMyC0zoiqhe7XzqYk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI3AJpw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C055DC4CECD;
	Thu, 14 Nov 2024 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573898;
	bh=28xo/GcqXu7Noex43IdCT3nlsYOlGRCmbcULqotFvGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GI3AJpw4RFNXyKxSygIHCED2Kcme73S6J79kzh92/qStihHmAyX4Imu63z8x4UFeC
	 mE817jtgRr4FjyaOyNHZnna9X69S1QYMsO+zDmaz7myxEQGU+pJwvf1CIRBWbinL8e
	 yUgqeFZqYtCGphTg8k2s2UM48aW+bU0RCTPUEvo1RgONoVKWRRSok9116miCA5gbVK
	 cBvGj8cPD8+zvcq5dfA9tojignWFQNzXnrzyOp2GdjKv05ktI/201cnV7QZZ2Vj9ZB
	 X8WKJTpD/Fp9j+powCd7jhXziX0blEZUZutNng6/zbSpC4WN11HOd2WuvZXlLy6AMk
	 aGVE8AufzG8yg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
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
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for BPF based fanotify fastpath handler
Date: Thu, 14 Nov 2024 00:43:45 -0800
Message-ID: <20241114084345.1564165-8-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084345.1564165-1-song@kernel.org>
References: <20241114084345.1564165-1-song@kernel.org>
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
  1. fanotify is created for the whole file system (/tmp).
  2. dentry of the subtree root is saved in map subtree_root.
  3. bpf_is_subdir() is used to check whether a fanotify event happens
     inside the subtree. Only events happened in the subtree are passed
     to userspace.
  4. A bpf map (inode_storage_map) is used to cache result from
     bpf_is_subdir().
  5. subsubtree moving is not handled. This is because we don't yet have
     a good way to walk a subtree from BPF (something similar to d_walk).

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 tools/testing/selftests/bpf/config            |   2 +
 .../testing/selftests/bpf/prog_tests/fan_fp.c | 264 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/fan_fp.c    | 154 ++++++++++
 4 files changed, 425 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fan_fp.c
 create mode 100644 tools/testing/selftests/bpf/progs/fan_fp.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 2eb3483f2fb0..6ccfef9685e1 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -87,4 +87,9 @@ struct dentry;
  */
 extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym __weak;
+
+struct fanotify_fastpath_event;
+extern struct inode *bpf_fanotify_data_inode(struct fanotify_fastpath_event *event) __ksym __weak;
+extern void bpf_iput(struct inode *inode) __ksym __weak;
+extern bool bpf_is_subdir(struct dentry *new_dentry, struct dentry *old_dentry) __ksym __weak;
 #endif
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116..505327f53f07 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -24,6 +24,8 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_FANOTIFY=y
+CONFIG_FANOTIFY_FASTPATH=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
diff --git a/tools/testing/selftests/bpf/prog_tests/fan_fp.c b/tools/testing/selftests/bpf/prog_tests/fan_fp.c
new file mode 100644
index 000000000000..92929b811282
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fan_fp.c
@@ -0,0 +1,264 @@
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
+	for (i = 0; i < ARRAY_SIZE(access_results); i++) {
+		if (strcmp(name, access_results[i].name_prefix) == 0)
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
+static void generate_and_test_event(int fanotify_fd, struct fan_fp *skel)
+{
+	char buffer[EVENT_BUFFER_SIZE];
+	int len, err, fd;
+
+	/* Open the dir, so initialize_subdir_root can work */
+	fd = open(TEST_DIR, O_RDONLY);
+	close(fd);
+
+	if (!ASSERT_EQ(skel->bss->initialized, true, "initialized"))
+		goto cleanup;
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
+	/* Each touch_file() generates two events: FAN_CREATE then
+	 * FAN_OPEN. The second event will hit cache.
+	 * open(TEST_DIR) also hit cache, as we updated it cache for
+	 * TEST_DIR from userspace.
+	 * Therefore, we expect 4 cache hits: aa, bb, cc, and TEST_DIR.
+	 */
+	ASSERT_EQ(skel->bss->cache_hit, 4, "cache_hit");
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
+	int zero = 0;
+	int err, fanotify_fd;
+	struct stat st;
+
+	test_root_fd = create_test_subtree();
+
+	if (!ASSERT_OK_FD(test_root_fd, "create_test_subtree"))
+		return;
+
+	err = fstat(test_root_fd, &st);
+	if (!ASSERT_OK(err, "fstat test_root_fd"))
+		goto close_test_root_fd;
+
+	skel = fan_fp__open_and_load();
+
+	if (!ASSERT_OK_PTR(skel, "fan_fp__open_and_load"))
+		goto close_test_root_fd;
+
+	skel->bss->root_ino = st.st_ino;
+
+	/* Add tag to /tmp/fanotify_test/ */
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.inode_storage_map),
+				  &test_root_fd, &zero, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto destroy_skel;
+	link = bpf_map__attach_struct_ops(skel->maps.bpf_fanotify_fastpath_ops);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto destroy_skel;
+
+	fanotify_fd = create_fanotify_fd();
+	if (!ASSERT_OK_FD(fanotify_fd, "create_fanotify_fd"))
+		goto destroy_link;
+
+	err = attach_global_fastpath(fanotify_fd);
+	if (!ASSERT_OK(err, "attach_global_fastpath"))
+		goto close_fanotify_fd;
+
+	generate_and_test_event(fanotify_fd, skel);
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
index 000000000000..97e7d0b9e644
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fan_fp.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+struct __dentry_kptr_value {
+	struct dentry __kptr * dentry;
+};
+
+/* subdir_root map holds a single dentry pointer to the subtree root.
+ * This pointer is used to call bpf_is_subdir().
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __dentry_kptr_value);
+	__uint(max_entries, 1);
+} subdir_root SEC(".maps");
+
+/* inode_storage_map serves as cache for bpf_is_subdir(). inode local
+ * storage has O(1) access time. So this is preferred over calling
+ * bpf_is_subdir().
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} inode_storage_map SEC(".maps");
+
+unsigned long root_ino;
+bool initialized;
+
+/* This function initialize map subdir_root. The logic is a bit ungly.
+ * First, user space sets root_ino. Then a fanotify event is triggered.
+ * If the event dentry matches root_ino, we take a reference on the
+ * dentry and save it in subdir_root map. The reference will be freed on
+ * the termination of subdir_root map.
+ */
+static void initialize_subdir_root(struct fanotify_fastpath_event *fp_event)
+{
+	struct __dentry_kptr_value *v;
+	struct dentry *dentry, *old;
+	int zero = 0;
+
+	if (initialized)
+		return;
+
+	dentry = bpf_fanotify_data_dentry(fp_event);
+	if (!dentry)
+		return;
+
+	if (dentry->d_inode->i_ino != root_ino) {
+		bpf_dput(dentry);
+		return;
+	}
+
+	v = bpf_map_lookup_elem(&subdir_root, &zero);
+	if (!v) {
+		bpf_dput(dentry);
+		return;
+	}
+
+	old = bpf_kptr_xchg(&v->dentry, dentry);
+	if (old)
+		bpf_dput(old);
+	initialized = true;
+}
+
+int cache_hit;
+
+/* bpf_fp_handler is sleepable, as it calls bpf_dput() */
+SEC("struct_ops.s")
+int BPF_PROG(bpf_fp_handler,
+	     struct fsnotify_group *group,
+	     struct fanotify_fastpath_hook *fp_hook,
+	     struct fanotify_fastpath_event *fp_event)
+{
+	struct __dentry_kptr_value *v;
+	struct dentry *dentry;
+	int zero = 0;
+	int *value;
+	int ret;
+
+	initialize_subdir_root(fp_event);
+
+	/* Before the subdir_root map is initialized, send all events to
+	 * user space.
+	 */
+	if (!initialized)
+		return FAN_FP_RET_SEND_TO_USERSPACE;
+
+	dentry = bpf_fanotify_data_dentry(fp_event);
+	if (!dentry)
+		return FAN_FP_RET_SEND_TO_USERSPACE;
+
+	/* If inode_storage_map has cached value, just return it */
+	value = bpf_inode_storage_get(&inode_storage_map, dentry->d_inode, 0, 0);
+	if (value) {
+		bpf_dput(dentry);
+		cache_hit++;
+		return *value;
+	}
+
+	/* Hold rcu read lock for bpf_is_subdir */
+	bpf_rcu_read_lock();
+	v = bpf_map_lookup_elem(&subdir_root, &zero);
+	if (!v || !v->dentry) {
+		/* This shouldn't happen, but we need this to pass
+		 * the verifier.
+		 */
+		ret = FAN_FP_RET_SEND_TO_USERSPACE;
+		goto out;
+	}
+
+	if (bpf_is_subdir(dentry, v->dentry))
+		ret = FAN_FP_RET_SEND_TO_USERSPACE;
+	else
+		ret = FAN_FP_RET_SKIP_EVENT;
+out:
+	bpf_rcu_read_unlock();
+
+	/* Save current result to the inode_storage_map */
+	value = bpf_inode_storage_get(&inode_storage_map, dentry->d_inode, 0,
+				      BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (value)
+		*value = ret;
+	bpf_dput(dentry);
+	return ret;
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


