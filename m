Return-Path: <linux-fsdevel+bounces-53568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E747AAF02E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF39E4A7A55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB82459FA;
	Tue,  1 Jul 2025 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WRG53vrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F72580FE
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395121; cv=none; b=cyTJuk74wxgA25Vi5dpoO1TOSrj/QYNJy4bQ67E45t2eanvRrEeNC0IKiVVHsnNC9ho+DoyiOG8qEZbGLwU7sii61ZvGx/CiRVZjsEoyW06Nqg2C4QraLidoGPhhwP6LjPY1hdNrcPUruJ1J2dinkzIKgSxeFH59Mj/ESmZtYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395121; c=relaxed/simple;
	bh=AX8CpDefeIEdavsa/SQL/k6hc98wRtYXRHCStb+QSBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpsestIjOFFbUxVOGhl9U+oPsSwp57cKrrHs6XeWM+DsmxiGjPNFhue1UIuhA/Tk8GOKNZpTdvCRtisaaKNGlvdiM1z0X7igi4Dchsc1W38vcByK2fVUu+3lOI9ju/VHZu08YZc6U57owlow1wplJmn8/8I7UGLcFk1y6+w5tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WRG53vrm; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bWsH80bXgzhLl;
	Tue,  1 Jul 2025 20:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751395107;
	bh=FrEvJDIbJrtZ1Q0/UvIhad6i9G46+UyNpszGlIcK0jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRG53vrmKCzTZHvCuDmal4LGkstzhMu060w63wJcD4OAB6M+rfw0hkrySTiG5O3x4
	 NQxdqE1fEhB1LhkSiayRzsQWQdv+sjBM58Ti3TGoUAZSPzr0ReqgvV3uCHFmyXoPFH
	 RxrGPNcDFgc3DYluWhuici8dCetiOlnW/8WHOt9U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bWsH72s5MzfBW;
	Tue,  1 Jul 2025 20:38:27 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Xu <jeffxu@google.com>,
	Ben Scarlato <akhna@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: [RFC PATCH v1 2/2] selftests/landlock: Add layout4_disconnected test suite
Date: Tue,  1 Jul 2025 20:38:08 +0200
Message-ID: <20250701183812.3201231-2-mic@digikod.net>
In-Reply-To: <20250701183812.3201231-1-mic@digikod.net>
References: <20250701183812.3201231-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Test disconnected directories with 12 variants.

Test coverage for security/landlock is 92.0% of 1956 lines.

Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Tingmao, I initially started from your patch [1] (it changed a lot), and
I'll probably squash with [2], at which point you'll be co-developer if
that's OK with you.

Link: https://lore.kernel.org/r/f7e3d874-6088-4f70-8222-c4a8547d213e@maowtm.org [1]
Link: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org [2]

TODO: Add more tests
---
 tools/testing/selftests/landlock/fs_test.c | 458 ++++++++++++++++++++-
 1 file changed, 452 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index d8f9259fffe4..a99e9ea22f98 100644
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
@@ -4895,7 +4911,14 @@ TEST_F_FORK(layout1_bind, path_disconnected)
 	EXPECT_EQ(0, close(ruleset_fd_l2));
 
 	EXPECT_EQ(0, test_open(file1_s4d1, O_RDONLY));
-	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	/*
+	 * Accessing a file through a disconnected file descriptor is not allowed
+	 * when it is no longer visible in its mount point.
+	 *
+	 * TODO: Is this the right behavior?  We could add an exception for access
+	 * rights tied to files, but it would be a bit inconsistent.
+	 */
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
 	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
 
 	/*
@@ -4977,17 +5000,17 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	EXPECT_EQ(ENOENT, test_open_rel(bind_s1d3_fd, "..", O_DIRECTORY));
 
 	/*
-	 * Since file is no longer under s1d2, we should not be able to access it if
-	 * we enforced layer 2.  Do a fork to test this so we don't prevent
-	 * ourselves from renaming it back later.
+	 * The file is no longer under s1d2 but we should still be able to access it
+	 * with layer 2 because its mount point is evaluated as the first valid
+	 * directory because it was initially a parent.  Do a fork to test this so
+	 * we don't prevent ourselves from renaming it back later.
 	 */
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
 		enforce_ruleset(_metadata, ruleset_fd_l2);
 		EXPECT_EQ(0, close(ruleset_fd_l2));
-		EXPECT_EQ(EACCES,
-			  test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
 		EXPECT_EQ(EACCES, test_open(file1_s4d2, O_RDONLY));
 
 		/*
@@ -5201,6 +5224,429 @@ TEST_F_FORK(layout1_bind, path_disconnected_link)
 	}
 }
 
+/* clang-format off */
+FIXTURE(layout4_disconnected) {
+	int s2d2_fd;
+};
+/* clang-format on */
+
+FIXTURE_SETUP(layout4_disconnected)
+{
+	prepare_layout(_metadata);
+
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d31/s1d41/f1");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d31/s1d41/f2");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f3");
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f4");
+	create_directory(_metadata, TMP_DIR "/s2d1/s2d2");
+	create_directory(_metadata, TMP_DIR "/s3d1/s3d2");
+	create_directory(_metadata, TMP_DIR "/s4d1/s4d2");
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
+FIXTURE_TEARDOWN_PARENT(layout4_disconnected)
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
+/*
+ * layout4_disconnected with bind mount and renames:
+ *
+ * tmp
+ * ├── s1d1
+ * │   └── s1d2 [source of the bind mount]
+ * │       ├── s1d31
+ * │       │   └── s1d41 [now renamed]
+ * │       │       ├── f1
+ * │       │       └── f2
+ * │       └── s1d32
+ * │           └── s1d42 [now renamed]
+ * │               ├── f3
+ * │               └── f4
+ * ├── s2d1
+ * │   └── s2d2 [bind mount of s1d2]
+ * │       ├── s1d31
+ * │       │   └── s1d41 [opened and now renamed]
+ * │       │       ├── f1
+ * │       │       └── f2
+ * │       └── s1d32
+ * │           └── s1d42 [opened and now renamed]
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
+FIXTURE_VARIANT(layout4_disconnected)
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
+	/* Expected result of the call to renameat([fd:s1d42]/f4, [fd:s1d42]/f5). */
+	const int expected_same_dir_rename_result;
+	/* Expected result of the call to renameat([fd:s1d41]/f1, [fd:s1d42]/f1). */
+	const int expected_rename_result;
+	/*
+	 * Expected result of the call to renameat([fd:s1d41]/f2, [fd:s1d42]/f2,
+	 * RENAME_EXCHANGE).
+	 */
+	const int expected_exchange_result;
+};
+
+/* XXX: Fails without the fix. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected, s1d1_mount_src_parent) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, s1d2_mount_src_refer) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected, s1d2_mount_src_create) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, s1d2_mount_src_rename) {
+	/* clang-format on */
+	.allowed_s1d2 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
+	.expected_read_result = EACCES,
+	.expected_same_dir_rename_result = 0,
+	.expected_rename_result = 0,
+	.expected_exchange_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected, s1d31_s1d32_old_parent) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, s1d41_s1d42_disconnected) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, s2d1_mount_dst_parent_create) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, s2d1_mount_dst_parent_refer) {
+	/* clang-format on */
+	.allowed_s2d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_READ_FILE,
+	.expected_read_result = 0,
+	.expected_same_dir_rename_result = EACCES,
+	.expected_rename_result = EACCES,
+	.expected_exchange_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected, s2d1_mount_dst_parent_mini) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, s2d2_covered_by_mount) {
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
+/* Fails without the fix. */
+/* Tests collect_domain_accesses(). */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout4_disconnected, s3d1_s4d1_new_parent) {
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
+FIXTURE_VARIANT_ADD(layout4_disconnected, f1_f2_f3) {
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
+TEST_F_FORK(layout4_disconnected, read_rename_exchange)
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
+	int ruleset_fd, s1d31_bind_fd, s1d32_bind_fd;
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
+	s1d31_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d31_bind_fd);
+	s1d32_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d32/s1d42",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d32_bind_fd);
+
+	/* Disconnects and checks source and destination directories. */
+	EXPECT_EQ(0, test_open_rel(s1d31_bind_fd, "..", O_DIRECTORY));
+	EXPECT_EQ(0, test_open_rel(s1d32_bind_fd, "..", O_DIRECTORY));
+	/* Renames to make it accessible through s3d1/s1d41 */
+	ASSERT_EQ(0, test_renameat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d31/s1d41",
+				   AT_FDCWD, TMP_DIR "/s3d1/s1d41"));
+	/* Renames to make it accessible through s4d1/s1d42 */
+	ASSERT_EQ(0, test_renameat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d32/s1d42",
+				   AT_FDCWD, TMP_DIR "/s4d1/s1d42"));
+	EXPECT_EQ(ENOENT, test_open_rel(s1d31_bind_fd, "..", O_DIRECTORY));
+	EXPECT_EQ(ENOENT, test_open_rel(s1d32_bind_fd, "..", O_DIRECTORY));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(variant->expected_read_result,
+		  test_open_rel(s1d31_bind_fd, "f1", O_RDONLY));
+
+	EXPECT_EQ(variant->expected_rename_result,
+		  test_renameat(s1d31_bind_fd, "f1", s1d32_bind_fd, "f1"));
+	EXPECT_EQ(variant->expected_exchange_result,
+		  test_exchangeat(s1d31_bind_fd, "f2", s1d32_bind_fd, "f3"));
+
+	EXPECT_EQ(variant->expected_same_dir_rename_result,
+		  test_renameat(s1d32_bind_fd, "f4", s1d32_bind_fd, "f5"));
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
-- 
2.50.0


