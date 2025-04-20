Return-Path: <linux-fsdevel+bounces-46737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68285A9483B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225687A56CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1920C47F;
	Sun, 20 Apr 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="noHw/2Mz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538120B813
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Apr 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745164771; cv=none; b=ltcoqcjKIW+RiWl9aj3je2DMbzf//4HeT9SVAZrjvkoqxB7Jmd/FsLnMVIcmLq25FcpiLdjl8Crz7VjFx6f3w3GWZKiA2VaUojQEJA/I+Do6g3uEIAfpZ/OnVFAxPy9L0bt6CbuzdwYQ3EGo8TDhh9t8/ZcoJtW0XGk1AigBF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745164771; c=relaxed/simple;
	bh=YJTA2WCu73KiUaMXC8PXQPYN2Tfrij0nfx8H+WdxTWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3cDqXt4t2rw2sZOQEV8q9E3xMGSDFxozNSBeX1mgPxW4ZX9wCQkPgI7LS9pc42p1/cwkD8EEpF8lz+w1A5Lj2kFyg4Y1a9VU4fohDlzcDKRJdZrIJw6zduO8PvqDE9y8Z6KFqqrJIlEdoXZutMW1POkvq/EDZKAsyiMoTWNnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=noHw/2Mz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745164766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hCKXlrHde8qXSd4LIsPBgn+QzDqDWcN7QcvO+ZGVpU=;
	b=noHw/2Mzdc9AdTAcY3mVgsoQtjWhoTS+GH22kclRbBTTJCFb7iLW47rSwjoaFAC8M76uzP
	pftbApbvDSzYKlK2k05iwCJaCMcDGE2+HQbVXd4oUcLyxb93gxjSe6WMI65Jfv0vDSoDUO
	D2ODPQXgnB/zlVeI1xO0xjM5244wnyE=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/3] bcachefs: bch_fs.writes -> enumerated_refs
Date: Sun, 20 Apr 2025 11:59:15 -0400
Message-ID: <20250420155918.749455-3-kent.overstreet@linux.dev>
In-Reply-To: <20250420155918.749455-1-kent.overstreet@linux.dev>
References: <20250420155918.749455-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the single-purpose write ref code in bcachefs.h, and convert to
enumarated refs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/alloc_background.c      | 23 ++++++------
 fs/bcachefs/bcachefs.h              | 57 ++---------------------------
 fs/bcachefs/btree_gc.c              |  7 ++--
 fs/bcachefs/btree_io.c              |  7 ++--
 fs/bcachefs/btree_trans_commit.c    |  5 ++-
 fs/bcachefs/btree_update_interior.c |  7 ++--
 fs/bcachefs/btree_write_buffer.c    | 11 +++---
 fs/bcachefs/ec.c                    | 13 ++++---
 fs/bcachefs/fs-io-direct.c          |  7 ++--
 fs/bcachefs/fs-io.c                 |  9 +++--
 fs/bcachefs/io_read.c               |  7 ++--
 fs/bcachefs/io_write.c              |  5 ++-
 fs/bcachefs/journal.c               |  5 ++-
 fs/bcachefs/reflink.c               |  5 ++-
 fs/bcachefs/snapshot.c              |  7 ++--
 fs/bcachefs/subvolume.c             |  7 ++--
 fs/bcachefs/super.c                 | 32 ++++------------
 fs/bcachefs/sysfs.c                 | 26 +++----------
 18 files changed, 87 insertions(+), 153 deletions(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index 6156c18b3347..c7e50b1835ed 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "disk_accounting.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "lru.h"
 #include "recovery.h"
@@ -1381,7 +1382,7 @@ static void check_discard_freespace_key_work(struct work_struct *work)
 		container_of(work, struct check_discard_freespace_key_async, work);
 
 	bch2_trans_do(w->c, bch2_recheck_discard_freespace_key(trans, w->pos));
-	bch2_write_ref_put(w->c, BCH_WRITE_REF_check_discard_freespace_key);
+	enumerated_ref_put(&w->c->writes, BCH_WRITE_REF_check_discard_freespace_key);
 	kfree(w);
 }
 
@@ -1458,7 +1459,7 @@ int bch2_check_discard_freespace_key(struct btree_trans *trans, struct btree_ite
 		if (!w)
 			goto out;
 
-		if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_check_discard_freespace_key)) {
+		if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_check_discard_freespace_key)) {
 			kfree(w);
 			goto out;
 		}
@@ -1953,14 +1954,14 @@ static void bch2_do_discards_work(struct work_struct *work)
 			      bch2_err_str(ret));
 
 	percpu_ref_put(&ca->io_ref[WRITE]);
-	bch2_write_ref_put(c, BCH_WRITE_REF_discard);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard);
 }
 
 void bch2_dev_do_discards(struct bch_dev *ca)
 {
 	struct bch_fs *c = ca->fs;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_discard))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_discard))
 		return;
 
 	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE))
@@ -1971,7 +1972,7 @@ void bch2_dev_do_discards(struct bch_dev *ca)
 
 	percpu_ref_put(&ca->io_ref[WRITE]);
 put_write_ref:
-	bch2_write_ref_put(c, BCH_WRITE_REF_discard);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard);
 }
 
 void bch2_do_discards(struct bch_fs *c)
@@ -2048,7 +2049,7 @@ static void bch2_do_discards_fast_work(struct work_struct *work)
 
 	bch2_trans_put(trans);
 	percpu_ref_put(&ca->io_ref[WRITE]);
-	bch2_write_ref_put(c, BCH_WRITE_REF_discard_fast);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard_fast);
 }
 
 static void bch2_discard_one_bucket_fast(struct bch_dev *ca, u64 bucket)
@@ -2058,7 +2059,7 @@ static void bch2_discard_one_bucket_fast(struct bch_dev *ca, u64 bucket)
 	if (discard_in_flight_add(ca, bucket, false))
 		return;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_discard_fast))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_discard_fast))
 		return;
 
 	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE))
@@ -2069,7 +2070,7 @@ static void bch2_discard_one_bucket_fast(struct bch_dev *ca, u64 bucket)
 
 	percpu_ref_put(&ca->io_ref[WRITE]);
 put_ref:
-	bch2_write_ref_put(c, BCH_WRITE_REF_discard_fast);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard_fast);
 }
 
 static int invalidate_one_bp(struct btree_trans *trans,
@@ -2263,14 +2264,14 @@ static void bch2_do_invalidates_work(struct work_struct *work)
 	bch2_trans_put(trans);
 	percpu_ref_put(&ca->io_ref[WRITE]);
 	bch2_bkey_buf_exit(&last_flushed, c);
-	bch2_write_ref_put(c, BCH_WRITE_REF_invalidate);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_invalidate);
 }
 
 void bch2_dev_do_invalidates(struct bch_dev *ca)
 {
 	struct bch_fs *c = ca->fs;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_invalidate))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_invalidate))
 		return;
 
 	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE))
@@ -2281,7 +2282,7 @@ void bch2_dev_do_invalidates(struct bch_dev *ca)
 
 	percpu_ref_put(&ca->io_ref[WRITE]);
 put_ref:
-	bch2_write_ref_put(c, BCH_WRITE_REF_invalidate);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_invalidate);
 }
 
 void bch2_do_invalidates(struct bch_fs *c)
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 56a71c7eb256..d00c320fe973 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -220,7 +220,7 @@
 #include "util.h"
 
 #ifdef CONFIG_BCACHEFS_DEBUG
-#define BCH_WRITE_REF_DEBUG
+#define ENUMERATED_REF_DEBUG
 #endif
 
 #ifndef dynamic_fault
@@ -484,6 +484,7 @@ enum bch_time_stats {
 #include "clock_types.h"
 #include "disk_groups_types.h"
 #include "ec_types.h"
+#include "enumerated_ref_types.h"
 #include "journal_types.h"
 #include "keylist_types.h"
 #include "quota_types.h"
@@ -734,11 +735,7 @@ struct bch_fs {
 	struct rw_semaphore	state_lock;
 
 	/* Counts outstanding writes, for clean transition to read-only */
-#ifdef BCH_WRITE_REF_DEBUG
-	atomic_long_t		writes[BCH_WRITE_REF_NR];
-#else
-	struct percpu_ref	writes;
-#endif
+	struct enumerated_ref	writes;
 	/*
 	 * Certain operations are only allowed in single threaded mode, during
 	 * recovery, and we want to assert that this is the case:
@@ -1123,54 +1120,6 @@ struct bch_fs {
 
 extern struct wait_queue_head bch2_read_only_wait;
 
-static inline void bch2_write_ref_get(struct bch_fs *c, enum bch_write_ref ref)
-{
-#ifdef BCH_WRITE_REF_DEBUG
-	atomic_long_inc(&c->writes[ref]);
-#else
-	percpu_ref_get(&c->writes);
-#endif
-}
-
-static inline bool __bch2_write_ref_tryget(struct bch_fs *c, enum bch_write_ref ref)
-{
-#ifdef BCH_WRITE_REF_DEBUG
-	return !test_bit(BCH_FS_going_ro, &c->flags) &&
-		atomic_long_inc_not_zero(&c->writes[ref]);
-#else
-	return percpu_ref_tryget(&c->writes);
-#endif
-}
-
-static inline bool bch2_write_ref_tryget(struct bch_fs *c, enum bch_write_ref ref)
-{
-#ifdef BCH_WRITE_REF_DEBUG
-	return !test_bit(BCH_FS_going_ro, &c->flags) &&
-		atomic_long_inc_not_zero(&c->writes[ref]);
-#else
-	return percpu_ref_tryget_live(&c->writes);
-#endif
-}
-
-static inline void bch2_write_ref_put(struct bch_fs *c, enum bch_write_ref ref)
-{
-#ifdef BCH_WRITE_REF_DEBUG
-	long v = atomic_long_dec_return(&c->writes[ref]);
-
-	BUG_ON(v < 0);
-	if (v)
-		return;
-	for (unsigned i = 0; i < BCH_WRITE_REF_NR; i++)
-		if (atomic_long_read(&c->writes[i]))
-			return;
-
-	set_bit(BCH_FS_write_disable_complete, &c->flags);
-	wake_up(&bch2_read_only_wait);
-#else
-	percpu_ref_put(&c->writes);
-#endif
-}
-
 static inline bool bch2_ro_ref_tryget(struct bch_fs *c)
 {
 	if (test_bit(BCH_FS_stopping, &c->flags))
diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
index 2824a6e87712..9db8f5f8745c 100644
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -22,6 +22,7 @@
 #include "debug.h"
 #include "disk_accounting.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extents.h"
 #include "journal.h"
@@ -1233,14 +1234,14 @@ static void bch2_gc_gens_work(struct work_struct *work)
 {
 	struct bch_fs *c = container_of(work, struct bch_fs, gc_gens_work);
 	bch2_gc_gens(c);
-	bch2_write_ref_put(c, BCH_WRITE_REF_gc_gens);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_gc_gens);
 }
 
 void bch2_gc_gens_async(struct bch_fs *c)
 {
-	if (bch2_write_ref_tryget(c, BCH_WRITE_REF_gc_gens) &&
+	if (enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_gc_gens) &&
 	    !queue_work(c->write_ref_wq, &c->gc_gens_work))
-		bch2_write_ref_put(c, BCH_WRITE_REF_gc_gens);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_gc_gens);
 }
 
 void bch2_fs_btree_gc_init_early(struct bch_fs *c)
diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 134d6eca9852..fb20146d78d5 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -13,6 +13,7 @@
 #include "buckets.h"
 #include "checksum.h"
 #include "debug.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extents.h"
 #include "io_write.h"
@@ -1935,7 +1936,7 @@ static void btree_node_scrub_work(struct work_struct *work)
 	btree_bounce_free(c, c->opts.btree_node_size, scrub->used_mempool, scrub->buf);
 	percpu_ref_put(&scrub->ca->io_ref[READ]);
 	kfree(scrub);
-	bch2_write_ref_put(c, BCH_WRITE_REF_btree_node_scrub);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_node_scrub);
 }
 
 static void btree_node_scrub_endio(struct bio *bio)
@@ -1954,7 +1955,7 @@ int bch2_btree_node_scrub(struct btree_trans *trans,
 
 	struct bch_fs *c = trans->c;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_btree_node_scrub))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_btree_node_scrub))
 		return -BCH_ERR_erofs_no_writes;
 
 	struct extent_ptr_decoded pick;
@@ -2004,7 +2005,7 @@ int bch2_btree_node_scrub(struct btree_trans *trans,
 	btree_bounce_free(c, c->opts.btree_node_size, used_mempool, buf);
 	percpu_ref_put(&ca->io_ref[READ]);
 err:
-	bch2_write_ref_put(c, BCH_WRITE_REF_btree_node_scrub);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_node_scrub);
 	return ret;
 }
 
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index 4297d8b5eddd..cdde769e7da3 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -11,6 +11,7 @@
 #include "btree_write_buffer.h"
 #include "buckets.h"
 #include "disk_accounting.h"
+#include "enumerated_ref.h"
 #include "errcode.h"
 #include "error.h"
 #include "journal.h"
@@ -994,7 +995,7 @@ int __bch2_trans_commit(struct btree_trans *trans, unsigned flags)
 		goto out_reset;
 
 	if (!(flags & BCH_TRANS_COMMIT_no_check_rw) &&
-	    unlikely(!bch2_write_ref_tryget(c, BCH_WRITE_REF_trans))) {
+	    unlikely(!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_trans))) {
 		if (unlikely(!test_bit(BCH_FS_may_go_rw, &c->flags)))
 			ret = do_bch2_trans_commit_to_journal_replay(trans);
 		else
@@ -1060,7 +1061,7 @@ int __bch2_trans_commit(struct btree_trans *trans, unsigned flags)
 	trace_and_count(c, transaction_commit, trans, _RET_IP_);
 out:
 	if (likely(!(flags & BCH_TRANS_COMMIT_no_check_rw)))
-		bch2_write_ref_put(c, BCH_WRITE_REF_trans);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_trans);
 out_reset:
 	if (!ret)
 		bch2_trans_downgrade(trans);
diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index a0ff2dc0aa91..fcca8b01dd62 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -14,6 +14,7 @@
 #include "btree_locking.h"
 #include "buckets.h"
 #include "clock.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extents.h"
 #include "io_write.h"
@@ -2326,7 +2327,7 @@ static void async_btree_node_rewrite_work(struct work_struct *work)
 	closure_wake_up(&c->btree_node_rewrites_wait);
 
 	bch2_bkey_buf_exit(&a->key, c);
-	bch2_write_ref_put(c, BCH_WRITE_REF_node_rewrite);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_node_rewrite);
 	kfree(a);
 }
 
@@ -2348,7 +2349,7 @@ void bch2_btree_node_rewrite_async(struct bch_fs *c, struct btree *b)
 
 	spin_lock(&c->btree_node_rewrites_lock);
 	if (c->curr_recovery_pass > BCH_RECOVERY_PASS_journal_replay &&
-	    bch2_write_ref_tryget(c, BCH_WRITE_REF_node_rewrite)) {
+	    enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_node_rewrite)) {
 		list_add(&a->list, &c->btree_node_rewrites);
 		now = true;
 	} else if (!test_bit(BCH_FS_may_go_rw, &c->flags)) {
@@ -2387,7 +2388,7 @@ void bch2_do_pending_node_rewrites(struct bch_fs *c)
 		if (!a)
 			break;
 
-		bch2_write_ref_get(c, BCH_WRITE_REF_node_rewrite);
+		enumerated_ref_get(&c->writes, BCH_WRITE_REF_node_rewrite);
 		queue_work(c->btree_node_rewrite_worker, &a->work);
 	}
 }
diff --git a/fs/bcachefs/btree_write_buffer.c b/fs/bcachefs/btree_write_buffer.c
index 68ab48af40f0..0094e4342b69 100644
--- a/fs/bcachefs/btree_write_buffer.c
+++ b/fs/bcachefs/btree_write_buffer.c
@@ -7,6 +7,7 @@
 #include "btree_update_interior.h"
 #include "btree_write_buffer.h"
 #include "disk_accounting.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extents.h"
 #include "journal.h"
@@ -629,11 +630,11 @@ int bch2_btree_write_buffer_tryflush(struct btree_trans *trans)
 {
 	struct bch_fs *c = trans->c;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_btree_write_buffer))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_btree_write_buffer))
 		return -BCH_ERR_erofs_no_writes;
 
 	int ret = bch2_btree_write_buffer_flush_nocheck_rw(trans);
-	bch2_write_ref_put(c, BCH_WRITE_REF_btree_write_buffer);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_write_buffer);
 	return ret;
 }
 
@@ -692,7 +693,7 @@ static void bch2_btree_write_buffer_flush_work(struct work_struct *work)
 	} while (!ret && bch2_btree_write_buffer_should_flush(c));
 	mutex_unlock(&wb->flushing.lock);
 
-	bch2_write_ref_put(c, BCH_WRITE_REF_btree_write_buffer);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_write_buffer);
 }
 
 static void wb_accounting_sort(struct btree_write_buffer *wb)
@@ -821,9 +822,9 @@ int bch2_journal_keys_to_write_buffer_end(struct bch_fs *c, struct journal_keys_
 		bch2_journal_pin_drop(&c->journal, &dst->wb->pin);
 
 	if (bch2_btree_write_buffer_should_flush(c) &&
-	    __bch2_write_ref_tryget(c, BCH_WRITE_REF_btree_write_buffer) &&
+	    __enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_btree_write_buffer) &&
 	    !queue_work(system_unbound_wq, &c->btree_write_buffer.flush_work))
-		bch2_write_ref_put(c, BCH_WRITE_REF_btree_write_buffer);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_write_buffer);
 
 	if (dst->wb == &wb->flushing)
 		mutex_unlock(&wb->flushing.lock);
diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
index 42600370ffb0..b4d78c0ca221 100644
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -16,6 +16,7 @@
 #include "disk_accounting.h"
 #include "disk_groups.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "io_read.h"
 #include "io_write.h"
@@ -1017,14 +1018,14 @@ static void ec_stripe_delete_work(struct work_struct *work)
 				BCH_TRANS_COMMIT_no_enospc, ({
 			ec_stripe_delete(trans, lru_k.k->p.offset);
 		})));
-	bch2_write_ref_put(c, BCH_WRITE_REF_stripe_delete);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_stripe_delete);
 }
 
 void bch2_do_stripe_deletes(struct bch_fs *c)
 {
-	if (bch2_write_ref_tryget(c, BCH_WRITE_REF_stripe_delete) &&
+	if (enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_stripe_delete) &&
 	    !queue_work(c->write_ref_wq, &c->ec_stripe_delete_work))
-		bch2_write_ref_put(c, BCH_WRITE_REF_stripe_delete);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_stripe_delete);
 }
 
 /* stripe creation: */
@@ -1418,15 +1419,15 @@ static void ec_stripe_create_work(struct work_struct *work)
 	while ((s = get_pending_stripe(c)))
 		ec_stripe_create(s);
 
-	bch2_write_ref_put(c, BCH_WRITE_REF_stripe_create);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_stripe_create);
 }
 
 void bch2_ec_do_stripe_creates(struct bch_fs *c)
 {
-	bch2_write_ref_get(c, BCH_WRITE_REF_stripe_create);
+	enumerated_ref_get(&c->writes, BCH_WRITE_REF_stripe_create);
 
 	if (!queue_work(system_long_wq, &c->ec_stripe_create_work))
-		bch2_write_ref_put(c, BCH_WRITE_REF_stripe_create);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_stripe_create);
 }
 
 static void ec_stripe_new_set_pending(struct bch_fs *c, struct ec_stripe_head *h)
diff --git a/fs/bcachefs/fs-io-direct.c b/fs/bcachefs/fs-io-direct.c
index 535bc5fcbcc0..1f5154d9676b 100644
--- a/fs/bcachefs/fs-io-direct.c
+++ b/fs/bcachefs/fs-io-direct.c
@@ -3,6 +3,7 @@
 
 #include "bcachefs.h"
 #include "alloc_foreground.h"
+#include "enumerated_ref.h"
 #include "fs.h"
 #include "fs-io.h"
 #include "fs-io-direct.h"
@@ -401,7 +402,7 @@ static __always_inline long bch2_dio_write_done(struct dio_write *dio)
 	ret = dio->op.error ?: ((long) dio->written << 9);
 	bio_put(&dio->op.wbio.bio);
 
-	bch2_write_ref_put(c, BCH_WRITE_REF_dio_write);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_dio_write);
 
 	/* inode->i_dio_count is our ref on inode and thus bch_fs */
 	inode_dio_end(&inode->v);
@@ -606,7 +607,7 @@ ssize_t bch2_direct_write(struct kiocb *req, struct iov_iter *iter)
 	prefetch(&inode->ei_inode);
 	prefetch((void *) &inode->ei_inode + 64);
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_dio_write))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_dio_write))
 		return -EROFS;
 
 	inode_lock(&inode->v);
@@ -675,7 +676,7 @@ ssize_t bch2_direct_write(struct kiocb *req, struct iov_iter *iter)
 	bio_put(bio);
 	inode_dio_end(&inode->v);
 err_put_write_ref:
-	bch2_write_ref_put(c, BCH_WRITE_REF_dio_write);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_dio_write);
 	goto out;
 }
 
diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 409bba396bad..a84b1baf02d8 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -7,6 +7,7 @@
 #include "btree_update.h"
 #include "buckets.h"
 #include "clock.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extents.h"
 #include "extent_update.h"
@@ -205,7 +206,7 @@ static int bch2_flush_inode(struct bch_fs *c,
 	if (c->opts.journal_flush_disabled)
 		return 0;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_fsync))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_fsync))
 		return -EROFS;
 
 	u64 seq;
@@ -213,7 +214,7 @@ static int bch2_flush_inode(struct bch_fs *c,
 			bch2_get_inode_journal_seq_trans(trans, inode_inum(inode), &seq)) ?:
 		  bch2_journal_flush_seq(&c->journal, seq, TASK_INTERRUPTIBLE) ?:
 		  bch2_inode_flush_nocow_writes(c, inode);
-	bch2_write_ref_put(c, BCH_WRITE_REF_fsync);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_fsync);
 	return ret;
 }
 
@@ -796,7 +797,7 @@ long bch2_fallocate_dispatch(struct file *file, int mode,
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	long ret;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_fallocate))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_fallocate))
 		return -EROFS;
 
 	inode_lock(&inode->v);
@@ -820,7 +821,7 @@ long bch2_fallocate_dispatch(struct file *file, int mode,
 err:
 	bch2_pagecache_block_put(inode);
 	inode_unlock(&inode->v);
-	bch2_write_ref_put(c, BCH_WRITE_REF_fallocate);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_fallocate);
 
 	return bch2_err_class(ret);
 }
diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
index 36108b1fcd44..680f4eeea52a 100644
--- a/fs/bcachefs/io_read.c
+++ b/fs/bcachefs/io_read.c
@@ -17,6 +17,7 @@
 #include "data_update.h"
 #include "disk_groups.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "io_read.h"
 #include "io_misc.h"
@@ -162,7 +163,7 @@ static noinline void promote_free(struct bch_read_bio *rbio)
 
 	bch2_data_update_exit(&op->write);
 
-	bch2_write_ref_put(c, BCH_WRITE_REF_promote);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_promote);
 	kfree_rcu(op, rcu);
 }
 
@@ -227,7 +228,7 @@ static struct bch_read_bio *__promote_alloc(struct btree_trans *trans,
 			return NULL;
 	}
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_promote))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_promote))
 		return ERR_PTR(-BCH_ERR_nopromote_no_writes);
 
 	struct promote_op *op = kzalloc(sizeof(*op), GFP_KERNEL);
@@ -278,7 +279,7 @@ static struct bch_read_bio *__promote_alloc(struct btree_trans *trans,
 	/* We may have added to the rhashtable and thus need rcu freeing: */
 	kfree_rcu(op, rcu);
 err_put:
-	bch2_write_ref_put(c, BCH_WRITE_REF_promote);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_promote);
 	return ERR_PTR(ret);
 }
 
diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
index 4dabff3ac1be..755169c4e0e0 100644
--- a/fs/bcachefs/io_write.c
+++ b/fs/bcachefs/io_write.c
@@ -15,6 +15,7 @@
 #include "compress.h"
 #include "debug.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extent_update.h"
 #include "inode.h"
@@ -512,7 +513,7 @@ static void bch2_write_done(struct closure *cl)
 	bch2_disk_reservation_put(c, &op->res);
 
 	if (!(op->flags & BCH_WRITE_move))
-		bch2_write_ref_put(c, BCH_WRITE_REF_write);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_write);
 	bch2_keylist_free(&op->insert_keys, op->inline_keys);
 
 	EBUG_ON(cl->parent);
@@ -1660,7 +1661,7 @@ CLOSURE_CALLBACK(bch2_write)
 	}
 
 	if (!(op->flags & BCH_WRITE_move) &&
-	    !bch2_write_ref_tryget(c, BCH_WRITE_REF_write)) {
+	    !enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_write)) {
 		op->error = -BCH_ERR_erofs_no_writes;
 		goto err;
 	}
diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index e1cd6e8e37cf..e2c95192a577 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -12,6 +12,7 @@
 #include "btree_update.h"
 #include "btree_write_buffer.h"
 #include "buckets.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "journal.h"
 #include "journal_io.h"
@@ -989,11 +990,11 @@ int bch2_journal_meta(struct journal *j)
 {
 	struct bch_fs *c = container_of(j, struct bch_fs, journal);
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_journal))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_journal))
 		return -BCH_ERR_erofs_no_writes;
 
 	int ret = __bch2_journal_meta(j);
-	bch2_write_ref_put(c, BCH_WRITE_REF_journal);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_journal);
 	return ret;
 }
 
diff --git a/fs/bcachefs/reflink.c b/fs/bcachefs/reflink.c
index 710178e3da4c..3a13dbcab6ba 100644
--- a/fs/bcachefs/reflink.c
+++ b/fs/bcachefs/reflink.c
@@ -3,6 +3,7 @@
 #include "bkey_buf.h"
 #include "btree_update.h"
 #include "buckets.h"
+#include "enumerated_ref.h"
 #include "error.h"
 #include "extents.h"
 #include "inode.h"
@@ -610,7 +611,7 @@ s64 bch2_remap_range(struct bch_fs *c,
 		!bch2_request_incompat_feature(c, bcachefs_metadata_version_reflink_p_may_update_opts);
 	int ret = 0, ret2 = 0;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_reflink))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_reflink))
 		return -BCH_ERR_erofs_no_writes;
 
 	bch2_check_set_feature(c, BCH_FEATURE_reflink);
@@ -761,7 +762,7 @@ s64 bch2_remap_range(struct bch_fs *c,
 	bch2_bkey_buf_exit(&new_src, c);
 	bch2_bkey_buf_exit(&new_dst, c);
 
-	bch2_write_ref_put(c, BCH_WRITE_REF_reflink);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_reflink);
 
 	return dst_done ?: ret ?: ret2;
 }
diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index 2eede851572c..14ea09ccee37 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -6,6 +6,7 @@
 #include "btree_key_cache.h"
 #include "btree_update.h"
 #include "buckets.h"
+#include "enumerated_ref.h"
 #include "errcode.h"
 #include "error.h"
 #include "fs.h"
@@ -1661,18 +1662,18 @@ void bch2_delete_dead_snapshots_work(struct work_struct *work)
 	set_worker_desc("bcachefs-delete-dead-snapshots/%s", c->name);
 
 	bch2_delete_dead_snapshots(c);
-	bch2_write_ref_put(c, BCH_WRITE_REF_delete_dead_snapshots);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_delete_dead_snapshots);
 }
 
 void bch2_delete_dead_snapshots_async(struct bch_fs *c)
 {
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_delete_dead_snapshots))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_delete_dead_snapshots))
 		return;
 
 	BUG_ON(!test_bit(BCH_FS_may_go_rw, &c->flags));
 
 	if (!queue_work(c->write_ref_wq, &c->snapshot_delete_work))
-		bch2_write_ref_put(c, BCH_WRITE_REF_delete_dead_snapshots);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_delete_dead_snapshots);
 }
 
 int __bch2_key_has_snapshot_overwrites(struct btree_trans *trans,
diff --git a/fs/bcachefs/subvolume.c b/fs/bcachefs/subvolume.c
index 1b9fb60c05be..39376c87b4a6 100644
--- a/fs/bcachefs/subvolume.c
+++ b/fs/bcachefs/subvolume.c
@@ -3,6 +3,7 @@
 #include "bcachefs.h"
 #include "btree_key_cache.h"
 #include "btree_update.h"
+#include "enumerated_ref.h"
 #include "errcode.h"
 #include "error.h"
 #include "fs.h"
@@ -517,7 +518,7 @@ static void bch2_subvolume_wait_for_pagecache_and_delete(struct work_struct *wor
 		darray_exit(&s);
 	}
 
-	bch2_write_ref_put(c, BCH_WRITE_REF_snapshot_delete_pagecache);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_snapshot_delete_pagecache);
 }
 
 struct subvolume_unlink_hook {
@@ -540,11 +541,11 @@ static int bch2_subvolume_wait_for_pagecache_and_delete_hook(struct btree_trans
 	if (ret)
 		return ret;
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_snapshot_delete_pagecache))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_snapshot_delete_pagecache))
 		return -EROFS;
 
 	if (!queue_work(c->write_ref_wq, &c->snapshot_wait_for_pagecache_and_delete_work))
-		bch2_write_ref_put(c, BCH_WRITE_REF_snapshot_delete_pagecache);
+		enumerated_ref_put(&c->writes, BCH_WRITE_REF_snapshot_delete_pagecache);
 	return 0;
 }
 
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 78f683c6b490..288e00779fff 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -28,6 +28,7 @@
 #include "disk_accounting.h"
 #include "disk_groups.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "errcode.h"
 #include "error.h"
 #include "fs.h"
@@ -311,15 +312,13 @@ static void __bch2_fs_read_only(struct bch_fs *c)
 	}
 }
 
-#ifndef BCH_WRITE_REF_DEBUG
-static void bch2_writes_disabled(struct percpu_ref *writes)
+static void bch2_writes_disabled(struct enumerated_ref *writes)
 {
 	struct bch_fs *c = container_of(writes, struct bch_fs, writes);
 
 	set_bit(BCH_FS_write_disable_complete, &c->flags);
 	wake_up(&bch2_read_only_wait);
 }
-#endif
 
 void bch2_fs_read_only(struct bch_fs *c)
 {
@@ -337,12 +336,7 @@ void bch2_fs_read_only(struct bch_fs *c)
 	 * writes will return -EROFS:
 	 */
 	set_bit(BCH_FS_going_ro, &c->flags);
-#ifndef BCH_WRITE_REF_DEBUG
-	percpu_ref_kill(&c->writes);
-#else
-	for (unsigned i = 0; i < BCH_WRITE_REF_NR; i++)
-		bch2_write_ref_put(c, i);
-#endif
+	enumerated_ref_stop_async(&c->writes);
 
 	/*
 	 * If we're not doing an emergency shutdown, we want to wait on
@@ -525,14 +519,8 @@ static int __bch2_fs_read_write(struct bch_fs *c, bool early)
 	set_bit(BCH_FS_rw, &c->flags);
 	set_bit(BCH_FS_was_rw, &c->flags);
 
-#ifndef BCH_WRITE_REF_DEBUG
-	percpu_ref_reinit(&c->writes);
-#else
-	for (unsigned i = 0; i < BCH_WRITE_REF_NR; i++) {
-		BUG_ON(atomic_long_read(&c->writes[i]));
-		atomic_long_inc(&c->writes[i]);
-	}
-#endif
+	enumerated_ref_start(&c->writes);
+
 	if (!early) {
 		ret = bch2_fs_read_write_late(c);
 		if (ret)
@@ -629,9 +617,7 @@ static void __bch2_fs_free(struct bch_fs *c)
 	mempool_exit(&c->btree_bounce_pool);
 	bioset_exit(&c->btree_bio);
 	mempool_exit(&c->fill_iter);
-#ifndef BCH_WRITE_REF_DEBUG
-	percpu_ref_exit(&c->writes);
-#endif
+	enumerated_ref_exit(&c->writes);
 	kfree(rcu_dereference_protected(c->disk_groups, 1));
 	kfree(c->journal_seq_blacklist_table);
 
@@ -978,10 +964,8 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts,
 
 	if (!(c->btree_read_complete_wq = alloc_workqueue("bcachefs_btree_read_complete",
 				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 512)) ||
-#ifndef BCH_WRITE_REF_DEBUG
-	    percpu_ref_init(&c->writes, bch2_writes_disabled,
-			    PERCPU_REF_INIT_DEAD, GFP_KERNEL) ||
-#endif
+	    enumerated_ref_init(&c->writes, BCH_WRITE_REF_NR,
+				bch2_writes_disabled) ||
 	    mempool_init_kmalloc_pool(&c->fill_iter, 1, iter_size) ||
 	    bioset_init(&c->btree_bio, 1,
 			max(offsetof(struct btree_read_bio, bio),
diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index 455c6ae9a494..58be32bbd49c 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -25,6 +25,7 @@
 #include "disk_accounting.h"
 #include "disk_groups.h"
 #include "ec.h"
+#include "enumerated_ref.h"
 #include "inode.h"
 #include "journal.h"
 #include "journal_reclaim.h"
@@ -177,8 +178,6 @@ read_attribute(btree_reserve_cache);
 read_attribute(open_buckets);
 read_attribute(open_buckets_partial);
 read_attribute(nocow_lock_table);
-
-#ifdef BCH_WRITE_REF_DEBUG
 read_attribute(write_refs);
 
 static const char * const bch2_write_refs[] = {
@@ -188,15 +187,6 @@ static const char * const bch2_write_refs[] = {
 	NULL
 };
 
-static void bch2_write_refs_to_text(struct printbuf *out, struct bch_fs *c)
-{
-	bch2_printbuf_tabstop_push(out, 24);
-
-	for (unsigned i = 0; i < ARRAY_SIZE(c->writes); i++)
-		prt_printf(out, "%s\t%li\n", bch2_write_refs[i], atomic_long_read(&c->writes[i]));
-}
-#endif
-
 read_attribute(internal_uuid);
 read_attribute(disk_groups);
 
@@ -481,10 +471,8 @@ SHOW(bch2_fs)
 	if (attr == &sysfs_moving_ctxts)
 		bch2_fs_moving_ctxts_to_text(out, c);
 
-#ifdef BCH_WRITE_REF_DEBUG
 	if (attr == &sysfs_write_refs)
-		bch2_write_refs_to_text(out, c);
-#endif
+		enumerated_ref_to_text(out, &c->writes, bch2_write_refs);
 
 	if (attr == &sysfs_nocow_lock_table)
 		bch2_nocow_locks_to_text(out, &c->nocow_locks);
@@ -517,7 +505,7 @@ STORE(bch2_fs)
 	if (attr == &sysfs_trigger_btree_updates)
 		queue_work(c->btree_interior_update_worker, &c->btree_interior_update_work);
 
-	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_sysfs))
+	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_sysfs))
 		return -EROFS;
 
 	if (attr == &sysfs_trigger_btree_cache_shrink) {
@@ -577,7 +565,7 @@ STORE(bch2_fs)
 			size = ret;
 	}
 #endif
-	bch2_write_ref_put(c, BCH_WRITE_REF_sysfs);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_sysfs);
 	return size;
 }
 SYSFS_OPS(bch2_fs);
@@ -670,9 +658,7 @@ struct attribute *bch2_fs_internal_files[] = {
 	&sysfs_new_stripes,
 	&sysfs_open_buckets,
 	&sysfs_open_buckets_partial,
-#ifdef BCH_WRITE_REF_DEBUG
 	&sysfs_write_refs,
-#endif
 	&sysfs_nocow_lock_table,
 	&sysfs_io_timers_read,
 	&sysfs_io_timers_write,
@@ -738,7 +724,7 @@ static ssize_t sysfs_opt_store(struct bch_fs *c,
 	 * We don't need to take c->writes for correctness, but it eliminates an
 	 * unsightly error message in the dmesg log when we're RO:
 	 */
-	if (unlikely(!bch2_write_ref_tryget(c, BCH_WRITE_REF_sysfs)))
+	if (unlikely(!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_sysfs)))
 		return -EROFS;
 
 	char *tmp = kstrdup(buf, GFP_KERNEL);
@@ -765,7 +751,7 @@ static ssize_t sysfs_opt_store(struct bch_fs *c,
 
 	ret = size;
 err:
-	bch2_write_ref_put(c, BCH_WRITE_REF_sysfs);
+	enumerated_ref_put(&c->writes, BCH_WRITE_REF_sysfs);
 	return ret;
 }
 
-- 
2.49.0


