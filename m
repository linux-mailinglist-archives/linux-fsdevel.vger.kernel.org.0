Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B758DF90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiHIS5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347169AbiHISzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:55:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472429806;
        Tue,  9 Aug 2022 11:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F24B8B81611;
        Tue,  9 Aug 2022 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413F7C433D6;
        Tue,  9 Aug 2022 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660069613;
        bh=JjHTUeqw28p16hzsAQonvrFVs4eLRC6jMsU0b3SQTsw=;
        h=From:To:Cc:Subject:Date:From;
        b=s6CWtjwvE6NOm0o9yilMgkYYsUufu8admB476kpZmy3Qy+SEqWENrpu8J11QwnqNT
         tjLzrsWnbStdIaEwTiO/Bn29IZVgbZf4TVfUYFjtsKLFtZXfSExyx8fpyLYnipZNnj
         O+uJkU2k/btlWxbaA0/C4d5ZuBFSy3fff/ROoiKl2kNvo5AGiCliGbWDHS9sb2QsZp
         OvR/9CoEKw0W3CHqRlyFs5SiXxKdWuJcGwDJv9NGKYUou5AuuThNEvc9SdMU8PP6iB
         2PINffLh9szkz/gD7pmKU4dKVlQfQbAa7GkMozJ6a/lrZy4lePsNF1+Z7d/T1W5isC
         jalo8taF6Sw+g==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] xfs_io: add support for mnt_id and change_attr statx fields
Date:   Tue,  9 Aug 2022 14:26:51 -0400
Message-Id: <20220809182651.163033-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for the new mnt_id field and the proposed change_attr field
in statx to xfs_io. Add a new autoconf test to see whether the system's
struct statx has the requisite fields. If not, or if there is no struct
statx defined, then use the internal definitions in statx.h.

Wrap most of the preprocessor constants in #ifdefs so that we only
redefine the values needed. Since we can't undefine a struct definition,
postfix their names with "_internal" and use the preprocessor to
override the struct definitions.

Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac          |  1 +
 include/builddefs.in  |  4 ++++
 io/stat.c             |  4 +++-
 io/statx.h            | 33 +++++++++++++++++++++++++--------
 m4/package_libcdev.m4 | 15 +++++++++++++++
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6c13eff1e5e8..e1c216ef7016 100644
--- a/configure.ac
+++ b/configure.ac
@@ -187,6 +187,7 @@ AC_HAVE_FSETXATTR
 AC_HAVE_MREMAP
 AC_NEED_INTERNAL_FSXATTR
 AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
+AC_NEED_INTERNAL_STATX
 AC_HAVE_GETFSMAP
 AC_HAVE_STATFS_FLAGS
 AC_HAVE_MAP_SYNC
diff --git a/include/builddefs.in b/include/builddefs.in
index e0a2f3cbc954..4c690ee3a89b 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -110,6 +110,7 @@ HAVE_FSETXATTR = @have_fsetxattr@
 HAVE_MREMAP = @have_mremap@
 NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
 NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
+NEED_INTERNAL_STATX = @need_internal_statx@
 HAVE_GETFSMAP = @have_getfsmap@
 HAVE_STATFS_FLAGS = @have_statfs_flags@
 HAVE_MAP_SYNC = @have_map_sync@
@@ -155,6 +156,9 @@ endif
 ifeq ($(NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG),yes)
 PCFLAGS+= -DOVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG
 endif
+ifeq ($(NEED_INTERNAL_STATX),yes)
+PCFLAGS+= -DOVERRIDE_SYSTEM_STATX
+endif
 ifeq ($(HAVE_GETFSMAP),yes)
 PCFLAGS+= -DHAVE_GETFSMAP
 endif
diff --git a/io/stat.c b/io/stat.c
index b57f9eefed29..974701565d2f 100644
--- a/io/stat.c
+++ b/io/stat.c
@@ -8,9 +8,9 @@
 
 #include "command.h"
 #include "input.h"
+#include "statx.h"
 #include "init.h"
 #include "io.h"
-#include "statx.h"
 #include "libxfs.h"
 #include "libfrog/logging.h"
 #include "libfrog/fsgeom.h"
@@ -349,6 +349,8 @@ dump_raw_statx(struct statx *stx)
 	printf("stat.rdev_minor = %u\n", stx->stx_rdev_minor);
 	printf("stat.dev_major = %u\n", stx->stx_dev_major);
 	printf("stat.dev_minor = %u\n", stx->stx_dev_minor);
+	printf("stat.mnt_id = 0x%llx\n", stx->stx_mnt_id);
+	printf("stat.change_attr = 0x%llx\n", stx->stx_change_attr);
 	return 0;
 }
 
diff --git a/io/statx.h b/io/statx.h
index c6625ac431bf..3dd447147894 100644
--- a/io/statx.h
+++ b/io/statx.h
@@ -5,6 +5,7 @@
 
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/types.h>
 
 #ifndef AT_EMPTY_PATH
 #define AT_EMPTY_PATH	0x1000
@@ -37,10 +38,9 @@
 #ifndef STATX_TYPE
 /* Pick up kernel definitions if glibc didn't already provide them */
 #include <linux/stat.h>
-#endif
-
-#ifndef STATX_TYPE
-/* Local definitions if glibc & kernel headers didn't already provide them */
+#endif /* STATX_TYPE */
+#ifdef OVERRIDE_SYSTEM_STATX
+/* Local definitions if they don't exist or are too old */
 
 /*
  * Timestamp structure for the timestamps in struct statx.
@@ -56,11 +56,12 @@
  *
  * __reserved is held in case we need a yet finer resolution.
  */
-struct statx_timestamp {
+struct statx_timestamp_internal {
 	__s64	tv_sec;
 	__s32	tv_nsec;
 	__s32	__reserved;
 };
+#define statx_timestamp statx_timestamp_internal
 
 /*
  * Structures for the extended file attribute retrieval system call
@@ -99,7 +100,7 @@ struct statx_timestamp {
  * will have values installed for compatibility purposes so that stat() and
  * co. can be emulated in userspace.
  */
-struct statx {
+struct statx_internal {
 	/* 0x00 */
 	__u32	stx_mask;	/* What results were written [uncond] */
 	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
@@ -126,9 +127,13 @@ struct statx {
 	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
 	__u32	stx_dev_minor;
 	/* 0x90 */
-	__u64	__spare2[14];	/* Spare space for future expansion */
+	__u64	stx_mnt_id;
+	__u64	stx_change_attr;
+	/* 0xa0 */
+	__u64	__spare2[12];	/* Spare space for future expansion */
 	/* 0x100 */
 };
+#define statx statx_internal
 
 /*
  * Flags to be stx_mask
@@ -138,6 +143,7 @@ struct statx {
  * These bits should be set in the mask argument of statx() to request
  * particular items when calling statx().
  */
+#ifndef STATX_TYPE
 #define STATX_TYPE		0x00000001U	/* Want/got stx_mode & S_IFMT */
 #define STATX_MODE		0x00000002U	/* Want/got stx_mode & ~S_IFMT */
 #define STATX_NLINK		0x00000004U	/* Want/got stx_nlink */
@@ -153,6 +159,15 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_ALL		0x00000fffU	/* All currently supported flags */
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
+#endif /* STATX_TYPE */
+
+#ifndef STATX_CHANGE_ATTR
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_CHANGE_ATTR	0x00002000U     /* Want/got stx_change_attr */
+#endif /* STATX_CHANGE_ATTR */
+
+
+
 
 /*
  * Attributes to be found in stx_attributes
@@ -165,6 +180,7 @@ struct statx {
  * semantically.  Where possible, the numerical value is picked to correspond
  * also.
  */
+#ifndef STATX_ATTR_COMPRESSED
 #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
 #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
 #define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
@@ -172,6 +188,7 @@ struct statx {
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#endif /* STATX_ATTR_COMPRESSED */
 
-#endif /* STATX_TYPE */
+#endif /* OVERRIDE_SYSTEM_STATX */
 #endif /* XFS_IO_STATX_H */
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index bb1ab49c11e4..f2f7fd5b3fc6 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -507,3 +507,18 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
     AC_SUBST(lto_cflags)
     AC_SUBST(lto_ldflags)
   ])
+
+AC_DEFUN([AC_NEED_INTERNAL_STATX],
+  [ AC_MSG_CHECKING([for struct statx.stx_change_attr])
+    AC_CHECK_TYPE(struct statx,
+      [
+        AC_CHECK_MEMBER(struct statx.stx_change_attr,
+          ,
+          need_internal_statx=yes,
+          [#include <linux/stat.h>]
+        )
+      ],,
+      [#include <linux/stat.h>]
+    )
+    AC_SUBST(need_internal_statx)
+  ])
-- 
2.37.1

