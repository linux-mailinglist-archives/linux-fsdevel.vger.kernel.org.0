Return-Path: <linux-fsdevel+bounces-57938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AAB26DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7627FAA7370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28833090DD;
	Thu, 14 Aug 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cqKFjRdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670A307AC0;
	Thu, 14 Aug 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192168; cv=none; b=fE5RGpqQbt8dfIA4uFki5/oKWhpOTKMx8Bw2u671a6KqOZb5sUZ2MLcpwwl22eq8KfQMbTyASQXq1MB/tUq72c0DhrWIDWHpMlv9RMxAo54OCR0EWfJB4APa3lXvv929cYv+3De+Xo2RE7E41weOIo+/X7pmLhlknTbcm7+cKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192168; c=relaxed/simple;
	bh=UZt79rZJ5DV3HNqrD/O1r33mIPK4oZ0wusIEeCj07Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/Nzf6SMzWFRbfAda+ibUlL/TZKECc+q1KW/rXfRnLDXDjvsDBywP9Ahg0iXp/ZvursK0PNc+YVD0aQ/z1x59gAN/Y/Aa24cxYEUY43ROenwJzTn3lQ0ncdupyQC0B7xfPlfA2Of0YimnAd6bp6xX4eoMCJXw/2FGDY7PjeyI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cqKFjRdo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sEJRQfROVC0Ok9/T67kIvrAW0iXrwsfMs4pZMXWWVu4=; b=cqKFjRdool9OfQoT6szn67+XUF
	aclj9GXjWvCO+R5/YUOjIPW7gtZnIts5XmSTh5YC8r0P0AOzs8Gt/Y8K7eFIj/YoH/lQPAZcUrIpY
	CmiIaXGtTFjHOJ07cc6wZsPrO2wLBDT9Q6hUcaFQv58Cos9ARtVTYF0mBPPe7vy3KbmNhBx+DVUtV
	+WR4sBs5rksWh/6f/sUF2E5gDeMyxWWaaYtSEs0HjCpQvlQzWv+Dc7oDPvASDNwWfvCS6vbllTqLj
	TsWhfEtMlOXk8DohH2RzgQoX5TIIG6lN/AOfI0AtOFOe76S2wzkGyhiTaQaIkyKp7VpaMpPJsCfJP
	TDohkKZQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbez-00EDyT-Lk; Thu, 14 Aug 2025 19:22:41 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:18 -0300
Subject: [PATCH v5 7/9] ovl: Add S_CASEFOLD as part of the inode flag to be
 copied
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-7-c5b80a909cbd@igalia.com>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To keep ovl's inodes consistent with their real inodes, create a new
mask for inode file attributes that needs to be copied.  Add the
S_CASEFOLD flag as part of the flags that need to be copied along with
the other file attributes.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
Changes from v3:
- Create new flag OVL_FATTR_I_FLAGS_MASK for the file attributes and add
  S_CASEFOLD in the OVL_COPY_I_FLAGS_MASK.
- Add WARN()s to check for inode consistency
- Add check for copied up directories

Changes from v2:
- Instead of manually setting the flag if the realpath dentry is
  casefolded, just add this flag as part of the flags that need to be
  copied.
---
 fs/overlayfs/copy_up.c   | 2 +-
 fs/overlayfs/inode.c     | 1 +
 fs/overlayfs/overlayfs.h | 8 +++++---
 fs/overlayfs/super.c     | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 27396fe63f6d5b36143750443304a1f0856e2f56..66bd43a99d2e8548eecf21699a9a6b97e9454d79 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -670,7 +670,7 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	if (err)
 		return err;
 
-	if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
+	if (inode->i_flags & OVL_FATTR_I_FLAGS_MASK &&
 	    (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
 		/*
 		 * Copy the fileattr inode flags that are the source of already
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ecb9f2019395ecd01a124ad029375b1a1d13ebb5..aaa4cf579561299c50046f5ded03d93f056c370c 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1277,6 +1277,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	}
 	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
 	ovl_inode_init(inode, oip, ino, fsid);
+	WARN_ON_ONCE(!!IS_CASEFOLDED(inode) != ofs->casefold);
 
 	if (upperdentry && ovl_is_impuredir(sb, upperdentry))
 		ovl_set_flag(OVL_IMPURE, inode);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bb0d7ded8e763a4a7a6fc506d966ed2f3bdb4f06..50d550dd1b9d7841723880da85359e735bfc9277 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -821,10 +821,12 @@ struct inode *ovl_get_inode(struct super_block *sb,
 			    struct ovl_inode_params *oip);
 void ovl_copyattr(struct inode *to);
 
+/* vfs fileattr flags read from overlay.protattr xattr to ovl inode */
+#define OVL_PROT_I_FLAGS_MASK  (S_APPEND | S_IMMUTABLE)
+/* vfs fileattr flags copied from real to ovl inode */
+#define OVL_FATTR_I_FLAGS_MASK (OVL_PROT_I_FLAGS_MASK | S_SYNC | S_NOATIME)
 /* vfs inode flags copied from real to ovl inode */
-#define OVL_COPY_I_FLAGS_MASK	(S_SYNC | S_NOATIME | S_APPEND | S_IMMUTABLE)
-/* vfs inode flags read from overlay.protattr xattr to ovl inode */
-#define OVL_PROT_I_FLAGS_MASK	(S_APPEND | S_IMMUTABLE)
+#define OVL_COPY_I_FLAGS_MASK  (OVL_FATTR_I_FLAGS_MASK | S_CASEFOLD)
 
 /*
  * fileattr flags copied from lower to upper inode on copy up.
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a99c77802efa1a6d96c43019728d3517fccdc16a..7937aa4daa9c29e8b9219f7fcc2abe7fb55b2e5c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1335,6 +1335,7 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
+	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
 	/* root keeps a reference of upperdentry */
 	dget(upperdentry);

-- 
2.50.1


