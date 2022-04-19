Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67198507908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbiDSSeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357438AbiDSSc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EE8427C8;
        Tue, 19 Apr 2022 11:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69843B818FE;
        Tue, 19 Apr 2022 18:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE4DC385A5;
        Tue, 19 Apr 2022 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650392559;
        bh=Bj67+NC5/w4hW+djueoYU3sQv3W0hf+L1Lfue7THGy4=;
        h=From:To:Cc:Subject:Date:From;
        b=DMxSlWQLAklOxnjN9ci7+rAyWTwSVXqQ+DmW2tGycghmhlQ5VyKiBtwuvd2nxkmL+
         cifNwUPYzr0UOZdLSAUsS/gK+Fvfb0VDfeLJS/Ke8ID9CrzHxWDdXyGM1iBroq78zq
         nFFKaR9Yoxpkc88JZBgGmC3Day0eeiQyJRwBhhxpuGP+cCqXfhuYAXkZlRQJik/RMs
         52QJPtYm62I8KLjFZGhTXVaf5fBlMk9it0PtJg2yd/p7RvpmNDHmLK4QgAIdlqPadD
         jGYkghl/ULVDMhAfHHLPUMauy7nIUjegUfleD13nGXSmSRNuOK0zyq0wyUPJjcOgqE
         uxfR/LhTVWxMw==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH resend] fs: change test in inode_insert5 for adding to the sb list
Date:   Tue, 19 Apr 2022 14:22:37 -0400
Message-Id: <20220419182237.62749-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Hi Al,

I'm going to eventually need this in order to start merging the
ceph-fscrypt patch series. Could you take this into your tree soon and
feed it into -next? I don't really expect any regressions from this, but
it'd be good to be sure.

Thanks,
Jeff

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..743420a55e5f 100644
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

