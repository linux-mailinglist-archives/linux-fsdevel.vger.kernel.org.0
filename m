Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C675F1D50
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJAPtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJAPtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:49:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D357209;
        Sat,  1 Oct 2022 08:49:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so9469544edc.10;
        Sat, 01 Oct 2022 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6GwzhcjTDdWfIT5p6fUXVZmAEKRE1bVAwqtESjsbzZo=;
        b=cVKwoYzlGKC6Ykjkgk0B5pN+qB2S4zbrzckDRtVAzVnXNbiFxd7pCQAHk4k7xNyASr
         gD32YUixNukCE5UUK3LK/Cq4lHablm1ZTtTx5T3BPl/qJ1xlSrFrnuYPoaTJEilymc49
         Zrw01qRI73S6zcrOe+7hIB1EOR+Wq+slB15K9EWK5f46w/6FxA23qPsc4Et2XbzHBUFX
         MwaqeQ2/zwmYP7ZTtRvQ6P7LUdXXv5FnPLHNgvGHgCI35AX3gwz2xh/LlXWEz9mtDVTG
         zmtR8ZR7QPpOWoLxA5/Ab+HfVI0wXTiRajHDq0giE0uHjjcv1x+IcxE9sJ9K6Rm6P+LF
         hnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6GwzhcjTDdWfIT5p6fUXVZmAEKRE1bVAwqtESjsbzZo=;
        b=JKW0iHSNelTDS4GqKIMgl1LD+oMRdEVeF4r20am/uIysGqOyr5qnOnhJfRCaanZXEs
         pNug+jweE/itMjDRNCccaIuVTnBeWAzluhF7l/TXfCrvmKzaPcQs6AXoIA678VI/Mmfv
         uj4a51ryJ0c3UKp/cEpN2ZcQYO9nQNJgpLqqmo2BtSjFA9cf/XaYsMAB7Ebq7FQaZGQp
         xhLFRMVnrqNcOavUiY4Baz/GxSquA0rhnI03ATJMl/VEh/WjH2cU8moQDWT9jKJ+mEmH
         J1FgZ8AsjOD1PFg1mppKJ7eEwSoWLMiVrjAiow8DCrK5Oo2TdCMRF2onGeWWpGR0WILV
         xm4A==
X-Gm-Message-State: ACrzQf1yl7OIO3Eoe2qoQcxWWPjuKEbAh0yNFh/1pyDfBKfrRGWj2QdR
        UNoxWXfmAyHnbb0kdxujXpU/xaR+pKQ=
X-Google-Smtp-Source: AMsMyM7U6mNM9Aw0pzhK8fgT42DRTzB7YDSwnaR0s1ohqf2A8W6GLNVI0m93+AInx26t8zZt0AHLSQ==
X-Received: by 2002:a05:6402:5ca:b0:445:c80a:3c2 with SMTP id n10-20020a05640205ca00b00445c80a03c2mr11859150edx.247.1664639370203;
        Sat, 01 Oct 2022 08:49:30 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b00458cc5f802asm617151edr.73.2022.10.01.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:49:29 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v8 4/9] landlock: Support file truncation
Date:   Sat,  1 Oct 2022 17:49:03 +0200
Message-Id: <20221001154908.49665-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

The following operations are restricted:

open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
implicitly truncated as part of the open() (e.g. using O_TRUNC).

Notable special cases:
* open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
* open() with O_TRUNC does *not* need the TRUNCATE right when it
  creates a new file.

truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
right.

ftruncate() (on a file): requires that the file had the TRUNCATE right
when it was previously opened.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                |  21 +++-
 security/landlock/fs.c                       | 102 +++++++++++++++++--
 security/landlock/fs.h                       |  24 +++++
 security/landlock/limits.h                   |   2 +-
 security/landlock/setup.c                    |   1 +
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   7 +-
 8 files changed, 144 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 23df4e0e8ace..d830cdfdbe56 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -95,8 +95,19 @@ struct landlock_path_beneath_attr {
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
+ *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
+ *   `O_TRUNC`. Whether an opened file can be truncated with
+ *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in the
+ *   same way as read and write permissions are checked during
+ *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
+ *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since the
+ *   third version of the Landlock ABI.
  *
  * A directory can receive access rights related to files or directories.  The
  * following access right is applied to the directory itself, and the
@@ -139,10 +150,9 @@ struct landlock_path_beneath_attr {
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
@@ -160,6 +170,7 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
+#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 083dd3d359de..80d507ce2305 100644
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
@@ -297,6 +298,18 @@ get_handled_accesses(const struct landlock_ruleset *const domain)
 	return access_dom & LANDLOCK_MASK_ACCESS_FS;
 }
 
+/*
+ * init_layer_masks - Populates @layer_masks such that for each access right in
+ * @access_request, the bits for all the layers are set where this access right
+ * is handled.
+ *
+ * @domain: The domain that defines the current restrictions.
+ * @access_request: The requested access rights to check.
+ * @layer_masks: The layer masks to populate.
+ *
+ * Returns: An access mask where each access right bit is set which is handled
+ * in any of the active layers in @domain.
+ */
 static inline access_mask_t
 init_layer_masks(const struct landlock_ruleset *const domain,
 		 const access_mask_t access_request,
@@ -1141,9 +1154,19 @@ static int hook_path_rmdir(const struct path *const dir,
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
+static int hook_path_truncate(const struct path *const path)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
+}
+
 /* File hooks */
 
-static inline access_mask_t get_file_access(const struct file *const file)
+/*
+ * get_required_file_open_access - Returns the access rights that are required
+ * for opening the file, depending on the file type and open mode.
+ */
+static inline access_mask_t
+get_required_file_open_access(const struct file *const file)
 {
 	access_mask_t access = 0;
 
@@ -1163,17 +1186,82 @@ static inline access_mask_t get_file_access(const struct file *const file)
 
 static int hook_file_open(struct file *const file)
 {
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	access_mask_t open_access_request, full_access_request, allowed_access;
+	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
 
-	if (!dom)
+	if (!dom) {
+		/*
+		 * Grants all access rights, even if most of them are not
+		 * checked later on. It is more consistent.
+		 */
+		landlock_file(file)->allowed_access = LANDLOCK_MASK_ACCESS_FS;
 		return 0;
+	}
+
 	/*
-	 * Because a file may be opened with O_PATH, get_file_access() may
-	 * return 0.  This case will be handled with a future Landlock
+	 * Because a file may be opened with O_PATH, get_required_file_open_access()
+	 * may return 0.  This case will be handled with a future Landlock
 	 * evolution.
 	 */
-	return check_access_path(dom, &file->f_path, get_file_access(file));
+	open_access_request = get_required_file_open_access(file);
+
+	/*
+	 * We look up more access than what we immediately need for open(), so
+	 * that we can later authorize operations on opened files.
+	 */
+	full_access_request = open_access_request | optional_access;
+
+	allowed_access = full_access_request;
+	if (!is_access_to_paths_allowed(
+		    dom, &file->f_path,
+		    init_layer_masks(dom, full_access_request, &layer_masks),
+		    &layer_masks, NULL, 0, NULL, NULL)) {
+		unsigned long access_bit;
+		unsigned long access_req = full_access_request;
+
+		/*
+		 * Calculate the actual allowed access rights from layer_masks.
+		 * Remove each access right from allowed_access which has been
+		 * vetoed by any layer.
+		 */
+		for_each_set_bit(access_bit, &access_req,
+				 ARRAY_SIZE(layer_masks)) {
+			if (layer_masks[access_bit])
+				allowed_access &= ~BIT_ULL(access_bit);
+		}
+	}
+
+	if (open_access_request & ~allowed_access)
+		return -EACCES;
+
+	/*
+	 * For operations on already opened files (i.e. ftruncate()), it is the
+	 * access rights at the time of open() which decide whether the
+	 * operation is permitted. Therefore, we record the relevant subset of
+	 * file access rights in the opened struct file.
+	 */
+	landlock_file(file)->allowed_access = allowed_access;
+	return 0;
+}
+
+static int hook_file_truncate(struct file *const file)
+{
+	/*
+	 * Allows truncation if the truncate right was available at the time of
+	 * opening the file, to get a consistent access check as for read, write
+	 * and execute operations.
+	 *
+	 * Note: For checks done based on the file's Landlock rights, we enforce
+	 * them independently of whether the current thread is in a Landlock
+	 * domain, so that open files passed between independent processes
+	 * retain their behaviour.
+	 */
+	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_TRUNCATE)
+		return 0;
+	return -EACCES;
 }
 
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
@@ -1193,6 +1281,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
+	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
 
 	LSM_HOOK_INIT(file_open, hook_file_open),
 };
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 8db7acf9109b..488e4813680a 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -36,6 +36,24 @@ struct landlock_inode_security {
 	struct landlock_object __rcu *object;
 };
 
+/**
+ * struct landlock_file_security - File security blob
+ *
+ * This information is populated when opening a file in hook_file_open, and
+ * tracks the relevant Landlock access rights that were available at the time
+ * of opening the file. Other LSM hooks use these rights in order to authorize
+ * operations on already opened files.
+ */
+struct landlock_file_security {
+	/**
+	 * @allowed_access: Access rights that were available at the time of
+	 * opening the file. This is not necessarily the full set of access
+	 * rights available at that time, but it's the necessary subset as
+	 * needed to authorize later operations on the open file.
+	 */
+	access_mask_t allowed_access;
+};
+
 /**
  * struct landlock_superblock_security - Superblock security blob
  *
@@ -50,6 +68,12 @@ struct landlock_superblock_security {
 	atomic_long_t inode_refs;
 };
 
+static inline struct landlock_file_security *
+landlock_file(const struct file *const file)
+{
+	return file->f_security + landlock_blob_sizes.lbs_file;
+}
+
 static inline struct landlock_inode_security *
 landlock_inode(const struct inode *const inode)
 {
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
 
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..3f196d2ce4f9 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -19,6 +19,7 @@ bool landlock_initialized __lsm_ro_after_init = false;
 
 struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct landlock_cred_security),
+	.lbs_file = sizeof(struct landlock_file_security),
 	.lbs_inode = sizeof(struct landlock_inode_security),
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
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
index 45de42a027c5..87b28d14a1aa 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -406,9 +406,10 @@ TEST_F_FORK(layout1, inval)
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
@@ -422,7 +423,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	ACCESS_LAST)
+	LANDLOCK_ACCESS_FS_REFER)
 
 /* clang-format on */
 
-- 
2.37.3

