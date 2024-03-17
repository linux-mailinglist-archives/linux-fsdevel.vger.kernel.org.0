Return-Path: <linux-fsdevel+bounces-14612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB887DEAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B5BB2114D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E834E4C84;
	Sun, 17 Mar 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYo/dRBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3001B949;
	Sun, 17 Mar 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693152; cv=none; b=LdlyrDjLmWNvXOViQDc0Rt9gvPPd5wz04JGixeaa+F9XXemoeLHMZCPCq7bfK7E/PwoQ9Bm5kNTM5PMmuWSLHzixr73czXfhjZilRThLqVFfOE9GYDv0LHg21lqkMiSHzGATNC4YhRaA+sku3wDYWO1lGgTf4bpd1wDeT3UYH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693152; c=relaxed/simple;
	bh=4jMkHDMrDZOw2p/fhQDGP76wu2GFqy3BwQJT5LKQt9Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSYVpjY1gvDIgv//nlXdHN5FGlHCCJgqbCDzn1WsWyE8apu22ZBuWGqGJ9S8dwiHh2g1F596su0971rhHwdsU4+z0k7r//OlCnLtnt106w+Z/u3VbzYBWWkLTUXAsJ2M5stK11Ixgx9ktUQBuTgQltvQO0Z1G08JBpmP38igNRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYo/dRBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF2C433F1;
	Sun, 17 Mar 2024 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693152;
	bh=4jMkHDMrDZOw2p/fhQDGP76wu2GFqy3BwQJT5LKQt9Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZYo/dRBotpN4KVSAz6ykCcSJyeWyt/VnBXP3k0dp6Hj8d6KawDtJJ3QR1WYtS3Pbg
	 sARgjodd4QbxZvvpjiIyOagfPJDd6c7pCGKHllKA5yiz6KcXWk/j9kfEK+uKWhVV94
	 qza9qVpf12COmqsKVv696kzFLSsKJwIVGEC2La5k1ONCriid9yBrLVN+j2h4Tue1Yw
	 sLU6wXAnC5D9/OyWIVVSZqJNQmajSaCr2YHzoGx2sdUKKeBYZ45PtH6xlYabfxGK7l
	 e4og/CNZ8Qh0S0NXgZSBwVrBnHc0SN6hXZ2uoiREyksi4KvBip0NoKxYa+eq88DmUn
	 +26pdbqDcRMEg==
Date: Sun, 17 Mar 2024 09:32:31 -0700
Subject: [PATCH 35/40] xfs: teach online repair to evaluate fsverity xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246470.2684506.16777519924436608697.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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
 fs/xfs/scrub/attr.c   |  102 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/attr.h   |    4 ++
 fs/xfs/scrub/common.c |   27 +++++++++++++
 3 files changed, 133 insertions(+)


diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index ae4227cb55ec..c69dee281984 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -21,6 +21,8 @@
 #include "scrub/dabtree.h"
 #include "scrub/attr.h"
 
+#include <linux/fsverity.h>
+
 /* Free the buffers linked from the xattr buffer. */
 static void
 xchk_xattr_buf_cleanup(
@@ -135,6 +137,91 @@ xchk_setup_xattr(
 	return xchk_setup_inode_contents(sc, 0);
 }
 
+#ifdef CONFIG_FS_VERITY
+/* Extract merkle tree geometry from incore information. */
+static int
+xchk_xattr_extract_verity(
+	struct xfs_scrub		*sc)
+{
+	struct xchk_xattr_buf		*ab = sc->buf;
+
+	/* setup should have allocated the buffer */
+	if (!ab) {
+		ASSERT(0);
+		return -EFSCORRUPTED;
+	}
+
+	return fsverity_merkle_tree_geometry(VFS_I(sc->ip),
+			&ab->merkle_blocksize, &ab->merkle_tree_size);
+}
+
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
+	switch (namelen) {
+	case sizeof(struct xfs_verity_merkle_key):
+		/* Oversized blocks are not allowed */
+		if (valuelen > ab->merkle_blocksize) {
+			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+			return;
+		}
+		break;
+	case XFS_VERITY_DESCRIPTOR_NAME_LEN:
+		/* Has to match the descriptor xattr name */
+		if (memcmp(name, XFS_VERITY_DESCRIPTOR_NAME, namelen)) {
+			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+		}
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
+	if (xfs_verity_merkle_key_from_disk(name) >= ab->merkle_tree_size)
+		xchk_ino_set_preen(sc, sc->ip->i_ino);
+}
+#else
+# define xchk_xattr_extract_verity(sc)	(0)
+
+static void
+xchk_xattr_verity(
+	struct xfs_scrub	*sc,
+	xfs_dablk_t		blkno,
+	const unsigned char	*name,
+	unsigned int		namelen)
+{
+	/* Should never see verity xattrs when verity is not enabled. */
+	xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
+}
+#endif /* CONFIG_FS_VERITY */
+
 /* Extended Attributes */
 
 struct xchk_xattr {
@@ -194,6 +281,15 @@ xchk_xattr_listent(
 		goto fail_xref;
 	}
 
+	/* Check verity xattr geometry */
+	if (flags & XFS_ATTR_VERITY) {
+		xchk_xattr_verity(sx->sc, args.blkno, name, namelen, valuelen);
+		if (sx->sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT) {
+			context->seen_enough = 1;
+			return;
+		}
+	}
+
 	/* Does this name make sense? */
 	if (!xfs_attr_namecheck(sx->sc->mp, name, namelen, flags)) {
 		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);
@@ -611,6 +707,12 @@ xchk_xattr(
 	if (error)
 		return error;
 
+	if (IS_VERITY(VFS_I(sc->ip))) {
+		error = xchk_xattr_extract_verity(sc);
+		if (error)
+			return error;
+	}
+
 	/* Check the physical structure of the xattr. */
 	if (sc->ip->i_af.if_format == XFS_DINODE_FMT_LOCAL)
 		error = xchk_xattr_check_sf(sc);
diff --git a/fs/xfs/scrub/attr.h b/fs/xfs/scrub/attr.h
index 48fd9402c432..37849ffb0375 100644
--- a/fs/xfs/scrub/attr.h
+++ b/fs/xfs/scrub/attr.h
@@ -19,6 +19,10 @@ struct xchk_xattr_buf {
 	/* Memory buffer used to extract xattr values. */
 	void			*value;
 	size_t			value_sz;
+
+	/* Geometry of the merkle tree attached to this verity file. */
+	u64			merkle_tree_size;
+	unsigned int		merkle_blocksize;
 };
 
 #endif	/* __XFS_SCRUB_ATTR_H__ */
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index abff79a77c72..dd2ed1f833c5 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -37,6 +37,8 @@
 #include "scrub/repair.h"
 #include "scrub/health.h"
 
+#include <linux/fsverity.h>
+
 /* Common code for the metadata scrubbers. */
 
 /*
@@ -1073,6 +1075,25 @@ xchk_irele(
 	xfs_irele(ip);
 }
 
+#ifdef CONFIG_FS_VERITY
+/*
+ * Make sure the fsverity information is attached, so we don't have to do that
+ * later after taking locks.
+ */
+static inline int
+xchk_setup_fsverity(
+	struct xfs_scrub	*sc)
+{
+	unsigned int		dontcare;
+	u64			alsodontcare;
+
+	return fsverity_merkle_tree_geometry(VFS_I(sc->ip),
+			&dontcare, &alsodontcare);
+}
+#else
+# define xchk_setup_fsverity(sc)	(0)
+#endif
+
 /*
  * Set us up to scrub metadata mapped by a file's fork.  Callers must not use
  * this to operate on user-accessible regular file data because the MMAPLOCK is
@@ -1092,6 +1113,12 @@ xchk_setup_inode_contents(
 	/* Lock the inode so the VFS cannot touch this file. */
 	xchk_ilock(sc, XFS_IOLOCK_EXCL);
 
+	if (IS_VERITY(VFS_I(sc->ip))) {
+		error = xchk_setup_fsverity(sc);
+		if (error)
+			goto out;
+	}
+
 	error = xchk_trans_alloc(sc, resblks);
 	if (error)
 		goto out;


