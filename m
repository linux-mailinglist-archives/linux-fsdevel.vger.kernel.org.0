Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127862A2A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 21:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiKOUUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 15:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKOUUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:20:12 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74E2495F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 12:20:11 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso11007312wmk.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZTI3MBvJUKftMBIuqIfZDhk1MLqSSScMjtTeea1qXbs=;
        b=Ik9WJSz677x4mKzyo9Cp9Gy2ZsfMCCf/lyv03MT6EvGvFo7V54HjqA0Zs8rSfLBN0S
         VBH1PlCA43C6Z6CrbYpBBfsG+M/Zgpne+yjPu1z/T4K9NB2C1DX1kOo0mX1yam7BsGl4
         UW8RjLqErsEqM5OvAmcZwKF02K2ZsIgxGhiwDencWVL2ZMyb8zAE52OMPJ5jLO4Nw6Tv
         kWkE3LwjP2Ld5HHJ6YhVmqQjvlr4eSO07RnMBK5Q+LRphYfYnoeACm4DjN5ByisuP5HC
         NNGNu33QKj15we5lkaYCNNuiEcSUiukC9wQxgGUBIseBEo3Eral+oh4ovw1j46Di99EB
         Y/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTI3MBvJUKftMBIuqIfZDhk1MLqSSScMjtTeea1qXbs=;
        b=3CXGQJCTyTbWEZZI25cM9nxRxsn/PmRKrNTeSZbIZ1MEZqjz2SZZ7f4NrUAvi2HFx+
         JcEdLXI5bSO8bs9sQCdBbgLakHwaV1RiH/YfNCs6i+M1Zk2D0j4IT3KIbXNJ31PSSd9n
         bbEfPkFqSiGwJ7yzdMFmkMOnzoAECnlcfH1OheU0ZiP9DGcmmtdqSducNZSCuiL52dO2
         eYxANuy2TmCyOrlL34CEJnhl1ekwp4ZB1ho9Rx0MD0EYKGhlaX0cxjS2/HzMVGpEoYE8
         QTw53mzlRIbldF/1NQbUAcu5g2keVCOaTv9kLcwpOaY22GPKbD4kiDufupldHvPROI43
         ZbNA==
X-Gm-Message-State: ANoB5pn/5M329Yca/KrDKcaYHRsLqifT2bP5ksTVJhxRk7XWmtIoZjWA
        gP7H5ID+WcY8igFGYSdjKbxfzV/OZOFpvs3H
X-Google-Smtp-Source: AA0mqf5s7NpTHFmqs1uZ4AxO8HtUoNpSxzIIv7Fxd+4+gy5jrrPwcImYESvUyWyKWNl1pnvLbmSQWeX8sz+jIcN/
X-Received: from fkdev.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:3506])
 (user=feldsherov job=sendgmr) by 2002:a05:600c:3b19:b0:3cf:7514:a80d with
 SMTP id m25-20020a05600c3b1900b003cf7514a80dmr7839wms.0.1668543609492; Tue,
 15 Nov 2022 12:20:09 -0800 (PST)
Date:   Tue, 15 Nov 2022 20:20:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115202001.324188-1-feldsherov@google.com>
Subject: [PATCH v3] fs: do not update freeing inode i_io_list
From:   Svyatoslav Feldsherov <feldsherov@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Svyatoslav Feldsherov <feldsherov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
already has I_DIRTY_INODE") writeback_single_inode can push inode with
I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
I_DIRTY_TIME set this can happen after deletion of inode from i_io_list
at evict. Stack trace is following.

evict
fat_evict_inode
fat_truncate_blocks
fat_flush_inodes
writeback_inode
sync_inode_metadata(inode, sync=0)
writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE

This will lead to use after free in flusher thread.

Similar issue can be triggered if writeback_single_inode in the
stack trace update inode->i_io_list. Add explicit check to avoid it.

Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
---
 V2 -> V3:
 - fix grammar in commit message and comments

 V1 -> V2: 
 - address review comments
 - skip inode_cgwb_move_to_attached for freeing inode 

 fs/fs-writeback.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..9958d4020771 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 	/*
-	 * If the inode is now fully clean, then it can be safely removed from
-	 * its writeback list (if any).  Otherwise the flusher threads are
-	 * responsible for the writeback lists.
+	 * If the inode is freeing, its i_io_list shoudn't be updated
+	 * as it can be finally deleted at this moment.
 	 */
-	if (!(inode->i_state & I_DIRTY_ALL))
-		inode_cgwb_move_to_attached(inode, wb);
-	else if (!(inode->i_state & I_SYNC_QUEUED)) {
-		if ((inode->i_state & I_DIRTY))
-			redirty_tail_locked(inode, wb);
-		else if (inode->i_state & I_DIRTY_TIME) {
-			inode->dirtied_when = jiffies;
-			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+	if (!(inode->i_state & I_FREEING)) {
+		/*
+		 * If the inode is now fully clean, then it can be safely
+		 * removed from its writeback list (if any). Otherwise the
+		 * flusher threads are responsible for the writeback lists.
+		 */
+		if (!(inode->i_state & I_DIRTY_ALL))
+			inode_cgwb_move_to_attached(inode, wb);
+		else if (!(inode->i_state & I_SYNC_QUEUED)) {
+			if ((inode->i_state & I_DIRTY))
+				redirty_tail_locked(inode, wb);
+			else if (inode->i_state & I_DIRTY_TIME) {
+				inode->dirtied_when = jiffies;
+				inode_io_list_move_locked(inode,
+							  wb,
+							  &wb->b_dirty_time);
+			}
 		}
 	}
 
-- 
2.38.1.431.g37b22c650d-goog

