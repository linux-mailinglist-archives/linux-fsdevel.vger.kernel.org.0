Return-Path: <linux-fsdevel+bounces-54697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368ABB02477
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8787AE76C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25B2EF9D5;
	Fri, 11 Jul 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y3Nstr8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071DE1E04BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261610; cv=none; b=sBcsVX1rzqM5k2B1EpxF4FzlX993+qkAre+qNviUvOmB95fT17+Gy5CHO/pQEGvOp/gqATxOGt89Yga8Ei/8lLdJPqZqZceE+ywgyszPNeZ0VK2ZimZGfIVY3ZfBhOUQN0a2HPUoIwKZq+ceHshV0X+Il8brCj8pZnFAyMAVYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261610; c=relaxed/simple;
	bh=jsFP/cC7LSyD4yWX7gcmFWTXD2Das9qiyzH/j9oJj2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBO2yuuPM32/zYOF6qPdi/Acz1jUoegPrXESfsdwbcEOVOlH2RGwcRTF9QpRmnPoKsGORAbuThXIHE+4WPg4IRlXUKVlI+fx7ulI9WYkjiYQI646yRaiJZjIlzhuzJqfXEQ65cwu+TUDnbo2pjeC+l4ZfscUltP3UIAkvt8I7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y3Nstr8x; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bf1kR0fb1zNgm;
	Fri, 11 Jul 2025 21:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752261598;
	bh=s6m/0uV/lv4emo5k39B8GYaIE91d3n98toAlYU9eO6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3Nstr8xSc6UPvnIl2sqHJ3seBRSfj2mTx7uSLKQp3VInq6BBpVFHh+oIEgiwySgs
	 yLUQX7+Aqn5ZPzC3iL5aqXMj+Ai8XdchzEdg1vM6TsWUBfBqmXkNLCJ58WvO1kk1zY
	 Dcl5RBRAAWK0ePLSoKU3aP3I9zhHAqos428SsIwQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bf1kQ34twzKTb;
	Fri, 11 Jul 2025 21:19:58 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH v2 2/3] selftests/landlock: Add tests for access through disconnected paths
Date: Fri, 11 Jul 2025 21:19:34 +0200
Message-ID: <20250711191938.2007175-3-mic@digikod.net>
In-Reply-To: <20250711191938.2007175-1-mic@digikod.net>
References: <20250711191938.2007175-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Tingmao Wang <m@maowtm.org>

This adds tests for the edge case discussed in [1], with specific ones
for rename and link operations when the operands are through
disconnected paths, as that go through a separate code path in Landlock.

This has resulted in a warning, due to collect_domain_accesses() not
expecting to reach a different root from path->mnt:

  #  RUN           layout1_bind.path_disconnected ...
  #            OK  layout1_bind.path_disconnected
  ok 96 layout1_bind.path_disconnected
  #  RUN           layout1_bind.path_disconnected_rename ...
  [..] ------------[ cut here ]------------
  [..] WARNING: CPU: 3 PID: 385 at security/landlock/fs.c:1065 collect_domain_accesses
  [..] ...
  [..] RIP: 0010:collect_domain_accesses (security/landlock/fs.c:1065 (discriminator 2) security/landlock/fs.c:1031 (discriminator 2))
  [..] current_check_refer_path (security/landlock/fs.c:1205)
  [..] ...
  [..] hook_path_rename (security/landlock/fs.c:1526)
  [..] security_path_rename (security/security.c:2026 (discriminator 1))
  [..] do_renameat2 (fs/namei.c:5264)
  #            OK  layout1_bind.path_disconnected_rename
  ok 97 layout1_bind.path_disconnected_rename

Move the const char definitions a bit above so that we can use the path
for s4d1 in cleanup code.

Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org [1]
Signed-off-by: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- Integrate this patch into my patch series, and change the result for
  two tests with updated comments.  Diff here:
  https://lore.kernel.org/r/20250701183812.3201231-2-mic@digikod.net
- Replace most ASSERT with EXPECT, add extra checks, massage commit
  message and comments.
- Squash Tingmao's patches:
  https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
  https://lore.kernel.org/r/8ed0bfcd-aefa-44bd-86b6-e12583779187@maowtm.org
  https://lore.kernel.org/r/3080e512-64b0-42cf-b379-8f52cfeff78a@maowtm.org
---
 tools/testing/selftests/landlock/fs_test.c | 405 ++++++++++++++++++++-
 1 file changed, 402 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fa0f18ec62c4..5312698927ea 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4561,6 +4561,18 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 FIXTURE(layout1_bind) {};
 /* clang-format on */
 
+static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
+static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
+
+/* Move targets for disconnected path tests. */
+static const char dir_s4d1[] = TMP_DIR "/s4d1";
+static const char file1_s4d1[] = TMP_DIR "/s4d1/f1";
+static const char file2_s4d1[] = TMP_DIR "/s4d1/f2";
+static const char dir_s4d2[] = TMP_DIR "/s4d1/s4d2";
+static const char file1_s4d2[] = TMP_DIR "/s4d1/s4d2/f1";
+static const char file1_name[] = "f1";
+static const char file2_name[] = "f2";
+
 FIXTURE_SETUP(layout1_bind)
 {
 	prepare_layout(_metadata);
@@ -4576,14 +4588,14 @@ FIXTURE_TEARDOWN_PARENT(layout1_bind)
 {
 	/* umount(dir_s2d2)) is handled by namespace lifetime. */
 
+	remove_path(file1_s4d1);
+	remove_path(file2_s4d1);
+
 	remove_layout1(_metadata);
 
 	cleanup_layout(_metadata);
 }
 
-static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
-static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
-
 /*
  * layout1_bind hierarchy:
  *
@@ -4806,6 +4818,393 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
 	ASSERT_EQ(0, rename(bind_file1_s1d3, file1_s2d2));
 }
 
+/*
+ * Make sure access to file through a disconnected path works as expected.
+ * This test moves s1d3 to s4d1.
+ */
+TEST_F_FORK(layout1_bind, path_disconnected)
+{
+	const struct rule layer1_allow_all[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_ALL,
+		},
+		{},
+	};
+	const struct rule layer2_allow_just_f1[] = {
+		{
+			.path = file1_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+	const struct rule layer3_only_s1d2[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+
+	/* Landlock should not deny access just because it is disconnected. */
+	int ruleset_fd_l1 =
+		create_ruleset(_metadata, ACCESS_ALL, layer1_allow_all);
+
+	/* Creates the new ruleset now before we move the dir containing the file. */
+	int ruleset_fd_l2 =
+		create_ruleset(_metadata, ACCESS_RW, layer2_allow_just_f1);
+	int ruleset_fd_l3 =
+		create_ruleset(_metadata, ACCESS_RW, layer3_only_s1d2);
+	int bind_s1d3_fd;
+
+	ASSERT_LE(0, ruleset_fd_l1);
+	ASSERT_LE(0, ruleset_fd_l2);
+	ASSERT_LE(0, ruleset_fd_l3);
+
+	enforce_ruleset(_metadata, ruleset_fd_l1);
+	EXPECT_EQ(0, close(ruleset_fd_l1));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, bind_s1d3_fd);
+
+	/* Tests access is possible before we move. */
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, "..", O_RDONLY | O_DIRECTORY));
+
+	/* Makes it disconnected. */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d1))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d1,
+		       strerror(errno));
+	}
+
+	/* Tests that access is still possible. */
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+
+	/*
+	 * Tests that ".." is not possible (not because of Landlock, but just
+	 * because it's disconnected).
+	 */
+	EXPECT_EQ(ENOENT,
+		  test_open_rel(bind_s1d3_fd, "..", O_RDONLY | O_DIRECTORY));
+
+	/* This should still work with a narrower rule. */
+	enforce_ruleset(_metadata, ruleset_fd_l2);
+	EXPECT_EQ(0, close(ruleset_fd_l2));
+
+	EXPECT_EQ(0, test_open(file1_s4d1, O_RDONLY));
+	/*
+	 * Accessing a file through a disconnected file descriptor is not allowed
+	 * when it is no longer visible in its mount point.
+	 */
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+
+	/*
+	 * But if we only allow access to under the original dir, then it
+	 * should be denied.
+	 */
+	enforce_ruleset(_metadata, ruleset_fd_l3);
+	EXPECT_EQ(0, close(ruleset_fd_l3));
+	EXPECT_EQ(EACCES, test_open(file1_s4d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+}
+
+/*
+ * Test that renameat with disconnected paths works under Landlock.  This test
+ * moves s1d3 to s4d2, so that we can have a rule allowing refers on the move
+ * target's immediate parent.
+ */
+TEST_F_FORK(layout1_bind, path_disconnected_rename)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_DIR |
+				  LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				  LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = dir_s4d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_DIR |
+				  LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				  LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+
+	/* This layer only handles LANDLOCK_ACCESS_FS_READ_FILE. */
+	const struct rule layer2_only_s1d2[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+	int ruleset_fd_l1, ruleset_fd_l2;
+	pid_t child_pid;
+	int bind_s1d3_fd, status;
+
+	ASSERT_EQ(0, mkdir(dir_s4d1, 0755))
+	{
+		TH_LOG("Failed to create %s: %s", dir_s4d1, strerror(errno));
+	}
+	ruleset_fd_l1 = create_ruleset(_metadata, ACCESS_ALL, layer1);
+	ruleset_fd_l2 = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
+				       layer2_only_s1d2);
+	ASSERT_LE(0, ruleset_fd_l1);
+	ASSERT_LE(0, ruleset_fd_l2);
+
+	enforce_ruleset(_metadata, ruleset_fd_l1);
+	EXPECT_EQ(0, close(ruleset_fd_l1));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, bind_s1d3_fd);
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+
+	/* Tests ENOENT priority over EACCES for disconnected directory. */
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, "..", O_DIRECTORY));
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
+		       strerror(errno));
+	}
+	EXPECT_EQ(ENOENT, test_open_rel(bind_s1d3_fd, "..", O_DIRECTORY));
+
+	/*
+	 * The file is no longer under s1d2 but we should still be able to access it
+	 * with layer 2 because its mount point is evaluated as the first valid
+	 * directory because it was initially a parent.  Do a fork to test this so
+	 * we don't prevent ourselves from renaming it back later.
+	 */
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		enforce_ruleset(_metadata, ruleset_fd_l2);
+		EXPECT_EQ(0, close(ruleset_fd_l2));
+		EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(file1_s4d2, O_RDONLY));
+
+		/*
+		 * Tests that access widening checks indeed prevents us from renaming it
+		 * back.
+		 */
+		EXPECT_EQ(-1, rename(dir_s4d2, dir_s1d3));
+		EXPECT_EQ(EXDEV, errno);
+
+		/*
+		 * Including through the now disconnected fd (but it should return
+		 * EXDEV).
+		 */
+		EXPECT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
+				       file1_s2d2));
+		EXPECT_EQ(EXDEV, errno);
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	EXPECT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
+	{
+		TH_LOG("Failed to rename %s back to %s: %s", dir_s4d1, dir_s1d3,
+		       strerror(errno));
+	}
+
+	/* Now checks that we can access it under l2. */
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		enforce_ruleset(_metadata, ruleset_fd_l2);
+		EXPECT_EQ(0, close(ruleset_fd_l2));
+		EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+		EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	EXPECT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/*
+	 * Also test that we can rename via a disconnected path.  We move the
+	 * dir back to the disconnected place first, then we rename file1 to
+	 * file2 through our dir fd.
+	 */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
+		       strerror(errno));
+	}
+	ASSERT_EQ(0,
+		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name))
+	{
+		TH_LOG("Failed to rename %s to %s within disconnected %s: %s",
+		       file1_name, file2_name, bind_dir_s1d3, strerror(errno));
+	}
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+	ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
+	{
+		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
+		       file2_name, file1_s2d2, bind_dir_s1d3, strerror(errno));
+	}
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+
+	/* Move it back using the disconnected path as the target. */
+	ASSERT_EQ(0, renameat(AT_FDCWD, file1_s2d2, bind_s1d3_fd, file1_name))
+	{
+		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
+		       file1_s1d2, file1_name, bind_dir_s1d3, strerror(errno));
+	}
+
+	/* Now make it connected again. */
+	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
+	{
+		TH_LOG("Failed to rename %s back to %s: %s", dir_s4d2, dir_s1d3,
+		       strerror(errno));
+	}
+
+	/* Checks again that we can access it under l2. */
+	enforce_ruleset(_metadata, ruleset_fd_l2);
+	EXPECT_EQ(0, close(ruleset_fd_l2));
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+}
+
+/*
+ * Test that linkat(2) with disconnected paths works under Landlock. This
+ * test moves s1d3 to s4d1.
+ */
+TEST_F_FORK(layout1_bind, path_disconnected_link)
+{
+	/* Ruleset to be applied after renaming s1d3 to s4d1. */
+	const struct rule layer1[] = {
+		{
+			.path = dir_s4d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd, bind_s1d3_fd;
+
+	/* Removes unneeded files created by layout1, otherwise it will EEXIST. */
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, bind_s1d3_fd);
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+
+	/* Disconnects bind_s1d3_fd. */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d1))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d1,
+		       strerror(errno));
+	}
+
+	/* Need this later to test different parent link. */
+	ASSERT_EQ(0, mkdir(dir_s4d2, 0755))
+	{
+		TH_LOG("Failed to create %s: %s", dir_s4d2, strerror(errno));
+	}
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* From disconnected to connected. */
+	ASSERT_EQ(0, linkat(bind_s1d3_fd, file1_name, AT_FDCWD, file1_s2d2, 0))
+	{
+		TH_LOG("Failed to link %s to %s via disconnected %s: %s",
+		       file1_name, file1_s2d2, bind_dir_s1d3, strerror(errno));
+	}
+
+	/* Tests that we can access via the new link... */
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY))
+	{
+		TH_LOG("Failed to open newly linked %s: %s", file1_s2d2,
+		       strerror(errno));
+	}
+
+	/* ...as well as the old one. */
+	EXPECT_EQ(0, test_open(file1_s4d1, O_RDONLY))
+	{
+		TH_LOG("Failed to open original %s: %s", file1_s4d1,
+		       strerror(errno));
+	}
+
+	/* From connected to disconnected. */
+	ASSERT_EQ(0, unlink(file1_s4d1));
+	ASSERT_EQ(0, linkat(AT_FDCWD, file1_s2d2, bind_s1d3_fd, file2_name, 0))
+	{
+		TH_LOG("Failed to link %s to %s via disconnected %s: %s",
+		       file1_s2d2, file2_name, bind_dir_s1d3, strerror(errno));
+	}
+	EXPECT_EQ(0, test_open(file2_s4d1, O_RDONLY));
+	ASSERT_EQ(0, unlink(file1_s2d2));
+
+	/* From disconnected to disconnected (same parent). */
+	ASSERT_EQ(0,
+		  linkat(bind_s1d3_fd, file2_name, bind_s1d3_fd, file1_name, 0))
+	{
+		TH_LOG("Failed to link %s to %s within disconnected %s: %s",
+		       file2_name, file1_name, bind_dir_s1d3, strerror(errno));
+	}
+	EXPECT_EQ(0, test_open(file1_s4d1, O_RDONLY))
+	{
+		TH_LOG("Failed to open newly linked %s: %s", file1_s4d1,
+		       strerror(errno));
+	}
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY))
+	{
+		TH_LOG("Failed to open %s through newly created link under disconnected path: %s",
+		       file1_name, strerror(errno));
+	}
+	ASSERT_EQ(0, unlink(file2_s4d1));
+
+	/* From disconnected to disconnected (different parent). */
+	ASSERT_EQ(0,
+		  linkat(bind_s1d3_fd, file1_name, bind_s1d3_fd, "s4d2/f1", 0))
+	{
+		TH_LOG("Failed to link %s to %s within disconnected %s: %s",
+		       file1_name, "s4d2/f1", bind_dir_s1d3, strerror(errno));
+	}
+	EXPECT_EQ(0, test_open(file1_s4d2, O_RDONLY))
+	{
+		TH_LOG("Failed to open %s after link: %s", file1_s4d2,
+		       strerror(errno));
+	}
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, "s4d2/f1", O_RDONLY))
+	{
+		TH_LOG("Failed to open %s through disconnected path after link: %s",
+		       "s4d2/f1", strerror(errno));
+	}
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
-- 
2.50.1


