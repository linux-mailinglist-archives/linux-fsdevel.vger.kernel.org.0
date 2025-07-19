Return-Path: <linux-fsdevel+bounces-55502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E52B0AF5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD29C3BD386
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E537238D54;
	Sat, 19 Jul 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cfqPmr6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58191227B94
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921738; cv=none; b=cYkjTg6aggHakDJc4SQ2kHSb4XWpbc9HbgaGihaKdp7C/DaDihu0/XAY5zv5bk9w0u/4RmiEA1gBn2LKFB5T/VEQ8+jQrXqe5zw/zd4zIaeSE8eqY+KZ7F3cfMbhqQLP76eCnmy0fV8bxJU/mIt0BMFoOmTQQ90dUDSFbxIfz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921738; c=relaxed/simple;
	bh=J7lE1XlktXOr04nu0d2DxN49LGl8ljm4MlCMRNc+Mpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRgCqUqcHOft8XJcEBTMKiEGurnAfGOpnHeVnKdoWblGZq7O2tMUtfnPWscglM60y3r25ztsNzwxx3eaoRunLG1iapWajOTCGnnMZ5uX0IS6MozlVnS7PwyR9B+j2gMXBJHIadEeJDKh9gUyw3KfJtBTBdipj4mH9k0tVna1bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cfqPmr6r; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bkjsK3NT9zngw;
	Sat, 19 Jul 2025 12:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752921733;
	bh=8nBtBC8lTCrdiPLS6VOdLj6Q1mgbRtki/F7Y7bm04GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfqPmr6rELCA1yAxhpMv8Q8V+krK2BNMKzD0wLi77KJ0GGN2VK+yqtK5RP4Uq+WKR
	 fK4jznM/ZRQka4aZffeoxzuM2eObGE3OEn+A6/fVNEk/j+JKIE0y7rzHdim7ANhVCI
	 HDF/YaMJMjfFWqRm3Q9rS02Gk3i3l+b2M6hDTMLM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bkjsJ5FgQzDGc;
	Sat, 19 Jul 2025 12:42:12 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 4/4] selftests/landlock: Add disconnected leafs and branch test suites
Date: Sat, 19 Jul 2025 12:42:03 +0200
Message-ID: <20250719104204.545188-5-mic@digikod.net>
In-Reply-To: <20250719104204.545188-1-mic@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Test disconnected directories with two test suites and 31 variants to
cover the main corner cases.

These tests are complementary to the previous commit.

Add test_renameat() and test_exchangeat() helpers.

Test coverage for security/landlock is 92.0% of 1962 lines according to
LLVM v20.

Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- Update test coverage.

Changes since v1:
- Rename layout4_disconnected to layout4_disconnected_leafs.
- Fix variable names.
- Add layout5_disconnected_branch test suite with 19 variants to cover
  potential implementation issues.
---
 tools/testing/selftests/landlock/fs_test.c | 912 +++++++++++++++++++++
 1 file changed, 912 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 5312698927ea..21dd95aaf5e4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2267,6 +2267,22 @@ static int test_exchange(const char *const oldpath, const char *const newpath)
 	return 0;
 }
 
+static int test_renameat(int olddirfd, const char *oldpath, int newdirfd,
+			 const char *newpath)
+{
+	if (renameat2(olddirfd, oldpath, newdirfd, newpath, 0))
+		return errno;
+	return 0;
+}
+
+static int test_exchangeat(int olddirfd, const char *oldpath, int newdirfd,
+			   const char *newpath)
+{
+	if (renameat2(olddirfd, oldpath, newdirfd, newpath, RENAME_EXCHANGE))
+		return errno;
+	return 0;
+}
+
 TEST_F_FORK(layout1, rename_file)
 {
 	const struct rule rules[] = {
@@ -5205,6 +5221,902 @@ TEST_F_FORK(layout1_bind, path_disconnected_link)
 	}
 }
 
+/*
+ * layout4_disconnected_leafs with bind mount and renames:
+ *
+ * tmp
+ * ├── s1d1
+ * │   └── s1d2 [source of the bind mount]
+ * │       ├── s1d31
+ * │       │   └── s1d41 [now renamed beneath s3d1]
+ * │       │       ├── f1
+ * │       │       └── f2
+ * │       └── s1d32
+ * │           └── s1d42 [now renamed beneath s4d1]
+ * │               ├── f3
+ * │               └── f4
+ * ├── s2d1
+ * │   └── s2d2 [bind mount of s1d2]
+ * │       ├── s1d31
+ * │       │   └── s1d41 [opened FD, now renamed beneath s3d1]
+ * │       │       ├── f1
+ * │       │       └── f2
+ * │       └── s1d32
+ * │           └── s1d42 [opened FD, now renamed beneath s4d1]
+ * │               ├── f3
+ * │               └── f4
+ * ├── s3d1
+ * │   └── s1d41 [renamed here]
+ * │       ├── f1
+ * │       └── f2
+ * └── s4d1
+ *     └── s1d42 [renamed here]
+ *         ├── f3
+ *         └── f4
+ */
+/* clang-format off */
+FIXTURE(layout4_disconnected_leafs) {
+	int s2d2_fd;
+};
+/* clang-format on */
+
+FIXTURE_SETUP(layout4_disconnected_leafs)
+{
+	prepare_layout(_metadata);
+
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d31/s1d41/f1");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d31/s1d41/f2");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f3");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f4");
+	create_directory(_metadata, TMP_DIR "/s2d1/s2d2");
+	create_directory(_metadata, TMP_DIR "/s3d1");
+	create_directory(_metadata, TMP_DIR "/s4d1");
+
+	self->s2d2_fd =
+		open(TMP_DIR "/s2d1/s2d2", O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, self->s2d2_fd);
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(TMP_DIR "/s1d1/s1d2", TMP_DIR "/s2d1/s2d2", NULL,
+			   MS_BIND, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN_PARENT(layout4_disconnected_leafs)
+{
+	/* umount(TMP_DIR "/s2d1") is handled by namespace lifetime. */
+
+	/* Removes files after renames. */
+	remove_path(TMP_DIR "/s3d1/s1d41/f1");
+	remove_path(TMP_DIR "/s3d1/s1d41/f2");
+	remove_path(TMP_DIR "/s4d1/s1d42/f1");
+	remove_path(TMP_DIR "/s4d1/s1d42/f3");
+	remove_path(TMP_DIR "/s4d1/s1d42/f4");
+	remove_path(TMP_DIR "/s4d1/s1d42/f5");
+
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(layout4_disconnected_leafs)
+{
+	/*
+	 * Parent of the bind mount source.  It should always be ignored when
+	 * testing against files under the s1d41 or s1d42 disconnected directories.
+	 */
+	const __u64 allowed_s1d1;
+	/*
+	 * Source of bind mount (to s2d2).  It should always be enforced when
+	 * testing against files under the s1d41 or s1d42 disconnected directories.
+	 */
+	const __u64 allowed_s1d2;
+	/*
+	 * Original parent of s1d41.  It should always be ignored when testing
+	 * against files under the s1d41 disconnected directory.
+	 */
+	const __u64 allowed_s1d31;
+	/*
+	 * Original parent of s1d42.  It should always be ignored when testing
+	 * against files under the s1d42 disconnected directory.
+	 */
+	const __u64 allowed_s1d32;
+	/*
+	 * Opened and disconnected source directory.  It should always be enforced
+	 * when testing against files under the s1d41 disconnected directory.
+	 */
+	const __u64 allowed_s1d41;
+	/*
+	 * Opened and disconnected source directory.  It should always be enforced
+	 * when testing against files under the s1d42 disconnected directory.
+	 */
+	const __u64 allowed_s1d42;
+	/*
+	 * File in the s1d41 disconnected directory.  It should always be enforced
+	 * when testing against itself under the s1d41 disconnected directory.
+	 */
+	const __u64 allowed_f1;
+	/*
+	 * File in the s1d41 disconnected directory.  It should always be enforced
+	 * when testing against itself under the s1d41 disconnected directory.
+	 */
+	const __u64 allowed_f2;
+	/*
+	 * File in the s1d42 disconnected directory.  It should always be enforced
+	 * when testing against itself under the s1d42 disconnected directory.
+	 */
+	const __u64 allowed_f3;
+	/*
+	 * Parent of the bind mount destination.  It should always be enforced when
+	 * testing against files under the s1d41 or s1d42 disconnected directories.
+	 */
+	const __u64 allowed_s2d1;
+	/*
+	 * Directory covered by the bind mount.  It should always be ignored when
+	 * testing against files under the s1d41 or s1d42 disconnected directories.
+	 */
+	const __u64 allowed_s2d2;
+	/*
+	 * New parent of the renamed s1d41.  It should always be ignored when
+	 * testing against files under the s1d41 disconnected directory.
+	 */
+	const __u64 allowed_s3d1;
+	/*
+	 * New parent of the renamed s1d42.  It should always be ignored when
+	 * testing against files under the s1d42 disconnected directory.
+	 */
+	const __u64 allowed_s4d1;
+
+	/* Expected result of the call to open([fd:s1d41]/f1, O_RDONLY). */
+	const int expected_read_result;
+	/* Expected result of the call to renameat([fd:s1d41]/f1, [fd:s1d42]/f1). */
+	const int expected_rename_result;
+	/*
+	 * Expected result of the call to renameat([fd:s1d41]/f2, [fd:s1d42]/f3,
+	 * RENAME_EXCHANGE).
+	 */
+	const int expected_exchange_result;
+	/* Expected result of the call to renameat([fd:s1d42]/f4, [fd:s1d42]/f5). */
+	const int expected_same_dir_rename_result;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s1d1_mount_src_parent) {
+	/* clang-format on */
+	.allowed_s1d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s1d2_mount_src_refer) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s1d2_mount_src_create) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = EXDEV,
+	.expected_exchange_result = EXDEV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s1d2_mount_src_rename) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s1d31_s1d32_old_parent) {
+	/* clang-format on */
+	.allowed_s1d31 = LANDLOCK_ACCESS_FS_REFER |
+			 LANDLOCK_ACCESS_FS_READ_FILE |
+			 LANDLOCK_ACCESS_FS_EXECUTE |
+			 LANDLOCK_ACCESS_FS_MAKE_REG,
+	.allowed_s1d32 = LANDLOCK_ACCESS_FS_REFER |
+			 LANDLOCK_ACCESS_FS_READ_FILE |
+			 LANDLOCK_ACCESS_FS_EXECUTE |
+			 LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s1d41_s1d42_disconnected) {
+	/* clang-format on */
+	.allowed_s1d41 = LANDLOCK_ACCESS_FS_REFER |
+			 LANDLOCK_ACCESS_FS_READ_FILE |
+			 LANDLOCK_ACCESS_FS_EXECUTE |
+			 LANDLOCK_ACCESS_FS_MAKE_REG,
+	.allowed_s1d42 = LANDLOCK_ACCESS_FS_REFER |
+			 LANDLOCK_ACCESS_FS_READ_FILE |
+			 LANDLOCK_ACCESS_FS_EXECUTE |
+			 LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s2d1_mount_dst_parent_create) {
+	/* clang-format on */
+	.allowed_s2d1 = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = EXDEV,
+	.expected_exchange_result = EXDEV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s2d1_mount_dst_parent_refer) {
+	/* clang-format on */
+	.allowed_s2d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s2d1_mount_dst_parent_mini) {
+	/* clang-format on */
+	.allowed_s2d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s2d2_covered_by_mount) {
+	/* clang-format on */
+	.allowed_s2d2 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* Tests collect_domain_accesses(). */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s3d1_s4d1_new_parent) {
+	/* clang-format on */
+	.allowed_s3d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.allowed_s4d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, f1_f2_f3) {
+	/* clang-format on */
+	.allowed_f1 = LANDLOCK_ACCESS_FS_READ_FILE,
+	.allowed_f2 = LANDLOCK_ACCESS_FS_READ_FILE,
+	.allowed_f3 = LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
+{
+	const __u64 handled_access =
+		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE |
+		LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_MAKE_REG;
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR "/s1d1",
+			.access = variant->allowed_s1d1,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2",
+			.access = variant->allowed_s1d2,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d31",
+			.access = variant->allowed_s1d31,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d32",
+			.access = variant->allowed_s1d32,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d31/s1d41",
+			.access = variant->allowed_s1d41,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d32/s1d42",
+			.access = variant->allowed_s1d42,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d31/s1d41/f1",
+			.access = variant->allowed_f1,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d31/s1d41/f2",
+			.access = variant->allowed_f2,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f3",
+			.access = variant->allowed_f3,
+		},
+		{
+			.path = TMP_DIR "/s2d1",
+			.access = variant->allowed_s2d1,
+		},
+		/* s2d2_fd */
+		{
+			.path = TMP_DIR "/s3d1",
+			.access = variant->allowed_s3d1,
+		},
+		{
+			.path = TMP_DIR "/s4d1",
+			.access = variant->allowed_s4d1,
+		},
+		{},
+	};
+	int ruleset_fd, s1d41_bind_fd, s1d42_bind_fd;
+
+	ruleset_fd = create_ruleset(_metadata, handled_access, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Adds rule for the covered directory. */
+	if (variant->allowed_s2d2) {
+		ASSERT_EQ(0, landlock_add_rule(
+				     ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				     &(struct landlock_path_beneath_attr){
+					     .parent_fd = self->s2d2_fd,
+					     .allowed_access =
+						     variant->allowed_s2d2,
+				     },
+				     0));
+	}
+	EXPECT_EQ(0, close(self->s2d2_fd));
+
+	s1d41_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d41_bind_fd);
+	s1d42_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d32/s1d42",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d42_bind_fd);
+
+	/* Disconnects and checks source and destination directories. */
+	EXPECT_EQ(0, test_open_rel(s1d41_bind_fd, "..", O_DIRECTORY));
+	EXPECT_EQ(0, test_open_rel(s1d42_bind_fd, "..", O_DIRECTORY));
+	/* Renames to make it accessible through s3d1/s1d41 */
+	ASSERT_EQ(0, test_renameat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d31/s1d41",
+				   AT_FDCWD, TMP_DIR "/s3d1/s1d41"));
+	/* Renames to make it accessible through s4d1/s1d42 */
+	ASSERT_EQ(0, test_renameat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d32/s1d42",
+				   AT_FDCWD, TMP_DIR "/s4d1/s1d42"));
+	EXPECT_EQ(ENOENT, test_open_rel(s1d41_bind_fd, "..", O_DIRECTORY));
+	EXPECT_EQ(ENOENT, test_open_rel(s1d42_bind_fd, "..", O_DIRECTORY));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(variant->expected_read_result,
+		  test_open_rel(s1d41_bind_fd, "f1", O_RDONLY));
+
+	EXPECT_EQ(variant->expected_rename_result,
+		  test_renameat(s1d41_bind_fd, "f1", s1d42_bind_fd, "f1"));
+	EXPECT_EQ(variant->expected_exchange_result,
+		  test_exchangeat(s1d41_bind_fd, "f2", s1d42_bind_fd, "f3"));
+
+	EXPECT_EQ(variant->expected_same_dir_rename_result,
+		  test_renameat(s1d42_bind_fd, "f4", s1d42_bind_fd, "f5"));
+}
+
+/*
+ * layout5_disconnected_branch before rename:
+ *
+ * tmp
+ * ├── s1d1
+ * │   └── s1d2 [source of the first bind mount]
+ * │       └── s1d3
+ * │           ├── s1d41
+ * │           │   ├── f1
+ * │           │   └── f2
+ * │           └── s1d42
+ * │               ├── f3
+ * │               └── f4
+ * ├── s2d1
+ * │   └── s2d2 [source of the second bind mount]
+ * │       └── s2d3
+ * │           └── s2d4 [first s1d2 bind mount]
+ * │               └── s1d3
+ * │                   ├── s1d41
+ * │                   │   ├── f1
+ * │                   │   └── f2
+ * │                   └── s1d42
+ * │                       ├── f3
+ * │                       └── f4
+ * ├── s3d1
+ * │   └── s3d2 [second s2d2 bind mount]
+ * │       └── s2d3
+ * │           └── s2d4 [first s1d2 bind mount]
+ * │               └── s1d3
+ * │                   ├── s1d41
+ * │                   │   ├── f1
+ * │                   │   └── f2
+ * │                   └── s1d42
+ * │                       ├── f3
+ * │                       └── f4
+ * └── s4d1
+ *
+ * After rename:
+ *
+ * tmp
+ * ├── s1d1
+ * │   └── s1d2 [source of the first bind mount]
+ * │       └── s1d3
+ * │           ├── s1d41
+ * │           │   ├── f1
+ * │           │   └── f2
+ * │           └── s1d42
+ * │               ├── f3
+ * │               └── f4
+ * ├── s2d1
+ * │   └── s2d2 [source of the second bind mount]
+ * ├── s3d1
+ * │   └── s3d2 [second s2d2 bind mount]
+ * └── s4d1
+ *     └── s2d3 [renamed here]
+ *         └── s2d4 [first s1d2 bind mount]
+ *             └── s1d3
+ *                 ├── s1d41
+ *                 │   ├── f1
+ *                 │   └── f2
+ *                 └── s1d42
+ *                     ├── f3
+ *                     └── f4
+ *
+ * Decision path: s1d3 -> s1d2 -> s2d2 -> s3d1 -> tmp
+ * s2d3 is ignored, as well as the directories under the mount points.
+ */
+
+/* clang-format off */
+FIXTURE(layout5_disconnected_branch) {
+	int s2d4_fd, s3d2_fd;
+};
+/* clang-format on */
+
+FIXTURE_SETUP(layout5_disconnected_branch)
+{
+	prepare_layout(_metadata);
+
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d3/s1d41/f1");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d3/s1d41/f2");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d3/s1d42/f3");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d3/s1d42/f4");
+	create_directory(_metadata, TMP_DIR "/s2d1/s2d2/s2d3/s2d4");
+	create_directory(_metadata, TMP_DIR "/s3d1/s3d2");
+	create_directory(_metadata, TMP_DIR "/s4d1");
+
+	self->s2d4_fd = open(TMP_DIR "/s2d1/s2d2/s2d3/s2d4",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, self->s2d4_fd);
+
+	self->s3d2_fd =
+		open(TMP_DIR "/s3d1/s3d2", O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, self->s3d2_fd);
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(TMP_DIR "/s1d1/s1d2", TMP_DIR "/s2d1/s2d2/s2d3/s2d4",
+			   NULL, MS_BIND, NULL));
+	ASSERT_EQ(0, mount(TMP_DIR "/s2d1/s2d2", TMP_DIR "/s3d1/s3d2", NULL,
+			   MS_BIND | MS_REC, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN_PARENT(layout5_disconnected_branch)
+{
+	/* Bind mounts are handled by namespace lifetime. */
+
+	/* Removes files after renames. */
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d41/f1");
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d41/f2");
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d42/f1");
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d42/f3");
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d42/f4");
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d42/f5");
+
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(layout5_disconnected_branch)
+{
+	/*
+	 * Parent of all files.  It should always be enforced when testing against
+	 * files under the s1d41 or s1d42 disconnected directories.
+	 */
+	const __u64 allowed_base;
+	/*
+	 * Parent of the first bind mount source.  It should always be ignored when
+	 * testing against files under the s1d41 or s1d42 disconnected directories.
+	 */
+	const __u64 allowed_s1d1;
+	const __u64 allowed_s1d2;
+	const __u64 allowed_s1d3;
+	const __u64 allowed_s2d1;
+	const __u64 allowed_s2d2;
+	const __u64 allowed_s2d3;
+	const __u64 allowed_s2d4;
+	const __u64 allowed_s3d1;
+	const __u64 allowed_s3d2;
+	const __u64 allowed_s4d1;
+
+	/* Expected result of the call to open([fd:s1d3]/s1d41/f1, O_RDONLY). */
+	const int expected_read_result;
+	/*
+	 * Expected result of the call to renameat([fd:s1d3]/s1d41/f1,
+	 * [fd:s1d3]/s1d42/f1).
+	 */
+	const int expected_rename_result;
+	/*
+	 * Expected result of the call to renameat([fd:s1d3]/s1d41/f2,
+	 * [fd:s1d3]/s1d42/f3,  RENAME_EXCHANGE).
+	 */
+	const int expected_exchange_result;
+	/*
+	 * Expected result of the call to renameat([fd:s1d3]/s1d42/f4,
+	 * [fd:s1d3]/s1d42/f5).
+	 */
+	const int expected_same_dir_rename_result;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d1_mount1_src_parent) {
+	/* clang-format on */
+	.allowed_s1d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d2_mount1_src_refer) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d2_mount1_src_create) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = EXDEV,
+	.expected_exchange_result = EXDEV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d2_mount1_src_rename) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d3_fd_refer) {
+	/* clang-format on */
+	.allowed_s1d3 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d3_fd_create) {
+	/* clang-format on */
+	.allowed_s1d3 = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = EXDEV,
+	.expected_exchange_result = EXDEV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d3_fd_rename) {
+	/* clang-format on */
+	.allowed_s1d3 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s1d3_fd_full) {
+	/* clang-format on */
+	.allowed_s1d3 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s2d1_mount2_src_parent) {
+	/* clang-format on */
+	.allowed_s2d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s2d2_mount2_src_refer) {
+	/* clang-format on */
+	.allowed_s2d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s2d2_mount2_src_create) {
+	/* clang-format on */
+	.allowed_s2d2 = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = EXDEV,
+	.expected_exchange_result = EXDEV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s2d2_mount2_src_rename) {
+	/* clang-format on */
+	.allowed_s2d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s2d3_mount1_dst_parent) {
+	/* clang-format on */
+	.allowed_s2d3 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s2d4_mount1_dst) {
+	/* clang-format on */
+	.allowed_s2d4 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s3d1_mount2_dst_parent_refer) {
+	/* clang-format on */
+	.allowed_s3d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s3d1_mount2_dst_parent_create) {
+	/* clang-format on */
+	.allowed_s3d1 = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = EXDEV,
+	.expected_exchange_result = EXDEV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s3d1_mount2_dst_parent_rename) {
+	/* clang-format on */
+	.allowed_s3d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s3d2_mount1_dst) {
+	/* clang-format on */
+	.allowed_s3d2 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout5_disconnected_branch, s4d1_rename_parent) {
+	/* clang-format on */
+	.allowed_s4d1 = LANDLOCK_ACCESS_FS_REFER |
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+TEST_F_FORK(layout5_disconnected_branch, read_rename_exchange)
+{
+	const __u64 handled_access =
+		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE |
+		LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_MAKE_REG;
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR "/s1d1",
+			.access = variant->allowed_s1d1,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2",
+			.access = variant->allowed_s1d2,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d3",
+			.access = variant->allowed_s1d3,
+		},
+		{
+			.path = TMP_DIR "/s2d1",
+			.access = variant->allowed_s2d1,
+		},
+		{
+			.path = TMP_DIR "/s2d1/s2d2",
+			.access = variant->allowed_s2d2,
+		},
+		{
+			.path = TMP_DIR "/s2d1/s2d2/s2d3",
+			.access = variant->allowed_s2d3,
+		},
+		/* s2d4_fd */
+		{
+			.path = TMP_DIR "/s3d1",
+			.access = variant->allowed_s3d1,
+		},
+		/* s3d2_fd */
+		{
+			.path = TMP_DIR "/s4d1",
+			.access = variant->allowed_s4d1,
+		},
+		{},
+	};
+	int ruleset_fd, s1d3_bind_fd;
+
+	ruleset_fd = create_ruleset(_metadata, handled_access, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Adds rules for the covered directories. */
+	if (variant->allowed_s2d4) {
+		ASSERT_EQ(0, landlock_add_rule(
+				     ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				     &(struct landlock_path_beneath_attr){
+					     .parent_fd = self->s2d4_fd,
+					     .allowed_access =
+						     variant->allowed_s2d4,
+				     },
+				     0));
+	}
+	EXPECT_EQ(0, close(self->s2d4_fd));
+
+	if (variant->allowed_s3d2) {
+		ASSERT_EQ(0, landlock_add_rule(
+				     ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				     &(struct landlock_path_beneath_attr){
+					     .parent_fd = self->s3d2_fd,
+					     .allowed_access =
+						     variant->allowed_s3d2,
+				     },
+				     0));
+	}
+	EXPECT_EQ(0, close(self->s3d2_fd));
+
+	s1d3_bind_fd = open(TMP_DIR "/s3d1/s3d2/s2d3/s2d4/s1d3",
+			    O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d3_bind_fd);
+
+	/* Disconnects and checks source and destination directories. */
+	EXPECT_EQ(0, test_open_rel(s1d3_bind_fd, "../../..", O_DIRECTORY));
+	/* Renames to make it accessible through s3d1/s1d41 */
+	ASSERT_EQ(0, test_renameat(AT_FDCWD, TMP_DIR "/s2d1/s2d2/s2d3",
+				   AT_FDCWD, TMP_DIR "/s4d1/s2d3"));
+	EXPECT_EQ(ENOENT, test_open_rel(s1d3_bind_fd, "../../..", O_DIRECTORY));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(variant->expected_read_result,
+		  test_open_rel(s1d3_bind_fd, "s1d41/f1", O_RDONLY));
+
+	EXPECT_EQ(variant->expected_rename_result,
+		  test_renameat(s1d3_bind_fd, "s1d41/f1", s1d3_bind_fd,
+				"s1d42/f1"));
+	EXPECT_EQ(variant->expected_exchange_result,
+		  test_exchangeat(s1d3_bind_fd, "s1d41/f2", s1d3_bind_fd,
+				  "s1d42/f3"));
+
+	EXPECT_EQ(variant->expected_same_dir_rename_result,
+		  test_renameat(s1d3_bind_fd, "s1d42/f4", s1d3_bind_fd,
+				"s1d42/f5"));
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
-- 
2.50.1


