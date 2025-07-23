Return-Path: <linux-fsdevel+bounces-55815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7AB0F09F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AF1AC119F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18712DEA93;
	Wed, 23 Jul 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx+1EakA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D952D8767;
	Wed, 23 Jul 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268327; cv=none; b=eALru81ceckA9jJsLMmSWviK+A5XDFM8Fp4X7HYSzl1YS16QgwKfVN9u8jcT/FrWaAn8OqIqXXOfvuFFY8yPZNONiNqs7o8SkhELLMfSy8S0bwGi75u9RKmbYSOn1at+1ZUxjnty26giHFXkj3IDeTh9RB53j3JexfikGKLecx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268327; c=relaxed/simple;
	bh=aWn9hikPCAPbrL31ZHq5BjXrDhpap4X/FU14oahmHsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaDVws9GsVYp1DkFlqm1uIlPVwTYB6YNZN69WFgCEQZ88FkxHz/r9EINvjphIfGnSDcJ8YjZSuDNp1CB3lqEMJOzpJ/Zbt88FWcaM5v7shT10bXSqbWzfwIvd5pMzNGYVJL1a71dH3i+IUNsd/ZDkE0pMGh3MznYZExO15Ehssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx+1EakA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48381C4CEF6;
	Wed, 23 Jul 2025 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268327;
	bh=aWn9hikPCAPbrL31ZHq5BjXrDhpap4X/FU14oahmHsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sx+1EakAui5CJajcV9yYu8LzuEugl8tFR7TZ06Ig269IWzHFDLzBKjuQR2idGWjNH
	 FCeNIZPvnUbHPsYk9BHo2TP7RQYw4Jk2U9Jf1KzXriOYaSAQrO68umynVsJm8nIe3f
	 pMUnWR/6EapI8qPVuDNajJcJqTJblGeRBn1ufw0tA5wU8dq4Xf7rmWYc3KRtABSxzb
	 knGAVhOO5Rb8wd1pmup/DQZbhAKHqzc1vAP1iOXvCvfvYZA8WTriHah26gd+rbW7o8
	 qZ3G1O/QslzFgBTvZXKSD6j0BT3k2Pjh8iFCeRWffqs3XQuEbY2T0rqDCzIa4fDk1g
	 +SMP+km2bRuYQ==
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
Subject: [PATCH v4 14/15] fs: drop i_verity_info from struct inode
Date: Wed, 23 Jul 2025 12:57:52 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-14-c8e11488a0e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639; i=brauner@kernel.org; h=from:subject:message-id; bh=aWn9hikPCAPbrL31ZHq5BjXrDhpap4X/FU14oahmHsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNA+fP7qDvtv8x7em/DxZeU20TXTWTJcuA7ttFryi 2WfX9RG+Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICLVDH8U685OGup4zy2Na2a F3/t7I7prL6TXblhUe3Z89s27lt+6Awjw/ITJU948+zUme4v49PU9eVfXfaqauU8/osPTO22dOl NZQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that all filesystems store the fsverity data pointer in their
private inode, drop the data pointer from struct inode itself freeing up
8 bytes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/verity/open.c         | 18 ++++++------------
 include/linux/fs.h       |  5 -----
 include/linux/fsverity.h | 11 +++++++----
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index a4d7388e2f71..0dcd33f00361 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -250,20 +250,15 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
 {
-	void *p;
-
 	/*
 	 * Multiple tasks may race to set ->i_verity_info, so use
 	 * cmpxchg_release().  This pairs with the smp_load_acquire() in
 	 * fsverity_get_info().  I.e., here we publish ->i_verity_info with a
 	 * RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
-
-	if (inode->i_sb->s_vop->inode_info_offs)
-		p = cmpxchg_release(fsverity_addr(inode), NULL, vi);
-	else
-		p = cmpxchg_release(&inode->i_verity_info, NULL, vi);
-	if (p != NULL) {
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop->inode_info_offs);
+	if (cmpxchg_release(fsverity_addr(inode), NULL, vi) != NULL) {
 		/* Lost the race, so free the fsverity_info we allocated. */
 		fsverity_free_info(vi);
 		/*
@@ -411,10 +406,9 @@ void __fsverity_cleanup_inode(struct inode *inode)
 {
 	struct fsverity_info **vi;
 
-	if (inode->i_sb->s_vop->inode_info_offs)
-		vi = fsverity_addr(inode);
-	else
-		vi = &inode->i_verity_info;
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop->inode_info_offs);
+	vi = fsverity_addr(inode);
 	fsverity_free_info(*vi);
 	*vi = NULL;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b76a10fc765b..cb249b6646f3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -73,7 +73,6 @@ struct seq_file;
 struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_operations;
-struct fsverity_info;
 struct fsverity_operations;
 struct fsnotify_mark_connector;
 struct fsnotify_sb_info;
@@ -777,10 +776,6 @@ struct inode {
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info	*i_verity_info;
-#endif
-
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 75ff6c9c50ef..0ee5b2fea389 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -136,7 +136,11 @@ static inline struct fsverity_info **fsverity_addr(const struct inode *inode)
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
-	if (!inode->i_sb->s_vop)
+	/*
+	 * We're called from fsverity_active() which might be called on
+	 * inodes from filesystems that don't support fsverity at all.
+	 */
+	if (likely(!inode->i_sb->s_vop))
 		return NULL;
 
 	/*
@@ -145,9 +149,8 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
 	 * to safely ACQUIRE the memory the other task published.
 	 */
-	if (inode->i_sb->s_vop->inode_info_offs)
-		return smp_load_acquire(fsverity_addr(inode));
-	return smp_load_acquire(&inode->i_verity_info);
+	VFS_WARN_ON_ONCE(!inode->i_sb->s_vop->inode_info_offs);
+	return smp_load_acquire(fsverity_addr(inode));
 }
 
 /* enable.c */

-- 
2.47.2


