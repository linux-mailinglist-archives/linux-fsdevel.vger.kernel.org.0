Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCC6FCC21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjEIQ7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjEIQ6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:58:22 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE85B4EF4
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXhu0IMdhm7TtmY2sdq2+bF9aYr9Sm4xuSQ9rgukQdg=;
        b=Gra0g7cwhAqneFL51O788e/pMmLPbI05SL6bok25hYVdGn18I9cy8a3/KaT30uAxdqDTg2
        SwDp+NtsmF5P0jw2xQkDhJ119T+9qju9K5I1q2D1uNjkIsQLuqoYRp9CqKmmQkS3AeA8xk
        Xg784HuVcBpPfrJnLnMCeN2m26D7MRs=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 20/32] vfs: factor out inode hash head calculation
Date:   Tue,  9 May 2023 12:56:45 -0400
Message-Id: <20230509165657.1735798-21-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

In preparation for changing the inode hash table implementation.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/inode.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f13..41a10bcda1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -60,6 +60,22 @@ static unsigned int i_hash_shift __read_mostly;
 static struct hlist_head *inode_hashtable __read_mostly;
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
 
+static unsigned long hash(struct super_block *sb, unsigned long hashval)
+{
+	unsigned long tmp;
+
+	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
+			L1_CACHE_BYTES;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> i_hash_shift);
+	return tmp & i_hash_mask;
+}
+
+static inline struct hlist_head *i_hash_head(struct super_block *sb,
+		unsigned int hashval)
+{
+	return inode_hashtable + hash(sb, hashval);
+}
+
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -506,16 +522,6 @@ static inline void inode_sb_list_del(struct inode *inode)
 	}
 }
 
-static unsigned long hash(struct super_block *sb, unsigned long hashval)
-{
-	unsigned long tmp;
-
-	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
-			L1_CACHE_BYTES;
-	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> i_hash_shift);
-	return tmp & i_hash_mask;
-}
-
 /**
  *	__insert_inode_hash - hash an inode
  *	@inode: unhashed inode
@@ -1163,7 +1169,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 			    int (*test)(struct inode *, void *),
 			    int (*set)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
+	struct hlist_head *head = i_hash_head(inode->i_sb, hashval);
 	struct inode *old;
 
 again:
@@ -1267,7 +1273,7 @@ EXPORT_SYMBOL(iget5_locked);
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
@@ -1335,7 +1341,7 @@ EXPORT_SYMBOL(iget_locked);
  */
 static int test_inode_iunique(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *b = inode_hashtable + hash(sb, ino);
+	struct hlist_head *b = i_hash_head(sb, ino);
 	struct inode *inode;
 
 	hlist_for_each_entry_rcu(inode, b, i_hash) {
@@ -1422,7 +1428,7 @@ EXPORT_SYMBOL(igrab);
 struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = i_hash_head(sb, hashval);
 	struct inode *inode;
 
 	spin_lock(&inode_hash_lock);
@@ -1477,7 +1483,7 @@ EXPORT_SYMBOL(ilookup5);
  */
 struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
@@ -1526,7 +1532,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
 					     void *),
 				void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = i_hash_head(sb, hashval);
 	struct inode *inode, *ret_inode = NULL;
 	int mval;
 
@@ -1571,7 +1577,7 @@ EXPORT_SYMBOL(find_inode_nowait);
 struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 			     int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = i_hash_head(sb, hashval);
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
@@ -1609,7 +1615,7 @@ EXPORT_SYMBOL(find_inode_rcu);
 struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 				    unsigned long ino)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
@@ -1629,7 +1635,7 @@ int insert_inode_locked(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	ino_t ino = inode->i_ino;
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 
 	while (1) {
 		struct inode *old = NULL;
-- 
2.40.1

