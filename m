Return-Path: <linux-fsdevel+bounces-57808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89740B256BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792D11C837DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC72F39D9;
	Wed, 13 Aug 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K32VlDM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C12FE07D;
	Wed, 13 Aug 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124664; cv=none; b=DuRVwRM4UZlurftH4568gZuqlP529bHK3a1n03e8Et8kuZxK5NPOAXkRbOmtucSQOQNV9O7gi9oV0HDeh+RNNVIxhrvSy7n4r2rzmwb2ahfzy6yfPUlPwkjSPjPcp1uLyO4hlHQcS+KsdIK36arzEEkFBwuEJeywGPL5dlV0PwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124664; c=relaxed/simple;
	bh=zF5JDnZ+HxHoDc0CabtkNEDh14LdUNdDD5WpssQR94I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nL4MCCzOFQXCWZUtLh03Za0KBX58ufARWIAm2X3QI9m5HmLPFMeozOK+rkz27p3SXyxbRWY1Lc9DqPBjaTunzpyWbhvt6Wi1gpwZu6wTWtdle8dIRdP6m3awef2zTiIUsG+CnchejCds+0RI/gJmQHrNtDofLSrLF0ar+bZfhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K32VlDM5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fCR/iJDoferAMv3I5VQIvoBSoPnnOy9/eTD/60JGY8s=; b=K32VlDM5hC5h3ppZrn0Fczc9gm
	y3zWuSi6JzNDgWxJGUSuqmSbvAKAxQIA8qPTNK/pgmXTDN4ioAIR5U66DPG3uxmEB02ROKk7JLGsk
	UgmYoy/06ErKseOXNYwP+c+QSQiMevSm1hOWCb4V6iYHSXsApoIcCbNP+a0BGYV9JLib324yZ3M33
	ijnnuPdkdHZiuTFu7H/lD7V5mKogOGGRZjEtdsKXucF5LEvN5D9hVE3Ty3tEY7dOduXSNo5+PVd6J
	Y8iQ5jlNp2x9Qya3LWOi0ls+HIpGhVH5EhA6lRgrkzreXKS+wzdThg9wCwfHbKBNKJOgv5dtSoc2w
	ELO7Qf4A==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK6E-00Ds0c-RR; Thu, 14 Aug 2025 00:37:39 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:43 -0300
Subject: [PATCH v4 7/9] ovl: Add S_CASEFOLD as part of the inode flag to be
 copied
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-7-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
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


