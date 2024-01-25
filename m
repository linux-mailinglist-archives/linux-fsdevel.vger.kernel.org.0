Return-Path: <linux-fsdevel+bounces-8934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B519483C770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289351F25F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD474E1A;
	Thu, 25 Jan 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YetrPFPH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9A6EB62
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198702; cv=none; b=p4e4t5/DxTP5qfv+zLa9EkbT03XryfZtv28+k89VGxrXyBzGbPJMhbE5gn00IIoCjpNPNSgxxkvVY/k7bSdAsdsMP5oMvYy9W/meQZWnaUN3QfwC2GjhMjZJu/ng69F/XR0i3mH2B5JueEJ9tLgFDz0DshRs8fpZZ/HKCz6K0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198702; c=relaxed/simple;
	bh=eck+Q6/d4PdPQ302HNsXwlqFeWOBFOPpF3o+EqB6Hzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBzAGziPWZL7Qu/ROsSzbYjUxlPu0sU2zMTj8F/cH2qj04eouZ0iJrdZGUPZmNCi+xeZa6DzUnORM3KN3bbv2AqhUhfasoc/MKrBxUKlYD+Bk0CcVJ7E39XWGtx8KIzOK1DAwwDQnvpj4+4NjGCbf+xBLUrAxZktNJ3+cVrm+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YetrPFPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A9FC43399;
	Thu, 25 Jan 2024 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706198702;
	bh=eck+Q6/d4PdPQ302HNsXwlqFeWOBFOPpF3o+EqB6Hzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YetrPFPHgtUaG3Ufw0vPIUgmEFCKQV9mxyQR00kmfrvasNh9INeTnFqSpWHFVivJj
	 +fbpqDK1nM00YZVONqDhg8uDDQAE1fUVlIfb22AKwhYnY1RZSsMDr4A0kI/ZmNKHW5
	 2ocBT2xCB3+amEGFJZoUoTf/xgHeDzegCa6+jUkUK1h3E/RAq1dgcEYm4SIstDF4my
	 WDIF/tpd/6uk9VLGFDqHZJdTaEVJnCkfDiW/cu9IShGKD9xbRtrgcfSVtxr9GLZ/b3
	 xFu4AxsriGCPGTW59Oj1Gn89djqdlBdyGGcJJ2aPB7s701MjfbB3PtleqqqhvgxmXx
	 kuPROLm9GuXqQ==
From: cem@kernel.org
To: jack@suze.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] Enable support for tmpfs quotas
Date: Thu, 25 Jan 2024 17:04:35 +0100
Message-ID: <20240125160447.1136023-4-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125160447.1136023-1-cem@kernel.org>
References: <20240125160447.1136023-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

To achieve so, add a new function quotactl_handle() to the quotaio subsystem,
this will call do_quotactl() with or without a valid quotadev, according to the
filesystem type.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 mntopt.h          |  1 +
 quotaio.c         | 19 +++++++++++++++++--
 quotaio.h         |  2 ++
 quotaio_generic.c | 11 +++++------
 quotaio_meta.c    |  3 +--
 quotaio_v1.c      | 11 +++++------
 quotaio_v2.c      | 11 +++++------
 quotaio_xfs.c     |  4 ++--
 quotasys.c        | 21 ++++++++++++++++++---
 9 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/mntopt.h b/mntopt.h
index 0f3b0c5..9b71990 100644
--- a/mntopt.h
+++ b/mntopt.h
@@ -22,6 +22,7 @@
 #define MNTTYPE_MPFS		"mpfs"  /* EMC Celerra MPFS filesystem */
 #define MNTTYPE_OCFS2		"ocfs2"	/* Oracle Cluster filesystem */
 #define MNTTYPE_GFS2		"gfs2"	/* Red Hat Global filesystem 2 */
+#define MNTTYPE_TMPFS		"tmpfs"	/* tmpfs filesystem */
 
 #ifndef MNTTYPE_NFS
 #define MNTTYPE_NFS	"nfs"		/* Network file system.  */
diff --git a/quotaio.c b/quotaio.c
index 9bebb5e..ae40d2a 100644
--- a/quotaio.c
+++ b/quotaio.c
@@ -34,6 +34,22 @@ struct disk_dqheader {
 	u_int32_t dqh_version;
 } __attribute__ ((packed));
 
+int quotactl_handle(int cmd, struct quota_handle *h, int id, void *addr)
+{
+	int err = -EINVAL;
+
+	if (!h)
+		return err;
+
+	if (!strcmp(h->qh_fstype, MNTTYPE_TMPFS))
+		err = do_quotactl(QCMD(cmd, h->qh_type), NULL, h->qh_dir,
+					id, addr);
+	else
+		err = do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev,
+					h->qh_dir, id, addr);
+
+	return err;
+}
 /*
  *	Detect quota format and initialize quota IO
  */
@@ -140,8 +156,7 @@ struct quota_handle *init_io(struct mount_entry *mnt, int type, int fmt, int fla
 		if (QIO_ENABLED(h)) {	/* Kernel uses same file? */
 			unsigned int cmd =
 				(kernel_iface == IFACE_GENERIC) ? Q_SYNC : Q_6_5_SYNC;
-			if (do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev,
-				     h->qh_dir, 0,  NULL) < 0) {
+			if (quotactl_handle(cmd, h, 0,  NULL) < 0) {
 				die(4, _("Cannot sync quotas on device %s: %s\n"),
 				    h->qh_quotadev, strerror(errno));
 			}
diff --git a/quotaio.h b/quotaio.h
index 2c373b2..91689d9 100644
--- a/quotaio.h
+++ b/quotaio.h
@@ -182,4 +182,6 @@ struct dquot *get_empty_dquot(void);
 /* Check whether values in current dquot can be stored on disk */
 int check_dquot_range(struct dquot *dquot);
 
+/* Uses do_quotactl() to call quotactl() or quotactl_fd() */
+int quotactl_handle(int cmd, struct quota_handle *h, int id, void *addr);
 #endif /* GUARD_QUOTAIO_H */
diff --git a/quotaio_generic.c b/quotaio_generic.c
index 3c95872..cf03b59 100644
--- a/quotaio_generic.c
+++ b/quotaio_generic.c
@@ -50,7 +50,7 @@ int vfs_get_info(struct quota_handle *h)
 {
 	struct if_dqinfo kinfo;
 
-	if (do_quotactl(QCMD(Q_GETINFO, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kinfo) < 0) {
+	if (quotactl_handle(Q_GETINFO, h, 0, (void *)&kinfo) < 0) {
 		errstr(_("Cannot get info for %s quota file from kernel on %s: %s\n"), type2name(h->qh_type), h->qh_quotadev, strerror(errno));
 		return -1;
 	}
@@ -68,7 +68,7 @@ int vfs_set_info(struct quota_handle *h, int flags)
 	kinfo.dqi_igrace = h->qh_info.dqi_igrace;
 	kinfo.dqi_valid = flags;
 
-	if (do_quotactl(QCMD(Q_SETINFO, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kinfo) < 0) {
+	if (quotactl_handle(Q_SETINFO, h, 0, (void *)&kinfo) < 0) {
 		errstr(_("Cannot set info for %s quota file from kernel on %s: %s\n"), type2name(h->qh_type), h->qh_quotadev, strerror(errno));
 		return -1;
 	}
@@ -80,7 +80,7 @@ int vfs_get_dquot(struct dquot *dquot)
 {
 	struct if_dqblk kdqblk;
 
-	if (do_quotactl(QCMD(Q_GETQUOTA, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev, dquot->dq_h->qh_dir, dquot->dq_id, (void *)&kdqblk) < 0) {
+	if (quotactl_handle(Q_GETQUOTA, dquot->dq_h, dquot->dq_id, (void *)&kdqblk) < 0) {
 		errstr(_("Cannot get quota for %s %d from kernel on %s: %s\n"), type2name(dquot->dq_h->qh_type), dquot->dq_id, dquot->dq_h->qh_quotadev, strerror(errno));
 		return -1;
 	}
@@ -95,7 +95,7 @@ int vfs_set_dquot(struct dquot *dquot, int flags)
 
 	generic_util2kerndqblk(&kdqblk, &dquot->dq_dqb);
 	kdqblk.dqb_valid = flags;
-	if (do_quotactl(QCMD(Q_SETQUOTA, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev, dquot->dq_h->qh_dir, dquot->dq_id, (void *)&kdqblk) < 0) {
+	if (quotactl_handle(Q_SETQUOTA, dquot->dq_h, dquot->dq_id, (void *)&kdqblk) < 0) {
 		errstr(_("Cannot set quota for %s %d from kernel on %s: %s\n"), type2name(dquot->dq_h->qh_type), dquot->dq_id, dquot->dq_h->qh_quotadev, strerror(errno));
 		return -1;
 	}
@@ -188,8 +188,7 @@ int vfs_scan_dquots(struct quota_handle *h,
 
 	dquot->dq_h = h;
 	while (1) {
-		ret = do_quotactl(QCMD(Q_GETNEXTQUOTA, h->qh_type),
-			       h->qh_quotadev, h->qh_dir, id, (void *)&kdqblk);
+		ret = quotactl_handle(Q_GETNEXTQUOTA, h, id, (void *)&kdqblk);
 		if (ret < 0)
 			break;
 
diff --git a/quotaio_meta.c b/quotaio_meta.c
index 51ebbcf..99fdaf8 100644
--- a/quotaio_meta.c
+++ b/quotaio_meta.c
@@ -59,8 +59,7 @@ static int meta_scan_dquots(struct quota_handle *h, int (*process_dquot)(struct
 	struct if_nextdqblk kdqblk;
 	int ret;
 
-	ret = do_quotactl(QCMD(Q_GETNEXTQUOTA, h->qh_type), h->qh_quotadev,
-			  h->qh_dir, 0, (void *)&kdqblk);
+	ret = quotactl_handle(Q_GETNEXTQUOTA, h, 0, (void *)&kdqblk);
 	/*
 	 * Fall back to scanning using passwd if Q_GETNEXTQUOTA is not
 	 * supported
diff --git a/quotaio_v1.c b/quotaio_v1.c
index 187a5a5..0b88d0c 100644
--- a/quotaio_v1.c
+++ b/quotaio_v1.c
@@ -118,7 +118,7 @@ static int v1_init_io(struct quota_handle *h)
 		else {
 			struct v1_kern_dqblk kdqblk;
 
-			if (do_quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqblk) < 0) {
+			if (quotactl_handle(Q_V1_GETQUOTA, h, 0, (void *)&kdqblk) < 0) {
 				if (errno == EPERM) {	/* We have no permission to get this information? */
 					h->qh_info.dqi_bgrace = h->qh_info.dqi_igrace = 0;	/* It hopefully won't be needed */
 				}
@@ -193,11 +193,11 @@ static int v1_write_info(struct quota_handle *h)
 		else {
 			struct v1_kern_dqblk kdqblk;
 
-			if (do_quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqblk) < 0)
+			if (quotactl_handle(Q_V1_GETQUOTA, h, 0, (void *)&kdqblk) < 0)
 				return -1;
 			kdqblk.dqb_btime = h->qh_info.dqi_bgrace;
 			kdqblk.dqb_itime = h->qh_info.dqi_igrace;
-			if (do_quotactl(QCMD(Q_V1_SETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqblk) < 0)
+			if (quotactl_handle(Q_V1_SETQUOTA, h, 0, (void *)&kdqblk) < 0)
 				return -1;
 		}
 	}
@@ -237,7 +237,7 @@ static struct dquot *v1_read_dquot(struct quota_handle *h, qid_t id)
 		else {
 			struct v1_kern_dqblk kdqblk;
 
-			if (do_quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, id, (void *)&kdqblk) < 0) {
+			if (quotactl_handle(Q_V1_GETQUOTA, h, id, (void *)&kdqblk) < 0) {
 				free(dquot);
 				return NULL;
 			}
@@ -299,8 +299,7 @@ static int v1_commit_dquot(struct dquot *dquot, int flags)
 			else
 				cmd = Q_V1_SETQUOTA;
 			v1_util2kerndqblk(&kdqblk, &dquot->dq_dqb);
-			if (do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev, h->qh_dir, dquot->dq_id,
-			     (void *)&kdqblk) < 0)
+			if (quotactl_handle(cmd, h, dquot->dq_id, (void *)&kdqblk) < 0)
 				return -1;
 		}
 	}
diff --git a/quotaio_v2.c b/quotaio_v2.c
index b0fe7bf..9927cad 100644
--- a/quotaio_v2.c
+++ b/quotaio_v2.c
@@ -275,7 +275,7 @@ static int v2_init_io(struct quota_handle *h)
 		else {
 			struct v2_kern_dqinfo kdqinfo;
 
-			if (do_quotactl(QCMD(Q_V2_GETINFO, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqinfo) < 0) {
+			if (quotactl_handle(Q_V2_GETINFO, h, 0, (void *)&kdqinfo) < 0) {
 				/* Temporary check just before fix gets to kernel */
 				if (errno == EPERM)	/* Don't have permission to get information? */
 					return 0;
@@ -403,8 +403,8 @@ static int v2_write_info(struct quota_handle *h)
 			kdqinfo.dqi_blocks = h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks;
 			kdqinfo.dqi_free_blk = h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_blk;
 			kdqinfo.dqi_free_entry = h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_entry;
-			if (do_quotactl(QCMD(Q_V2_SETGRACE, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqinfo) < 0 ||
-			    do_quotactl(QCMD(Q_V2_SETFLAGS, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqinfo) < 0)
+			if (quotactl_handle(Q_V2_SETGRACE, h, 0, (void *)&kdqinfo) < 0 ||
+			    quotactl_handle(Q_V2_SETFLAGS, h, 0, (void *)&kdqinfo) < 0)
 					return -1;
 		}
 	}
@@ -441,7 +441,7 @@ static struct dquot *v2_read_dquot(struct quota_handle *h, qid_t id)
 		else {
 			struct v2_kern_dqblk kdqblk;
 
-			if (do_quotactl(QCMD(Q_V2_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, id, (void *)&kdqblk) < 0) {
+			if (quotactl_handle(Q_V2_GETQUOTA, h, id, (void *)&kdqblk) < 0) {
 				free(dquot);
 				return NULL;
 			}
@@ -485,8 +485,7 @@ static int v2_commit_dquot(struct dquot *dquot, int flags)
 			else
 				cmd = Q_V2_SETQUOTA;
 			v2_util2kerndqblk(&kdqblk, &dquot->dq_dqb);
-			if (do_quotactl(QCMD(cmd, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev,
-			     dquot->dq_h->qh_dir, dquot->dq_id, (void *)&kdqblk) < 0)
+			if (quotactl_handle(cmd, dquot->dq_h, dquot->dq_id, (void *)&kdqblk) < 0)
 				return -1;
 		}
 		return 0;
diff --git a/quotaio_xfs.c b/quotaio_xfs.c
index 0bf6f34..d742f9c 100644
--- a/quotaio_xfs.c
+++ b/quotaio_xfs.c
@@ -128,7 +128,7 @@ static int xfs_init_io(struct quota_handle *h)
 
 	qcmd = QCMD(Q_XFS_GETQSTAT, h->qh_type);
 	memset(&info, 0, sizeof(struct xfs_mem_dqinfo));
-	if (do_quotactl(qcmd, h->qh_quotadev, h->qh_dir, 0, (void *)&info) < 0)
+	if (quotactl_handle(qcmd, h, 0, (void *)&info) < 0)
 		return -1;
 	h->qh_info.dqi_bgrace = info.qs_btimelimit;
 	h->qh_info.dqi_igrace = info.qs_itimelimit;
@@ -153,7 +153,7 @@ static int xfs_write_info(struct quota_handle *h)
 	xdqblk.d_itimer = h->qh_info.dqi_igrace;
 	xdqblk.d_fieldmask |= FS_DQ_TIMER_MASK;
 	qcmd = QCMD(Q_XFS_SETQLIM, h->qh_type);
-	if (do_quotactl(qcmd, h->qh_quotadev, h->qh_dir, 0, (void *)&xdqblk) < 0)
+	if (quotactl_handle(qcmd, h, 0, (void *)&xdqblk) < 0)
 		return -1;
 	return 0;
 }
diff --git a/quotasys.c b/quotasys.c
index 903816b..2655345 100644
--- a/quotasys.c
+++ b/quotasys.c
@@ -73,6 +73,11 @@ int meta_qf_fstype(char *type)
 	return !strcmp(type, MNTTYPE_OCFS2);
 }
 
+int tmpfs_fstype(char *type)
+{
+	return !strcmp(type, MNTTYPE_TMPFS);
+}
+
 /*
  *	Convert type of quota to written representation
  */
@@ -752,6 +757,7 @@ static int hasvfsmetaquota(const char *dev, struct mntent *mnt, int type, int fl
 
 	if (!do_quotactl(QCMD(Q_GETFMT, type), dev, mnt->mnt_dir, 0, (void *)&fmt))
 		return QF_META;
+
 	return QF_ERROR;
 }
 
@@ -816,8 +822,13 @@ static int hasquota(const char *dev, struct mntent *mnt, int type, int flags)
 	    !strcmp(mnt->mnt_type, MNTTYPE_XFS) ||
 	    !strcmp(mnt->mnt_type, MNTTYPE_EXFS))
 		return hasxfsquota(dev, mnt, type, flags);
+
 	if (!strcmp(mnt->mnt_type, MNTTYPE_OCFS2))
 		return hasvfsmetaquota(dev, mnt, type, flags);
+
+	/* tmpfs has no device, pass null here so quotactl_fd() is called */
+	if (!strcmp(mnt->mnt_type, MNTTYPE_TMPFS))
+		return hasvfsmetaquota(NULL, mnt, type, flags);
 	/*
 	 * For ext4 we check whether it has quota in system files and if not,
 	 * we fall back on checking standard quotas. Furthermore we cannot use
@@ -1384,7 +1395,7 @@ alloc:
 			continue;
 		}
 
-		if (!nfs_fstype(mnt->mnt_type)) {
+		if (!nfs_fstype(mnt->mnt_type) && !tmpfs_fstype(mnt->mnt_type)) {
 			if (stat(devname, &st) < 0) {	/* Can't stat mounted device? */
 				errstr(_("Cannot stat() mounted device %s: %s\n"), devname, strerror(errno));
 				free((char *)devname);
@@ -1398,6 +1409,7 @@ alloc:
 			dev = st.st_rdev;
 			for (i = 0; i < mnt_entries_cnt && mnt_entries[i].me_dev != dev; i++);
 		}
+
 		/* Cope with network filesystems or new mountpoint */
 		if (nfs_fstype(mnt->mnt_type) || i == mnt_entries_cnt) {
 			if (stat(mnt->mnt_dir, &st) < 0) {	/* Can't stat mountpoint? We have better ignore it... */
@@ -1570,8 +1582,11 @@ restart:
 	sd = check_dirs + act_checked;
 	for (i = 0; i < mnt_entries_cnt; i++) {
 		if (sd->sd_isdir) {
-			if (sd->sd_dev == mnt_entries[i].me_dev && sd->sd_ino == mnt_entries[i].me_ino)
-				break;
+			if (sd->sd_ino == mnt_entries[i].me_ino)
+				if ((sd->sd_dev == mnt_entries[i].me_dev) ||
+				    (!strcmp(mnt_entries[i].me_type, MNTTYPE_TMPFS)))
+					break;
+
 		}
 		else
 			if (sd->sd_dev == mnt_entries[i].me_dev)
-- 
2.43.0


