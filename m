Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3953A29F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFJLRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5486 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJLRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:48 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G11Y83YsTzZf53;
        Thu, 10 Jun 2021 19:13:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:50 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 2/8] jbd2: ensure abort the journal if detect IO error when writing original buffer back
Date:   Thu, 10 Jun 2021 19:24:34 +0800
Message-ID: <20210610112440.3438139-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610112440.3438139-1-yi.zhang@huawei.com>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although we merged c044f3d8360 ("jbd2: abort journal if free a async
write error metadata buffer"), there is a race between
jbd2_journal_try_to_free_buffers() and jbd2_journal_destroy(), so the
jbd2_log_do_checkpoint() may still fail to detect the buffer write
io error flag which may lead to filesystem inconsistency.

jbd2_journal_try_to_free_buffers()     ext4_put_super()
                                        jbd2_journal_destroy()
  __jbd2_journal_remove_checkpoint()
  detect buffer write error              jbd2_log_do_checkpoint()
                                         jbd2_cleanup_journal_tail()
                                           <--- lead to inconsistency
  jbd2_journal_abort()

Fix this issue by introducing a new atomic flag which only have one
JBD2_CHECKPOINT_IO_ERROR bit now, and set it in
__jbd2_journal_remove_checkpoint() when freeing a checkpoint buffer
which has write_io_error flag. Then jbd2_journal_destroy() will detect
this mark and abort the journal to prevent updating log tail.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 12 ++++++++++++
 fs/jbd2/journal.c    | 14 ++++++++++++++
 include/linux/jbd2.h | 11 +++++++++++
 3 files changed, 37 insertions(+)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index bf5511d19ac5..d27c10f4502f 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -564,6 +564,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	struct transaction_chp_stats_s *stats;
 	transaction_t *transaction;
 	journal_t *journal;
+	struct buffer_head *bh = jh2bh(jh);
 
 	JBUFFER_TRACE(jh, "entry");
 
@@ -575,6 +576,17 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	journal = transaction->t_journal;
 
 	JBUFFER_TRACE(jh, "removing from transaction");
+
+	/*
+	 * If we have failed to write the buffer out to disk, the filesystem
+	 * may become inconsistent. We cannot abort the journal here since
+	 * we hold j_list_lock and we have to be careful about races with
+	 * jbd2_journal_destroy(). So mark the writeback IO error in the
+	 * journal here and we abort the journal later from a better context.
+	 */
+	if (buffer_write_io_error(bh))
+		set_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags);
+
 	__buffer_unlink(jh);
 	jh->b_cp_transaction = NULL;
 	jbd2_journal_put_journal_head(jh);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..90146755941f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1618,6 +1618,10 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	if (is_journal_aborted(journal))
 		return -EIO;
+	if (test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags)) {
+		jbd2_journal_abort(journal, -EIO);
+		return -EIO;
+	}
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
@@ -1995,6 +1999,16 @@ int jbd2_journal_destroy(journal_t *journal)
 	J_ASSERT(journal->j_checkpoint_transactions == NULL);
 	spin_unlock(&journal->j_list_lock);
 
+	/*
+	 * OK, all checkpoint transactions have been checked, now check the
+	 * write out io error flag and abort the journal if some buffer failed
+	 * to write back to the original location, otherwise the filesystem
+	 * may become inconsistent.
+	 */
+	if (!is_journal_aborted(journal) &&
+	    test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags))
+		jbd2_journal_abort(journal, -EIO);
+
 	if (journal->j_sb_buffer) {
 		if (!is_journal_aborted(journal)) {
 			mutex_lock_io(&journal->j_checkpoint_mutex);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index db0e1920cb12..f9b5e657b8f3 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -779,6 +779,11 @@ struct journal_s
 	 */
 	unsigned long		j_flags;
 
+	/**
+	 * @j_atomic_flags: Atomic journaling state flags.
+	 */
+	unsigned long		j_atomic_flags;
+
 	/**
 	 * @j_errno:
 	 *
@@ -1371,6 +1376,12 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 #define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
 #define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
 
+/*
+ * Journal atomic flag definitions
+ */
+#define JBD2_CHECKPOINT_IO_ERROR	0x001	/* Detect io error while writing
+						 * buffer back to disk */
+
 /*
  * Function declarations for the journaling transaction and buffer
  * management
-- 
2.31.1

