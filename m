Return-Path: <linux-fsdevel+bounces-54573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391AB00F92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348221CA37AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260E2D3EDD;
	Thu, 10 Jul 2025 23:21:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407392D23B6;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189693; cv=none; b=ab6xN00VZqFFpb7KjNC6q0Q364op153Bk7B4jVvrPf0a3Ixj7qDRMmU/Hf4CZyrcN+QvaP84KjPM8TWbrhkghlhC8JoOTHjWmtxX0WK6oJvFkkBzLVXkdzuUJOGmtnrJQ54EY3ySFayY1+z7+R7Tlu4RnhhEi7Iq4KXhYTi6rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189693; c=relaxed/simple;
	bh=Ps0U/+0i98nWDLoi7YkqfnRtlXbgNmKUa0uPpoZBWOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOuHd2pMtZAtQd9o6aTIV8aghHVxUNL3SRST11TbO9FDfkXjkinfdkA5ozk/4Vn9Qyt195je7eRGMVu9bVnWrgZYm+/HBOTKKMtT5eq/WOY7m7NelIVs0KBrqtcfXq9lWgq/aZRvOMrMvAbnmQ++MgSITH0FzXDWPcMgCH9ApHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zv-001XGs-6O;
	Thu, 10 Jul 2025 23:21:24 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/20] ovl: narrow locking in ovl_workdir_cleanup_recurse()
Date: Fri, 11 Jul 2025 09:03:43 +1000
Message-ID: <20250710232109.3014537-14-neil@brown.name>
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

Only take the dir lock when needed, rather than for the whole loop.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/readdir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 3a4bbc178203..b3d44bf56c78 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1122,7 +1122,6 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 	if (err)
 		goto out;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 	list_for_each_entry(p, &list, l_node) {
 		struct dentry *dentry;
 
@@ -1137,16 +1136,18 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 			err = -EINVAL;
 			break;
 		}
-		dentry = ovl_lookup_upper(ofs, p->name, path->dentry, p->len);
+		dentry = ovl_lookup_upper_unlocked(ofs, p->name, path->dentry, p->len);
 		if (IS_ERR(dentry))
 			continue;
-		if (dentry->d_inode)
+		if (dentry->d_inode) {
+			inode_lock_nested(dir, I_MUTEX_PARENT);
 			err = ovl_workdir_cleanup(ofs, dir, path->mnt, dentry, level);
+			inode_unlock(dir);
+		}
 		dput(dentry);
 		if (err)
 			break;
 	}
-	inode_unlock(dir);
 out:
 	ovl_cache_free(&list);
 	return err;
-- 
2.49.0


