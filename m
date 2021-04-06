Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9103553F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbhDFMd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 08:33:59 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:45282 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344050AbhDFMd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:33:58 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id A206C65065;
        Tue,  6 Apr 2021 22:33:48 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lTktv-00Cq7V-UL; Tue, 06 Apr 2021 22:33:47 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1lTktv-007ImY-MX; Tue, 06 Apr 2021 22:33:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] vfs: factor out inode hash head calculation
Date:   Tue,  6 Apr 2021 22:33:41 +1000
Message-Id: <20210406123343.1739669-2-david@fromorbit.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210406123343.1739669-1-david@fromorbit.com>
References: <20210406123343.1739669-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=3YhXtTcJ-WEA:10 a=20KFwNOVAAAA:8 a=4C8iV8CbDRy0lkdI5c4A:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

In preparation for changing the inode hash table implementation.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/inode.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..b8d9eb3454dc 100644
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
@@ -475,16 +491,6 @@ static inline void inode_sb_list_del(struct inode *inode)
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
@@ -1073,7 +1079,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 			    int (*test)(struct inode *, void *),
 			    int (*set)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
+	struct hlist_head *head = i_hash_head(inode->i_sb, hashval);
 	struct inode *old;
 	bool creating = inode->i_state & I_CREATING;
 
@@ -1173,7 +1179,7 @@ EXPORT_SYMBOL(iget5_locked);
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
@@ -1241,7 +1247,7 @@ EXPORT_SYMBOL(iget_locked);
  */
 static int test_inode_iunique(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *b = inode_hashtable + hash(sb, ino);
+	struct hlist_head *b = i_hash_head(sb, ino);
 	struct inode *inode;
 
 	hlist_for_each_entry_rcu(inode, b, i_hash) {
@@ -1328,7 +1334,7 @@ EXPORT_SYMBOL(igrab);
 struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = i_hash_head(sb, hashval);
 	struct inode *inode;
 
 	spin_lock(&inode_hash_lock);
@@ -1383,7 +1389,7 @@ EXPORT_SYMBOL(ilookup5);
  */
 struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
@@ -1432,7 +1438,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
 					     void *),
 				void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = i_hash_head(sb, hashval);
 	struct inode *inode, *ret_inode = NULL;
 	int mval;
 
@@ -1477,7 +1483,7 @@ EXPORT_SYMBOL(find_inode_nowait);
 struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 			     int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = i_hash_head(sb, hashval);
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
@@ -1515,7 +1521,7 @@ EXPORT_SYMBOL(find_inode_rcu);
 struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 				    unsigned long ino)
 {
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
@@ -1535,7 +1541,7 @@ int insert_inode_locked(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	ino_t ino = inode->i_ino;
-	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = i_hash_head(sb, ino);
 
 	while (1) {
 		struct inode *old = NULL;
-- 
2.31.0

