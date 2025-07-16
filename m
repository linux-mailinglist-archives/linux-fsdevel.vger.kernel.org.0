Return-Path: <linux-fsdevel+bounces-55061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD56B06ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BC9172510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BB1B85FD;
	Wed, 16 Jul 2025 00:47:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1313B58A;
	Wed, 16 Jul 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626861; cv=none; b=q8YFyO/gxHOdBEGo4AHr9qgSeznh+7YueKPW+N8MTQDWkaEiRjkxLRBFQvDR0bTxEhaZrfdjtIQqkcRukDqTpVq/DSphsAT9c86XrxO9IuQ0XomqasA6ZB8m5GfWmIn8Lo7jJ+nO1o4r7tvx3FY0LXwNBsJbp1DyqSJgcRkAD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626861; c=relaxed/simple;
	bh=+g67YL39q29RLUvbB/H+dN88yAfgmT1pagAjE1x422g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYThEd5/R7cB2yILIbw1GIw+9xBL2zEKhlT9EmBr9ed88quns5QGDaUfYnNHGo31E8XRKe8nyDpAa67BO8v8Jf4+pZc9+5BB2tdlc38Q+Iz5aeBL9XYSYGEqJDmMMrbPEsLZ+3OtabP/PX9q+kXv5ecyXMx6gSSC3y1e60eggyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ6-002ABY-Ul;
	Wed, 16 Jul 2025 00:47:38 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/21] ovl: narrow locking in ovl_workdir_cleanup_recurse()
Date: Wed, 16 Jul 2025 10:44:25 +1000
Message-ID: <20250716004725.1206467-15-neil@brown.name>
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

Only take the dir lock when needed, rather than for the whole loop.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/readdir.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 95d5284daf8d..b0f9e5a00c1a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1122,7 +1122,6 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 	if (err)
 		goto out;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 	list_for_each_entry(p, &list, l_node) {
 		struct dentry *dentry;
 
@@ -1137,16 +1136,21 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 			err = -EINVAL;
 			break;
 		}
-		dentry = ovl_lookup_upper(ofs, p->name, path->dentry, p->len);
+		dentry = ovl_lookup_upper_unlocked(ofs, p->name, path->dentry, p->len);
 		if (IS_ERR(dentry))
 			continue;
-		if (dentry->d_inode)
-			err = ovl_workdir_cleanup(ofs, dir, path->mnt, dentry, level);
+		if (dentry->d_inode) {
+			err = ovl_parent_lock(path->dentry, dentry);
+			if (!err) {
+				err = ovl_workdir_cleanup(ofs, dir, path->mnt,
+							  dentry, level);
+				ovl_parent_unlock(path->dentry);
+			}
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


