Return-Path: <linux-fsdevel+bounces-68132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203DC54FF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B16B834DA52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F462222B6;
	Thu, 13 Nov 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fiTp6dnT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iEjy79S6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406F19D8AC;
	Thu, 13 Nov 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994494; cv=none; b=kV2+V0b1VFm+9EX/pAfy9E8/CT/As4bYYpXvVxODsYKBUWcPuezu//LE6JofbSN8YtxOOi97C9DBtFabmA8WX2kRFRH5WWNiQmpr2u8wuakHrmW4+OmDcbNJ1tgOyApcoK6UFGdd88ru1T/SpRA2kh4KtfaGuYXtFfGwfM133Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994494; c=relaxed/simple;
	bh=d61hITnA+5mbX5xtGCakqQ/T5qUsEeGDqqb0/e3igWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lytyBx8fG/EpvxGnMJPqcbkPaR8eBYnoRAzUfereDq10VU3gXF5DknRI/R2OrjU+Kdye5Ty6/JK/O6uMjLycGl68BQOS2uBoD71ZAowJC4de0mQZG3ZCZXgiALiLjBz3rABRUAEucEEC1vg+k3H/axQy/KkjcWUIBleWnOkADAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fiTp6dnT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iEjy79S6; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id C7E041300C99;
	Wed, 12 Nov 2025 19:41:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 12 Nov 2025 19:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994490;
	 x=1763001690; bh=V9EFXVCJTSaEEUgch9FfiXY2S5v/XMDsT20GhSXheMo=; b=
	fiTp6dnTennWy+0qlowuu6fMu+qK20+Pnqmdrs7q3B2zz9rMTHe6wvLC9wCn5dU2
	sBj2/p2aTwEB5fCQMMcQjRWtR5/Mt3YOm5AcDXkwGHknLOGJiEqF1bvseJ7N8p2M
	PCC2s4Rg2OTCSP4nqK0RIEMTCN+WneFm7qHBOS+2F+vwd4pMqb8l91gRCGqy3Bht
	Ni0pFgyK9TcqnBsMdp1oaVcoAbRsX+6P5mmKtkjIhsWY5UW6tx1dl0JAYdQF+pQ/
	VBqYivVCSlpVPXdtL11id9/CHZfXax3fupjz5Gul/u8PMbsG/nXP0JNUKLQcICLr
	KH7SMfZa29qq0euFMdSQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994490; x=1763001690; bh=V
	9EFXVCJTSaEEUgch9FfiXY2S5v/XMDsT20GhSXheMo=; b=iEjy79S6mymE09HsI
	NF/rvOsCU9BTtcuFcobjTGVs1S4org8LJ8ULviZ7N+T79ZllbcTWq+J8Ff3uWnAX
	vlYk87eomm/iy/Rq5/Lq2072uJ6L8Q2ru+8qWFTPyXeiIdEVQ3qfpn979vgMKdS4
	O63CrkwmtYWTeZ8cBU4LZq/2UpCmOruPFqliVSwmXZ90RLXgtQyuRSz8j/aqgsBX
	pup3NrbYYS5zhiVUlkt+2hF3W9VFHY8u7Y+/H8i96lPR7v7poi4jT4wl2Hi6eLyk
	+jS2WkfFrS9XJ9Uud0bNOpt/Jhd2n6AYRzk5chzXhcPDMSHaRP4136x4dqjbkeO5
	QYqjA==
X-ME-Sender: <xms:OikVaeNiTScjZtPO29K0V8DeFrfrV_y-9eBp8QrDskEaqlkyosSTiw>
    <xme:OikVaSDbEDNW_KhkLjs6cVzD3No7tADxNMX8qA1zy9iBo-1745pdHXJZJkyHBxAe2
    hAbbubrfVVnF-H6FayMvCSuwcIMnI7piMVT5GrjBCQTpGEH>
X-ME-Received: <xmr:OikVaSRSso9gVnsnp-4O9_O2cThzi8q4MHlQbXglZnTbcSbEuHfugyqPt-me7JH_a2S6j7VZSpNXDqaU46khZw_I_tb0atmYGVswGGcvKFaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:OikVacbyF8ubYEOaJRfQWThVNg-S0zefkjrn-6O_GsbSWe1WvqdFiA>
    <xmx:OikVaX_ZaDtKwDiefPa04-JmXgn4SHIl2up7ljDO_rrf3t3qRQNJBQ>
    <xmx:OikVaYLD_XVl4xT2n8-ATAiyVxI9U_3n8dGrpLHDoo9AbM3o9i_Zqw>
    <xmx:OikVaQUfxA5Xj5lZSGaNB0KvOzuumAI0waTZNVocDw4TwSweQ69k9g>
    <xmx:OikVabPJ-8EqYT5HJnMYClwjY1gzdaoCyPwEXmENW0MGU8paIuDRCfAa>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:41:20 -0500 (EST)
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
Subject: [PATCH v6 08/15] VFS: introduce start_removing_dentry()
Date: Thu, 13 Nov 2025 11:18:31 +1100
Message-ID: <20251113002050.676694-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
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

cachefiles_bury_object() now gets an extra ref to the victim, which is
drops.  As it includes the needed end_removing() calls, the caller
doesn't need them.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org> (for ksmbd part)
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

---
Changes since v4
Callers of cachefiles_bury_object() were incorrectly calling
end_removing() after that call.  The dput() was needed, the unlock
wasn't.  The dput() has been effectively moved into
cachefiles_bury_object() by removing a dget() which is now not needed.
---
 fs/cachefiles/interface.c      | 11 +++++++----
 fs/cachefiles/namei.c          | 30 ++++++++++++++----------------
 fs/cachefiles/volume.c         |  9 ++++++---
 fs/namei.c                     | 33 +++++++++++++++++++++++++++++++++
 fs/overlayfs/dir.c             | 10 ++++------
 fs/overlayfs/readdir.c         |  8 ++++----
 fs/smb/server/vfs.c            | 27 ++++-----------------------
 include/linux/namei.h          |  2 ++
 security/apparmor/apparmorfs.c |  8 ++++----
 9 files changed, 78 insertions(+), 60 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 3e63cfe15874..a08250d244ea 100644
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
@@ -428,11 +429,13 @@ static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
 		if (!old_tmpfile) {
 			struct cachefiles_volume *volume = object->volume;
 			struct dentry *fan = volume->fanout[(u8)cookie->key_hash];
+			struct dentry *obj;
 
-			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
-			cachefiles_bury_object(volume->cache, object, fan,
-					       old_file->f_path.dentry,
-					       FSCACHE_OBJECT_INVALIDATED);
+			obj = start_removing_dentry(fan, old_file->f_path.dentry);
+			if (!IS_ERR(obj))
+				cachefiles_bury_object(volume->cache, object,
+						       fan, obj,
+						       FSCACHE_OBJECT_INVALIDATED);
 		}
 		fput(old_file);
 	}
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index c7f0c6ab9b88..0104ac00485d 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -261,6 +261,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
  * - Directory backed objects are stuffed into the graveyard for userspace to
  *   delete
  * On entry dir must be locked.  It will be unlocked on exit.
+ * On entry there must be at least 2 refs on rep, one will be dropped on exit.
  */
 int cachefiles_bury_object(struct cachefiles_cache *cache,
 			   struct cachefiles_object *object,
@@ -275,12 +276,6 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	_enter(",'%pd','%pd'", dir, rep);
 
-	/* end_removing() will dput() @rep but we need to keep
-	 * a ref, so take one now.  This also stops the dentry
-	 * being negated when unlinked which we need.
-	 */
-	dget(rep);
-
 	if (rep->d_parent != dir) {
 		end_removing(rep);
 		_leave(" = -ESTALE");
@@ -425,13 +420,12 @@ int cachefiles_delete_object(struct cachefiles_object *object,
 
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
 
@@ -644,9 +638,13 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 
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
 		dput(dentry);
 		if (ret < 0)
 			return false;
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 781aac4ef274..90ba926f488e 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -7,6 +7,7 @@
 
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include <trace/events/fscache.h>
 
@@ -58,9 +59,11 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
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
 			cachefiles_put_directory(volume->dentry);
 			cond_resched();
 			goto retry;
diff --git a/fs/namei.c b/fs/namei.c
index da01b828ede6..729b42fb143b 100644
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
index 20682afdbd20..6d1d0e94e287 100644
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
index ea0a06b0ae44..148c65d59e42 100644
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
 				 struct path *path, bool for_remove)
@@ -1082,18 +1064,17 @@ int ksmbd_vfs_unlink(struct file *filp)
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
index 0441f5921f87..d089e4e8fdd0 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -95,6 +95,8 @@ struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
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


