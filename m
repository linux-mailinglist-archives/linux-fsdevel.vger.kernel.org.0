Return-Path: <linux-fsdevel+bounces-38205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79849FDBCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C801882C5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B319882F;
	Sat, 28 Dec 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkZyB+e+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98556194ACC
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408530; cv=none; b=IacxErluOiQUzNQqio5MGtnFs7lGHTmCmmhW9IU25XON1ZrF3yclvKFHYCU6tX85lqrhW9Wkhrzinnvsl5gbz6SxGb0l6ato2EijN7tCSq5OTZ0ZXW25lOrPYir/W1UpLRNEtAlp/cuKjx5z9pVof7/2eZHrRWRm/MDEggwgWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408530; c=relaxed/simple;
	bh=WTZSoNUmlpCr3xI8k1Ogjd81zfFoaOgkluDOdOMlomc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og+sLTGcZ3aYgqz8bm5Syu3EIH5IA18LVMNlmxu5lkt/oJV890yiisHP5RwQCDvBEmAr02Km7oImO7GVg2y8bQ/8kppGcnHa7fZWJIBDmrUVgA0ClxG4oQD0pGiMXb7tFRPNYObkIrxI1yYrz/tAh0DdJDehUnbxyrdfPR6ROtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkZyB+e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5054DC4CED4;
	Sat, 28 Dec 2024 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735408530;
	bh=WTZSoNUmlpCr3xI8k1Ogjd81zfFoaOgkluDOdOMlomc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkZyB+e+oXkkoiHfk2e90Exd3floAYt11DNoTBTvESvt94QQxkC2Teg8+ggq+xFly
	 hh6n3Io4qJeO2eJVX5/oiBoIaxWwI02BBTFu5hPJ9BIyXL5O7WhzGYEuAG5/7DjY3g
	 00G1EdCX5yStiA+UmPqSLYUoZhviIviS79CEIjDM8eXfWkIhl3QZuys+KfLNEKduK5
	 r7pXgWrri3WFqa68vMdNuqQyRDNbj/P1mL2CpqIKBpOR9iVmY2GyKq6LW/KawYnc2q
	 x9NRV17i8nJIEKHRy990w/ibPDPP0H73lUGAZxny5q4qBC7LIs3xDnfBu4mt7EJs9o
	 UaUDHrVVugSsg==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Liam.Howlett@oracle.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 2/5] Revert "libfs: Add simple_offset_empty()"
Date: Sat, 28 Dec 2024 12:55:18 -0500
Message-ID: <20241228175522.1854234-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241228175522.1854234-1-cel@kernel.org>
References: <20241228175522.1854234-1-cel@kernel.org>
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
index f6fb053ac50d..fe5613a5ae20 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3820,7 +3820,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_offset_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3877,7 +3877,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_offset_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-- 
2.47.0


