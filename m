Return-Path: <linux-fsdevel+bounces-4682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4992801C8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17841C2091E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40703168BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FEcmzQh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D81124;
	Sat,  2 Dec 2023 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=F8PhHlQpw1agE8e4gUoZBwCoedJwGCZUllve+ZMs9lU=; t=1701514184; x=1702723784; 
	b=FEcmzQh0bsIjqk6r5t6yevD+khvz0zRxqI/Z8MWgdf23sUSCiyk43o3BM9PqKEyalOwcHEaIfyy
	DNZqH03AVZbpgEk4oCoBqxwRY2mNAAxwTw16oCn72GLqUUSAXhPbWi3/3VqqAwEHwu1/RQvFryYBs
	ufe1zCpDMIve+8rsG6ZlGl1hLz8wLrUmHMB+qzi48aIisx7DEF6p66nVf/gi0N+aMHsoxuhtWEW2F
	dh9SEIR/hNoPEqpYmm6isFSsDvFaUCCVLarxGQocf26lQBR91jv7djvLD0e7wG6MIjLzOXrZ4omev
	eTAXFa37SnH+v2NgaSEiisljkw/WWrkNh1fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9NZ7-0000000CR3d-3PqU;
	Sat, 02 Dec 2023 11:49:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] Revert "debugfs: annotate debugfs handlers vs. removal with lockdep"
Date: Sat,  2 Dec 2023 11:49:37 +0100
Message-ID: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit f4acfcd4deb1 ("debugfs: annotate debugfs handlers
vs. removal with lockdep"), it appears to have false positives and
really shouldn't have been in the -rc series with the fixes anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c     | 10 ----------
 fs/debugfs/inode.c    |  7 -------
 fs/debugfs/internal.h |  6 ------
 3 files changed, 23 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a5ade8c16375..5063434be0fc 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -108,12 +108,6 @@ int debugfs_file_get(struct dentry *dentry)
 			kfree(fsd);
 			fsd = READ_ONCE(dentry->d_fsdata);
 		}
-#ifdef CONFIG_LOCKDEP
-		fsd->lock_name = kasprintf(GFP_KERNEL, "debugfs:%pd", dentry);
-		lockdep_register_key(&fsd->key);
-		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
-				 &fsd->key, 0);
-#endif
 		INIT_LIST_HEAD(&fsd->cancellations);
 		mutex_init(&fsd->cancellations_mtx);
 	}
@@ -132,8 +126,6 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!refcount_inc_not_zero(&fsd->active_users))
 		return -EIO;
 
-	lock_map_acquire_read(&fsd->lockdep_map);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(debugfs_file_get);
@@ -151,8 +143,6 @@ void debugfs_file_put(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd = READ_ONCE(dentry->d_fsdata);
 
-	lock_map_release(&fsd->lockdep_map);
-
 	if (refcount_dec_and_test(&fsd->active_users))
 		complete(&fsd->active_users_drained);
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e4e7fe1bd9fb..034a617cb1a5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -243,10 +243,6 @@ static void debugfs_release_dentry(struct dentry *dentry)
 
 	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
 	if (fsd && fsd->real_fops) {
-#ifdef CONFIG_LOCKDEP
-		lockdep_unregister_key(&fsd->key);
-		kfree(fsd->lock_name);
-#endif
 		WARN_ON(!list_empty(&fsd->cancellations));
 		mutex_destroy(&fsd->cancellations_mtx);
 	}
@@ -755,9 +751,6 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	lock_map_acquire(&fsd->lockdep_map);
-	lock_map_release(&fsd->lockdep_map);
-
 	/* if we hit zero, just wait for all to finish */
 	if (!refcount_dec_and_test(&fsd->active_users)) {
 		wait_for_completion(&fsd->active_users_drained);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 0c4c68cf161f..dae80c2a469e 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -7,7 +7,6 @@
 
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
-#include <linux/lockdep.h>
 #include <linux/list.h>
 
 struct file_operations;
@@ -25,11 +24,6 @@ struct debugfs_fsdata {
 		struct {
 			refcount_t active_users;
 			struct completion active_users_drained;
-#ifdef CONFIG_LOCKDEP
-			struct lockdep_map lockdep_map;
-			struct lock_class_key key;
-			char *lock_name;
-#endif
 
 			/* protect cancellations */
 			struct mutex cancellations_mtx;
-- 
2.43.0


