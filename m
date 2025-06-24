Return-Path: <linux-fsdevel+bounces-52826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ECAE72DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32196175164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264A25CC57;
	Tue, 24 Jun 2025 23:07:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E67201032;
	Tue, 24 Jun 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806440; cv=none; b=t1IVsOSPokhaBOqcXrlxV1++DK/ih4A6uKRd2jzUTtvjHHYpWtWtKXL+Q+zt/u/IriDkgSX8HE09eoiCa/DluqnFcY357NACHwM9fGdNQEmQmtSNM9mqef6sXCx+4Gj3HmQ12G5adFdxzUngX9Wd1ulii48oNlbzdLLXE4063eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806440; c=relaxed/simple;
	bh=bsfJROdtAjlIW86iEo/MBOWjWD2O1nIc4Yz1HN8ypN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzo53ABKJ3J2vbDOGnNclB7t9q31CEcicL0doCAPIu8ZeSm1kILWFdLswxdiiHob2xnva1yu6SKT6LserApptuJ8s+zQ/1l5riQz0E4qbfB/bW7ldw6UewNeTJ1xKm6h/P5WdTMXMX1RtGjz5smPo7b4c8R+wMDdS8tFLJy2uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjU-0045cb-GS;
	Tue, 24 Jun 2025 23:07:16 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] ovl: narrow locking in ovl_cleanup_whiteouts()
Date: Wed, 25 Jun 2025 08:55:04 +1000
Message-ID: <20250624230636.3233059-9-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
References: <20250624230636.3233059-1-neil@brown.name>
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


