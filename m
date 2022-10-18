Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EAD603248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJRSXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJRSWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610DC8263C;
        Tue, 18 Oct 2022 11:22:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s30so21778800eds.1;
        Tue, 18 Oct 2022 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxrb/R+LIlvDBRxezargrUidMjxxYVQiRlTvZstHXqI=;
        b=KT2lgZ7Pfg5gYwfhLrdDwEima5OcwqxFvBggyNUcYCaAXsi50/cVFzhbnS84HJilPH
         Qle2Tl1lKEou3FBuzI2enMEXP9Wi0Tzh7yiBQzRqAbIkDPsfvjokpyGrCMufnzRhC3e6
         9g+VkViWf7otsjxRbGjNq5dfkuVdnhKH5MLgWB1HJlwHzcNNwdgEm+EOBzAOWMm1vtRS
         HXuaRnwmykOeSNjqBkl8qoZ6IrXANOg92f0xNQ8tVT4+TbMr/Rtt+CwxIzLN4ZaV04gN
         j2z1fjLKmaLSJ6Fn4XoerGQ+E29TLzBaHZoGImB+vNc2XPWfAu0Dgy9JZe79RyxpxCZd
         xp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nxrb/R+LIlvDBRxezargrUidMjxxYVQiRlTvZstHXqI=;
        b=iSZ/md6cDL9RoGoH6sMVXh5/PLul2WU6KlVuJldq0ycWCSRjSn5TjaxNpiSZKa0HEa
         /xWWHRc/k8vyrHiZ4J6040gmSq7fovbJFYonhHTuH0cU5Z+uo+N7ndxIKeQ2+uDzs29r
         CG44PJ5bDoZBzHZbAhxJZab0Mm3jCgE0tSfo40rBPPpoxzRsv4YuXlck+cvA1r/bPGSp
         o+h5v+DoTv274iepc/Vyb3teoEtdQLZpjd1LZq/rGEdOQSePzABma2V+Zp43/Av2Pna8
         y+bNtuxZBMmVan5BOxNSPHqCUoT9aHfB5alwzSbFO7JlAZcdTDqYFYEMzAk4/K5QqaDD
         MLww==
X-Gm-Message-State: ACrzQf0F8EcZj3rzr3LgptfsUyUYLGSPQMiXde/lPzSfq5PBOamGY8YX
        N6OvxLY4fLzT+LQO8qPcHX/TvVE8RPg=
X-Google-Smtp-Source: AMsMyM5cC5wFQRLQmMwzJH9K/WjTZ+lU22Gkeiv7xRBivDYrHCeb04Hki43trLxzLocmGlpjw/l5wA==
X-Received: by 2002:a05:6402:3584:b0:45d:8fd7:f798 with SMTP id y4-20020a056402358400b0045d8fd7f798mr3790288edc.356.1666117352524;
        Tue, 18 Oct 2022 11:22:32 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:32 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v10 04/11] landlock: Support file truncation
Date:   Tue, 18 Oct 2022 20:22:09 +0200
Message-Id: <20221018182216.301684-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018182216.301684-1-gnoack3000@gmail.com>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
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

This flag hooks into the path_truncate, file_truncate and
file_alloc_security LSM hooks and covers file truncation using
truncate(2), ftruncate(2), open(2) with O_TRUNC, as well as creat().

This change also increments the Landlock ABI version, updates
corresponding selftests, and updates code documentation to document
the flag.

In security/security.c, allocate security blobs at pointer-aligned
offsets. This fixes the problem where one LSM's security blob can
shift another LSM's security blob to an unaligned address. (Reported
by Nathan Chancellor)

The following operations are restricted:

open(2): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
implicitly truncated as part of the open() (e.g. using O_TRUNC).

Notable special cases:
* open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
* open() with O_TRUNC does *not* need the TRUNCATE right when it
  creates a new file.

truncate(2) (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
right.

ftruncate(2) (on a file): requires that the file had the TRUNCATE
right when it was previously opened. File descriptors acquired by
other means than open(2) (e.g. memfd_create(2)) continue to support
truncation with ftruncate(2).

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                |  21 +++-
 security/landlock/fs.c                       | 104 ++++++++++++++++++-
 security/landlock/fs.h                       |  24 +++++
 security/landlock/limits.h                   |   2 +-
 security/landlock/setup.c                    |   1 +
 security/landlock/syscalls.c                 |   2 +-
 security/security.c                          |  11 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   7 +-
 9 files changed, 153 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 9c4bcc37a455..f3223f964691 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -95,8 +95,19 @@ struct landlock_path_beneath_attr {
  * A file can only receive these access rights:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
- * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
+ * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
+ *   you might additionally need the %LANDLOCK_ACCESS_FS_TRUNCATE right in order
+ *   to overwrite files with :manpage:`open(2)` using ``O_TRUNC`` or
+ *   :manpage:`creat(2)`.
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
+ * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
+ *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
+ *   ``O_TRUNC``. Whether an opened file can be truncated with
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
index 87fde50eb550..adcea0fe7e68 100644
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
@@ -1154,9 +1155,23 @@ static int hook_path_rmdir(const struct path *const dir,
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
+static int hook_path_truncate(const struct path *const path)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
+}
+
 /* File hooks */
 
-static inline access_mask_t get_file_access(const struct file *const file)
+/**
+ * get_required_file_open_access - Get access needed to open a file
+ *
+ * @file: File being opened.
+ *
+ * Returns the access rights that are required for opening the given file,
+ * depending on the file type and open mode.
+ */
+static inline access_mask_t
+get_required_file_open_access(const struct file *const file)
 {
 	access_mask_t access = 0;
 
@@ -1174,19 +1189,95 @@ static inline access_mask_t get_file_access(const struct file *const file)
 	return access;
 }
 
+static int hook_file_alloc_security(struct file *const file)
+{
+	/*
+	 * Grants all access rights, even if most of them are not checked later
+	 * on. It is more consistent.
+	 *
+	 * Notably, file descriptors for regular files can also be acquired
+	 * without going through the file_open hook, for example when using
+	 * memfd_create(2).
+	 */
+	landlock_file(file)->allowed_access = LANDLOCK_MASK_ACCESS_FS;
+	return 0;
+}
+
 static int hook_file_open(struct file *const file)
 {
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+	access_mask_t open_access_request, full_access_request, allowed_access;
+	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
 
 	if (!dom)
 		return 0;
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
+	if (is_access_to_paths_allowed(
+		    dom, &file->f_path,
+		    init_layer_masks(dom, full_access_request, &layer_masks),
+		    &layer_masks, NULL, 0, NULL, NULL)) {
+		allowed_access = full_access_request;
+	} else {
+		unsigned long access_bit;
+		const unsigned long access_req = full_access_request;
+
+		/*
+		 * Calculate the actual allowed access rights from layer_masks.
+		 * Add each access right to allowed_access which has not been
+		 * vetoed by any layer.
+		 */
+		allowed_access = 0;
+		for_each_set_bit(access_bit, &access_req,
+				 ARRAY_SIZE(layer_masks)) {
+			if (!layer_masks[access_bit])
+				allowed_access |= BIT_ULL(access_bit);
+		}
+	}
+
+	/*
+	 * For operations on already opened files (i.e. ftruncate()), it is the
+	 * access rights at the time of open() which decide whether the
+	 * operation is permitted. Therefore, we record the relevant subset of
+	 * file access rights in the opened struct file.
+	 */
+	landlock_file(file)->allowed_access = allowed_access;
+
+	if ((open_access_request & allowed_access) == open_access_request)
+		return 0;
+
+	return -EACCES;
+}
+
+static int hook_file_truncate(struct file *const file)
+{
+	/*
+	 * Allows truncation if the truncate right was available at the time of
+	 * opening the file, to get a consistent access check as for read, write
+	 * and execute operations.
+	 *
+	 * Note: For checks done based on the file's Landlock allowed access, we
+	 * enforce them independently of whether the current thread is in a
+	 * Landlock domain, so that open files passed between independent
+	 * processes retain their behaviour.
+	 */
+	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_TRUNCATE)
+		return 0;
+	return -EACCES;
 }
 
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
@@ -1206,8 +1297,11 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
+	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
 
+	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
+	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
 };
 
 __init void landlock_add_fs_hooks(void)
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
index 2ca0ccbd905a..245cc650a4dc 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 2
+#define LANDLOCK_ABI_VERSION 3
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/security/security.c b/security/security.c
index b55596958d0c..e0fe4ba39eb9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -185,11 +185,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
 {
 	int offset;
 
-	if (*need > 0) {
-		offset = *lbs;
-		*lbs += *need;
-		*need = offset;
-	}
+	if (*need <= 0)
+		return;
+
+	offset = ALIGN(*lbs, sizeof(void *));
+	*lbs = offset + *need;
+	*need = offset;
 }
 
 static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
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
2.38.0

