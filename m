Return-Path: <linux-fsdevel+bounces-58822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D2DB31B47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4003A5A3E4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8203126B3;
	Fri, 22 Aug 2025 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Id+XILnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA691311C3E;
	Fri, 22 Aug 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872262; cv=none; b=RCRvTqD9iWx8DppYswq0IrVCxOb3HBfuPg1uPPLqxekzvxPn1yvtmI26A/83sxPu52x7kdd/RwpAS+njyMZUvP3DwjE8wNTmWiOPKZ76QmZgnpII5lKnxu3YJNE+KEOFmlovabNLwZbmVcbcABokVTv56tRTsvUHE6TyJfMfMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872262; c=relaxed/simple;
	bh=gKdPhfzVzGjRylFzqfw/FU1dI1xjEdmRHEslruJwZM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9uSmcVeYlry5eZvX1l1SK22NAKQkJUSLK6riq/TYfY+eR1ciLR3gehdIhrsiMCyZXLiAg3+9oacjhT2wKzrUpL9Bug0OE+uXeL3iFBM6lYtPjnLcg+AwuCiQPp5upTWX4SpGuyTUz4LnWu55PXx7//ZKdRJdYGoGnL6rr/q/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Id+XILnV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FvK6Hsm1/2OFiKohVwzkFGf+hjsAiPyR3cbDJE33s2M=; b=Id+XILnVLDO3A45YIwBRaDqBq4
	hcaEtuZvrW8FhNJrbXzsU1/JscsvnKnyaUWf3hIzhYgWUDDIPkNCetlfI2g2Png/14uHj9QsA8XdO
	oHmEyTB7nfmeq92SBqk2N3NgPD4XPYEYQRw9M5lcLyocYgmijiovEbNLRqwzkBIPAjAYz3DXKtw8Z
	apg6eND8slj3Wgrt+1rS/DVYU/WYqGQNG5pIXjQ89M/hJZl0CuzkcjaiZ+Ir2s1olJfNqAZXJVTki
	h6bM0raRX3RVfUIuxPDUToqsdorO6ZAcLonLW7YTM7VA+Tq77SIBsb0Gye+CBn1RbU3+324tksFNS
	trdPV1cw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSaF-0008Fn-DD; Fri, 22 Aug 2025 16:17:35 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:10 -0300
Subject: [PATCH v6 7/9] ovl: Add S_CASEFOLD as part of the inode flag to be
 copied
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-7-8b6e9e604fa2@igalia.com>
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
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
index 8db4e55d5027cb975fec9b92251f62fe5924af4f..f5fce0a67ed5ea4de56462cab56f82ba7a020c84 100644
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


