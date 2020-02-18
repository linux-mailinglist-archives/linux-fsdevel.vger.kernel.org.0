Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56A41633A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRVAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:00:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sar5G6HpViVGOrNBKDzwX2RJuXtQ317XNwLn4Ye1bz0=; b=Amtp5P+sj+UtsgXsVn+AqANaQO
        T5BwIebOogKHZzOXG5qmwa0DkxQ8tFzFR7GDFL37cm6ByxJlOZ2AJckQgq3wQaCxoxTgBWGSy4LlL
        /uL2rr6q93JCuWVSJFL6Rk+K4jmH+sdZk4736aMrn5w1FEPvTOMO/RGscZrh5ylRe8i7io3asBul8
        llNHDe7GQIa1FdQnjNmIPxaKvRMcYbhwJMVXP+cCSI93BwX+RNJwbvXilgnODN66uPvBzyPik2ARJ
        0NE+XSYMEBNb9lP8yjGIpFQVXdtgyV3wYSq3dF3eXiqZR91R7RuA2oSVwlYoHdSME98kqoXABcsEC
        B+henIww==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49yu-0007MG-7C; Tue, 18 Feb 2020 21:00:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] xfs: remove the icdinode di_uid/di_gid members
Date:   Tue, 18 Feb 2020 13:00:19 -0800
Message-Id: <20200218210020.40846-3-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218210020.40846-1-hch@lst.de>
References: <20200218210020.40846-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the Linux inode i_uid/i_gid members everywhere and just convert
from/to the scalar value when reading or writing the on-disk inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_inode_buf.c | 10 ++++-----
 fs/xfs/libxfs/xfs_inode_buf.h |  2 --
 fs/xfs/xfs_dquot.c            |  4 ++--
 fs/xfs/xfs_inode.c            | 14 ++++--------
 fs/xfs/xfs_inode_item.c       |  4 ++--
 fs/xfs/xfs_ioctl.c            |  6 +++---
 fs/xfs/xfs_iops.c             |  6 +-----
 fs/xfs/xfs_itable.c           |  4 ++--
 fs/xfs/xfs_qm.c               | 40 ++++++++++++++++++++++-------------
 fs/xfs/xfs_quota.h            |  4 ++--
 fs/xfs/xfs_symlink.c          |  4 +---
 11 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index cc4efd34843a..bc72b575ceed 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -222,10 +222,8 @@ xfs_inode_from_disk(
 	}
 
 	to->di_format = from->di_format;
-	to->di_uid = be32_to_cpu(from->di_uid);
-	inode->i_uid = xfs_uid_to_kuid(to->di_uid);
-	to->di_gid = be32_to_cpu(from->di_gid);
-	inode->i_gid = xfs_gid_to_kgid(to->di_gid);
+	inode->i_uid = xfs_uid_to_kuid(be32_to_cpu(from->di_uid));
+	inode->i_gid = xfs_gid_to_kgid(be32_to_cpu(from->di_gid));
 	to->di_flushiter = be16_to_cpu(from->di_flushiter);
 
 	/*
@@ -278,8 +276,8 @@ xfs_inode_to_disk(
 
 	to->di_version = from->di_version;
 	to->di_format = from->di_format;
-	to->di_uid = cpu_to_be32(from->di_uid);
-	to->di_gid = cpu_to_be32(from->di_gid);
+	to->di_uid = cpu_to_be32(xfs_kuid_to_uid(inode->i_uid));
+	to->di_gid = cpu_to_be32(xfs_kgid_to_gid(inode->i_gid));
 	to->di_projid_lo = cpu_to_be16(from->di_projid & 0xffff);
 	to->di_projid_hi = cpu_to_be16(from->di_projid >> 16);
 
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index fd94b1078722..2683e1e2c4a6 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -19,8 +19,6 @@ struct xfs_icdinode {
 	int8_t		di_version;	/* inode version */
 	int8_t		di_format;	/* format of di_c data */
 	uint16_t	di_flushiter;	/* incremented on flush */
-	uint32_t	di_uid;		/* owner's user id */
-	uint32_t	di_gid;		/* owner's group id */
 	uint32_t	di_projid;	/* owner's project id */
 	xfs_fsize_t	di_size;	/* number of bytes in file */
 	xfs_rfsblock_t	di_nblocks;	/* # of direct & btree blocks used */
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index d223e1ae90a6..3579de9306c1 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -829,9 +829,9 @@ xfs_qm_id_for_quotatype(
 {
 	switch (type) {
 	case XFS_DQ_USER:
-		return ip->i_d.di_uid;
+		return xfs_kuid_to_uid(VFS_I(ip)->i_uid);
 	case XFS_DQ_GROUP:
-		return ip->i_d.di_gid;
+		return xfs_kgid_to_gid(VFS_I(ip)->i_gid);
 	case XFS_DQ_PROJ:
 		return ip->i_d.di_projid;
 	}
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 938b0943bd95..3324e1696354 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -813,18 +813,15 @@ xfs_ialloc(
 	inode->i_mode = mode;
 	set_nlink(inode, nlink);
 	inode->i_uid = current_fsuid();
-	ip->i_d.di_uid = xfs_kuid_to_uid(inode->i_uid);
 	inode->i_rdev = rdev;
 	ip->i_d.di_projid = prid;
 
 	if (pip && XFS_INHERIT_GID(pip)) {
 		inode->i_gid = VFS_I(pip)->i_gid;
-		ip->i_d.di_gid = pip->i_d.di_gid;
 		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
 			inode->i_mode |= S_ISGID;
 	} else {
 		inode->i_gid = current_fsgid();
-		ip->i_d.di_gid = xfs_kgid_to_gid(inode->i_gid);
 	}
 
 	/*
@@ -832,9 +829,8 @@ xfs_ialloc(
 	 * ID or one of the supplementary group IDs, the S_ISGID bit is cleared
 	 * (and only if the irix_sgid_inherit compatibility variable is set).
 	 */
-	if ((irix_sgid_inherit) &&
-	    (inode->i_mode & S_ISGID) &&
-	    (!in_group_p(xfs_gid_to_kgid(ip->i_d.di_gid))))
+	if (irix_sgid_inherit &&
+	    (inode->i_mode & S_ISGID) && !in_group_p(inode->i_gid))
 		inode->i_mode &= ~S_ISGID;
 
 	ip->i_d.di_size = 0;
@@ -1162,8 +1158,7 @@ xfs_create(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, xfs_kuid_to_uid(current_fsuid()),
-					xfs_kgid_to_gid(current_fsgid()), prid,
+	error = xfs_qm_vop_dqalloc(dp, current_fsuid(), current_fsgid(), prid,
 					XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 					&udqp, &gdqp, &pdqp);
 	if (error)
@@ -1313,8 +1308,7 @@ xfs_create_tmpfile(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, xfs_kuid_to_uid(current_fsuid()),
-				xfs_kgid_to_gid(current_fsgid()), prid,
+	error = xfs_qm_vop_dqalloc(dp, current_fsuid(), current_fsgid(), prid,
 				XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 				&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 8bd5d0de6321..83d7914556ef 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -308,8 +308,8 @@ xfs_inode_to_log_dinode(
 
 	to->di_version = from->di_version;
 	to->di_format = from->di_format;
-	to->di_uid = from->di_uid;
-	to->di_gid = from->di_gid;
+	to->di_uid = xfs_kuid_to_uid(inode->i_uid);
+	to->di_gid = xfs_kgid_to_gid(inode->i_gid);
 	to->di_projid_lo = from->di_projid & 0xffff;
 	to->di_projid_hi = from->di_projid >> 16;
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d42de92cb283..0f85bedc5977 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1434,9 +1434,9 @@ xfs_ioctl_setattr(
 	 * because the i_*dquot fields will get updated anyway.
 	 */
 	if (XFS_IS_QUOTA_ON(mp)) {
-		code = xfs_qm_vop_dqalloc(ip, ip->i_d.di_uid,
-					 ip->i_d.di_gid, fa->fsx_projid,
-					 XFS_QMOPT_PQUOTA, &udqp, NULL, &pdqp);
+		code = xfs_qm_vop_dqalloc(ip, VFS_I(ip)->i_uid,
+				VFS_I(ip)->i_gid, fa->fsx_projid,
+				XFS_QMOPT_PQUOTA, &udqp, NULL, &pdqp);
 		if (code)
 			return code;
 	}
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index b818b261918f..a5b7c3100a2f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -692,9 +692,7 @@ xfs_setattr_nonsize(
 		 */
 		ASSERT(udqp == NULL);
 		ASSERT(gdqp == NULL);
-		error = xfs_qm_vop_dqalloc(ip, xfs_kuid_to_uid(uid),
-					   xfs_kgid_to_gid(gid),
-					   ip->i_d.di_projid,
+		error = xfs_qm_vop_dqalloc(ip, uid, gid, ip->i_d.di_projid,
 					   qflags, &udqp, &gdqp, NULL);
 		if (error)
 			return error;
@@ -763,7 +761,6 @@ xfs_setattr_nonsize(
 				olddquot1 = xfs_qm_vop_chown(tp, ip,
 							&ip->i_udquot, udqp);
 			}
-			ip->i_d.di_uid = xfs_kuid_to_uid(uid);
 			inode->i_uid = uid;
 		}
 		if (!gid_eq(igid, gid)) {
@@ -775,7 +772,6 @@ xfs_setattr_nonsize(
 				olddquot2 = xfs_qm_vop_chown(tp, ip,
 							&ip->i_gdquot, gdqp);
 			}
-			ip->i_d.di_gid = xfs_kgid_to_gid(gid);
 			inode->i_gid = gid;
 		}
 	}
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index 4b31c29b7e6b..497db4160283 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -86,8 +86,8 @@ xfs_bulkstat_one_int(
 	 */
 	buf->bs_projectid = ip->i_d.di_projid;
 	buf->bs_ino = ino;
-	buf->bs_uid = dic->di_uid;
-	buf->bs_gid = dic->di_gid;
+	buf->bs_uid = xfs_kuid_to_uid(inode->i_uid);
+	buf->bs_gid = xfs_kgid_to_gid(inode->i_gid);
 	buf->bs_size = dic->di_size;
 
 	buf->bs_nlink = inode->i_nlink;
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 0b0909657bad..54dda7d982c9 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -326,16 +326,18 @@ xfs_qm_dqattach_locked(
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
 
 	if (XFS_IS_UQUOTA_ON(mp) && !ip->i_udquot) {
-		error = xfs_qm_dqattach_one(ip, ip->i_d.di_uid, XFS_DQ_USER,
-				doalloc, &ip->i_udquot);
+		error = xfs_qm_dqattach_one(ip,
+				xfs_kuid_to_uid(VFS_I(ip)->i_uid),
+				XFS_DQ_USER, doalloc, &ip->i_udquot);
 		if (error)
 			goto done;
 		ASSERT(ip->i_udquot);
 	}
 
 	if (XFS_IS_GQUOTA_ON(mp) && !ip->i_gdquot) {
-		error = xfs_qm_dqattach_one(ip, ip->i_d.di_gid, XFS_DQ_GROUP,
-				doalloc, &ip->i_gdquot);
+		error = xfs_qm_dqattach_one(ip,
+				xfs_kgid_to_gid(VFS_I(ip)->i_gid),
+				XFS_DQ_GROUP, doalloc, &ip->i_gdquot);
 		if (error)
 			goto done;
 		ASSERT(ip->i_gdquot);
@@ -1613,8 +1615,8 @@ xfs_qm_dqfree_one(
 int
 xfs_qm_vop_dqalloc(
 	struct xfs_inode	*ip,
-	xfs_dqid_t		uid,
-	xfs_dqid_t		gid,
+	kuid_t			uid,
+	kgid_t			gid,
 	prid_t			prid,
 	uint			flags,
 	struct xfs_dquot	**O_udqpp,
@@ -1622,6 +1624,7 @@ xfs_qm_vop_dqalloc(
 	struct xfs_dquot	**O_pdqpp)
 {
 	struct xfs_mount	*mp = ip->i_mount;
+	struct inode		*inode = VFS_I(ip);
 	struct xfs_dquot	*uq = NULL;
 	struct xfs_dquot	*gq = NULL;
 	struct xfs_dquot	*pq = NULL;
@@ -1635,7 +1638,7 @@ xfs_qm_vop_dqalloc(
 	xfs_ilock(ip, lockflags);
 
 	if ((flags & XFS_QMOPT_INHERIT) && XFS_INHERIT_GID(ip))
-		gid = ip->i_d.di_gid;
+		gid = inode->i_gid;
 
 	/*
 	 * Attach the dquot(s) to this inode, doing a dquot allocation
@@ -1650,7 +1653,7 @@ xfs_qm_vop_dqalloc(
 	}
 
 	if ((flags & XFS_QMOPT_UQUOTA) && XFS_IS_UQUOTA_ON(mp)) {
-		if (ip->i_d.di_uid != uid) {
+		if (!uid_eq(inode->i_uid, uid)) {
 			/*
 			 * What we need is the dquot that has this uid, and
 			 * if we send the inode to dqget, the uid of the inode
@@ -1661,7 +1664,8 @@ xfs_qm_vop_dqalloc(
 			 * holding ilock.
 			 */
 			xfs_iunlock(ip, lockflags);
-			error = xfs_qm_dqget(mp, uid, XFS_DQ_USER, true, &uq);
+			error = xfs_qm_dqget(mp, xfs_kuid_to_uid(uid),
+					XFS_DQ_USER, true, &uq);
 			if (error) {
 				ASSERT(error != -ENOENT);
 				return error;
@@ -1682,9 +1686,10 @@ xfs_qm_vop_dqalloc(
 		}
 	}
 	if ((flags & XFS_QMOPT_GQUOTA) && XFS_IS_GQUOTA_ON(mp)) {
-		if (ip->i_d.di_gid != gid) {
+		if (!gid_eq(inode->i_gid, gid)) {
 			xfs_iunlock(ip, lockflags);
-			error = xfs_qm_dqget(mp, gid, XFS_DQ_GROUP, true, &gq);
+			error = xfs_qm_dqget(mp, xfs_kgid_to_gid(gid),
+					XFS_DQ_GROUP, true, &gq);
 			if (error) {
 				ASSERT(error != -ENOENT);
 				goto error_rele;
@@ -1810,7 +1815,8 @@ xfs_qm_vop_chown_reserve(
 			XFS_QMOPT_RES_RTBLKS : XFS_QMOPT_RES_REGBLKS;
 
 	if (XFS_IS_UQUOTA_ON(mp) && udqp &&
-	    ip->i_d.di_uid != be32_to_cpu(udqp->q_core.d_id)) {
+	    xfs_kuid_to_uid(VFS_I(ip)->i_uid) !=
+			be32_to_cpu(udqp->q_core.d_id)) {
 		udq_delblks = udqp;
 		/*
 		 * If there are delayed allocation blocks, then we have to
@@ -1823,7 +1829,8 @@ xfs_qm_vop_chown_reserve(
 		}
 	}
 	if (XFS_IS_GQUOTA_ON(ip->i_mount) && gdqp &&
-	    ip->i_d.di_gid != be32_to_cpu(gdqp->q_core.d_id)) {
+	    xfs_kgid_to_gid(VFS_I(ip)->i_gid) !=
+			be32_to_cpu(gdqp->q_core.d_id)) {
 		gdq_delblks = gdqp;
 		if (delblks) {
 			ASSERT(ip->i_gdquot);
@@ -1920,14 +1927,17 @@ xfs_qm_vop_create_dqattach(
 
 	if (udqp && XFS_IS_UQUOTA_ON(mp)) {
 		ASSERT(ip->i_udquot == NULL);
-		ASSERT(ip->i_d.di_uid == be32_to_cpu(udqp->q_core.d_id));
+		ASSERT(xfs_kuid_to_uid(VFS_I(ip)->i_uid) ==
+			be32_to_cpu(udqp->q_core.d_id));
 
 		ip->i_udquot = xfs_qm_dqhold(udqp);
 		xfs_trans_mod_dquot(tp, udqp, XFS_TRANS_DQ_ICOUNT, 1);
 	}
 	if (gdqp && XFS_IS_GQUOTA_ON(mp)) {
 		ASSERT(ip->i_gdquot == NULL);
-		ASSERT(ip->i_d.di_gid == be32_to_cpu(gdqp->q_core.d_id));
+		ASSERT(xfs_kgid_to_gid(VFS_I(ip)->i_gid) ==
+			be32_to_cpu(gdqp->q_core.d_id));
+
 		ip->i_gdquot = xfs_qm_dqhold(gdqp);
 		xfs_trans_mod_dquot(tp, gdqp, XFS_TRANS_DQ_ICOUNT, 1);
 	}
diff --git a/fs/xfs/xfs_quota.h b/fs/xfs/xfs_quota.h
index efe42ae7a2f3..aa8fc1f55fbd 100644
--- a/fs/xfs/xfs_quota.h
+++ b/fs/xfs/xfs_quota.h
@@ -86,7 +86,7 @@ extern int xfs_trans_reserve_quota_bydquots(struct xfs_trans *,
 		struct xfs_mount *, struct xfs_dquot *,
 		struct xfs_dquot *, struct xfs_dquot *, int64_t, long, uint);
 
-extern int xfs_qm_vop_dqalloc(struct xfs_inode *, xfs_dqid_t, xfs_dqid_t,
+extern int xfs_qm_vop_dqalloc(struct xfs_inode *, kuid_t, kgid_t,
 		prid_t, uint, struct xfs_dquot **, struct xfs_dquot **,
 		struct xfs_dquot **);
 extern void xfs_qm_vop_create_dqattach(struct xfs_trans *, struct xfs_inode *,
@@ -109,7 +109,7 @@ extern void xfs_qm_unmount_quotas(struct xfs_mount *);
 
 #else
 static inline int
-xfs_qm_vop_dqalloc(struct xfs_inode *ip, xfs_dqid_t uid, xfs_dqid_t gid,
+xfs_qm_vop_dqalloc(struct xfs_inode *ip, kuid_t kuid, kgid_t kgid,
 		prid_t prid, uint flags, struct xfs_dquot **udqp,
 		struct xfs_dquot **gdqp, struct xfs_dquot **pdqp)
 {
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index d762d42ed0ff..ea42e25ec1bf 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -182,9 +182,7 @@ xfs_symlink(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp,
-			xfs_kuid_to_uid(current_fsuid()),
-			xfs_kgid_to_gid(current_fsgid()), prid,
+	error = xfs_qm_vop_dqalloc(dp, current_fsuid(), current_fsgid(), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
-- 
2.24.1

