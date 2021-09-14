Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA93740A1F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 02:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhINA3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 20:29:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55088 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbhINA3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:29:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99029200AA;
        Tue, 14 Sep 2021 00:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631579293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+AH5az6YB5d1G93t+IcgOjK97PdYCD1vgzzwp0b1A4=;
        b=alftfvknnXvvyyrEoULvS1VHdHrp4QigC7kX101FPGauGb0bejYoklkrO5xA/KiBsu3F5A
        SehbTi4gi727U4337mkMGjkx8t+h0PPoa4oFRLhjpjFPzxAHo+l0n3Dqn/89iwGDbf34eM
        qoiS23uj+YmmXgOCfedNGlHRM2IHNjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631579293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+AH5az6YB5d1G93t+IcgOjK97PdYCD1vgzzwp0b1A4=;
        b=7RVZAXOXvV0ntmE7QktWScNv2/X5V4egJV7QhcKOvnQ2UBuxavMTfKlMtx7vXisWIr81E2
        iZnqbETZJnjKthCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12DC113ADE;
        Tue, 14 Sep 2021 00:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xsn7MJbsP2EvawAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 00:28:06 +0000
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>
Date:   Tue, 14 Sep 2021 10:13:04 +1000
Subject: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <163157838437.13293.14244628630141187199.stgit@noble.brown>
In-Reply-To: <163157808321.13293.486682642188075090.stgit@noble.brown>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Indefinite loops waiting for memory allocation are discouraged by
documentation in gfp.h which says the use of __GFP_NOFAIL that it

 is definitely preferable to use the flag rather than opencode endless
 loop around allocator.

Such loops that use congestion_wait() are particularly unwise as
congestion_wait() is indistinguishable from
schedule_timeout_uninterruptible() in practice - and should be
deprecated.

So this patch changes the two loops in ext4_ext_truncate() to use
__GFP_NOFAIL instead of looping.

As the allocation is multiple layers deeper in the call stack, this
requires passing the EXT4_EX_NOFAIL flag down and handling it in various
places.

Of particular interest is the ext4_journal_start family of calls which
can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
a high bit, so it is safe in practice.

jbd2__journal_start() is enhanced so that the gfp_t flags passed are
used for *all* allocations.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/ext4/ext4.h           |    2 +-
 fs/ext4/ext4_jbd2.c      |    8 +++++++-
 fs/ext4/extents.c        |   49 +++++++++++++++++-----------------------------
 fs/ext4/extents_status.c |   35 +++++++++++++++++++--------------
 fs/ext4/extents_status.h |    2 +-
 fs/ext4/indirect.c       |    2 +-
 fs/ext4/inode.c          |    6 +++---
 fs/ext4/ioctl.c          |    4 ++--
 fs/ext4/super.c          |    2 +-
 fs/jbd2/transaction.c    |    8 ++++----
 10 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 90ff5acaf11f..52a34f5dfda2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3720,7 +3720,7 @@ extern int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			       struct ext4_map_blocks *map, int flags);
 extern int ext4_ext_truncate(handle_t *, struct inode *);
 extern int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
-				 ext4_lblk_t end);
+				 ext4_lblk_t end, int nofail);
 extern void ext4_ext_init(struct super_block *);
 extern void ext4_ext_release(struct super_block *);
 extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 6def7339056d..2bdda3b7a3e6 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -92,6 +92,12 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 {
 	journal_t *journal;
 	int err;
+	gfp_t gfp_mask = GFP_NOFS;
+
+	if (type & EXT4_EX_NOFAIL) {
+		gfp_mask |= __GFP_NOFAIL;
+		type &= ~EXT4_EX_NOFAIL;
+	}
 
 	trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
 				 _RET_IP_);
@@ -103,7 +109,7 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 	if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 		return ext4_get_nojournal();
 	return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
-				   GFP_NOFS, type, line);
+				   gfp_mask, type, line);
 }
 
 int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c0de30f25185..b7bc12aedf78 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1488,7 +1488,7 @@ static int ext4_ext_search_left(struct inode *inode,
 static int ext4_ext_search_right(struct inode *inode,
 				 struct ext4_ext_path *path,
 				 ext4_lblk_t *logical, ext4_fsblk_t *phys,
-				 struct ext4_extent *ret_ex)
+				 struct ext4_extent *ret_ex, int nofail)
 {
 	struct buffer_head *bh = NULL;
 	struct ext4_extent_header *eh;
@@ -1565,7 +1565,7 @@ static int ext4_ext_search_right(struct inode *inode,
 	while (++depth < path->p_depth) {
 		/* subtract from p_depth to get proper eh_depth */
 		bh = read_extent_tree_block(inode, block,
-					    path->p_depth - depth, 0);
+					    path->p_depth - depth, nofail);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		eh = ext_block_hdr(bh);
@@ -1574,7 +1574,7 @@ static int ext4_ext_search_right(struct inode *inode,
 		put_bh(bh);
 	}
 
-	bh = read_extent_tree_block(inode, block, path->p_depth - depth, 0);
+	bh = read_extent_tree_block(inode, block, path->p_depth - depth, nofail);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	eh = ext_block_hdr(bh);
@@ -2773,7 +2773,7 @@ ext4_ext_more_to_rm(struct ext4_ext_path *path)
 }
 
 int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
-			  ext4_lblk_t end)
+			  ext4_lblk_t end, int nofail)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int depth = ext_depth(inode);
@@ -2789,7 +2789,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	ext_debug(inode, "truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
-	handle = ext4_journal_start_with_revoke(inode, EXT4_HT_TRUNCATE,
+	handle = ext4_journal_start_with_revoke(inode,
+			EXT4_HT_TRUNCATE | nofail,
 			depth + 1,
 			ext4_free_metadata_revoke_credits(inode->i_sb, depth));
 	if (IS_ERR(handle))
@@ -2877,7 +2878,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    NULL);
+						    NULL, nofail);
 			if (err < 0)
 				goto out;
 			if (pblk) {
@@ -2899,10 +2900,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 			       GFP_NOFS | __GFP_NOFAIL);
-		if (path == NULL) {
-			ext4_journal_stop(handle);
-			return -ENOMEM;
-		}
 		path[0].p_maxdepth = path[0].p_depth = depth;
 		path[0].p_hdr = ext_inode_hdr(inode);
 		i = 0;
@@ -2955,7 +2952,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			memset(path + i + 1, 0, sizeof(*path));
 			bh = read_extent_tree_block(inode,
 				ext4_idx_pblock(path[i].p_idx), depth - i - 1,
-				EXT4_EX_NOCACHE);
+				EXT4_EX_NOCACHE | nofail);
 			if (IS_ERR(bh)) {
 				/* should we reset i_size? */
 				err = PTR_ERR(bh);
@@ -4186,7 +4183,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto out;
 	ar.lright = map->m_lblk;
-	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
+	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2, 0);
 	if (err < 0)
 		goto out;
 
@@ -4368,23 +4365,13 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 
 	last_block = (inode->i_size + sb->s_blocksize - 1)
 			>> EXT4_BLOCK_SIZE_BITS(sb);
-retry:
 	err = ext4_es_remove_extent(inode, last_block,
-				    EXT_MAX_BLOCKS - last_block);
-	if (err == -ENOMEM) {
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, HZ/50);
-		goto retry;
-	}
+				    EXT_MAX_BLOCKS - last_block,
+				    EXT4_EX_NOFAIL);
 	if (err)
 		return err;
-retry_remove_space:
-	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
-	if (err == -ENOMEM) {
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, HZ/50);
-		goto retry_remove_space;
-	}
+	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1,
+				    EXT4_EX_NOFAIL);
 	return err;
 }
 
@@ -5322,13 +5309,13 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_discard_preallocations(inode, 0);
 
 	ret = ext4_es_remove_extent(inode, punch_start,
-				    EXT_MAX_BLOCKS - punch_start);
+				    EXT_MAX_BLOCKS - punch_start, 0);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
 		goto out_stop;
 	}
 
-	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
+	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1, 0);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
 		goto out_stop;
@@ -5510,7 +5497,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 
 	ret = ext4_es_remove_extent(inode, offset_lblk,
-			EXT_MAX_BLOCKS - offset_lblk);
+				    EXT_MAX_BLOCKS - offset_lblk, 0);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
 		goto out_stop;
@@ -5574,10 +5561,10 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 	BUG_ON(!inode_is_locked(inode1));
 	BUG_ON(!inode_is_locked(inode2));
 
-	*erp = ext4_es_remove_extent(inode1, lblk1, count);
+	*erp = ext4_es_remove_extent(inode1, lblk1, count, 0);
 	if (unlikely(*erp))
 		return 0;
-	*erp = ext4_es_remove_extent(inode2, lblk2, count);
+	*erp = ext4_es_remove_extent(inode2, lblk2, count, 0);
 	if (unlikely(*erp))
 		return 0;
 
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9a3a8996aacf..7f7711a2ea44 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -144,9 +144,10 @@
 static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      int nofail);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved);
+			      ext4_lblk_t end, int *reserved, int nofail);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
@@ -452,10 +453,11 @@ static void ext4_es_list_del(struct inode *inode)
 
 static struct extent_status *
 ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
-		     ext4_fsblk_t pblk)
+		     ext4_fsblk_t pblk, int nofail)
 {
 	struct extent_status *es;
-	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
+	es = kmem_cache_alloc(ext4_es_cachep,
+			      GFP_ATOMIC | (nofail ? __GFP_NOFAIL : 0));
 	if (es == NULL)
 		return NULL;
 	es->es_lblk = lblk;
@@ -754,7 +756,8 @@ static inline void ext4_es_insert_extent_check(struct inode *inode,
 }
 #endif
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      int nofail)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node **p = &tree->root.rb_node;
@@ -795,7 +798,7 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 	}
 
 	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
-				  newes->es_pblk);
+				  newes->es_pblk, nofail);
 	if (!es)
 		return -ENOMEM;
 	rb_link_node(&es->rb_node, parent, p);
@@ -848,11 +851,11 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_es_insert_extent_check(inode, &newes);
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, NULL);
+	err = __es_remove_extent(inode, lblk, end, NULL, 0);
 	if (err != 0)
 		goto error;
 retry:
-	err = __es_insert_extent(inode, &newes);
+	err = __es_insert_extent(inode, &newes, 0);
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
@@ -902,7 +905,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
 	if (!es || es->es_lblk > end)
-		__es_insert_extent(inode, &newes);
+		__es_insert_extent(inode, &newes, 0);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
@@ -1294,6 +1297,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * @lblk - first block in range
  * @end - last block in range
  * @reserved - number of cluster reservations released
+ * @nofail - EXT4_EX_NOFAIL if __GFP_NOFAIL should be used
  *
  * If @reserved is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
@@ -1301,7 +1305,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved)
+			      ext4_lblk_t end, int *reserved, int nofail)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node *node;
@@ -1350,7 +1354,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 					orig_es.es_len - len2;
 			ext4_es_store_pblock_status(&newes, block,
 						    ext4_es_status(&orig_es));
-			err = __es_insert_extent(inode, &newes);
+			err = __es_insert_extent(inode, &newes, nofail);
 			if (err) {
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
@@ -1426,12 +1430,13 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
  * @inode - file containing range
  * @lblk - first block in range
  * @len - number of blocks to remove
+ * @nofail - EXT4_EX_NOFAIL if __GFP_NOFAIL should be used
  *
  * Reduces block/cluster reservation count and for bigalloc cancels pending
  * reservations as needed. Returns 0 on success, error code on failure.
  */
 int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len)
+			  ext4_lblk_t len, int nofail)
 {
 	ext4_lblk_t end;
 	int err = 0;
@@ -1456,7 +1461,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved);
+	err = __es_remove_extent(inode, lblk, end, &reserved, nofail);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
@@ -2003,11 +2008,11 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err = __es_remove_extent(inode, lblk, lblk, NULL);
+	err = __es_remove_extent(inode, lblk, lblk, NULL, 0);
 	if (err != 0)
 		goto error;
 retry:
-	err = __es_insert_extent(inode, &newes);
+	err = __es_insert_extent(inode, &newes, 0);
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4ec30a798260..23d77094a165 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -134,7 +134,7 @@ extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
 extern int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len);
+				 ext4_lblk_t len, int nofail);
 extern void ext4_es_find_extent_range(struct inode *inode,
 				      int (*match_fn)(struct extent_status *es),
 				      ext4_lblk_t lblk, ext4_lblk_t end,
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 89efa78ed4b2..910e87aea7be 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1125,7 +1125,7 @@ void ext4_ind_truncate(handle_t *handle, struct inode *inode)
 			return;
 	}
 
-	ext4_es_remove_extent(inode, last_block, EXT_MAX_BLOCKS - last_block);
+	ext4_es_remove_extent(inode, last_block, EXT_MAX_BLOCKS - last_block, 0);
 
 	/*
 	 * The orphan list entry will now protect us from any crash which
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d18852d6029c..24246043d94b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1575,7 +1575,7 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 		ext4_lblk_t start, last;
 		start = index << (PAGE_SHIFT - inode->i_blkbits);
 		last = end << (PAGE_SHIFT - inode->i_blkbits);
-		ext4_es_remove_extent(inode, start, last - start + 1);
+		ext4_es_remove_extent(inode, start, last - start + 1, 0);
 	}
 
 	pagevec_init(&pvec);
@@ -4109,7 +4109,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 		ext4_discard_preallocations(inode, 0);
 
 		ret = ext4_es_remove_extent(inode, first_block,
-					    stop_block - first_block);
+					    stop_block - first_block, 0);
 		if (ret) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			goto out_stop;
@@ -4117,7 +4117,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 			ret = ext4_ext_remove_space(inode, first_block,
-						    stop_block - 1);
+						    stop_block - 1, 0);
 		else
 			ret = ext4_ind_remove_space(handle, inode, first_block,
 						    stop_block);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..e4de05a6b976 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -79,8 +79,8 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
 		(ei1->i_flags & ~EXT4_FL_SHOULD_SWAP);
 	ei2->i_flags = tmp | (ei2->i_flags & ~EXT4_FL_SHOULD_SWAP);
 	swap(ei1->i_disksize, ei2->i_disksize);
-	ext4_es_remove_extent(inode1, 0, EXT_MAX_BLOCKS);
-	ext4_es_remove_extent(inode2, 0, EXT_MAX_BLOCKS);
+	ext4_es_remove_extent(inode1, 0, EXT_MAX_BLOCKS, 0);
+	ext4_es_remove_extent(inode2, 0, EXT_MAX_BLOCKS, 0);
 
 	isize = i_size_read(inode1);
 	i_size_write(inode1, i_size_read(inode2));
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0775950ee84e..947e8376a35a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1393,7 +1393,7 @@ void ext4_clear_inode(struct inode *inode)
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	ext4_discard_preallocations(inode, 0);
-	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS, 0);
 	dquot_drop(inode);
 	if (EXT4_I(inode)->jinode) {
 		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6a3caedd2285..23e0f003d43b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -476,9 +476,9 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 }
 
 /* Allocate a new handle.  This should probably be in a slab... */
-static handle_t *new_handle(int nblocks)
+static handle_t *new_handle(int nblocks, gfp_t gfp)
 {
-	handle_t *handle = jbd2_alloc_handle(GFP_NOFS);
+	handle_t *handle = jbd2_alloc_handle(gfp);
 	if (!handle)
 		return NULL;
 	handle->h_total_credits = nblocks;
@@ -505,13 +505,13 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 
 	nblocks += DIV_ROUND_UP(revoke_records,
 				journal->j_revoke_records_per_block);
-	handle = new_handle(nblocks);
+	handle = new_handle(nblocks, gfp_mask);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
 	if (rsv_blocks) {
 		handle_t *rsv_handle;
 
-		rsv_handle = new_handle(rsv_blocks);
+		rsv_handle = new_handle(rsv_blocks, gfp_mask);
 		if (!rsv_handle) {
 			jbd2_free_handle(handle);
 			return ERR_PTR(-ENOMEM);


