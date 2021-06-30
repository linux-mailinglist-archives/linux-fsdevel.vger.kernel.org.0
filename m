Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED433B8AB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhF3XBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 19:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhF3XA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:00:58 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Jun 2021 15:58:29 PDT
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A7C0617AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 15:58:28 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GFc3T5h8jzMqHjK;
        Thu,  1 Jul 2021 00:49:25 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4GFc3T3QBmzlh8ms;
        Thu,  1 Jul 2021 00:49:25 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 4/4] selftests/landlock: Check all possible intermediate directories
Date:   Thu,  1 Jul 2021 00:48:56 +0200
Message-Id: <20210630224856.1313928-5-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210630224856.1313928-1-mic@digikod.net>
References: <20210630224856.1313928-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Open and store file descriptors for the initial test directory at layout
initialization and at sandbox creation.  This enables checking relative
path opening with different scenarios.  To be sure to test all
combinations, the intermediate path checks are of exponential
complexity, which is OK for these use case though.  All meaningful tests
now also check relative paths.

Use some macros to avoid useless helper call rewrites with a context
tied to each test.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210630224856.1313928-5-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 140 ++++++++++++++++++---
 1 file changed, 125 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 403c8255311f..b1a91fdd0f88 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -154,7 +154,13 @@ static int remove_path(const char *const path)
 	return err;
 }
 
-static void prepare_layout(struct __test_metadata *const _metadata)
+struct layout_context {
+	int init_layout_cwd_fd;
+	int init_sandbox_cwd_fd;
+};
+
+static void prepare_layout(struct __test_metadata *const _metadata,
+		struct layout_context *const ctx)
 {
 	disable_caps(_metadata);
 	umask(0077);
@@ -171,10 +177,18 @@ static void prepare_layout(struct __test_metadata *const _metadata)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	ASSERT_EQ(0, chdir(TMP_DIR));
+	ctx->init_layout_cwd_fd = open(".", O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, ctx->init_layout_cwd_fd);
+	ctx->init_sandbox_cwd_fd = -1;
 }
 
-static void cleanup_layout(struct __test_metadata *const _metadata)
+static void cleanup_layout(struct __test_metadata *const _metadata,
+		const struct layout_context *const ctx)
 {
+	EXPECT_EQ(0, close(ctx->init_layout_cwd_fd));
+	if (ctx->init_sandbox_cwd_fd != -1) {
+		EXPECT_EQ(0, close(ctx->init_sandbox_cwd_fd));
+	}
 	EXPECT_EQ(0, chdir(".."));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -227,11 +241,12 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 }
 
 FIXTURE(layout1) {
+	struct layout_context ctx;
 };
 
 FIXTURE_SETUP(layout1)
 {
-	prepare_layout(_metadata);
+	prepare_layout(_metadata, &self->ctx);
 
 	create_layout1(_metadata);
 }
@@ -240,7 +255,7 @@ FIXTURE_TEARDOWN(layout1)
 {
 	remove_layout1(_metadata);
 
-	cleanup_layout(_metadata);
+	cleanup_layout(_metadata, &self->ctx);
 }
 
 /*
@@ -264,11 +279,84 @@ static int test_open_rel(const int dirfd, const char *const path, const int flag
 	return 0;
 }
 
-static int test_open(const char *const path, const int flags)
+static int _test_open_all(const int base_fd, char *const path, const int flags)
+{
+	int ret_child, i;
+
+	ret_child = test_open_rel(base_fd, path, flags);
+	if (ret_child == ENOENT)
+		return ret_child;
+
+	for (i = strlen(path); i > 0; i--) {
+		int inter_fd, ret_parent;
+
+		if (path[i] != '/')
+			continue;
+		path[i] = '\0';
+		/* Using a non-O_PATH FD fills the cache. */
+		inter_fd = openat(base_fd, path, O_CLOEXEC | O_DIRECTORY);
+		path[i] = '/';
+		if (inter_fd < 0) {
+			if (errno != EACCES)
+				return -1;
+			/* If the sandbox denies access, then use O_PATH. */
+			path[i] = '\0';
+			inter_fd = openat(base_fd, path, O_CLOEXEC |
+					O_DIRECTORY | O_PATH);
+			path[i] = '/';
+			if (inter_fd < 0)
+				return -1;
+		}
+
+		/*
+		 * Checks all possible inter_fd combinations with
+		 * recursive calls.
+		 */
+		ret_parent = _test_open_all(inter_fd, path + i + 1, flags);
+		close(inter_fd);
+
+		/* Checks inconsistencies that may come from the cache. */
+		if (ret_parent != ret_child)
+			return -1;
+	}
+	return ret_child;
+}
+
+static int _test_open_ctx(const struct layout_context *const ctx,
+		const char *const path, const int flags)
 {
-	return test_open_rel(AT_FDCWD, path, flags);
+	char *walker;
+	int ret_init, ret_next, i;
+	/*
+	 * Checks with a FD opened without sandbox, and another FD opened
+	 * within a sandbox (but maybe not the same).
+	 */
+	const int extra_dirfd[] = {
+		ctx->init_layout_cwd_fd,
+		ctx->init_sandbox_cwd_fd
+	};
+
+	walker = strdup(path);
+	if (!walker)
+		return ENOMEM;
+
+	ret_init = _test_open_all(AT_FDCWD, walker, flags);
+	for (i = 0; i < ARRAY_SIZE(extra_dirfd); i++) {
+		const int dirfd = extra_dirfd[i];
+
+		if (dirfd != -1) {
+			ret_next = _test_open_all(dirfd, walker, flags);
+			if (ret_next != ret_init)
+				return -1;
+		}
+	}
+
+	free(walker);
+	return ret_init;
 }
 
+#define test_open(path, flags)	_test_open_ctx(&self->ctx, path, flags)
+
 TEST_F_FORK(layout1, no_restriction)
 {
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
@@ -493,15 +581,28 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 	return ruleset_fd;
 }
 
-static void enforce_ruleset(struct __test_metadata *const _metadata,
-		const int ruleset_fd)
+static void _enforce_ruleset(struct layout_context *const ctx,
+		struct __test_metadata *const _metadata, const int ruleset_fd)
 {
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0)) {
 		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
 	}
+
+	if (ctx->init_sandbox_cwd_fd == -1) {
+		ctx->init_sandbox_cwd_fd = open(".", O_DIRECTORY | O_CLOEXEC);
+		if (ctx->init_sandbox_cwd_fd == -1) {
+			ASSERT_EQ(EACCES, errno);
+			ctx->init_sandbox_cwd_fd = open(".", O_DIRECTORY |
+					O_CLOEXEC | O_PATH);
+			ASSERT_LE(0, ctx->init_sandbox_cwd_fd);
+		}
+	}
 }
 
+#define enforce_ruleset(_metadata, ruleset_fd)	\
+	_enforce_ruleset(&self->ctx, _metadata, ruleset_fd)
+
 TEST_F_FORK(layout1, proc_nsfs)
 {
 	const struct rule rules[] = {
@@ -1265,7 +1366,6 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
-	ASSERT_EQ(0, test_open("s3d3", O_RDONLY));
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
 }
 
@@ -1366,7 +1466,8 @@ enum relative_access {
 	REL_CHROOT_CHDIR,
 };
 
-static void test_relative_path(struct __test_metadata *const _metadata,
+static void _test_relative_path(struct __test_metadata *const _metadata,
+		FIXTURE_DATA(layout1) *const self,
 		const enum relative_access rel)
 {
 	/*
@@ -1479,6 +1580,8 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+#define test_relative_path(_metadata, rel)	_test_relative_path(_metadata, self, rel)
+
 TEST_F_FORK(layout1, relative_open)
 {
 	test_relative_path(_metadata, REL_OPEN);
@@ -1809,7 +1912,8 @@ TEST_F_FORK(layout1, remove_file)
 	ASSERT_EQ(0, unlinkat(AT_FDCWD, file1_s1d3, 0));
 }
 
-static void test_make_file(struct __test_metadata *const _metadata,
+static void _test_make_file(struct __test_metadata *const _metadata,
+		FIXTURE_DATA(layout1) *self,
 		const __u64 access, const mode_t mode, const dev_t dev)
 {
 	const struct rule rules[] = {
@@ -1860,6 +1964,10 @@ static void test_make_file(struct __test_metadata *const _metadata,
 	ASSERT_EQ(0, rename(file1_s1d3, file2_s1d3));
 }
 
+#define test_make_file(_metadata, access, mode, dev)	\
+	_test_make_file(_metadata, self, access, mode, dev)
+
+
 TEST_F_FORK(layout1, make_char)
 {
 	/* Creates a /dev/null device. */
@@ -2076,11 +2184,12 @@ TEST_F_FORK(layout1, proc_pipe)
 }
 
 FIXTURE(layout1_bind) {
+	struct layout_context ctx;
 };
 
 FIXTURE_SETUP(layout1_bind)
 {
-	prepare_layout(_metadata);
+	prepare_layout(_metadata, &self->ctx);
 
 	create_layout1(_metadata);
 
@@ -2097,7 +2206,7 @@ FIXTURE_TEARDOWN(layout1_bind)
 
 	remove_layout1(_metadata);
 
-	cleanup_layout(_metadata);
+	cleanup_layout(_metadata, &self->ctx);
 }
 
 static const char bind_dir_s1d3[] = "./s2d1/s2d2/s1d3";
@@ -2417,11 +2526,12 @@ static const char (*merge_sub_files[])[] = {
  */
 
 FIXTURE(layout2_overlay) {
+	struct layout_context ctx;
 };
 
 FIXTURE_SETUP(layout2_overlay)
 {
-	prepare_layout(_metadata);
+	prepare_layout(_metadata, &self->ctx);
 
 	create_directory(_metadata, LOWER_BASE);
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -2484,7 +2594,7 @@ FIXTURE_TEARDOWN(layout2_overlay)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(MERGE_DATA));
 
-	cleanup_layout(_metadata);
+	cleanup_layout(_metadata, &self->ctx);
 }
 
 TEST_F_FORK(layout2_overlay, no_restriction)
-- 
2.32.0

