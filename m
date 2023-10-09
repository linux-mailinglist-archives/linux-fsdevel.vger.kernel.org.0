Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD537BDC2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376431AbjJIMem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346668AbjJIMec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8133F4;
        Mon,  9 Oct 2023 05:33:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C54FC433C7;
        Mon,  9 Oct 2023 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696854838;
        bh=vL7gXeaL011kYTMUYatRQTiyf0pSn/dtrKj6ZXAphQQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZT8o+VZJcIzri/iCDJzVZTrfdAbhcekGlsGvsz4NMjRg3yVVbdATL8/iIC62Ra692
         PDPn8CXxibOemoqXElv+/sZeklaJ0wVnc7jU10uZusFT8IZDjccg7pblkMTf8ue4eD
         QqPN7sNhhlctwp/hddMudFIGNc+EGPtOwmsF2gvqC0DIkFvSMXxNTa0XTIRZhPEsBe
         8JFm1C5pZdaeBBbL5nB47gF71Kwnwcivwxq57X0/ZHGl0u4EL3NSwFlcO3IJorKbF9
         jll761Wo1XvWMHA7uZOzNNnl7nKymm3rZ73fIsR27aTFd31podvp5PcyWuebPOwRMW
         dpEu+1zUcPfFg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 09 Oct 2023 14:33:40 +0200
Subject: [PATCH 3/4] reiserfs: centralize journal device closing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-vfs-fixes-reiserfs-v1-3-723a2f1132ce@kernel.org>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vL7gXeaL011kYTMUYatRQTiyf0pSn/dtrKj6ZXAphQQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQqf9YPmTRdk8/MTfGSm/utyNd6cyJuOu8Tqrg9pUzZ2X+D
 /PzujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn8+cjwz2zSti9+Gx/aL9/2XPNO5J
 X5/fPSvp3+90DNZqWd3Qszy3OMDPP3Nz2dHXR8d3rWrI8cjCHu+xXc1n+OnHZS8byfrdaWBTwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the journal device is closed in multiple locations:

* in reiserfs_fill_super() if reiserfs_fill_super() fails
* in reiserfs_put_super() when reiserfs is shut down and
  reiserfs_fill_super() had succeeded

Stop duplicating this logic and always kill the journal device in
reiserfs_kill_b().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/reiserfs/journal.c  | 18 ++++++++----------
 fs/reiserfs/reiserfs.h |  2 ++
 fs/reiserfs/super.c    |  4 ++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index b9d9bf26d108..e001a96fc76c 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -90,8 +90,6 @@ static int flush_commit_list(struct super_block *s,
 static int can_dirty(struct reiserfs_journal_cnode *cn);
 static int journal_join(struct reiserfs_transaction_handle *th,
 			struct super_block *sb);
-static void release_journal_dev(struct super_block *super,
-			       struct reiserfs_journal *journal);
 static void dirty_one_transaction(struct super_block *s,
 				 struct reiserfs_journal_list *jl);
 static void flush_async_commits(struct work_struct *work);
@@ -1889,12 +1887,6 @@ static void free_journal_ram(struct super_block *sb)
 	if (journal->j_header_bh) {
 		brelse(journal->j_header_bh);
 	}
-	/*
-	 * j_header_bh is on the journal dev, make sure
-	 * not to release the journal dev until we brelse j_header_bh
-	 */
-	release_journal_dev(sb, journal);
-	vfree(journal);
 }
 
 /*
@@ -2587,13 +2579,19 @@ static void journal_list_init(struct super_block *sb)
 	SB_JOURNAL(sb)->j_current_jl = alloc_journal_list(sb);
 }
 
-static void release_journal_dev(struct super_block *super,
-			       struct reiserfs_journal *journal)
+void reiserfs_release_journal_dev(struct super_block *super,
+				  struct reiserfs_journal *journal)
 {
 	if (journal->j_dev_bd != NULL) {
 		blkdev_put(journal->j_dev_bd, super);
 		journal->j_dev_bd = NULL;
 	}
+
+	/*
+	 * j_header_bh is on the journal dev, make sure not to release
+	 * the journal dev until we brelse j_header_bh
+	 */
+	vfree(journal);
 }
 
 static int journal_init_dev(struct super_block *super,
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 7d12b8c5b2fa..dd5d69c25e32 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3414,3 +3414,5 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long reiserfs_compat_ioctl(struct file *filp,
 		   unsigned int cmd, unsigned long arg);
 int reiserfs_unpack(struct inode *inode);
+void reiserfs_release_journal_dev(struct super_block *super,
+				  struct reiserfs_journal *journal);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 6db8ed10a78d..c04d9a4427e5 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -550,6 +550,7 @@ int remove_save_link(struct inode *inode, int truncate)
 static void reiserfs_kill_sb(struct super_block *s)
 {
 	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
+	struct reiserfs_journal *journal = NULL;
 
 	if (sbi) {
 		reiserfs_proc_info_done(s);
@@ -567,10 +568,13 @@ static void reiserfs_kill_sb(struct super_block *s)
 		sbi->xattr_root = NULL;
 		dput(sbi->priv_root);
 		sbi->priv_root = NULL;
+		journal = SB_JOURNAL(s);
 	}
 
 	kill_block_super(s);
 
+	if (journal)
+		reiserfs_release_journal_dev(s, journal);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 }

-- 
2.34.1

