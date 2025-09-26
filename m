Return-Path: <linux-fsdevel+bounces-62847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E34BA2401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF47A624374
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963420459A;
	Fri, 26 Sep 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Xihsu7VE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfxjIXfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B01C5F1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855073; cv=none; b=mxa+rSrjjga5evUTkZyWS/ImOchk6J8rk4HsIkPzKizwPU4YpBGHmTt0KBYeYnTioL5v4grBLopqR+9O52l30XCadU33T9jsekmtIrE1zNfDWPbszwejzg4n5lyqOAjur5DpNB6PQIevUt3E323T+x3gWMFjLvpqWa9Gp3/2+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855073; c=relaxed/simple;
	bh=c05xNyVlcqbLDKT7bLUWb5/YRzi5JlykFHtSr+72V4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF7no1F8iyhCiZYY5qEheCDoQZWYyJMfh8okz0U+NiPwH+7ik4cjCimNxR7KQBkQ75TOZz0NpbjEmZtSrxUVYCo0X+tmRPv8QJ/YMcjnjQi+ho1somrJeufhuHydlxHG4HcrRHJQkIr+so4An3Bdf7W9hwiOx1WprzKmrf7nArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Xihsu7VE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfxjIXfW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF8C71400040;
	Thu, 25 Sep 2025 22:51:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 25 Sep 2025 22:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855070;
	 x=1758941470; bh=BKFtnvDZURH4lLG0e3uE9+E8D7QkSsfpy0mRyOPsnfg=; b=
	Xihsu7VEgz4BpyOtiv+NXnspejnlU77efguNLXyINOZ8ddC4b9w3ajVOYaebi3p0
	HV1nW8e9NQbnRI/waRnUJJ7S6L5UXiEe2t50ikbDD01ujd35/GByjLaoi9GMfk7V
	SdbwcgIDZoCzXOBenRxKhmXKt56krx3XML5dxFGhpZ3ZSxlKalHeH88OMbCM1ft/
	4nkBIcu/pTy7+Wi1ZFckIFQrApjanZ8mm1MJhmFKc1jLLlPJrGjnUZns3r1ErVHo
	+Pi5QwBI6m8lcSXmt+MvRiHO+v8Ptd2dR+CrYFpopnuiSpXqdOSJQr1nj8H1MOiS
	9hp2Yn1neDbah5lDHClsTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855070; x=1758941470; bh=B
	KFtnvDZURH4lLG0e3uE9+E8D7QkSsfpy0mRyOPsnfg=; b=AfxjIXfWw7XiM4cOi
	sWX23F5YOBoCnlT6WrOSgF96/U4NLd7WxfmNHfkpTVn5Fhb3ifVS3mUeMBAPmDTH
	fMnL6OTY940prY/YKhfeHiLwCJuXLeY4RHZlaypgW9b8RBiU09B8VzEDqYTqE8FX
	aPp61CvHGxYmiuWbJT/x0/MMXBG2vwjaz17ybhmtxHavvqGPaSlg5if8ygtRo3L2
	m0YMpBcYi1/7zhJMFsF1MjqUWy8Gu0bhSH8lPGMQr8EgwXvs/TeH7KsZO8ITcOOR
	EtLQHrniy8KmZuNJn3mXpzqkJnbOItJbUs3MSLi13XNgWg45fkSuTFxupQRbRFHH
	CO1Eg==
X-ME-Sender: <xms:nv_VaLerq-7bm2zPn08erW2gfyqGI3J7rHl0xQWfWlDLRCeE_f2VDw>
    <xme:nv_VaMKlQmniJ49ETCGr3F5rGZLRJOT3UPlxAvjJkf8VI9k78K9kmtgC-wAXgLF5S
    QqJDWFl8zY3PbQvTRzDG81JHBpIuWJ6zIuVIz9YQ8UQju55pQ>
X-ME-Received: <xmr:nv_VaDhWLcuEyUGafv-MPbbeXl8TLGft-5XSoqmyyJMflw2vkJiWEYEFovwV7Dv-lKPGkKq7bdFBi4Qi6FxxszNAhKdXfcODxnB4TGYc6MZD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nv_VaCQKMkidzWFG076YX-yTHJynIzYQQAErrvsh3_Fn3DK2r8nezQ>
    <xmx:nv_VaFWF3i7o5Lvb7ZUyLj3_kA7itNQ0KrGT4qLlOBCQVHP4HpaueQ>
    <xmx:nv_VaGSRlA_fpewChTUEIs_dHDe3tgFzDQori1QRln2SWhciW8m20g>
    <xmx:nv_VaPmTxiSAeI6501ZQn5t-RnLtIIbqUGlVyMV0mxFWv1HKBXX7Hg>
    <xmx:nv_VaCUhEuG_ZhflhS-uX8BVHfzV5KCtAdsGZKQ3LyNu_ibinGeHEVa0>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:51:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
Date: Fri, 26 Sep 2025 12:49:13 +1000
Message-ID: <20250926025015.1747294-10-neilb@ownmail.net>
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

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c               | 106 ++++++++++++++++++++++++++++++++++++---
 fs/overlayfs/copy_up.c   |  47 ++++++++---------
 fs/overlayfs/dir.c       |  19 +------
 fs/overlayfs/overlayfs.h |   8 +--
 fs/overlayfs/super.c     |  20 ++++----
 fs/overlayfs/util.c      |  11 ----
 fs/smb/server/vfs.c      |  60 ++++------------------
 include/linux/namei.h    |   2 +
 8 files changed, 147 insertions(+), 126 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 79a8b3b47e4d..aca6de83d255 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3686,7 +3686,7 @@ EXPORT_SYMBOL(unlock_rename);
 
 /**
  * __start_renaming - lookup and lock names for rename
- * @rd:           rename data containing parent and flags, and
+ * @rd:           rename data containing parents and flags, and
  *                for receiving found dentries
  * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
  *                LOOKUP_NO_SYMLINKS etc).
@@ -3697,8 +3697,8 @@ EXPORT_SYMBOL(unlock_rename);
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
@@ -3750,6 +3750,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 
 	rd->old_dentry = d1;
 	rd->new_dentry = d2;
+	dget(rd->old_parent);
 	return 0;
 
 out_unlock_3:
@@ -3765,7 +3766,7 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 
 /**
  * start_renaming - lookup and lock names for rename with permission checking
- * @rd:           rename data containing parent and flags, and
+ * @rd:           rename data containing parents and flags, and
  *                for receiving found dentries
  * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
  *                LOOKUP_NO_SYMLINKS etc).
@@ -3776,8 +3777,8 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
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
@@ -3799,11 +3800,104 @@ int start_renaming(struct renamedata *rd, int lookup_flags,
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
+		d2 = ERR_PTR(-EINVAL);
+		goto out_unlock_2;
+	}
+
+	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
+				  lookup_flags | target_flags);
+	if (IS_ERR(d2))
+		goto out_unlock_2;
+
+	if (old_dentry == trap) {
+		/* source is an ancestor of target */
+		err = -EINVAL;
+		goto out_unlock_3;
+	}
+
+	if (d2 == trap) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_unlock_3;
+	}
+
+	rd->old_dentry = dget(old_dentry);
+	rd->new_dentry = d2;
+	rd->old_parent = dget(old_dentry->d_parent);
+	return 0;
+
+out_unlock_3:
+	dput(d2);
+	d2 = ERR_PTR(err);
+out_unlock_2:
+	unlock_rename(old_dentry->d_parent, rd->new_parent);
+	return PTR_ERR(d2);
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
+ * was originally %NULL, it is set.  In either case a refernence is taken.
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
index 6a31ea34ff80..3f19548b5d48 100644
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
@@ -807,29 +806,27 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
-	trap = lock_rename(c->workdir, c->destdir);
-	if (trap || temp->d_parent != c->workdir) {
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = c->workdir;
+	rd.new_parent = c->destdir;
+	rd.flags = 0;
+	err = start_renaming_dentry(&rd, 0, temp,
+				    &QSTR_LEN(c->destname.name, c->destname.len));
+	if (err == -EINVAL || err == -EXDEV) {
 		/* temp or workdir moved underneath us? abort without cleanup */
 		dput(temp);
 		err = -EIO;
-		if (!IS_ERR(trap))
-			unlock_rename(c->workdir, c->destdir);
 		goto out;
 	}
-
-	err = ovl_copy_up_metadata(c, temp);
 	if (err)
 		goto cleanup;
 
-	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
-				 c->destname.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
+	err = ovl_copy_up_metadata(c, temp);
+	if (err)
 		goto cleanup;
 
-	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
-	unlock_rename(c->workdir, c->destdir);
-	dput(upper);
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 	if (err)
 		goto cleanup_unlocked;
 
@@ -851,7 +848,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	return err;
 
 cleanup:
-	unlock_rename(c->workdir, c->destdir);
+	end_renaming(&rd);
 cleanup_unlocked:
 	ovl_cleanup(ofs, c->workdir, temp);
 	dput(temp);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b37aefe465a2..54423ad00e1c 100644
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
index 181fc46195f2..a8bc144f9d62 100644
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
@@ -893,7 +888,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct dentry *parent, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
-struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir);
+#define OVL_TEMPNAME_SIZE 20
+void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 67abb62e205b..1af489272d10 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -559,6 +559,8 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	struct dentry *dest;
 	struct dentry *whiteout;
 	struct name_snapshot name;
+	struct renamedata rd = {};
+	char name2[OVL_TEMPNAME_SIZE];
 	int err;
 
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
@@ -566,23 +568,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
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
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 41033bac96cb..bfe44eba903f 100644
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
index 56b755a05c4e..8961b7e38782 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -662,7 +662,6 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		     char *newname, int flags)
 {
-	struct dentry *old_parent, *new_dentry, *trap;
 	struct dentry *old_child = old_path->dentry;
 	struct path new_path;
 	struct qstr new_last;
@@ -672,7 +671,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	struct ksmbd_file *parent_fp;
 	int new_type;
 	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
-	int target_lookup_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
@@ -683,14 +681,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
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
@@ -707,17 +697,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
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
@@ -730,44 +717,17 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
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
index b65ed6e1e91a..ada0f6cc38bc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -142,6 +142,8 @@ extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
+int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
+			  struct dentry *old_dentry, struct qstr *new_last);
 void end_renaming(struct renamedata *rd);
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


