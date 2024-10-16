Return-Path: <linux-fsdevel+bounces-32069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22969A0230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E71285FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95371C4A1C;
	Wed, 16 Oct 2024 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As0Rb8I6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF82433CE;
	Wed, 16 Oct 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062620; cv=none; b=jwgtKJ4pVJXf9DnFaXEWqCN0nZx97EU8aVlKirEubFaMUAGqnY8rPuV461naKhKp10WbGtJaZK6/W5XIgeDrip6oJ97lOFolgWwPEXc49uQU2WRVvB1Qzoq7CZFJ/3bvrRnuo1Bt2PNctpzXseo/vuaYbv9+D2AXlG9J7QlHFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062620; c=relaxed/simple;
	bh=nxakek7sL8xSsKVj/KOi6ZNyLMe9MbAwDA2OugPeeVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpEv9nt2EcptwgpxKiHItNJFld75vblqxkcZmLfH+1ZPxnn0RKYXoFFwOdeB9B2UqCZ1hlT4JaGTQif64c3xYm2ON+TWr5AZmiuB1ON58+dNxchlFkyGh4f6vGE1RIftHOtjA8RR0QFfpQURwn7USrnttDK/XwK14iEbNfykbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As0Rb8I6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278EDC4CEC5;
	Wed, 16 Oct 2024 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729062618;
	bh=nxakek7sL8xSsKVj/KOi6ZNyLMe9MbAwDA2OugPeeVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=As0Rb8I6dDb0Stxb/0N2Fifxx+geVc2xE9QI4GcQnZI7XYmJOT8IJPnNjsgUmLlI3
	 1Anw74eII70lJoBIyQkC22lEkh6rm/yqQ2ZPPd+6LTMmOyqTHhrXg/I3/gGsGoHYqC
	 ODAvfYB7n/pz3tBQPLIIq5+MmuYEuohAAk5cXaKlP+EFem2QdoMQOq2XHvqRBte+GW
	 PCEOqZv1Piex9sw7XXU73fGXjRtM+xfKUt6GrBzS0CUMf05c1mTHutDiKL79oBKT5n
	 4KG+eu5G1nfFpc5IBLef0e9BilgXk0vHYGe6G8OZJABJ7iAmy0m41ah2N+mIYbVsAe
	 eaPYMk0F8jUxQ==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to cover security.bpf xattr names
Date: Wed, 16 Oct 2024 00:09:55 -0700
Message-ID: <20241016070955.375923-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241016070955.375923-1-song@kernel.org>
References: <20241016070955.375923-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend test_progs fs_kfuncs to cover different xattr names. Specifically:
xattr name "user.kfuncs", "security.bpf", and "security.bpf.xxx" can be
read from BPF program with kfuncs bpf_get_[file|dentry]_xattr(); while
"security.bpfxxx" and "security.selinux" cannot be read.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 40 ++++++++++++++-----
 .../selftests/bpf/progs/test_get_xattr.c      | 30 ++++++++++++--
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 5a0b51157451..986dd5eabaa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -12,7 +12,7 @@
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
-static void test_xattr(void)
+static void test_get_xattr(const char *name, const char *value, bool allow_access)
 {
 	struct test_get_xattr *skel = NULL;
 	int fd = -1, err;
@@ -25,7 +25,7 @@ static void test_xattr(void)
 	close(fd);
 	fd = -1;
 
-	err = setxattr(testfile, "user.kfuncs", "hello", sizeof("hello"), 0);
+	err = setxattr(testfile, name, value, strlen(value) + 1, 0);
 	if (err && errno == EOPNOTSUPP) {
 		printf("%s:SKIP:local fs doesn't support xattr (%d)\n"
 		       "To run this test, make sure /tmp filesystem supports xattr.\n",
@@ -48,16 +48,23 @@ static void test_xattr(void)
 		goto out;
 
 	fd = open(testfile, O_RDONLY, 0644);
+
 	if (!ASSERT_GE(fd, 0, "open_file"))
 		goto out;
 
-	ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
-
 	/* Trigger security_inode_getxattr */
-	err = getxattr(testfile, "user.kfuncs", v, sizeof(v));
-	ASSERT_EQ(err, -1, "getxattr_return");
-	ASSERT_EQ(errno, EINVAL, "getxattr_errno");
-	ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
+	err = getxattr(testfile, name, v, sizeof(v));
+
+	if (allow_access) {
+		ASSERT_EQ(err, -1, "getxattr_return");
+		ASSERT_EQ(errno, EINVAL, "getxattr_errno");
+		ASSERT_EQ(skel->bss->found_xattr_from_file, 1, "found_xattr_from_file");
+		ASSERT_EQ(skel->bss->found_xattr_from_dentry, 1, "found_xattr_from_dentry");
+	} else {
+		ASSERT_EQ(err, strlen(value) + 1, "getxattr_return");
+		ASSERT_EQ(skel->bss->found_xattr_from_file, 0, "found_xattr_from_file");
+		ASSERT_EQ(skel->bss->found_xattr_from_dentry, 0, "found_xattr_from_dentry");
+	}
 
 out:
 	close(fd);
@@ -141,8 +148,21 @@ static void test_fsverity(void)
 
 void test_fs_kfuncs(void)
 {
-	if (test__start_subtest("xattr"))
-		test_xattr();
+	/* Matches xattr_names in progs/test_get_xattr.c */
+	if (test__start_subtest("user_xattr"))
+		test_get_xattr("user.kfuncs", "hello", true);
+
+	if (test__start_subtest("security_bpf_xattr_1"))
+		test_get_xattr("security.bpf", "hello", true);
+
+	if (test__start_subtest("security_bpf_xattr_2"))
+		test_get_xattr("security.bpf.xxx", "hello", true);
+
+	if (test__start_subtest("security_bpfxxx_xattr_error"))
+		test_get_xattr("security.bpfxxx", "hello", false);
+
+	if (test__start_subtest("security_selinux_xattr_error"))
+		test_get_xattr("security.selinux", "hello", false);
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
index 66e737720f7c..0be8120683cd 100644
--- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -17,12 +17,26 @@ static const char expected_value[] = "hello";
 char value1[32];
 char value2[32];
 
+#define NUM_OF_XATTR_NAME 5
+
+/* Matches caller of test_get_xattr() in prog_tests/fs_kfuncs.c */
+static const char *xattr_names[NUM_OF_XATTR_NAME] = {
+	/* The following work. */
+	"user.kfuncs",
+	"security.bpf",
+	"security.bpf.xxx",
+
+	/* The following do not work. */
+	"security.bpfxxx",
+	"security.selinux"
+};
+
 SEC("lsm.s/file_open")
 int BPF_PROG(test_file_open, struct file *f)
 {
 	struct bpf_dynptr value_ptr;
 	__u32 pid;
-	int ret;
+	int ret, i;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
 	if (pid != monitored_pid)
@@ -30,7 +44,11 @@ int BPF_PROG(test_file_open, struct file *f)
 
 	bpf_dynptr_from_mem(value1, sizeof(value1), 0, &value_ptr);
 
-	ret = bpf_get_file_xattr(f, "user.kfuncs", &value_ptr);
+	for (i = 0; i < NUM_OF_XATTR_NAME; i++) {
+		ret = bpf_get_file_xattr(f, xattr_names[i], &value_ptr);
+		if (ret == sizeof(expected_value))
+			break;
+	}
 	if (ret != sizeof(expected_value))
 		return 0;
 	if (bpf_strncmp(value1, ret, expected_value))
@@ -44,7 +62,7 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
 {
 	struct bpf_dynptr value_ptr;
 	__u32 pid;
-	int ret;
+	int ret, i;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
 	if (pid != monitored_pid)
@@ -52,7 +70,11 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
 
 	bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
 
-	ret = bpf_get_dentry_xattr(dentry, "user.kfuncs", &value_ptr);
+	for (i = 0; i < NUM_OF_XATTR_NAME; i++) {
+		ret = bpf_get_dentry_xattr(dentry, xattr_names[i], &value_ptr);
+		if (ret == sizeof(expected_value))
+			break;
+	}
 	if (ret != sizeof(expected_value))
 		return 0;
 	if (bpf_strncmp(value2, ret, expected_value))
-- 
2.43.5


