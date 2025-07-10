Return-Path: <linux-fsdevel+bounces-54556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9113FB00F71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC4317D20A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C72C158C;
	Thu, 10 Jul 2025 23:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0029ACED;
	Thu, 10 Jul 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189690; cv=none; b=Od0vVTOJ3OErDWecBlj8niQNvRwl6ku7YPUOn+nHy9p4pLZJpBpoguIxiYM02zyCv44EWiWuiQIYXDq33YnG7CCJUweqFy4RzqwfhXlQSP0s99++UqsZdEK+fQ/R8vrXUdHO5xYxQiSlikwSeJ3mQXgqv5iu1I41nbHpiKxkEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189690; c=relaxed/simple;
	bh=5/oEgWAohI2afNbeu/8H9o+W1AxpdjA8d7b925kzjvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPBROR0E4Y4gpOhwZrENlGB7iRYZirOHOxwQCBao7TBavl9yenBAlnH2VKhPgRcnD9A04R+J1pYO5r6+SkHH+4MkN5bAYGpie3LzLlvYXINjCwv7eGtJH4v30ty6WBHH4JfDSCu2WmoDUxZ679THTAVzmKum8HxI6y5ah3jOu40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zq-001XFs-8P;
	Thu, 10 Jul 2025 23:21:19 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/20] ovl: change ovl_create_index() to take write and dir locks
Date: Fri, 11 Jul 2025 09:03:32 +1000
Message-ID: <20250710232109.3014537-3-neil@brown.name>
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

ovl_copy_up_workdir() currently take a rename lock on two directories,
then use the lock to both create a file in one directory, perform a
rename, and possibly unlink the file for cleanup.  This is incompatible
with proposed changes which will lock just the dentry of objects being
acted on.

This patch moves the call to ovl_create_index() earlier in
ovl_copy_up_workdir() to before the lock is taken, and also before write
access to the filesystem is gained (this last is not strictly necessary
but seems cleaner).

ovl_create_index() then take the requires locks and drops them before
returning.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 5d21b8d94a0a..25be0b80a40b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -517,8 +517,6 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 
 /*
  * Create and install index entry.
- *
- * Caller must hold i_mutex on indexdir.
  */
 static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 			    struct dentry *upper)
@@ -550,7 +548,10 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		return err;
 
+	ovl_start_write(dentry);
+	inode_lock(dir);
 	temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
+	inode_unlock(dir);
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
 		goto free_name;
@@ -559,6 +560,9 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		goto out;
 
+	err = parent_lock(indexdir, temp);
+	if (err)
+		goto out;
 	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
@@ -566,9 +570,11 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
 		dput(index);
 	}
+	parent_unlock(indexdir);
 out:
 	if (err)
-		ovl_cleanup(ofs, dir, temp);
+		ovl_cleanup_unlocked(ofs, indexdir, temp);
+	ovl_end_write(dentry);
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -797,6 +803,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto cleanup_need_write;
 
+	if (S_ISDIR(c->stat.mode) && c->indexed) {
+		err = ovl_create_index(c->dentry, c->origin_fh, temp);
+		if (err)
+			goto cleanup_need_write;
+	}
+
 	/*
 	 * We cannot hold lock_rename() throughout this helper, because of
 	 * lock ordering with sb_writers, which shouldn't be held when calling
@@ -818,12 +830,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto cleanup;
 
-	if (S_ISDIR(c->stat.mode) && c->indexed) {
-		err = ovl_create_index(c->dentry, c->origin_fh, temp);
-		if (err)
-			goto cleanup;
-	}
-
 	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
 				 c->destname.len);
 	err = PTR_ERR(upper);
-- 
2.49.0


