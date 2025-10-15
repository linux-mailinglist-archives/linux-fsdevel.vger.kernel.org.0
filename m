Return-Path: <linux-fsdevel+bounces-64186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3FBDC07A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F121A4EF027
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5032FB084;
	Wed, 15 Oct 2025 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="xE10sH6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXom6EVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4C2F7478
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492940; cv=none; b=aKMM3VQP1ZWbbGcYZcqpAyRay42TdDe5w8/BOw+sAR/xkhonoRpai8ehq72pAaqzct+orKDTdPCGcXJji7+WhVEJ17dyT5iT8zoxf7oMgg5lyGT/M+kpIoIN+bHlc5+hY/ANhBvmR9gzjqVWlnqxJ1poszgvPXmBHavRK3c10X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492940; c=relaxed/simple;
	bh=RLFJe4X9kZtF9jEsIq+GA9/mFJsTJpkPbbnRi17FajE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZRdCGoXyGrqP3/t4cf+2y+dbmjsmAMoTQztzweRsIILM4sUMiu1aj03U13tylrdQuTIE57HASsNg5bsYB/YzA2NPEbxoKktv2X4mXenwwxoBftJAtVHuurjT09HlutcjsEl8nMDn+SyvwVKf+StIrTdkhgzwXkl5sYs5cSwsX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=xE10sH6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXom6EVn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98E8914000A2;
	Tue, 14 Oct 2025 21:48:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 21:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492937;
	 x=1760579337; bh=JwXF3Iy4B23A4jQfEa2DGZs9WESVBs9O8afN3UM/0ns=; b=
	xE10sH6kt2hYT+AJ5rlSaUJmKKHBsx6YY2WWX3erfnSFiWLzEoxbkJfzBX8oT1oO
	GsV14pgrG0KXyMRk9jez0VniBh7WVG5wAxem0JEM0UlMmY7mInyOctrK4Lxq/a0/
	8F10s6IlZ/Jh8iV0X6cK5anZtzH+HY50j1BHx14Z1eDWp0uht5oxr/JF+HflJ7Hq
	TUGzbAB68e/gj6/hwoooP1rlYxa6AMY7gKwyGCGj4JLFv8E37Hb+f7H89Iz5yBp9
	y4C/atWPYLDhAK0iG/loT5FMcfjpSe7xYv/TqPDCxUkig9RTcT+Egqpd5Vmu7/YY
	eQ5HKeKrJo7/E1pH/KSG4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492937; x=1760579337; bh=J
	wXF3Iy4B23A4jQfEa2DGZs9WESVBs9O8afN3UM/0ns=; b=cXom6EVnLRsKX/uTy
	Ui4YIV8BJTtKuvUxmQBSaOIDvFlq+cQvD16WqqGNi3SEdBTiVCKOFxaskATz7OwX
	V946NpGvETV0Jx4iRI2Y8BZNiemcxgWI/ua9OFj6XTr1R5zZsm0yhUh4WjorIALj
	x6Yq+gKfxXamg6a/F5mTiXojzol8fK5MvHj+59jIIDcPmW5V2G77UJuKp5S+Mdie
	QZZmeGcIirW2m3u+s5Y5zmWSjLJc1sAAPeqcFIbcDctfQE4Hy/0PmN+yg+87zah5
	JV0vz1hojYTbkXQp3Wv74PcZTC7GL3ageq9L5vCtVQa/rxU7yLCESbtKOzijugHf
	BAHWQ==
X-ME-Sender: <xms:if3uaKt7t1zTMENuRGQmFGx1EoGygYNFgD7ZbyDaCXTSwtni6PpWQg>
    <xme:if3uaKZoDy5Du2FtaePCYRxizxoFveLzWUq84km4wiBlTUfiE7OiYXDaYi-Gx99sf
    VF5-RWrUA4zjJ08f4Zl0EagogVBnFZ2Ny7Ui6_Mj-djIWI0CUM>
X-ME-Received: <xmr:if3uaEwppe9mNvqYsbEgbpdj8g5IhRcJC8R-t8_y1kaEb-Rcb9KEskc_YuycMQrBBJRzU58bIgWC4ZH_9RdgSjL7GLAXoEymfSJRKimyZ1DV>
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
X-ME-Proxy: <xmx:if3uaKjhSmVVYh3YKOqPYvy6qo61zb8klwsrd7u64msiTaKKXwe-rg>
    <xmx:if3uaIngwgnD1CtHa5PavHWkhILwWvMhm6L5tIiAgxDMbX055vXUCw>
    <xmx:if3uaIgesJhieGLbRbSqjXhrgGupIqQzN1-fQo3Jgv4z1PzWvlJ3fg>
    <xmx:if3uaE0EgJtOlr6dneoRhEpBgL0QGOecAFb4bOMgLKapD8rQpO4-BQ>
    <xmx:if3uaPm1UIAd8qvPYjiwdL-q5CIhOehqx9lfrL8vSqDNH13sMQWE_DQL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:55 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
Date: Wed, 15 Oct 2025 12:47:02 +1100
Message-ID: <20251015014756.2073439-11-neilb@ownmail.net>
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

Several callers perform a rename on a dentry they already have, and only
require lookup for the target name.  This includes smb/server and a few
different places in overlayfs.

start_renaming_dentry() performs the required lookup and takes the
required lock using lock_rename_child()

It is used in three places in overlayfs and in ksmbd_vfs_rename().

In the ksmbd case, the parent of the source is not important - the
source must be renamed from wherever it is.  So start_renaming_dentry()
allows rd->old_parent to be NULL and only checks it if it is non-NULL.
On success rd->old_parent will be the parent of old_dentry with an extra
reference taken.  Other start_renaming function also now take the extra
reference and end_renaming() now drops this reference as well.

ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
all removed as they are no longer needed.

OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h so
that ovl_check_rename_whiteout() can access them.

ovl_copy_up_workdir() now always cleans up on error.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c               | 108 ++++++++++++++++++++++++++++++++++++---
 fs/overlayfs/copy_up.c   |  54 +++++++++-----------
 fs/overlayfs/dir.c       |  19 +------
 fs/overlayfs/overlayfs.h |   8 +--
 fs/overlayfs/super.c     |  22 ++++----
 fs/overlayfs/util.c      |  11 ----
 fs/smb/server/vfs.c      |  60 ++++------------------
 include/linux/namei.h    |   2 +
 8 files changed, 150 insertions(+), 134 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a2553df8f34e..4e694b82e309 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3669,7 +3669,7 @@ EXPORT_SYMBOL(unlock_rename);
 
 /**
  * __start_renaming - lookup and lock names for rename
- * @rd:           rename data containing parent and flags, and
+ * @rd:           rename data containing parents and flags, and
  *                for receiving found dentries
  * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
  *                LOOKUP_NO_SYMLINKS etc).
@@ -3680,8 +3680,8 @@ EXPORT_SYMBOL(unlock_rename);
  * rename.
  *
  * On success the found dentrys are stored in @rd.old_dentry,
- * @rd.new_dentry.  These references and the lock are dropped by
- * end_renaming().
+ * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
+ * These references and the lock are dropped by end_renaming().
  *
  * The passed in qstrs must have the hash calculated, and no permission
  * checking is performed.
@@ -3733,6 +3733,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 
 	rd->old_dentry = d1;
 	rd->new_dentry = d2;
+	dget(rd->old_parent);
 	return 0;
 
 out_unlock_3:
@@ -3748,7 +3749,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 
 /**
  * start_renaming - lookup and lock names for rename with permission checking
- * @rd:           rename data containing parent and flags, and
+ * @rd:           rename data containing parents and flags, and
  *                for receiving found dentries
  * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
  *                LOOKUP_NO_SYMLINKS etc).
@@ -3759,8 +3760,8 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
  * rename.
  *
  * On success the found dentrys are stored in @rd.old_dentry,
- * @rd.new_dentry.  These references and the lock are dropped by
- * end_renaming().
+ * @rd.new_dentry.  Also the refcount on @rd->old_parent is increased.
+ * These references and the lock are dropped by end_renaming().
  *
  * The passed in qstrs need not have the hash calculated, and basic
  * eXecute permission checking is performed against @rd.mnt_idmap.
@@ -3782,11 +3783,106 @@ int start_renaming(struct renamedata *rd, int lookup_flags,
 }
 EXPORT_SYMBOL(start_renaming);
 
+static int
+__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			struct dentry *old_dentry, struct qstr *new_last)
+{
+	struct dentry *trap;
+	struct dentry *d2;
+	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
+	int err;
+
+	if (rd->flags & RENAME_EXCHANGE)
+		target_flags = 0;
+	if (rd->flags & RENAME_NOREPLACE)
+		target_flags |= LOOKUP_EXCL;
+
+	/* Already have the dentry - need to be sure to lock the correct parent */
+	trap = lock_rename_child(old_dentry, rd->new_parent);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
+	if (d_unhashed(old_dentry) ||
+	    (rd->old_parent && rd->old_parent != old_dentry->d_parent)) {
+		/* dentry was removed, or moved and explicit parent requested */
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
+				  lookup_flags | target_flags);
+	err = PTR_ERR(d2);
+	if (IS_ERR(d2))
+		goto out_unlock;
+
+	if (old_dentry == trap) {
+		/* source is an ancestor of target */
+		err = -EINVAL;
+		goto out_dput_d2;
+	}
+
+	if (d2 == trap) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_dput_d2;
+	}
+
+	rd->old_dentry = dget(old_dentry);
+	rd->new_dentry = d2;
+	rd->old_parent = dget(old_dentry->d_parent);
+	return 0;
+
+out_dput_d2:
+	dput(d2);
+out_unlock:
+	unlock_rename(old_dentry->d_parent, rd->new_parent);
+	return err;
+}
+
+/**
+ * start_renaming_dentry - lookup and lock name for rename with permission checking
+ * @rd:           rename data containing parents and flags, and
+ *                for receiving found dentries
+ * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
+ *                LOOKUP_NO_SYMLINKS etc).
+ * @old_dentry:   dentry of name to move
+ * @new_last:     name of target in @rd.new_parent
+ *
+ * Look up target name and ensure locks are in place for
+ * rename.
+ *
+ * On success the found dentry is stored in @rd.new_dentry and
+ * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
+ * was originally %NULL, it is set.  In either case a reference is taken
+ * so that end_renaming() can have a stable reference to unlock.
+ *
+ * References and the lock can be dropped with end_renaming()
+ *
+ * The passed in qstr need not have the hash calculated, and basic
+ * eXecute permission checking is performed against @rd.mnt_idmap.
+ *
+ * Returns: zero or an error.
+ */
+int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			  struct dentry *old_dentry, struct qstr *new_last)
+{
+	int err;
+
+	err = lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
+	if (err)
+		return err;
+	return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_last);
+}
+EXPORT_SYMBOL(start_renaming_dentry);
+
 void end_renaming(struct renamedata *rd)
 {
 	unlock_rename(rd->old_parent, rd->new_parent);
 	dput(rd->old_dentry);
 	dput(rd->new_dentry);
+	dput(rd->old_parent);
 }
 EXPORT_SYMBOL(end_renaming);
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7a31ca9bdea2..27014ada11c7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
-	struct dentry *index = NULL;
 	struct dentry *temp = NULL;
+	struct renamedata rd = {};
 	struct qstr name = { };
 	int err;
 
@@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		goto out;
 
-	err = ovl_parent_lock(indexdir, temp);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = indexdir;
+	rd.new_parent = indexdir;
+	err = start_renaming_dentry(&rd, 0, temp, &name);
 	if (err)
 		goto out;
-	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
-	if (IS_ERR(index)) {
-		err = PTR_ERR(index);
-	} else {
-		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
-		dput(index);
-	}
-	ovl_parent_unlock(indexdir);
+
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 out:
 	if (err)
 		ovl_cleanup(ofs, indexdir, temp);
@@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
-	struct dentry *temp, *upper, *trap;
+	struct renamedata rd = {};
+	struct dentry *temp;
 	struct ovl_cu_creds cc;
 	int err;
 	struct ovl_cattr cattr = {
@@ -807,29 +806,24 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
-	trap = lock_rename(c->workdir, c->destdir);
-	if (trap || temp->d_parent != c->workdir) {
-		/* temp or workdir moved underneath us? abort without cleanup */
-		dput(temp);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = c->workdir;
+	rd.new_parent = c->destdir;
+	rd.flags = 0;
+	err = start_renaming_dentry(&rd, 0, temp,
+				    &QSTR_LEN(c->destname.name, c->destname.len));
+	if (err) {
+		/* temp or workdir moved underneath us? map to -EIO */
 		err = -EIO;
-		if (!IS_ERR(trap))
-			unlock_rename(c->workdir, c->destdir);
-		goto out;
 	}
-
-	err = ovl_copy_up_metadata(c, temp);
 	if (err)
-		goto cleanup;
+		goto cleanup_unlocked;
 
-	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
-				 c->destname.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
-		goto cleanup;
+	err = ovl_copy_up_metadata(c, temp);
+	if (!err)
+		err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 
-	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
-	unlock_rename(c->workdir, c->destdir);
-	dput(upper);
 	if (err)
 		goto cleanup_unlocked;
 
@@ -850,8 +844,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	return err;
 
-cleanup:
-	unlock_rename(c->workdir, c->destdir);
 cleanup_unlocked:
 	ovl_cleanup(ofs, c->workdir, temp);
 	dput(temp);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ded86855e91c..6367cebdbd48 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -57,8 +57,7 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
 	return 0;
 }
 
-#define OVL_TEMPNAME_SIZE 20
-static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
+void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 {
 	static atomic_t temp_id = ATOMIC_INIT(0);
 
@@ -66,22 +65,6 @@ static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
 	snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_id));
 }
 
-struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
-{
-	struct dentry *temp;
-	char name[OVL_TEMPNAME_SIZE];
-
-	ovl_tempname(name);
-	temp = ovl_lookup_upper(ofs, name, workdir, strlen(name));
-	if (!IS_ERR(temp) && temp->d_inode) {
-		pr_err("workdir/%s already exists\n", name);
-		dput(temp);
-		temp = ERR_PTR(-EIO);
-	}
-
-	return temp;
-}
-
 static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
 					      struct dentry *workdir)
 {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index aecb527e0524..a9ecab16dba6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -454,11 +454,6 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 }
 
 /* util.c */
-int ovl_parent_lock(struct dentry *parent, struct dentry *child);
-static inline void ovl_parent_unlock(struct dentry *parent)
-{
-	inode_unlock(parent->d_inode);
-}
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
 void ovl_start_write(struct dentry *dentry);
@@ -895,7 +890,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct dentry *parent, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
-struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir);
+#define OVL_TEMPNAME_SIZE 20
+void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 6e0816c1147a..a721ef2b90e8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -566,9 +566,10 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 {
 	struct dentry *workdir = ofs->workdir;
 	struct dentry *temp;
-	struct dentry *dest;
 	struct dentry *whiteout;
 	struct name_snapshot name;
+	struct renamedata rd = {};
+	char name2[OVL_TEMPNAME_SIZE];
 	int err;
 
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
@@ -576,23 +577,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	if (IS_ERR(temp))
 		return err;
 
-	err = ovl_parent_lock(workdir, temp);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = workdir;
+	rd.new_parent = workdir;
+	rd.flags = RENAME_WHITEOUT;
+	ovl_tempname(name2);
+	err = start_renaming_dentry(&rd, 0, temp, &QSTR(name2));
 	if (err) {
 		dput(temp);
 		return err;
 	}
-	dest = ovl_lookup_temp(ofs, workdir);
-	err = PTR_ERR(dest);
-	if (IS_ERR(dest)) {
-		dput(temp);
-		ovl_parent_unlock(workdir);
-		return err;
-	}
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
-	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
-	ovl_parent_unlock(workdir);
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 	if (err) {
 		if (err == -EINVAL)
 			err = 0;
@@ -616,7 +615,6 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	ovl_cleanup(ofs, workdir, temp);
 	release_dentry_name_snapshot(&name);
 	dput(temp);
-	dput(dest);
 
 	return err;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f76672f2e686..46387aeb6be6 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1548,14 +1548,3 @@ void ovl_copyattr(struct inode *inode)
 	i_size_write(inode, i_size_read(realinode));
 	spin_unlock(&inode->i_lock);
 }
-
-int ovl_parent_lock(struct dentry *parent, struct dentry *child)
-{
-	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-	if (!child ||
-	    (!d_unhashed(child) && child->d_parent == parent))
-		return 0;
-
-	inode_unlock(parent->d_inode);
-	return -EINVAL;
-}
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 7c4ddc43ab39..f54b5b0aaba2 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -663,7 +663,6 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		     char *newname, int flags)
 {
-	struct dentry *old_parent, *new_dentry, *trap;
 	struct dentry *old_child = old_path->dentry;
 	struct path new_path;
 	struct qstr new_last;
@@ -673,7 +672,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	struct ksmbd_file *parent_fp;
 	int new_type;
 	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
-	int target_lookup_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
@@ -684,14 +682,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto revert_fsids;
 	}
 
-	/*
-	 * explicitly handle file overwrite case, for compatibility with
-	 * filesystems that may not support rename flags (e.g: fuse)
-	 */
-	if (flags & RENAME_NOREPLACE)
-		target_lookup_flags |= LOOKUP_EXCL;
-	flags &= ~(RENAME_NOREPLACE);
-
 retry:
 	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
 				     &new_path, &new_last, &new_type,
@@ -708,17 +698,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	if (err)
 		goto out2;
 
-	trap = lock_rename_child(old_child, new_path.dentry);
-	if (IS_ERR(trap)) {
-		err = PTR_ERR(trap);
+	rd.mnt_idmap		= mnt_idmap(old_path->mnt);
+	rd.old_parent		= NULL;
+	rd.new_parent		= new_path.dentry;
+	rd.flags		= flags;
+	rd.delegated_inode	= NULL,
+	err = start_renaming_dentry(&rd, lookup_flags, old_child, &new_last);
+	if (err)
 		goto out_drop_write;
-	}
-
-	old_parent = dget(old_child->d_parent);
-	if (d_unhashed(old_child)) {
-		err = -EINVAL;
-		goto out3;
-	}
 
 	parent_fp = ksmbd_lookup_fd_inode(old_child->d_parent);
 	if (parent_fp) {
@@ -731,44 +718,17 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		ksmbd_fd_put(work, parent_fp);
 	}
 
-	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | target_lookup_flags);
-	if (IS_ERR(new_dentry)) {
-		err = PTR_ERR(new_dentry);
-		goto out3;
-	}
-
-	if (d_is_symlink(new_dentry)) {
+	if (d_is_symlink(rd.new_dentry)) {
 		err = -EACCES;
-		goto out4;
-	}
-
-	if (old_child == trap) {
-		err = -EINVAL;
-		goto out4;
-	}
-
-	if (new_dentry == trap) {
-		err = -ENOTEMPTY;
-		goto out4;
+		goto out3;
 	}
 
-	rd.mnt_idmap		= mnt_idmap(old_path->mnt),
-	rd.old_parent		= old_parent,
-	rd.old_dentry		= old_child,
-	rd.new_parent		= new_path.dentry,
-	rd.new_dentry		= new_dentry,
-	rd.flags		= flags,
-	rd.delegated_inode	= NULL,
 	err = vfs_rename(&rd);
 	if (err)
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
-out4:
-	dput(new_dentry);
 out3:
-	dput(old_parent);
-	unlock_rename(old_parent, new_path.dentry);
+	end_renaming(&rd);
 out_drop_write:
 	mnt_drop_write(old_path->mnt);
 out2:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 19c3d8e336d5..f73001e3719a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -158,6 +158,8 @@ extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
+int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			  struct dentry *old_dentry, struct qstr *new_last);
 void end_renaming(struct renamedata *rd);
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


