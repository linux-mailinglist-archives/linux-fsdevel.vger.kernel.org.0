Return-Path: <linux-fsdevel+bounces-18252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2488B68B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D691C21DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD2B10A3C;
	Tue, 30 Apr 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efl5Hypu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9B10979;
	Tue, 30 Apr 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447791; cv=none; b=e0ew6Pi4gSbj4xGfQO9j5IXkVlYtfrVT+EVVWsUeiM4yb3laMB0XJiCGhl8KGq2PTWfiI2bkkNirS/1oQUJl1GZQZfK+YE51lVGB2FlwC1zo8Tict7zBjN3vbL6BvXA7m+Gy9hs7dY9ru3BW5tzyCZm4nH9GSMwMP5/3z5wfVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447791; c=relaxed/simple;
	bh=E6cocmmuNOIuTtAioefBHH9vGQO/GmXvpdzFFNyLsDQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mER/KQEJ9BhsXWLPZKUSHAkR0s1b0n6k1z1o2/4vixiGFRMWCi5gAWHihEq+MJWZnQZL6SyQzNb0Dlk3Ysx22gTO2+4MF7aBUW+a3F/bz1a20AettJXkMpFZDZmftYKArp5dDvMR3sNf73P+PaO0WFFhSKE3XfXnFSLYNpHeYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efl5Hypu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3DDC116B1;
	Tue, 30 Apr 2024 03:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447791;
	bh=E6cocmmuNOIuTtAioefBHH9vGQO/GmXvpdzFFNyLsDQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=efl5Hypuee5LyISLZyKxkPCLla4hNeeB9r12/3yrvlthejGQf5s89XYYLbKXcX8Oo
	 q8FZL0SgV7BMrBpouCrbxixy/F9raspz8Jjw7w+nBlIeJJfSfDIpzarLjxw3s7QGKE
	 aNsVEBh80CuUFnIFzWibGspoLEcW+wzIl75bo5jU96CtjPipTcP1zSxORekD92vDPw
	 U9KnXExtM4SZdLR7NP7yhAQVHVvAsMLrUqsxRyP4tpsGnZcJZZdQPF4x3X21z0+VvH
	 e29jgD+GzvyXoKEiQ+F4j0x02BBDVO6bPuJ7jF/m7J+OkMktsOpbyEEofej6rezzO9
	 nEARK9hdqy4Nw==
Date: Mon, 29 Apr 2024 20:29:50 -0700
Subject: [PATCH 22/26] xfs: check and repair the verity inode flag state
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680740.957659.12306880673536917469.stgit@frogsfrogsfrogs>
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

If an inode has the incore verity iflag set, make sure that we can
actually activate fsverity on that inode.  If activation fails due to
a fsverity metadata validation error, clear the flag.  The usage model
for fsverity requires that any program that cares about verity state is
required to call statx/getflags to check that the flag is set after
opening the file, so clearing the flag will not compromise that model.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/attr.c         |    7 ++++
 fs/xfs/scrub/common.c       |   68 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/common.h       |    3 ++
 fs/xfs/scrub/inode.c        |    7 ++++
 fs/xfs/scrub/inode_repair.c |   36 +++++++++++++++++++++++
 5 files changed, 121 insertions(+)


diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 708334f9b2bd1..b1448832ae6ba 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -646,6 +646,13 @@ xchk_xattr(
 	if (!xfs_inode_hasattr(sc->ip))
 		return -ENOENT;
 
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
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index ee7355f4450a6..106e079aac71d 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -45,6 +45,8 @@
 #include "scrub/health.h"
 #include "scrub/tempfile.h"
 
+#include <linux/fsverity.h>
+
 /* Common code for the metadata scrubbers. */
 
 /*
@@ -1871,6 +1873,72 @@ xchk_inode_count_blocks(
 	return 0;
 }
 
+/*
+ * If this inode has S_VERITY set on it, read the merkle tree geometry, which
+ * will activate the incore fsverity context for this file.  If the activation
+ * fails with anything other than ENOMEM, the file is corrupt, which we can
+ * detect later with fsverity_active.
+ *
+ * Callers must hold the IOLOCK and must not hold the ILOCK of sc->ip because
+ * activation reads xattrs.  @blocksize and @treesize will be filled out with
+ * merkle tree geometry if they are not NULL pointers.
+ */
+int
+xchk_inode_setup_verity(
+	struct xfs_scrub	*sc,
+	unsigned int		*blocksize,
+	u64			*treesize)
+{
+	unsigned int		bs;
+	u64			ts;
+	int			error;
+
+	if (!IS_VERITY(VFS_I(sc->ip)))
+		return 0;
+
+	error = fsverity_merkle_tree_geometry(VFS_I(sc->ip), &bs, &ts);
+	switch (error) {
+	case 0:
+		/* fsverity is active; return tree geometry. */
+		if (blocksize)
+			*blocksize = bs;
+		if (treesize)
+			*treesize = ts;
+		break;
+	case -ENODATA:
+	case -EMSGSIZE:
+	case -EINVAL:
+	case -EFSCORRUPTED:
+	case -EFBIG:
+		/*
+		 * The nonzero errno codes above are the error codes that can
+		 * be returned from fsverity on metadata validation errors.
+		 * Set the geometry to zero.
+		 */
+		if (blocksize)
+			*blocksize = 0;
+		if (treesize)
+			*treesize = 0;
+		return 0;
+	default:
+		/* runtime errors */
+		return error;
+	}
+
+	return 0;
+}
+
+/*
+ * Is this a verity file that failed to activate?  Callers must have tried to
+ * activate fsverity via xchk_inode_setup_verity.
+ */
+bool
+xchk_inode_verity_broken(
+	struct xfs_inode	*ip)
+{
+	return IS_VERITY(VFS_I(ip)) && !fsverity_active(VFS_I(ip));
+}
+
 /* Complain about failures... */
 void
 xchk_whine(
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index f15038dd6dedc..673347d51f29f 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -302,5 +302,8 @@ int xchk_inode_is_allocated(struct xfs_scrub *sc, xfs_agino_t agino,
 		bool *inuse);
 int xchk_inode_count_blocks(struct xfs_scrub *sc, int whichfork,
 		xfs_extnum_t *nextents, xfs_filblks_t *count);
+int xchk_inode_setup_verity(struct xfs_scrub *sc, unsigned int *blocksize,
+		u64 *treesize);
+bool xchk_inode_verity_broken(struct xfs_inode *ip);
 
 #endif	/* __XFS_SCRUB_COMMON_H__ */
diff --git a/fs/xfs/scrub/inode.c b/fs/xfs/scrub/inode.c
index cb2530a93a001..91eab60947b12 100644
--- a/fs/xfs/scrub/inode.c
+++ b/fs/xfs/scrub/inode.c
@@ -36,6 +36,10 @@ xchk_prepare_iscrub(
 
 	xchk_ilock(sc, XFS_IOLOCK_EXCL);
 
+	error = xchk_inode_setup_verity(sc, NULL, NULL);
+	if (error)
+		return error;
+
 	error = xchk_trans_alloc(sc, 0);
 	if (error)
 		return error;
@@ -825,6 +829,9 @@ xchk_inode(
 	if (S_ISREG(VFS_I(sc->ip)->i_mode))
 		xchk_inode_check_reflink_iflag(sc, sc->ip->i_ino);
 
+	if (xchk_inode_verity_broken(sc->ip))
+		xchk_ino_set_corrupt(sc, sc->sm->sm_ino);
+
 	xchk_inode_check_unlinked(sc);
 
 	xchk_inode_xref(sc, sc->ip->i_ino, &di);
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index fb8d1ba1f35c0..c990fd7483529 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -566,6 +566,8 @@ xrep_dinode_flags(
 		dip->di_nrext64_pad = 0;
 	else if (dip->di_version >= 3)
 		dip->di_v3_pad = 0;
+	if (!xfs_has_verity(mp) || !S_ISREG(mode))
+		flags2 &= ~XFS_DIFLAG2_VERITY;
 
 	if (flags2 & XFS_DIFLAG2_METADIR) {
 		xfs_failaddr_t	fa;
@@ -1589,6 +1591,10 @@ xrep_dinode_core(
 	if (iget_error)
 		return iget_error;
 
+	error = xchk_inode_setup_verity(sc, NULL, NULL);
+	if (error)
+		return error;
+
 	error = xchk_trans_alloc(sc, 0);
 	if (error)
 		return error;
@@ -2015,6 +2021,27 @@ xrep_inode_unlinked(
 	return 0;
 }
 
+/*
+ * If this file is a fsverity file, xchk_prepare_iscrub or xrep_dinode_core
+ * should have activated it.  If it's still not active, then there's something
+ * wrong with the verity descriptor and we should turn it off.
+ */
+STATIC int
+xrep_inode_verity(
+	struct xfs_scrub	*sc)
+{
+	struct inode		*inode = VFS_I(sc->ip);
+
+	if (xchk_inode_verity_broken(sc->ip)) {
+		sc->ip->i_diflags2 &= ~XFS_DIFLAG2_VERITY;
+		inode->i_flags &= ~S_VERITY;
+
+		xfs_trans_log_inode(sc->tp, sc->ip, XFS_ILOG_CORE);
+	}
+
+	return 0;
+}
+
 /* Repair an inode's fields. */
 int
 xrep_inode(
@@ -2064,6 +2091,15 @@ xrep_inode(
 			return error;
 	}
 
+	/*
+	 * Disable fsverity if it cannot be activated.  Activation failure
+	 * prohibits the file from being opened, so there cannot be another
+	 * program with an open fd to what it thinks is a verity file.
+	 */
+	error = xrep_inode_verity(sc);
+	if (error)
+		return error;
+
 	/* Reconnect incore unlinked list */
 	error = xrep_inode_unlinked(sc);
 	if (error)


