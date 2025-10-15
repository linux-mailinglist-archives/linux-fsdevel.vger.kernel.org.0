Return-Path: <linux-fsdevel+bounces-64187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ECBDC07D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4741927C14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974DA2FABFE;
	Wed, 15 Oct 2025 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YDdbdN5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pxfxi6eG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12C2FABF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492944; cv=none; b=fP3C0GX2s1h21u4rLh4OId4UgDEIUWG/7+Jx+0wg+WenE8MsFvOH17u46MPKN4xIW8ZuL7txpXt0sGzes3tjUWpy9Wv9k8u8zYam+1U/W1I6TlznLY3ApDcoW1PXz0u1mPTGggiG12MvVDeHUtK/XUDu/m+SFnjchCq8pbXrfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492944; c=relaxed/simple;
	bh=d9DG3W80TuZQwpLRFV6aNe6UnHhAdRCJwqacfsfHflU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZvgy+60ZtslXU01HKAn/TrC6WuQPRH9sfWQnx1WAbtL9QEFRQflmzeTrcfkW8hZdb2NM6WcE+aFMFAppaU6+hCj5H9IiM5gsVDtMvneO77uv616MtDH5BtaDADrbGWa853mJ4Umy/GHPNOrpRJ/z6c4u4/mx6luLtHdtTRdxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YDdbdN5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pxfxi6eG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F932EC023F;
	Tue, 14 Oct 2025 21:49:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 21:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492942;
	 x=1760579342; bh=C5cG47NQAokTUOTbuvGCWCAxpBnYacdgGmKxSsouYPE=; b=
	YDdbdN5kLWC+cd8c9+EyTgZtsPsNKevjJWkQrGNBVnjh5VnE7o4oDiCvSl79l6Cd
	pcu6OlM//3dbg+nMZoSo5NlKPmM1C9Wa6NKfx48UL1Vy/VfCmaVNtFl1hQazDcrJ
	gdc+n6CqHn71UNLULQvYpm1vtJL9YlS4CTIzno/0exZugr0Nb/lkhI00pEGqMwHh
	44ybT3vg5zw6ET4qLycuPho2L+W85sIe05F3H41OMsOBzZcc/Lk++MX233gj0xwd
	dr/NBBKnmETDWciKJRTlYPPZae3SIqsxmyuK9ODJHLoikLzX9/Ld3zAugm/6Vr06
	Z/m0eGpHMeZIa8dFj/9xwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492942; x=1760579342; bh=C
	5cG47NQAokTUOTbuvGCWCAxpBnYacdgGmKxSsouYPE=; b=Pxfxi6eGkycf04FFc
	bAtayWjwQhlv7MeRRHhXWuzP1WEMfwDvX+Vf3u1dpV2T6to3o8t3hEQn07MVkKCV
	uPUtnOh0wwn+e0oJJ06w2o5Pd2oHz5QZ6GmWMmpmyvMLT+NutPINVrv1J6VEXxM7
	J6DKcAYomWj+Z3+AZhoqdDHvLlqsgCzMJ7yfhXIPHNWzVylyGvkJt6mpQ7LAnVuu
	1BiBU6GWHYAvFU9EtLRjYWp4QtmqG+lzjc+WQIGTYx9H8SAnRp00Pn9trEEsvvCw
	Zrky6R5LJ6V/j13CDFRj7AvdJnDg/8qPENDoU8m/vcDLtI4Aq58spb4Or6LgLh4O
	0gTxg==
X-ME-Sender: <xms:jf3uaDj_4_RRUblsCejkD9NN8vkuKQ3iO-sfrclLntROBuAULqDWQg>
    <xme:jf3uaK8ZMINGgJXJdFq46C81_EEh9h5g9xAZ1EwEE4zPLEuPIEDHGpPRRcd8jN4Ah
    -pkXMe7to5zwwcYICZs6bWETw9e8gOcTAzq--wmhtHNtRBdgg>
X-ME-Received: <xmr:jf3uaCGg6o_Wl_ZWlaP3ejibxPCSF74OcRo0pslcOIEmrbKOngrgusIaVMzfplfCdc1YuzdBa7B6okxvLJ-QXhvLgpm5TNRKEq0a3F9KsLtL>
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
X-ME-Proxy: <xmx:jf3uaFnY_U2jmZe0M6JnfwAnkZ0tTMp4uHXRhVT0u5lgRCLtCBFuKQ>
    <xmx:jf3uaObvxNBScy1lD9NnZUEOhPjn4NKtByFQAw0LgMM53kCCeasnPw>
    <xmx:jf3uaCE3Gv7jH-CSRtMkFmdmuEfW60pSkjo3Iq4BdWpTu-1F4teNcQ>
    <xmx:jf3uaHLz0XZ-NDujIrwpmi2JCQKEPcTfdxcqLtJEUmGRBZF2H7sLMg>
    <xmx:jv3uaD6Y4OwLYdkCmbDWx-1LFxNgJESPvgT25jN-P9WpWw1c6qttVIlc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:59 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/14] Add start_renaming_two_dentries()
Date: Wed, 15 Oct 2025 12:47:03 +1100
Message-ID: <20251015014756.2073439-12-neilb@ownmail.net>
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

A few callers want to lock for a rename and already have both dentries.
Also debugfs does want to perform a lookup but doesn't want permission
checking, so start_renaming_dentry() cannot be used.

This patch introduces start_renaming_two_dentries() which is given both
dentries.  debugfs performs one lookup itself.  As it will only continue
with a negative dentry and as those cannot be renamed or unlinked, it is
safe to do the lookup before getting the rename locks.

overlayfs uses start_renaming_two_dentries() in three places and  selinux
uses it twice in sel_make_policy_nodes().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/debugfs/inode.c           | 48 ++++++++++++--------------
 fs/namei.c                   | 65 ++++++++++++++++++++++++++++++++++++
 fs/overlayfs/dir.c           | 42 +++++++++++++++--------
 include/linux/namei.h        |  2 ++
 security/selinux/selinuxfs.c | 27 ++++++++++-----
 5 files changed, 135 insertions(+), 49 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f241b9df642a..532bd7c46baf 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -842,7 +842,8 @@ int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, .
 	int error = 0;
 	const char *new_name;
 	struct name_snapshot old_name;
-	struct dentry *parent, *target;
+	struct dentry *target;
+	struct renamedata rd = {};
 	struct inode *dir;
 	va_list ap;
 
@@ -855,36 +856,31 @@ int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, .
 	if (!new_name)
 		return -ENOMEM;
 
-	parent = dget_parent(dentry);
-	dir = d_inode(parent);
-	inode_lock(dir);
+	rd.old_parent = dget_parent(dentry);
+	rd.new_parent = rd.old_parent;
+	rd.flags = RENAME_NOREPLACE;
+	target = lookup_noperm_unlocked(&QSTR(new_name), rd.new_parent);
+	if (IS_ERR(target))
+		return PTR_ERR(target);
 
-	take_dentry_name_snapshot(&old_name, dentry);
-
-	if (WARN_ON_ONCE(dentry->d_parent != parent)) {
-		error = -EINVAL;
-		goto out;
-	}
-	if (strcmp(old_name.name.name, new_name) == 0)
-		goto out;
-	target = lookup_noperm(&QSTR(new_name), parent);
-	if (IS_ERR(target)) {
-		error = PTR_ERR(target);
-		goto out;
-	}
-	if (d_really_is_positive(target)) {
-		dput(target);
-		error = -EINVAL;
+	error = start_renaming_two_dentries(&rd, dentry, target);
+	if (error) {
+		if (error == -EEXIST && target == dentry)
+			/* it isn't an error to rename a thing to itself */
+			error = 0;
 		goto out;
 	}
-	simple_rename_timestamp(dir, dentry, dir, target);
-	d_move(dentry, target);
-	dput(target);
+
+	dir = d_inode(rd.old_parent);
+	take_dentry_name_snapshot(&old_name, dentry);
+	simple_rename_timestamp(dir, dentry, dir, rd.new_dentry);
+	d_move(dentry, rd.new_dentry);
 	fsnotify_move(dir, dir, &old_name.name, d_is_dir(dentry), NULL, dentry);
-out:
 	release_dentry_name_snapshot(&old_name);
-	inode_unlock(dir);
-	dput(parent);
+	end_renaming(&rd);
+out:
+	dput(rd.old_parent);
+	dput(target);
 	kfree_const(new_name);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 4e694b82e309..0a5261640ae5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3877,6 +3877,71 @@ int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 }
 EXPORT_SYMBOL(start_renaming_dentry);
 
+/**
+ * start_renaming_two_dentries - Lock to dentries in given parents for rename
+ * @rd:           rename data containing parent
+ * @old_dentry:   dentry of name to move
+ * @new_dentry:   dentry to move to
+ *
+ * Ensure locks are in place for rename and check parentage is still correct.
+ *
+ * On success the two dentries are stored in @rd.old_dentry and
+ * @rd.new_dentry and @rd.old_parent and @rd.new_parent are confirmed to
+ * be the parents of the dentries.
+ *
+ * References and the lock can be dropped with end_renaming()
+ *
+ * Returns: zero or an error.
+ */
+int
+start_renaming_two_dentries(struct renamedata *rd,
+			    struct dentry *old_dentry, struct dentry *new_dentry)
+{
+	struct dentry *trap;
+	int err;
+
+	/* Already have the dentry - need to be sure to lock the correct parent */
+	trap = lock_rename_child(old_dentry, rd->new_parent);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
+	err = -EINVAL;
+	if (d_unhashed(old_dentry) ||
+	    (rd->old_parent && rd->old_parent != old_dentry->d_parent))
+		/* old_dentry was removed, or moved and explicit parent requested */
+		goto out_unlock;
+	if (d_unhashed(new_dentry) ||
+	    rd->new_parent != new_dentry->d_parent)
+		/* new_dentry was removed or moved */
+		goto out_unlock;
+
+	if (old_dentry == trap)
+		/* source is an ancestor of target */
+		goto out_unlock;
+
+	if (new_dentry == trap) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_unlock;
+	}
+
+	err = -EEXIST;
+	if (d_is_positive(new_dentry) && (rd->flags & RENAME_NOREPLACE))
+		goto out_unlock;
+
+	rd->old_dentry = dget(old_dentry);
+	rd->new_dentry = dget(new_dentry);
+	rd->old_parent = dget(old_dentry->d_parent);
+	return 0;
+
+out_unlock:
+	unlock_rename(old_dentry->d_parent, rd->new_parent);
+	return err;
+}
+EXPORT_SYMBOL(start_renaming_two_dentries);
+
 void end_renaming(struct renamedata *rd)
 {
 	unlock_rename(rd->old_parent, rd->new_parent);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6367cebdbd48..dfd1d4b48948 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -123,6 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 			     struct dentry *dentry)
 {
 	struct dentry *whiteout;
+	struct renamedata rd = {};
 	int err;
 	int flags = 0;
 
@@ -134,10 +135,13 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	err = ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dentry);
+	rd.old_parent = ofs->workdir;
+	rd.new_parent = dir;
+	rd.flags = flags;
+	err = start_renaming_two_dentries(&rd, whiteout, dentry);
 	if (!err) {
-		err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
-		unlock_rename(ofs->workdir, dir);
+		err = ovl_do_rename_rd(&rd);
+		end_renaming(&rd);
 	}
 	if (err)
 		goto kill_whiteout;
@@ -388,6 +392,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
+	struct renamedata rd = {};
 	struct path upperpath;
 	struct dentry *upper;
 	struct dentry *opaquedir;
@@ -413,7 +418,11 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (IS_ERR(opaquedir))
 		goto out;
 
-	err = ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upper);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = workdir;
+	rd.new_parent = upperdir;
+	rd.flags = RENAME_EXCHANGE;
+	err = start_renaming_two_dentries(&rd, opaquedir, upper);
 	if (err)
 		goto out_cleanup_unlocked;
 
@@ -431,8 +440,8 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (err)
 		goto out_cleanup;
 
-	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
-	unlock_rename(workdir, upperdir);
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 	if (err)
 		goto out_cleanup_unlocked;
 
@@ -445,7 +454,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	return opaquedir;
 
 out_cleanup:
-	unlock_rename(workdir, upperdir);
+	end_renaming(&rd);
 out_cleanup_unlocked:
 	ovl_cleanup(ofs, workdir, opaquedir);
 	dput(opaquedir);
@@ -468,6 +477,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
+	struct renamedata rd = {};
 	struct dentry *upper;
 	struct dentry *newdentry;
 	int err;
@@ -499,7 +509,11 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		goto out_dput;
 
-	err = ovl_lock_rename_workdir(workdir, newdentry, upperdir, upper);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = workdir;
+	rd.new_parent = upperdir;
+	rd.flags = 0;
+	err = start_renaming_two_dentries(&rd, newdentry, upper);
 	if (err)
 		goto out_cleanup_unlocked;
 
@@ -536,16 +550,16 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 
-		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
-				    RENAME_EXCHANGE);
-		unlock_rename(workdir, upperdir);
+		rd.flags = RENAME_EXCHANGE;
+		err = ovl_do_rename_rd(&rd);
+		end_renaming(&rd);
 		if (err)
 			goto out_cleanup_unlocked;
 
 		ovl_cleanup(ofs, workdir, upper);
 	} else {
-		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
-		unlock_rename(workdir, upperdir);
+		err = ovl_do_rename_rd(&rd);
+		end_renaming(&rd);
 		if (err)
 			goto out_cleanup_unlocked;
 	}
@@ -565,7 +579,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	return err;
 
 out_cleanup:
-	unlock_rename(workdir, upperdir);
+	end_renaming(&rd);
 out_cleanup_unlocked:
 	ovl_cleanup(ofs, workdir, newdentry);
 	dput(newdentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index f73001e3719a..a99ac8b7e24a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -160,6 +160,8 @@ int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
 int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 			  struct dentry *old_dentry, struct qstr *new_last);
+int start_renaming_two_dentries(struct renamedata *rd,
+				struct dentry *old_dentry, struct dentry *new_dentry);
 void end_renaming(struct renamedata *rd);
 
 /**
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 232e087bce3e..a224ef9bb831 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -506,6 +506,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 {
 	int ret = 0;
 	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir;
+	struct renamedata rd = {};
 	unsigned int bool_num = 0;
 	char **bool_names = NULL;
 	int *bool_values = NULL;
@@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	if (ret)
 		goto out;
 
-	lock_rename(tmp_parent, fsi->sb->s_root);
+	rd.old_parent = tmp_parent;
+	rd.new_parent = fsi->sb->s_root;
 
 	/* booleans */
-	d_exchange(tmp_bool_dir, fsi->bool_dir);
+	ret = start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_dir);
+	if (!ret) {
+		d_exchange(tmp_bool_dir, fsi->bool_dir);
 
-	swap(fsi->bool_num, bool_num);
-	swap(fsi->bool_pending_names, bool_names);
-	swap(fsi->bool_pending_values, bool_values);
+		swap(fsi->bool_num, bool_num);
+		swap(fsi->bool_pending_names, bool_names);
+		swap(fsi->bool_pending_values, bool_values);
 
-	fsi->bool_dir = tmp_bool_dir;
+		fsi->bool_dir = tmp_bool_dir;
+		end_renaming(&rd);
+	}
 
 	/* classes */
-	d_exchange(tmp_class_dir, fsi->class_dir);
-	fsi->class_dir = tmp_class_dir;
+	ret = start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir);
+	if (ret == 0) {
+		d_exchange(tmp_class_dir, fsi->class_dir);
+		fsi->class_dir = tmp_class_dir;
 
-	unlock_rename(tmp_parent, fsi->sb->s_root);
+		end_renaming(&rd);
+	}
 
 out:
 	sel_remove_old_bool_data(bool_num, bool_names, bool_values);
-- 
2.50.0.107.gf914562f5916.dirty


