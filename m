Return-Path: <linux-fsdevel+bounces-64184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B1BDC074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF43E3309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047002FB984;
	Wed, 15 Oct 2025 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="q0GAUS/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RySqOwhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659E2FB0B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492933; cv=none; b=Jbt6if0T0Qk4vYSAS9E8QN9CXKyV0/MLcjGBsDkuCffrKQXaAlk7Mri204/7YSAkmmroWeF7nvHfMoiul+K6yTB/3uvOgVVmaFgm/PbdVynUw38gMou0lQCsLPiQq3M+B0NoIr9uOqj53nzMMsNy3U1YogMes7Iy3iUr6rDcgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492933; c=relaxed/simple;
	bh=lvLaEpNbIdKSPD/pOI5N5yLYW/6x33Xdth/HeRzcyH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQepHcOcjhAHUR4e1WJPiU61lz8bzGJtOmKvqZVilwHlV3WL9Y+jLTl0FzfrhXZUjBMXe1lc+leqw7CjYRrxZo0Y/fKltbB5+QNS3vJFExadkxv89CqZfsc3dgk5QyxkGRjyawiQUKRTJuggYvXuKTFQj/uUEaSfp2WuWICzTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=q0GAUS/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RySqOwhG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B2897EC023F;
	Tue, 14 Oct 2025 21:48:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 21:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492928;
	 x=1760579328; bh=I6StfOjqE3oh2lquyYNPVVvsVAS6+Gog4sTTx+bEtbc=; b=
	q0GAUS/u+uF7XK7yI5V7AB9wAYzebCk3xbO2NvJ2PEQweC1GsaMwStt5sPLVuxxI
	nGW0hVLd1qvbH/YDR6czrtn3s9Lq4yLxXylYU500OUPL9ZmPQG3YCViPqSshwrtu
	+ryygY/qwLHI1ZCK/p4cXlq62wQyDVvQfjK2ujnR007fxy5KWwc1HTngfqTN9U4e
	9RC3CPyr+E5ZUsc7mPb8jbmMp1OFApheu+ALo6CwqAbp3g/DIUa+7drkUAC3E2o0
	E9WSj60C8321AzeM/CA+getnBz21Bu5Cic7Fkkkfyh5OK275/ltEDlnDnaUZ6jg1
	drBOZEWSVtDYi2wE8tbKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492928; x=1760579328; bh=I
	6StfOjqE3oh2lquyYNPVVvsVAS6+Gog4sTTx+bEtbc=; b=RySqOwhGv4X9A/cw/
	BreW0rNRsshmWY1MTCKg6Joi4tB73V4x8AxVea5x/6Tqo4+9qFDMUZvxolx7pfLG
	nnHn22cpFsaXO0NhCoZrExfwFU+HhTuNi47jCAlPezRbDY1MLlj8JP3CZpeXL6E/
	UmWINugDLZF8tSQ0Qy8xw3rESKHguGj6B+z/w6zKA3xyIvSr05dR76LdjkPH78aJ
	OojpH6ffTJDg7kVAUzjyTNwb8dFAcolgv4xFfhfkQrsbec2Ua2M83yr3OwELDEnr
	ZpR2SQiw8AzpUPSvxTy5XoPeLgRVh3Q8gDeOUpdcC4ongQfVMLn0qhxKGd+ehA9b
	1jkGA==
X-ME-Sender: <xms:gP3uaL-hXJ8svomCxWK-zCA2ytKtuxTaRPrkzyPejSfKa7PM_5L7ng>
    <xme:gP3uaCqXBmFZm1ooPEEtD2t3i9QC709Mz1g8joWH0HVowe4xtFDNiewn_7C8N7TBa
    t1t0mYgzNQr2hjXietvJUT8DXc2g9RCOc3g9XMYnt5_aTPpfDM>
X-ME-Received: <xmr:gP3uaICPXhDKDq7Hn66wilqH8LT94c1Vj83aXwQUR3MRaSwMTzYP6cyPKWyVKYqTTW4fSPyGcBsn-OucgZDQSyWZAysochevcH565hmt4jo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gP3uaMwd_jWboNzukuJGas4b7Gqr4xTpXCNLIFbTO7n5aSo2aF48iw>
    <xmx:gP3uaN3TS5dAnGijjPtq4FPO527nN5wYDUvk-rVCwR6I4g6nIMG9QA>
    <xmx:gP3uaEwxDRDsV5Y3f8bTyQ_SS0gz-dVCJgYo-LmOvEnIMFdSb10fog>
    <xmx:gP3uaMEZrVGCEh8_Vh3e4SbYS9AytdXuQjmNfuqVuxPLoaU93zFRng>
    <xmx:gP3uaO2jP5OVw9Tq1wnXzFkp9reBCxk_ndYl7jhIF8DK6RYsVVFTNDFC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:46 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/14] VFS: add start_creating_killable() and start_removing_killable()
Date: Wed, 15 Oct 2025 12:47:00 +1100
Message-ID: <20251015014756.2073439-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251015014756.2073439-1-neilb@ownmail.net>
References: <20251015014756.2073439-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

These are similar to start_creating() and start_removing(), but allow a
fatal signal to abort waiting for the lock.

They are used in btrfs for subvol creation and removal.

btrfs_may_create() no longer needs IS_DEADDIR() and
start_creating_killable() includes that check.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/btrfs/ioctl.c      | 41 +++++++---------------
 fs/namei.c            | 80 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/namei.h |  6 ++++
 3 files changed, 95 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 185bef0df1c2..4fbfdd8faf6a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -904,14 +904,9 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 	struct fscrypt_str name_str = FSTR_INIT((char *)qname->name, qname->len);
 	int ret;
 
-	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (ret == -EINTR)
-		return ret;
-
-	dentry = lookup_one(idmap, qname, parent);
-	ret = PTR_ERR(dentry);
+	dentry = start_creating_killable(idmap, parent, qname);
 	if (IS_ERR(dentry))
-		goto out_unlock;
+		return PTR_ERR(dentry);
 
 	ret = btrfs_may_create(idmap, dir, dentry);
 	if (ret)
@@ -940,9 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 out_up_read:
 	up_read(&fs_info->subvol_sem);
 out_dput:
-	dput(dentry);
-out_unlock:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+	end_creating(dentry, parent);
 	return ret;
 }
 
@@ -2417,18 +2410,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		goto free_subvol_name;
 	}
 
-	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (ret == -EINTR)
-		goto free_subvol_name;
-	dentry = lookup_one(idmap, &QSTR(subvol_name), parent);
+	dentry = start_removing_killable(idmap, parent, &QSTR(subvol_name));
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
-		goto out_unlock_dir;
-	}
-
-	if (d_really_is_negative(dentry)) {
-		ret = -ENOENT;
-		goto out_dput;
+		goto out_end_removing;
 	}
 
 	inode = d_inode(dentry);
@@ -2449,7 +2434,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EPERM;
 		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
-			goto out_dput;
+			goto out_end_removing;
 
 		/*
 		 * Do not allow deletion if the parent dir is the same
@@ -2460,21 +2445,21 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EINVAL;
 		if (root == dest)
-			goto out_dput;
+			goto out_end_removing;
 
 		ret = inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
 		if (ret)
-			goto out_dput;
+			goto out_end_removing;
 	}
 
 	/* check if subvolume may be deleted by a user */
 	ret = btrfs_may_delete(idmap, dir, dentry, 1);
 	if (ret)
-		goto out_dput;
+		goto out_end_removing;
 
 	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = -EINVAL;
-		goto out_dput;
+		goto out_end_removing;
 	}
 
 	btrfs_inode_lock(BTRFS_I(inode), 0);
@@ -2483,10 +2468,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	if (!ret)
 		d_delete_notify(dir, dentry);
 
-out_dput:
-	dput(dentry);
-out_unlock_dir:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+out_end_removing:
+	end_removing(dentry);
 free_subvol_name:
 	kfree(subvol_name_ptr);
 free_parent:
diff --git a/fs/namei.c b/fs/namei.c
index bfc443bec8a9..04d2819bd351 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2778,19 +2778,33 @@ static int filename_parentat(int dfd, struct filename *name,
  * Returns: a locked dentry, or an error.
  *
  */
-struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
-			   unsigned int lookup_flags)
+static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
+				    unsigned int lookup_flags,
+				    unsigned int state)
 {
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
+	if (state == TASK_KILLABLE) {
+		int ret = down_write_killable_nested(&dir->i_rwsem,
+						     I_MUTEX_PARENT);
+		if (ret)
+			return ERR_PTR(ret);
+	} else {
+		inode_lock_nested(dir, I_MUTEX_PARENT);
+	}
 	dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
 	if (IS_ERR(dentry))
 		inode_unlock(dir);
 	return dentry;
 }
 
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags)
+{
+	return __start_dirop(parent, name, lookup_flags, TASK_NORMAL);
+}
+
 /**
  * end_dirop - signal completion of a dirop
  * @de: the dentry which was returned by start_dirop or similar.
@@ -3275,6 +3289,66 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing);
 
+/**
+ * start_creating_killable - prepare to create a given name with permission checking
+ * @idmap:  idmap of the mount
+ * @parent: directory in which to prepare to create the name
+ * @name:   the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
+ * an object in a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name already exists, a positive dentry is returned.
+ *
+ * If a signal is received or was already pending, the function aborts
+ * with -EINTR;
+ *
+ * Returns: a negative or positive dentry, or an error.
+ */
+struct dentry *start_creating_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return __start_dirop(parent, name, LOOKUP_CREATE, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(start_creating_killable);
+
+/**
+ * start_removing_killable - prepare to remove a given name with permission checking
+ * @idmap:  idmap of the mount
+ * @parent: directory in which to find the name
+ * @name:   the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_removing() should be called when removal is complete, or aborted.
+ *
+ * If a signal is received or was already pending, the function aborts
+ * with -EINTR;
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return __start_dirop(parent, name, 0, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(start_removing_killable);
+
 /**
  * start_creating_noperm - prepare to create a given name without permission checking
  * @parent: directory in which to prepare to create the name
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 7e916e9d7726..e5cff89679df 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -92,6 +92,12 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
 struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_creating_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name);
+struct dentry *start_removing_killable(struct mnt_idmap *idmap,
+				       struct dentry *parent,
+				       struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_dentry(struct dentry *parent,
-- 
2.50.0.107.gf914562f5916.dirty


