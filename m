Return-Path: <linux-fsdevel+bounces-18280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A558B68FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45CBB230B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BF10A3E;
	Tue, 30 Apr 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9GoBIw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BA10A01;
	Tue, 30 Apr 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448229; cv=none; b=qIzrWdf1hQ63Uuhc95+lMvIqofC9lgm8lhG2mPe/0/0ZA5xpqYVbjany9FG50YHwdzVW+j5nJfd5iS59DQHdqxipLGmJGk06s4jl+wFIiWmKSo1nI17UOIj9Km+Jj5ysJqtKwaaNue8Fo4sxNcddefbgFuIE6GrD66ZtB8YyQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448229; c=relaxed/simple;
	bh=YJDOmx6DmnmLiAvVB0dzx1CvDDvtPWmL4uzXT+oXD3w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gw5GGO9lBjpGJ8QzX5gEpND4RVh/ce36/sx0p3hpP3F/qQLpwV6S5roF3UEniFjVhDmGT6F9DfFy2QJEuzhG8yOQLm9e+Bb9uRTXGMTa9k16k84OZuwpmsQXuOAzAPfEQtd5sk1c/1UE6ZmLN97/RABbL6OIL7231tf6L2QGNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9GoBIw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40349C116B1;
	Tue, 30 Apr 2024 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448229;
	bh=YJDOmx6DmnmLiAvVB0dzx1CvDDvtPWmL4uzXT+oXD3w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f9GoBIw9hvF2ZcxUeR3C+craG43eW56kO+NlVUNPgCIlprhDpo/vKZRhr4I4zmTsq
	 1L/Zr2xkOMrJyMexF1xWmFrgbMfycH+UnXvratvTmFU3O5IcUXTz8ais69A7Umd+mW
	 vcH/XYUB/R5ZsXND6dTbeUwKDOTxFusJZJbFHhUDlr6EnznkYicUHwLsHughfBoIhn
	 ArvcFCtlEH7Hb4OKzCizYyzbjTiC7+3OayoJSkpU84a1Qnw6IYM0exVcbNVrsUcFAZ
	 OfKfyMnqUP81KuO/zFqsSl6fpQiTZl9lJSOCJokl5QA/agCeXU6O2H0CJcUHpxtqXi
	 k9mE/PRRy3FUg==
Date: Mon, 29 Apr 2024 20:37:08 -0700
Subject: [PATCH 24/38] xfs_db: dump the verity descriptor
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683480.960383.15143756405243298510.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Dump the fsverity descriptor if fsverity.h is present.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 configure.ac            |    1 +
 db/Makefile             |    4 ++++
 db/attr.c               |   31 +++++++++++++++++++++++++++++++
 db/attrshort.c          |   22 ++++++++++++++++++++--
 db/field.c              |   29 +++++++++++++++++++++++++++++
 db/field.h              |    3 +++
 include/builddefs.in    |    1 +
 include/platform_defs.h |    4 ++++
 m4/package_libcdev.m4   |   18 ++++++++++++++++++
 9 files changed, 111 insertions(+), 2 deletions(-)


diff --git a/configure.ac b/configure.ac
index 1cb7d59c5582..ade0aca58418 100644
--- a/configure.ac
+++ b/configure.ac
@@ -223,6 +223,7 @@ fi
 AC_MANUAL_FORMAT
 AC_HAVE_LIBURCU_ATOMIC64
 AC_USE_RADIX_TREE_FOR_INUMS
+AC_HAVE_FSVERITY_DESCRIPTOR
 
 AC_CONFIG_FILES([include/builddefs])
 AC_OUTPUT
diff --git a/db/Makefile b/db/Makefile
index 02eeead25b49..9fe6fed727e1 100644
--- a/db/Makefile
+++ b/db/Makefile
@@ -78,6 +78,10 @@ LLDLIBS += $(LIBEDITLINE) $(LIBTERMCAP)
 CFLAGS += -DENABLE_EDITLINE
 endif
 
+ifeq ($(HAVE_FSVERITY_DESCR),yes)
+CFLAGS += -DHAVE_FSVERITY_DESCR
+endif
+
 default: depend $(LTCOMMAND)
 
 include $(BUILDRULES)
diff --git a/db/attr.c b/db/attr.c
index 7d8bdeb53032..e05243ff16fa 100644
--- a/db/attr.c
+++ b/db/attr.c
@@ -40,6 +40,7 @@ static int	attr3_remote_merkledata_count(void *obj, int startoff);
 static int	attr_leaf_name_local_merkledata_count(void *obj, int startoff);
 static int	attr_leaf_name_local_merkleoff_count(void *obj, int startoff);
 static int	attr_leaf_name_remote_merkleoff_count(void *obj, int startoff);
+static int	attr_leaf_vdesc_count(void *obj, int startoff);
 
 const field_t	attr_hfld[] = {
 	{ "", FLDT_ATTR, OI(0), C1, 0, TYP_NONE },
@@ -151,6 +152,8 @@ const field_t	attr_leaf_name_flds[] = {
 	  attr_leaf_name_remote_name_count, FLD_COUNT, TYP_NONE },
 	{ "merkle_pos", FLDT_UINT64X, OI(MKROFF(mk_pos)),
 	  attr_leaf_name_remote_merkleoff_count, FLD_COUNT, TYP_NONE },
+	{ "vdesc", FLDT_FSVERITY_DESCR, attr_leaf_name_local_value_offset,
+	  attr_leaf_vdesc_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
 	{ NULL }
 };
 
@@ -717,6 +720,34 @@ attr_leaf_name_remote_merkleoff_count(
 	return attr_leaf_entry_walk(obj, startoff, __leaf_remote_merkleoff_count);
 }
 
+static int
+__leaf_vdesc_count(
+	struct xfs_attr_leafblock	*leaf,
+	struct xfs_attr_leaf_entry      *e,
+	int				i)
+{
+	struct xfs_attr_leaf_name_local	*l;
+
+	if (!(e->flags & XFS_ATTR_LOCAL))
+		return 0;
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) != XFS_ATTR_VERITY)
+		return 0;
+
+	l = xfs_attr3_leaf_name_local(leaf, i);
+	if (l->namelen != XFS_VERITY_DESCRIPTOR_NAME_LEN)
+		return 0;
+
+	return 1;
+}
+
+static int
+attr_leaf_vdesc_count(
+	void				*obj,
+	int				startoff)
+{
+	return attr_leaf_entry_walk(obj, startoff, __leaf_vdesc_count);
+}
+
 int
 attr_size(
 	void	*obj,
diff --git a/db/attrshort.c b/db/attrshort.c
index 1d26a358335f..4ff19d1284c8 100644
--- a/db/attrshort.c
+++ b/db/attrshort.c
@@ -22,6 +22,7 @@ static int	attr_sf_entry_pptr_count(void *obj, int startoff);
 
 static int	attr_sf_entry_merkleoff_count(void *obj, int startoff);
 static int	attr_sf_entry_merkledata_count(void *obj, int startoff);
+static int	attr_sf_entry_vdesc_count(void *obj, int startoff);
 
 const field_t	attr_shortform_flds[] = {
 	{ "hdr", FLDT_ATTR_SF_HDR, OI(0), C1, 0, TYP_NONE },
@@ -66,6 +67,8 @@ const field_t	attr_sf_entry_flds[] = {
 	  attr_sf_entry_merkledata_count, FLD_COUNT | FLD_OFFSET, TYP_NONE },
 	{ "value", FLDT_CHARNS, attr_sf_entry_value_offset,
 	  attr_sf_entry_value_count, FLD_COUNT|FLD_OFFSET, TYP_NONE },
+	{ "vdesc", FLDT_FSVERITY_DESCR, attr_sf_entry_value_offset,
+	  attr_sf_entry_vdesc_count, FLD_COUNT | FLD_OFFSET, TYP_NONE },
 	{ NULL }
 };
 
@@ -112,8 +115,7 @@ attr_sf_entry_value_count(
 	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_PARENT)
 		return 0;
 
-	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
-	    e->namelen == sizeof(struct xfs_merkle_key))
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY)
 		return 0;
 
 	return e->valuelen;
@@ -233,3 +235,19 @@ attr_sf_entry_merkledata_count(
 
 	return 0;
 }
+
+static int
+attr_sf_entry_vdesc_count(
+	void				*obj,
+	int				startoff)
+{
+	struct xfs_attr_sf_entry	*e;
+
+	ASSERT(bitoffs(startoff) == 0);
+	e = (struct xfs_attr_sf_entry *)((char *)obj + byteize(startoff));
+	if ((e->flags & XFS_ATTR_NSP_ONDISK_MASK) == XFS_ATTR_VERITY &&
+	    e->namelen == XFS_VERITY_DESCRIPTOR_NAME_LEN)
+		return 1;
+
+	return 0;
+}
diff --git a/db/field.c b/db/field.c
index 066239ae6073..4f9dafbee182 100644
--- a/db/field.c
+++ b/db/field.c
@@ -33,6 +33,25 @@ const field_t		parent_flds[] = {
 };
 #undef PPOFF
 
+#ifdef HAVE_FSVERITY_DESCR
+# define	OFF(f)	bitize(offsetof(struct fsverity_descriptor, f))
+const field_t	vdesc_flds[] = {
+	{ "version", FLDT_UINT8D, OI(OFF(version)), C1, 0, TYP_NONE },
+	{ "hash_algorithm", FLDT_UINT8D, OI(OFF(hash_algorithm)), C1, 0, TYP_NONE },
+	{ "log_blocksize", FLDT_UINT8D, OI(OFF(log_blocksize)), C1, 0, TYP_NONE },
+	{ "salt_size", FLDT_UINT8D, OI(OFF(salt_size)), C1, 0, TYP_NONE },
+	{ "data_size", FLDT_UINT64D_LE, OI(OFF(data_size)), C1, 0, TYP_NONE },
+	{ "root_hash", FLDT_HEXSTRING, OI(OFF(root_hash)), CI(64), 0, TYP_NONE },
+	{ "salt", FLDT_HEXSTRING, OI(OFF(salt)), CI(32), 0, TYP_NONE },
+	{ NULL }
+};
+# undef OFF
+#else
+const field_t	vdesc_flds[] = {
+	{ NULL }
+};
+#endif
+
 const ftattr_t	ftattrtab[] = {
 	{ FLDT_AGBLOCK, "agblock", fp_num, "%u", SI(bitsz(xfs_agblock_t)),
 	  FTARG_DONULL, fa_agblock, NULL },
@@ -440,6 +459,16 @@ const ftattr_t	ftattrtab[] = {
 	{ FLDT_RGSUMMARY, "rgsummary", NULL, (char *)rgsummary_flds,
 	  btblock_size, FTARG_SIZE, NULL, rgsummary_flds },
 
+	{ FLDT_UINT64D_LE, "uint64d_le", fp_num, "%llu", SI(bitsz(uint64_t)),
+	  FTARG_LE, NULL, NULL },
+
+#ifdef HAVE_FSVERITY_DESCR
+	{ FLDT_FSVERITY_DESCR, "verity", NULL, (char *)vdesc_flds,
+	  SI(bitsz(struct fsverity_descriptor)), 0, NULL, vdesc_flds },
+#else
+	{ FLDT_FSVERITY_DESCR, "verity", NULL, NULL, 0, 0, NULL, NULL },
+#endif
+
 	{ FLDT_ZZZ, NULL }
 };
 
diff --git a/db/field.h b/db/field.h
index 89752d07b84c..bc5426f47293 100644
--- a/db/field.h
+++ b/db/field.h
@@ -211,6 +211,9 @@ typedef enum fldt	{
 	FLDT_SUMINFO,
 	FLDT_RGSUMMARY,
 
+	FLDT_UINT64D_LE,
+	FLDT_FSVERITY_DESCR,
+
 	FLDT_ZZZ			/* mark last entry */
 } fldt_t;
 
diff --git a/include/builddefs.in b/include/builddefs.in
index 5a4008318c84..0e2974044a55 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -114,6 +114,7 @@ HAVE_UDEV = @have_udev@
 UDEV_RULE_DIR = @udev_rule_dir@
 HAVE_LIBURCU_ATOMIC64 = @have_liburcu_atomic64@
 USE_RADIX_TREE_FOR_INUMS = @use_radix_tree_for_inums@
+HAVE_FSVERITY_DESCR = @have_fsverity_descr@
 
 GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
 #	   -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-decl
diff --git a/include/platform_defs.h b/include/platform_defs.h
index 9c28e2744a8d..95f9df0d3d86 100644
--- a/include/platform_defs.h
+++ b/include/platform_defs.h
@@ -174,4 +174,8 @@ static inline size_t __ab_c_size(size_t a, size_t b, size_t c)
 # define barrier() __memory_barrier()
 #endif
 
+#ifdef HAVE_FSVERITY_DESCR
+# include <linux/fsverity.h>
+#endif
+
 #endif	/* __XFS_PLATFORM_DEFS_H__ */
diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
index 711ff81f3332..1edf1fc12d6b 100644
--- a/m4/package_libcdev.m4
+++ b/m4/package_libcdev.m4
@@ -237,3 +237,21 @@ AC_DEFUN([AC_USE_RADIX_TREE_FOR_INUMS],
        AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
     AC_SUBST(use_radix_tree_for_inums)
   ])
+
+#
+# Check if linux/fsverity.h defines the verity descriptor
+#
+AC_DEFUN([AC_HAVE_FSVERITY_DESCRIPTOR],
+  [ AC_MSG_CHECKING([for fsverity_descriptor in linux/fsverity.h ])
+    AC_COMPILE_IFELSE(
+    [	AC_LANG_PROGRAM([[
+#include <linux/types.h>
+#include <linux/fsverity.h>
+	]], [[
+struct fsverity_descriptor m = { };
+	]])
+    ], have_fsverity_descr=yes
+       AC_MSG_RESULT(yes),
+       AC_MSG_RESULT(no))
+    AC_SUBST(have_fsverity_descr)
+  ])


