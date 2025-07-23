Return-Path: <linux-fsdevel+bounces-55808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F5DB0F093
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D151C84D64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337592DECBB;
	Wed, 23 Jul 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcZ3BUcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F32DA749;
	Wed, 23 Jul 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268305; cv=none; b=LimzRsFNHe3itsYTWOJ+nFp2mAb5PqJGMjA0Uam6XuIoU9KJoJtyxKW/YI0fZcqhUII36A6foy1oMQXHsSRPe8DGddfCh2TFEF5eDxBs8FeqBKIjpbck3f5NAA2tc9/9Z56v2QBvKhosfd3Lf672Q30YnL6n1Qh1A4IFKVXHxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268305; c=relaxed/simple;
	bh=hjTxLTjeyfv1cmY9AM9rNrj/psDt2Jl7S1EiMR+M7Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlvRz4xLYJeBZVZAcMQlNsOHh6MXQKq0n1X9H5Ub5ujJ6Q6tiK1Yh67jQAgvoNMYGyRDg3azEO7MJM+aqd6mJZQTDtB1rF+ndrIr7iC0diOy78iIGrvIHzW9HIga1yC1x48ZRuwtSs2SPtw9gi3+DTph7hGfqiPtXRkYmXnbxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcZ3BUcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BEFC4CEF5;
	Wed, 23 Jul 2025 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268305;
	bh=hjTxLTjeyfv1cmY9AM9rNrj/psDt2Jl7S1EiMR+M7Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcZ3BUcz2//co0w+VUYRX1MidwmLQVzCtw4mIFLU/aqJ02zRNJlD/8+7HA6YpwuAv
	 q3cJ6gwi1BWwlwDieusQKOTDf6bxpiIumuafU4/9Az0fippnf0a/D1NqXJRvLTbHqH
	 PnJPkruo84412/X87V4SQEpEQ1v0S9xr3bI1fyZr61SQS0Q+ttC9/4J5zUKcjIoqP0
	 nNjsMPf5jQDNFDuT+IUBeIXyOFiWQUaiqhUVOcXMcM4p3rGglTcoVjGp4CBGCj3khN
	 Q4KuapxRcW2HC3Sv1DzC/DoRnZWuXwFTw2qpLTWgPfRgN4BkVJIutcBc27/cz5+EAv
	 do22yaPlAkKOw==
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
Subject: [PATCH v4 07/15] fs: drop i_crypt_info from struct inode
Date: Wed, 23 Jul 2025 12:57:45 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-7-c8e11488a0e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601; i=brauner@kernel.org; h=from:subject:message-id; bh=hjTxLTjeyfv1cmY9AM9rNrj/psDt2Jl7S1EiMR+M7Hk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNCy3vrqXZeLrImSwP1M557MbUG2CdZz5r4tSivbk Svg6z+/o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ69xgZppp0FPKsEDTccSxv 9xF9feMv0jt83u0ry541zXHtFW39TIb/tRXe/3808Old4d8j7Ki98sJ8fcVg26flu1RSFyrmckl xAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that all filesystems store the fscrypt data pointer in their private
inode, drop the data pointer from struct inode itself freeing up 8
bytes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/crypto/keysetup.c    |  9 +++++----
 include/linux/fs.h      |  5 -----
 include/linux/fscrypt.h | 23 +++++++----------------
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 8fd89ce0b614..352d0cfda17d 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -799,10 +799,11 @@ void fscrypt_put_encryption_info(struct inode *inode)
 {
 	struct fscrypt_inode_info **crypt_info;
 
-	if (inode->i_sb->s_cop->inode_info_offs)
-		crypt_info = fscrypt_addr(inode);
-	else
-		crypt_info = &inode->i_crypt_info;
+	if (!IS_ENCRYPTED(inode))
+		return;
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop->inode_info_offs);
+	crypt_info = fscrypt_addr(inode);
 	put_crypt_info(*crypt_info);
 	*crypt_info = NULL;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..b76a10fc765b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -72,7 +72,6 @@ struct swap_info_struct;
 struct seq_file;
 struct workqueue_struct;
 struct iov_iter;
-struct fscrypt_inode_info;
 struct fscrypt_operations;
 struct fsverity_info;
 struct fsverity_operations;
@@ -778,10 +777,6 @@ struct inode {
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_inode_info	*i_crypt_info;
-#endif
-
 #ifdef CONFIG_FS_VERITY
 	struct fsverity_info	*i_verity_info;
 #endif
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 123871dd394c..a62879456873 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -208,28 +208,21 @@ static inline struct fscrypt_inode_info **fscrypt_addr(const struct inode *inode
 static inline bool fscrypt_set_inode_info(struct inode *inode,
 					  struct fscrypt_inode_info *crypt_info)
 {
-	void *p;
-
 	/*
 	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
 	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
 	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
 	 * a RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
-
-	if (inode->i_sb->s_cop->inode_info_offs)
-		p = cmpxchg_release(fscrypt_addr(inode), NULL, crypt_info);
-	else
-		p = cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info);
-	return p == NULL;
+	return cmpxchg_release(fscrypt_addr(inode), NULL, crypt_info) == NULL;
 }
 
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info_raw(const struct inode *inode)
 {
-	if (inode->i_sb->s_cop->inode_info_offs)
-		return *fscrypt_addr(inode);
-	return inode->i_crypt_info;
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop->inode_info_offs);
+	return *fscrypt_addr(inode);
 }
 
 static inline struct fscrypt_inode_info *
@@ -241,11 +234,9 @@ fscrypt_get_inode_info(const struct inode *inode)
 	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
 	 * ACQUIRE the memory the other task published.
 	 */
-
-	if (inode->i_sb->s_cop->inode_info_offs)
-		return smp_load_acquire(fscrypt_addr(inode));
-
-	return smp_load_acquire(&inode->i_crypt_info);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop->inode_info_offs);
+	return smp_load_acquire(fscrypt_addr(inode));
 }
 
 /**

-- 
2.47.2


