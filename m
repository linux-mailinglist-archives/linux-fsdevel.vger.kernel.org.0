Return-Path: <linux-fsdevel+bounces-55057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56156B06AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700043BDCCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E251A9B24;
	Wed, 16 Jul 2025 00:47:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090521A239A;
	Wed, 16 Jul 2025 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626859; cv=none; b=r/Qm0CCiuTER4CPNsfqfPGhwLeZ8kdCk/m5SzbUC8KWRmm/2eOEGgs1vobbEhV/lGg3J1Ow1ihX3J+tLfGzbHdIVIbeCnUfbuKBZxRvOcAk3GXfvgDtZzNj/fQybCIF9guOF+2VV3GUQWZyejCjbEfI3K2pR1kegnWJJvvfn1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626859; c=relaxed/simple;
	bh=Z3HqspT2JxawNktWBWEcsQs9ty5Icy4vJeirqknBlp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGUV/zlHfX5EBYJ0J2yISsmV7YEdR7cDOCsaSnGJWmQYTBvVgxoxo/5JEmm+/rXf8N3WSPOYq9wi7/6ApnSdR57+FCg9ECPQ15akGpVMEdAT+ZCtaHpecEYW8/5TfMzcBdCoKSmG3gU75Pr4jmIh7bFxsob6fgH1ibN6t6JHgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ4-002ABE-Gm;
	Wed, 16 Jul 2025 00:47:36 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/21] ovl: narrow locking in ovl_cleanup_index()
Date: Wed, 16 Jul 2025 10:44:22 +1000
Message-ID: <20250716004725.1206467-12-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
References: <20250716004725.1206467-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl_cleanup_index() takes a lock on the directory and then does a lookup
and possibly one of two different cleanups.
This patch narrows the locking to use the _unlocked() versions of the
lookup and one cleanup, and just takes the lock for the other cleanup.

A subsequent patch will take the lock into the cleanup.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/util.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index fc229f5fb4e9..b06136bbe170 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1071,7 +1071,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
-	struct inode *dir = indexdir->d_inode;
 	struct dentry *lowerdentry = ovl_dentry_lower(dentry);
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *index = NULL;
@@ -1107,21 +1106,22 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		goto out;
 	}
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
+	index = ovl_lookup_upper_unlocked(ofs, name.name, indexdir, name.len);
 	err = PTR_ERR(index);
 	if (IS_ERR(index)) {
 		index = NULL;
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
-		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
-					       indexdir, index);
+		err = ovl_parent_lock(indexdir, index);
+		if (!err) {
+			err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
+						       indexdir, index);
+			ovl_parent_unlock(indexdir);
+		}
 	} else {
 		/* Cleanup orphan index entries */
-		err = ovl_cleanup(ofs, dir, index);
+		err = ovl_cleanup_unlocked(ofs, indexdir, index);
 	}
-
-	inode_unlock(dir);
 	if (err)
 		goto fail;
 
-- 
2.49.0


