Return-Path: <linux-fsdevel+bounces-65043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF501BFA00C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AFD19C9B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091A2D97B8;
	Wed, 22 Oct 2025 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nNcgM5PN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZBPRTwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A751F099C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108486; cv=none; b=k9O4HwhP8iGvZTCrjwunyt5Q9D0wNRbf3i1RsMEIhnOa8RudTEyAw+KLH7SZubnGO/hKSTvVL3EDxmpfiB5s/iGgaa/59+VwJV4imaeEu+GHDcu09MqIpE6bRZoqcNmo9WzJ4NVV06MdhnNZj6FSgn7XZXBO1OKgn4aCKqaWa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108486; c=relaxed/simple;
	bh=ws3gEU+Yn0QciYqJP5mV3FMkw6UeNTNyrYdqTw4nbi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl6YIhMHY7B6uuTtW+VZna3vtLAXG+Y5/vPqoA2RoiZ2xaVpUGbOkidtYcC3AaSIH54Z74ptwxSoFyLLRxCf2TfwGQAChhpU42UakWEvc5ydzD5izbVcIZBwZsNrql5P5ZGPlc/NM+EyXNxLT80H+1kEzOJEQ9MJxuRIsLK1g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nNcgM5PN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vZBPRTwE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72A2914001DD;
	Wed, 22 Oct 2025 00:48:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 22 Oct 2025 00:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761108483;
	 x=1761194883; bh=yU5OE+dxP+twvAE9s7uQKb6ICMfHcmP1PJB+VlfPSZA=; b=
	nNcgM5PNjdQlMeaHKhVYqzs1qj9uPvFe6+01gDwBUoUPutxSeck4gN+x0v9Orx50
	RvDibZgbsT76t4b/E3VATeEFX/nrrp3lRp5FlHMpdP7qEu28JuQTMpm4BvecYN51
	BFCDid5laqhE+9TyUMoH2nqLrhndUkFWi7xGtOaItkzprPB+vAbva6Lu8DqY/U3N
	efKCiJn87IA1tXZjYFEY717cvkIfuigN0qAZYXMvIPzJShH7RUEUr+i/CxgCw+pD
	Y5K3AmPVD1XvHuGqfBjPQUoeHaRS3W9hdICZKfHEuNnZgysqsGrQtIqtIgYhSmwE
	909BzEOonGP1/qyKnNH1pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761108483; x=1761194883; bh=y
	U5OE+dxP+twvAE9s7uQKb6ICMfHcmP1PJB+VlfPSZA=; b=vZBPRTwE/a6mOaGiV
	+eYKYBPdWO58rzb36YejBGtI/Fk5uwhiIC45F1UUH+q5dNp2WwY0mgRdRX+QeD26
	En9OIVsxt96ay+hIxiTozdc6+8nJiLZBXhAOG68oJhNd5kgyH1rLKmYcdeTz446E
	Huk8lN6pMpvabAYhp6yYUiVwyGvEUuOttHmwOQwyMKRB85BQmiQdbprHSLgNGlgz
	avE5tsyiZ2Wk7fcA7yykAla95eJqF7GdNenqNRRYrOxQocK23PJ2DGdzHA2iI7gm
	lHBZxA1f04dxYX7FWcfUy65lFQjHwtlSXnjUGt+vWD6Xo9wERYA47KBJ/hkRdwVT
	LCHmA==
X-ME-Sender: <xms:A2L4aAYcuKzzaRLZJRmzEhsI3tsPs50lCSMGVMvn3I8sOfO8xRsDCw>
    <xme:A2L4aGVxSYxF0qA1rsuCIQmGSf90JXKyWn2SgDdX5fOkZrdBIBKRX5PVgO891KYLY
    r926Ki-2ArbACvi9J60WB_2LN5EuwvD78ti2diQDy8BbhXwxg>
X-ME-Received: <xmr:A2L4aJ98SuTFBTYCCcRLROHRzDx5yiP9uIDnHWm4D-TC1nEMQ6NCAvhNYoaeTZp9PWz-0uEFAbvQ9HR1hMhi4qocmMggmDJ_5_SxTTK_cu6r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:A2L4aP_tD-ND_jpEzGBgy9fLSGRGeem6Zhwe7UHoBz3HaDHEVlyi9w>
    <xmx:A2L4aJRL83G3lH4WBh_DiEA2VlffCqQYO-qAPy-9BWNVI80auYfPxw>
    <xmx:A2L4aDeUna30p3BIwYrLeIghjXAQaVOXBsae6oRxJbq5HR_wmGU7Rg>
    <xmx:A2L4aNBZqhty-N9YFkiqKVa34IHIb05ySEP1R8AOx4Dd48Uy9EvOzQ>
    <xmx:A2L4aFzh1c3CVpA9IFHCFrF8XPGRLhRoitjqT95GSXFE0idGMU5R8CSg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:48:01 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/14] Add start_renaming_two_dentries()
Date: Wed, 22 Oct 2025 15:41:45 +1100
Message-ID: <20251022044545.893630-12-neilb@ownmail.net>
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
index 5153ceddd37a..4a4b8b96c192 100644
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
index 3c5cb665d530..b1f2c940e585 100644
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


