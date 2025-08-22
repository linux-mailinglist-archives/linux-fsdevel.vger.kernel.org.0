Return-Path: <linux-fsdevel+bounces-58716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03601B30A19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988517BAEAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5BB17A2EB;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8D28F4;
	Fri, 22 Aug 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821485; cv=none; b=KbLpQnzGkMlCuyvaeKLs955Nv5/E1htCbe0mqnO+6aITf91Z81qwzJgNpObrepcXJbpNBYZNEmwZhnY5haNK4uXhGQSBkkuws3DTeCyGiV9V9s1b5cBy6ke8NgaVeU/5vCfS+KyEK7ahMyqPE8Z9ltDd2XnonA9nP3xAy0Ej1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821485; c=relaxed/simple;
	bh=Xm0u+m9SfyNz7nxDbcIx4KNkfWnzX+pGkAKYdilO22I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc3NJxa2J7jFhfqWqGINO0EkfI4fAjSEw4I0ES4aBMacOWuY9i8AQSr4QHTs9FXA2sUobtz3MiLRH+HqqoNcFu5j1tLJO8uBBeHOsIS6hjq5fOvAA4dqqv/jYTyWJioZTMffMh6QyEbe7XpQSCvuZj3qCYkvuUPG0hcgy0qBElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNB-006nav-13;
	Fri, 22 Aug 2025 00:11:14 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/16] VFS: introduce end_dirop() and end_dirop_mkdir()
Date: Fri, 22 Aug 2025 10:00:25 +1000
Message-ID: <20250822000818.1086550-8-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

end_dirop() is the partner of start_dirop().  It drops the lock and
releases the reference on the dentry.
It *is* exported and can be used by all callers.

As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
that won't unlock when the dentry IS_ERR().  For those cases we have
end_dirop_mkdir().

end_dirop() can always be called on the result of start_dirop(), but not
after vfs_mkdir().
end_dirop_mkdir() can only be called on the result of start_dirop() if
that was not an error, and can calso be called on the result of
vfs_mkdir().

We we change vfs_mkdir() to drop the lock when it drops the dentry,
end_dirop_mkdir() can be discarded.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 50 +++++++++++++++++++++++++++++++++++--------
 include/linux/namei.h |  3 +++
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4f1eddaff63f..8121550f20aa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2778,6 +2778,43 @@ static struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
 	return dentry;
 }
 
+/**
+ * end_dirop - signal completion of a dirop
+ * @de - the dentry which was returned by start_dirop or similar.
+ *
+ * If the de is an error, nothing happens. Otherwise any lock taken to
+ * protect the dentry is dropped and the dentry itself is release (dput()).
+ */
+void end_dirop(struct dentry *de)
+{
+	if (!IS_ERR(de)) {
+		inode_unlock(de->d_parent->d_inode);
+		dput(de);
+	}
+}
+EXPORT_SYMBOL(end_dirop);
+
+/**
+ * end_dirop_mkdir - signal completion of a dirop which could have been vfs_mkdir
+ * @de - the dentry which was returned by start_dirop or similar.
+ * @parent - the parent in which the mkdir happened.
+ *
+ * Because vfs_mkdir() dput()s the dentry on failure, end_dirop() cannot be
+ * used with it.  Instead this function must be used, and it must not be caller
+ * if the original lookup failed.
+ *
+ * If de is an error the parent is unlocked, else this behaves the same as
+ * end_dirop().
+ */
+void end_dirop_mkdir(struct dentry *de, struct dentry *parent)
+{
+	if (IS_ERR(de))
+		inode_unlock(parent->d_inode);
+	else
+		end_dirop(de);
+}
+EXPORT_SYMBOL(end_dirop_mkdir);
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct path *path)
 {
@@ -4174,9 +4211,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 
 	return dentry;
 fail:
-	dput(dentry);
+	end_dirop(dentry);
 	dentry = ERR_PTR(error);
-	inode_unlock(path->dentry->d_inode);
 out_drop_write:
 	if (!error)
 		mnt_drop_write(path->mnt);
@@ -4198,9 +4234,7 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
-		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	end_dirop_mkdir(dentry, path->dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4540,8 +4574,7 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit4;
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
-	dput(dentry);
-	inode_unlock(path.dentry->d_inode);
+	end_dirop(dentry);
 exit3:
 	mnt_drop_write(path.mnt);
 exit2:
@@ -4674,8 +4707,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
-		inode_unlock(path.dentry->d_inode);
+		end_dirop(dentry);
 	}
 	if (inode)
 		iput(inode);	/* truncate the inode here */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..bd0cba118540 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,6 +81,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
 
+void end_dirop(struct dentry *de);
+void end_dirop_mkdir(struct dentry *de, struct dentry *parent);
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.50.0.107.gf914562f5916.dirty


