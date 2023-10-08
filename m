Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079DA7BCB36
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 02:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjJHAxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 20:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjJHAxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:53:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6B198B;
        Sat,  7 Oct 2023 17:49:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F73C433AD;
        Sun,  8 Oct 2023 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726195;
        bh=ZjCh8/FJjF3WMsH6UnPMzA0/YZG7x4p2NFD2leXaqCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0Ermj/lhkC192LLQBKMpD+aS+iS6sLbSsuTYI1PhkgUIBnVVv/blGngyMrlaJk6I
         8zhQuY32Y+ziXMcS13xwu1nIRmaDAzTia1Azlmzp06UUTQv6DK+L/aBADLPloI+dcI
         4CLcA0httfsX0Rrf820NUdw88XZESH3sUqlimOWjfSeL8IrUB23BiyzycLDjComu+l
         HP8iwM44QTy1Ci41Ri6+/F77i0KzNSWlymo1SY39EXjprC6KRXJFVi/kf/e3M85ErC
         mxra3zYVAnWoqwMz2wyikb7thBNS9okHAeQGUzNXYITMbeC4+20tzPq/+KrAqkBeCX
         LKGPLZvSpgctw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/10] fs-writeback: do not requeue a clean inode having skipped pages
Date:   Sat,  7 Oct 2023 20:49:41 -0400
Message-Id: <20231008004950.3768189-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004950.3768189-1-sashal@kernel.org>
References: <20231008004950.3768189-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.134
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chunhai Guo <guochunhai@vivo.com>

[ Upstream commit be049c3a088d512187407b7fd036cecfab46d565 ]

When writing back an inode and performing an fsync on it concurrently, a
deadlock issue may arise as shown below. In each writeback iteration, a
clean inode is requeued to the wb->b_dirty queue due to non-zero
pages_skipped, without anything actually being written. This causes an
infinite loop and prevents the plug from being flushed, resulting in a
deadlock. We now avoid requeuing the clean inode to prevent this issue.

    wb_writeback        fsync (inode-Y)
blk_start_plug(&plug)
for (;;) {
  iter i-1: some reqs with page-X added into plug->mq_list // f2fs node page-X with PG_writeback
                        filemap_fdatawrite
                          __filemap_fdatawrite_range // write inode-Y with sync_mode WB_SYNC_ALL
                           do_writepages
                            f2fs_write_data_pages
                             __f2fs_write_data_pages // wb_sync_req[DATA]++ for WB_SYNC_ALL
                              f2fs_write_cache_pages
                               f2fs_write_single_data_page
                                f2fs_do_write_data_page
                                 f2fs_outplace_write_data
                                  f2fs_update_data_blkaddr
                                   f2fs_wait_on_page_writeback
                                     wait_on_page_writeback // wait for f2fs node page-X
  iter i:
    progress = __writeback_inodes_wb(wb, work)
    . writeback_sb_inodes
    .   __writeback_single_inode // write inode-Y with sync_mode WB_SYNC_NONE
    .   . do_writepages
    .   .   f2fs_write_data_pages
    .   .   .  __f2fs_write_data_pages // skip writepages due to (wb_sync_req[DATA]>0)
    .   .   .   wbc->pages_skipped += get_dirty_pages(inode) // wbc->pages_skipped = 1
    .   if (!(inode->i_state & I_DIRTY_ALL)) // i_state = I_SYNC | I_SYNC_QUEUED
    .    total_wrote++;  // total_wrote = 1
    .   requeue_inode // requeue inode-Y to wb->b_dirty queue due to non-zero pages_skipped
    if (progress) // progress = 1
      continue;
  iter i+1:
      queue_io
      // similar process with iter i, infinite for-loop !
}
blk_finish_plug(&plug)   // flush plug won't be called

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Message-Id: <20230916045131.957929-1-guochunhai@vivo.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c76537a6826a7..5f0abea107e46 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1557,10 +1557,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 
 	if (wbc->pages_skipped) {
 		/*
-		 * writeback is not making progress due to locked
-		 * buffers. Skip this inode for now.
+		 * Writeback is not making progress due to locked buffers.
+		 * Skip this inode for now. Although having skipped pages
+		 * is odd for clean inodes, it can happen for some
+		 * filesystems so handle that gracefully.
 		 */
-		redirty_tail_locked(inode, wb);
+		if (inode->i_state & I_DIRTY_ALL)
+			redirty_tail_locked(inode, wb);
+		else
+			inode_cgwb_move_to_attached(inode, wb);
 		return;
 	}
 
-- 
2.40.1

