Return-Path: <linux-fsdevel+bounces-62841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C126BA23ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BF5385CAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D820459A;
	Fri, 26 Sep 2025 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hjT3d8h8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXuu3Wz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFE1EB9E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855047; cv=none; b=IN1PWJzqMfMv7YuJuCNz4OH0QqWyobwqvVic6N0ZLk8uNeIKXiUIimt+b9sEFrmpnpamO9Ac/LscnsPb0w516wPirjWSlZX17QC20WhVgHhDDvQgtrA8gCyyngDoNdjIkZ9o8aRs3RtG3gBeI67Y4HEIbqgTRL4Qz/dgA9Kura8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855047; c=relaxed/simple;
	bh=gvkUchqY24enn6/BkfxQHNwrZFdIMNf1VdIamaVi7gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrXrGIP7FRs6vJemCplcslVz20vlVcmZWZtLUnRX5ig3Ld1sLJ2GjA2KiqKANA3TY44GObFjY93UKuz1EHSPzaPw4vhHvADK83JUWj+77dGl2bJyP7u48ouwYbuDaPYxlAleliFvKcML4xt8+eFAjfOKvq3DDTBpyOCTQqUvq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hjT3d8h8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXuu3Wz+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E52E14000C1;
	Thu, 25 Sep 2025 22:50:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 22:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855044;
	 x=1758941444; bh=Bp3mG2wvorEbbv2A2wTDrJYifglT40R2DRk1WJIMNcY=; b=
	hjT3d8h88kFI6gfiKdMuq1atzze/bvAk65xCNh1S1JXsoAGk5J4CwhlzJx5jekPi
	2gG9xvMvzZToXrRyQIvj+OTFhPuc6Ot7wjPnROal6voyLyro+LjhIUNK7CvGTx2L
	L4aQzNcn0LJGZh6rSlqIQ0U35/LiCM56GfeJaFMDM4TrYRd4V5Pdd0OKqL9nSShD
	gz5aBNa6ZvNq+baKjw5+b0gc/uSL9/u0pGpFkk5MwZMT8FzgePe7oZ5KDj0DO212
	WvOiXFA1nAYUyFKY5SUURsEtrT1wWVWtAcs1dN4+zwRiLz+xMZ4Ey20qFFagXkNi
	8A69p81G5Wz9A91Kbz+I2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855044; x=1758941444; bh=B
	p3mG2wvorEbbv2A2wTDrJYifglT40R2DRk1WJIMNcY=; b=PXuu3Wz+UkqJlqugI
	GMPLzXVOOFrfx9wuS+Y3Ab+koUtWrILGi/3aXULXZmvMnNIFRzWBHu4ZeE0tO0Fd
	bh2C+ICQv+ILpVV0Yx/v+hZ6PEa9PcJnF+bwUzTgMNcMWiB/QNqHOzUlLkWVHglV
	IVgyoPZamH5b7xivwgoztANsafBIoZzHILXDyhpqShKfrvU7MpDnaBpcD3sG9ppW
	U6QtmtVfnucQknMVpilsQ4IYdgjzBoR1cdqOmL6cLj/yU/evaoKI1U1PMqU3v3ql
	MnEwNCpCu44KsNFEe9LA5NsuCJk6K1IOy5dh/jVyyiKu12KB5qY4WFBefP5h4GCE
	e7VZw==
X-ME-Sender: <xms:hP_VaNXeYNLAO9zPjYFIqtT2ipWNHpaxC4pSWHGyGbaJSQHnl9li3A>
    <xme:hP_VaIhd_kxjqy9lGY5kxMxFkSISsz4eESupy2DckhtQWUtcbhYRP50vfpTFphnjC
    NM-gup0KRdZRtekbH6Qei1JMXTaS8G-l7QQ7hCR5fxSwl31pA>
X-ME-Received: <xmr:hP_VaIZ5vod1mVdvOtG3WPk7jS8uELEICDogN_NPdsB9JVrsmF6SU8ovkFP5m3AU53zmrw0lOdnGmLpOPpI9aSssSYgiVbG_ZkACqfbxFWB6>
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
X-ME-Proxy: <xmx:hP_VaFomnidcNedhHrrQjmzaBk-Va2OEpiOSp1tDaCRmZM-tevOjUQ>
    <xmx:hP_VaFMMB0dY851Z0V1TVz7w21oTAq78eTCCXV6LQV7tsaTpHmXXgA>
    <xmx:hP_VaIo_RnjNbZa9cBr_CDzcvlhoo83R2ErBEDolupp0hplVyJhFDQ>
    <xmx:hP_VaCfe69nxSoY_6x1-JMfpDJZAnGaaILL2fMS9bh4tPnJfQFPpTw>
    <xmx:hP_VaBNw3O_RWCfceRDTkg7v0VcWAuvJYp0k46BVBvB--2H8UqFJxjQ8>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
Date: Fri, 26 Sep 2025 12:49:07 +1000
Message-ID: <20250926025015.1747294-4-neilb@ownmail.net>
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

start_creating() is similar to simple_start_creating() but is not so
simple.
It takes a qstr for the name, includes permission checking, and does NOT
report an error if the name already exists, returning a positive dentry
instead.

This is currently used by nfsd, cachefiles, and overlayfs.

end_creating() is called after the dentry has been used.
end_creating() drops the reference to the dentry as it is generally no
longer needed.  This is exactly end_dirop_mkdir(),
but using that everywhere looks a bit odd...

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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    | 37 ++++++++--------
 fs/namei.c               | 27 ++++++++++++
 fs/nfsd/nfs3proc.c       | 14 +++---
 fs/nfsd/nfs4proc.c       | 14 +++---
 fs/nfsd/nfs4recover.c    | 16 +++----
 fs/nfsd/nfsproc.c        | 11 +++--
 fs/nfsd/vfs.c            | 42 +++++++-----------
 fs/overlayfs/copy_up.c   | 19 ++++----
 fs/overlayfs/dir.c       | 94 ++++++++++++++++++++++++----------------
 fs/overlayfs/overlayfs.h |  8 ++++
 fs/overlayfs/super.c     | 32 +++++++-------
 include/linux/namei.h    | 18 ++++++++
 12 files changed, 187 insertions(+), 145 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d1edb2ac3837..965b22b2f58d 100644
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
@@ -679,36 +676,37 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 
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
 
@@ -729,10 +727,9 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
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
index 81cbaabbbe21..064cb44a3a46 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3242,6 +3242,33 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
+/**
+ * start_creating - prepare to create a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
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
index 71b428efcbb5..35d48221072f 100644
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
index 2231192ec33f..93b2a3e764db 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -216,13 +216,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
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
@@ -233,15 +231,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
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
index aa4a95713a48..90c830c59c60 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1605,19 +1605,16 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1626,7 +1623,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	inode_unlock(dentry->d_inode);
+	end_creating(dchild, dentry);
 	return err;
 }
 
@@ -1712,11 +1709,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1729,11 +1724,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1788,32 +1783,31 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
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
@@ -1828,12 +1822,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
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
index 27396fe63f6d..6a31ea34ff80 100644
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
index dbd63a74df4b..0ae79efbfce7 100644
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
@@ -78,6 +84,16 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
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
@@ -88,35 +104,31 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
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
+		struct dentry *ret = NULL;
+
+		whiteout = ovl_start_creating_temp(ofs, workdir);
+		if (IS_ERR(whiteout))
 			return whiteout;
-		if (PTR_ERR(whiteout) != -EMLINK) {
+		err = ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
+		if (!err)
+			ret = dget(whiteout);
+		end_creating(whiteout, workdir);
+		if (ret)
+			return ret;
+
+		if (err != -EMLINK) {
 			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%lu)\n",
 				ofs->whiteout->d_inode->i_nlink,
 				PTR_ERR(whiteout));
@@ -225,10 +237,13 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
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
 
@@ -327,18 +342,21 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
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
index 4f84abaa0d68..c24c2da953bd 100644
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
index bd3d7ba8fb95..67abb62e205b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -300,8 +300,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	bool retried = false;
 
 retry:
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
+	work = ovl_start_creating_upper(ofs, ofs->workbasedir, &QSTR(name));
 
 	if (!IS_ERR(work)) {
 		struct iattr attr = {
@@ -310,14 +309,13 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
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
@@ -328,7 +326,9 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
-		inode_unlock(dir);
+		if (!IS_ERR(work))
+			dget(work);
+		end_creating(work, ofs->workbasedir);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -366,7 +366,6 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		if (err)
 			goto out_dput;
 	} else {
-		inode_unlock(dir);
 		err = PTR_ERR(work);
 		goto out_err;
 	}
@@ -616,14 +615,17 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
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
index a7800ef04e76..4cbe930054a1 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -88,6 +88,24 @@ struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
 
+struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
+
+/* end_creating - finish action started with start_creating
+ * @child - dentry returned by start_creating()
+ * @parent - dentry given to start_creating()
+ *
+ * Unlock and release the child.
+ *
+ * Unlike end_dirop() this can only be called if start_creating() succeeded.
+ * It handles @child being and error as vfs_mkdir() might have converted the
+ * dentry to an error - in that case the parent still needs to be unlocked.
+ */
+static inline void end_creating(struct dentry *child, struct dentry *parent)
+{
+	end_dirop_mkdir(child, parent);
+}
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.50.0.107.gf914562f5916.dirty


