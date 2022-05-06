Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD051DD37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443610AbiEFQNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443585AbiEFQNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:34 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD24E6EB27
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:09:48 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwWD3d6lzMprsq;
        Fri,  6 May 2022 18:09:44 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwWD15TzzlhSLy;
        Fri,  6 May 2022 18:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853384;
        bh=I7EZhSC3AUC9NjlYd6g70uKXcXU27Qtij4wWmQ3PV6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zka+y2XoPa6a6wvNEmXvlkpp6nXy3ryx+3lSfeFLZ6ApRkrf7iBdPuC+LzkIlewbo
         fVGO7xzJYstJCPVdLhkbkg+afvuwGsiccUyW52HMleX/fBx+DMYSEkvgp0nPUOYlbf
         cnECg92guS/LUfuDtFE07A+9ENdTupul2DetEVhQ=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 08/12] selftests/landlock: Add 11 new test suites dedicated to file reparenting
Date:   Fri,  6 May 2022 18:10:58 +0200
Message-Id: <20220506161102.525323-9-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These test suites try to check all edge cases for directory and file
renaming or linking involving a new parent directory, with and without
LANDLOCK_ACCESS_FS_REFER and other access rights.

layout1:
* reparent_refer: Tests simple FS_REFER usage.
* reparent_link: Tests a mix of FS_MAKE_REG and FS_REFER with links.
* reparent_rename: Tests a mix of FS_MAKE_REG and FS_REFER with renames
  and RENAME_EXCHANGE.
* reparent_exdev_layers_rename1/2: Tests renames with two layers.
* reparent_exdev_layers_exchange1/2/3: Tests exchanges with two layers.
* reparent_remove: Tests file and directory removal with rename.
* reparent_dom_superset: Tests access partial ordering.

layout1_bind:
* reparent_cross_mount: Tests FS_REFER propagation across mount points.

Test coverage for security/landlock is 95.4% of 604 lines according to
gcc/gcov-11.

Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-9-mic@digikod.net
---

Changes since v2:
* Add test coverage in patch description.
* Format with clang-format and rebase.

Changes since v1:
* Add tests specific to RENAME_EXCHANGE and split
  layout1.reparent_exdev_layers to avoid inconsistent layout
  modifications and make these tests easier to understand.
* Add full error predominance tests with RENAME_EXCHANGE to
  layout1.reparent_exdev_layers* .  This now work as expected thanks to
  the rename hook change.
* Add layout1.reparent_remove tests to check file and directory removal
  with rename.
* Improve the remove_path() helper to handle unlinking paths with
  non-existing components.
---
 tools/testing/selftests/landlock/fs_test.c | 755 ++++++++++++++++++++-
 1 file changed, 754 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 69f9c7409198..21a2ce8fa739 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -146,7 +146,7 @@ static int remove_path(const char *const path)
 		goto out;
 	}
 	if (unlink(path) && rmdir(path)) {
-		if (errno != ENOENT)
+		if (errno != ENOENT && errno != ENOTDIR)
 			err = errno;
 		goto out;
 	}
@@ -1972,6 +1972,721 @@ TEST_F_FORK(layout1, rename_dir)
 	ASSERT_EQ(0, rmdir(dir_s1d3));
 }
 
+TEST_F_FORK(layout1, reparent_refer)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{},
+	};
+	int ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d2));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+
+	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d2));
+	ASSERT_EQ(EXDEV, errno);
+	/*
+	 * Moving should only be allowed when the source and the destination
+	 * parent directory have REFER.
+	 */
+	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d3));
+	ASSERT_EQ(ENOTEMPTY, errno);
+	ASSERT_EQ(0, unlink(file1_s2d3));
+	ASSERT_EQ(0, unlink(file2_s2d3));
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s2d3));
+}
+
+TEST_F_FORK(layout1, reparent_link)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s2d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(
+		_metadata,
+		LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	/* Denies linking because of missing MAKE_REG. */
+	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	/* Denies linking because of missing source and destination REFER. */
+	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+	/* Denies linking because of missing source REFER. */
+	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Denies linking because of missing MAKE_REG. */
+	ASSERT_EQ(-1, link(file1_s2d2, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	/* Denies linking because of missing destination REFER. */
+	ASSERT_EQ(-1, link(file1_s2d2, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Allows linking because of REFER and MAKE_REG. */
+	ASSERT_EQ(0, link(file1_s2d2, file1_s1d3));
+	ASSERT_EQ(0, unlink(file1_s2d2));
+	/* Reverse linking denied because of missing MAKE_REG. */
+	ASSERT_EQ(-1, link(file1_s1d3, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s2d3));
+	/* Checks reverse linking. */
+	ASSERT_EQ(0, link(file1_s1d3, file1_s2d3));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	/*
+	 * This is OK for a file link, but it should not be allowed for a
+	 * directory rename (because of the superset of access rights.
+	 */
+	ASSERT_EQ(0, link(file1_s2d3, file1_s1d3));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, link(file2_s1d3, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
+	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
+}
+
+TEST_F_FORK(layout1, reparent_rename)
+{
+	/* Same rules as for reparent_link. */
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s2d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(
+		_metadata,
+		LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	/* Denies renaming because of missing MAKE_REG. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file1_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	/* Even denies same file exchange. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Denies renaming because of missing source and destination REFER. */
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+	/*
+	 * Denies renaming because of missing MAKE_REG, source and destination
+	 * REFER.
+	 */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file2_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file1_s2d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Denies renaming because of missing source REFER. */
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+	/* Denies renaming because of missing MAKE_REG. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file2_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Denies renaming because of missing MAKE_REG. */
+	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	/* Denies renaming because of missing destination REFER*/
+	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Denies exchange because of one missing MAKE_REG. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, file2_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	/* Allows renaming because of REFER and MAKE_REG. */
+	ASSERT_EQ(0, rename(file1_s2d2, file1_s1d3));
+
+	/* Reverse renaming denied because of missing MAKE_REG. */
+	ASSERT_EQ(-1, rename(file1_s1d3, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s2d3));
+	ASSERT_EQ(0, rename(file1_s1d3, file1_s2d3));
+
+	/* Tests reverse renaming. */
+	ASSERT_EQ(0, rename(file1_s2d3, file1_s1d3));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s1d3,
+			       RENAME_EXCHANGE));
+	ASSERT_EQ(0, rename(file1_s1d3, file1_s2d3));
+
+	/*
+	 * This is OK for a file rename, but it should not be allowed for a
+	 * directory rename (because of the superset of access rights).
+	 */
+	ASSERT_EQ(0, rename(file1_s2d3, file1_s1d3));
+	ASSERT_EQ(0, rename(file1_s1d3, file1_s2d3));
+
+	/*
+	 * Tests superset restrictions applied to directories.  Not only the
+	 * dir_s2d3's parent (dir_s2d2) should be taken into account but also
+	 * access rights tied to dir_s2d3. dir_s2d2 is missing one access right
+	 * compared to dir_s1d3/file1_s1d3 (MAKE_REG) but it is provided
+	 * directly by the moved dir_s2d3.
+	 */
+	ASSERT_EQ(0, rename(dir_s2d3, file1_s1d3));
+	ASSERT_EQ(0, rename(file1_s1d3, dir_s2d3));
+	/*
+	 * The first rename is allowed but not the exchange because dir_s1d3's
+	 * parent (dir_s1d2) doesn't have REFER.
+	 */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, dir_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, file1_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, rename(file1_s2d3, dir_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+
+	ASSERT_EQ(-1, rename(file2_s1d2, file1_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, rename(file2_s1d3, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Renaming in the same directory is always allowed. */
+	ASSERT_EQ(0, rename(file2_s1d2, file1_s1d2));
+	ASSERT_EQ(0, rename(file2_s1d3, file1_s1d3));
+
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	/* Denies because of missing source MAKE_REG and destination REFER. */
+	ASSERT_EQ(-1, rename(dir_s2d3, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	/* Denies because of missing source MAKE_REG and REFER. */
+	ASSERT_EQ(-1, rename(dir_s2d2, file1_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+}
+
+static void
+reparent_exdev_layers_enforce1(struct __test_metadata *const _metadata)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			/* Interesting for the layer2 tests. */
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = dir_s2d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(
+		_metadata,
+		LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+static void
+reparent_exdev_layers_enforce2(struct __test_metadata *const _metadata)
+{
+	const struct rule layer2[] = {
+		{
+			.path = dir_s2d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_DIR,
+		},
+		{},
+	};
+	/*
+	 * Same checks as before but with a second layer and a new MAKE_DIR
+	 * rule (and no explicit handling of REFER).
+	 */
+	const int ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_MAKE_DIR, layer2);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
+{
+	ASSERT_EQ(0, unlink(file1_s2d2));
+	ASSERT_EQ(0, unlink(file1_s2d3));
+
+	reparent_exdev_layers_enforce1(_metadata);
+
+	/*
+	 * Moving the dir_s1d3 directory below dir_s2d2 is allowed by Landlock
+	 * because it doesn't inherit new access rights.
+	 */
+	ASSERT_EQ(0, rename(dir_s1d3, file1_s2d2));
+	ASSERT_EQ(0, rename(file1_s2d2, dir_s1d3));
+
+	/*
+	 * Moving the dir_s1d3 directory below dir_s2d3 is allowed, even if it
+	 * gets a new inherited access rights (MAKE_REG), because MAKE_REG is
+	 * already allowed for dir_s1d3.
+	 */
+	ASSERT_EQ(0, rename(dir_s1d3, file1_s2d3));
+	ASSERT_EQ(0, rename(file1_s2d3, dir_s1d3));
+
+	/*
+	 * However, moving the file1_s1d3 file below dir_s2d3 is allowed
+	 * because it cannot inherit MAKE_REG right (which is dedicated to
+	 * directories).
+	 */
+	ASSERT_EQ(0, rename(file1_s1d3, file1_s2d3));
+
+	reparent_exdev_layers_enforce2(_metadata);
+
+	/*
+	 * Moving the dir_s1d3 directory below dir_s2d2 is now denied because
+	 * MAKE_DIR is not tied to dir_s2d2.
+	 */
+	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Moving the dir_s1d3 directory below dir_s2d3 is forbidden because it
+	 * would grants MAKE_REG and MAKE_DIR rights to it.
+	 */
+	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+
+	/*
+	 * However, moving the file2_s1d3 file below dir_s2d3 is allowed
+	 * because it cannot inherit MAKE_REG nor MAKE_DIR rights (which are
+	 * dedicated to directories).
+	 */
+	ASSERT_EQ(0, rename(file2_s1d3, file1_s2d3));
+}
+
+TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
+{
+	reparent_exdev_layers_enforce1(_metadata);
+
+	/* Checks EACCES predominance over EXDEV. */
+	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+	/* Modify layout! */
+	ASSERT_EQ(0, rename(file1_s1d2, file1_s2d3));
+
+	/* Without REFER source. */
+	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	reparent_exdev_layers_enforce2(_metadata);
+
+	/* Checks EACCES predominance over EXDEV. */
+	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	/* Checks with actual file2_s1d2. */
+	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+	/* Modify layout! */
+	ASSERT_EQ(0, rename(file2_s1d2, file1_s2d3));
+
+	/* Without REFER source, EACCES wins over EXDEV. */
+	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d2));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
+{
+	const char *const dir_file1_s1d2 = file1_s1d2, *const dir_file2_s2d3 =
+							       file2_s2d3;
+
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, mkdir(file1_s1d2, 0700));
+	ASSERT_EQ(0, unlink(file2_s2d3));
+	ASSERT_EQ(0, mkdir(file2_s2d3, 0700));
+
+	reparent_exdev_layers_enforce1(_metadata);
+
+	/* Error predominance with file exchange: returns EXDEV and EACCES. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Checks with directories which creation could be allowed, but denied
+	 * because of access rights that would be inherited.
+	 */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD,
+				dir_file2_s2d3, RENAME_EXCHANGE));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD,
+				dir_file1_s1d2, RENAME_EXCHANGE));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Checks with same access rights. */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s2d3,
+			       RENAME_EXCHANGE));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
+			       RENAME_EXCHANGE));
+
+	/* Checks with different (child-only) access rights. */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_file1_s1d2,
+			       RENAME_EXCHANGE));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD, dir_s2d3,
+			       RENAME_EXCHANGE));
+
+	/*
+	 * Checks that exchange between file and directory are consistent.
+	 *
+	 * Moving a file (file1_s2d2) to a directory which only grants more
+	 * directory-related access rights is allowed, and at the same time
+	 * moving a directory (dir_file2_s2d3) to another directory which
+	 * grants less access rights is allowed too.
+	 *
+	 * See layout1.reparent_exdev_layers_exchange3 for inverted arguments.
+	 */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
+			       RENAME_EXCHANGE));
+	/*
+	 * However, moving back the directory is denied because it would get
+	 * more access rights than the current state and because file creation
+	 * is forbidden (in dir_s2d2).
+	 */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	reparent_exdev_layers_enforce2(_metadata);
+
+	/* Error predominance with file exchange: returns EXDEV and EACCES. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Checks with directories which creation is now denied. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD,
+				dir_file2_s2d3, RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD,
+				dir_file1_s1d2, RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Checks with different (child-only) access rights. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s2d3,
+				RENAME_EXCHANGE));
+	/* Denied because of MAKE_DIR. */
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Checks with different (child-only) access rights. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_file1_s1d2,
+				RENAME_EXCHANGE));
+	/* Denied because of MAKE_DIR. */
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD, dir_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* See layout1.reparent_exdev_layers_exchange2 for complement. */
+}
+
+TEST_F_FORK(layout1, reparent_exdev_layers_exchange2)
+{
+	const char *const dir_file2_s2d3 = file2_s2d3;
+
+	ASSERT_EQ(0, unlink(file2_s2d3));
+	ASSERT_EQ(0, mkdir(file2_s2d3, 0700));
+
+	reparent_exdev_layers_enforce1(_metadata);
+	reparent_exdev_layers_enforce2(_metadata);
+
+	/* Checks that exchange between file and directory are consistent. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, reparent_exdev_layers_exchange3)
+{
+	const char *const dir_file2_s2d3 = file2_s2d3;
+
+	ASSERT_EQ(0, unlink(file2_s2d3));
+	ASSERT_EQ(0, mkdir(file2_s2d3, 0700));
+
+	reparent_exdev_layers_enforce1(_metadata);
+
+	/*
+	 * Checks that exchange between file and directory are consistent,
+	 * including with inverted arguments (see
+	 * layout1.reparent_exdev_layers_exchange1).
+	 */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
+			       RENAME_EXCHANGE));
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, reparent_remove)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_REMOVE_DIR,
+		},
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(
+		_metadata,
+		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_REMOVE_DIR |
+			LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Access denied because of wrong/swapped remove file/dir. */
+	ASSERT_EQ(-1, rename(file1_s1d1, dir_s2d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s2d2, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s2d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Access allowed thanks to the matching rights. */
+	ASSERT_EQ(-1, rename(file1_s2d1, dir_s1d2));
+	ASSERT_EQ(EISDIR, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d1));
+	ASSERT_EQ(ENOTDIR, errno);
+	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d1));
+	ASSERT_EQ(ENOTDIR, errno);
+	ASSERT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+	ASSERT_EQ(0, rename(dir_s1d3, file1_s2d1));
+
+	/* Effectively removes a file and a directory by exchanging them. */
+	ASSERT_EQ(0, mkdir(dir_s1d3, 0700));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
+			       RENAME_EXCHANGE));
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, reparent_dom_superset)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = file1_s1d2,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_SOCK |
+				  LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_EXECUTE |
+				  LANDLOCK_ACCESS_FS_MAKE_SOCK,
+		},
+		{
+			.path = dir_s2d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_MAKE_FIFO,
+		},
+		{},
+	};
+	int ruleset_fd = create_ruleset(_metadata,
+					LANDLOCK_ACCESS_FS_REFER |
+						LANDLOCK_ACCESS_FS_EXECUTE |
+						LANDLOCK_ACCESS_FS_MAKE_SOCK |
+						LANDLOCK_ACCESS_FS_READ_FILE |
+						LANDLOCK_ACCESS_FS_MAKE_FIFO,
+					layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+	/*
+	 * Moving file1_s1d2 beneath dir_s2d3 would grant it the READ_FILE
+	 * access right.
+	 */
+	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+	/*
+	 * Moving file1_s1d2 should be allowed even if dir_s2d2 grants a
+	 * superset of access rights compared to dir_s1d2, because file1_s1d2
+	 * already has these access rights anyway.
+	 */
+	ASSERT_EQ(0, rename(file1_s1d2, file1_s2d2));
+	ASSERT_EQ(0, rename(file1_s2d2, file1_s1d2));
+
+	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d1));
+	ASSERT_EQ(EXDEV, errno);
+	/*
+	 * Moving dir_s1d3 beneath dir_s2d3 would grant it the MAKE_FIFO access
+	 * right.
+	 */
+	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+	/*
+	 * Moving dir_s1d3 should be allowed even if dir_s2d2 grants a superset
+	 * of access rights compared to dir_s1d2, because dir_s1d3 already has
+	 * these access rights anyway.
+	 */
+	ASSERT_EQ(0, rename(dir_s1d3, file1_s2d2));
+	ASSERT_EQ(0, rename(file1_s2d2, dir_s1d3));
+
+	/*
+	 * Moving file1_s2d3 beneath dir_s1d2 is allowed, but moving it back
+	 * will be denied because the new inherited access rights from dir_s1d2
+	 * will be less than the destination (original) dir_s2d3.  This is a
+	 * sinkhole scenario where we cannot move back files or directories.
+	 */
+	ASSERT_EQ(0, rename(file1_s2d3, file2_s1d2));
+	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(0, unlink(file2_s1d2));
+	ASSERT_EQ(0, unlink(file2_s2d3));
+	/*
+	 * Checks similar directory one-way move: dir_s2d3 loses EXECUTE and
+	 * MAKE_SOCK which were inherited from dir_s1d3.
+	 */
+	ASSERT_EQ(0, rename(dir_s2d3, file2_s1d2));
+	ASSERT_EQ(-1, rename(file2_s1d2, dir_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+}
+
 TEST_F_FORK(layout1, remove_dir)
 {
 	const struct rule rules[] = {
@@ -2520,6 +3235,44 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
 }
 
+TEST_F_FORK(layout1_bind, reparent_cross_mount)
+{
+	const struct rule layer1[] = {
+		{
+			/* dir_s2d1 is beneath the dir_s2d2 mount point. */
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path = bind_dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{},
+	};
+	int ruleset_fd = create_ruleset(
+		_metadata,
+		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_EXECUTE, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks basic denied move. */
+	ASSERT_EQ(-1, rename(file1_s1d1, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Checks real cross-mount move (Landlock is not involved). */
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s2d2));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Checks move that will give more accesses. */
+	ASSERT_EQ(-1, rename(file1_s2d2, bind_file1_s1d3));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Checks legitimate downgrade move. */
+	ASSERT_EQ(0, rename(bind_file1_s1d3, file1_s2d2));
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
-- 
2.35.1

