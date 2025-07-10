Return-Path: <linux-fsdevel+bounces-54570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C8B00F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54641CA3643
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F582D3A6A;
	Thu, 10 Jul 2025 23:21:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AC2C15B0;
	Thu, 10 Jul 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189692; cv=none; b=F4vs/unduqq94fkXanEzNGpkPhyq1j7+UmtsTJFQrK/AE6HCaxrrAJg/qtY0D3PKgmifykrclMflvj0OqAC9R/GzEUPLKMYle20oVjCzTsnx7e8DehbD2AmJFj4NKtCpIYVOHYgYzQBocDjkpK5sCxstM6KyDSrLTbIG32YlXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189692; c=relaxed/simple;
	bh=t6rNcM2Mrk8jSgNeFGuvGiEydXKLNrVReYRKGHDkMB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYU69IIfNymOUXi5CuVJ1AuCoHhSyuGXucfs1IhQdJM7y+w2KFMFdejrpkZVKNyVhA8PWV9dX94mrWk/z6j6hpVi4tZrgxfd3Tps82faOzVsJi/RPYBgMpu7cpY6gpJJ+PgzR3aQUb9HpVJKhCr/jvT9vKuBnmSm0UJtivPbvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zt-001XGU-Cr;
	Thu, 10 Jul 2025 23:21:23 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/20] ovl: narrow locking in ovl_cleanup_whiteouts()
Date: Fri, 11 Jul 2025 09:03:39 +1000
Message-ID: <20250710232109.3014537-10-neil@brown.name>
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

Rather than lock the directory for the whole operation, use
ovl_lookup_upper_unlocked() and ovl_cleanup_unlocked() to take the lock
only when needed.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/readdir.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 68cca52ae2ac..2a222b8185a3 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1034,14 +1034,13 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
 {
 	struct ovl_cache_entry *p;
 
-	inode_lock_nested(upper->d_inode, I_MUTEX_CHILD);
 	list_for_each_entry(p, list, l_node) {
 		struct dentry *dentry;
 
 		if (WARN_ON(!p->is_whiteout || !p->is_upper))
 			continue;
 
-		dentry = ovl_lookup_upper(ofs, p->name, upper, p->len);
+		dentry = ovl_lookup_upper_unlocked(ofs, p->name, upper, p->len);
 		if (IS_ERR(dentry)) {
 			pr_err("lookup '%s/%.*s' failed (%i)\n",
 			       upper->d_name.name, p->len, p->name,
@@ -1049,10 +1048,9 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
 			continue;
 		}
 		if (dentry->d_inode)
-			ovl_cleanup(ofs, upper->d_inode, dentry);
+			ovl_cleanup_unlocked(ofs, upper, dentry);
 		dput(dentry);
 	}
-	inode_unlock(upper->d_inode);
 }
 
 static bool ovl_check_d_type(struct dir_context *ctx, const char *name,
-- 
2.49.0


