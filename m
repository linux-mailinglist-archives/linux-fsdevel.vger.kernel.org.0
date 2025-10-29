Return-Path: <linux-fsdevel+bounces-66394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF4C1DC27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F59189CE6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5432862C;
	Wed, 29 Oct 2025 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XxOTU1us";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xcu3qQP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33F258CFF;
	Wed, 29 Oct 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781587; cv=none; b=QUUHXclLrnW30hujHRmlRQCjRZVZkI6SbDWjzG4YwoKfFEqEYei3yevO3dBTMPN3X4CS4+8fv0mPGqeHItkWqB5+owLVkYS/cB9fi2jHPu137qTDean5MAdXj9p6KcMzv0SfH589dLMSHSvgcJ9zoYfUUnWY7mIBp/xBtAISw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781587; c=relaxed/simple;
	bh=lvLaEpNbIdKSPD/pOI5N5yLYW/6x33Xdth/HeRzcyH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLDWU/t5A8S6Ry00sZ1emHGlKtFHXeYlkJA6meKsyaHik+rZMsqiyJDQF1vTflPqcgqU0atF/WO8xP3dhFF0Fp3/+OmmxmO/kk2JL+ay82HljHnLYfVFsL22hm3VOnNH8Yd1OBn4UHw6ezZAc/+cTVHFe0q9aYF3vAo1cqzR4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XxOTU1us; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xcu3qQP4; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 41B5F130007D;
	Wed, 29 Oct 2025 19:46:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 19:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781584;
	 x=1761788784; bh=I6StfOjqE3oh2lquyYNPVVvsVAS6+Gog4sTTx+bEtbc=; b=
	XxOTU1usXG8hD+3G2n8UCBk47hINJNnHsTZwiirgSwwNX2RBmu58wAwOo7afk5DX
	DWyqHdkGk9n6xBRPKmwaDSCKqJ1OJZF8pMip6eROIafDoyNIHlaN15Vlm+iU4LM/
	iBkKrhywBd5fp3esFRyqOxFtRfUVeIGCvYxSYdrf2f9lX+D+kwI6YD2UgjLnID1p
	zGb6D8c08jMfrczXoCQSWS/zJgwECLsTylk3p8Fw+ZyzcuMp6Chq6fvMWc/+ZKGi
	9JbhVSwkdyvWBHlUTeWqu2B/vgOH+dDIHxtLlRbc60cRtA2KUJDRJHvXvJcFQC1U
	Pf1UFaHRYUdxAs+8FEJTVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781584; x=1761788784; bh=I
	6StfOjqE3oh2lquyYNPVVvsVAS6+Gog4sTTx+bEtbc=; b=Xcu3qQP4jbnSKAOYE
	gljwLYbTBSl5vsAmEcNK07nyyMdLL8t/p07MlozHHgwhEll/WCimy3pP8QnroiI/
	+qNmjStgozAgJvcrab55cgo4dB+Qhm+WlUt1D0srOXEzEN1dT6vd4yw/VngPpkGc
	BNdflJH+3Gb7FgIhWcEjboeAKPdyzRln+St8Q7eWXsQfpcO7C5AuYrha26gO6y9L
	ciTgbYDeZHhkMHVvQKxP6yX2V0w+KC7/i8xCrHo2i5LVijv5hyjpfUFys6XxhLSN
	JbqzMeFiyROwMIVi2qN2qTVMdiiCD46kXuIgn0+AHcXQsGgT9NF4/JHqqKaHeOm/
	ocsFQ==
X-ME-Sender: <xms:T6cCaXWZfT1Y6q6MGzFUyvbcTYB5yc6qCHN1PxnGnqyb8NJa53SODw>
    <xme:T6cCaXkUqdUlTxkhlZW1X18icWYAmZNsC22KleUxqdlCTf_CHbq_t1iK2H3wSrVtz
    br8Ry_rGB7crcM5WcfcuMSzvkNKnlO8hylWHfj0IBoL8HciIA>
X-ME-Received: <xmr:T6cCaUBDq-Bfur4_wKz57WlgfQBK29T_PqrEO6daarmwRjReCu-rDHdD9YhZ8f2-HKMvhKDeKceP_upHa7Nc2be8eoGDEBUl4iNW-VUV1gQ6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhp
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
X-ME-Proxy: <xmx:T6cCaR5VRKNzGmS-StOWNPvJinroAdtuDxRAc36MCWVRBSMoEzKHLg>
    <xmx:T6cCaVU0oXPEOu4tauz-LMzZ0Xx1Q5b7STx2czwPXW3Q6aoLORGF5A>
    <xmx:T6cCaRTdMtMRJLDM42oXtOkn_YUSKuyv5vPCOGEF9QI7OYeSA7sM-Q>
    <xmx:T6cCaZYNaDaK0cIHYZX2xjK4u1gwHOSJ9HC3nX-IBYJSFchd5QLJZQ>
    <xmx:UKcCaSYIoxptUW6FxVu8Xt9NxBH9K4aLPhCNW5vefczxJP683vHZtlS9>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:46:13 -0400 (EDT)
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
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 08/14] VFS: add start_creating_killable() and start_removing_killable()
Date: Thu, 30 Oct 2025 10:31:08 +1100
Message-ID: <20251029234353.1321957-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251029234353.1321957-1-neilb@ownmail.net>
References: <20251029234353.1321957-1-neilb@ownmail.net>
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


