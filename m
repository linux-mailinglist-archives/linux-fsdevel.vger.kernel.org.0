Return-Path: <linux-fsdevel+bounces-40070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB3A1BCCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0745188FBEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C52253FE;
	Fri, 24 Jan 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q306l4ws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C92248B2;
	Fri, 24 Jan 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746401; cv=none; b=mT96s3TEeELIE8laYjWmtZiJC+ug+ls/KaxTcl9l3oprcDzCRfX5tomrrufA3UAdZltdQQUqpWJo23Bd0ILp0bTIe2sy8CJjxL/KFKlqkfvpbfqnZSsy5fIQm4o+Uz971pP9RIs1LBN8xL2n4yuH3MNshdbWnctLtadrev+UykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746401; c=relaxed/simple;
	bh=7i8ieMEYnSbXE7wG5048yyfg5P+RPVEiCcn7OJpp8XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXbUzcqdM8W+d9ZJM8JDn6cPaDX49W6QTzqCyYl1aQhVk7hSp+H/Lfyy6r49I7QEibzNGxUmRwCWPhtusBOmHyGuUjUFTPCD00QggOSsuqv5g1KWnS44u1yAs7e6AuEL85rQ8qpzezWwjav1IBqV8YYK0/SMXXwkV8tTtt5cPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q306l4ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1325C4CEE3;
	Fri, 24 Jan 2025 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746400;
	bh=7i8ieMEYnSbXE7wG5048yyfg5P+RPVEiCcn7OJpp8XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q306l4wsGt82CKQzJvzhCo3HcT3FOVHMDa4ucpXOi/awls8OhBeRzHF/cvjCiN/es
	 TpjuBhJs8QKINqg3tPofapF/U7S59qv64UiRwDNps4Rn+6oEbcAONf+scmmvYG4mNe
	 nEfrbvG9XNRWRWNLjoXHoBtXHpu3kAhE8RFN1bOacH8yxGWMfvwNggTrD4lUdBPv7R
	 k31E1KBrrisj3Vo0UfhlGhwQ+3t7EgN9Z674QXx6Ss2S9DM6gYboYkLaS+pHszU2ih
	 mNVa3Qn5iyQh7toBcbBlE15mLKn9yoHQ0DU2Z4aNaTrgOz0Ur0D6WmjFylrTUOtK9n
	 4BS4b24PehbQQ==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v6.6 08/10] Revert "libfs: Add simple_offset_empty()"
Date: Fri, 24 Jan 2025 14:19:43 -0500
Message-ID: <20250124191946.22308-9-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
References: <20250124191946.22308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d7bde4f27ceef3dc6d72010a20d4da23db835a32 ]

simple_empty() and simple_offset_empty() perform the same task.
The latter's use as a canary to find bugs has not found any new
issues. A subsequent patch will remove the use of the mtree for
iterating directory contents, so revert back to using a similar
mechanism for determining whether a directory is indeed empty.

Only one such mechanism is ever needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20241228175522.1854234-3-cel@kernel.org
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ cel: adjusted to apply to origin/linux-6.6.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 32 --------------------------------
 include/linux/fs.h |  1 -
 mm/shmem.c         |  4 ++--
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 200bcfc2ac34..082bacf0b9e6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -324,38 +324,6 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
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
-	xa_for_each(&octx->xa, index, child) {
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
index e4d139fcaad0..e47596d354ff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3197,7 +3197,6 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
-int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index ab2b0e87b051..283fb62084d4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3368,7 +3368,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_offset_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3425,7 +3425,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_offset_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-- 
2.47.0


