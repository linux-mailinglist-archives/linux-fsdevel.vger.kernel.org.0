Return-Path: <linux-fsdevel+bounces-36483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416119E3EB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024A128366E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35720CCDC;
	Wed,  4 Dec 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8mUmlEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971520C499
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327585; cv=none; b=X0N3gCHGmd4nVSnTNdzOrUA5NyoK04nXDpymceudBg/1Rlu1gsRGXqJEg0C0KXwtLKBXJmpsuPsVDgATfXcROV2ntAidapNACJBVaJ5BgjIrF1/lbTYkHQft8fCiokvlABQJUWEsq9S/9j9lKJb2BLx8H4EFlbpm3Eg8scVLKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327585; c=relaxed/simple;
	bh=N2kJlcrn9JOTM3KVLvrbjdtgeqhmJMuG2Y/zQp2C8sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mum5aKBq/NcP9Og4JW9ibGE26yXpUWLvuZTe3FMrSGEuG7Rynhkjo7NvNGTY26wDEyDQuSLmXghCxTkucMNqcA1Aj+ICwpsEJwoHkHXAQA7V51dXwL7RnIZPLhUvClJrdxvt4htm7QxUftYEbbJLqzizHN9QaWUE7dOKIse7KCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8mUmlEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3432C4CED1;
	Wed,  4 Dec 2024 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327584;
	bh=N2kJlcrn9JOTM3KVLvrbjdtgeqhmJMuG2Y/zQp2C8sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8mUmlEmi1YX9VJXiiGL6ot4MnLU+An2YSxggSZVPZtdpsB9RZ4PPgT8dKAJKyMk9
	 QQGgo56Hqy0Yv8NjuXQckIsZRYBRaETkYPR+bNx90Zbp2M5xDQP2qBOn9NlK047AIt
	 f2QtumEWqXAqPc3Ge1dUSHbJsXja/zQwjrMf6RzAAEGI6p0PMM1JJxUc9kh2ARHLiR
	 sm73FgFFJ6rks2aNBTaq3oPFifhtWX5Rf5P65oyWaeNEwjlkYrwxRcT7+kKcTxgbce
	 Wa9A+h2fYaKZ1oGXrXywzv0oGHgOQEbneNLsBYhFXbKSHl0fucmCyWQl/0AECa920h
	 IYDC41rC1xyDA==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 2/5] Revert "libfs: Add simple_offset_empty()"
Date: Wed,  4 Dec 2024 10:52:53 -0500
Message-ID: <20241204155257.1110338-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155257.1110338-1-cel@kernel.org>
References: <20241204155257.1110338-1-cel@kernel.org>
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
index bf67954b525b..b668a4f5bbc9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -327,38 +327,6 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
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
index 3559446279c1..0698cf63346c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3434,7 +3434,6 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
-int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index 568bb290bdce..6ae963d42dbe 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3697,7 +3697,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_offset_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3754,7 +3754,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_offset_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-- 
2.47.0


