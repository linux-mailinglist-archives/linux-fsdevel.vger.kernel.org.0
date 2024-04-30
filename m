Return-Path: <linux-fsdevel+bounces-18253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AA8B68B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E901C21CBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783461118C;
	Tue, 30 Apr 2024 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdVpHkU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFFADDA6;
	Tue, 30 Apr 2024 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447806; cv=none; b=L+N3Zb3YaQfCx473HkHfH64z6tiqebRDmVENZGjXZA6Ws95vblh/5d+eHkVGkY6HX9MmQwlC56/cZawOPT/JRU7gYjhUjgm33yDn1Mk6TJq8MI/T49QPYjHcAitzUDilC/oJfO7wxAkwb/jcF0xV8/DfpU6FZHlzQwhlwEoKTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447806; c=relaxed/simple;
	bh=onh5fSUvb4T8Q52MEVObwn5ZKikQJKXx88H4RpZBu4o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ox4vbL/iMf35SuV9uAXos/kL/+Q1RC1AWmeFDv3kT7/ERjJ5n2sfQ4l4gd9ja6Xv2+BDWPJ8m5H55pwY95sTMaEL8B8NhUySSBgTN5ANSKBKWitcDCglJS3nxfeWgEE/aADCrTcMelfgLGP28thlGvjl3ENDag3HiXtablQpm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdVpHkU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E10C116B1;
	Tue, 30 Apr 2024 03:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447806;
	bh=onh5fSUvb4T8Q52MEVObwn5ZKikQJKXx88H4RpZBu4o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UdVpHkU82ramTSfxXMcTGZuy6/GDspmKt4gfhWH7P0YIyikDqZ8382L7UssY/Uuku
	 upQZep+xRJqfza3wHMloqdIcAqKxgKQxTi5BHCZDTP+QHNFIVl/7NmkmNmaDV5RC1/
	 OucmBDklvo2Z7nRpzJCcDW/f5+SyrIHFpT8PTL8m+I/liXWLn2gdKcyHP4UmlnAXgl
	 8B7tVcVFCfNipxFsY4HiKkndtEWkBVxNRKWa3Fmw3FFCPSRbVu1NTQ+JM21OinDHGP
	 Gec1ZATv9OWB/S5X9AE/PIqIK9BQFWE3iDbWueaKG1/JXvbCNaFvozMlgEgmmVV0y/
	 PCgpnHConkwFQ==
Date: Mon, 29 Apr 2024 20:30:06 -0700
Subject: [PATCH 23/26] xfs: teach online repair to evaluate fsverity xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680757.957659.8130677930415663024.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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

Teach online repair to check for unused fsverity metadata and purge it
on reconstruction.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/scrub/attr.c        |  138 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/attr.h        |    6 ++
 fs/xfs/scrub/attr_repair.c |   51 ++++++++++++++++
 fs/xfs/scrub/trace.c       |    1 
 fs/xfs/scrub/trace.h       |   31 ++++++++++
 5 files changed, 226 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index b1448832ae6ba..f5fd7424bad1a 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -18,6 +18,7 @@
 #include "xfs_attr_leaf.h"
 #include "xfs_attr_sf.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
 #include "scrub/dabtree.h"
@@ -126,6 +127,47 @@ xchk_setup_xattr_buf(
 	return 0;
 }
 
+#ifdef CONFIG_FS_VERITY
+/*
+ * Obtain merkle tree geometry information for a verity file so that we can
+ * perform sanity checks of the fsverity xattrs.
+ */
+STATIC int
+xchk_xattr_setup_verity(
+	struct xfs_scrub	*sc)
+{
+	struct xchk_xattr_buf	*ab;
+	int			error;
+
+	/*
+	 * Drop the ILOCK and the transaction because loading the fsverity
+	 * metadata will call into the xattr code.  S_VERITY is enabled with
+	 * IOLOCK_EXCL held, so it should not change here.
+	 */
+	xchk_iunlock(sc, XFS_ILOCK_EXCL);
+	xchk_trans_cancel(sc);
+
+	error = xchk_setup_xattr_buf(sc, 0);
+	if (error)
+		return error;
+
+	ab = sc->buf;
+	error = xchk_inode_setup_verity(sc, &ab->merkle_blocksize,
+			&ab->merkle_tree_size);
+	if (error)
+		return error;
+
+	error = xchk_trans_alloc(sc, 0);
+	if (error)
+		return error;
+
+	xchk_ilock(sc, XFS_ILOCK_EXCL);
+	return 0;
+}
+#else
+# define xchk_xattr_setup_verity(...)	(0)
+#endif /* CONFIG_FS_VERITY */
+
 /* Set us up to scrub an inode's extended attributes. */
 int
 xchk_setup_xattr(
@@ -150,9 +192,89 @@ xchk_setup_xattr(
 			return error;
 	}
 
-	return xchk_setup_inode_contents(sc, 0);
+	error = xchk_setup_inode_contents(sc, 0);
+	if (error)
+		return error;
+
+	if (IS_VERITY(VFS_I(sc->ip))) {
+		error = xchk_xattr_setup_verity(sc);
+		if (error)
+			return error;
+	}
+
+	return error;
 }
 
+#ifdef CONFIG_FS_VERITY
+/* Check the merkle tree xattrs. */
+STATIC void
+xchk_xattr_verity(
+	struct xfs_scrub		*sc,
+	xfs_dablk_t			blkno,
+	const unsigned char		*name,
+	unsigned int			namelen,
+	unsigned int			valuelen)
+{
+	struct xchk_xattr_buf		*ab = sc->buf;
+
+	/* Non-verity filesystems should never have verity xattrs. */
+	if (!xfs_has_verity(sc->mp)) {
+		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+		return;
+	}
+
+	/*
+	 * Any verity metadata on a non-verity file are leftovers from a
+	 * previous attempt to enable verity.
+	 */
+	if (!IS_VERITY(VFS_I(sc->ip))) {
+		xchk_ino_set_preen(sc, sc->ip->i_ino);
+		return;
+	}
+
+	/* Zero blocksize occurs if we couldn't load the merkle tree data. */
+	if (ab->merkle_blocksize == 0)
+		return;
+
+	switch (namelen) {
+	case sizeof(struct xfs_merkle_key):
+		/* Oversized blocks are not allowed */
+		if (valuelen > ab->merkle_blocksize) {
+			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+			return;
+		}
+		break;
+	case XFS_VERITY_DESCRIPTOR_NAME_LEN:
+		/* Has to match the descriptor xattr name */
+		if (memcmp(name, XFS_VERITY_DESCRIPTOR_NAME, namelen))
+			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+		return;
+	default:
+		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+		return;
+	}
+
+	/*
+	 * Merkle tree blocks beyond the end of the tree are leftovers from
+	 * a previous failed attempt to enable verity.
+	 */
+	if (xfs_merkle_key_from_disk(name, namelen) >= ab->merkle_tree_size)
+		xchk_ino_set_preen(sc, sc->ip->i_ino);
+}
+#else
+static void
+xchk_xattr_verity(
+	struct xfs_scrub		*sc,
+	xfs_dablk_t			blkno,
+	const unsigned char		*name,
+	unsigned int			namelen,
+	unsigned int			valuelen)
+{
+	/* Should never see verity xattrs when verity is not enabled. */
+	xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+}
+#endif /* CONFIG_FS_VERITY */
+
 /* Extended Attributes */
 
 /*
@@ -216,6 +338,13 @@ xchk_xattr_actor(
 		return -ECANCELED;
 	}
 
+	/* Check verity xattr geometry */
+	if (attr_flags & XFS_ATTR_VERITY) {
+		xchk_xattr_verity(sc, args.blkno, name, namelen, valuelen);
+		if (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)
+			return -ECANCELED;
+	}
+
 	/*
 	 * Try to allocate enough memory to extract the attr value.  If that
 	 * doesn't work, return -EDEADLOCK as a signal to try again with a
@@ -653,6 +782,13 @@ xchk_xattr(
 	if (xchk_inode_verity_broken(sc->ip))
 		xchk_set_incomplete(sc);
 
+	/*
+	 * If this is a verity file that won't activate, we cannot check the
+	 * merkle tree geometry.
+	 */
+	if (xchk_inode_verity_broken(sc->ip))
+		xchk_set_incomplete(sc);
+
 	/* Allocate memory for xattr checking. */
 	error = xchk_setup_xattr_buf(sc, 0);
 	if (error == -ENOMEM)
diff --git a/fs/xfs/scrub/attr.h b/fs/xfs/scrub/attr.h
index 7db58af56646b..40b8c12384f55 100644
--- a/fs/xfs/scrub/attr.h
+++ b/fs/xfs/scrub/attr.h
@@ -22,6 +22,12 @@ struct xchk_xattr_buf {
 	/* Memory buffer used to extract xattr values. */
 	void			*value;
 	size_t			value_sz;
+
+#ifdef CONFIG_FS_VERITY
+	/* Geometry of the merkle tree attached to this verity file. */
+	u64			merkle_tree_size;
+	unsigned int		merkle_blocksize;
+#endif
 };
 
 bool xchk_xattr_set_map(struct xfs_scrub *sc, unsigned long *map,
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index c7eb94069cafc..ff38c563a090b 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -29,6 +29,7 @@
 #include "xfs_exchrange.h"
 #include "xfs_acl.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 #include "scrub/xfs_scrub.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
@@ -155,6 +156,44 @@ xrep_setup_xattr(
 	return xrep_tempfile_create(sc, S_IFREG);
 }
 
+#ifdef CONFIG_FS_VERITY
+static int
+xrep_xattr_want_salvage_verity(
+	struct xrep_xattr	*rx,
+	const void		*name,
+	int			namelen,
+	int			valuelen)
+{
+	struct xchk_xattr_buf	*ab = rx->sc->buf;
+
+	if (!xfs_has_verity(rx->sc->mp))
+		return false;
+	if (!IS_VERITY(VFS_I(rx->sc->ip)))
+		return false;
+
+	switch (namelen) {
+	case sizeof(struct xfs_merkle_key):
+		/* Oversized blocks are not allowed */
+		if (valuelen > ab->merkle_blocksize)
+			return false;
+		break;
+	case XFS_VERITY_DESCRIPTOR_NAME_LEN:
+		/* Has to match the descriptor xattr name */
+		return !memcmp(name, XFS_VERITY_DESCRIPTOR_NAME, namelen);
+	default:
+		return false;
+	}
+
+	/*
+	 * Merkle tree blocks beyond the end of the tree are leftovers from
+	 * a previous failed attempt to enable verity.
+	 */
+	return xfs_merkle_key_from_disk(name, namelen) < ab->merkle_tree_size;
+}
+#else
+# define xrep_xattr_want_salvage_verity(...)	(false)
+#endif /* CONFIG_FS_VERITY */
+
 /*
  * Decide if we want to salvage this attribute.  We don't bother with
  * incomplete or oversized keys or values.  The @value parameter can be null
@@ -179,6 +218,9 @@ xrep_xattr_want_salvage(
 		return false;
 	if (attr_flags & XFS_ATTR_PARENT)
 		return xfs_parent_valuecheck(rx->sc->mp, value, valuelen);
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xrep_xattr_want_salvage_verity(rx, name, namelen,
+				valuelen);
 
 	return true;
 }
@@ -212,6 +254,11 @@ xrep_xattr_salvage_key(
 
 		trace_xrep_xattr_salvage_pptr(rx->sc->ip, flags, name,
 				key.namelen, value, valuelen);
+	} else if (flags & XFS_ATTR_VERITY) {
+		key.namelen = namelen;
+
+		trace_xrep_xattr_salvage_verity(rx->sc->ip, flags, name,
+				key.namelen, value, valuelen);
 	} else {
 		while (i < namelen && name[i] != 0)
 			i++;
@@ -663,6 +710,10 @@ xrep_xattr_insert_rec(
 				ab->name, key->namelen, ab->value,
 				key->valuelen);
 		args.op_flags |= XFS_DA_OP_LOGGED;
+	} else if (key->flags & XFS_ATTR_VERITY) {
+		trace_xrep_xattr_insert_verity(rx->sc->ip, key->flags,
+				ab->name, key->namelen, ab->value,
+				key->valuelen);
 	} else {
 		trace_xrep_xattr_insert_rec(rx->sc->tempip, key->flags,
 				ab->name, key->namelen, key->valuelen);
diff --git a/fs/xfs/scrub/trace.c b/fs/xfs/scrub/trace.c
index 6d8acb2f63d8a..69c234f2a4b32 100644
--- a/fs/xfs/scrub/trace.c
+++ b/fs/xfs/scrub/trace.c
@@ -22,6 +22,7 @@
 #include "xfs_parent.h"
 #include "xfs_imeta.h"
 #include "xfs_rtgroup.h"
+#include "xfs_verity.h"
 #include "scrub/scrub.h"
 #include "scrub/xfile.h"
 #include "scrub/xfarray.h"
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index c43d02f9afade..c41598456dfcf 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -3072,6 +3072,37 @@ DEFINE_EVENT(xrep_pptr_salvage_class, name, \
 DEFINE_XREP_PPTR_SALVAGE_EVENT(xrep_xattr_salvage_pptr);
 DEFINE_XREP_PPTR_SALVAGE_EVENT(xrep_xattr_insert_pptr);
 
+DECLARE_EVENT_CLASS(xrep_verity_salvage_class,
+	TP_PROTO(struct xfs_inode *ip, unsigned int flags, const void *name,
+		 unsigned int namelen, const void *value, unsigned int valuelen),
+	TP_ARGS(ip, flags, name, namelen, value, valuelen),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(unsigned long long, merkle_off)
+	),
+	TP_fast_assign(
+		__entry->dev = ip->i_mount->m_super->s_dev;
+		__entry->ino = ip->i_ino;
+		if (namelen == sizeof(struct xfs_merkle_key))
+			__entry->merkle_off = xfs_merkle_key_from_disk(name,
+								namelen);
+		else
+			__entry->merkle_off = -1ULL;
+	),
+	TP_printk("dev %d:%d ino 0x%llx merkle_off 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->merkle_off)
+)
+#define DEFINE_XREP_VERITY_SALVAGE_EVENT(name) \
+DEFINE_EVENT(xrep_verity_salvage_class, name, \
+	TP_PROTO(struct xfs_inode *ip, unsigned int flags, const void *name, \
+		 unsigned int namelen, const void *value, unsigned int valuelen), \
+	TP_ARGS(ip, flags, name, namelen, value, valuelen))
+DEFINE_XREP_VERITY_SALVAGE_EVENT(xrep_xattr_salvage_verity);
+DEFINE_XREP_VERITY_SALVAGE_EVENT(xrep_xattr_insert_verity);
+
 TRACE_EVENT(xrep_xattr_class,
 	TP_PROTO(struct xfs_inode *ip, struct xfs_inode *arg_ip),
 	TP_ARGS(ip, arg_ip),


