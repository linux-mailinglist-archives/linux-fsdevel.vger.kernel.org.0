Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB2523AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbiEKQxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiEKQxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 12:53:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816B167ED;
        Wed, 11 May 2022 09:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F2EB82527;
        Wed, 11 May 2022 16:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02BEC340EE;
        Wed, 11 May 2022 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652288021;
        bh=e9vbk1Pqaf3l9bUqYJpN10NAUUig8p2n65wo8lvfY7c=;
        h=From:To:Cc:Subject:Date:From;
        b=p3WRz7S2UkyN3pxwVr09s0NmSETrW0Q5CKXPOSe3oiinf94Em17VJbQCtOWaK5rr7
         i1yViJY4ZZ4+S5sF0i0aNSGIMAq/F2HQIfIbEGoDAUoXQ7rQwhLOLA5WgnFqWgwRow
         M9smy8pz9sBNJeudpxFpZHepn4SIIpwqFwL2IyQMjJ7MwzevGaTlv5mdaxpTJnjBGX
         s9a0RCjVtpqPlW/4PWn83uicLqBCwq35NESUv1t+7AlawYVuC2CGEtdokKksA59M/k
         Eyn/ThkSwUdKo/nyB/ChY1/TSgcDBDUYpVu9kD8gZAKh6ZB9EEfBSwRK1xzStBEzr4
         WHnPIg0T1eJjg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubli@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2] fs: change test in inode_insert5 for adding to the sb list
Date:   Wed, 11 May 2022 12:53:39 -0400
Message-Id: <20220511165339.85614-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode_insert5 currently looks at I_CREATING to decide whether to
insert the inode into the sb list. This test is a bit ambiguous though
as I_CREATING state is not directly related to that list.

This test is also problematic for some upcoming ceph changes to add
fscrypt support. We need to be able to allocate an inode using new_inode
and insert it into the hash later if we end up using it, and doing that
now means that we double add it and corrupt the list.

What we really want to know in this test is whether the inode is already
in its superblock list, and then add it if it isn't. Have it test for
list_empty instead and ensure that we always initialize the list by
doing it in inode_init_once. It's only ever removed from the list with
list_del_init, so that should be sufficient.

There doesn't seem to be any need to hold the inode_hash_lock for this
operation either, so drop that before adding to to the list.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

A small revision to the patch that I sent as part of the ceph+fscrypt
series. I didn't see any need to hold the inode_hash_lock when adding
the inode to the sb list, so do that outside the lock. I also revised
the comment to be more clear.

Al, I'm planning to merge this via the ceph tree since I have other
patches that depend on it. Let me know if you'd rather take this via
your tree instead.

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..9d429247a4f0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -422,6 +422,7 @@ void inode_init_once(struct inode *inode)
 	INIT_LIST_HEAD(&inode->i_io_list);
 	INIT_LIST_HEAD(&inode->i_wb_list);
 	INIT_LIST_HEAD(&inode->i_lru);
+	INIT_LIST_HEAD(&inode->i_sb_list);
 	__address_space_init_once(&inode->i_data);
 	i_size_ordered_init(inode);
 }
@@ -1021,7 +1022,6 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 		spin_lock(&inode->i_lock);
 		inode->i_state = 0;
 		spin_unlock(&inode->i_lock);
-		INIT_LIST_HEAD(&inode->i_sb_list);
 	}
 	return inode;
 }
@@ -1165,7 +1165,6 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 {
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	struct inode *old;
-	bool creating = inode->i_state & I_CREATING;
 
 again:
 	spin_lock(&inode_hash_lock);
@@ -1199,11 +1198,17 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
-	if (!creating)
-		inode_sb_list_add(inode);
 unlock:
 	spin_unlock(&inode_hash_lock);
 
+	/*
+	 * Add it to the sb list if it's not already. If there is an inode,
+	 * then it has I_NEW at this point, so it should be safe to test
+	 * i_sb_list locklessly.
+	 */
+	if (inode && list_empty(&inode->i_sb_list))
+		inode_sb_list_add(inode);
+
 	return inode;
 }
 EXPORT_SYMBOL(inode_insert5);
-- 
2.35.3

