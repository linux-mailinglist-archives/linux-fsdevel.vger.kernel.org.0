Return-Path: <linux-fsdevel+bounces-60612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91575B4A0E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B061BC2493
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669F2ECEBC;
	Tue,  9 Sep 2025 04:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="L0Byf8wh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWGmiQCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583A2E2851
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393321; cv=none; b=P3jIta1hbO3DFxHmsoSPID2MNAqU9fS+UxgA7jyEuyJZ/+A8aNtsvQfZ8KXszT0TnJACHawNMdmbzFbDRLGZRgNLG+6w6pLbMhcCvZMbZzTp0tjY4HvoE/E3j0+vDMvGtiztI5RQTon4PU8c4gA2z+13WIsPC4/l8X0IlfnIP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393321; c=relaxed/simple;
	bh=qaMQKs+ni/9z+tKkWDWHzH2/ji40cUTAJSW3c9uemec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuslUmwhSOp87YBFjw/TSZUD8kWMMqSqxmQgaMpXyy8PrWPCkuJFeHJ2SxvARSPKN3EgbcX4u6jES1sK5mqUXNH0X+9xLeONuSzAyqpFsF5iZ02jT9vhsGFrwM1sHjfoX10pZwdGiNG5H+pTHUwgoV1CpFGvLEFyxB8unN57qQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=L0Byf8wh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWGmiQCI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 59DF91D000D3;
	Tue,  9 Sep 2025 00:48:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 09 Sep 2025 00:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757393318;
	 x=1757479718; bh=DmcGNYNHkMHCJpusBgTlvCnP5IiIbkrZP/NI+gd1x0g=; b=
	L0Byf8whNjLP1bcI+WNY7nl4J86vNWfE8teQQXvt2ipWa/plO1tevkJgdALEDZPs
	8aX9iDyJ3inIZG4gcD9bbaJiOHJVYxxuvN6jMvVPpeYas1vu25yhmzB6ffytdtjk
	ldONE34kSGtRStaOivhe8SPFztQEZWKR54WzjIWcvBNyKs4wMmek0GF4y0dfwGui
	cZGAATUmvr5ZPi+eCZ1HCl1/EyRWPmCGpCHl+AkpyBca+Jsyo76dtAlLKSSZab54
	dktWd2qgFTP6SOEo4J2WgDra2Giy0JZDKtHWaSItS4GhF9dDMlOotTbHtMgwf4Ex
	u0UqtYWDeJAQAXFR2zCicA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757393318; x=1757479718; bh=D
	mcGNYNHkMHCJpusBgTlvCnP5IiIbkrZP/NI+gd1x0g=; b=IWGmiQCImoOytiZlz
	dpNzu6CshXAH3jPYZbBIq9d7Das3BaXm/+dBui/KkTEsDf2/XEjf3LfBPGIQgeSx
	W6ssbMSO0JF9CNG4sBVnMSu/syRHwpi4pC1f7J0L4qdq2xJQNTPba/XVWxyZo1Sj
	MfFcvyUex4oi1aalAuEzjhMfpI/U9qcdj44oPA/+ldWUrY2oys7cJdpiJWdl7VLm
	4BtNgzqeYfTjopHz+iAn4Dd3Rdjdq+J+9J7zkX4HDtohgKXTpkhwXMwCIC46EZb2
	FTph1+T2CwcoWRjUj/gn13myH8R6ujbQdQB+9sVsR1wcPE6ddiZbzXjATu2eVRsp
	FTO6w==
X-ME-Sender: <xms:pbG_aIAS1f0Bv2QDdRRT5EuF-FJIDKZQqvzwDWij7JCVm_uBQyjKRw>
    <xme:pbG_aMzkJY-zjC66RdimLh5p-5AGvxcmcW7nq1CK4-CVVMu8eP6tcVOiUjOe4gSID
    Zesq7jS2OB_Kg>
X-ME-Received: <xmr:pbG_aN2OBb4lOKrvchWLoS5vrH8rmrK4MOaQmdf0w10vNbnpNMdmHS5R9rPKVqHGEHjWtbT4QJbHldPXEqszXPVH0bsyAxja2VoJKkJs3fL2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeglecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pbG_aEzQI89WOy7buNFPyUQ93e8vNvSSPHe_LFdTJCrkFSmU0HSbng>
    <xmx:prG_aMHMKJXMByfmg7oGFK5KvToaBQzrN_IeKZAvUogHE86RFWO-xw>
    <xmx:prG_aPbzjZxNPbohazSF9dmWdHYUVk7_p8k0LELgrXog7UNsvKjHrQ>
    <xmx:prG_aGA_QuA9ssldGMk3w_wYl2tk4KrHEgv6xurTVxbMHyp0o_OVPw>
    <xmx:prG_aPb5us1HziYNQe9kPYvAFwR5bgv53C4Wu1WS4wO_KIqTxQiL8uZI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 00:48:35 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/7] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
Date: Tue,  9 Sep 2025 14:43:17 +1000
Message-ID: <20250909044637.705116-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250909044637.705116-1-neilb@ownmail.net>
References: <20250909044637.705116-1-neilb@ownmail.net>
Reply-To: neil@brown.name
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


