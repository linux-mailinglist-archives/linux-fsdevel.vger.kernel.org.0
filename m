Return-Path: <linux-fsdevel+bounces-64183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB4BDC071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4703D3BFA58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850B2FC02A;
	Wed, 15 Oct 2025 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YLj23xTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pqu+yA/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985D2FB0B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492926; cv=none; b=brRAACSXdC+7kMHzPCF9ta5zfmpYBGOLamgj3YeqaQ9bcLycSdnS20d+3nRIzfQ5zwzgo9t4wxogyAwFG0vcrhQGwHpV5hRYZ84DUjc3i0QX0TfAaauHPbiaRKG74I0Ds3YC1vkdU1J7BmNX3Thv1kbBgtFpJ5+/UptEaM5gIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492926; c=relaxed/simple;
	bh=M3Aq+T2ThOF8yjWasTSo5EjmvdI40fBDnsjv8qUqkj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgucpt9A5Z0DaL6V9I520EjlMlmdMI1xJoZexvSMMh2sLH1hKSV/cBewruNR0Z2FKVHhdCKRqedUsJHuYCCOvIqCZGgv4c1TpvXjFI7taMnbKC78s6KTgMCi/mwh23vu2HCKomarii5btciiX1DNgbYaCU+BHV1jgRtedhvcGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YLj23xTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pqu+yA/F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2015B14000A2;
	Tue, 14 Oct 2025 21:48:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 14 Oct 2025 21:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492924;
	 x=1760579324; bh=n0bmhfTrPmHWo1XFASS1JrpC/bkaIxmw/2lGv/3M3xY=; b=
	YLj23xTH2o9gi3dwW7tss6sZqjOXX5grPmTRbAxLrfqIC4sBT7aic/iw+U+6HWX9
	glCdOkGQNDE+t+9Ez2iEhnegL6pxwhllgtZLXqg70gwmNTEz0r9OCGE2bDJkLBqy
	vDbKratJytI0bv1NC683Tn9Lf/EYbZZhGhSRz1/jFmyA8OLKNWIQkAnq3I/4/JuN
	IkHCL8o5BC0iQPFFHar7zzJ/09bZ6RTS5GCmZlYy7JuRnVVZBRT1nvd9yBifXF5x
	Bi+Kc2857tWGR5E7cRquI4cDzy+ZOzP2FJ1y7PXMb3GmW2OtB8K3M4hFJi9+vm00
	D8FdzhHiGJiOAUidkr7ZDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492924; x=1760579324; bh=n
	0bmhfTrPmHWo1XFASS1JrpC/bkaIxmw/2lGv/3M3xY=; b=Pqu+yA/Fu8EQCnCkf
	ukXnoKcRWk4Hlo/qqVkEEM20wMsWbbwo/Z6zbAe8AxS0krKbKC45ElgJ6kcA4tI6
	m4hYeYayKROaCTujL6PzZ11EyrYAuShRPXKSRStGuGFTiay6GNGvx9HZjC40dKui
	Vagxe8+1ozNlO3itTB6juscbzQEtJWSDc4fe81al112KGM6DbLPzU3K536vfuYBM
	YCIpI33KrK6n47n5u9WZBuo9OUzPCok4daEfSx9w5g5GPoXwtvWdIRFTIaWHXIge
	uCizN0a8UxB3Fnduzm6hqHJ0PZ7xIODuwZO8SMZeRzEAMMi0wCGYqZdu5vPe/D0W
	qhnmA==
X-ME-Sender: <xms:e_3uaMeqKM1r1R2LxMUWajUFwWuCTSK0U8HUQsfMJlOd7NDlHKozBA>
    <xme:e_3uaJKfY3RphyyN-ixcpmquXDM-CRza2-QSqhlhMG76jD9z-vuoklSLZV1WvltMe
    jyUiQJ_9diijifM5umTh8DAxtX99HQKln2b1DbqCWXu7tzk>
X-ME-Received: <xmr:e_3uaMiTaNSY5f7EosspiYQHNknFskQQ3KVR8i4NZzQl9ULX95g4CAapNhbqhGcX7kMgnsCNv11kaRo-83kRj_Hog-kVl7e0Lqat4pSCFCfJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:e_3uaHSgehA8aoZn7ri0Cxooee3XML3kwORKHJfDDYxGzaYmlCmscg>
    <xmx:e_3uaGVlkp4ba6E4kvRzngfeOm2Xl-1RCybvUFUm0TA4NuiUls39PQ>
    <xmx:e_3uaDRYOan1VMmgUtsZl2-f6s1WItQc2RYRRk2NcaTpVXCLboZrdw>
    <xmx:e_3uaIkaTkLfELjzUNvdi39x0Vys75ip5asbC-OauR388vRZuofoxQ>
    <xmx:fP3uaLWBuGAvWf7oFsolr7UXDQjfzibiuZej3X82kPGCYAtArPHhgXEX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/14] VFS: introduce start_removing_dentry()
Date: Wed, 15 Oct 2025 12:46:59 +1100
Message-ID: <20251015014756.2073439-8-neilb@ownmail.net>
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


