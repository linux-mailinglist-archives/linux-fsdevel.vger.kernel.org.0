Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C303373E72B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFZSHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFZSHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0121B1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687802773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=il3HTgPDxa0mQ+wSSkQc8OYkxm+WI6iN4tN+WT86o9g=;
        b=X/gJv/DRqZaVUGP6dsjrhAQH2D8OTjh2TlHY38EVsWIN0XOB0q9R31GDyPhJ9SOOs3phlA
        z66CuVIR32EGvvEql8rmT9yIKQwxTJNznbYi6m/vhTqhgOfbucO9wEq3WBIgZrnYciYoJx
        iz3CWCBvbwEstJFb7rtybANxQcWh6xs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-pv2jUNpcPy2GdR1o1fkO9A-1; Mon, 26 Jun 2023 14:06:09 -0400
X-MC-Unique: pv2jUNpcPy2GdR1o1fkO9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D077858F1E;
        Mon, 26 Jun 2023 18:06:08 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88200F5AE9;
        Mon, 26 Jun 2023 18:06:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 43D36400F7B60; Mon, 26 Jun 2023 15:04:53 -0300 (-03)
Date:   Mon, 26 Jun 2023 15:04:53 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: [PATCH] fs/buffer.c: remove per-CPU buffer_head lookup cache
Message-ID: <ZJnTRfHND0Wi4YcU@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


For certain types of applications (for example PLC software or
RAN processing), upon occurrence of an event, it is necessary to
complete a certain task in a maximum amount of time (deadline).

One way to express this requirement is with a pair of numbers, 
deadline time and execution time, where:

        * deadline time: length of time between event and deadline.
        * execution time: length of time it takes for processing of event
                          to occur on a particular hardware platform
                          (uninterrupted).

The particular values depend on use-case. For the case
where the realtime application executes in a virtualized
guest, an IPI which must be serviced in the host will cause 
the following sequence of events:

        1) VM-exit
        2) execution of IPI (and function call)
        3) VM-entry

Which causes an excess of 50us latency as observed by cyclictest
(this violates the latency requirement of vRAN application with 1ms TTI,
for example).

invalidate_bh_lrus calls an IPI on each CPU that has non empty
per-CPU cache:

        on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);

Upon closer investigation, it was found that in current codebase, lookup_bh_lru
is slower than __find_get_block_slow:

 114 ns per __find_get_block
 68 ns per __find_get_block_slow

So remove the per-CPU buffer_head caching.

Test program:

#define NRLOOPS 200000
static int __init example_init(void)
{
        ktime_t s, e;
        s64 delta;
        int i, suc;

        bdev = blkdev_get_by_path("/dev/loop0", FMODE_READ, NULL);
        if (IS_ERR(bdev)) {
                printk(KERN_ERR "failed to load /dev/loop0\n");
                return -ENODEV;
        }

        suc = 0;
        delta = 0;
        for (i=0; i < NRLOOPS; i++) {
                struct buffer_head *bh;

                s = ktime_get();
                bh = __find_get_block(bdev, 1, 512);
                e = ktime_get();
                if (bh) {
                                suc++;
                                __brelse(bh);
                }
                delta = delta + ktime_to_ns(ktime_sub(e, s));

        }
        printk(KERN_ERR "%lld ns per __find_get_block (suc=%d)\n", delta/NRLOOPS, suc);

        suc = 0;
        delta = 0;
        for (i=0; i < NRLOOPS; i++) {
                struct buffer_head *bh;

                s = ktime_get();
                bh = __find_get_block_slow(bdev, 1);
                e = ktime_get();
                if (bh) {
                        suc++;
                        __brelse(bh);
                }
                delta = delta + ktime_to_ns(ktime_sub(e, s));
        }
        printk(KERN_ERR "%lld ns per __find_get_block_slow (suc=%d)\n", delta/NRLOOPS, suc);

        return 0;
}

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

 block/bdev.c                |    2 -
 fs/buffer.c                 |  209 +++++-------------------------------------------------------------------------------------------------------------------------------------------------------
 fs/jbd2/revoke.c            |    9 ++----
 fs/mpage.c                  |    3 --
 fs/ocfs2/journal.c          |    3 --
 fs/reiserfs/reiserfs.h      |    2 -
 include/linux/buffer_head.h |   11 ++------
 mm/migrate.c                |   12 +-------
 mm/swap.c                   |    4 --
 9 files changed, 21 insertions(+), 234 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef323..dc511024b11f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -72,7 +72,6 @@ static void kill_bdev(struct block_device *bdev)
 	if (mapping_empty(mapping))
 		return;
 
-	invalidate_bh_lrus();
 	truncate_inode_pages(mapping, 0);
 }
 
@@ -82,7 +81,6 @@ void invalidate_bdev(struct block_device *bdev)
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
 	if (mapping->nrpages) {
-		invalidate_bh_lrus();
 		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
 	}
diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..916d35af8628 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -186,8 +186,8 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  * may be quite high.  This code could TryLock the page, and if that
  * succeeds, there is no need to take private_lock.
  */
-static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+struct buffer_head *
+__find_get_block(struct block_device *bdev, sector_t block)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -227,7 +227,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	 */
 	ratelimit_set_flags(&last_warned, RATELIMIT_MSG_ON_RELEASE);
 	if (all_mapped && __ratelimit(&last_warned)) {
-		printk("__find_get_block_slow() failed. block=%llu, "
+		printk("__find_get_block() failed. block=%llu, "
 		       "b_blocknr=%llu, b_state=0x%08lx, b_size=%zu, "
 		       "device %pg blocksize: %d\n",
 		       (unsigned long long)block,
@@ -241,6 +241,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(__find_get_block);
 
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
@@ -598,10 +599,9 @@ EXPORT_SYMBOL(sync_mapping_buffers);
  * `bblock + 1' is probably a dirty indirect block.  Hunt it down and, if it's
  * dirty, schedule it for IO.  So that indirects merge nicely with their data.
  */
-void write_boundary_block(struct block_device *bdev,
-			sector_t bblock, unsigned blocksize)
+void write_boundary_block(struct block_device *bdev, sector_t bblock)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh = __find_get_block(bdev, bblock + 1);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -1080,7 +1080,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 		struct buffer_head *bh;
 		int ret;
 
-		bh = __find_get_block(bdev, block, size);
+		bh = __find_get_block(bdev, block);
 		if (bh)
 			return bh;
 
@@ -1232,137 +1232,6 @@ static struct buffer_head *__bread_slow(struct buffer_head *bh)
 	return NULL;
 }
 
-/*
- * Per-cpu buffer LRU implementation.  To reduce the cost of __find_get_block().
- * The bhs[] array is sorted - newest buffer is at bhs[0].  Buffers have their
- * refcount elevated by one when they're in an LRU.  A buffer can only appear
- * once in a particular CPU's LRU.  A single buffer can be present in multiple
- * CPU's LRUs at the same time.
- *
- * This is a transparent caching front-end to sb_bread(), sb_getblk() and
- * sb_find_get_block().
- *
- * The LRUs themselves only need locking against invalidate_bh_lrus.  We use
- * a local interrupt disable for that.
- */
-
-#define BH_LRU_SIZE	16
-
-struct bh_lru {
-	struct buffer_head *bhs[BH_LRU_SIZE];
-};
-
-static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
-
-#ifdef CONFIG_SMP
-#define bh_lru_lock()	local_irq_disable()
-#define bh_lru_unlock()	local_irq_enable()
-#else
-#define bh_lru_lock()	preempt_disable()
-#define bh_lru_unlock()	preempt_enable()
-#endif
-
-static inline void check_irqs_on(void)
-{
-#ifdef irqs_disabled
-	BUG_ON(irqs_disabled());
-#endif
-}
-
-/*
- * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
- * inserted at the front, and the buffer_head at the back if any is evicted.
- * Or, if already in the LRU it is moved to the front.
- */
-static void bh_lru_install(struct buffer_head *bh)
-{
-	struct buffer_head *evictee = bh;
-	struct bh_lru *b;
-	int i;
-
-	check_irqs_on();
-	bh_lru_lock();
-
-	/*
-	 * the refcount of buffer_head in bh_lru prevents dropping the
-	 * attached page(i.e., try_to_free_buffers) so it could cause
-	 * failing page migration.
-	 * Skip putting upcoming bh into bh_lru until migration is done.
-	 */
-	if (lru_cache_disabled()) {
-		bh_lru_unlock();
-		return;
-	}
-
-	b = this_cpu_ptr(&bh_lrus);
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		swap(evictee, b->bhs[i]);
-		if (evictee == bh) {
-			bh_lru_unlock();
-			return;
-		}
-	}
-
-	get_bh(bh);
-	bh_lru_unlock();
-	brelse(evictee);
-}
-
-/*
- * Look up the bh in this cpu's LRU.  If it's there, move it to the head.
- */
-static struct buffer_head *
-lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
-{
-	struct buffer_head *ret = NULL;
-	unsigned int i;
-
-	check_irqs_on();
-	bh_lru_lock();
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
-
-		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
-		    bh->b_size == size) {
-			if (i) {
-				while (i) {
-					__this_cpu_write(bh_lrus.bhs[i],
-						__this_cpu_read(bh_lrus.bhs[i - 1]));
-					i--;
-				}
-				__this_cpu_write(bh_lrus.bhs[0], bh);
-			}
-			get_bh(bh);
-			ret = bh;
-			break;
-		}
-	}
-	bh_lru_unlock();
-	return ret;
-}
-
-/*
- * Perform a pagecache lookup for the matching buffer.  If it's there, refresh
- * it in the LRU and mark it as accessed.  If it is not present then return
- * NULL
- */
-struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
-{
-	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
-
-	if (bh == NULL) {
-		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
-		if (bh)
-			bh_lru_install(bh);
-	} else
-		touch_buffer(bh);
-
-	return bh;
-}
-EXPORT_SYMBOL(__find_get_block);
-
 /*
  * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
  * which corresponds to the passed block_device, block and size. The
@@ -1375,7 +1244,7 @@ struct buffer_head *
 __getblk_gfp(struct block_device *bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh = __find_get_block(bdev, block);
 
 	might_sleep();
 	if (bh == NULL)
@@ -1421,61 +1290,6 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 }
 EXPORT_SYMBOL(__bread_gfp);
 
-static void __invalidate_bh_lrus(struct bh_lru *b)
-{
-	int i;
-
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		brelse(b->bhs[i]);
-		b->bhs[i] = NULL;
-	}
-}
-/*
- * invalidate_bh_lrus() is called rarely - but not only at unmount.
- * This doesn't race because it runs in each cpu either in irq
- * or with preempt disabled.
- */
-static void invalidate_bh_lru(void *arg)
-{
-	struct bh_lru *b = &get_cpu_var(bh_lrus);
-
-	__invalidate_bh_lrus(b);
-	put_cpu_var(bh_lrus);
-}
-
-bool has_bh_in_lru(int cpu, void *dummy)
-{
-	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
-	int i;
-	
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		if (b->bhs[i])
-			return true;
-	}
-
-	return false;
-}
-
-void invalidate_bh_lrus(void)
-{
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
-}
-EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
-
-/*
- * It's called from workqueue context so we need a bh_lru_lock to close
- * the race with preemption/irq.
- */
-void invalidate_bh_lrus_cpu(void)
-{
-	struct bh_lru *b;
-
-	bh_lru_lock();
-	b = this_cpu_ptr(&bh_lrus);
-	__invalidate_bh_lrus(b);
-	bh_lru_unlock();
-}
-
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
@@ -2997,13 +2811,6 @@ EXPORT_SYMBOL(free_buffer_head);
 
 static int buffer_exit_cpu_dead(unsigned int cpu)
 {
-	int i;
-	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
-
-	for (i = 0; i < BH_LRU_SIZE; i++) {
-		brelse(b->bhs[i]);
-		b->bhs[i] = NULL;
-	}
 	this_cpu_add(bh_accounting.nr, per_cpu(bh_accounting, cpu).nr);
 	per_cpu(bh_accounting, cpu).nr = 0;
 	return 0;
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..f68b9207737d 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -345,7 +345,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 	bh = bh_in;
 
 	if (!bh) {
-		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh = __find_get_block(bdev, blocknr);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -355,7 +355,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block(bdev, blocknr);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if (bh2 != bh && buffer_revokevalid(bh2))
@@ -466,7 +466,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
+		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
@@ -496,8 +496,7 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 			struct buffer_head *bh;
 			record = (struct jbd2_revoke_record_s *)list_entry;
 			bh = __find_get_block(journal->j_fs_dev,
-					      record->blocknr,
-					      journal->j_blocksize);
+					      record->blocknr);
 			if (bh) {
 				clear_buffer_revoked(bh);
 				__brelse(bh);
diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..e50d30a009ce 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -634,8 +634,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (boundary || (first_unmapped != blocks_per_page)) {
 		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
-			write_boundary_block(boundary_bdev,
-					boundary_block, 1 << blkbits);
+			write_boundary_block(boundary_bdev, boundary_block);
 		}
 	} else {
 		mpd->last_block_in_bio = blocks[blocks_per_page - 1];
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 25d8072ccfce..12be1471c9aa 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1212,8 +1212,7 @@ static int ocfs2_force_read_journal(struct inode *inode)
 		}
 
 		for (i = 0; i < p_blocks; i++, p_blkno++) {
-			bh = __find_get_block(osb->sb->s_bdev, p_blkno,
-					osb->sb->s_blocksize);
+			bh = __find_get_block(osb->sb->s_bdev, p_blkno);
 			/* block not cached. */
 			if (!bh)
 				continue;
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 1bccf6a2e908..19708f600bce 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2810,7 +2810,7 @@ struct reiserfs_journal_header {
 #define journal_hash(t,sb,block) ((t)[_jhashfn((sb),(block)) & JBH_HASH_MASK])
 
 /* We need these to make journal.c code more readable */
-#define journal_find_get_block(s, block) __find_get_block(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
+#define journal_find_get_block(s, block) __find_get_block(SB_JOURNAL(s)->j_dev_bd, block)
 #define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
 #define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 1520793c72da..084a9d5f53d3 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -227,8 +227,7 @@ static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 void mark_buffer_async_write(struct buffer_head *bh);
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
-struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
-			unsigned size);
+struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block);
 struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
 				  unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
@@ -236,9 +235,6 @@ void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
-void invalidate_bh_lrus(void);
-void invalidate_bh_lrus_cpu(void);
-bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -247,8 +243,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void submit_bh(blk_opf_t, struct buffer_head *);
-void write_boundary_block(struct block_device *bdev,
-			sector_t bblock, unsigned blocksize);
+void write_boundary_block(struct block_device *bdev, sector_t bblock);
 int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 void __bh_read_batch(int nr, struct buffer_head *bhs[],
@@ -375,7 +370,7 @@ sb_getblk_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
 static inline struct buffer_head *
 sb_find_get_block(struct super_block *sb, sector_t block)
 {
-	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
+	return __find_get_block(sb->s_bdev, block);
 }
 
 static inline void
diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..ceecd95cfd49 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -747,9 +747,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 
 	if (check_refs) {
 		bool busy;
-		bool invalidated = false;
 
-recheck_buffers:
 		busy = false;
 		spin_lock(&mapping->private_lock);
 		bh = head;
@@ -761,14 +759,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 			bh = bh->b_this_page;
 		} while (bh != head);
 		if (busy) {
-			if (invalidated) {
-				rc = -EAGAIN;
-				goto unlock_buffers;
-			}
-			spin_unlock(&mapping->private_lock);
-			invalidate_bh_lrus();
-			invalidated = true;
-			goto recheck_buffers;
+			rc = -EAGAIN;
+			goto unlock_buffers;
 		}
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index 423199ee8478..64ce7255ff4d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -765,7 +765,6 @@ static void lru_add_and_bh_lrus_drain(void)
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	local_unlock(&cpu_fbatches.lock);
-	invalidate_bh_lrus_cpu();
 	mlock_drain_local();
 }
 
@@ -798,8 +797,7 @@ static bool cpu_needs_drain(unsigned int cpu)
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
 		folio_batch_count(&fbatches->activate) ||
-		need_mlock_drain(cpu) ||
-		has_bh_in_lru(cpu, NULL);
+		need_mlock_drain(cpu);
 }
 
 /*

