Return-Path: <linux-fsdevel+bounces-55811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C4B0F099
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD81562FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1228EA5A;
	Wed, 23 Jul 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxSb4XAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E8253358;
	Wed, 23 Jul 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268314; cv=none; b=LaIXO2m8Vd42lfAumZ2PY2IsroIyWX07RfwUluc/APhxK0PrSXpFGbtU6Zi1Z8tt+XcmxVYR6PhiNa09xkrupbXiJQhX4ovmLbbkCOV8Shfv2ysfVDYLC2DfuemlLtzgF1X+/9tBmLVpZt72o58GRhZ6wN72pQearXLuPSpR1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268314; c=relaxed/simple;
	bh=AqBbyAWIcycwKsjuhdlFuJqCrZWLSeaq5fAlXrm7sb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YG33AcO/x4rVd49reOmiPSHrNL9lUfIfgIsIWfBmyJzsf78BM4Bt1Sia12wbCAZ7T7g50a0c+0PgejNN6C1CHsQA5E/bOKDS9iIXbl39qPvgS5pyd+9wwK+iWzQlC+gO53uWatJhEkhtiia4uJLd4+u1Flqksc4iM6/hwW74UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxSb4XAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EE6C4CEE7;
	Wed, 23 Jul 2025 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268314;
	bh=AqBbyAWIcycwKsjuhdlFuJqCrZWLSeaq5fAlXrm7sb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxSb4XAAzsDjjWMbmoOrD/sDMuKe3BCT/P1faV9+0PCO8wa7H7/M48e+nTg6GCnX7
	 503vWPAoCXfVUCMYcmu4hbGPVb1JMdKzgRYPVDRlHbQLvBShzBaJsqOfqktEq2v2G8
	 q7Hx3QQISIhhUso1Lc1lK+QJJsBowY7rn5mWmsMgbAdCsADvCLarj3Q7hEfXeSk+6n
	 w8RpH4PJlLqs0yvD9JfQlXsoztz9Y4E6JTz+5QMEUoCggDr/MSbXgwp3U5TOUPOhCc
	 6Rl6AmLWoCDV09Z4F7unv72Ren00eG40zihRvTVqk/1gMuNJkPx7b9L4GHB+yjGmuV
	 MhR8VpxkWKYiw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v4 10/15] fs/verity: use accessors
Date: Wed, 23 Jul 2025 12:57:48 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-10-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=3629; i=brauner@kernel.org; h=from:subject:message-id; bh=AqBbyAWIcycwKsjuhdlFuJqCrZWLSeaq5fAlXrm7sb8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HND24bH8zOAvZbhV/hgnj9RNdiGGmZ123qlf/u44/ pMxzPJMRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES8ohkZPgiFnVRKbhZgdQ+x EzG5PP/F9aeqx4s+/zvLbzbj/sv6XYwMm9gZ0l0d9U7zr2rPMvirt6pfNTnupuH7HaWCO+w15ji yAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Use accessor to get and set the verity info from the filesystem.
They can be removed once all filesystems have been converted to make
room for verity info in their own inodes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/verity/open.c         | 19 ++++++++++++++++---
 fs/verity/verify.c       |  2 +-
 include/linux/fsverity.h | 12 +++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af..a4d7388e2f71 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -250,13 +250,20 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
 {
+	void *p;
+
 	/*
 	 * Multiple tasks may race to set ->i_verity_info, so use
 	 * cmpxchg_release().  This pairs with the smp_load_acquire() in
 	 * fsverity_get_info().  I.e., here we publish ->i_verity_info with a
 	 * RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
-	if (cmpxchg_release(&inode->i_verity_info, NULL, vi) != NULL) {
+
+	if (inode->i_sb->s_vop->inode_info_offs)
+		p = cmpxchg_release(fsverity_addr(inode), NULL, vi);
+	else
+		p = cmpxchg_release(&inode->i_verity_info, NULL, vi);
+	if (p != NULL) {
 		/* Lost the race, so free the fsverity_info we allocated. */
 		fsverity_free_info(vi);
 		/*
@@ -402,8 +409,14 @@ EXPORT_SYMBOL_GPL(__fsverity_prepare_setattr);
 
 void __fsverity_cleanup_inode(struct inode *inode)
 {
-	fsverity_free_info(inode->i_verity_info);
-	inode->i_verity_info = NULL;
+	struct fsverity_info **vi;
+
+	if (inode->i_sb->s_vop->inode_info_offs)
+		vi = fsverity_addr(inode);
+	else
+		vi = &inode->i_verity_info;
+	fsverity_free_info(*vi);
+	*vi = NULL;
 }
 EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a12..a9c2f5c86991 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -247,7 +247,7 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
 		   unsigned long max_ra_pages)
 {
 	struct inode *inode = data_folio->mapping->host;
-	struct fsverity_info *vi = inode->i_verity_info;
+	struct fsverity_info *vi = fsverity_get_info(inode);
 	const unsigned int block_size = vi->tree_params.block_size;
 	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 85831f36e2f8..75ff6c9c50ef 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -129,14 +129,24 @@ struct fsverity_operations {
 
 #ifdef CONFIG_FS_VERITY
 
+static inline struct fsverity_info **fsverity_addr(const struct inode *inode)
+{
+	return ((void *)inode + inode->i_sb->s_vop->inode_info_offs);
+}
+
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
+	if (!inode->i_sb->s_vop)
+		return NULL;
+
 	/*
 	 * Pairs with the cmpxchg_release() in fsverity_set_info().
 	 * I.e., another task may publish ->i_verity_info concurrently,
 	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */
+	if (inode->i_sb->s_vop->inode_info_offs)
+		return smp_load_acquire(fsverity_addr(inode));
 	return smp_load_acquire(&inode->i_verity_info);
 }
 
@@ -165,7 +175,7 @@ void __fsverity_cleanup_inode(struct inode *inode);
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
-	if (inode->i_verity_info)
+	if (IS_VERITY(inode))
 		__fsverity_cleanup_inode(inode);
 }
 

-- 
2.47.2


