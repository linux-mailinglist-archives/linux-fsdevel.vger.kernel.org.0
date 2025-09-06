Return-Path: <linux-fsdevel+bounces-60409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FDFB46927
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BCF1D20823
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA318C034;
	Sat,  6 Sep 2025 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HP7set+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8+IMnvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AE261B9B
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134870; cv=none; b=Qf6iLjWkhqwOBtfMyZ6bAy5QJjF6p+eMOgPfBefw89sjGi8JvE717PsnCsXY+9cNex4q0co/I1ZeiU0tjFLgM7CoT6OJyW9oXdW7cm3hJm1RE4fD4EBoEu7BsV3aAvHHhjIm7pkc75t8NPkHd2e87vMaWkSJ4AvvO0FL7FLxW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134870; c=relaxed/simple;
	bh=0OQNih4BrVIqY8oE2EA3FB2do3tqZnFuZicgX1Kef+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEo1HqC7W5fYmbSfSVIJRbhp4ktH7rs92blEtm5HHLcPgeJMCQuKCOAmhxwm8QE6gf60ncisaMAx5BL/vqs9iT8PRBrv2E/az8PkTg++Ri/WH8RGpkksjF+suQJzyqsvtH/gFD4+qdwL6kbfv49OPva7aVAoKnuoE4r1n9WRz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HP7set+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8+IMnvj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC1A57A0390;
	Sat,  6 Sep 2025 01:01:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 06 Sep 2025 01:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757134867; x=
	1757221267; bh=s4UkAjzdDzCdTXPkk5WdH1guG8dFARRJ4yJwoZOyrwY=; b=H
	P7set+B6iQVhtSi7VM1QYLwf5/JEc/tPnu5CCKPFdZr98KWtC7qFoEt6puEFD6q1
	h700ipq6rWk8T5QNVmfZzC3eGVo9ChpKx7osyjPMxKVAykRxXNWWoUEy+c+zCmWI
	4qLfd+O8rnVskC6jImrfpyWvR/xYX/LJE3CfOTgbwabjRDrf73PPv/r56jm8wlP/
	1g7q//Q1SmjABxxKt+ye3Fs9KXyvZpzLtS9HiV661UsPIWf+dvOJOkSMvPvNoEML
	mXeqZ9Af6lyNahIHM7oaKJ4/GBC7+UWTIF3KVQA1r+QtwJXKVi1L4LQ3FbbRw2i5
	0VJWUAlY58wryNal/d/tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757134867; x=1757221267; bh=s
	4UkAjzdDzCdTXPkk5WdH1guG8dFARRJ4yJwoZOyrwY=; b=f8+IMnvjdqyj5F/nv
	RupDCYn3WmbeRPtSgbB1VxOckmONtae9smLdp7wCH4U4rEZ7nHT/yP0dTWrt0Cpb
	XaLgxkC2K0aPtiyMXgdKgRPwHJrOtxso7RbWQmcdKE9UbG7RhOMNAkta0UZmstph
	0w4yGjqmp/MEJsy9Mhuc6O/tYZTznH05CgqW4mWnBwRc6REmgf55iJ9s0YzcjWvS
	KfuZyTu9jta7gR7f0vziniNVDgNLmbWGX1aelmJ75QfETaUDgkcuMU7pjI5oKNL8
	2Xg/fmS8Ps4mbeCUOKg4a1cloTADfN64t5lCM6/wOFZKlWuxRoIzGe5Osm0+EmQE
	Jnv4Q==
X-ME-Sender: <xms:E8C7aBLmwChzDxNtMCbyQs9yCsfzB0L3DlYq2ge0pg6so-PTCzKHmw>
    <xme:E8C7aLFpp7NAjaR7cu-XWQSAvJiiFXhK_2bx1SoST5cVFTsBhbOhVt3v6rMgBQUNI
    QUEx2Y2Ory0uA>
X-ME-Received: <xmr:E8C7aMBH2stxcNu5Rf-0yCWXWewTmMyN9IQyFd3hCZlOYw-ynlZ7nsV7L2p5eujxal5YLcoXDB6n1gP7_lyMGvZ8pIdtHsevounVXOtc1Onl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
    ekvdehhfegtddufffhjeehfeeiueffgeeltdeuhefhtdffteejtdejtedvjeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:E8C7aG9nKtaFWijPQ23WtDzTJVDiDbbMbBDgbWViTzpjSlRJLTh59A>
    <xmx:E8C7aAA0Pcn4haK6SxeZTDMCyde_oUdfI9JiTIGliP4gA9UJS3Rn_A>
    <xmx:E8C7aDTzPAIQEJfkiV8aaSoHfKD1bhI2EOZ64RaCRKVAVokTEupnyw>
    <xmx:E8C7aPtjlJFvd0xJJT_YIc-Uqq5nyc4Dqe2SnBa-_0cGiQdpUT2n_g>
    <xmx:E8C7aONRYwLrdlPMXHtL1i6LKBMGNgYosoZjoo-Ustrr9VIDdFtZyh4j>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:01:05 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
Date: Sat,  6 Sep 2025 14:57:08 +1000
Message-ID: <20250906050015.3158851-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250906050015.3158851-1-neilb@ownmail.net>
References: <20250906050015.3158851-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

A rename can only rename within a single mount.  Callers of vfs_rename()
must and do ensure this is the case.

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
index a8d9fa44f2bf..8b065dbca2ab 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5076,20 +5076,20 @@ int vfs_rename(struct renamedata *rd)
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
@@ -5104,13 +5104,13 @@ int vfs_rename(struct renamedata *rd)
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
@@ -5178,7 +5178,7 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
+	error = old_dir->i_op->rename(rd->mnt_idmap, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
@@ -5321,10 +5321,9 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
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


