Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7A778B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjHKKLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjHKKKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD7935BC;
        Fri, 11 Aug 2023 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TfXf3rA/PGmh51lRw9XZCTKP64O/GfZ4zbLGJbB3SHI=; b=MNGF7jGfwxDH36Qic3Fz1xl09l
        GmgK5zJuj3hVSNHhedykMUuZSoP5/NOMHSjgzzZbc/q87WJKW4TQEU1te8Ja+pUBnNkvgDLQXP6Dm
        wVT7B6DnAN39z1QOUst8ysCKadJ4AIxRloZbpCKZosjSYZp/yOy9XcdJE6BCB8la+DkR4M+tVfWQt
        1VU98T2wUocyuCNOM/6EUJYZMRRvHejA9zEZxxY+k1FfSwfuO2YKjdaG/h8I1j21BJLakfqLBJTew
        lEnypaUD2w3NshOUPzTBxRXs/dKY0lHyTMTLAyTcJd2WQEMAE2nMywgmpJXDJ1H5CR0qQzltoLuzS
        YsoZ5aqQ==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP58-00A5v0-0n;
        Fri, 11 Aug 2023 10:09:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/17] fs: simplify invalidate_inodes
Date:   Fri, 11 Aug 2023 12:08:28 +0200
Message-Id: <20230811100828.1897174-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kill_dirty has always been true for a long time, so hard code it and
remove the unused return value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/inode.c    | 16 ++--------------
 fs/internal.h |  2 +-
 fs/super.c    |  2 +-
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84a9..fd67ca46415d50 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -754,14 +754,10 @@ EXPORT_SYMBOL_GPL(evict_inodes);
  * @sb:		superblock to operate on
  * @kill_dirty: flag to guide handling of dirty inodes
  *
- * Attempts to free all inodes for a given superblock.  If there were any
- * busy inodes return a non-zero value, else zero.
- * If @kill_dirty is set, discard dirty inodes too, otherwise treat
- * them as busy.
+ * Attempts to free all inodes (including dirty inodes) for a given superblock.
  */
-int invalidate_inodes(struct super_block *sb, bool kill_dirty)
+void invalidate_inodes(struct super_block *sb)
 {
-	int busy = 0;
 	struct inode *inode, *next;
 	LIST_HEAD(dispose);
 
@@ -773,14 +769,8 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		if (inode->i_state & I_DIRTY_ALL && !kill_dirty) {
-			spin_unlock(&inode->i_lock);
-			busy = 1;
-			continue;
-		}
 		if (atomic_read(&inode->i_count)) {
 			spin_unlock(&inode->i_lock);
-			busy = 1;
 			continue;
 		}
 
@@ -798,8 +788,6 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
-
-	return busy;
 }
 
 /*
diff --git a/fs/internal.h b/fs/internal.h
index f7a3dc11102647..b94290f61714a0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -201,7 +201,7 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
  * fs-writeback.c
  */
 extern long get_nr_dirty_inodes(void);
-extern int invalidate_inodes(struct super_block *, bool);
+void invalidate_inodes(struct super_block *sb);
 
 /*
  * dcache.c
diff --git a/fs/super.c b/fs/super.c
index d3d27ff009d5f6..500c5308f2c8a0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1204,7 +1204,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	if (!surprise)
 		sync_filesystem(sb);
 	shrink_dcache_sb(sb);
-	invalidate_inodes(sb, true);
+	invalidate_inodes(sb);
 	if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
 
-- 
2.39.2

