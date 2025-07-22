Return-Path: <linux-fsdevel+bounces-55735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B5B0E439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5AD1C80FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD1285065;
	Tue, 22 Jul 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9KI9wUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BB284B3E;
	Tue, 22 Jul 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212499; cv=none; b=g8NtJQ2LOU5uKfK2RX6UZuW5Wt7Wfvh222rlvxOT3kFfIpul6f3ObtUeswKOr/mpxMM1uWfgePHfx8cpAKKayy1BK5/HM6jOEiOn6niX2aZvZ8j21k/3FYbMFTSwo9hCEzgN8NHG7W4IA8Zqh4uiaK9j57M/wvwqyu1CXrSp6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212499; c=relaxed/simple;
	bh=+pw0mAIxkqCmK0nJ5rmed+zPLewIGehmiWBFCkzmNK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2oxhCOCGIZxJH2EHE4rT6l6oNH84kQZgXNkb18uHyr1Vlc/Mhc3r57psp6g6xbTAchzZO3ORGyy9XhyrMK4zTy7oG24p5nna5Edg7akQ55fqt1uaIi6U/eU31D3K2fRVttvTJCN0FHyFApPyw3pm/b0vJs1FFve+oCG2mXYSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9KI9wUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9C4C4CEF6;
	Tue, 22 Jul 2025 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212499;
	bh=+pw0mAIxkqCmK0nJ5rmed+zPLewIGehmiWBFCkzmNK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9KI9wUXAsLs9utSoYYM2oW+rMKq8aTqzPyHFtwGB6X9z9A7oLr3zYB5EMmLwN4h9
	 76dZEeSsAmu+bWF3Ijua3L8bH5lA48nLn0Ns4Ig8faqmVQu+GyDlaypGgHGxwtfCFw
	 UAEPAnbOQJoL3AbhNUMvHllEJ/qLAJiZxpUGVDdshiOmaKa21ty41M087k1ERomjVr
	 Q4G/kdCxLUIUVBrJBQZiENKNa10+g7SLV5xepaS8pIi9L7jt/FeUZo2ZZBvZ3uHcEo
	 dVuhKokDjCg74rL0/Te4FUpDDw+4wgz824S2glxAvP791S4flOFlElch0ygKxKKTYO
	 DkJ9C7/HgsMhA==
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
Subject: [PATCH v3 09/13] fs/verity: use accessors
Date: Tue, 22 Jul 2025 21:27:27 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-9-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=3527; i=brauner@kernel.org; h=from:subject:message-id; bh=+pw0mAIxkqCmK0nJ5rmed+zPLewIGehmiWBFCkzmNK4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5PL2/ftdVhlIrPwZrH2NU43D933apjpLay0WWrd7 5OfhC63dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE0ojhfwCX7bHP7/Zedm+c WV5/RX3Xqbnds2sqb03UTNG/Lpo88T0jQ3+l/ge9q683Ho28wxG6trDwivm0uMgpReLGwZOmnLS ewwEA
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
index fdeb95eca3af..9368eeac6fb6 100644
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
+	if (inode->i_sb->s_op->i_fsverity)
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
index 1eb7eae580be..341cb1ec73f8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -124,6 +124,11 @@ struct fsverity_operations {
 
 #ifdef CONFIG_FS_VERITY
 
+static inline struct fsverity_info **fsverity_addr(const struct inode *inode)
+{
+	return ((void *)inode + inode->i_sb->s_op->i_fsverity);
+}
+
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
 	/*
@@ -132,6 +137,8 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */
+	if (inode->i_sb->s_op->i_fsverity)
+		return smp_load_acquire(fsverity_addr(inode));
 	return smp_load_acquire(&inode->i_verity_info);
 }
 
@@ -160,7 +167,7 @@ void __fsverity_cleanup_inode(struct inode *inode);
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
-	if (inode->i_verity_info)
+	if (inode->i_verity_info || inode->i_sb->s_op->i_fsverity)
 		__fsverity_cleanup_inode(inode);
 }
 

-- 
2.47.2


