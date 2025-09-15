Return-Path: <linux-fsdevel+bounces-61269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A619B56E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACB53B58CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C81F1306;
	Mon, 15 Sep 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C25rLvTs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dep5ljMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B511FE44B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902578; cv=none; b=MVviTNjB9fu8f3Gh7krK73Kn5eEHx1bGBMb2/VK95RfLXJE3BMk0g6kbmGseKh7nQASYQLt+xaYqEXjriOOMh4YOHPeItlg9vohIdsAeOFDuoCu3EJ7Y6xHCFyYq2OUJ2zyeo96QaXJ8cdu/bDnRUIQJkQXtnY+A6lZNfvHiHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902578; c=relaxed/simple;
	bh=qaMQKs+ni/9z+tKkWDWHzH2/ji40cUTAJSW3c9uemec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZAMy5uDP4yIvJX0FgWXQUzDL0TZWwUOsqbf4pIktl4aONXOE8T+BCvMjoYUxF41cbxM/KbfwKPvrGUxtuLE7uTF9xMqTVpjaPymCyQoTY8DPaWqnA5R/UwPdxBhHhaeYG7t+CvMPgiTKoUTCHPlwRWfT04Jy9uiFDrg+MUYaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C25rLvTs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dep5ljMR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B9907A011C;
	Sun, 14 Sep 2025 22:16:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 14 Sep 2025 22:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757902574;
	 x=1757988974; bh=DmcGNYNHkMHCJpusBgTlvCnP5IiIbkrZP/NI+gd1x0g=; b=
	C25rLvTseoADMrmQinS16wWvAXjhYL2D5RIXZBByYtq3E5m/h1iEdWdL6UuaVzqY
	q10TPrveMLrEzMHAZmJ0+Mo6OiKDZjrUj+XI+o8k3zyyR9Hqg3is8x7ay5TsRELQ
	9C+H3EAguVi85SHF+WlKaDp/i0SdE++WUKsofxVWcTrQPXBqdqWNQD7kTwE1DyVf
	OWymO5M4gIz8m0yHaC33pVGDrhOsxrPJJ6HN/32qJb2o9HscnkSqjvhFkJxP6Vme
	W2+JyKRAptILtaJiBQwNlQ0vRSncPHm8jFYhUcYx7lOxelePsAipZQCTVO+P0xI6
	R50m7v2k8T6IfGaZr4tzFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757902574; x=1757988974; bh=D
	mcGNYNHkMHCJpusBgTlvCnP5IiIbkrZP/NI+gd1x0g=; b=Dep5ljMRix8GwHCNK
	NI3FEf8dzb8XpMY8bwowlBGFGEXWrhzi7kR0B4AvMG7ulrA3oTbcZM31doS23swI
	Bfz4sCLM5YF1P/vOzmuMHJmXcL8TzLLDOeu08G71XifJzCuzT+EFfo3bR00aXi3T
	m+/W6mT9WTovs0/gcKSgCVCEg1nWrhHvyPvoVdLpVo8yRIjD5998Vbc5ZtWLUnPJ
	MhIraCJh+sbyzXnyCVryyDNuR3kkQFDtbiGjtdFGIDTnQfX0nPWXSmqlHPVbIfJR
	0P0DJOLcdAB/vVEC52V4Ig3Dxs6elS79T3gW4qLSqgFUoJjmJwo5yAtluT9vYQin
	4SYdA==
X-ME-Sender: <xms:7nbHaMNSOHGXF4GhKxHI6aBXoQ4z3fxX1LVzVz_UUo3IthlYi0Yf9A>
    <xme:7nbHaKXlIkOe--2VhNbkLyLJTC8qee-YQZuSx_dHjxr_L5U5lyxnWDYUb6regAgzQ
    lIWj6RuwfSCMw>
X-ME-Received: <xmr:7nbHaI0JGLmdOCqfsPovrIm2HUmnJGYfhOslvaH7zxUbQGL4o7h7StPW7D1XFG87buoOvdfl0nbVp1Ejgx5h8K7povpouNUBd1S0D0oZB4OS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:7nbHaAqbEGdlpSsVn7lOGnqXZcuziky3xfCkwq2-06h4gOYMTCFkNg>
    <xmx:7nbHaHVtRPUmF5G5MZ4kwpuHfJIEMmph6sifRy64dQ2TB7Y7Eoh51w>
    <xmx:7nbHaDaNCo50dylzC81F7O-IpewtdG8aAKvp_Sp1qsLfyrw9XEBN_g>
    <xmx:7nbHaMcDckmsmkgnLmG27SNYHl3qOOsCcLogQO1J5jq6mXuqMwej_g>
    <xmx:7nbHaMEW_Z75tFnJ7CcTB7lZEY13Pj0MGoen4kWNsm7MsK2JB5sZsilB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:16:12 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
Date: Mon, 15 Sep 2025 12:13:43 +1000
Message-ID: <20250915021504.2632889-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915021504.2632889-1-neilb@ownmail.net>
References: <20250915021504.2632889-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

A rename operation can only rename within a single mount.  Callers of
vfs_rename() must and do ensure this is the case.

So there is no point in having two mnt_idmaps in renamedata as they are
always the same.  Only one of them is passed to ->rename in any case.

This patch replaces both with a single "mnt_idmap" and changes all
callers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    |  3 +--
 fs/ecryptfs/inode.c      |  3 +--
 fs/namei.c               | 17 ++++++++---------
 fs/nfsd/vfs.c            |  3 +--
 fs/overlayfs/overlayfs.h |  3 +--
 fs/smb/server/vfs.c      |  3 +--
 include/linux/fs.h       |  6 ++----
 7 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 91dfd0231877..d1edb2ac3837 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -387,10 +387,9 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
 		struct renamedata rd = {
-			.old_mnt_idmap	= &nop_mnt_idmap,
+			.mnt_idmap	= &nop_mnt_idmap,
 			.old_parent	= dir,
 			.old_dentry	= rep,
-			.new_mnt_idmap	= &nop_mnt_idmap,
 			.new_parent	= cache->graveyard,
 			.new_dentry	= grave,
 		};
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 72fbe1316ab8..abd954c6a14e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -634,10 +634,9 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_lock;
 	}
 
-	rd.old_mnt_idmap	= &nop_mnt_idmap;
+	rd.mnt_idmap		= &nop_mnt_idmap;
 	rd.old_parent		= lower_old_dir_dentry;
 	rd.old_dentry		= lower_old_dentry;
-	rd.new_mnt_idmap	= &nop_mnt_idmap;
 	rd.new_parent		= lower_new_dir_dentry;
 	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
diff --git a/fs/namei.c b/fs/namei.c
index e2c2ab286bc0..180037b96956 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5077,20 +5077,20 @@ int vfs_rename(struct renamedata *rd)
 	if (source == target)
 		return 0;
 
-	error = may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
+	error = may_delete(rd->mnt_idmap, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(rd->new_mnt_idmap, new_dir, new_dentry);
+		error = may_create(rd->mnt_idmap, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(rd->new_mnt_idmap, new_dir,
+			error = may_delete(rd->mnt_idmap, new_dir,
 					   new_dentry, is_dir);
 		else
-			error = may_delete(rd->new_mnt_idmap, new_dir,
+			error = may_delete(rd->mnt_idmap, new_dir,
 					   new_dentry, new_is_dir);
 	}
 	if (error)
@@ -5105,13 +5105,13 @@ int vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(rd->old_mnt_idmap, source,
+			error = inode_permission(rd->mnt_idmap, source,
 						 MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(rd->new_mnt_idmap, target,
+			error = inode_permission(rd->mnt_idmap, target,
 						 MAY_WRITE);
 			if (error)
 				return error;
@@ -5179,7 +5179,7 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
+	error = old_dir->i_op->rename(rd->mnt_idmap, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
@@ -5322,10 +5322,9 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
 	rd.old_parent	   = old_path.dentry;
 	rd.old_dentry	   = old_dentry;
-	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
+	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
 	rd.new_parent	   = new_path.dentry;
 	rd.new_dentry	   = new_dentry;
-	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index edf050766e57..aa4a95713a48 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1951,10 +1951,9 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out_dput_old;
 	} else {
 		struct renamedata rd = {
-			.old_mnt_idmap	= &nop_mnt_idmap,
+			.mnt_idmap	= &nop_mnt_idmap,
 			.old_parent	= fdentry,
 			.old_dentry	= odentry,
-			.new_mnt_idmap	= &nop_mnt_idmap,
 			.new_parent	= tdentry,
 			.new_dentry	= ndentry,
 		};
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bb0d7ded8e76..4f84abaa0d68 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -361,10 +361,9 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 {
 	int err;
 	struct renamedata rd = {
-		.old_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
+		.mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.old_parent	= olddir,
 		.old_dentry	= olddentry,
-		.new_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.new_parent	= newdir,
 		.new_dentry	= newdentry,
 		.flags		= flags,
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 04539037108c..07739055ac9f 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -770,10 +770,9 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out4;
 	}
 
-	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt),
+	rd.mnt_idmap		= mnt_idmap(old_path->mnt),
 	rd.old_parent		= old_parent,
 	rd.old_dentry		= old_child,
-	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt),
 	rd.new_parent		= new_path.dentry,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..73b39e5bb9e4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2008,20 +2008,18 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 
 /**
  * struct renamedata - contains all information required for renaming
- * @old_mnt_idmap:     idmap of the old mount the inode was found from
+ * @mnt_idmap:     idmap of the mount in which the rename is happening.
  * @old_parent:        parent of source
  * @old_dentry:                source
- * @new_mnt_idmap:     idmap of the new mount the inode was found from
  * @new_parent:        parent of destination
  * @new_dentry:                destination
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
 struct renamedata {
-	struct mnt_idmap *old_mnt_idmap;
+	struct mnt_idmap *mnt_idmap;
 	struct dentry *old_parent;
 	struct dentry *old_dentry;
-	struct mnt_idmap *new_mnt_idmap;
 	struct dentry *new_parent;
 	struct dentry *new_dentry;
 	struct inode **delegated_inode;
-- 
2.50.0.107.gf914562f5916.dirty


