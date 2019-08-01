Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37797D2B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 03:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfHABQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 21:16:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbfHABQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:16:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hszhL-0002IK-Em; Thu, 01 Aug 2019 03:16:03 +0200
Message-Id: <20190801010944.457499601@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 03:01:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        "Theodore Tso" <tytso@mit.edu>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [patch V2 6/7] fs/jbd2: Make state lock a spinlock
References: <20190801010126.245731659@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bit-spinlocks are problematic on PREEMPT_RT if functions which might sleep
on RT, e.g. spin_lock(), alloc/free(), are invoked inside the lock held
region because bit spinlocks disable preemption even on RT.

A first attempt was to replace state lock with a spinlock placed in struct
buffer_head and make the locking conditional on PREEMPT_RT and
DEBUG_BIT_SPINLOCKS.

Jan pointed out that there is a 4 byte hole in struct journal_head where a
regular spinlock fits in and he would not object to convert the state lock
to a spinlock unconditionally.

Aside of solving the RT problem, this also gains lockdep coverage for the
journal head state lock (bit-spinlocks are not covered by lockdep as it's
hard to fit a lockdep map into a single bit).

The trivial change would have been to convert the jbd_*lock_bh_state()
inlines, but that comes with the downside that these functions take a
buffer head pointer which needs to be converted to a journal head pointer
which adds another level of indirection.

As almost all functions which use this lock have a journal head pointer
readily available, it makes more sense to remove the lock helper inlines
and write out spin_*lock() at all call sites.

Fixup all locking comments as well.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
---
V2: New patch
---
 fs/jbd2/commit.c             |    8 ++--
 fs/jbd2/journal.c            |   10 +++--
 fs/jbd2/transaction.c        |   83 +++++++++++++++++++++----------------------
 fs/ocfs2/suballoc.c          |   19 +++++----
 include/linux/jbd2.h         |   20 +---------
 include/linux/journal-head.h |   19 ++++++---
 6 files changed, 77 insertions(+), 82 deletions(-)

--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -482,10 +482,10 @@ void jbd2_journal_commit_transaction(jou
 		if (jh->b_committed_data) {
 			struct buffer_head *bh = jh2bh(jh);
 
-			jbd_lock_bh_state(bh);
+			spin_lock(&jh->state_lock);
 			jbd2_free(jh->b_committed_data, bh->b_size);
 			jh->b_committed_data = NULL;
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->state_lock);
 		}
 		jbd2_journal_refile_buffer(journal, jh);
 	}
@@ -927,7 +927,7 @@ void jbd2_journal_commit_transaction(jou
 		 * done with it.
 		 */
 		get_bh(bh);
-		jbd_lock_bh_state(bh);
+		spin_lock(&jh->state_lock);
 		J_ASSERT_JH(jh,	jh->b_transaction == commit_transaction);
 
 		/*
@@ -1023,7 +1023,7 @@ void jbd2_journal_commit_transaction(jou
 		}
 		JBUFFER_TRACE(jh, "refile or unfile buffer");
 		__jbd2_journal_refile_buffer(jh);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->state_lock);
 		if (try_to_free)
 			release_buffer_page(bh);	/* Drops bh reference */
 		else
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -365,7 +365,7 @@ int jbd2_journal_write_metadata_buffer(t
 	/* keep subsequent assertions sane */
 	atomic_set(&new_bh->b_count, 1);
 
-	jbd_lock_bh_state(bh_in);
+	spin_lock(&jh_in->state_lock);
 repeat:
 	/*
 	 * If a new transaction has already done a buffer copy-out, then
@@ -407,13 +407,13 @@ int jbd2_journal_write_metadata_buffer(t
 	if (need_copy_out && !done_copy_out) {
 		char *tmp;
 
-		jbd_unlock_bh_state(bh_in);
+		spin_unlock(&jh_in->state_lock);
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
 			return -ENOMEM;
 		}
-		jbd_lock_bh_state(bh_in);
+		spin_lock(&jh_in->state_lock);
 		if (jh_in->b_frozen_data) {
 			jbd2_free(tmp, bh_in->b_size);
 			goto repeat;
@@ -466,7 +466,7 @@ int jbd2_journal_write_metadata_buffer(t
 	__jbd2_journal_file_buffer(jh_in, transaction, BJ_Shadow);
 	spin_unlock(&journal->j_list_lock);
 	set_buffer_shadow(bh_in);
-	jbd_unlock_bh_state(bh_in);
+	spin_unlock(&jh_in->state_lock);
 
 	return do_escape | (done_copy_out << 1);
 }
@@ -2412,6 +2412,8 @@ static struct journal_head *journal_allo
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
 	}
+	if (ret)
+		spin_lock_init(&ret->state_lock);
 	return ret;
 }
 
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -876,7 +876,7 @@ do_get_write_access(handle_t *handle, st
 
  	start_lock = jiffies;
 	lock_buffer(bh);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 
 	/* If it takes too long to lock the buffer, trace it */
 	time_lock = jbd2_time_diff(start_lock, jiffies);
@@ -926,7 +926,7 @@ do_get_write_access(handle_t *handle, st
 
 	error = -EROFS;
 	if (is_handle_aborted(handle)) {
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->state_lock);
 		goto out;
 	}
 	error = 0;
@@ -990,7 +990,7 @@ do_get_write_access(handle_t *handle, st
 	 */
 	if (buffer_shadow(bh)) {
 		JBUFFER_TRACE(jh, "on shadow: sleep");
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->state_lock);
 		wait_on_bit_io(&bh->b_state, BH_Shadow, TASK_UNINTERRUPTIBLE);
 		goto repeat;
 	}
@@ -1011,7 +1011,7 @@ do_get_write_access(handle_t *handle, st
 		JBUFFER_TRACE(jh, "generate frozen data");
 		if (!frozen_buffer) {
 			JBUFFER_TRACE(jh, "allocate memory for buffer");
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->state_lock);
 			frozen_buffer = jbd2_alloc(jh2bh(jh)->b_size,
 						   GFP_NOFS | __GFP_NOFAIL);
 			goto repeat;
@@ -1030,7 +1030,7 @@ do_get_write_access(handle_t *handle, st
 	jh->b_next_transaction = transaction;
 
 done:
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 
 	/*
 	 * If we are about to journal a buffer, then any revoke pending on it is
@@ -1169,7 +1169,7 @@ int jbd2_journal_get_create_access(handl
 	 * that case: the transaction must have deleted the buffer for it to be
 	 * reused here.
 	 */
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 	J_ASSERT_JH(jh, (jh->b_transaction == transaction ||
 		jh->b_transaction == NULL ||
 		(jh->b_transaction == journal->j_committing_transaction &&
@@ -1204,7 +1204,7 @@ int jbd2_journal_get_create_access(handl
 		jh->b_next_transaction = transaction;
 		spin_unlock(&journal->j_list_lock);
 	}
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 
 	/*
 	 * akpm: I added this.  ext3_alloc_branch can pick up new indirect
@@ -1272,13 +1272,13 @@ int jbd2_journal_get_undo_access(handle_
 		committed_data = jbd2_alloc(jh2bh(jh)->b_size,
 					    GFP_NOFS|__GFP_NOFAIL);
 
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 	if (!jh->b_committed_data) {
 		/* Copy out the current buffer contents into the
 		 * preserved, committed copy. */
 		JBUFFER_TRACE(jh, "generate b_committed data");
 		if (!committed_data) {
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->state_lock);
 			goto repeat;
 		}
 
@@ -1286,7 +1286,7 @@ int jbd2_journal_get_undo_access(handle_
 		committed_data = NULL;
 		memcpy(jh->b_committed_data, bh->b_data, bh->b_size);
 	}
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 out:
 	jbd2_journal_put_journal_head(jh);
 	if (unlikely(committed_data))
@@ -1387,16 +1387,16 @@ int jbd2_journal_dirty_metadata(handle_t
 	 */
 	if (jh->b_transaction != transaction &&
 	    jh->b_next_transaction != transaction) {
-		jbd_lock_bh_state(bh);
+		spin_lock(&jh->state_lock);
 		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_next_transaction == transaction);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->state_lock);
 	}
 	if (jh->b_modified == 1) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
 		if (jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata) {
-			jbd_lock_bh_state(bh);
+			spin_lock(&jh->state_lock);
 			if (jh->b_transaction == transaction &&
 			    jh->b_jlist != BJ_Metadata)
 				pr_err("JBD2: assertion failure: h_type=%u "
@@ -1406,13 +1406,13 @@ int jbd2_journal_dirty_metadata(handle_t
 				       jh->b_jlist);
 			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
 					jh->b_jlist == BJ_Metadata);
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->state_lock);
 		}
 		goto out;
 	}
 
 	journal = transaction->t_journal;
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 
 	if (jh->b_modified == 0) {
 		/*
@@ -1498,7 +1498,7 @@ int jbd2_journal_dirty_metadata(handle_t
 	__jbd2_journal_file_buffer(jh, transaction, BJ_Metadata);
 	spin_unlock(&journal->j_list_lock);
 out_unlock_bh:
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 out:
 	JBUFFER_TRACE(jh, "exit");
 	return ret;
@@ -1536,18 +1536,18 @@ int jbd2_journal_forget (handle_t *handl
 
 	BUFFER_TRACE(bh, "entry");
 
-	jbd_lock_bh_state(bh);
-
 	if (!buffer_jbd(bh))
 		goto not_jbd;
+
 	jh = bh2jh(bh);
+	spin_lock(&jh->state_lock);
 
 	/* Critical error: attempting to delete a bitmap buffer, maybe?
 	 * Don't do any jbd operations, and return an error. */
 	if (!J_EXPECT_JH(jh, !jh->b_committed_data,
 			 "inconsistent data on disk")) {
 		err = -EIO;
-		goto not_jbd;
+		goto bad_jbd;
 	}
 
 	/* keep track of whether or not this transaction modified us */
@@ -1664,7 +1664,7 @@ int jbd2_journal_forget (handle_t *handl
 		spin_unlock(&journal->j_list_lock);
 	}
 
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 	__brelse(bh);
 drop:
 	if (drop_reserve) {
@@ -1673,8 +1673,9 @@ int jbd2_journal_forget (handle_t *handl
 	}
 	return err;
 
+bad_jbd:
+	spin_unlock(&jh->state_lock);
 not_jbd:
-	jbd_unlock_bh_state(bh);
 	__bforget(bh);
 	goto drop;
 }
@@ -1875,7 +1876,7 @@ int jbd2_journal_stop(handle_t *handle)
  *
  * j_list_lock is held.
  *
- * jbd_lock_bh_state(jh2bh(jh)) is held.
+ * jh->state_lock is held.
  */
 
 static inline void
@@ -1899,7 +1900,7 @@ static inline void
  *
  * Called with j_list_lock held, and the journal may not be locked.
  *
- * jbd_lock_bh_state(jh2bh(jh)) is held.
+ * jh->state_lock is held.
  */
 
 static inline void
@@ -1931,7 +1932,7 @@ static void __jbd2_journal_temp_unlink_b
 	transaction_t *transaction;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
+	assert_spin_locked(&jh->state_lock);
 	transaction = jh->b_transaction;
 	if (transaction)
 		assert_spin_locked(&transaction->t_journal->j_list_lock);
@@ -1987,18 +1988,18 @@ void jbd2_journal_unfile_buffer(journal_
 
 	/* Get reference so that buffer cannot be freed before we unlock it */
 	get_bh(bh);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 	spin_lock(&journal->j_list_lock);
 	__jbd2_journal_unfile_buffer(jh);
 	spin_unlock(&journal->j_list_lock);
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 	__brelse(bh);
 }
 
 /*
  * Called from jbd2_journal_try_to_free_buffers().
  *
- * Called under jbd_lock_bh_state(bh)
+ * Called under spin_lock(&jh->state_lock)
  */
 static void
 __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
@@ -2085,10 +2086,10 @@ int jbd2_journal_try_to_free_buffers(jou
 		if (!jh)
 			continue;
 
-		jbd_lock_bh_state(bh);
+		spin_lock(&jh->state_lock);
 		__journal_try_to_free_buffer(journal, bh);
 		jbd2_journal_put_journal_head(jh);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->state_lock);
 		if (buffer_jbd(bh))
 			goto busy;
 	} while ((bh = bh->b_this_page) != head);
@@ -2109,7 +2110,7 @@ int jbd2_journal_try_to_free_buffers(jou
  *
  * Called under j_list_lock.
  *
- * Called under jbd_lock_bh_state(bh).
+ * Called under spin_lock(&jh->state_lock).
  */
 static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
 {
@@ -2202,7 +2203,7 @@ static int journal_unmap_buffer(journal_
 
 	/* OK, we have data buffer in journaled mode */
 	write_lock(&journal->j_state_lock);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 	spin_lock(&journal->j_list_lock);
 
 	/*
@@ -2285,7 +2286,7 @@ static int journal_unmap_buffer(journal_
 		if (partial_page) {
 			jbd2_journal_put_journal_head(jh);
 			spin_unlock(&journal->j_list_lock);
-			jbd_unlock_bh_state(bh);
+			spin_unlock(&jh->state_lock);
 			write_unlock(&journal->j_state_lock);
 			return -EBUSY;
 		}
@@ -2300,7 +2301,7 @@ static int journal_unmap_buffer(journal_
 			jh->b_next_transaction = journal->j_running_transaction;
 		jbd2_journal_put_journal_head(jh);
 		spin_unlock(&journal->j_list_lock);
-		jbd_unlock_bh_state(bh);
+		spin_unlock(&jh->state_lock);
 		write_unlock(&journal->j_state_lock);
 		return 0;
 	} else {
@@ -2327,7 +2328,7 @@ static int journal_unmap_buffer(journal_
 	jh->b_modified = 0;
 	jbd2_journal_put_journal_head(jh);
 	spin_unlock(&journal->j_list_lock);
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 	write_unlock(&journal->j_state_lock);
 zap_buffer_unlocked:
 	clear_buffer_dirty(bh);
@@ -2415,7 +2416,7 @@ void __jbd2_journal_file_buffer(struct j
 	int was_dirty = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
+	assert_spin_locked(&jh->state_lock);
 	assert_spin_locked(&transaction->t_journal->j_list_lock);
 
 	J_ASSERT_JH(jh, jh->b_jlist < BJ_Types);
@@ -2477,11 +2478,11 @@ void __jbd2_journal_file_buffer(struct j
 void jbd2_journal_file_buffer(struct journal_head *jh,
 				transaction_t *transaction, int jlist)
 {
-	jbd_lock_bh_state(jh2bh(jh));
+	spin_lock(&jh->state_lock);
 	spin_lock(&transaction->t_journal->j_list_lock);
 	__jbd2_journal_file_buffer(jh, transaction, jlist);
 	spin_unlock(&transaction->t_journal->j_list_lock);
-	jbd_unlock_bh_state(jh2bh(jh));
+	spin_unlock(&jh->state_lock);
 }
 
 /*
@@ -2491,7 +2492,7 @@ void jbd2_journal_file_buffer(struct jou
  * buffer on that transaction's metadata list.
  *
  * Called under j_list_lock
- * Called under jbd_lock_bh_state(jh2bh(jh))
+ * Called under jh->state_lock
  *
  * jh and bh may be already free when this function returns
  */
@@ -2500,7 +2501,7 @@ void __jbd2_journal_refile_buffer(struct
 	int was_dirty, jlist;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
+	assert_spin_locked(&jh->state_lock);
 	if (jh->b_transaction)
 		assert_spin_locked(&jh->b_transaction->t_journal->j_list_lock);
 
@@ -2549,10 +2550,10 @@ void jbd2_journal_refile_buffer(journal_
 
 	/* Get reference so that buffer cannot be freed before we unlock it */
 	get_bh(bh);
-	jbd_lock_bh_state(bh);
+	spin_lock(&jh->state_lock);
 	spin_lock(&journal->j_list_lock);
 	__jbd2_journal_refile_buffer(jh);
-	jbd_unlock_bh_state(bh);
+	spin_unlock(&jh->state_lock);
 	spin_unlock(&journal->j_list_lock);
 	__brelse(bh);
 }
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1252,6 +1252,7 @@ static int ocfs2_test_bg_bit_allocatable
 					 int nr)
 {
 	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) bg_bh->b_data;
+	struct journal_head *jh;
 	int ret;
 
 	if (ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap))
@@ -1260,13 +1261,14 @@ static int ocfs2_test_bg_bit_allocatable
 	if (!buffer_jbd(bg_bh))
 		return 1;
 
-	jbd_lock_bh_state(bg_bh);
-	bg = (struct ocfs2_group_desc *) bh2jh(bg_bh)->b_committed_data;
+	jh = bh2jh(bg_bh);
+	spin_lock(&jh->state_lock);
+	bg = (struct ocfs2_group_desc *) jh->b_committed_data;
 	if (bg)
 		ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
 	else
 		ret = 1;
-	jbd_unlock_bh_state(bg_bh);
+	spin_unlock(&jh->state_lock);
 
 	return ret;
 }
@@ -2387,6 +2389,7 @@ static int ocfs2_block_group_clear_bits(
 	int status;
 	unsigned int tmp;
 	struct ocfs2_group_desc *undo_bg = NULL;
+	struct journal_head *jh;
 
 	/* The caller got this descriptor from
 	 * ocfs2_read_group_descriptor().  Any corruption is a code bug. */
@@ -2405,10 +2408,10 @@ static int ocfs2_block_group_clear_bits(
 		goto bail;
 	}
 
+	jh = bh2jh(group_bh);
 	if (undo_fn) {
-		jbd_lock_bh_state(group_bh);
-		undo_bg = (struct ocfs2_group_desc *)
-					bh2jh(group_bh)->b_committed_data;
+		spin_lock(&jh->state_lock);
+		undo_bg = (struct ocfs2_group_desc *) jh->b_committed_data;
 		BUG_ON(!undo_bg);
 	}
 
@@ -2423,7 +2426,7 @@ static int ocfs2_block_group_clear_bits(
 	le16_add_cpu(&bg->bg_free_bits_count, num_bits);
 	if (le16_to_cpu(bg->bg_free_bits_count) > le16_to_cpu(bg->bg_bits)) {
 		if (undo_fn)
-			jbd_unlock_bh_state(group_bh);
+			spin_unlock(&jh->state_lock);
 		return ocfs2_error(alloc_inode->i_sb, "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
 				   (unsigned long long)le64_to_cpu(bg->bg_blkno),
 				   le16_to_cpu(bg->bg_bits),
@@ -2432,7 +2435,7 @@ static int ocfs2_block_group_clear_bits(
 	}
 
 	if (undo_fn)
-		jbd_unlock_bh_state(group_bh);
+		spin_unlock(&jh->state_lock);
 
 	ocfs2_journal_dirty(handle, group_bh);
 bail:
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -313,7 +313,6 @@ enum jbd_state_bits {
 	BH_Revoked,		/* Has been revoked from the log */
 	BH_RevokeValid,		/* Revoked flag is valid */
 	BH_JBDDirty,		/* Is dirty but journaled */
-	BH_State,		/* Pins most journal_head state */
 	BH_JournalHead,		/* Pins bh->b_private and jh->b_bh */
 	BH_Shadow,		/* IO on shadow buffer is running */
 	BH_Verified,		/* Metadata block has been verified ok */
@@ -342,21 +341,6 @@ static inline struct journal_head *bh2jh
 	return bh->b_private;
 }
 
-static inline void jbd_lock_bh_state(struct buffer_head *bh)
-{
-	bit_spin_lock(BH_State, &bh->b_state);
-}
-
-static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
-{
-	return bit_spin_is_locked(BH_State, &bh->b_state);
-}
-
-static inline void jbd_unlock_bh_state(struct buffer_head *bh)
-{
-	bit_spin_unlock(BH_State, &bh->b_state);
-}
-
 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_JournalHead, &bh->b_state);
@@ -551,9 +535,9 @@ struct transaction_chp_stats_s {
  *      ->jbd_lock_bh_journal_head()	(This is "innermost")
  *
  *    j_state_lock
- *    ->jbd_lock_bh_state()
+ *    ->jh->state_lock
  *
- *    jbd_lock_bh_state()
+ *    jh->state_lock
  *    ->j_list_lock
  *
  *    j_state_lock
--- a/include/linux/journal-head.h
+++ b/include/linux/journal-head.h
@@ -24,13 +24,18 @@ struct journal_head {
 	struct buffer_head *b_bh;
 
 	/*
+	 * Protect the buffer head state
+	 */
+	spinlock_t state_lock;
+
+	/*
 	 * Reference count - see description in journal.c
 	 * [jbd_lock_bh_journal_head()]
 	 */
 	int b_jcount;
 
 	/*
-	 * Journalling list for this buffer [jbd_lock_bh_state()]
+	 * Journalling list for this buffer [jh->state_lock]
 	 * NOTE: We *cannot* combine this with b_modified into a bitfield
 	 * as gcc would then (which the C standard allows but which is
 	 * very unuseful) make 64-bit accesses to the bitfield and clobber
@@ -41,20 +46,20 @@ struct journal_head {
 	/*
 	 * This flag signals the buffer has been modified by
 	 * the currently running transaction
-	 * [jbd_lock_bh_state()]
+	 * [jh->state_lock]
 	 */
 	unsigned b_modified;
 
 	/*
 	 * Copy of the buffer data frozen for writing to the log.
-	 * [jbd_lock_bh_state()]
+	 * [jh->state_lock]
 	 */
 	char *b_frozen_data;
 
 	/*
 	 * Pointer to a saved copy of the buffer containing no uncommitted
 	 * deallocation references, so that allocations can avoid overwriting
-	 * uncommitted deletes. [jbd_lock_bh_state()]
+	 * uncommitted deletes. [jh->state_lock]
 	 */
 	char *b_committed_data;
 
@@ -63,7 +68,7 @@ struct journal_head {
 	 * metadata: either the running transaction or the committing
 	 * transaction (if there is one).  Only applies to buffers on a
 	 * transaction's data or metadata journaling list.
-	 * [j_list_lock] [jbd_lock_bh_state()]
+	 * [j_list_lock] [jh->state_lock]
 	 * Either of these locks is enough for reading, both are needed for
 	 * changes.
 	 */
@@ -73,13 +78,13 @@ struct journal_head {
 	 * Pointer to the running compound transaction which is currently
 	 * modifying the buffer's metadata, if there was already a transaction
 	 * committing it when the new transaction touched it.
-	 * [t_list_lock] [jbd_lock_bh_state()]
+	 * [t_list_lock] [jh->state_lock]
 	 */
 	transaction_t *b_next_transaction;
 
 	/*
 	 * Doubly-linked list of buffers on a transaction's data, metadata or
-	 * forget queue. [t_list_lock] [jbd_lock_bh_state()]
+	 * forget queue. [t_list_lock] [jh->state_lock]
 	 */
 	struct journal_head *b_tnext, *b_tprev;
 


