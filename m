Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E27B8C68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245422AbjJDTIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbjJDTIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:08:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1FF10DD;
        Wed,  4 Oct 2023 11:55:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C94C433C7;
        Wed,  4 Oct 2023 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445719;
        bh=IjkUPhbmYczYkXpzgrTEcDFuI4tfjCDPQMycSKoo/uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaAcmkyp9t16v9NaW85TlKfJSpvzj6u1RoepQQCDzss+0J3qRaolSk3f0kJbnMC7X
         ZYyqHg1pXEmrjwf0QmXTm4/KKpMQDnDsm9mM2vjM55N1q1V1Ysv9zHQnPTCMP47Ne4
         17VoAlSpZIrHQgvzN95on39fmtEs7CgE7brE9LRz4USnzaoSkbS1JsdXzSBkkcjnii
         Lyw+OrAyCrGM7NKAXP6prg1ZdSEqG0ddY6strTXw9ukiOQ2e0+URj82j8vuMeuCnM8
         f5L8kH2q2zgtdmxAFPRQo2TbXUWEZDqLdImQ16S6va1JwjC4ItR+qAXzgYzweBhHTM
         EUu8hh4sjMXvg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH v2 77/89] xfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:02 -0400
Message-ID: <20231004185347.80880-75-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/libxfs/xfs_inode_buf.c   | 10 ++++++----
 fs/xfs/libxfs/xfs_rtbitmap.c    |  6 +++++-
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_bmap_util.c          |  7 ++++---
 fs/xfs/xfs_inode.c              |  4 ++--
 fs/xfs/xfs_inode_item.c         |  4 ++--
 fs/xfs/xfs_iops.c               |  8 ++++----
 fs/xfs/xfs_itable.c             | 12 ++++++------
 fs/xfs/xfs_rtalloc.c            | 30 ++++++++++++++++--------------
 9 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index a35781577cad..543f3748c2a3 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -220,8 +220,10 @@ xfs_inode_from_disk(
 	 * a time before epoch is converted to a time long after epoch
 	 * on 64 bit systems.
 	 */
-	inode->i_atime = xfs_inode_from_disk_ts(from, from->di_atime);
-	inode->i_mtime = xfs_inode_from_disk_ts(from, from->di_mtime);
+	inode_set_atime_to_ts(inode,
+			      xfs_inode_from_disk_ts(from, from->di_atime));
+	inode_set_mtime_to_ts(inode,
+			      xfs_inode_from_disk_ts(from, from->di_mtime));
 	inode_set_ctime_to_ts(inode,
 			      xfs_inode_from_disk_ts(from, from->di_ctime));
 
@@ -315,8 +317,8 @@ xfs_inode_to_disk(
 	to->di_projid_lo = cpu_to_be16(ip->i_projid & 0xffff);
 	to->di_projid_hi = cpu_to_be16(ip->i_projid >> 16);
 
-	to->di_atime = xfs_inode_to_disk_ts(ip, inode->i_atime);
-	to->di_mtime = xfs_inode_to_disk_ts(ip, inode->i_mtime);
+	to->di_atime = xfs_inode_to_disk_ts(ip, inode_get_atime(inode));
+	to->di_mtime = xfs_inode_to_disk_ts(ip, inode_get_mtime(inode));
 	to->di_ctime = xfs_inode_to_disk_ts(ip, inode_get_ctime(inode));
 	to->di_nlink = cpu_to_be32(inode->i_nlink);
 	to->di_gen = cpu_to_be32(inode->i_generation);
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index fa180ab66b73..396648acb5be 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -970,6 +970,7 @@ xfs_rtfree_extent(
 	xfs_mount_t	*mp;		/* file system mount structure */
 	xfs_fsblock_t	sb;		/* summary file block number */
 	struct xfs_buf	*sumbp = NULL;	/* summary file block buffer */
+	struct timespec64 atime;
 
 	mp = tp->t_mountp;
 
@@ -999,7 +1000,10 @@ xfs_rtfree_extent(
 	    mp->m_sb.sb_rextents) {
 		if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM))
 			mp->m_rbmip->i_diflags |= XFS_DIFLAG_NEWRTBM;
-		*(uint64_t *)&VFS_I(mp->m_rbmip)->i_atime = 0;
+
+		atime = inode_get_atime(VFS_I(mp->m_rbmip));
+		*((uint64_t *)&atime) = 0;
+		inode_set_atime_to_ts(VFS_I(mp->m_rbmip), atime);
 		xfs_trans_log_inode(tp, mp->m_rbmip, XFS_ILOG_CORE);
 	}
 	return 0;
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 6b2296ff248a..70e97ea6eee7 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -65,7 +65,7 @@ xfs_trans_ichgtime(
 	tv = current_time(inode);
 
 	if (flags & XFS_ICHGTIME_MOD)
-		inode->i_mtime = tv;
+		inode_set_mtime_to_ts(inode, tv);
 	if (flags & XFS_ICHGTIME_CHG)
 		inode_set_ctime_to_ts(inode, tv);
 	if (flags & XFS_ICHGTIME_CREATE)
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fcefab687285..40e0a1f1f753 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1644,7 +1644,7 @@ xfs_swap_extents(
 	uint64_t		f;
 	int			resblks = 0;
 	unsigned int		flags = 0;
-	struct timespec64	ctime;
+	struct timespec64	ctime, mtime;
 
 	/*
 	 * Lock the inodes against other IO, page faults and truncate to
@@ -1758,10 +1758,11 @@ xfs_swap_extents(
 	 * under it.
 	 */
 	ctime = inode_get_ctime(VFS_I(ip));
+	mtime = inode_get_mtime(VFS_I(ip));
 	if ((sbp->bs_ctime.tv_sec != ctime.tv_sec) ||
 	    (sbp->bs_ctime.tv_nsec != ctime.tv_nsec) ||
-	    (sbp->bs_mtime.tv_sec != VFS_I(ip)->i_mtime.tv_sec) ||
-	    (sbp->bs_mtime.tv_nsec != VFS_I(ip)->i_mtime.tv_nsec)) {
+	    (sbp->bs_mtime.tv_sec != mtime.tv_sec) ||
+	    (sbp->bs_mtime.tv_nsec != mtime.tv_nsec)) {
 		error = -EBUSY;
 		goto out_trans_cancel;
 	}
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 4d55f58d99b7..36f5cf802c07 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -844,8 +844,8 @@ xfs_init_new_inode(
 	ASSERT(ip->i_nblocks == 0);
 
 	tv = inode_set_ctime_current(inode);
-	inode->i_mtime = tv;
-	inode->i_atime = tv;
+	inode_set_mtime_to_ts(inode, tv);
+	inode_set_atime_to_ts(inode, tv);
 
 	ip->i_extsize = 0;
 	ip->i_diflags = 0;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 127b2410eb20..17c51804f9c6 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -526,8 +526,8 @@ xfs_inode_to_log_dinode(
 	to->di_projid_hi = ip->i_projid >> 16;
 
 	memset(to->di_pad3, 0, sizeof(to->di_pad3));
-	to->di_atime = xfs_inode_to_log_dinode_ts(ip, inode->i_atime);
-	to->di_mtime = xfs_inode_to_log_dinode_ts(ip, inode->i_mtime);
+	to->di_atime = xfs_inode_to_log_dinode_ts(ip, inode_get_atime(inode));
+	to->di_mtime = xfs_inode_to_log_dinode_ts(ip, inode_get_mtime(inode));
 	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode_get_ctime(inode));
 	to->di_nlink = inode->i_nlink;
 	to->di_gen = inode->i_generation;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1c1e6171209d..687eff5d9e16 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,8 +572,8 @@ xfs_vn_getattr(
 	stat->uid = vfsuid_into_kuid(vfsuid);
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->ino = ip->i_ino;
-	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
+	stat->atime = inode_get_atime(inode);
+	stat->mtime = inode_get_mtime(inode);
 	stat->ctime = inode_get_ctime(inode);
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
@@ -1062,9 +1062,9 @@ xfs_vn_update_time(
 		now = current_time(inode);
 
 	if (flags & S_MTIME)
-		inode->i_mtime = now;
+		inode_set_mtime_to_ts(inode, now);
 	if (flags & S_ATIME)
-		inode->i_atime = now;
+		inode_set_atime_to_ts(inode, now);
 
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	xfs_trans_log_inode(tp, ip, log_flags);
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index f5377ba5967a..14462614fcc8 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -107,12 +107,12 @@ xfs_bulkstat_one_int(
 	buf->bs_size = ip->i_disk_size;
 
 	buf->bs_nlink = inode->i_nlink;
-	buf->bs_atime = inode->i_atime.tv_sec;
-	buf->bs_atime_nsec = inode->i_atime.tv_nsec;
-	buf->bs_mtime = inode->i_mtime.tv_sec;
-	buf->bs_mtime_nsec = inode->i_mtime.tv_nsec;
-	buf->bs_ctime = inode_get_ctime(inode).tv_sec;
-	buf->bs_ctime_nsec = inode_get_ctime(inode).tv_nsec;
+	buf->bs_atime = inode_get_atime_sec(inode);
+	buf->bs_atime_nsec = inode_get_atime_nsec(inode);
+	buf->bs_mtime = inode_get_mtime_sec(inode);
+	buf->bs_mtime_nsec = inode_get_mtime_nsec(inode);
+	buf->bs_ctime = inode_get_ctime_sec(inode);
+	buf->bs_ctime_nsec = inode_get_ctime_nsec(inode);
 	buf->bs_gen = inode->i_generation;
 	buf->bs_mode = inode->i_mode;
 
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 16534e9873f6..2e1a4e5cd03d 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1420,25 +1420,26 @@ xfs_rtunmount_inodes(
  */
 int					/* error */
 xfs_rtpick_extent(
-	xfs_mount_t	*mp,		/* file system mount point */
-	xfs_trans_t	*tp,		/* transaction pointer */
-	xfs_extlen_t	len,		/* allocation length (rtextents) */
-	xfs_rtblock_t	*pick)		/* result rt extent */
-{
-	xfs_rtblock_t	b;		/* result block */
-	int		log2;		/* log of sequence number */
-	uint64_t	resid;		/* residual after log removed */
-	uint64_t	seq;		/* sequence number of file creation */
-	uint64_t	*seqp;		/* pointer to seqno in inode */
+	xfs_mount_t		*mp,		/* file system mount point */
+	xfs_trans_t		*tp,		/* transaction pointer */
+	xfs_extlen_t		len,		/* allocation length (rtextents) */
+	xfs_rtblock_t		*pick)		/* result rt extent */
+	{
+	xfs_rtblock_t		b;		/* result block */
+	int			log2;		/* log of sequence number */
+	uint64_t		resid;		/* residual after log removed */
+	uint64_t		seq;		/* sequence number of file creation */
+	struct timespec64	ts;		/* temporary timespec64 storage */
 
 	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
 
-	seqp = (uint64_t *)&VFS_I(mp->m_rbmip)->i_atime;
 	if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM)) {
 		mp->m_rbmip->i_diflags |= XFS_DIFLAG_NEWRTBM;
-		*seqp = 0;
+		seq = 0;
+	} else {
+		ts = inode_get_atime(VFS_I(mp->m_rbmip));
+		seq = (uint64_t)ts.tv_sec;
 	}
-	seq = *seqp;
 	if ((log2 = xfs_highbit64(seq)) == -1)
 		b = 0;
 	else {
@@ -1450,7 +1451,8 @@ xfs_rtpick_extent(
 		if (b + len > mp->m_sb.sb_rextents)
 			b = mp->m_sb.sb_rextents - len;
 	}
-	*seqp = seq + 1;
+	ts.tv_sec = (time64_t)seq + 1;
+	inode_set_atime_to_ts(VFS_I(mp->m_rbmip), ts);
 	xfs_trans_log_inode(tp, mp->m_rbmip, XFS_ILOG_CORE);
 	*pick = b;
 	return 0;
-- 
2.41.0

