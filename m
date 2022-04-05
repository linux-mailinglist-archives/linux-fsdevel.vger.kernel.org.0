Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A824F4D42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581799AbiDEXlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573557AbiDETWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844F3F899;
        Tue,  5 Apr 2022 12:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2623ECE1FB8;
        Tue,  5 Apr 2022 19:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA51CC385A0;
        Tue,  5 Apr 2022 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186439;
        bh=aGm/yYftJrMv8Wm0z7akYN9TTrAtUh82JqGdEA2ekKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKs1Yjzs98L8zGRRD0FwzP0xrAX0EHlKhwSsFbQXrX9BBZav9La1egDgcBTZ/jvwi
         NK2BWI0205CvUtsRTaOKah9SErtfgrKJby9ltId9RE8vBdZLKVVkNiZXr7HifE+w7i
         /3OgKwab9ZpJH2mHMUfrLu59chPIn6/KRr9Ae85+Qpz41FGwqurBQYvkDDWITlUFQ9
         G2i3w9IMdIS+wkv/c9dcmPAEg8ksaNnbS1ywDpp3BrW/AXFJQDhgYIdK+Wts5KG0tq
         I4bbEgTFPNoo4wOa3asis/p4fI/3Rp0XZNu8ZRPP6WBwfOr6rUkLNJbcXhXBq0bq3p
         jEMuvqeP5AhzQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v13 08/59] fs: change test in inode_insert5 for adding to the sb list
Date:   Tue,  5 Apr 2022 15:19:39 -0400
Message-Id: <20220405192030.178326-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
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

