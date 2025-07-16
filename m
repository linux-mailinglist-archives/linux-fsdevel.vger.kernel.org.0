Return-Path: <linux-fsdevel+bounces-55063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BEDB06AD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE961A624A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD781C5485;
	Wed, 16 Jul 2025 00:47:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264691BBBE5;
	Wed, 16 Jul 2025 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626863; cv=none; b=Dn8eaDrM5Npzbj2hVxjn1piXXORX8bCtO4jCPtfNeNLaV1J+EN2coPErGfyp+k5pUj5UcTBaQhfvSC3iy1UneyOF7768DHqLdfo1xRZGhRXLTkVHNwduss2CpVChoreGNAWW6AvwWkEHlfXwRXr/CiYS15NhhImNaVn/GAOjH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626863; c=relaxed/simple;
	bh=XI/g5MR64Q4hLKzrXUM7Q+B8570uP9ugX5gUDj5wlmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzCbQam3U0bnWxJHoQdeKAkz2UWSq5GP8KH9RDK4MrA3wX4uMKApf06FiG11YYkL+yMcIqRFAnN2zq5yhsuDCwLJqcBEzyUPfw0T04WaLVnOtspfoB6X09swFVmBjfZ2w1/7TLO4d8HKOEjk8+HR1ZJLGV85hSY2QcvhGAr6dLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ8-002ABk-Mn;
	Wed, 16 Jul 2025 00:47:40 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 16/21] ovl: narrow locking on ovl_remove_and_whiteout()
Date: Wed, 16 Jul 2025 10:44:27 +1000
Message-ID: <20250716004725.1206467-17-neil@brown.name>
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

This code:
  performs a lookup_upper
  creates a whiteout object
  renames the whiteout over the result of the lookup

The create and the rename must be locked separately for proposed
directory locking changes.  This patch takes a first step of moving the
lookup out of the locked region.  A subsequent patch will separate the
create from the rename.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index e81be60f1125..340f8679b6e7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -770,15 +770,11 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 			goto out;
 	}
 
-	err = ovl_lock_rename_workdir(workdir, NULL, upperdir, NULL);
-	if (err)
-		goto out_dput;
-
-	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
-				 dentry->d_name.len);
+	upper = ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upperdir,
+					  dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
-		goto out_unlock;
+		goto out_dput;
 
 	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
@@ -787,17 +783,18 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
 
-	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
+	err = ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
 	if (err)
-		goto out_d_drop;
+		goto out_dput_upper;
+
+	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
+	if (!err)
+		ovl_dir_modified(dentry->d_parent, true);
 
-	ovl_dir_modified(dentry->d_parent, true);
-out_d_drop:
 	d_drop(dentry);
+	unlock_rename(workdir, upperdir);
 out_dput_upper:
 	dput(upper);
-out_unlock:
-	unlock_rename(workdir, upperdir);
 out_dput:
 	dput(opaquedir);
 out:
-- 
2.49.0


