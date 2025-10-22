Return-Path: <linux-fsdevel+bounces-65039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD5BFA003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E8D19C9AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95752D949C;
	Wed, 22 Oct 2025 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mHQtlIT+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eexf+fvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E21E5B68
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108466; cv=none; b=QVmsB+m2B7uSEZJsWWy8sudlXN2a71dY9a72J3JmKl33BJSKU90S71ILYeIdApImjDbLz//C0N689ujJMc3mQaihnU3JsEx3PuUsturROUd/RtaOfF8iYKPT0jnVAsfJkzj1yMhpViOTxy47grJcKyzK1WQorhLFBkVtIiXbKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108466; c=relaxed/simple;
	bh=M3Aq+T2ThOF8yjWasTSo5EjmvdI40fBDnsjv8qUqkj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0pCdJ8stjV8qf3nKnAvstx3m7h3zL45sqInuN4ftclLhE1xiwCGxBXAzlc032QYmByixupatjJDenmuw+1qxl45jUsy17a6tNkwJFveHKvQ4avSYeIU2zUWCpEDVboCT2pmWCKtShJ0rjDZna4nZeXVSyz0+KqYgbximfPIiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mHQtlIT+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eexf+fvV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A16814001C7;
	Wed, 22 Oct 2025 00:47:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 22 Oct 2025 00:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108463;
	 x=1761194863; bh=n0bmhfTrPmHWo1XFASS1JrpC/bkaIxmw/2lGv/3M3xY=; b=
	mHQtlIT+BeSS3+bYsqWyvx1tEozFKyxLNjNISiqNK0dJixTp4SjqbBzLtbo66uUI
	hcAQSqWG5FbA8QZ5z0D9DXFSChxtlOLqNzvKMIXXn6nNfE9yZCjzKIsApyCuaYGi
	03L3CgscvEhKWsafODn7pMyQh380/ix46tdqUMRI4w669RB4sS9k8OhKZ3He6f6b
	7DmrJWG6TPXDW2pDvHyxqJfB+gRyxMY4itUbqPwYCoDyhU+omdRpDv09UxMYBeum
	pgvKKS5kc/AUnoZWDVLPPkMRJaBOEyD9DLCdkKyjJglG+XWotJU1Ok6OSGfCx+0I
	pyiuZ1yKgZRDPIj7lRng3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108463; x=1761194863; bh=n
	0bmhfTrPmHWo1XFASS1JrpC/bkaIxmw/2lGv/3M3xY=; b=eexf+fvVyz/Tixcrf
	JINWheT4Vp7mQWdIoD/XRcFSjL7/7VYfKdE/BtvAHmavuZWh7+DF5FqtWOqE6tcN
	3hldCSJCluRVV4nicbFR4fOxR0mbwi5r4XK71fga14m8r+znJi5JQZCXXHJDtlHA
	jhr3nJLcE1goSz6z5Js0XPIvxivMSC/yRItLPYA26D0D3or/QUe7wcp4k123XdtU
	18Ruj5PWz6b6qRJsyt7gsT7uPDYOIhirYEP3q4tfitPDM1lTuYG6pjdxN2a57kDw
	eg2rszTRbFMQQPae/JSmUuVkH1hNMNebX4weKRB8QSAhi/sxTya7ZaojQRRae4Kw
	itH2A==
X-ME-Sender: <xms:7mH4aLiDohC7K9szgDJkGVYobWPuw5KjdXH3IYL4GjwQUfxEdFLMYg>
    <xme:7mH4aC-EWaS_iD82n5-ZRVcpQCsXpEr3JTv_0lpJw09SbgLbqj068JXyhqzmVUiOF
    1fIdnal1E9e8XrRfR9y8Zsj7WFaCN1_v7v5TT5ZwUyAVCCSfg>
X-ME-Received: <xmr:7mH4aKH4OxInFJA8I_AP0SMsuuxem9teW7xiKyb17gJpTlpP0dCvtXL1wP52bEHhnvQJyirE5qcohYYEykyYbslGirZIVy-5dwRORwntPgek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7mH4aNmGI3YS4AbwUmufaJSWbYsLUojfkMBJ-bFc-2AeC8sRQlscsA>
    <xmx:7mH4aGY8l6HHJKq56Grknz9bnWsGfdZ2uZqqJ5ebUMOvb83IK_jF4w>
    <xmx:7mH4aKHJX17JDu9Ut7T12F0CVmBDNQFx6WUbXpoN-cqivo2My5-89Q>
    <xmx:7mH4aPJTEASG9wJXlNys5aTQCEeVqqf3v5hdjxa3tWCkCOrTqTaS1Q>
    <xmx:72H4aE30uO7RBU7NVSGrULbx5Qxgkyx2vu9bdJ2zxF1WQehGUIArgI3Y>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:47:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 07/14] VFS: introduce start_removing_dentry()
Date: Wed, 22 Oct 2025 15:41:41 +1100
Message-ID: <20251022044545.893630-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>
References: <20251022044545.893630-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

start_removing_dentry() is similar to start_removing() but instead of
providing a name for lookup, the target dentry is given.

start_removing_dentry() checks that the dentry is still hashed and in
the parent, and if so it locks and increases the refcount so that
end_removing() can be used to finish the operation.

This is used in cachefiles, overlayfs, smb/server, and apparmor.

There will be other users including ecryptfs.

As start_removing_dentry() takes an extra reference to the dentry (to be
put by end_removing()), there is no need to explicitly take an extra
reference to stop d_delete() from using dentry_unlink_inode() to negate
the dentry - as in cachefiles_delete_object(), and ksmbd_vfs_unlink().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/interface.c      | 14 +++++++++-----
 fs/cachefiles/namei.c          | 24 ++++++++++++++----------
 fs/cachefiles/volume.c         | 10 +++++++---
 fs/namei.c                     | 33 +++++++++++++++++++++++++++++++++
 fs/overlayfs/dir.c             | 10 ++++------
 fs/overlayfs/readdir.c         |  8 ++++----
 fs/smb/server/vfs.c            | 27 ++++-----------------------
 include/linux/namei.h          |  2 ++
 security/apparmor/apparmorfs.c |  8 ++++----
 9 files changed, 81 insertions(+), 55 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 3e63cfe15874..3f8a6f1a8fc3 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -9,6 +9,7 @@
 #include <linux/mount.h>
 #include <linux/xattr.h>
 #include <linux/file.h>
+#include <linux/namei.h>
 #include <linux/falloc.h>
 #include <trace/events/fscache.h>
 #include "internal.h"
@@ -428,11 +429,14 @@ static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
 		if (!old_tmpfile) {
 			struct cachefiles_volume *volume = object->volume;
 			struct dentry *fan = volume->fanout[(u8)cookie->key_hash];
-
-			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
-			cachefiles_bury_object(volume->cache, object, fan,
-					       old_file->f_path.dentry,
-					       FSCACHE_OBJECT_INVALIDATED);
+			struct dentry *obj;
+
+			obj = start_removing_dentry(fan, old_file->f_path.dentry);
+			if (!IS_ERR(obj))
+				cachefiles_bury_object(volume->cache, object,
+						       fan, obj,
+						       FSCACHE_OBJECT_INVALIDATED);
+			end_removing(obj);
 		}
 		fput(old_file);
 	}
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index c7f0c6ab9b88..b97a40917a32 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -425,13 +425,12 @@ int cachefiles_delete_object(struct cachefiles_object *object,
 
 	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
 
-	/* Stop the dentry being negated if it's only pinned by a file struct. */
-	dget(dentry);
-
-	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
-	ret = cachefiles_unlink(volume->cache, object, fan, dentry, why);
-	inode_unlock(d_backing_inode(fan));
-	dput(dentry);
+	dentry = start_removing_dentry(fan, dentry);
+	if (IS_ERR(dentry))
+		ret = PTR_ERR(dentry);
+	else
+		ret = cachefiles_unlink(volume->cache, object, fan, dentry, why);
+	end_removing(dentry);
 	return ret;
 }
 
@@ -644,9 +643,14 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 
 	if (!d_is_reg(dentry)) {
 		pr_err("%pd is not a file\n", dentry);
-		inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
-		ret = cachefiles_bury_object(volume->cache, object, fan, dentry,
-					     FSCACHE_OBJECT_IS_WEIRD);
+		struct dentry *de = start_removing_dentry(fan, dentry);
+		if (IS_ERR(de))
+			ret = PTR_ERR(de);
+		else
+			ret = cachefiles_bury_object(volume->cache, object,
+						     fan, de,
+						     FSCACHE_OBJECT_IS_WEIRD);
+		end_removing(de);
 		dput(dentry);
 		if (ret < 0)
 			return false;
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 781aac4ef274..ddf95ff5daf0 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -7,6 +7,7 @@
 
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include <trace/events/fscache.h>
 
@@ -58,9 +59,12 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 		if (ret < 0) {
 			if (ret != -ESTALE)
 				goto error_dir;
-			inode_lock_nested(d_inode(cache->store), I_MUTEX_PARENT);
-			cachefiles_bury_object(cache, NULL, cache->store, vdentry,
-					       FSCACHE_VOLUME_IS_WEIRD);
+			vdentry = start_removing_dentry(cache->store, vdentry);
+			if (!IS_ERR(vdentry))
+				cachefiles_bury_object(cache, NULL, cache->store,
+						       vdentry,
+						       FSCACHE_VOLUME_IS_WEIRD);
+			end_removing(vdentry);
 			cachefiles_put_directory(volume->dentry);
 			cond_resched();
 			goto retry;
diff --git a/fs/namei.c b/fs/namei.c
index 696e4b794416..bfc443bec8a9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3323,6 +3323,39 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing_noperm);
 
+/**
+ * start_removing_dentry - prepare to remove a given dentry
+ * @parent: directory from which dentry should be removed
+ * @child:  the dentry to be removed
+ *
+ * A lock is taken to protect the dentry again other dirops and
+ * the validity of the dentry is checked: correct parent and still hashed.
+ *
+ * If the dentry is valid and positive, a reference is taken and
+ * returned.  If not an error is returned.
+ *
+ * end_removing() should be called when removal is complete, or aborted.
+ *
+ * Returns: the valid dentry, or an error.
+ */
+struct dentry *start_removing_dentry(struct dentry *parent,
+				     struct dentry *child)
+{
+	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+	if (unlikely(IS_DEADDIR(parent->d_inode) ||
+		     child->d_parent != parent ||
+		     d_unhashed(child))) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EINVAL);
+	}
+	if (d_is_negative(child)) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-ENOENT);
+	}
+	return dget(child);
+}
+EXPORT_SYMBOL(start_removing_dentry);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b5247c9e1903..c8d0885ee5e0 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -47,14 +47,12 @@ static int ovl_cleanup_locked(struct ovl_fs *ofs, struct inode *wdir,
 int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
 		struct dentry *wdentry)
 {
-	int err;
-
-	err = ovl_parent_lock(workdir, wdentry);
-	if (err)
-		return err;
+	wdentry = start_removing_dentry(workdir, wdentry);
+	if (IS_ERR(wdentry))
+		return PTR_ERR(wdentry);
 
 	ovl_cleanup_locked(ofs, workdir->d_inode, wdentry);
-	ovl_parent_unlock(workdir);
+	end_removing(wdentry);
 
 	return 0;
 }
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 1e9792cc557b..77ecc39fc33a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1242,11 +1242,11 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 	if (!d_is_dir(dentry) || level > 1)
 		return ovl_cleanup(ofs, parent, dentry);
 
-	err = ovl_parent_lock(parent, dentry);
-	if (err)
-		return err;
+	dentry = start_removing_dentry(parent, dentry);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 	err = ovl_do_rmdir(ofs, parent->d_inode, dentry);
-	ovl_parent_unlock(parent);
+	end_removing(dentry);
 	if (err) {
 		struct path path = { .mnt = mnt, .dentry = dentry };
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 891ed2dc2b73..7c4ddc43ab39 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -49,24 +49,6 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 	i_uid_write(inode, i_uid_read(parent_inode));
 }
 
-/**
- * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
- * @parent: parent dentry
- * @child: child dentry
- *
- * Returns: %0 on success, %-ENOENT if the parent dentry is not stable
- */
-int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
-{
-	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	if (child->d_parent != parent) {
-		inode_unlock(d_inode(parent));
-		return -ENOENT;
-	}
-
-	return 0;
-}
-
 static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 				 char *pathname, unsigned int flags,
 				 struct path *path, bool do_lock)
@@ -1084,18 +1066,17 @@ int ksmbd_vfs_unlink(struct file *filp)
 		return err;
 
 	dir = dget_parent(dentry);
-	err = ksmbd_vfs_lock_parent(dir, dentry);
-	if (err)
+	dentry = start_removing_dentry(dir, dentry);
+	err = PTR_ERR(dentry);
+	if (IS_ERR(dentry))
 		goto out;
-	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
 		err = vfs_rmdir(idmap, d_inode(dir), dentry);
 	else
 		err = vfs_unlink(idmap, d_inode(dir), dentry, NULL);
 
-	dput(dentry);
-	inode_unlock(d_inode(dir));
+	end_removing(dentry);
 	if (err)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
 out:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 688e157d6afc..7e916e9d7726 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -94,6 +94,8 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_removing_dentry(struct dentry *parent,
+				     struct dentry *child);
 
 /**
  * end_creating - finish action started with start_creating
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 391a586d0557..9d08d103f142 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -355,17 +355,17 @@ static void aafs_remove(struct dentry *dentry)
 	if (!dentry || IS_ERR(dentry))
 		return;
 
+	/* ->d_parent is stable as rename is not supported */
 	dir = d_inode(dentry->d_parent);
-	inode_lock(dir);
-	if (simple_positive(dentry)) {
+	dentry = start_removing_dentry(dentry->d_parent, dentry);
+	if (!IS_ERR(dentry) && simple_positive(dentry)) {
 		if (d_is_dir(dentry))
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
 		d_delete(dentry);
-		dput(dentry);
 	}
-	inode_unlock(dir);
+	end_removing(dentry);
 	simple_release_fs(&aafs_mnt, &aafs_count);
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


