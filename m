Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72D628B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 22:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiKNVXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 16:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiKNVXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:23:40 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDDC5FBA
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 13:23:39 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso6794427wms.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 13:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2s5p7qUTZoX+xCiO6iUkhANRSk/2v5qgG9igFsxp65M=;
        b=S2Kj3NDMntV93G0ZGOxCLd15RWQhiWng/uuFCMn+z5aAJGDLzXGR6qRQ47yO+p98ro
         F72bMYkbKOngtGU2MEr3YF9SERzf8wjuRoXDxhAAiO84bP8i5xdMDr8MvkxipXuhi2Ns
         YALre42dFlZ/SoncAScMZXjCC5WuhU//Zjb6Sqss5iRz47cj3LVzKEjEMPR8xiTy8A6O
         zw0ONphrScEMXVCo1d5q59zibgd2n/UfGY8jlqxanJgf265SdsZzvJWVVdbn0hF/vds8
         LqmifXWvjIqfLLnvNwZJ8cw+qMzGjg/JfksX2547mWdENWGrvPMl3tz3bwligeBBi3G3
         9rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2s5p7qUTZoX+xCiO6iUkhANRSk/2v5qgG9igFsxp65M=;
        b=ag848cAuhVjFpWQfjGgzuAT5lkSaLouRAzQGL5COomUsDR6VdObTd0DWcgpeeYqQ+H
         LojynDaARO1I0fXfTTnprmzBNFHnvTKl3eV3NbnT1wyiHsIuKu89sq5hfdaB4DorTaAr
         WfAhKKQV73BDA5fvSr9i/F6QM6736+gjhqf+3XvYojrpkWOhfKvdkm25gyQjaDZLk+Dy
         otFHu4tZOJXVm5nKXEsHwDtXQh77HxGNh72E6njlUePOvkPGIIpCIdGC5tdb8xPdi+EV
         Qva8Razt1htQ0h2izuxt7U7358icDLjV75q5RoBHMGpG+Tk9gCq3dMoIwDuFshs5/Owq
         LBDw==
X-Gm-Message-State: ANoB5plwQgfl40kuYjBT5vLemegB/TOWNWfovv6j/62zjApevR8B230s
        jkUAItu8wiGQa9IEGsM24BzkgshWtbx79zsD
X-Google-Smtp-Source: AA0mqf5EKCmkWZGF7y09cx0NacbNwoDjdVtNzN9rOEgej1Z8TUySZKlbZtnG1/6nuy2Hj79ADAXRNWdMt6C1GGPQ
X-Received: from fkdev.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:3506])
 (user=feldsherov job=sendgmr) by 2002:a05:600c:35c6:b0:3c2:7211:732e with
 SMTP id r6-20020a05600c35c600b003c27211732emr9326994wmq.191.1668461018405;
 Mon, 14 Nov 2022 13:23:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:21:55 +0000
In-Reply-To: <20221114192129.zkmubc6pmruuzkc7@quack3>
Mime-Version: 1.0
References: <20221114192129.zkmubc6pmruuzkc7@quack3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114212155.221829-1-feldsherov@google.com>
Subject: [PATCH v2] fs: do not update freeing inode io_list
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
already has I_DIRTY_INODE") writeiback_single_inode can push inode with
I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
I_DIRTY_TIME set this can happened after deletion of inode io_list at
evict. Stack trace is following.

evict
fat_evict_inode
fat_truncate_blocks
fat_flush_inodes
writeback_inode
sync_inode_metadata(inode, sync=0)
writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE

This will lead to use after free in flusher thread.

Similar issue can be triggered if writeback_single_inode in the
stack trace update inode->io_list. Add explicit check to avoid it.

Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
---
 V1 -> V2: 
 - address review comments
 - skip inode_cgwb_move_to_attached for freeing inode 

 fs/fs-writeback.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..c4aea096689c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 	/*
-	 * If the inode is now fully clean, then it can be safely removed from
-	 * its writeback list (if any).  Otherwise the flusher threads are
-	 * responsible for the writeback lists.
+	 * If the inode is freeing, it's io_list shoudn't be updated
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

