Return-Path: <linux-fsdevel+bounces-18267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828198B68E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB43B23C04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14ED134BD;
	Tue, 30 Apr 2024 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0vCLEkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BE101DE;
	Tue, 30 Apr 2024 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448026; cv=none; b=uJh4QXKVmzg3SQYNJUOwN7JDw+ubp6oW9rJgPEPy4RwDd4Ex9Hm+AXLZyZD0mUCa3WWVhSGUmExFCW7UxoPKVWNSDZekzdm7TOG0/II798JcycXHI4wmqf+P79mevRTryd4sayKGCbqCpZp1Fznq8khUlxIFCSjovk3aWotzxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448026; c=relaxed/simple;
	bh=k/fasQwWEVvmT69L5YC5B1M2Ix2sTLcKSvaSWlRVAw0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOkG2n4TPoo8LpBMB1yDL+jJWcFaEAsL2UMK4Y5xR1kZcQ9E73+8G1WEoM5HVHjRByuRQTuO7t8l4mkb7zygDizWV6xr8dAkk819AOenwmNZ3uZ6kCHho0ArVHMF9XXSVAO1z/cpVLGUkf1dLWZvcsepXx0n/JUx1JJ60El9U5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0vCLEkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB6FC116B1;
	Tue, 30 Apr 2024 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448025;
	bh=k/fasQwWEVvmT69L5YC5B1M2Ix2sTLcKSvaSWlRVAw0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E0vCLEkNYGLb75mkCroQVjIO9WSs4KGENHdk3QXxrRPQOaiCdoxAglikx0UBpVwEO
	 XAzmkpv2JwVdLS+LkWja/dD224dWKAYtjAF54uIsV7+3XOC9O4pOsP2nzG8Y4ziAtV
	 NmboNW/n8ypzEpr1sZ8elv7q1YfmcveeBeayvp+GbBbWZFwhEuUgqop7Ls8ZA0mwJO
	 uAMOdlpNJgaHRmvCAtzvOg24hQMs1ydUIcncRFE6EOY2mXjnfQ8nCw4MZ5ZkWF6hT7
	 fxlqsmZpkpKrIufbakYZ0JVSYIduwoZigQlEp0lcMLurnDQ+3vKY/KuogClqEnQJaE
	 t6+C9Oo924h2g==
Date: Mon, 29 Apr 2024 20:33:45 -0700
Subject: [PATCH 11/38] xfs: add fs-verity support
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683281.960383.4385904319578267037.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

Add integration with fs-verity. The XFS store fs-verity metadata in
the extended file attributes. The metadata consist of verity
descriptor and Merkle tree blocks.

The descriptor is stored under "vdesc" extended attribute. The
Merkle tree blocks are stored under binary indexes which are offsets
into the Merkle tree.

When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
flag is set meaning that the Merkle tree is being build. The
initialization ends with storing of verity descriptor and setting
inode on-disk flag (XFS_DIFLAG2_VERITY).

The verification on read is done in read path of iomap.

Merkle tree blocks are indexed by a per-AG rhashtable to reduce the time
it takes to load a block from disk in a manner that doesn't bloat struct
xfs_inode.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: replace caching implementation with an xarray, other cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/Makefile        |    6 +++--
 libxfs/xfs_ag.h        |    8 +++++++
 libxfs/xfs_attr.c      |    4 +++
 libxfs/xfs_da_format.h |   14 ++++++++++++
 libxfs/xfs_ondisk.h    |    3 ++
 libxfs/xfs_verity.c    |   58 ++++++++++++++++++++++++++++++++++++++++++++++++
 libxfs/xfs_verity.h    |   13 +++++++++++
 7 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 libxfs/xfs_verity.c
 create mode 100644 libxfs/xfs_verity.h


diff --git a/libxfs/Makefile b/libxfs/Makefile
index ac3484efe914..c67e9449835e 100644
--- a/libxfs/Makefile
+++ b/libxfs/Makefile
@@ -69,7 +69,8 @@ HFILES = \
 	xfs_shared.h \
 	xfs_trans_resv.h \
 	xfs_trans_space.h \
-	xfs_dir2_priv.h
+	xfs_dir2_priv.h \
+	xfs_verity.h
 
 CFILES = buf_mem.c \
 	cache.c \
@@ -131,7 +132,8 @@ CFILES = buf_mem.c \
 	xfs_trans_inode.c \
 	xfs_trans_resv.c \
 	xfs_trans_space.c \
-	xfs_types.c
+	xfs_types.c \
+	xfs_verity.c
 
 #
 # Tracing flags:
diff --git a/libxfs/xfs_ag.h b/libxfs/xfs_ag.h
index 80bf8771ea2a..792ce162312e 100644
--- a/libxfs/xfs_ag.h
+++ b/libxfs/xfs_ag.h
@@ -123,6 +123,12 @@ struct xfs_perag {
 
 	/* Hook to feed rmapbt updates to an active online repair. */
 	struct xfs_hooks	pag_rmap_update_hooks;
+
+# ifdef CONFIG_FS_VERITY
+	/* per-inode merkle tree caches */
+	spinlock_t		pagi_merkle_lock;
+	struct rhashtable	pagi_merkle_blobs;
+# endif /* CONFIG_FS_VERITY */
 #endif /* __KERNEL__ */
 };
 
@@ -135,6 +141,7 @@ struct xfs_perag {
 #define XFS_AGSTATE_ALLOWS_INODES	3
 #define XFS_AGSTATE_AGFL_NEEDS_RESET	4
 #define XFS_AGSTATE_NOALLOC		5
+#define XFS_AGSTATE_MERKLE		6
 
 #define __XFS_AG_OPSTATE(name, NAME) \
 static inline bool xfs_perag_ ## name (struct xfs_perag *pag) \
@@ -148,6 +155,7 @@ __XFS_AG_OPSTATE(prefers_metadata, PREFERS_METADATA)
 __XFS_AG_OPSTATE(allows_inodes, ALLOWS_INODES)
 __XFS_AG_OPSTATE(agfl_needs_reset, AGFL_NEEDS_RESET)
 __XFS_AG_OPSTATE(prohibits_alloc, NOALLOC)
+__XFS_AG_OPSTATE(caches_merkle, MERKLE)
 
 void xfs_free_unused_perag_range(struct xfs_mount *mp, xfs_agnumber_t agstart,
 			xfs_agnumber_t agend);
diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index c2c411268904..94c425b984d2 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -26,6 +26,7 @@
 #include "xfs_trace.h"
 #include "defer_item.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1618,6 +1619,9 @@ xfs_attr_namecheck(
 	if (!xfs_attr_check_namespace(attr_flags))
 		return false;
 
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xfs_verity_namecheck(attr_flags, name, length);
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index c84b94da3f32..43e9d1f00a4a 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -929,4 +929,18 @@ struct xfs_parent_rec {
 	__be32	p_gen;
 } __packed;
 
+/*
+ * fs-verity attribute name format
+ *
+ * Merkle tree blocks are stored under extended attributes of the inode.  The
+ * name of the attributes are byte positions into the merkle data.
+ */
+struct xfs_merkle_key {
+	__be64	mk_pos;
+};
+
+/* ondisk xattr name used for the fsverity descriptor */
+#define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/libxfs/xfs_ondisk.h b/libxfs/xfs_ondisk.h
index 7a312aed2337..03aaf508e4a4 100644
--- a/libxfs/xfs_ondisk.h
+++ b/libxfs/xfs_ondisk.h
@@ -209,6 +209,9 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
 
+	/* fs-verity xattrs */
+	XFS_CHECK_STRUCT_SIZE(struct xfs_merkle_key,		8);
+	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME),	6);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/libxfs/xfs_verity.c b/libxfs/xfs_verity.c
new file mode 100644
index 000000000000..8d1a759f995b
--- /dev/null
+++ b/libxfs/xfs_verity.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Red Hat, Inc.
+ */
+#include "libxfs_priv.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_log_format.h"
+#include "xfs_attr.h"
+#include "xfs_verity.h"
+
+/* Set a merkle tree pos in preparation for setting merkle tree attrs. */
+void
+xfs_merkle_key_to_disk(
+	struct xfs_merkle_key	*key,
+	uint64_t		pos)
+{
+	key->mk_pos = cpu_to_be64(pos);
+}
+
+/* Retrieve the merkle tree pos from the attr data. */
+uint64_t
+xfs_merkle_key_from_disk(
+	const void		*attr_name,
+	int			namelen)
+{
+	const struct xfs_merkle_key *key = attr_name;
+
+	ASSERT(namelen == sizeof(struct xfs_merkle_key));
+
+	return be64_to_cpu(key->mk_pos);
+}
+
+/* Return true if verity attr name is valid. */
+bool
+xfs_verity_namecheck(
+	unsigned int		attr_flags,
+	const void		*name,
+	int			namelen)
+{
+	if (!(attr_flags & XFS_ATTR_VERITY))
+		return false;
+
+	/*
+	 * Merkle tree pages are stored under u64 indexes; verity descriptor
+	 * blocks are held in a named attribute.
+	 */
+	if (namelen != sizeof(struct xfs_merkle_key) &&
+	    namelen != XFS_VERITY_DESCRIPTOR_NAME_LEN)
+		return false;
+
+	return true;
+}
diff --git a/libxfs/xfs_verity.h b/libxfs/xfs_verity.h
new file mode 100644
index 000000000000..5813665c5a01
--- /dev/null
+++ b/libxfs/xfs_verity.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_VERITY_H__
+#define __XFS_VERITY_H__
+
+void xfs_merkle_key_to_disk(struct xfs_merkle_key *key, uint64_t pos);
+uint64_t xfs_merkle_key_from_disk(const void *attr_name, int namelen);
+bool xfs_verity_namecheck(unsigned int attr_flags, const void *name,
+		int namelen);
+
+#endif	/* __XFS_VERITY_H__ */


