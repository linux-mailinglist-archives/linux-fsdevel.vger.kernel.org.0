Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD24EE462
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiCaW6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 18:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbiCaW6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A22325D6;
        Thu, 31 Mar 2022 15:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5846361660;
        Thu, 31 Mar 2022 22:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B302C340ED;
        Thu, 31 Mar 2022 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648767394;
        bh=QThZI7tHhBglWLB+tvKaUGnhtbdylP2EGYTJaJlJio4=;
        h=From:To:Cc:Subject:Date:From;
        b=J8JMzh4VJmddMyni9deTyx+5xAOEZMrVJqRn5OpAGfNxCl25S4PU+kOGwaeP5th7I
         PFHpGI0Jd7D6poVg7TjGwDlJWbDz/QWr3iQMJiDqK2DFiVth8/hDEhDmh9G9cv5L6q
         NmDfec+Md9goHnugcNR6kJJHVpzSkwRrdQpIB/KRy/ckIRZx6fCAEao72HgwPJA8fT
         teOfdU0DxJAN6CFkVm2LAgd4aTEQt4hOI6p4K/zwkQ6FR21EHxnKbkhN8YZ1y42PXG
         eFHJaXQCZKesogajnbqgTVf3BFmXZM6ZjmIl9U4YFIZeGqZvZhwjiGgYOLxiu1rAKH
         XdO8bCnUj3d6Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: change test in inode_insert5 for adding to the sb list
Date:   Thu, 31 Mar 2022 18:56:32 -0400
Message-Id: <20220331225632.247244-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

This is the alternate approach that Al suggested to me on IRC. I think
this is likely to be more robust in the long run, and we can avoid
exporting another symbol.

Al, if you're ok with this, would you mind taking this in via your tree?
I'd like to see this in sit in linux-next for a bit so we can see if any
benchmarks get dinged.

diff --git a/fs/inode.c b/fs/inode.c
index 63324df6fa27..e10cff5102d4 100644
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
@@ -1199,7 +1198,13 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
-	if (!creating)
+
+	/*
+	 * Add it to the list if it wasn't already in,
+	 * e.g. new_inode. We hold I_NEW at this point, so
+	 * we should be safe to test i_sb_list locklessly.
+	 */
+	if (list_empty(&inode->i_sb_list))
 		inode_sb_list_add(inode);
 unlock:
 	spin_unlock(&inode_hash_lock);
-- 
2.35.1

