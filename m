Return-Path: <linux-fsdevel+bounces-55060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C774B06ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CA31713E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF51B4247;
	Wed, 16 Jul 2025 00:47:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755971946A0;
	Wed, 16 Jul 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626861; cv=none; b=LCn7EtBclWLAC5Ue/L6BiU6IyfWo9b+3XHKL4uagkXRFsu3Dsip4lg5npximUVzcnTv2Fn7pSNG64/YpFno/uWOUBR/IUqNML/6MlrmkBnKpCt5dSBWj983riTSpbmACyoG3rr3kY9nm/iv8YqHiQSZ8pr613+By28GHYq0Y2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626861; c=relaxed/simple;
	bh=4IswhXGO0eV10HV44GqBl/Gt5Sg5O6kNSwcvIOjRAjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5Rnq2Zs2D1KFEDKr7J0S8PqlqtqNS/xJfP0fv3XpKUVCmSzOFPf2CDLFdE1vL7MKaXOWLYy42n9Mplle8Qlt5LQAWcte7XDiST4A+Di2qhk0zqxIjIj+4xOfHxqJvN2RvDaX835540Y+7V2mB8230O9f/nWSK0JGGKyPab8vwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ6-002ABS-4o;
	Wed, 16 Jul 2025 00:47:37 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/21] ovl: narrow locking in ovl_indexdir_cleanup()
Date: Wed, 16 Jul 2025 10:44:24 +1000
Message-ID: <20250716004725.1206467-14-neil@brown.name>
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

Instead of taking the directory lock for the whole cleanup, only take it
when needed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/readdir.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 2a222b8185a3..95d5284daf8d 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1194,7 +1194,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	if (err)
 		goto out;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 	list_for_each_entry(p, &list, l_node) {
 		if (p->name[0] == '.') {
 			if (p->len == 1)
@@ -1202,7 +1201,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			if (p->len == 2 && p->name[1] == '.')
 				continue;
 		}
-		index = ovl_lookup_upper(ofs, p->name, indexdir, p->len);
+		index = ovl_lookup_upper_unlocked(ofs, p->name, indexdir, p->len);
 		if (IS_ERR(index)) {
 			err = PTR_ERR(index);
 			index = NULL;
@@ -1210,7 +1209,11 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		}
 		/* Cleanup leftover from index create/cleanup attempt */
 		if (index->d_name.name[0] == '#') {
-			err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
+			err = ovl_parent_lock(indexdir, index);
+			if (!err) {
+				err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
+				ovl_parent_unlock(indexdir);
+			}
 			if (err)
 				break;
 			goto next;
@@ -1220,7 +1223,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			goto next;
 		} else if (err == -ESTALE) {
 			/* Cleanup stale index entries */
-			err = ovl_cleanup(ofs, dir, index);
+			err = ovl_cleanup_unlocked(ofs, indexdir, index);
 		} else if (err != -ENOENT) {
 			/*
 			 * Abort mount to avoid corrupting the index if
@@ -1233,10 +1236,14 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			 * Whiteout orphan index to block future open by
 			 * handle after overlay nlink dropped to zero.
 			 */
-			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
+			err = ovl_parent_lock(indexdir, index);
+			if (!err) {
+				err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
+				ovl_parent_unlock(indexdir);
+			}
 		} else {
 			/* Cleanup orphan index entries */
-			err = ovl_cleanup(ofs, dir, index);
+			err = ovl_cleanup_unlocked(ofs, indexdir, index);
 		}
 
 		if (err)
@@ -1247,7 +1254,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		index = NULL;
 	}
 	dput(index);
-	inode_unlock(dir);
 out:
 	ovl_cache_free(&list);
 	if (err)
-- 
2.49.0


