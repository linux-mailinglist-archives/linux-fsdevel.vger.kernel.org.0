Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26D595D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiHPNar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiHPNai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:30:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053C6B8F09;
        Tue, 16 Aug 2022 06:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74627B819C9;
        Tue, 16 Aug 2022 13:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80BDC433D6;
        Tue, 16 Aug 2022 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656629;
        bh=FllygCNtLO2m8JRLkjcqE6kxOOJd4BymxCTrkj6ZZl0=;
        h=From:To:Cc:Subject:Date:From;
        b=kSTQub2OoA7UcVv9dgvQm+K8UnBWzwKbz7m0mc6w6Wd9TlXczf07bzUBUGgoVkEI2
         9RzvmQ+gAu8vrme7xz4Oqy222ABeq+FKICcX6FBQ/+Vt8Y64DJ/8PO9oRwE6CX+iMY
         qxUitdJi2EtYLWxbdtSd/a1VGomV9hJ/mdw197D2Z8Pi4FiWSGIAwkq94kD2LN4z3l
         GAZTYpZ5PHiMkpAQWARNMGVGvMm19FfziPCiWSyKM+4ti2hRAWFRZ8fdGmJBHNKTUN
         Q7KclckrDbpIi0UKh+T7Cv28qF7DyS5W9+PR1vEnPAWDgp62ltvulgirhk9veUOS1g
         Dpwn4jEKsMnWg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [xfsprogs PATCH] xfs_io: add support for mnt_id and change_attr statx fields
Date:   Tue, 16 Aug 2022 09:30:27 -0400
Message-Id: <20220816133027.43983-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 io/stat.c             |  8 ++++++--
 io/statx.h            | 29 ++++++++++++++++++++++-------
 m4/package_libcdev.m4 | 14 ++++++++++++++
 5 files changed, 47 insertions(+), 9 deletions(-)

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
index b57f9eefed29..a417d859eb88 100644
--- a/io/stat.c
+++ b/io/stat.c
@@ -17,6 +17,8 @@
 
 #include <fcntl.h>
 
+#define IO_STATX_MASK	(STATX_ALL | STATX_MNT_ID | STATX_CHANGE_ATTR)
+
 static cmdinfo_t stat_cmd;
 static cmdinfo_t statfs_cmd;
 static cmdinfo_t statx_cmd;
@@ -349,6 +351,8 @@ dump_raw_statx(struct statx *stx)
 	printf("stat.rdev_minor = %u\n", stx->stx_rdev_minor);
 	printf("stat.dev_major = %u\n", stx->stx_dev_major);
 	printf("stat.dev_minor = %u\n", stx->stx_dev_minor);
+	printf("stat.mnt_id = 0x%llx\n", stx->stx_mnt_id);
+	printf("stat.change_attr = 0x%llx\n", stx->stx_change_attr);
 	return 0;
 }
 
@@ -367,7 +371,7 @@ statx_f(
 	char		*p;
 	struct statx	stx;
 	int		atflag = 0;
-	unsigned int	mask = STATX_ALL;
+	unsigned int	mask = IO_STATX_MASK;
 
 	while ((c = getopt(argc, argv, "m:rvFD")) != EOF) {
 		switch (c) {
@@ -375,7 +379,7 @@ statx_f(
 			if (strcmp(optarg, "basic") == 0)
 				mask = STATX_BASIC_STATS;
 			else if (strcmp(optarg, "all") == 0)
-				mask = STATX_ALL;
+				mask = IO_STATX_MASK;
 			else {
 				mask = strtoul(optarg, &p, 0);
 				if (!p || p == optarg) {
diff --git a/io/statx.h b/io/statx.h
index c6625ac431bf..7b3b23058493 100644
--- a/io/statx.h
+++ b/io/statx.h
@@ -5,6 +5,7 @@
 
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/types.h>
 
 #ifndef AT_EMPTY_PATH
 #define AT_EMPTY_PATH	0x1000
@@ -37,10 +38,10 @@
 #ifndef STATX_TYPE
 /* Pick up kernel definitions if glibc didn't already provide them */
 #include <linux/stat.h>
-#endif
+#endif /* STATX_TYPE */
 
-#ifndef STATX_TYPE
-/* Local definitions if glibc & kernel headers didn't already provide them */
+#ifdef OVERRIDE_SYSTEM_STATX
+/* Local definitions if they don't exist or are too old */
 
 /*
  * Timestamp structure for the timestamps in struct statx.
@@ -56,11 +57,12 @@
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
@@ -99,7 +101,7 @@ struct statx_timestamp {
  * will have values installed for compatibility purposes so that stat() and
  * co. can be emulated in userspace.
  */
-struct statx {
+struct statx_internal {
 	/* 0x00 */
 	__u32	stx_mask;	/* What results were written [uncond] */
 	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
@@ -126,9 +128,13 @@ struct statx {
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
@@ -138,6 +144,7 @@ struct statx {
  * These bits should be set in the mask argument of statx() to request
  * particular items when calling statx().
  */
+#ifndef STATX_TYPE
 #define STATX_TYPE		0x00000001U	/* Want/got stx_mode & S_IFMT */
 #define STATX_MODE		0x00000002U	/* Want/got stx_mode & ~S_IFMT */
 #define STATX_NLINK		0x00000004U	/* Want/got stx_nlink */
@@ -153,6 +160,12 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_ALL		0x00000fffU	/* All currently supported flags */
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
+#endif /* STATX_TYPE */
+
+#ifndef STATX_CHANGE_ATTR
+#define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_CHANGE_ATTR	0x00002000U     /* Want/got stx_change_attr */
+#endif /* STATX_CHANGE_ATTR */
 
 /*
  * Attributes to be found in stx_attributes
@@ -165,6 +178,7 @@ struct statx {
  * semantically.  Where possible, the numerical value is picked to correspond
  * also.
  */
+#ifndef STATX_ATTR_COMPRESSED
 #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
 #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
 #define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
@@ -172,6 +186,7 @@ struct statx {
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#endif /* STATX_ATTR_COMPRESSED */
 
-#endif /* STATX_TYPE */
+#endif /* OVERRIDE_SYSTEM_STATX */
 #endif /* XFS_IO_STATX_H */
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index bb1ab49c11e4..8fde37518323 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -507,3 +507,17 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
     AC_SUBST(lto_cflags)
     AC_SUBST(lto_ldflags)
   ])
+
+AC_DEFUN([AC_NEED_INTERNAL_STATX],
+  [ AC_CHECK_TYPE(struct statx,
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
2.37.2

