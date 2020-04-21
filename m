Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48F1B2212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 10:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDUIyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 04:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUIyu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9B2DAC92;
        Tue, 21 Apr 2020 08:54:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 313F41E0E3B; Tue, 21 Apr 2020 10:54:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] fs: Avoid leaving freed inode on dirty list
Date:   Tue, 21 Apr 2020 10:54:43 +0200
Message-Id: <20200421085445.5731-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200421085445.5731-1-jack@suse.cz>
References: <20200421085445.5731-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

evict() can race with writeback_sb_inodes() and so
list_empty(&inode->i_io_list) check can race with list_move() from
redirty_tail() possibly resulting in list_empty() returning false and
thus we end up leaving freed inode in wb->b_dirty list leading to
use-after-free issues.

Fix the problem by using list_empty_careful() check and add assert that
inode's i_io_list is empty in clear_inode() to catch the problem earlier
in the future.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..a73c8a7aa71a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -534,6 +534,7 @@ void clear_inode(struct inode *inode)
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(inode->i_state & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
+	BUG_ON(!list_empty(&inode->i_io_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
 	inode->i_state = I_FREEING | I_CLEAR;
 }
@@ -559,7 +560,13 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
-	if (!list_empty(&inode->i_io_list))
+	/*
+	 * We are the only holder of the inode so it cannot be marked dirty.
+	 * Flusher thread won't start new writeback but there can be still e.g.
+	 * redirty_tail() running from writeback_sb_inodes(). So we have to be
+	 * careful to remove inode from dirty/io list in all the cases.
+	 */
+	if (!list_empty_careful(&inode->i_io_list))
 		inode_io_list_del(inode);
 
 	inode_sb_list_del(inode);
-- 
2.16.4

