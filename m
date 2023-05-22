Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF47470CF95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjEWAlJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjEVXe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 19:34:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5F118
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 16:32:16 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MMkIjL015313
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 16:32:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qpuy0qjg2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 16:32:15 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:32:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 55A77312BC0C1; Mon, 22 May 2023 16:29:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <cyphar@cyphar.com>, <brauner@kernel.org>,
        <lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests
Date:   Mon, 22 May 2023 16:29:17 -0700
Message-ID: <20230522232917.2454595-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522232917.2454595-1-andrii@kernel.org>
References: <20230522232917.2454595-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: D_dyvWX-0fB4mJnmMzg3r5iQTkCdqmPK
X-Proofpoint-GUID: D_dyvWX-0fB4mJnmMzg3r5iQTkCdqmPK
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a selftest demonstrating using detach-mounted BPF FS using new mount
APIs, and pinning and getting BPF map using such mount. This
demonstrates how something like container manager could setup BPF FS,
pin and adjust all the necessary objects in it, all before exposing BPF
FS to a particular mount namespace.

Also add a few subtests validating all meaningful combinations of
path_fd and pathname. We use mounted /sys/fs/bpf location for these.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_obj_pinning.c          | 268 ++++++++++++++++++
 1 file changed, 268 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
new file mode 100644
index 000000000000..31f1e815f671
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/unistd.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+
+static inline int sys_fsopen(const char *fsname, unsigned flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fsconfig(int fs_fd, unsigned cmd, const char *key, const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_flags)
+{
+	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
+}
+
+__attribute__((unused))
+static inline int sys_move_mount(int from_dfd, const char *from_path,
+			         int to_dfd, const char *to_path,
+			         unsigned int ms_flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_path, to_dfd, to_path, ms_flags);
+}
+
+static void bpf_obj_pinning_detached(void)
+{
+	LIBBPF_OPTS(bpf_obj_pin_opts, pin_opts);
+	LIBBPF_OPTS(bpf_obj_get_opts, get_opts);
+	int fs_fd = -1, mnt_fd = -1;
+	int map_fd = -1, map_fd2 = -1;
+	int zero = 0, src_value, dst_value, err;
+	const char *map_name = "fsmount_map";
+
+	/* A bunch of below UAPI calls are constructed based on reading:
+	 * https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html
+	 */
+
+	/* create VFS context */
+	fs_fd = sys_fsopen("bpf", 0);
+	if (!ASSERT_GE(fs_fd, 0, "fs_fd"))
+		goto cleanup;
+
+	/* instantiate FS object */
+	err = sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (!ASSERT_OK(err, "fs_create"))
+		goto cleanup;
+
+	/* create O_PATH fd for detached mount */
+	mnt_fd = sys_fsmount(fs_fd, 0, 0);
+	if (!ASSERT_GE(mnt_fd, 0, "mnt_fd"))
+		goto cleanup;
+
+	/* If we wanted to expose detached mount in the file system, we'd do
+	 * something like below. But the whole point is that we actually don't
+	 * even have to expose BPF FS in the file system to be able to work
+	 * (pin/get objects) with it.
+	 *
+	 * err = sys_move_mount(mnt_fd, "", -EBADF, mnt_path, MOVE_MOUNT_F_EMPTY_PATH);
+	 * if (!ASSERT_OK(err, "move_mount"))
+	 *	goto cleanup;
+	 */
+
+	/* create BPF map to pin */
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, map_name, 4, 4, 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "map_fd"))
+		goto cleanup;
+
+	/* pin BPF map into detached BPF FS through mnt_fd */
+	pin_opts.file_flags = BPF_F_PATH_FD;
+	pin_opts.path_fd = mnt_fd;
+	err = bpf_obj_pin_opts(map_fd, map_name, &pin_opts);
+	if (!ASSERT_OK(err, "map_pin"))
+		goto cleanup;
+
+	/* get BPF map from detached BPF FS through mnt_fd */
+	get_opts.file_flags = BPF_F_PATH_FD;
+	get_opts.path_fd = mnt_fd;
+	map_fd2 = bpf_obj_get_opts(map_name, &get_opts);
+	if (!ASSERT_GE(map_fd2, 0, "map_get"))
+		goto cleanup;
+
+	/* update map through one FD */
+	src_value = 0xcafebeef;
+	err = bpf_map_update_elem(map_fd, &zero, &src_value, 0);
+	ASSERT_OK(err, "map_update");
+
+	/* check values written/read through different FDs do match */
+	dst_value = 0;
+	err = bpf_map_lookup_elem(map_fd2, &zero, &dst_value);
+	ASSERT_OK(err, "map_lookup");
+	ASSERT_EQ(dst_value, src_value, "map_value_eq1");
+	ASSERT_EQ(dst_value, 0xcafebeef, "map_value_eq2");
+
+cleanup:
+	if (map_fd >= 0)
+		ASSERT_OK(close(map_fd), "close_map_fd");
+	if (map_fd2 >= 0)
+		ASSERT_OK(close(map_fd2), "close_map_fd2");
+	if (fs_fd >= 0)
+		ASSERT_OK(close(fs_fd), "close_fs_fd");
+	if (mnt_fd >= 0)
+		ASSERT_OK(close(mnt_fd), "close_mnt_fd");
+}
+
+enum path_kind
+{
+	PATH_STR_ABS,
+	PATH_STR_REL,
+	PATH_FD_REL,
+};
+
+static void validate_pin(int map_fd, const char *map_name, int src_value,
+			 enum path_kind path_kind)
+{
+	LIBBPF_OPTS(bpf_obj_pin_opts, pin_opts);
+	char abs_path[PATH_MAX], old_cwd[PATH_MAX];
+	const char *pin_path = NULL;
+	int zero = 0, dst_value, map_fd2, err;
+
+	snprintf(abs_path, sizeof(abs_path), "/sys/fs/bpf/%s", map_name);
+	old_cwd[0] = '\0';
+
+	switch (path_kind) {
+	case PATH_STR_ABS:
+		/* absolute path */
+		pin_path = abs_path;
+		break;
+	case PATH_STR_REL:
+		/* cwd + relative path */
+		ASSERT_OK_PTR(getcwd(old_cwd, sizeof(old_cwd)), "getcwd");
+		ASSERT_OK(chdir("/sys/fs/bpf"), "chdir");
+		pin_path = map_name;
+		break;
+	case PATH_FD_REL:
+		/* dir fd + relative path */
+		pin_opts.file_flags = BPF_F_PATH_FD;
+		pin_opts.path_fd = open("/sys/fs/bpf", O_PATH);
+		ASSERT_GE(pin_opts.path_fd, 0, "path_fd");
+		pin_path = map_name;
+		break;
+	}
+
+	/* pin BPF map using specified path definition */
+	err = bpf_obj_pin_opts(map_fd, pin_path, &pin_opts);
+	ASSERT_OK(err, "obj_pin");
+
+	/* cleanup */
+	if (pin_opts.path_fd >= 0)
+		close(pin_opts.path_fd);
+	if (old_cwd[0])
+		ASSERT_OK(chdir(old_cwd), "restore_cwd");
+
+	map_fd2 = bpf_obj_get(abs_path);
+	if (!ASSERT_GE(map_fd2, 0, "map_get"))
+		goto cleanup;
+
+	/* update map through one FD */
+	err = bpf_map_update_elem(map_fd, &zero, &src_value, 0);
+	ASSERT_OK(err, "map_update");
+
+	/* check values written/read through different FDs do match */
+	dst_value = 0;
+	err = bpf_map_lookup_elem(map_fd2, &zero, &dst_value);
+	ASSERT_OK(err, "map_lookup");
+	ASSERT_EQ(dst_value, src_value, "map_value_eq");
+cleanup:
+	if (map_fd2 >= 0)
+		ASSERT_OK(close(map_fd2), "close_map_fd2");
+	unlink(abs_path);
+}
+
+static void validate_get(int map_fd, const char *map_name, int src_value,
+			 enum path_kind path_kind)
+{
+	LIBBPF_OPTS(bpf_obj_get_opts, get_opts);
+	char abs_path[PATH_MAX], old_cwd[PATH_MAX];
+	const char *pin_path = NULL;
+	int zero = 0, dst_value, map_fd2, err;
+
+	snprintf(abs_path, sizeof(abs_path), "/sys/fs/bpf/%s", map_name);
+	/* pin BPF map using specified path definition */
+	err = bpf_obj_pin(map_fd, abs_path);
+	if (!ASSERT_OK(err, "pin_map"))
+		return;
+
+	old_cwd[0] = '\0';
+
+	switch (path_kind) {
+	case PATH_STR_ABS:
+		/* absolute path */
+		pin_path = abs_path;
+		break;
+	case PATH_STR_REL:
+		/* cwd + relative path */
+		ASSERT_OK_PTR(getcwd(old_cwd, sizeof(old_cwd)), "getcwd");
+		ASSERT_OK(chdir("/sys/fs/bpf"), "chdir");
+		pin_path = map_name;
+		break;
+	case PATH_FD_REL:
+		/* dir fd + relative path */
+		get_opts.file_flags = BPF_F_PATH_FD;
+		get_opts.path_fd = open("/sys/fs/bpf", O_PATH);
+		ASSERT_GE(get_opts.path_fd, 0, "path_fd");
+		pin_path = map_name;
+		break;
+	}
+
+	map_fd2 = bpf_obj_get_opts(pin_path, &get_opts);
+	if (!ASSERT_GE(map_fd2, 0, "map_get"))
+		goto cleanup;
+
+	/* cleanup */
+	if (get_opts.path_fd >= 0)
+		close(get_opts.path_fd);
+	if (old_cwd[0])
+		ASSERT_OK(chdir(old_cwd), "restore_cwd");
+
+	/* update map through one FD */
+	err = bpf_map_update_elem(map_fd, &zero, &src_value, 0);
+	ASSERT_OK(err, "map_update");
+
+	/* check values written/read through different FDs do match */
+	dst_value = 0;
+	err = bpf_map_lookup_elem(map_fd2, &zero, &dst_value);
+	ASSERT_OK(err, "map_lookup");
+	ASSERT_EQ(dst_value, src_value, "map_value_eq");
+cleanup:
+	if (map_fd2 >= 0)
+		ASSERT_OK(close(map_fd2), "close_map_fd2");
+	unlink(abs_path);
+}
+
+static void bpf_obj_pinning_mounted(enum path_kind path_kind)
+{
+	const char *map_name = "mounted_map";
+	int map_fd;
+
+	/* create BPF map to pin */
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, map_name, 4, 4, 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "map_fd"))
+		return;
+
+	validate_pin(map_fd, map_name, 100 + (int)path_kind, path_kind);
+	validate_get(map_fd, map_name, 200 + (int)path_kind, path_kind);
+	ASSERT_OK(close(map_fd), "close_map_fd");
+}
+
+void test_bpf_obj_pinning()
+{
+	if (test__start_subtest("detached"))
+		bpf_obj_pinning_detached();
+	if (test__start_subtest("mounted-str-abs"))
+		bpf_obj_pinning_mounted(PATH_STR_ABS);
+	if (test__start_subtest("mounted-str-rel"))
+		bpf_obj_pinning_mounted(PATH_STR_REL);
+	if (test__start_subtest("mounted-fd-rel"))
+		bpf_obj_pinning_mounted(PATH_FD_REL);
+}
-- 
2.34.1

