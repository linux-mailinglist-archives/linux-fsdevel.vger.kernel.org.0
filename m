Return-Path: <linux-fsdevel+bounces-66393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CBC1DC0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59086189D264
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB75328603;
	Wed, 29 Oct 2025 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="L1O1Ij7Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZqQGLed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5FD258CFF;
	Wed, 29 Oct 2025 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781574; cv=none; b=e6eU9WjNAtOtjfN0/MvOrWzFJnJxDc1sdDFEYwZ+egrat+GDWBdw4n2oOu3wOSq//MWDjr14tMShxVIzxMchZWvgVIpu6qtya6fuTGZ/7TFU5EkQG72F+ttMIDuzy1z7rpPZln1NN5vpgHkRNUED8+kUEUN66/mKVJXYaQjg5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781574; c=relaxed/simple;
	bh=M3Aq+T2ThOF8yjWasTSo5EjmvdI40fBDnsjv8qUqkj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkvKMnq0Ol+yDpdhCSNM+fGa9q3AFjOACyFGheokO6y1bbYMJhZkApTiHrehgePwEswcy1iJ8Q4tgu9Gp/vxAYCGjM7kEUil74V65GPcjJhRcej6q9fIa6H7wX/cbZq4fCzIlKdLsFoc3usZ5qOhbv82whZ2DrUKRapT7ej9zcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=L1O1Ij7Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZqQGLed; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 5F34E130007D;
	Wed, 29 Oct 2025 19:46:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 29 Oct 2025 19:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761781570;
	 x=1761788770; bh=n0bmhfTrPmHWo1XFASS1JrpC/bkaIxmw/2lGv/3M3xY=; b=
	L1O1Ij7Y7dmX2VvPi9AiKWJVLxb4L7SuY5AW2JsF+yvJKnweth2eAzIwgwRod/fN
	IsyMBrhBOe/hMS8mAH0t6i07Zeky30pCLL/GcOivzRmObME+3Kk+wS/tMyLd1eGB
	es1E7uzcYBu8aqILKFm2Mq7SFxmV4h2CaJ+d+C/2niS2/9ZA5jqGXuHFsxQhNfkD
	4nLrcnIl2TLp7ErF3fdAWs3BNyJW09Bg/c8JAselyo5wavodeQwLpc3XD0f/yDIm
	U9J9/RaraXwoAY1DXw1h+efJX++WQI7WoFfeCDpJzTyHkBltL9MQomJrG8WiUuOT
	QRglUPOcGExRcLgmUO5EVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761781570; x=1761788770; bh=n
	0bmhfTrPmHWo1XFASS1JrpC/bkaIxmw/2lGv/3M3xY=; b=TZqQGLedAq17aUnWI
	vpqBgQLvP8y11Dp3Ea6Xdes70s31Wzld0p3dGuCZtujDvlYv4B5EaeKOWfLi3tTq
	3JcrI194iPTHJDbTsg3/qLJJMQSX3KmPqlnvWbCI+O2ZBfjOoEtYyaXv9q51thhy
	8o4KXLkr5KY3RPnN6vjatkgS50CCpMsFHcYK/JLeuXyhgnFxwyGb2Q1SGNFkR5a6
	lpNgq95HXx/CRopYwQlw3lAV/2i00eSNo+thTlPbm+G4P7iBfggH3U90COz6W9u9
	5drQNkdx/mWd4eWcDqtyx6c0ymNZifPrYRcSYwcOQlQZH4Dym+gjZRqXr/kJhCfZ
	P0EZQ==
X-ME-Sender: <xms:QqcCaSn5TQHk33AML_fWZGvgC3E-IDuA6GNTjbnxFsW-fgrr7aDRzQ>
    <xme:QqcCactOZcpj0IAUiEYkCeLJttYVVN6ajUYqDcenqgLzSid7ZSePZorQhX6qhA5Ah
    DBbc1V9Zwsxtchra3tp_z4rjp_7luacXA-QBUo2RP8BSaawqA>
X-ME-Received: <xmr:QqcCaReOhMA84CINv9qWqnwI5FUiLZEKz-W23Gj_4IJexPhbLiChRUsekp8UaL63OAGQNLTXh8I-5YbLze-rYwXzVbpG7XC1eDlAu9Fi0yrx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QqcCaYb_CTFDEqOjYxF-gnTPUCmOr_W9QZeGCaI0T5hIpPfQlyyNcQ>
    <xmx:QqcCaexiST1ZroOiD4CqwUHn4HYjjUvF6ZIMcfw4fnmIhQw19RdWRQ>
    <xmx:QqcCaQspF_DOWkoLCsEIJqMdnW8CsvqmrBT4iTXdBcQESzBxZEDyRw>
    <xmx:QqcCaZKSDzdcHNkoKUKUJEEvkr3mBxWzPCuYBopgHlfeqaWHzcLdUQ>
    <xmx:QqcCaWbQVLjIXd8d1er_RxbT8C0c_F0tfe9tviWfxcYGjed7wFVEjUES>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:45:59 -0400 (EDT)
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
Subject: [PATCH v4 07/14] VFS: introduce start_removing_dentry()
Date: Thu, 30 Oct 2025 10:31:07 +1100
Message-ID: <20251029234353.1321957-8-neilb@ownmail.net>
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


