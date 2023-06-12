Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795F272CF1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbjFLTPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjFLTOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:14:47 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15243C7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 12:14:44 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1b72M4jzMqSLJ;
        Mon, 12 Jun 2023 19:14:43 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1b663lDz1X5M;
        Mon, 12 Jun 2023 21:14:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686597283;
        bh=AcXTzNo59PZOYAQWkPTvo0hVX2p9T7yXQha5grHQJmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhGqPLbSifo8J6qkDInAnBsQOxi4gRxt9PDtGa8cEYOLRbqPMpFw5f8Bg+2++yaIA
         /RxDrIadWj7x+uqd/W/Hg5NBzKLfaFPR7IqIbHv153EmiGG8zkQ/fOJAYXH+r7P312
         HEHQZ0Gn2P9ONlcxi2/7/gq0Dg5CaZ/hHTz4bf+c=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 5/6] selftests/landlock: Add tests for pseudo filesystems
Date:   Mon, 12 Jun 2023 21:14:29 +0200
Message-ID: <20230612191430.339153-6-mic@digikod.net>
In-Reply-To: <20230612191430.339153-1-mic@digikod.net>
References: <20230612191430.339153-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add generic and read-only tests for 6 pseudo filesystems to make sure
they have a consistent inode management, which is required for
Landlock's file hierarchy identification:
- tmpfs
- ramfs
- cgroup2
- proc
- sysfs

Update related kernel configuration to support these new filesystems,
remove useless CONFIG_SECURITY_PATH, and sort all entries.  If these
filesystems are not supported by the kernel running tests, the related
tests are skipped.

Expanding variants, this adds 25 new tests for layout3_fs:
- tag_inode_dir_parent
- tag_inode_dir_mnt
- tag_inode_dir_child
- tag_inode_dir_file
- release_inodes

Test coverage for security/landlock with kernel debug code:
- 94.7% of 835 lines according to gcc/gcov-12
- 93.0% of 852 lines according to gcc/gcov-13

Test coverage for security/landlock without kernel debug code:
- 95.5% of 624 lines according to gcc/gcov-12
- 93.1% of 641 lines according to gcc/gcov-13

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/config    |   9 +-
 tools/testing/selftests/landlock/fs_test.c | 254 ++++++++++++++++++++-
 2 files changed, 259 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 0f0a65287bac..3dc9e438eab1 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,7 +1,10 @@
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
 CONFIG_OVERLAY_FS=y
-CONFIG_SECURITY_LANDLOCK=y
-CONFIG_SECURITY_PATH=y
+CONFIG_PROC_FS=y
 CONFIG_SECURITY=y
+CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SHMEM=y
-CONFIG_TMPFS_XATTR=y
+CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 737047a81547..2911b5241583 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -121,6 +121,10 @@ static bool supports_filesystem(const char *const filesystem)
 	if (!inf)
 		return true;
 
+	/* filesystem can be null for bind mounts. */
+	if (!filesystem)
+		return true;
+
 	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
 	if (len >= sizeof(str))
 		/* Ignores too-long filesystem names. */
@@ -243,7 +247,7 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 	 * for tests relying on pivot_root(2) and move_mount(2).
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, unshare(CLONE_NEWNS | CLONE_NEWCGROUP));
 	ASSERT_EQ(0, mount_opt(mnt, TMP_DIR))
 	{
 		TH_LOG("Failed to mount the %s filesystem: %s", mnt->type,
@@ -318,11 +322,13 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(file1_s1d3));
 	EXPECT_EQ(0, remove_path(file1_s1d2));
 	EXPECT_EQ(0, remove_path(file1_s1d1));
+	EXPECT_EQ(0, remove_path(dir_s1d3));
 
 	EXPECT_EQ(0, remove_path(file2_s2d3));
 	EXPECT_EQ(0, remove_path(file1_s2d3));
 	EXPECT_EQ(0, remove_path(file1_s2d2));
 	EXPECT_EQ(0, remove_path(file1_s2d1));
+	EXPECT_EQ(0, remove_path(dir_s2d2));
 
 	EXPECT_EQ(0, remove_path(file1_s3d1));
 	EXPECT_EQ(0, remove_path(dir_s3d3));
@@ -4482,4 +4488,250 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	}
 }
 
+FIXTURE(layout3_fs)
+{
+	bool has_created_dir;
+	bool has_created_file;
+	char *dir_path;
+	bool skip_test;
+};
+
+FIXTURE_VARIANT(layout3_fs)
+{
+	const struct mnt_opt mnt;
+	const char *const file_path;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
+	/* clang-format on */
+	.mnt = mnt_tmp,
+	.file_path = file1_s1d1,
+};
+
+FIXTURE_VARIANT_ADD(layout3_fs, ramfs) {
+	.mnt = {
+		.type = "ramfs",
+		.data = "mode=700",
+	},
+	.file_path = TMP_DIR "/dir/file",
+};
+
+FIXTURE_VARIANT_ADD(layout3_fs, cgroup2) {
+	.mnt = {
+		.type = "cgroup2",
+	},
+	.file_path = TMP_DIR "/test/cgroup.procs",
+};
+
+FIXTURE_VARIANT_ADD(layout3_fs, proc) {
+	.mnt = {
+		.type = "proc",
+	},
+	.file_path = TMP_DIR "/self/status",
+};
+
+FIXTURE_VARIANT_ADD(layout3_fs, sysfs) {
+	.mnt = {
+		.type = "sysfs",
+	},
+	.file_path = TMP_DIR "/kernel/notes",
+};
+
+FIXTURE_SETUP(layout3_fs)
+{
+	struct stat statbuf;
+	const char *slash;
+	size_t dir_len;
+
+	if (!supports_filesystem(variant->mnt.type)) {
+		self->skip_test = true;
+		SKIP(return, "this filesystem is not supported (setup)");
+	}
+
+	slash = strrchr(variant->file_path, '/');
+	ASSERT_NE(slash, NULL);
+	dir_len = (size_t)slash - (size_t)variant->file_path;
+	ASSERT_LT(0, dir_len);
+	self->dir_path = malloc(dir_len + 1);
+	self->dir_path[dir_len] = '\0';
+	strncpy(self->dir_path, variant->file_path, dir_len);
+
+	prepare_layout_opt(_metadata, &variant->mnt);
+
+	/* Creates directory when required. */
+	if (stat(self->dir_path, &statbuf)) {
+		set_cap(_metadata, CAP_DAC_OVERRIDE);
+		EXPECT_EQ(0, mkdir(self->dir_path, 0700))
+		{
+			TH_LOG("Failed to create directory \"%s\": %s",
+			       self->dir_path, strerror(errno));
+			free(self->dir_path);
+			self->dir_path = NULL;
+		}
+		self->has_created_dir = true;
+		clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	}
+
+	/* Creates file when required. */
+	if (stat(variant->file_path, &statbuf)) {
+		int fd;
+
+		set_cap(_metadata, CAP_DAC_OVERRIDE);
+		fd = creat(variant->file_path, 0600);
+		EXPECT_LE(0, fd)
+		{
+			TH_LOG("Failed to create file \"%s\": %s",
+			       variant->file_path, strerror(errno));
+		}
+		EXPECT_EQ(0, close(fd));
+		self->has_created_file = true;
+		clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	}
+}
+
+FIXTURE_TEARDOWN(layout3_fs)
+{
+	if (self->skip_test)
+		SKIP(return, "this filesystem is not supported (teardown)");
+
+	if (self->has_created_file) {
+		set_cap(_metadata, CAP_DAC_OVERRIDE);
+		/*
+		 * Don't check for error because the file might already
+		 * have been removed (cf. release_inode test).
+		 */
+		unlink(variant->file_path);
+		clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	}
+
+	if (self->has_created_dir) {
+		set_cap(_metadata, CAP_DAC_OVERRIDE);
+		/*
+		 * Don't check for error because the directory might already
+		 * have been removed (cf. release_inode test).
+		 */
+		rmdir(self->dir_path);
+		clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	}
+	free(self->dir_path);
+	self->dir_path = NULL;
+
+	cleanup_layout(_metadata);
+}
+
+static void layer3_fs_tag_inode(struct __test_metadata *const _metadata,
+				FIXTURE_DATA(layout3_fs) * self,
+				const FIXTURE_VARIANT(layout3_fs) * variant,
+				const char *const rule_path)
+{
+	const struct rule layer1_allow_read_file[] = {
+		{
+			.path = rule_path,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+	const struct landlock_ruleset_attr layer2_deny_everything_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	const char *const dev_null_path = "/dev/null";
+	int ruleset_fd;
+
+	if (self->skip_test)
+		SKIP(return, "this filesystem is not supported (test)");
+
+	/* Checks without Landlock. */
+	EXPECT_EQ(0, test_open(dev_null_path, O_RDONLY | O_CLOEXEC));
+	EXPECT_EQ(0, test_open(variant->file_path, O_RDONLY | O_CLOEXEC));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
+				    layer1_allow_read_file);
+	EXPECT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(EACCES, test_open(dev_null_path, O_RDONLY | O_CLOEXEC));
+	EXPECT_EQ(0, test_open(variant->file_path, O_RDONLY | O_CLOEXEC));
+
+	/* Forbids directory reading. */
+	ruleset_fd =
+		landlock_create_ruleset(&layer2_deny_everything_attr,
+					sizeof(layer2_deny_everything_attr), 0);
+	EXPECT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks with Landlock and forbidden access. */
+	EXPECT_EQ(EACCES, test_open(dev_null_path, O_RDONLY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, test_open(variant->file_path, O_RDONLY | O_CLOEXEC));
+}
+
+/* Matrix of tests to check file hierarchy evaluation. */
+
+TEST_F_FORK(layout3_fs, tag_inode_dir_parent)
+{
+	/* The current directory must not be the root for this test. */
+	layer3_fs_tag_inode(_metadata, self, variant, ".");
+}
+
+TEST_F_FORK(layout3_fs, tag_inode_dir_mnt)
+{
+	layer3_fs_tag_inode(_metadata, self, variant, TMP_DIR);
+}
+
+TEST_F_FORK(layout3_fs, tag_inode_dir_child)
+{
+	layer3_fs_tag_inode(_metadata, self, variant, self->dir_path);
+}
+
+TEST_F_FORK(layout3_fs, tag_inode_file)
+{
+	layer3_fs_tag_inode(_metadata, self, variant, variant->file_path);
+}
+
+/* Light version of layout1.release_inodes */
+TEST_F_FORK(layout3_fs, release_inodes)
+{
+	const struct rule layer1[] = {
+		{
+			.path = TMP_DIR,
+			.access = LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	if (self->skip_test)
+		SKIP(return, "this filesystem is not supported (test)");
+
+	/* Clean up for the teardown to not fail. */
+	if (self->has_created_file)
+		EXPECT_EQ(0, remove_path(variant->file_path));
+
+	if (self->has_created_dir)
+		/* Don't check for error because of cgroup specificities. */
+		remove_path(self->dir_path);
+
+	ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, layer1);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Unmount the filesystem while it is being used by a ruleset. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, umount(TMP_DIR));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* Replaces with a new mount point to simplify FIXTURE_TEARDOWN. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount_opt(&mnt_tmp, TMP_DIR));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that access to the new mount point is denied. */
+	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

