Return-Path: <linux-fsdevel+bounces-68128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEBC54F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B74FA3457FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404551F181F;
	Thu, 13 Nov 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JuqDND1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTcNCDPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDB1A2C11;
	Thu, 13 Nov 2025 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994440; cv=none; b=foczHpHij3c2G+EN++L6twvCujBi4dQLZyBXs0eAdZ9ZPCot3ExR7Wowv0pnEdghoM/3AAO78GcrcIxE1IAhql3hd6/UwZckoxg1ROuzC1adpyqV3/LlHnzj0gOCFi0CFHAsfI5XtuHXHgtaHke2aHtkRXGUYHbampCl7J78M6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994440; c=relaxed/simple;
	bh=KhJbkBCUFrSWlOdh98NJdHCE3KxdfdX5TiZHM9vj+4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs8rBI+h3EQ5ZAXq53CiHqtjIYls550H06KvLnlxmAcWGqaAjaBx8yeHmoaRjqzwqvQfmuBUmcbHw9t6aWalFwe/8VidC30eel2ZtrZU/Yw9WiruwbbXKTqGZ0cESkbCT8l822/I/QMmT7L1TqHt40HI6SMAFFCIDB3iuSyI9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JuqDND1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTcNCDPw; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 04DBF13000C2;
	Wed, 12 Nov 2025 19:40:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 19:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994434;
	 x=1763001634; bh=GdImJRXn7Aw+bUPHb+tkpSoneiX//mTZIZeyEmhb7yI=; b=
	JuqDND1qV5NGDgYIRgTCebMzIcQgxQWhP2KcQ12EJzBuvcp70p/PBbylgxpcSpDn
	zLgpUxKJ3hxCVHJF9yz0Z8/3oGng8WgZhcNr2v1Rbw/OWEcg04NbGRmeC1exmOri
	6bmYLVhND+lgSZUPtzKSG/GxgUbEw0hl02gYDg82uVYjSSXvlzgoJY8+El5DVZ5B
	Fx19TSY9drOn+fei+bew9V0Xrq+vqu9R4itgta/xQKhG1ZvMcKFJcWj/ku/WjBTg
	pyRsDaTdnVQLMRvbFRiKQoFhG2i22C2v9lOWeT8GK7YtPvRtKVwxRRaUPLdHgZDO
	WFLeKFibUzG0FuBC+rxPgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994434; x=1763001634; bh=G
	dImJRXn7Aw+bUPHb+tkpSoneiX//mTZIZeyEmhb7yI=; b=XTcNCDPwe1Mv65uxG
	v9LT0O7/HMcN6Hn/2pA1fuUzUwtFhziw/OZ1PCeeZL+LnXWaHpvjocz+E6NJR8SR
	j42YN21jRvXQV/VZLqcx4cyOoBj1z+WDNXwy8B1KOgE43A/xO1R7jSu0zODcYNeA
	Bc2xIic0znv5dHZ0O9FEzaEJsUeMUI6hjpUYjNAh+aU8A9IxH8zaLj08DjyJoBGW
	WwSy/2+PHqgL6rRE8CnOHGWE8rfvUBfGu0yBCgNh/ajV4R6oOtZCtNhAjS3sK5UN
	DXIxzjA5iGkUIQffLQmHKAswbF0lMhFNsBFLwDnNy6lZYSMn5bidqL55YLXZ56uh
	2nowA==
X-ME-Sender: <xms:AikVaf30-2mnmS1NSGPm6kTaz0tCmd_iARYYNxruViD3i9yAwOI2DA>
    <xme:AikVaTJsoKpyHJxoP8xjJIU-2ZtjEtujJagd5BbdI3DmAzPANzqxtZ2O7RuUROeBN
    R8zJxblqwPNEeLrsCsotRC5EHhpPigV6dKG8lq6eOWcL4XBgo8>
X-ME-Received: <xmr:AikVac5CwczQG5mGTCxSP0pvs60CzyU8KMZM2oXqV0o9qzrVZjcnPpC_PjmjdfYPOq7LItIJa0SClahffoiidJEqM2J_a8ZE9Js45oRQERdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:AikVaSgnZX8jrfq5o8TcffGEqE3XNqUixK6kJ1bThVr36cnaxLwZIg>
    <xmx:AikVaTkzsKMN4_nmcLMtpVSjxtA7Mfq0F6TJArycvpHE5fNmIX8I-A>
    <xmx:AikVabQTdPoPtiQqBlt85igtfs19EsfpjmvZJEVy-nrF_z3sCgOqZw>
    <xmx:AikVaU8wSQtQ6M2rDng41YDbYnhIDKgJtECy3Jvb3VJuOwJLepmXIA>
    <xmx:AikVafjkoS26UgBr0zoCpC0HeWDFBKwttENy6HhKYXrkxj5L392FsarH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:40:24 -0500 (EST)
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
Subject: [PATCH v6 04/15] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
Date: Thu, 13 Nov 2025 11:18:27 +1100
Message-ID: <20251113002050.676694-5-neilb@ownmail.net>
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

start_creating() is similar to simple_start_creating() but is not so
simple.
It takes a qstr for the name, includes permission checking, and does NOT
report an error if the name already exists, returning a positive dentry
instead.

This is currently used by nfsd, cachefiles, and overlayfs.

end_creating() is called after the dentry has been used.
end_creating() drops the reference to the dentry as it is generally no
longer needed.  This is exactly the first section of end_creating_path()
so that function is changed to call the new end_creating()

These calls help encapsulate locking rules so that directory locking can
be changed.

Occasionally this change means that the parent lock is held for a
shorter period of time, for example in cachefiles_commit_tmpfile().
As this function now unlocks after an unlink and before the following
lookup, it is possible that the lookup could again find a positive
dentry, so a while loop is introduced there.

In overlayfs the ovl_lookup_temp() function has ovl_tempname()
split out to be used in ovl_start_creating_temp().  The other use
of ovl_lookup_temp() is preparing for a rename.  When rename handling
is updated, ovl_lookup_temp() will be removed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v4
 Change "PTR_ERR(whiteout)" to "err" in ovl_whiteout() - thanks to
 Dan Carpenter.
---
 fs/cachefiles/namei.c    |  41 ++++++++--------
 fs/namei.c               |  35 +++++++++++---
 fs/nfsd/nfs3proc.c       |  14 ++----
 fs/nfsd/nfs4proc.c       |  14 ++----
 fs/nfsd/nfs4recover.c    |  16 +++----
 fs/nfsd/nfsproc.c        |  11 ++---
 fs/nfsd/vfs.c            |  52 ++++++++------------
 fs/overlayfs/copy_up.c   |  19 ++++----
 fs/overlayfs/dir.c       | 100 +++++++++++++++++++++++----------------
 fs/overlayfs/overlayfs.h |   8 ++++
 fs/overlayfs/super.c     |  32 +++++++------
 include/linux/namei.h    |  33 +++++++++++++
 12 files changed, 215 insertions(+), 160 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d1edb2ac3837..0a136eb434da 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -93,12 +93,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	_enter(",,%s", dirname);
 
 	/* search the current directory for the element name */
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
 retry:
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		subdir = lookup_one(&nop_mnt_idmap, &QSTR(dirname), dir);
+		subdir = start_creating(&nop_mnt_idmap, dir, &QSTR(dirname));
 	else
 		subdir = ERR_PTR(ret);
 	trace_cachefiles_lookup(NULL, dir, subdir);
@@ -141,7 +140,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		trace_cachefiles_mkdir(dir, subdir);
 
 		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
-			dput(subdir);
+			end_creating(subdir, dir);
 			goto retry;
 		}
 		ASSERT(d_backing_inode(subdir));
@@ -154,7 +153,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* Tell rmdir() it's not allowed to delete the subdir */
 	inode_lock(d_inode(subdir));
-	inode_unlock(d_inode(dir));
+	dget(subdir);
+	end_creating(subdir, dir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
@@ -196,14 +196,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(-EBUSY);
 
 mkdir_error:
-	inode_unlock(d_inode(dir));
-	if (!IS_ERR(subdir))
-		dput(subdir);
+	end_creating(subdir, dir);
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
 lookup_error:
-	inode_unlock(d_inode(dir));
 	ret = PTR_ERR(subdir);
 	pr_err("Lookup %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
@@ -679,36 +676,41 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 
 	_enter(",%pD", object->file);
 
-	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		dentry = lookup_one(&nop_mnt_idmap, &QSTR(object->d_name), fan);
+		dentry = start_creating(&nop_mnt_idmap, fan, &QSTR(object->d_name));
 	else
 		dentry = ERR_PTR(ret);
 	if (IS_ERR(dentry)) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 					   cachefiles_trace_lookup_error);
 		_debug("lookup fail %ld", PTR_ERR(dentry));
-		goto out_unlock;
+		goto out;
 	}
 
-	if (!d_is_negative(dentry)) {
+	/*
+	 * This loop will only execute more than once if some other thread
+	 * races to create the object we are trying to create.
+	 */
+	while (!d_is_negative(dentry)) {
 		ret = cachefiles_unlink(volume->cache, object, fan, dentry,
 					FSCACHE_OBJECT_IS_STALE);
 		if (ret < 0)
-			goto out_dput;
+			goto out_end;
+
+		end_creating(dentry, fan);
 
-		dput(dentry);
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
-			dentry = lookup_one(&nop_mnt_idmap, &QSTR(object->d_name), fan);
+			dentry = start_creating(&nop_mnt_idmap, fan,
+						&QSTR(object->d_name));
 		else
 			dentry = ERR_PTR(ret);
 		if (IS_ERR(dentry)) {
 			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 						   cachefiles_trace_lookup_error);
 			_debug("lookup fail %ld", PTR_ERR(dentry));
-			goto out_unlock;
+			goto out;
 		}
 	}
 
@@ -729,10 +731,9 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		success = true;
 	}
 
-out_dput:
-	dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(fan));
+out_end:
+	end_creating(dentry, fan);
+out:
 	_leave(" = %u", success);
 	return success;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 93c5fce2d814..8873ad0f05b0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3221,6 +3221,33 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
+/**
+ * start_creating - prepare to create a given name with permission checking
+ * @idmap:  idmap of the mount
+ * @parent: directory in which to prepare to create the name
+ * @name:   the name to be created
+ *
+ * Locks are taken and a lookup is performed prior to creating
+ * an object in a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name already exists, a positive dentry is returned, so
+ * behaviour is similar to O_CREAT without O_EXCL, which doesn't fail
+ * with -EEXIST.
+ *
+ * Returns: a negative or positive dentry, or an error.
+ */
+struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, LOOKUP_CREATE);
+}
+EXPORT_SYMBOL(start_creating);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
@@ -4306,13 +4333,7 @@ EXPORT_SYMBOL(start_creating_path);
  */
 void end_creating_path(const struct path *path, struct dentry *dentry)
 {
-	if (IS_ERR(dentry))
-		/* The parent is still locked despite the error from
-		 * vfs_mkdir() - must unlock it.
-		 */
-		inode_unlock(path->dentry->d_inode);
-	else
-		end_dirop(dentry);
+	end_creating(dentry, path->dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7..e2aac0def2cb 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -281,14 +281,11 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	inode_lock_nested(inode, I_MUTEX_PARENT);
-
-	child = lookup_one(&nop_mnt_idmap,
-			   &QSTR_LEN(argp->name, argp->len),
-			   parent);
+	child = start_creating(&nop_mnt_idmap, parent,
+			       &QSTR_LEN(argp->name, argp->len));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out;
+		goto out_write;
 	}
 
 	if (d_really_is_negative(child)) {
@@ -367,9 +364,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	inode_unlock(inode);
-	if (child && !IS_ERR(child))
-		dput(child);
+	end_creating(child, parent);
+out_write:
 	fh_drop_write(fhp);
 	return status;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e466cf52d7d7..b2c95e8e7c68 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -264,14 +264,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (is_create_with_attrs(open))
 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
 
-	inode_lock_nested(inode, I_MUTEX_PARENT);
-
-	child = lookup_one(&nop_mnt_idmap,
-			   &QSTR_LEN(open->op_fname, open->op_fnamelen),
-			   parent);
+	child = start_creating(&nop_mnt_idmap, parent,
+			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out;
+		goto out_write;
 	}
 
 	if (d_really_is_negative(child)) {
@@ -379,10 +376,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	inode_unlock(inode);
+	end_creating(child, parent);
 	nfsd_attrs_free(&attrs);
-	if (child && !IS_ERR(child))
-		dput(child);
+out_write:
 	fh_drop_write(fhp);
 	return status;
 }
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index e2b9472e5c78..c247a7c3291c 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -195,13 +195,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		goto out_creds;
 
 	dir = nn->rec_file->f_path.dentry;
-	/* lock the parent */
-	inode_lock(d_inode(dir));
 
-	dentry = lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
+	dentry = start_creating(&nop_mnt_idmap, dir, &QSTR(dname));
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
-		goto out_unlock;
+		goto out;
 	}
 	if (d_really_is_positive(dentry))
 		/*
@@ -212,15 +210,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * In the 4.0 case, we should never get here; but we may
 		 * as well be forgiving and just succeed silently.
 		 */
-		goto out_put;
+		goto out_end;
 	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
-out_put:
-	if (!status)
-		dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(dir));
+out_end:
+	end_creating(dentry, dir);
+out:
 	if (status == 0) {
 		if (nn->in_grace)
 			__nfsd4_create_reclaim_record_grace(clp, dname,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8f71f5748c75..ee1b16e921fd 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -306,18 +306,16 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto done;
 	}
 
-	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one(&nop_mnt_idmap, &QSTR_LEN(argp->name, argp->len),
-			    dirfhp->fh_dentry);
+	dchild = start_creating(&nop_mnt_idmap, dirfhp->fh_dentry,
+				&QSTR_LEN(argp->name, argp->len));
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
-		goto out_unlock;
+		goto out_write;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
-	dput(dchild);
 	if (resp->status) {
 		if (resp->status != nfserr_noent)
 			goto out_unlock;
@@ -423,7 +421,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	inode_unlock(dirfhp->fh_dentry->d_inode);
+	end_creating(dchild, dirfhp->fh_dentry);
+out_write:
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cf4062ac092a..24e501abad0e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1521,7 +1521,7 @@ nfsd_check_ignore_resizing(struct iattr *iap)
 		iap->ia_valid &= ~ATTR_SIZE;
 }
 
-/* The parent directory should already be locked: */
+/* The parent directory should already be locked - we will unlock */
 __be32
 nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   struct nfsd_attrs *attrs,
@@ -1587,8 +1587,9 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 
 out:
-	if (!IS_ERR(dchild))
-		dput(dchild);
+	if (!err)
+		fh_fill_post_attrs(fhp);
+	end_creating(dchild, dentry);
 	return err;
 
 out_nfserr:
@@ -1626,28 +1627,26 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	dchild = start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
 	host_err = PTR_ERR(dchild);
-	if (IS_ERR(dchild)) {
-		err = nfserrno(host_err);
-		goto out_unlock;
-	}
+	if (IS_ERR(dchild))
+		return nfserrno(host_err);
+
 	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
 	/*
 	 * We unconditionally drop our ref to dchild as fh_compose will have
 	 * already grabbed its own ref for it.
 	 */
-	dput(dchild);
 	if (err)
 		goto out_unlock;
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
 	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
-	fh_fill_post_attrs(fhp);
+	return err;
+
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	end_creating(dchild, dentry);
 	return err;
 }
 
@@ -1733,11 +1732,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	dentry = fhp->fh_dentry;
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dnew = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	dnew = start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
-		inode_unlock(dentry->d_inode);
 		goto out_drop_write;
 	}
 	err = fh_fill_pre_attrs(fhp);
@@ -1750,11 +1747,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	end_creating(dnew, dentry);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-	dput(dnew);
-	if (err==0) err = cerr;
+	if (!err)
+		err = cerr;
 out_drop_write:
 	fh_drop_write(fhp);
 out:
@@ -1809,32 +1806,31 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
+	dnew = start_creating(&nop_mnt_idmap, ddir, &QSTR_LEN(name, len));
 
-	dnew = lookup_one(&nop_mnt_idmap, &QSTR_LEN(name, len), ddir);
 	if (IS_ERR(dnew)) {
 		host_err = PTR_ERR(dnew);
-		goto out_unlock;
+		goto out_drop_write;
 	}
 
 	dold = tfhp->fh_dentry;
 
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
-		goto out_dput;
+		goto out_unlock;
 	err = fh_fill_pre_attrs(ffhp);
 	if (err != nfs_ok)
-		goto out_dput;
+		goto out_unlock;
 	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
-	inode_unlock(dirp);
+out_unlock:
+	end_creating(dnew, ddir);
 	if (!host_err) {
 		host_err = commit_metadata(ffhp);
 		if (!host_err)
 			host_err = commit_metadata(tfhp);
 	}
 
-	dput(dnew);
 out_drop_write:
 	fh_drop_write(tfhp);
 	if (host_err == -EBUSY) {
@@ -1849,12 +1845,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-
-out_dput:
-	dput(dnew);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 static void
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 604a82acd164..e2bdac4317e7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -613,9 +613,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto out;
 
-	inode_lock_nested(udir, I_MUTEX_PARENT);
-	upper = ovl_lookup_upper(ofs, c->dentry->d_name.name, upperdir,
-				 c->dentry->d_name.len);
+	upper = ovl_start_creating_upper(ofs, upperdir,
+					 &QSTR_LEN(c->dentry->d_name.name,
+						   c->dentry->d_name.len));
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, ovl_dentry_upper(c->dentry), udir, upper);
@@ -626,9 +626,8 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			ovl_dentry_set_upper_alias(c->dentry);
 			ovl_dentry_update_reval(c->dentry, upper);
 		}
-		dput(upper);
+		end_creating(upper, upperdir);
 	}
-	inode_unlock(udir);
 	if (err)
 		goto out;
 
@@ -894,16 +893,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto out;
 
-	inode_lock_nested(udir, I_MUTEX_PARENT);
-
-	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
-				 c->destname.len);
+	upper = ovl_start_creating_upper(ofs, c->destdir,
+					 &QSTR_LEN(c->destname.name,
+						   c->destname.len));
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
-		dput(upper);
+		end_creating(upper, c->destdir);
 	}
-	inode_unlock(udir);
 
 	if (err)
 		goto out;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 83b955a1d55c..b9160fefbd00 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -59,15 +59,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
 	return 0;
 }
 
-struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
+#define OVL_TEMPNAME_SIZE 20
+static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 {
-	struct dentry *temp;
-	char name[20];
 	static atomic_t temp_id = ATOMIC_INIT(0);
 
 	/* counter is allowed to wrap, since temp dentries are ephemeral */
-	snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
+	snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_id));
+}
+
+struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
+{
+	struct dentry *temp;
+	char name[OVL_TEMPNAME_SIZE];
 
+	ovl_tempname(name);
 	temp = ovl_lookup_upper(ofs, name, workdir, strlen(name));
 	if (!IS_ERR(temp) && temp->d_inode) {
 		pr_err("workdir/%s already exists\n", name);
@@ -78,48 +84,52 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 	return temp;
 }
 
+static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
+					      struct dentry *workdir)
+{
+	char name[OVL_TEMPNAME_SIZE];
+
+	ovl_tempname(name);
+	return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
+			      &QSTR(name));
+}
+
 static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 {
 	int err;
-	struct dentry *whiteout;
+	struct dentry *whiteout, *link;
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
 
 	guard(mutex)(&ofs->whiteout_lock);
 
 	if (!ofs->whiteout) {
-		inode_lock_nested(wdir, I_MUTEX_PARENT);
-		whiteout = ovl_lookup_temp(ofs, workdir);
-		if (!IS_ERR(whiteout)) {
-			err = ovl_do_whiteout(ofs, wdir, whiteout);
-			if (err) {
-				dput(whiteout);
-				whiteout = ERR_PTR(err);
-			}
-		}
-		inode_unlock(wdir);
+		whiteout = ovl_start_creating_temp(ofs, workdir);
 		if (IS_ERR(whiteout))
 			return whiteout;
-		ofs->whiteout = whiteout;
+		err = ovl_do_whiteout(ofs, wdir, whiteout);
+		if (!err)
+			ofs->whiteout = dget(whiteout);
+		end_creating(whiteout, workdir);
+		if (err)
+			return ERR_PTR(err);
 	}
 
 	if (!ofs->no_shared_whiteout) {
-		inode_lock_nested(wdir, I_MUTEX_PARENT);
-		whiteout = ovl_lookup_temp(ofs, workdir);
-		if (!IS_ERR(whiteout)) {
-			err = ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
-			if (err) {
-				dput(whiteout);
-				whiteout = ERR_PTR(err);
-			}
-		}
-		inode_unlock(wdir);
-		if (!IS_ERR(whiteout))
-			return whiteout;
-		if (PTR_ERR(whiteout) != -EMLINK) {
-			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%lu)\n",
+		link = ovl_start_creating_temp(ofs, workdir);
+		if (IS_ERR(link))
+			return link;
+		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
+		if (!err)
+			whiteout = dget(link);
+		end_creating(link, workdir);
+		if (!err)
+			return whiteout;;
+
+		if (err != -EMLINK) {
+			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%u)\n",
 				ofs->whiteout->d_inode->i_nlink,
-				PTR_ERR(whiteout));
+				err);
 			ofs->no_shared_whiteout = true;
 		}
 	}
@@ -252,10 +262,13 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
 	struct dentry *ret;
-	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
-	ret = ovl_create_real(ofs, workdir,
-			      ovl_lookup_temp(ofs, workdir), attr);
-	inode_unlock(workdir->d_inode);
+	ret = ovl_start_creating_temp(ofs, workdir);
+	if (IS_ERR(ret))
+		return ret;
+	ret = ovl_create_real(ofs, workdir, ret, attr);
+	if (!IS_ERR(ret))
+		dget(ret);
+	end_creating(ret, workdir);
 	return ret;
 }
 
@@ -354,18 +367,21 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
-	struct inode *udir = upperdir->d_inode;
 	struct dentry *newdentry;
 	int err;
 
-	inode_lock_nested(udir, I_MUTEX_PARENT);
-	newdentry = ovl_create_real(ofs, upperdir,
-				    ovl_lookup_upper(ofs, dentry->d_name.name,
-						     upperdir, dentry->d_name.len),
-				    attr);
-	inode_unlock(udir);
+	newdentry = ovl_start_creating_upper(ofs, upperdir,
+					     &QSTR_LEN(dentry->d_name.name,
+						       dentry->d_name.len));
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
+	newdentry = ovl_create_real(ofs, upperdir, newdentry, attr);
+	if (IS_ERR(newdentry)) {
+		end_creating(newdentry, upperdir);
+		return PTR_ERR(newdentry);
+	}
+	dget(newdentry);
+	end_creating(newdentry, upperdir);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c8fd5951fc5e..beeba96cfcb2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -415,6 +415,14 @@ static inline struct dentry *ovl_lookup_upper_unlocked(struct ovl_fs *ofs,
 				   &QSTR_LEN(name, len), base);
 }
 
+static inline struct dentry *ovl_start_creating_upper(struct ovl_fs *ofs,
+						      struct dentry *parent,
+						      struct qstr *name)
+{
+	return start_creating(ovl_upper_mnt_idmap(ofs),
+			      parent, name);
+}
+
 static inline bool ovl_open_flags_need_copy_up(int flags)
 {
 	if (!flags)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 43ee4c7296a7..6e0816c1147a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -310,8 +310,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	bool retried = false;
 
 retry:
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
+	work = ovl_start_creating_upper(ofs, ofs->workbasedir, &QSTR(name));
 
 	if (!IS_ERR(work)) {
 		struct iattr attr = {
@@ -320,14 +319,13 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		};
 
 		if (work->d_inode) {
+			dget(work);
+			end_creating(work, ofs->workbasedir);
+			if (persist)
+				return work;
 			err = -EEXIST;
-			inode_unlock(dir);
 			if (retried)
 				goto out_dput;
-
-			if (persist)
-				return work;
-
 			retried = true;
 			err = ovl_workdir_cleanup(ofs, ofs->workbasedir, mnt, work, 0);
 			dput(work);
@@ -338,7 +336,9 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
-		inode_unlock(dir);
+		if (!IS_ERR(work))
+			dget(work);
+		end_creating(work, ofs->workbasedir);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -376,7 +376,6 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		if (err)
 			goto out_dput;
 	} else {
-		inode_unlock(dir);
 		err = PTR_ERR(work);
 		goto out_err;
 	}
@@ -626,14 +625,17 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
 					   const char *name, umode_t mode)
 {
-	size_t len = strlen(name);
 	struct dentry *child;
 
-	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-	child = ovl_lookup_upper(ofs, name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(ofs, parent, child, OVL_CATTR(mode));
-	inode_unlock(parent->d_inode);
+	child = ovl_start_creating_upper(ofs, parent, &QSTR(name));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode)
+			child = ovl_create_real(ofs, parent, child,
+						OVL_CATTR(mode));
+		if (!IS_ERR(child))
+			dget(child);
+		end_creating(child, parent);
+	}
 	dput(parent);
 
 	return child;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b0679c7420a8..37b72f4a64f0 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -89,6 +89,39 @@ struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
 
+struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
+
+/**
+ * end_creating - finish action started with start_creating
+ * @child:  dentry returned by start_creating() or vfs_mkdir()
+ * @parent: dentry given to start_creating(),
+ *
+ * Unlock and release the child.
+ *
+ * Unlike end_dirop() this can only be called if start_creating() succeeded.
+ * It handles @child being and error as vfs_mkdir() might have converted the
+ * dentry to an error - in that case the parent still needs to be unlocked.
+ *
+ * If vfs_mkdir() was called then the value returned from that function
+ * should be given for @child rather than the original dentry, as vfs_mkdir()
+ * may have provided a new dentry.  Even if vfs_mkdir() returns an error
+ * it must be given to end_creating().
+ *
+ * If vfs_mkdir() was not called, then @child will be a valid dentry and
+ * @parent will be ignored.
+ */
+static inline void end_creating(struct dentry *child, struct dentry *parent)
+{
+	if (IS_ERR(child))
+		/* The parent is still locked despite the error from
+		 * vfs_mkdir() - must unlock it.
+		 */
+		inode_unlock(parent->d_inode);
+	else
+		end_dirop(child);
+}
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.50.0.107.gf914562f5916.dirty


