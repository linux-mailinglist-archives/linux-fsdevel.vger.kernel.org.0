Return-Path: <linux-fsdevel+bounces-55679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22623B0DA4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B522B7B20F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A622E9EDD;
	Tue, 22 Jul 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paCRV9uc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13AA2D8DDF;
	Tue, 22 Jul 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189094; cv=none; b=njVrY0tAELG9o7Pa9C6BpeBpPKjuOv54joT/HjXSpDEu508ix6kwfQvbPcP0Si3ZNI0u0FwtuBM9TbJ4V5EESYb6fvgXRbe7r2RAzGyiDj/aZyKzKgfBgem5XJmBnaKsTd1Pdug/ocY/KmXLF8urN9VSPAG7e2O/W9J0gLYwojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189094; c=relaxed/simple;
	bh=utPtFc1v9KwW8FSgy4te1mb8qVCp0S/ltA9erhVq1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlfCi2qPA5GKLdc6hzbJZk0tQ+g2C5MiBQarmLYnTU0aRXPhTbFbfWs6YmFUDLxaVaeJ3ybjf9aSZpr0dORtqkeng8UrOd2nb/5N8tKZjRuEIB5Ne52Vdi91zCdQ+XnJdMImspZHjUT1SYGoGYe9jy8tmywgCPzA7DOdj61sqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paCRV9uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC08C4CEEB;
	Tue, 22 Jul 2025 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189093;
	bh=utPtFc1v9KwW8FSgy4te1mb8qVCp0S/ltA9erhVq1EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paCRV9uciiKOoe0r0AAlqgdCAjfW+YWQFjecn2gBqQotGC8aQ09ii9S/eFLmwV9+P
	 y4Sh9VRrxiTxkYpqRxgeh0g9YpPVCggmxI5wSFdvqK+XUb4CxJNs1jhvG5MOtlj1Gt
	 KCFU4SMeOI+yakPgl4Z/BgAyUCSGF+bqfGtTX+BlRVsA7IWvqq52NA9lNc4H6uAyBy
	 /ZIxc5AUXUQ9W/JYTznPFAEFTt9x41lMN6A91AkEr9vaJx51SpiAxywcQLh/X5kUda
	 19byg9Ev5E1kbkobWI1GmAXjjIh1q1PdGtFXX276mz6K1ukfiQ+rC17/GfrbBUMlF1
	 1n7tUXhUv/NjA==
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
Subject: [PATCH RFC DRAFT v2 09/13] fs/verity: use accessors
Date: Tue, 22 Jul 2025 14:57:15 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-9-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=3503; i=brauner@kernel.org; h=from:subject:message-id; bh=utPtFc1v9KwW8FSgy4te1mb8qVCp0S/ltA9erhVq1EY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd23aa8f02mKSxKNwzbtKT3cbcu+YUf2Uca7fUfbgc 52NxhxOHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhO8nIsHL9wVlvlIOs8l/3 znoc5xl2waZvRZBxMXeAUG1yjprodYZ/RtPilqXqvFySNPH5jo0yH/rur7/ftHHtxy9MU2T7W6J WsgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Use accessor to get and set the verity info from the filesystem.
They can be removed once all filesystems have been converted to make
room for verity info in their own inodes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/verity/open.c         | 18 +++++++++++++++---
 fs/verity/verify.c       |  2 +-
 include/linux/fsverity.h |  9 ++++++++-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af..2b9da08754f3 100644
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
+	if (inode->i_op->i_fsverity)
+		p = cmpxchg_release(fsverity_addr(inode), NULL, vi);
+	else
+		p = cmpxchg_release(&inode->i_verity_info, NULL, vi);
+	if (p != NULL) {
 		/* Lost the race, so free the fsverity_info we allocated. */
 		fsverity_free_info(vi);
 		/*
@@ -402,8 +409,13 @@ EXPORT_SYMBOL_GPL(__fsverity_prepare_setattr);
 
 void __fsverity_cleanup_inode(struct inode *inode)
 {
-	fsverity_free_info(inode->i_verity_info);
-	inode->i_verity_info = NULL;
+	struct fsverity_info **vi;
+
+	vi = fsverity_addr(inode);
+	if (!*vi)
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
index 1eb7eae580be..3f15d22c03d6 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -124,6 +124,11 @@ struct fsverity_operations {
 
 #ifdef CONFIG_FS_VERITY
 
+static inline struct fsverity_info **fsverity_addr(const struct inode *inode)
+{
+	return ((void *)inode + inode->i_op->i_fsverity);
+}
+
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
 	/*
@@ -132,6 +137,8 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */
+	if (inode->i_op->i_fsverity)
+		return smp_load_acquire(fsverity_addr(inode));
 	return smp_load_acquire(&inode->i_verity_info);
 }
 
@@ -160,7 +167,7 @@ void __fsverity_cleanup_inode(struct inode *inode);
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
-	if (inode->i_verity_info)
+	if (inode->i_verity_info || inode->i_op->i_fsverity)
 		__fsverity_cleanup_inode(inode);
 }
 

-- 
2.47.2


