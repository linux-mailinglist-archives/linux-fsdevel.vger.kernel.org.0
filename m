Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732083B8AAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhF3XBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 19:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbhF3XA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:00:58 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D47CC0617AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 15:58:29 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GFc3S3wLKzMqJH1;
        Thu,  1 Jul 2021 00:49:24 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4GFc3S1S1zzlh8ms;
        Thu,  1 Jul 2021 00:49:24 +0200 (CEST)
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
Subject: [PATCH v1 3/4] selftests/landlock: Work in a temporary directory
Date:   Thu,  1 Jul 2021 00:48:55 +0200
Message-Id: <20210630224856.1313928-4-mic@digikod.net>
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

To be able to test the current working directory, run all tests in a
temporary directory instead of in its parent directory.  This is
required for the following commit.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210630224856.1313928-4-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 65 ++++++++++++----------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 10c9a1e4ebd9..403c8255311f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -23,31 +23,31 @@
 #include "common.h"
 
 #define TMP_DIR		"tmp"
-#define BINARY_PATH	"./true"
+#define BINARY_PATH	"../true"
 
 /* Paths (sibling number and depth) */
-static const char dir_s1d1[] = TMP_DIR "/s1d1";
-static const char file1_s1d1[] = TMP_DIR "/s1d1/f1";
-static const char file2_s1d1[] = TMP_DIR "/s1d1/f2";
-static const char dir_s1d2[] = TMP_DIR "/s1d1/s1d2";
-static const char file1_s1d2[] = TMP_DIR "/s1d1/s1d2/f1";
-static const char file2_s1d2[] = TMP_DIR "/s1d1/s1d2/f2";
-static const char dir_s1d3[] = TMP_DIR "/s1d1/s1d2/s1d3";
-static const char file1_s1d3[] = TMP_DIR "/s1d1/s1d2/s1d3/f1";
-static const char file2_s1d3[] = TMP_DIR "/s1d1/s1d2/s1d3/f2";
-
-static const char dir_s2d1[] = TMP_DIR "/s2d1";
-static const char file1_s2d1[] = TMP_DIR "/s2d1/f1";
-static const char dir_s2d2[] = TMP_DIR "/s2d1/s2d2";
-static const char file1_s2d2[] = TMP_DIR "/s2d1/s2d2/f1";
-static const char dir_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3";
-static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
-static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
-
-static const char dir_s3d1[] = TMP_DIR "/s3d1";
+static const char dir_s1d1[] = "./s1d1";
+static const char file1_s1d1[] = "./s1d1/f1";
+static const char file2_s1d1[] = "./s1d1/f2";
+static const char dir_s1d2[] = "./s1d1/s1d2";
+static const char file1_s1d2[] = "./s1d1/s1d2/f1";
+static const char file2_s1d2[] = "./s1d1/s1d2/f2";
+static const char dir_s1d3[] = "./s1d1/s1d2/s1d3";
+static const char file1_s1d3[] = "./s1d1/s1d2/s1d3/f1";
+static const char file2_s1d3[] = "./s1d1/s1d2/s1d3/f2";
+
+static const char dir_s2d1[] = "./s2d1";
+static const char file1_s2d1[] = "./s2d1/f1";
+static const char dir_s2d2[] = "./s2d1/s2d2";
+static const char file1_s2d2[] = "./s2d1/s2d2/f1";
+static const char dir_s2d3[] = "./s2d1/s2d2/s2d3";
+static const char file1_s2d3[] = "./s2d1/s2d2/s2d3/f1";
+static const char file2_s2d3[] = "./s2d1/s2d2/s2d3/f2";
+
+static const char dir_s3d1[] = "./s3d1";
 /* dir_s3d2 is a mount point. */
-static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
-static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
+static const char dir_s3d2[] = "./s3d1/s3d2";
+static const char dir_s3d3[] = "./s3d1/s3d2/s3d3";
 
 /*
  * layout1 hierarchy:
@@ -140,11 +140,12 @@ static int remove_path(const char *const path)
 		walker[i] = '\0';
 		ret = rmdir(walker);
 		if (ret) {
-			if (errno != ENOTEMPTY && errno != EBUSY)
+			if (errno != ENOTEMPTY && errno != EBUSY
+					&& errno != EINVAL)
 				err = errno;
 			goto out;
 		}
-		if (strcmp(walker, TMP_DIR) == 0)
+		if (strcmp(walker, ".") == 0)
 			goto out;
 	}
 
@@ -168,10 +169,14 @@ static void prepare_layout(struct __test_metadata *const _metadata)
 	ASSERT_EQ(0, mount("tmp", TMP_DIR, "tmpfs", 0, "size=4m,mode=700"));
 	ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC, NULL));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ASSERT_EQ(0, chdir(TMP_DIR));
 }
 
 static void cleanup_layout(struct __test_metadata *const _metadata)
 {
+	EXPECT_EQ(0, chdir(".."));
+
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, umount(TMP_DIR));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
@@ -1370,7 +1375,7 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	 */
 	const struct rule layer1_base[] = {
 		{
-			.path = TMP_DIR,
+			.path = ".",
 			.access = ACCESS_RO,
 		},
 		{}
@@ -2095,8 +2100,8 @@ FIXTURE_TEARDOWN(layout1_bind)
 	cleanup_layout(_metadata);
 }
 
-static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
-static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
+static const char bind_dir_s1d3[] = "./s2d1/s2d2/s1d3";
+static const char bind_file1_s1d3[] = "./s2d1/s2d2/s1d3/f1";
 
 /*
  * layout1_bind hierarchy:
@@ -2282,7 +2287,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
 }
 
-#define LOWER_BASE	TMP_DIR "/lower"
+#define LOWER_BASE	"./lower"
 #define LOWER_DATA	LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
 static const char lower_dl1[] = LOWER_DATA "/dl1";
@@ -2309,7 +2314,7 @@ static const char (*lower_sub_files[])[] = {
 	NULL
 };
 
-#define UPPER_BASE	TMP_DIR "/upper"
+#define UPPER_BASE	"./upper"
 #define UPPER_DATA	UPPER_BASE "/data"
 #define UPPER_WORK	UPPER_BASE "/work"
 static const char upper_fu1[] = UPPER_DATA "/fu1";
@@ -2337,7 +2342,7 @@ static const char (*upper_sub_files[])[] = {
 	NULL
 };
 
-#define MERGE_BASE	TMP_DIR "/merge"
+#define MERGE_BASE	"./merge"
 #define MERGE_DATA	MERGE_BASE "/data"
 static const char merge_fl1[] = MERGE_DATA "/fl1";
 static const char merge_dl1[] = MERGE_DATA "/dl1";
-- 
2.32.0

