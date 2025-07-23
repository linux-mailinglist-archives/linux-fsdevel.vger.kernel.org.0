Return-Path: <linux-fsdevel+bounces-55816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB5B0F0A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9018928A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458C2DAFCF;
	Wed, 23 Jul 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rluPevrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65928E604;
	Wed, 23 Jul 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268330; cv=none; b=PSTdLmY56NPUp/iFz5DxLE2uGbxcsWAScMDcBnpTyTz8NIZCJeOI+JtnOwVJFYVsf/FsZTJDzgYskNgd2dtStMLsMlmh2NFrEpumo09ylWZWc2XDla9LGa17XRmCpORHOUSv+vrDf6UKwxI05yR0cVz09K4Kz61SPzJxw/mOkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268330; c=relaxed/simple;
	bh=pHPHczG1H3lLu6dsysbI2Wm2loEr+NyRXNQXn75/4tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qso23ODKUFYrYQ0GuEnBDdyVC5hFHl+zR9zKEvlLie253+9Y8zVGijit/MHmt30iJOh32bwI1rohA25Xa0zzXGR8hx4wbNVnVCrlG0IiyU5o9OttowL/FCRnTZH9ThxroOW+eZZLCcoaeyVpkdR3NrEGASghRq39MzVHqKwBtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rluPevrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C48C4CEF5;
	Wed, 23 Jul 2025 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268330;
	bh=pHPHczG1H3lLu6dsysbI2Wm2loEr+NyRXNQXn75/4tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rluPevrIRf4SiI9xNR2+yev+fdhIcpRZGkoVuh/1mjP+KM85CcIVcFiXi570UHy5E
	 xrdwRur4+JJyOHWk3WstmWmGBouvG5bCBPzxJJWbe00Onje5efmZ3s5BVJEHr8vDCR
	 PqAeiTZtRjOGd3HxgBjF+o6omDf/sPc+CA2rGOJqJuZx0MWIEX143HlxVLp6xoxGXW
	 R91FWPRuCSZhfqcyTY+8r6QDa1C/OEBx2jVrLfAMeCLMnaNgv76KgHM4XkPL8JMbyD
	 7S9wz8xIkDy08S9rmldInhiD60nDT8UHT3rDqx0vspQI0Fxe2A0nBSq/EMXFGakPkN
	 timU8w7KjSVVg==
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
Subject: [PATCH v4 15/15] fsverity: rephrase documentation and comments
Date: Wed, 23 Jul 2025 12:57:53 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-15-c8e11488a0e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6277; i=brauner@kernel.org; h=from:subject:message-id; bh=pHPHczG1H3lLu6dsysbI2Wm2loEr+NyRXNQXn75/4tQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNDRXnGmLGLZp2qvS6wTlzernbK3aZlTK81/zLA7k SF2W8TijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYzmdkOFihav02Yu+hTadd rG3XbDqyRK14esayvLdHQyQSw+6u/s7IcMC3P88z6s7c1kN6h/dH3f22rLa3Vb951te66dwd29/ 95gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we moved fsverity out of struct inode update the comments to
not imply that it's still located in there.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/verity/enable.c           |  6 +++---
 fs/verity/fsverity_private.h |  9 +++++----
 fs/verity/open.c             | 12 ++++++------
 include/linux/fsverity.h     | 12 +++++++-----
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..760824611abc 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -287,9 +287,9 @@ static int enable_verity(struct file *filp,
 		/* Successfully enabled verity */
 
 		/*
-		 * Readers can start using ->i_verity_info immediately, so it
-		 * can't be rolled back once set.  So don't set it until just
-		 * after the filesystem has successfully enabled verity.
+		 * Readers can start using the inode's verity info immediately,
+		 * so it can't be rolled back once set.  So don't set it until
+		 * just after the filesystem has successfully enabled verity.
 		 */
 		fsverity_set_info(inode, vi);
 	}
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..1b45dc5f52cc 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -58,10 +58,11 @@ struct merkle_tree_params {
  * fsverity_info - cached verity metadata for an inode
  *
  * When a verity file is first opened, an instance of this struct is allocated
- * and stored in ->i_verity_info; it remains until the inode is evicted.  It
- * caches information about the Merkle tree that's needed to efficiently verify
- * data read from the file.  It also caches the file digest.  The Merkle tree
- * pages themselves are not cached here, but the filesystem may cache them.
+ * and stored in inode's verity pointer; it remains until the inode is evicted.
+ * It caches information about the Merkle tree that's needed to efficiently
+ * verify data read from the file.  It also caches the file digest.  The Merkle
+ * tree pages themselves are not cached here, but the filesystem may cache
+ * them.
  */
 struct fsverity_info {
 	struct merkle_tree_params tree_params;
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 0dcd33f00361..c4a0c94dde2c 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -251,10 +251,10 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
 {
 	/*
-	 * Multiple tasks may race to set ->i_verity_info, so use
+	 * Multiple tasks may race to set the inode's verity info, so use
 	 * cmpxchg_release().  This pairs with the smp_load_acquire() in
-	 * fsverity_get_info().  I.e., here we publish ->i_verity_info with a
-	 * RELEASE barrier so that other tasks can ACQUIRE it.
+	 * fsverity_get_info().  I.e., here we publish the inode's verity info
+	 * with a RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
 	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop);
 	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop->inode_info_offs);
@@ -262,8 +262,8 @@ void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
 		/* Lost the race, so free the fsverity_info we allocated. */
 		fsverity_free_info(vi);
 		/*
-		 * Afterwards, the caller may access ->i_verity_info directly,
-		 * so make sure to ACQUIRE the winning fsverity_info.
+		 * Afterwards, the caller may access the inode's verity info
+		 * directly, so make sure to ACQUIRE the winning fsverity_info.
 		 */
 		(void)fsverity_get_info(inode);
 	}
@@ -359,7 +359,7 @@ int fsverity_get_descriptor(struct inode *inode,
 	return 0;
 }
 
-/* Ensure the inode has an ->i_verity_info */
+/* Ensure the inode has fsverity info set */
 static int ensure_verity_info(struct inode *inode)
 {
 	struct fsverity_info *vi = fsverity_get_info(inode);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 0ee5b2fea389..9e204d5c5691 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -145,7 +145,7 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 
 	/*
 	 * Pairs with the cmpxchg_release() in fsverity_set_info().
-	 * I.e., another task may publish ->i_verity_info concurrently,
+	 * I.e., another task may publish the inode's verity info concurrently,
 	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */
@@ -174,7 +174,8 @@ void __fsverity_cleanup_inode(struct inode *inode);
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted
  *
- * Filesystems must call this on inode eviction to free ->i_verity_info.
+ * Filesystems must call this on inode eviction to free -the inode's
+ * verity info.
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
@@ -285,12 +286,13 @@ static inline bool fsverity_verify_page(struct page *page)
  * fsverity_active() - do reads from the inode need to go through fs-verity?
  * @inode: inode to check
  *
- * This checks whether ->i_verity_info has been set.
+ * This checks whether the inode's verity info has been set.
  *
  * Filesystems call this from ->readahead() to check whether the pages need to
  * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
  * a race condition where the file is being read concurrently with
- * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before ->i_verity_info.)
+ * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the inode's
+ * verity info.)
  *
  * Return: true if reads need to go through fs-verity, otherwise false
  */
@@ -305,7 +307,7 @@ static inline bool fsverity_active(const struct inode *inode)
  * @filp: the struct file being set up
  *
  * When opening a verity file, deny the open if it is for writing.  Otherwise,
- * set up the inode's ->i_verity_info if not already done.
+ * set up the inode's verity info if not already done.
  *
  * When combined with fscrypt, this must be called after fscrypt_file_open().
  * Otherwise, we won't have the key set up to decrypt the verity metadata.

-- 
2.47.2


