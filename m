Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA31D3927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENSeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 14:34:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:57264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgENSeB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 14:34:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3807EADFE;
        Thu, 14 May 2020 18:34:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E3E51E04CF; Thu, 14 May 2020 20:26:29 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Check freed inode is not left on dirty list
Date:   Thu, 14 May 2020 20:26:17 +0200
Message-Id: <20200514182617.20087-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add check that freed inode is not left on dirty list. ext4 had a bug
that could do that resulting in difficult to debug use-after-free issues
with inodes. Also add a comment in evict() explaining why dirty list
handling there is safe.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..15260b6d5590 100644
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
@@ -559,6 +560,13 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
+	/*
+	 * We are the only holder of the inode so it cannot be marked dirty.
+	 * Flusher thread won't start new writeback because I_FREEING is set
+	 * but there can be still redirty_tail() running from
+	 * writeback_sb_inodes(). However this list_move() cannot result in
+	 * list_empty() returning true.
+	 */
 	if (!list_empty(&inode->i_io_list))
 		inode_io_list_del(inode);
 
-- 
2.16.4

