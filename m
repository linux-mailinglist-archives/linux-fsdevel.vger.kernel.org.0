Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC881B2211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgDUIyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 04:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgDUIyu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC380ACD0;
        Tue, 21 Apr 2020 08:54:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 395121E124D; Tue, 21 Apr 2020 10:54:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext4: Avoid freeing inodes on dirty list
Date:   Tue, 21 Apr 2020 10:54:45 +0200
Message-Id: <20200421085445.5731-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200421085445.5731-1-jack@suse.cz>
References: <20200421085445.5731-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we are evicting inode with journalled data, we may race with
transaction commit in the following way:

CPU0					CPU1
jbd2_journal_commit_transaction()	evict(inode)
					  inode_io_list_del()
					  inode_wait_for_writeback()
  process BJ_Forget list
    __jbd2_journal_insert_checkpoint()
    __jbd2_journal_refile_buffer()
      __jbd2_journal_unfile_buffer()
        if (test_clear_buffer_jbddirty(bh))
          mark_buffer_dirty(bh)
	    __mark_inode_dirty(inode)
					  ext4_evict_inode(inode)
					    frees the inode

This results in use-after-free issues in the writeback code (or
the assertion added in the previous commit triggering).

Fix the problem by removing inode from writeback lists once all the page
cache is evicted and so inode cannot be added to writeback lists again.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..d8a9d3da678c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -220,6 +220,16 @@ void ext4_evict_inode(struct inode *inode)
 		ext4_begin_ordered_truncate(inode, 0);
 	truncate_inode_pages_final(&inode->i_data);
 
+	/*
+	 * For inodes with journalled data, transaction commit could have
+	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
+	 * flag but we still need to remove the inode from the writeback lists.
+	 */
+	if (!list_empty_careful(&inode->i_io_list)) {
+		WARN_ON_ONCE(!ext4_should_journal_data(inode));
+		inode_io_list_del(inode);
+	}
+
 	/*
 	 * Protect us against freezing - iput() caller didn't have to have any
 	 * protection against it
-- 
2.16.4

