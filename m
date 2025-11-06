Return-Path: <linux-fsdevel+bounces-67245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D392BC38967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83AF3B9349
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96122126D;
	Thu,  6 Nov 2025 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XPJmGYK0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbdtCLf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB601E5724;
	Thu,  6 Nov 2025 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390548; cv=none; b=k+frv62oawycHzQMr4jzCzkXyxpiUk0/13X7+Rw7AeR3Wk/IvAlQs/gDANGE7VusZ6NTZXt5a3B8YsJrCLwY8+LQj3bdlT7Heoct9RrPt3jFMbwEXkOU/rR+7T+Y4v0DBZkPQCTcv2+czBErNOnMsHbCKrPQBQI2rKkMcoOD4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390548; c=relaxed/simple;
	bh=047jfL6s61LZaEIBYmzfucfb0b84bJ21twF4SyUYhPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtjASyOQ0WEKMn7dOIv2horfJ58bGEXb+F5BYe7ymc+22aRw8fBTxr1+gNY68mpVQm5y+Ev+T+dKzcVFw5r7ocXwIkUQ4u/tkCoVCbig4Pw7Vu6TrFLrlne40hwpZ3jTtFIeafCAuHsfqxJcmBpCTxSZHPc0YxN25KY1MClzMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XPJmGYK0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pbdtCLf9; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 30D1213005FE;
	Wed,  5 Nov 2025 19:55:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 19:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390545;
	 x=1762397745; bh=6GxIRIn2Y+jgQEzm+nvqg4ydKhOE6rwcOntaL14shm0=; b=
	XPJmGYK0Q55AWbSjy4sPS1BQNuq9p9M0HTsm/6Yciv8joS+TD4uLENU6wDu+5z0N
	LjHu05jCju67OSnAF0M+GfkfDMzI3jiUpeRC5VxXHGC7YvoPaUc53+N+gojGNm2c
	Y+qhrDOZ1Ot1ZqmE9hIaKUinm5vD9JB4j7REo81l92u/v3YKS7IenDpVWoPIJZhm
	In+ftREaytuPokcxTn7oBHu09ZDCW5epNdkObjOgumztAQcMD/YXoZokXuxOjoQt
	XQ7cuOdAh4lPl/v7+UTrc03MKkqa8QNtBhibGk3qI+FO7WQzAeQi79AzX3tokhln
	NKpaoC+TAjsWc3x6dxQsZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390545; x=1762397745; bh=6
	GxIRIn2Y+jgQEzm+nvqg4ydKhOE6rwcOntaL14shm0=; b=pbdtCLf96oRrEPxz2
	08/9STwDJ5RmZlpiDaMOtchAvMif9s8Obm8Y04ypiuYq/yZSbnlzdAKGaGbR1R3w
	lwgkWvj3axpV0L/nAeW9bWCep8fGZ9pzN/sMemicM9YpcSa55hHxp+XkW31y24ZN
	CpCt3HcUPh8M37z0r6EK6iCx+WdvOkgvE+lLcZEzJG+alRmB870b48h6YbhMDmUb
	z7LvF/y91b0ODvLwZTn4ovTxyizM4K68fy8BGQrTsnSBiUJh1QAw2gRo+B9tr13U
	/YqwaJsWl96xNdLKxmZHnOs6S+SU5MuA0gN/G1fs9/d7jpHZBkaHpgEMAxQTQQFc
	jNNCA==
X-ME-Sender: <xms:EPILaVafYAc8UDvWm6XVSrQOryrarnbf5TzTioxmDwquCrzx-wHAUg>
    <xme:EPILaSJhuVXEbj0F3Z1KtpiToqYqSY8wjCT4g_uW6vXSTJDtJuUImYp4ZsCPpzPOl
    RRiVlUA5kmXFYjVl7UiIaV86CzhfYouisq2V6jQWBpkrS0naQ>
X-ME-Received: <xmr:EPILaeyIuYkLXL3fdJ3iXsZCFZoRc_TP0zz8ML8L6rjeBgVs0WaK4X0x2LgaIygsDPwPKsiNkTU_iW6D2-B2u-VLgbp2ySLAPvqjsdyAvTUC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:EPILaa3rI_LDj4p_yQ-M1hr_svznEUNvjEoaK0rlqpy7aSVkxz1Icg>
    <xmx:EPILaRjVYfyT7dmVCAWaIaN6NVVpsfbz-1wv12PDjRKNMj8-syPT_Q>
    <xmx:EPILaeNfdHms9poIKTk528xn2F6Z-zp4rNjJ5R60oq0icEw1dLGTWg>
    <xmx:EPILaZJxm2bP53gidS403QV4FYzFzPUaMdBoajvsQBCcsiwO48i7Sw>
    <xmx:EfILaXwmAeu8KBbP0dmPzcYz_jjArrs-e5oJqVQlwOllp2O_z0z77iWE>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:55:34 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v5 08/14] VFS: add start_creating_killable() and start_removing_killable()
Date: Thu,  6 Nov 2025 11:50:52 +1100
Message-ID: <20251106005333.956321-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
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
index 8cb7d5a462ef..d0c3bb0423bb 100644
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
index 729b42fb143b..e70d056b9543 100644
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
index d089e4e8fdd0..196c66156a8a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -93,6 +93,12 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
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


