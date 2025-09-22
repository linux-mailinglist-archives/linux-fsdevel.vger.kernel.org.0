Return-Path: <linux-fsdevel+bounces-62360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F7B8EF0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BBD7A8270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174E1F3B98;
	Mon, 22 Sep 2025 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="kZUD2uCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TE2ysOaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2E1E0B86
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515615; cv=none; b=nHmf0PCUOGLSmAOm1opjqbAfUPDWXTsU17mAckcpR7w6HB/4Hd2JI9gWUkvusfqYzvNoMJq97c9PGl7Ad/xr837hVbhQaMMqBVW0OnPZsqDscTDt4JD4sQX2U6GarO40vDGpLgy2CJcJXqYW7u0XiwC4pMsSg83T0AdqDiymBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515615; c=relaxed/simple;
	bh=qaMQKs+ni/9z+tKkWDWHzH2/ji40cUTAJSW3c9uemec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBPbIhPHDudKYOATsOqHux/mIQKQCyTPVpVPnIGtNa3tZgvUmct6ZZ5vWrG7/c0lM8w1jR+47zyfD39NfJKVS2LEPp2F5XQBUkcQ6aL5CoM5O8WqaGwTVZhBNjsap1tI+hq7akFUz3+Znl//Ti8zty/TZzQFjFgl+PSAQUV8sbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=kZUD2uCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TE2ysOaw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 805ECEC008E;
	Mon, 22 Sep 2025 00:33:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 22 Sep 2025 00:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758515612;
	 x=1758602012; bh=DmcGNYNHkMHCJpusBgTlvCnP5IiIbkrZP/NI+gd1x0g=; b=
	kZUD2uCClzc40cphxSU/gEkFgKWrPbOnngkzvpw7uVA0egN3GAKqikghSSPOpORU
	lwQMBE7IJE7yHSFWbNw7WfBxx2yhSbo0fv1393YyH2buDnr5xCrlXXthFqJ9OnrM
	dr0bNLkSj1wqbrAOgCPgeJC9nvyIZVs+UiBwwpZ+bIuv9mZi3u83BBvd85qqU4I4
	8gKmrg5eGQEGA1mm5vBoiO90X+do0FR68y34TJt40u6zE5fqKZwAIIASmLqzHqfe
	lMjgs0lVo47fauPbHcXs4filh6n+ufP4MPLG73lSGlKEQKT2p6GcjIv35NcoFtx2
	ylDeb2jytNjGoKcteLzfRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758515612; x=1758602012; bh=D
	mcGNYNHkMHCJpusBgTlvCnP5IiIbkrZP/NI+gd1x0g=; b=TE2ysOawoOceOcAsn
	pieGWCUM63PasyyEngtgzGkW0lkF8BMmACN2fWqrDWWOSzh4WTb/J33nq4YHl1Lf
	L8BvbcXQZrnZ5rlPesDXIVwfQ4qIKbxnIcwsr5wFG/S7jXbVZoz7CQy+PbQ/3mp7
	z/r1nw332sz1vFvwkxjBqiWbPhcxD3kRHwbcA7jEdDeCW5vrTxmOL99hovhCIceA
	41W6ZySfiXklgK8KkrKRBY9ibiuj8X8RzxFlFi61ZiDP0YS+djjRPfVdEZMyvKu1
	mMYLL64R8PhYK5MBGW33bRCj31pYjdjAtjI8/Uz8Dl4zbeaLBUzLjpkt0WW4K+An
	TndEA==
X-ME-Sender: <xms:nNHQaFsQR50ReYvQOhhLnMTu2FeEdbZlFVjF1tGwLc_gK-bf8peH2w>
    <xme:nNHQaF0v4NvHj0-vucyeoj1lVnZ17pQpGpYilE0fX9EbABOl6ZfDnQSLiV9ngrH-2
    ziirmBdlIu5LA>
X-ME-Received: <xmr:nNHQaOW8i1ekk57n58w622xl7nqC3PqgskcYE0WNcLwC4Fp5YigX2GtANYVhl_AZkSYUESpfmZX9UPmtvRNCEm38umsHGQHCYScLQAhlKyic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:nNHQaIIHlXYmcmdDDVkLNdbqibwuLRRUXLfikwge6938yTAj6QYiLg>
    <xmx:nNHQaI1suphDsuPxr3L6eXVsQHznTcCUv1IDKSw6XEmyFKy6tX4hqw>
    <xmx:nNHQaG66lyTvpUuTtQr3zhHsAoNZd4is7kGxzD23fHcOrd4n8S8wHg>
    <xmx:nNHQaJ-UznnKk45Mogu3KEEmfbCnsD_VT0zMoorwYPVlJI6WCls6EQ>
    <xmx:nNHQaJlO6F4bRXVsSulrfhmiU8MWOf9Hqea1TVC1vtvgRXOycjFB8j9L>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:30 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 3/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
Date: Mon, 22 Sep 2025 14:29:50 +1000
Message-ID: <20250922043121.193821-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250922043121.193821-1-neilb@ownmail.net>
References: <20250922043121.193821-1-neilb@ownmail.net>
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


