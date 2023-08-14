Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333877BEED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjHNR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHNR2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317DB10D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a5ac5c29so61493747b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034123; x=1692638923;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooTRBNPvBWcG23633hOLwSy6Pk7nUFD8xNZxmRBXym8=;
        b=WFrKfE5rS+qGWhqVn80/6LlJCufkjc8dtuB0aDdOxsN8vroVEOTRGM9rUsa0bmwGaA
         vpkiCG7HBo4rNTRfeHBzddmhLw7R/zFyxKqr2ihytKuys8/7uZkgpGd8DdiX+JYYMP2D
         Lrz1Qwnn8VzrSfk7G8135XLxVyN+hTeOoJqbyuDmw2yf8O14tNeF7BqH8PGOBzvpBajS
         TzYGSY4em2sl2KK5G1k0J/9YGYmh6h7Y/CXknqloVB/oiyG1CmSLsi0HOQcBY10J/Byx
         oqGTGlfPTudZyJoJ+6/Iln7nK4BhRTZCsgjulUZob7JX1P4c5iAGPh03rjZa13zyRlHr
         NMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034123; x=1692638923;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ooTRBNPvBWcG23633hOLwSy6Pk7nUFD8xNZxmRBXym8=;
        b=jPEHJ+HUZ58oG6VQOqkQ1fEkayLluKA/Xp9s/04FsEoFp60vwRAPNlQjyUBegRq2Y8
         slhcSE0mpLL6YSlqmiU0UIs/g9GsQ/FohmnfLtaJcZy1MXEmlVHKTm33bHienV7UIR5t
         o/ZbLCyUxSLwTI6LV0f2wXJgSJepvZhU6Ilr3FqxC+u7n7sOzG5JUH1TLT5E/FSlAX6K
         oPGD8M8NelaDDj4BqcG5bpgwHXU+AgPtaKbi0dWt35Ei6d1xSrJWBrSdDVQsQRzUwfSW
         NTo4dTFkquunZJMlcLbNcTG6/mQb0yOsV79JEBfZCw74Q96e6zRwaAnHjShUzs8a3uKx
         gizw==
X-Gm-Message-State: AOJu0YzwNaMhr41kklwhxlXyi4HIiwzkikyj7rONhvw3NXwBh7L5ayE1
        O02kl0bzvoyYyIz1fYrr6ATrcgsXUR4=
X-Google-Smtp-Source: AGHT+IHwZBIIV5T8nIbKG/c/meAKnRLxIj2igiWWybKGpAyCcQlVNNJp42MCF5UrI60uuh6hz9Xlarm+Ofs=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a05:6902:4c7:b0:d0f:a0a6:8e87 with SMTP id
 v7-20020a05690204c700b00d0fa0a68e87mr131848ybs.2.1692034123461; Mon, 14 Aug
 2023 10:28:43 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:12 +0200
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
Message-Id: <20230814172816.3907299-2-gnoack@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 1/5] landlock: Add ioctl access right
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
and increments the Landlock ABI version to 4.

Like the truncate right, these rights are associated with a file
descriptor at the time of open(2), and get respected even when the
file descriptor is used outside of the thread which it was originally
opened in.

A newly enabled Landlock policy therefore does not apply to file
descriptors which are already open.

If a file was opened without the LANDLOCK_ACCESS_FS_IOCTL right, IOCTL
attempts on the opened file will fail, except for a small number of
common and harmless IOCTL commands (see documentation).

Noteworthy scenarios which require special attention:

TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
used to control shell processes on the same terminal which run at
different privilege levels, which may make it possible to escape a
sandbox.  Because stdin, stdout and stderr are normally inherited
rather than newly opened, IOCTLs are usually permitted on them even
after the Landlock policy is enforced.

Some legitimate file system features, like setting up fscrypt, are
exposed as IOCTL commands on regular files and directories -- users of
Landlock are advised to double check that the sandboxed process does
not require these IOCTLs.

Known limitations:

The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
over IOCTL commands.  Future work will enable a more fine-grained
access control for IOCTLs.

In the meantime, Landlock users may use path-based restrictions in
combination with their knowledge about the file system layout to
control what IOCTLs can be done.  Mounting file systems with the nodev
option can help to distinguish regular files and devices, and give
guarantees about the affected files, which Landlock alone can not give
yet.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                | 31 +++++++++++-----
 security/landlock/fs.c                       | 38 ++++++++++++++++++--
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  5 +--
 6 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 81d09ef9aa50..3c1d4f1e084d 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -92,7 +92,7 @@ struct landlock_path_beneath_attr {
  * files and directories.  Files or directories opened before the sandboxi=
ng
  * are not subject to these restrictions.
  *
- * A file can only receive these access rights:
+ * The following access rights apply only to files:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
  * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note t=
hat
@@ -102,12 +102,13 @@ struct landlock_path_beneath_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in t=
he
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since =
the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version =
of the
+ *   Landlock ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or=
 used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same wa=
y as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories. =
 The
  * following access right is applied to the directory itself, and the
@@ -162,13 +163,26 @@ struct landlock_path_beneath_attr {
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
  *
+ * The following access right applies both to files and directories:
+ *
+ * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` commands on an =
opened
+ *   file or directory.
+ *
+ *   This access right applies to all :manpage:`ioctl(2)` commands, except=
 of
+ *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC`` and ``FIONREAD``=
.
+ *   These commands continue to be invokable independent of the
+ *   %LANDLOCK_ACCESS_FS_IOCTL access right.
+ *
+ *   This access right is available since the fourth version of the Landlo=
ck
+ *   ABI.
+ *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -187,6 +201,7 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
 /* clang-format on */
=20
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..3b4a6263f5a9 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -7,6 +7,7 @@
  * Copyright =C2=A9 2021-2022 Microsoft Corporation
  */
=20
+#include <asm/ioctls.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
@@ -147,7 +148,8 @@ static struct landlock_object *get_inode_object(struct =
inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 /* clang-format on */
=20
 /*
@@ -1207,7 +1209,8 @@ static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
 	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE |
+					      LANDLOCK_ACCESS_FS_IOCTL;
 	const struct landlock_ruleset *const dom =3D
 		landlock_get_current_domain();
=20
@@ -1280,6 +1283,36 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	/*
+	 * These IOCTL commands are generally permitted with Landlock: FIOCLEX,
+	 * FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's close-on-exec and
+	 * the file's buffered-IO and async flags.  These operations are also
+	 * available through fcntl(2).  FIONREAD returns the number of
+	 * immediately writable bytes.
+	 */
+	switch (cmd) {
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIONBIO:
+	case FIOASYNC:
+	case FIONREAD:
+		return 0;
+	}
+
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether ioctl can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_IOCTL)
+		return 0;
+	return -EACCES;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1302,6 +1335,7 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
 };
=20
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 82288f0e9e5e..40d8f17698b6 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
=20
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 245cc650a4dc..c70fc9e6fe9e 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops =3D {
 	.write =3D fop_dummy_write,
 };
=20
-#define LANDLOCK_ABI_VERSION 3
+#define LANDLOCK_ABI_VERSION 4
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 792c3f0a59b4..646f778dfb1e 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 83d565569512..09dd1eaac8a9 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -523,9 +523,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
--=20
2.41.0.694.ge786442a9b-goog

