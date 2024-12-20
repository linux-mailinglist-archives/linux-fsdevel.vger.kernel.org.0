Return-Path: <linux-fsdevel+bounces-37947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499449F957F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F51675EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC749218E9C;
	Fri, 20 Dec 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3exKZ2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54784218AC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708800; cv=none; b=R3eQlJ6p2HyNoPAhfoUyc9W2koWB8awXl3OCaaujlEWdnDbRfF+Jr7ROyiL5jlWziQY03DG3ddbEUrhuRvpQeuDhb14NyWlwVMLbFVjDp8oFVdVdjLHZgEfWV/nwHdo+Ei4bZRjpglgL80DdFViR0hPn9WWS8wJW1lh63VKxRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708800; c=relaxed/simple;
	bh=ZyCXpRT455r2S07+QOUD9SLmwrfNZHhbqdLqERRMUuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyoAmbaKB7hcEpGzJ6FQrmDfigVQ5W25zrpyAwWD1nEHWA53f8gpxo+v1N0W5je20PO70wLcUjoDO1wdym5qhaYkJYgPXFBiUXGxzqCSrGT6CyUFiRcuvL5ZsjDLowNcrLLET8kk7hrupPq4pze9WyLiyopiCgzqXykqiUxU2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3exKZ2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC47C4CEDC;
	Fri, 20 Dec 2024 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734708799;
	bh=ZyCXpRT455r2S07+QOUD9SLmwrfNZHhbqdLqERRMUuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3exKZ2T5TgdU+zC58sBpE4t5ZjksAHSgtcv+GepWfxEqTmJyAJFq7FrwKp2iubcV
	 NT6tJPsTRr06rcD6138Ya+4zZNhbLXJawNOtTiO5xXvQk5GVtY/HPLONeKs+QVkdug
	 kxGsdY5zU8XA6Tzut1cA3LYOWYlT7H55zz+OBqA9QfqPJvgS6ziryU6gY5n4QXAHhV
	 J7xMHac3Nn+/JSYu4zevHf5pSeXqYcLmzz7dpIUPC/8JWkRxAofdZkqLIyRhGrnt0z
	 1iHnTsuS3kGJXivaJ3EuItrypzffShYARESNujqmZV3+LaTaWr+z61Kzs5TVSMI5Z7
	 hfO4MHZ5gOmGA==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 2/5] Revert "libfs: Add simple_offset_empty()"
Date: Fri, 20 Dec 2024 10:33:11 -0500
Message-ID: <20241220153314.5237-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220153314.5237-1-cel@kernel.org>
References: <20241220153314.5237-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

simple_empty() and simple_offset_empty() perform the same task.
The latter's use as a canary to find bugs has not found any new
issues. A subsequent patch will remove the use of the mtree for
iterating directory contents, so revert back to using a similar
mechanism for determining whether a directory is indeed empty.

Only one such mechanism is ever needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 32 --------------------------------
 include/linux/fs.h |  1 -
 mm/shmem.c         |  4 ++--
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3da58a92f48f..8380d9314ebd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -329,38 +329,6 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 	offset_set(dentry, 0);
 }
 
-/**
- * simple_offset_empty - Check if a dentry can be unlinked
- * @dentry: dentry to be tested
- *
- * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
- */
-int simple_offset_empty(struct dentry *dentry)
-{
-	struct inode *inode = d_inode(dentry);
-	struct offset_ctx *octx;
-	struct dentry *child;
-	unsigned long index;
-	int ret = 1;
-
-	if (!inode || !S_ISDIR(inode->i_mode))
-		return ret;
-
-	index = DIR_OFFSET_MIN;
-	octx = inode->i_op->get_offset_ctx(inode);
-	mt_for_each(&octx->mt, child, index, LONG_MAX) {
-		spin_lock(&child->d_lock);
-		if (simple_positive(child)) {
-			spin_unlock(&child->d_lock);
-			ret = 0;
-			break;
-		}
-		spin_unlock(&child->d_lock);
-	}
-
-	return ret;
-}
-
 /**
  * simple_offset_rename - handle directory offsets for rename
  * @old_dir: parent directory of source entry
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..f7efc6866ebc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3468,7 +3468,6 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
-int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index ccb9629a0f70..274c2666f457 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3818,7 +3818,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_offset_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3875,7 +3875,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_offset_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-- 
2.47.0


