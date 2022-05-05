Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A851C13D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352094AbiEENwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379994AbiEENwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 09:52:04 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24257994;
        Thu,  5 May 2022 06:48:19 -0700 (PDT)
Received: from SHSend.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by SHSQR01.spreadtrum.com with ESMTPS id 245Dlgb1015983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 5 May 2022 21:47:42 +0800 (CST)
        (envelope-from Jing.Xia@unisoc.com)
Received: from bj08259pcu.spreadtrum.com (10.0.74.59) by
 shmbx04.spreadtrum.com (10.0.1.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 5 May 2022 21:47:44 +0800
From:   Jing Xia <jing.xia@unisoc.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <jack@suse.cz>, <jing.xia@unisoc.com>, <jing.xia.mail@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] writeback: Avoid skipping inode writeback
Date:   Thu, 5 May 2022 21:47:31 +0800
Message-ID: <20220505134731.5295-1-jing.xia@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.59]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 245Dlgb1015983
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have run into an issue that a task gets stuck in
balance_dirty_pages_ratelimited() when perform I/O stress testing.
The reason we observed is that an I_DIRTY_PAGES inode with lots
of dirty pages is in b_dirty_time list and standard background
writeback cannot writeback the inode.
After studing the relevant code, the following scenario may lead
to the issue:

task1                                   task2
-----                                   -----
fuse_flush
 write_inode_now //in b_dirty_time
  writeback_single_inode
   __writeback_single_inode
                                 fuse_write_end
                                  filemap_dirty_folio
                                   __xa_set_mark:PAGECACHE_TAG_DIRTY
    lock inode->i_lock
    if mapping tagged PAGECACHE_TAG_DIRTY
    inode->i_state |= I_DIRTY_PAGES
    unlock inode->i_lock
                                   __mark_inode_dirty:I_DIRTY_PAGES
                                      lock inode->i_lock
                                      -was dirty,inode stays in
                                      -b_dirty_time
                                      unlock inode->i_lock

   if(!(inode->i_state & I_DIRTY_All))
      -not true,so nothing done

This patch moves the dirty inode to b_dirty list when the inode
currently is not queued in b_io or b_more_io list at the end of
writeback_single_inode.

Signed-off-by: Jing Xia <jing.xia@unisoc.com>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..d7763feaf14a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1712,6 +1712,9 @@ static int writeback_single_inode(struct inode *inode,
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
 		inode_cgwb_move_to_attached(inode, wb);
+	else if (!(inode->i_state & I_SYNC_QUEUED) && (inode->i_state & I_DIRTY))
+		redirty_tail_locked(inode, wb);
+
 	spin_unlock(&wb->list_lock);
 	inode_sync_complete(inode);
 out:
-- 
2.17.1

