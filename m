Return-Path: <linux-fsdevel+bounces-54574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F155AB00F90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCCA563A8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73652D3EE1;
	Thu, 10 Jul 2025 23:21:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF952D0C6D;
	Thu, 10 Jul 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189694; cv=none; b=s1KFHa2CEOBwtfTBYXuOStKdjIutei26OcJv9lYQI1l/ZlytW3Cx2HXnWbvHIk8OLO3SwlLivNAcHJ7e5WGVCZB4kEIDmRTNpg7kk+yieBKyyAjdWJLEfz3Z/qr7lgzFotMj5zZVci+Its6jloGiGPALonPu+RBR8pVl7RIsmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189694; c=relaxed/simple;
	bh=InDxxP5yHLfqSPzC6VuUYqpzf8pOlsERDM9lR85VT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJNyPBQMUSumKEZR2BvvaBtzp9s4PnNh+gbeFrW7gWp2hh5w4r5vkxdI0lP6ND2MZkKR53/t3STG5ELaDdFfBELmhRnbDYcFL0t9SCB2VWFIDWadlbLlsyD3SEwDz5+zEgnfFfEbRPz4mxShSHzozEV64ba5sxtNR27L5AcGcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zu-001XGm-OW;
	Thu, 10 Jul 2025 23:21:24 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/20] ovl: narrow locking in ovl_indexdir_cleanup()
Date: Fri, 11 Jul 2025 09:03:42 +1000
Message-ID: <20250710232109.3014537-13-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
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
 fs/overlayfs/readdir.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 2a222b8185a3..3a4bbc178203 100644
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
@@ -1210,7 +1209,9 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		}
 		/* Cleanup leftover from index create/cleanup attempt */
 		if (index->d_name.name[0] == '#') {
+			inode_lock_nested(dir, I_MUTEX_PARENT);
 			err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
+			inode_unlock(dir);
 			if (err)
 				break;
 			goto next;
@@ -1220,7 +1221,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			goto next;
 		} else if (err == -ESTALE) {
 			/* Cleanup stale index entries */
-			err = ovl_cleanup(ofs, dir, index);
+			err = ovl_cleanup_unlocked(ofs, indexdir, index);
 		} else if (err != -ENOENT) {
 			/*
 			 * Abort mount to avoid corrupting the index if
@@ -1233,10 +1234,12 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			 * Whiteout orphan index to block future open by
 			 * handle after overlay nlink dropped to zero.
 			 */
+			inode_lock_nested(dir, I_MUTEX_PARENT);
 			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
+			inode_unlock(dir);
 		} else {
 			/* Cleanup orphan index entries */
-			err = ovl_cleanup(ofs, dir, index);
+			err = ovl_cleanup_unlocked(ofs, indexdir, index);
 		}
 
 		if (err)
@@ -1247,7 +1250,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		index = NULL;
 	}
 	dput(index);
-	inode_unlock(dir);
 out:
 	ovl_cache_free(&list);
 	if (err)
-- 
2.49.0


