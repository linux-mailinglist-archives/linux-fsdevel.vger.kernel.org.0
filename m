Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF052F399B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406633AbhALTFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406589AbhALTF3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:05:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44D8F23134;
        Tue, 12 Jan 2021 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478252;
        bh=6FqWuQrXV+HGHkzTR42Ape3on4H7NKo1rahsTeQDI4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZNZ7JkkNHWRoE3L2XHIBFGDbwLmXQ+WYmrSQ2HH5mrAH3MtFyOQ0LJ3XzuG+BY4y
         Ji+rdyAJ/Veytz+4dA94ERGnUigqHy0UnTkMBHX3hMM1lpgpo62tkwB8hq57YCbBS2
         mSpxDL4QT3QnH5GgvYEHuAvdrKqC/sWHNDwlpy7hlUjEyBW/VUJPoonFZt7omR5ygJ
         u+3VdJWj6zeBFzD0LHf+ThYBySvpcxA7LHRs2EujZ9L/va74iZnRNhyVvauDdUf+To
         kefvDtvLXHBcCaVR/JzpiX8n8OVbP6jRDf4CZ8F0mW0jGMkcAqjwaEqOQF2vg/QhvM
         gWcEr3/JZZHjA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 11/11] ext4: simplify i_state checks in __ext4_update_other_inode_time()
Date:   Tue, 12 Jan 2021 11:02:53 -0800
Message-Id: <20210112190253.64307-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since I_DIRTY_TIME and I_DIRTY_INODE are mutually exclusive in i_state,
there's no need to check for I_DIRTY_TIME && !I_DIRTY_INODE.  Just check
for I_DIRTY_TIME.

Also introduce a helper function in include/linux/fs.h to do this check.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c    |  8 ++------
 include/linux/fs.h | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4cc6c7834312f..d809a06b6ef7f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4961,15 +4961,11 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 	if (!inode)
 		return;
 
-	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
-			       I_DIRTY_INODE)) ||
-	    ((inode->i_state & I_DIRTY_TIME) == 0))
+	if (!inode_is_dirtytime_only(inode))
 		return;
 
 	spin_lock(&inode->i_lock);
-	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
-				I_DIRTY_INODE)) == 0) &&
-	    (inode->i_state & I_DIRTY_TIME)) {
+	if (inode_is_dirtytime_only(inode)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
 		inode->i_state &= ~I_DIRTY_TIME;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45a0303b2aeb6..de0c789104c26 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2194,6 +2194,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+/*
+ * Returns true if the given inode itself only has dirty timestamps (its pages
+ * may still be dirty) and isn't currently being allocated or freed.
+ * Filesystems should call this if when writing an inode when lazytime is
+ * enabled, they want to opportunistically write the timestamps of other inodes
+ * located very nearby on-disk, e.g. in the same inode block.  This returns true
+ * if the given inode is in need of such an opportunistic update.  Requires
+ * i_lock, or at least later re-checking under i_lock.
+ */
+static inline bool inode_is_dirtytime_only(struct inode *inode)
+{
+	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
+				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+}
+
 extern void inc_nlink(struct inode *inode);
 extern void drop_nlink(struct inode *inode);
 extern void clear_nlink(struct inode *inode);
-- 
2.30.0

