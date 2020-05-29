Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04EE1E8A8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgE2WAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:00:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728267AbgE2WAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEdigCE9V+miZbrTMPI+f9WXFauTNRxgHU3//m3jDoQ=;
        b=FJlduyEKbTkJMaGZPdnIyw64qu6UGr21NQXhCzTaYvv7CySkbS4jtupWMyL+RxLG7ZyWMf
        XslNh+ewAm9Pnu/y1s3SaSNHAAQdJuywHgRDROV7mjzNozfirRxeDC5VC23Pn3pk9Rz49l
        bYn5OvSRGUeSufLBGHN7qNGGiIGep34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-Giu2vRR_OBCZ1PSObBJoNw-1; Fri, 29 May 2020 18:00:12 -0400
X-MC-Unique: Giu2vRR_OBCZ1PSObBJoNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CD99107ACF3;
        Fri, 29 May 2020 22:00:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 977035D9EF;
        Fri, 29 May 2020 22:00:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/27] vfs, afs,
 ext4: Make the inode hash table RCU searchable
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-ext4@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:07 +0100
Message-ID: <159078960778.679399.5682252853189947919.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the inode hash table RCU searchable so that searches that want to
access or modify an inode without taking a ref on that inode can do so
without taking the inode hash table lock.

The main thing this requires is some RCU annotation on the list
manipulation operations.  Inodes are already freed by RCU in most cases.

Users of this interface must take care as the inode may be still under
construction or may be being torn down around them.

There are at least two instances where this can be of use:

 (1) Ext4 date stamp updating.

 (2) AFS callback breaking.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc: linux-ext4@vger.kernel.org
cc: linux-afs@lists.infradead.org
---

 fs/afs/callback.c  |   12 +++-
 fs/ext4/inode.c    |   44 +++++++------
 fs/inode.c         |  173 ++++++++++++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h |    3 +
 4 files changed, 179 insertions(+), 53 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 2dca8df1a18d..0dcbd40732d1 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -252,6 +252,7 @@ static void afs_break_one_callback(struct afs_server *server,
 	struct afs_vnode *vnode;
 	struct inode *inode;
 
+	rcu_read_lock();
 	read_lock(&server->cb_break_lock);
 	hlist_for_each_entry(vi, &server->cb_volumes, srv_link) {
 		if (vi->vid < fid->vid)
@@ -287,12 +288,16 @@ static void afs_break_one_callback(struct afs_server *server,
 		} else {
 			data.volume = NULL;
 			data.fid = *fid;
-			inode = ilookup5_nowait(cbi->sb, fid->vnode,
-						afs_iget5_test, &data);
+
+			/* See if we can find a matching inode - even an I_NEW
+			 * inode needs to be marked as it can have its callback
+			 * broken before we finish setting up the local inode.
+			 */
+			inode = find_inode_rcu(cbi->sb, fid->vnode,
+					       afs_iget5_test, &data);
 			if (inode) {
 				vnode = AFS_FS_I(inode);
 				afs_break_callback(vnode, afs_cb_break_for_callback);
-				iput(inode);
 			} else {
 				trace_afs_cb_miss(fid, afs_cb_break_for_callback);
 			}
@@ -301,6 +306,7 @@ static void afs_break_one_callback(struct afs_server *server,
 
 out:
 	read_unlock(&server->cb_break_lock);
+	rcu_read_unlock();
 }
 
 /*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..2bbb55d05bb7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4860,21 +4860,22 @@ static int ext4_inode_blocks_set(handle_t *handle,
 	return 0;
 }
 
-struct other_inode {
-	unsigned long		orig_ino;
-	struct ext4_inode	*raw_inode;
-};
-
-static int other_inode_match(struct inode * inode, unsigned long ino,
-			     void *data)
+static void __ext4_update_other_inode_time(struct super_block *sb,
+					   unsigned long orig_ino,
+					   unsigned long ino,
+					   struct ext4_inode *raw_inode)
 {
-	struct other_inode *oi = (struct other_inode *) data;
+	struct inode *inode;
+
+	inode = find_inode_by_ino_rcu(sb, ino);
+	if (!inode)
+		return;
 
-	if ((inode->i_ino != ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
+	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
 			       I_DIRTY_INODE)) ||
 	    ((inode->i_state & I_DIRTY_TIME) == 0))
-		return 0;
+		return;
+
 	spin_lock(&inode->i_lock);
 	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
 				I_DIRTY_INODE)) == 0) &&
@@ -4885,16 +4886,15 @@ static int other_inode_match(struct inode * inode, unsigned long ino,
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
-		EXT4_INODE_SET_XTIME(i_ctime, inode, oi->raw_inode);
-		EXT4_INODE_SET_XTIME(i_mtime, inode, oi->raw_inode);
-		EXT4_INODE_SET_XTIME(i_atime, inode, oi->raw_inode);
-		ext4_inode_csum_set(inode, oi->raw_inode, ei);
+		EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
+		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
+		ext4_inode_csum_set(inode, raw_inode, ei);
 		spin_unlock(&ei->i_raw_lock);
-		trace_ext4_other_inode_update_time(inode, oi->orig_ino);
-		return -1;
+		trace_ext4_other_inode_update_time(inode, orig_ino);
+		return;
 	}
 	spin_unlock(&inode->i_lock);
-	return -1;
 }
 
 /*
@@ -4904,24 +4904,24 @@ static int other_inode_match(struct inode * inode, unsigned long ino,
 static void ext4_update_other_inodes_time(struct super_block *sb,
 					  unsigned long orig_ino, char *buf)
 {
-	struct other_inode oi;
 	unsigned long ino;
 	int i, inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
 	int inode_size = EXT4_INODE_SIZE(sb);
 
-	oi.orig_ino = orig_ino;
 	/*
 	 * Calculate the first inode in the inode table block.  Inode
 	 * numbers are one-based.  That is, the first inode in a block
 	 * (assuming 4k blocks and 256 byte inodes) is (n*16 + 1).
 	 */
 	ino = ((orig_ino - 1) & ~(inodes_per_block - 1)) + 1;
+	rcu_read_lock();
 	for (i = 0; i < inodes_per_block; i++, ino++, buf += inode_size) {
 		if (ino == orig_ino)
 			continue;
-		oi.raw_inode = (struct ext4_inode *) buf;
-		(void) find_inode_nowait(sb, ino, other_inode_match, &oi);
+		__ext4_update_other_inode_time(sb, orig_ino, ino,
+					       (struct ext4_inode *)buf);
 	}
+	rcu_read_unlock();
 }
 
 /*
diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..a9ae3a405a1f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -497,7 +497,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
-	hlist_add_head(&inode->i_hash, b);
+	hlist_add_head_rcu(&inode->i_hash, b);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
 }
@@ -513,7 +513,7 @@ void __remove_inode_hash(struct inode *inode)
 {
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
-	hlist_del_init(&inode->i_hash);
+	hlist_del_init_rcu(&inode->i_hash);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
 }
@@ -808,8 +808,31 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode);
+
 /*
- * Called with the inode lock held.
+ * Find an inode.  Can be called with either the RCU read lock or the
+ * inode cache lock held.  No check is made as to the validity of the
+ * inode found.
+ */
+static struct inode *__find_inode_rcu(struct super_block *sb,
+				      struct hlist_head *head,
+				      int (*test)(struct inode *, void *),
+				      void *data)
+{
+	struct inode *inode;
+
+	hlist_for_each_entry_rcu(inode, head, i_hash) {
+		if (inode->i_sb == sb &&
+		    test(inode, data))
+			return inode;
+	}
+
+	return NULL;
+}
+
+/*
+ * Called with the inode hash lock held.  Waits until dying inodes are freed,
+ * dropping the inode hash lock temporarily to do so.
  */
 static struct inode *find_inode(struct super_block *sb,
 				struct hlist_head *head,
@@ -819,11 +842,8 @@ static struct inode *find_inode(struct super_block *sb,
 	struct inode *inode = NULL;
 
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
-		if (inode->i_sb != sb)
-			continue;
-		if (!test(inode, data))
-			continue;
+	inode = __find_inode_rcu(sb, head, test, data);
+	if (inode) {
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode);
@@ -840,6 +860,26 @@ static struct inode *find_inode(struct super_block *sb,
 	return NULL;
 }
 
+/*
+ * Find an inode by inode number.  Can be called with either the RCU
+ * read lock or the inode cache lock held.  No check is made as to the
+ * validity of the inode found.
+ */
+static struct inode *__find_inode_by_ino_rcu(struct super_block *sb,
+					     struct hlist_head *head,
+					     unsigned long ino)
+{
+	struct inode *inode;
+
+	hlist_for_each_entry_rcu(inode, head, i_hash) {
+		if (inode->i_ino == ino &&
+		    inode->i_sb == sb)
+			return inode;
+	}
+
+	return NULL;
+}
+
 /*
  * find_inode_fast is the fast path version of find_inode, see the comment at
  * iget_locked for details.
@@ -850,11 +890,8 @@ static struct inode *find_inode_fast(struct super_block *sb,
 	struct inode *inode = NULL;
 
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
-		if (inode->i_ino != ino)
-			continue;
-		if (inode->i_sb != sb)
-			continue;
+	inode = __find_inode_by_ino_rcu(sb, head, ino);
+	if (inode) {
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode);
@@ -1107,7 +1144,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 */
 	spin_lock(&inode->i_lock);
 	inode->i_state |= I_NEW;
-	hlist_add_head(&inode->i_hash, head);
+	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
 	if (!creating)
 		inode_sb_list_add(inode);
@@ -1201,7 +1238,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
 			inode->i_state = I_NEW;
-			hlist_add_head(&inode->i_hash, head);
+			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			inode_sb_list_add(inode);
 			spin_unlock(&inode_hash_lock);
@@ -1245,15 +1282,9 @@ static int test_inode_iunique(struct super_block *sb, unsigned long ino)
 	struct inode *inode;
 
 	spin_lock(&inode_hash_lock);
-	hlist_for_each_entry(inode, b, i_hash) {
-		if (inode->i_ino == ino && inode->i_sb == sb) {
-			spin_unlock(&inode_hash_lock);
-			return 0;
-		}
-	}
+	inode = __find_inode_by_ino_rcu(sb, b, ino);
 	spin_unlock(&inode_hash_lock);
-
-	return 1;
+	return inode ? 0 : 1;
 }
 
 /**
@@ -1325,6 +1356,7 @@ EXPORT_SYMBOL(igrab);
  *
  * Note: I_NEW is not waited upon so you have to be very careful what you do
  * with the returned inode.  You probably should be using ilookup5() instead.
+ * It may still sleep waiting for I_FREE and I_WILL_FREE, however.
  *
  * Note2: @test is called with the inode_hash_lock held, so can't sleep.
  */
@@ -1456,6 +1488,86 @@ struct inode *find_inode_nowait(struct super_block *sb,
 }
 EXPORT_SYMBOL(find_inode_nowait);
 
+/**
+ * find_inode_rcu - find an inode in the inode cache
+ * @sb:		Super block of file system to search
+ * @hashval:	Key to hash
+ * @test:	Function to test match on an inode
+ * @data:	Data for test function
+ *
+ * Search for the inode specified by @hashval and @data in the inode cache,
+ * where the helper function @test will return 0 if the inode does not match
+ * and 1 if it does.  The @test function must be responsible for taking the
+ * i_lock spin_lock and checking i_state for an inode being freed or being
+ * initialized.
+ *
+ * If successful, this will return the inode for which the @test function
+ * returned 1 and NULL otherwise.
+ *
+ * The @test function is not permitted to take a ref on any inode presented
+ * unless the caller is holding the inode hashtable lock.  It is also not
+ * permitted to sleep, since it may be called with the RCU read lock held.
+ *
+ * The caller must hold either the RCU read lock or the inode hashtable lock.
+ */
+struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
+			     int (*test)(struct inode *, void *), void *data)
+{
+	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode;
+
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&inode_hash_lock) && !rcu_read_lock_held(),
+			 "suspicious find_inode_by_ino_rcu() usage");
+
+	hlist_for_each_entry_rcu(inode, head, i_hash) {
+		if (inode->i_sb == sb &&
+		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    test(inode, data))
+			return inode;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(find_inode_rcu);
+
+/**
+ * find_inode_by_rcu - Find an inode in the inode cache
+ * @sb:		Super block of file system to search
+ * @ino:	The inode number to match
+ *
+ * Search for the inode specified by @hashval and @data in the inode cache,
+ * where the helper function @test will return 0 if the inode does not match
+ * and 1 if it does.  The @test function must be responsible for taking the
+ * i_lock spin_lock and checking i_state for an inode being freed or being
+ * initialized.
+ *
+ * If successful, this will return the inode for which the @test function
+ * returned 1 and NULL otherwise.
+ *
+ * The @test function is not permitted to take a ref on any inode presented
+ * unless the caller is holding the inode hashtable lock.  It is also not
+ * permitted to sleep, since it may be called with the RCU read lock held.
+ *
+ * The caller must hold either the RCU read lock or the inode hashtable lock.
+ */
+struct inode *find_inode_by_ino_rcu(struct super_block *sb,
+				    unsigned long ino)
+{
+	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	struct inode *inode;
+
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&inode_hash_lock) && !rcu_read_lock_held(),
+			 "suspicious find_inode_by_ino_rcu() usage");
+
+	hlist_for_each_entry_rcu(inode, head, i_hash) {
+		if (inode->i_ino == ino &&
+		    inode->i_sb == sb &&
+		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
+		    return inode;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(find_inode_by_ino_rcu);
+
 int insert_inode_locked(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
@@ -1480,7 +1592,7 @@ int insert_inode_locked(struct inode *inode)
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
 			inode->i_state |= I_NEW | I_CREATING;
-			hlist_add_head(&inode->i_hash, head);
+			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
 			return 0;
@@ -1540,6 +1652,7 @@ static void iput_final(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct super_operations *op = inode->i_sb->s_op;
+	unsigned long state;
 	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
@@ -1555,16 +1668,20 @@ static void iput_final(struct inode *inode)
 		return;
 	}
 
+	state = READ_ONCE(inode->i_state);
 	if (!drop) {
-		inode->i_state |= I_WILL_FREE;
+		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
+
 		write_inode_now(inode, 1);
+
 		spin_lock(&inode->i_lock);
-		WARN_ON(inode->i_state & I_NEW);
-		inode->i_state &= ~I_WILL_FREE;
+		state = READ_ONCE(inode->i_state);
+		WARN_ON(state & I_NEW);
+		state &= ~I_WILL_FREE;
 	}
 
-	inode->i_state |= I_FREEING;
+	WRITE_ONCE(inode->i_state, state | I_FREEING);
 	if (!list_empty(&inode->i_lru))
 		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6dd..5f9b2bb4b44f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3070,6 +3070,9 @@ extern struct inode *find_inode_nowait(struct super_block *,
 				       int (*match)(struct inode *,
 						    unsigned long, void *),
 				       void *data);
+extern struct inode *find_inode_rcu(struct super_block *, unsigned long,
+				    int (*)(struct inode *, void *), void *);
+extern struct inode *find_inode_by_ino_rcu(struct super_block *, unsigned long);
 extern int insert_inode_locked4(struct inode *, unsigned long, int (*test)(struct inode *, void *), void *);
 extern int insert_inode_locked(struct inode *);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC


