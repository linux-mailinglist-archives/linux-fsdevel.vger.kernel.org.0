Return-Path: <linux-fsdevel+bounces-62845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F168BA23FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B21C225B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5D020459A;
	Fri, 26 Sep 2025 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YjXdBi2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoQt0bGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3A1C5F1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855065; cv=none; b=DS4OhzzZFj5nhXC7T/t1KIX7MvR2EucODcKg4E+yA0B5frAG7w8S4EyrLkYikuwoAzjD20BjRQdAA1MbHiyTsIdwMfgDUxi1ijy1xkqq3Gp+VyCHAzmS7a2b4WKLLQKhwkmq9Q2nizkRB0EcScgi9YuPVEMddRsZsPuMe93xrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855065; c=relaxed/simple;
	bh=2MTDvH0IhdCOm+MGeDfqFSeYPx+rKFZ0HsdlZddPUqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i82DEhaaKti5ijCbe2LYwwMO+j/yYNMShHC5otFFIkC3RYSfEsKWyeiSNahJnpTkxXMbB6eeT4wgo9CWSwqFIJc5spUXrxvO4/ldNza6mZjfXF4xgU2j0xT9mxkZmVx7SCS2O/1t+OSvatRNQIHxV2PPoDx2w6gAxS6zS468G2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YjXdBi2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoQt0bGs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CEF08EC01C9;
	Thu, 25 Sep 2025 22:51:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 22:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855061;
	 x=1758941461; bh=teycFwScudRQjNEdQ+l0m5w3Koakn5txirTB2bIc4So=; b=
	YjXdBi2uKitbb2VUxKyVsQmCJD85HrIVhP7IX9bVNgjaib5gVx3sCgAuhhIds83T
	P/5q0L23p/CsUkq+04pGO1Timk8/3mSydH/Z6mqMfIkRI5qZqNlMYxaY67wslNsP
	yP9xFLilhBV4R5FAkPiRaySxgKO3hSMYGFaQG652td7uUyYUDz0obILGA/GmveVs
	4QqEafd8ZUNdpLzB37QrsQDHUB3VDwi9jVWFvl4qkBAQJOJObLIfMz3pd2d7cAZO
	V6vhMVZJeoFm+zNVE63LveNPeGmf6ktTZ0W9fJdQ4SudF4B21cMJ2lRSvjx4MJuv
	ZAg2grFMlELDwETTnbLvoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855061; x=1758941461; bh=t
	eycFwScudRQjNEdQ+l0m5w3Koakn5txirTB2bIc4So=; b=HoQt0bGsN1oT1VXqn
	i67zaUKv9OkpK0+mQiQAPF7xGJPMMYKVfut6kHavqPsnySwDDNc0GK88WstzP6mV
	ObsYTLycqwHUqPdzC/PDgkAvD2a0/lVdWUd3viZJ+zYanRcyXRS9/+C/Wy9GqmBj
	f5NWgrHVvm5xLdQN/xHe90X7nOL+OlpBSzeBk7vI3DTAZ40dAT403AD25GVkYUuL
	rhEAKee2wi78hvBOTkNa1ZSOtVTIbPrbuAt34LQjaS3EYGbtnMspL2aWS3CbwqB/
	NOKSVXYIZA9WZic7gdiPEaX79QHlYPh80XaBu50Dq0+mchRzrj1nMPN2BavXUMJ9
	/vfaw==
X-ME-Sender: <xms:lf_VaEc8VKzj4CpzD52nlLrSqogxywXj3M2jpSMrLV-TlVLXO5ePTg>
    <xme:lf_VaNnqgT-f7I3terlzAySNMNY7SUpOJiKxVqUuJQGUccQFvB4yNjkhDxfxvcHLK
    tw1oXX2tuxtEFL_Th0avYrkPUkkr8siDUAvFlE2AmZ7GFlE1A>
X-ME-Received: <xmr:lf_VaLH4KXCrEZPL0vz3YYKcCUP-VapL2WvWsSN8ZdYiHECCMUonIILvvDqlmSdF3rrjIIo5By6MnPnnbDTTVq9gDCY-dhdZGtj8LecPHDl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lf_VaF7FvSPTmEkHnAt61CfFI9EtwFaSC1U-CO3wwFKRt3T_AdBbsw>
    <xmx:lf_VaDnrdryUr9I0IV33JgGK9xcRdP8geyt62uDkZWMSmog2vXRyHA>
    <xmx:lf_VaKoxOKQ4nbZGrswCQr7xDsFRcMt3xX37TOwljn2fRCakwbx3_Q>
    <xmx:lf_VaCtBke-8iX_89U8mhX1Ulhf00Puwi9i4dFxA8ZaG55AzdpuOiw>
    <xmx:lf_VaKViWhKvF-scv7ygPW94piS8sTK0eqFEw5lSOwwvrvCfjp8H_wLg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:59 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/11] VFS: add start_creating_killable() and start_removing_killable()
Date: Fri, 26 Sep 2025 12:49:11 +1000
Message-ID: <20250926025015.1747294-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/btrfs/ioctl.c      | 43 +++++++----------------
 fs/namei.c            | 80 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/namei.h |  6 ++++
 3 files changed, 95 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e13de2bdcbf..3a007f59f7f2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -880,8 +880,6 @@ static inline int btrfs_may_create(struct mnt_idmap *idmap,
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
-	if (IS_DEADDIR(dir))
-		return -ENOENT;
 	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
 		return -EOVERFLOW;
 	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
@@ -904,14 +902,9 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
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
@@ -940,9 +933,7 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 out_up_read:
 	up_read(&fs_info->subvol_sem);
 out_dput:
-	dput(dentry);
-out_unlock:
-	btrfs_inode_unlock(BTRFS_I(dir), 0);
+	end_creating(dentry, parent);
 	return ret;
 }
 
@@ -2417,18 +2408,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
@@ -2449,7 +2432,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 */
 		ret = -EPERM;
 		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
-			goto out_dput;
+			goto out_end_removing;
 
 		/*
 		 * Do not allow deletion if the parent dir is the same
@@ -2460,21 +2443,21 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
@@ -2483,10 +2466,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
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
index cb4d40af12ae..f5c96f801b74 100644
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
  * @de - the dentry which was returned by start_dirop or similar.
@@ -3296,6 +3310,66 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing);
 
+/**
+ * start_creating_killable - prepare to create a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
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
+ * @idmap - idmap of the mount
+ * @parent - directory in which to find the name
+ * @name - the name to be removed
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
  * @parent - directory in which to prepare to create the name
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 32a007f1043e..9771ec940b72 100644
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


