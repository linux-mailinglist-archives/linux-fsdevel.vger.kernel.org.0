Return-Path: <linux-fsdevel+bounces-15739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E2889286D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0110CB229DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043915A8;
	Sat, 30 Mar 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+B0bjrt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C967EC;
	Sat, 30 Mar 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759340; cv=none; b=koliF2vsgWiZ0ZsF4qxE/7PLZ6QA+ErHO8//vve188LzksUF26aWEwgWk0IdSn9lwzrDPpBPc61BkWrPaAKVgcOh3hdUXHlob9V/rCpnKZLz3VvdNjR258TKRrU7o/m9ehxDpPLglo55fXDvg9SxtQsCpk/bGAiNXHzQMUAx0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759340; c=relaxed/simple;
	bh=EaJIoOcM03rXA7udWPXnNGh6i7JQBWThpuwnDxVzF0o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRoIfND+HPfiFrtsQ3EVxmWmeK2ribpPz0KJobtXFeFgz3XaJUVh0GlP+P1+NE1CB9SPcUmXk2Ml9TQo2B7rEbdUNMt2iHw2akcRRU5VlwRxsClerspfqvgi+3BCJzRbmHYKJECWJPKoLzP73/LMsCSuJSNaiCBUyF6q2OUEj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+B0bjrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C09C433F1;
	Sat, 30 Mar 2024 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759340;
	bh=EaJIoOcM03rXA7udWPXnNGh6i7JQBWThpuwnDxVzF0o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Q+B0bjrtIVICuZ/v9w707Gwk1V0i3fRamVhi/kdz1X8f7LAP3TMjsxIzorS0Wn90K
	 z/z0rptrdIEZk70P/XZSa977zDdV7vwQBIvv40mWBIMf5t6jSYiycUt8IxQZJtb19X
	 HTrt+1nn/e8V2X3lM9+nYYM7Xwuu62TLz7cPBVVLP0pi83un6Qr/UtUgsqkZ2JQoY7
	 irId0VZcAGLIZ+4Krb9ZFgIeKHiJdmh99FzN5W0GUYPXLjbV1DnuqG0IdHJXDafge/
	 6V85VixH+IeTFeua73bw3f1Ts+fVClKBKsiJjLZnntMXUkG03xzEiMqpnPiH8it/EY
	 fQCu2uwtezCGQ==
Date: Fri, 29 Mar 2024 17:42:19 -0700
Subject: [PATCH 24/29] xfs: teach online repair to evaluate fsverity xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868956.1988170.10162640337320302727.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
---
 fs/xfs/scrub/attr.c        |  139 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/attr.h        |    6 ++
 fs/xfs/scrub/attr_repair.c |   50 ++++++++++++++++
 fs/xfs/scrub/trace.c       |    1 
 fs/xfs/scrub/trace.h       |   31 ++++++++++
 5 files changed, 226 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 2e8a2b2e82fbd..be121625c14f0 100644
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
@@ -25,6 +26,8 @@
 #include "scrub/listxattr.h"
 #include "scrub/repair.h"
 
+#include <linux/fsverity.h>
+
 /* Free the buffers linked from the xattr buffer. */
 static void
 xchk_xattr_buf_cleanup(
@@ -126,6 +129,53 @@ xchk_setup_xattr_buf(
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
+	error = fsverity_merkle_tree_geometry(VFS_I(sc->ip),
+			&ab->merkle_blocksize, &ab->merkle_tree_size);
+	if (error == -ENODATA || error == -EFSCORRUPTED) {
+		/* fsverity metadata corrupt, cannot complete checks */
+		xchk_set_incomplete(sc);
+		ab->merkle_blocksize = 0;
+		error = 0;
+	}
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
@@ -150,9 +200,89 @@ xchk_setup_xattr(
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
@@ -211,6 +341,13 @@ xchk_xattr_actor(
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
 	 * Local and shortform xattr values are stored in the attr leaf block,
 	 * so we don't need to retrieve the value from a remote block to detect
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
index 7c5e52ceae82e..040138610ae94 100644
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
@@ -159,6 +160,44 @@ xrep_setup_xattr(
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
@@ -183,6 +222,9 @@ xrep_xattr_want_salvage(
 		return false;
 	if (attr_flags & XFS_ATTR_PARENT)
 		return xfs_parent_valuecheck(rx->sc->mp, value, valuelen);
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xrep_xattr_want_salvage_verity(rx, name, namelen,
+				valuelen);
 
 	return true;
 }
@@ -216,6 +258,11 @@ xrep_xattr_salvage_key(
 
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
@@ -667,6 +714,9 @@ xrep_xattr_insert_rec(
 		trace_xrep_xattr_insert_pptr(rx->sc->tempip, key->flags,
 				ab->name, key->namelen, ab->value,
 				key->valuelen);
+	else if (key->flags & XFS_ATTR_VERITY)
+		trace_xrep_xattr_insert_verity(rx->sc->ip, key->flags, ab->name,
+				key->namelen, ab->value, key->valuelen);
 	else
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
index 6fd91c13f25ff..787f409799a06 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -3069,6 +3069,37 @@ DEFINE_EVENT(xrep_pptr_salvage_class, name, \
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


