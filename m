Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF27192850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgCYM2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 08:28:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgCYM2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eHCeht8Jl87loSG9fXCjdqcbTJKVdxCg8ZdFEYMWIr8=; b=uus+icWQcHSgAhoVsInQ++TwUI
        qDZjpBIzOwTvK1ys0gtNgZMNwLbEpGG+kCXKe1BpCKD/yrrceIcRvozFaFgfDrpFwWvAnN7oiy6zq
        mCXVDurYXZaCyFTKOpw5bG1a+BmrxjcUBMiu41iw96exliyRhjrSapCoqIleisGdAulAQVi5J+Bf9
        VQHrQGHnkRJy9Dci9+GOp2e5v06DmOQjXrFaCrMIXYeL2JoBxk9knaHgcXDB/0skewK8pto97zhig
        T5p/CqzfS8zKMU5afyd2Rl3n8Tc4iEpyoJsbsrU0HqTdGK2oqdMQXJsckOLHgmrLKFkypME5RXkT9
        SenBw6DQ==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH599-0003Ko-4c; Wed, 25 Mar 2020 12:28:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fs: don't call ->dirty_inode for lazytime timestamp updates
Date:   Wed, 25 Mar 2020 13:28:24 +0100
Message-Id: <20200325122825.1086872-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325122825.1086872-1-hch@lst.de>
References: <20200325122825.1086872-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to call into ->dirty_inode for lazytime timestamp
updates that use the I_DIRTY_TIME flag, as file systems per definition
must ignore them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/inode.c   | 8 +-------
 fs/f2fs/super.c   | 3 ---
 fs/fs-writeback.c | 8 +++-----
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..dbdcf3cc0e64 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5805,17 +5805,11 @@ void ext4_dirty_inode(struct inode *inode, int flags)
 {
 	handle_t *handle;
 
-	if (flags == I_DIRTY_TIME)
-		return;
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 	if (IS_ERR(handle))
-		goto out;
-
+		return;
 	ext4_mark_inode_dirty(handle, inode);
-
 	ext4_journal_stop(handle);
-out:
-	return;
 }
 
 int ext4_change_inode_journal_flag(struct inode *inode, int val)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 529334573944..5f3221ade64e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1091,9 +1091,6 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return;
 
-	if (flags == I_DIRTY_TIME)
-		return;
-
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		clear_inode_flag(inode, FI_AUTO_RECOVER);
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index dc2d65c765ae..482781da8be1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2252,16 +2252,14 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
 	 * dirty the inode itself
 	 */
-	if (flags & (I_DIRTY_INODE | I_DIRTY_TIME)) {
+	if (flags & I_DIRTY_INODE) {
 		trace_writeback_dirty_inode_start(inode, flags);
-
 		if (sb->s_op->dirty_inode)
 			sb->s_op->dirty_inode(inode, flags);
-
 		trace_writeback_dirty_inode(inode, flags);
-	}
-	if (flags & I_DIRTY_INODE)
+
 		flags &= ~I_DIRTY_TIME;
+	}
 	dirtytime = flags & I_DIRTY_TIME;
 
 	/*
-- 
2.25.1

