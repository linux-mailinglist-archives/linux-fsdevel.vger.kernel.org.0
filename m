Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DD597808
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbiHQUaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbiHQUaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:30:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE4A98F3;
        Wed, 17 Aug 2022 13:30:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i14so26478115ejg.6;
        Wed, 17 Aug 2022 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/Vvzr+OTnuwQXrGOY+/lEBQwn9fiaqN6qenxPjftdtA=;
        b=OWg8AKmmBdBR81D7+pa0uu/X/Dn1NbnjLKPKaafykls/r91xnJ7jHUDqkt8cV2cssA
         xb83kFZ+AcTxezyww4vhEFYEegm+cBOQDUdx3DoFvR2RbRZkeBuqGxuBPw4Y3wtPGDEz
         +zvnWyrHaGueTCHi+VcVHsiNd/a6Igc9akHZeH7mw28mKoknuJ81kByACMcaD2jbcr+0
         fTtLkAJoy8K4G08z7ARuR9PTQk6HkYhJgrJXns9x++zEkFbha1vpenvfiovBAk2hrxXU
         ZlDGrYx/4tnguKDqA4/KatBAxwqdOsEXWJAH8FpR56r3qMa+4+AO+rVNl6uBoVMR27Ty
         xj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/Vvzr+OTnuwQXrGOY+/lEBQwn9fiaqN6qenxPjftdtA=;
        b=uDpWOL8JBqdJaw1eErUSjU9xEXaRbQZD/uJOMT5jWKfZEsv8ZbMA3cmmEIKn6KdGFN
         FQLwyQpUN+2zoU6kccAXMeaKnnqxbXP5m0xKjbyEFzdHIIBAUbUdXHjmXLU5JbfZgyH/
         l2vP40AcSqRzeTS4raPT2nAkRjZUTQJLLJuUCB71AWf5aEI3Bo5+Nddlh8N4L+LyJTtl
         UyXAXAGoCA0b+XknhZAlK9fyt6tnZXnwGwh3cS2WqlI8hQEbs7V0zr/W+o0eb5UgfL8U
         Q6pNqutulgEmqIXJy/3xTm2IpL3pEldi3fmMnlmETHvyD784vvxjf4PbZsdwkQ9683dN
         Smmw==
X-Gm-Message-State: ACgBeo0l4JJe6CcVvVJgMRut/9HK0NhU2y633uf+nxeuOHsvOS5Bg482
        IINRr+NcwiKGLrenFKfrIS2tgdZJaiA=
X-Google-Smtp-Source: AA6agR7BDddie+aAYCAxA4jJ5qGAEpU+Fsi3V2tSRTc7yjYbOcgZ9SfdYLlW+Dz9RZ6DTKvjiQgsKw==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr18237094ejd.174.1660768217881;
        Wed, 17 Aug 2022 13:30:17 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090653c700b0073b0c2d420dsm512042ejo.217.2022.08.17.13.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:30:17 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v5 1/4] landlock: Support file truncation
Date:   Wed, 17 Aug 2022 22:30:03 +0200
Message-Id: <20220817203006.21769-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817203006.21769-1-gnoack3000@gmail.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.

This flag hooks into the path_truncate LSM hook and covers file
truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
well as creat().

This change also increments the Landlock ABI version, updates
corresponding selftests, and updates code documentation to document
the flag.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                | 17 ++++++++++++-----
 security/landlock/fs.c                       |  9 ++++++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  7 ++++---
 6 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 23df4e0e8ace..50c35404c4d3 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -95,8 +95,15 @@ struct landlock_path_beneath_attr {
  * A file can only receive these access rights:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
- * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
+ * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
+ *   you might additionally need the `LANDLOCK_ACCESS_FS_TRUNCATE` right in
+ *   order to overwrite files with :manpage:`open(2)` using `O_TRUNC` or
+ *   :manpage:`creat(2)`.
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
+ * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
+ *   :manpage:`ftruncate(2)`, :manpage:`open(2)` with `O_TRUNC` or
+ *   :manpage:`creat(2)`. This access right is available since the third version
+ *   of the Landlock ABI.
  *
  * A directory can receive access rights related to files or directories.  The
  * following access right is applied to the directory itself, and the
@@ -139,10 +146,9 @@ struct landlock_path_beneath_attr {
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
- *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
- *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
- *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
- *   :manpage:`access(2)`.
+ *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
+ *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
+ *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -160,6 +166,7 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
+#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ec5a6247cd3e..c57f581a9cd5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -146,7 +146,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_READ_FILE)
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 /* clang-format on */
 
 /*
@@ -1140,6 +1141,11 @@ static int hook_path_rmdir(const struct path *const dir,
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
+static int hook_path_truncate(const struct path *const path)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
+}
+
 /* File hooks */
 
 static inline access_mask_t get_file_access(const struct file *const file)
@@ -1192,6 +1198,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
+	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
 
 	LSM_HOOK_INIT(file_open, hook_file_open),
 };
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index b54184ab9439..82288f0e9e5e 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 735a0865ea11..f4d6fc7ed17f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 2
+#define LANDLOCK_ABI_VERSION 3
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index da9290817866..72cdae277b02 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..cb77eaa01c91 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -399,9 +399,10 @@ TEST_F_FORK(layout1, inval)
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_READ_FILE)
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
@@ -415,7 +416,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	ACCESS_LAST)
+	LANDLOCK_ACCESS_FS_REFER)
 
 /* clang-format on */
 
-- 
2.37.2

