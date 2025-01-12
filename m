Return-Path: <linux-fsdevel+bounces-38964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFCA0A790
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68983A89C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F074E1922F2;
	Sun, 12 Jan 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D+UBgtoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005731494A3
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=GEQobmD6ScCzs2Dg/Q7IPpygnBRhAXWEuoB3mIjrEl9FhD+vAD725zpuWST3FM7U2ejyNi7gIVqTgu6gt4PnH9NpryTuQ/OidFOZMTv8Ve6aoM9dD8ZZWTXlMeux7b721ZAbUarDiAfQKxXo3KDsEZLCJGTbHe/j3h+WeXBjYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=HEaCBbZkihChoOI3bMNRU4zvLAlX9FhGx3Ov1FEtG8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGJH23qZniZeOK7PKxsFfn2oEqdwPL2oPyU5yRB+YZbRImQ5qCvDt3UANn3w6okeQx30nxM5LFJo7yFYDU1SfXvnV/gALJQR/QYe58qqVO1CDL3GxEDRhH9XtyO7hVuIY2DU6044sDKTCP1l2WxKKEq7TdtYMbdiMeY8Evyer4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D+UBgtoW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gdyGFIBoU1ORCe952ZRKQoSeaYnFIXXg/0Zeoxy/ohs=; b=D+UBgtoW5N+y9yDaxbrmLHVf+0
	yiNHD+7nRJ5NMX/1jcv7RF+JMrePMGRCszuSp3eiEwwb+Gyh5gK9ZKUkbdV15OZQ9yBiQeL0i05+R
	g2u64OEzxqRAuJGL+TGtxYwfT/OCcvFvyjVSVgQoBijnpiJWf7g8/k12QJPz8QXW9nbyFobhcqzNy
	ZQCYo3/7b53c54UibRGaBeDSZXtWexGDbzgJbD+Xs1ExlPZoTQpy9jmlPg81dSWRJ779SE1Ui9hUX
	yykmY+Vog0zfUBsway9uJ1rrS8RcMaZ6F97qqyOz8tQBwPGEhd+lPBPA13dpVhqbHO+cTDR7Jmj47
	uFbYXfUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszx-00000000aj2-2Qjd;
	Sun, 12 Jan 2025 08:07:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 02/21] debugfs: move ->automount into debugfs_inode_info
Date: Sun, 12 Jan 2025 08:06:46 +0000
Message-ID: <20250112080705.141166-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and don't bother with debugfs_fsdata for those.  Life's
simpler that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c    | 21 +++++----------------
 fs/debugfs/internal.h | 19 +++++++++----------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 5d423bd92f93..2f5afd7b1b94 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -246,8 +246,8 @@ static void debugfs_release_dentry(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
-	if (fsd && (fsd->real_fops || fsd->short_fops)) {
+	/* check it wasn't a dir or automount (no fsdata) */
+	if (fsd) {
 		WARN_ON(!list_empty(&fsd->cancellations));
 		mutex_destroy(&fsd->cancellations_mtx);
 	}
@@ -257,9 +257,9 @@ static void debugfs_release_dentry(struct dentry *dentry)
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+	struct inode *inode = path->dentry->d_inode;
 
-	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
+	return DEBUGFS_I(inode)->automount(path->dentry, inode->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -642,23 +642,13 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
-	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
-	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
-	if (!fsd) {
-		failed_creating(dentry);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	fsd->automount = f;
-
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
-		kfree(fsd);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -666,14 +656,13 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
-		kfree(fsd);
 		return failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = fsd;
+	DEBUGFS_I(inode)->automount = f;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 5cb940b0b8f6..a644e44a0ee4 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -13,6 +13,9 @@ struct file_operations;
 
 struct debugfs_inode_info {
 	struct inode vfs_inode;
+	union {
+		debugfs_automount_t automount;
+	};
 };
 
 static inline struct debugfs_inode_info *DEBUGFS_I(struct inode *inode)
@@ -29,17 +32,13 @@ extern const struct file_operations debugfs_full_short_proxy_file_operations;
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
 	const struct debugfs_short_fops *short_fops;
-	union {
-		/* automount_fn is used when real_fops is NULL */
-		debugfs_automount_t automount;
-		struct {
-			refcount_t active_users;
-			struct completion active_users_drained;
+	struct {
+		refcount_t active_users;
+		struct completion active_users_drained;
 
-			/* protect cancellations */
-			struct mutex cancellations_mtx;
-			struct list_head cancellations;
-		};
+		/* protect cancellations */
+		struct mutex cancellations_mtx;
+		struct list_head cancellations;
 	};
 };
 
-- 
2.39.5


