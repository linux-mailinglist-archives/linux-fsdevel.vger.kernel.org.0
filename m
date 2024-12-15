Return-Path: <linux-fsdevel+bounces-37442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04669F2575
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DEE164788
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97291BBBF1;
	Sun, 15 Dec 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWfkeu17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B231BB6BC
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289102; cv=none; b=tObXIxF9CloQfwhnH98ayrGilQCMKdXRAedRUDpGRwXG8C84wAHGa5S2gn2awvHzRW5atuRLNGqDMEcKyeWYKw8lV0jaz7p516OQSmMqmspz8wRQM7Q9wVPiMYEVMHLrz5kKi7EDBHC3aQJs8m/m5/yLeZmCVzAJ9GYhvpJB864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289102; c=relaxed/simple;
	bh=8uJ2Pr2s2e4IY7lhSwlQ1U0qNB24Hr3dfGxCSwH7i3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYHLb4m8ur6DTtsMygYNKm5KMIHMc/rCyZBypmZX2Q+1rjlAz8dyRjzSs8BwNsHWK/cpdbGsmckv55bd/ceVbQeqXjyAke+28XAkGJW8nfD5O6QcNPh0S5ieLXbmDg163IAn7K4P0H2OCDJyoUy8kKu7JL8iGD8S4NUZQpizX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWfkeu17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8ABC4CEE2;
	Sun, 15 Dec 2024 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734289102;
	bh=8uJ2Pr2s2e4IY7lhSwlQ1U0qNB24Hr3dfGxCSwH7i3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWfkeu17XsQ+VEfxJGvSI1fYGGkfbSlT2wtA6f7qr/YCmDZmIILW5Y7tthYzlzTjj
	 +f739dSbqQXnNixYLSpa/VJWdd/z4Lw4NmTKq4c2rPSur2mK8Qd6WJqcbN7dMoua6l
	 3hIXUCg94IHunYxZwUmbgaheKN9dkL/Jpxz1FYF6ldyB6gKg4P2V7DUGIEuaTvu67g
	 U+tprO9LReZW8Jz6fxc8s64cDP6lP7UrykVNSQdV3C//s4wPhLBxsvCi9uEcQBzBco
	 JM0GEkPZSaToe/PoMuv7e7WSQ6seR1DI8J4lLITiGagTpCgTvjRQhUQ6VwZYtod69Y
	 JgEZLwf+wpBSg==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 2/5] Revert "libfs: Add simple_offset_empty()"
Date: Sun, 15 Dec 2024 13:58:13 -0500
Message-ID: <20241215185816.1826975-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241215185816.1826975-1-cel@kernel.org>
References: <20241215185816.1826975-1-cel@kernel.org>
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
index f6d04c69f195..9bcc97ffae48 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -331,38 +331,6 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
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


