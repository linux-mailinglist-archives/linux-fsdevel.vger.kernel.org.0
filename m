Return-Path: <linux-fsdevel+bounces-46738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6ABA9483D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A5F3B1700
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A820B80F;
	Sun, 20 Apr 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mhminj2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF320B81B;
	Sun, 20 Apr 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745164772; cv=none; b=fE/ogaId/XRMOBT52OPAyIO+mM3LS82xsYeRqNDURxmSX7PsfMi023KPikfwvOxjdU/ygo0x8qa1sq3cYei4FqNmyMogu3bfxMkMKN4+5sH0WcGQDCgRzfMwWhWxds1F8QBHTxgs+D+zMOZmpV5JA2buKRzq6Lqf6OtD5x9g838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745164772; c=relaxed/simple;
	bh=luRxqSNkqDg7iiDhDaiRBlyF0UiesDjcFQl3Q4GUtiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3NylDfuOgXJANeAreoElWXCakrqS0Dw6aRIaxfNWOUL5kX08dI9ooLYnOKjDFxCpAv3wsD8MI7ZXTZXKuIPocbR3Azusb+HSxO4UZ5chihSiOeYkQOFWmleUULrA81+daqIKOX8CYqLztfcsgdbqDcrLxjRY8FlVxXq/M0L+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mhminj2I; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745164767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx9DRbM3zBHy5tm6FaIz7q1iDeYYK2z5AiDAN6M/468=;
	b=mhminj2IX81+OoXJiFWln4aaJoxS8WR/1wlgn9QixwR/OEQWhZSMCHlPEP3DZWcIA1OOf7
	ksbcemC9NJhICNS7VkZgIDdP7ciCPNB7LR1C21aeDNVRB54mteEWf2zsmAj3xocCFGkgNV
	mGL7C32wzHjmc4VjWywpWMX/f0IlgpE=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 3/3] bcachefs: bch_dev.io_ref -> enumerated_ref
Date: Sun, 20 Apr 2025 11:59:16 -0400
Message-ID: <20250420155918.749455-4-kent.overstreet@linux.dev>
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

Convert device IO refs to enumerated_refs, for easier debugging of
refcount issues.

Simple conversion: enumerate all users and convert to the new helpers.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/alloc_background.c | 18 +++----
 fs/bcachefs/backpointers.c     |  6 ++-
 fs/bcachefs/bcachefs.h         | 48 +++++++++++++++++-
 fs/bcachefs/btree_io.c         | 22 ++++----
 fs/bcachefs/btree_node_scan.c  | 10 ++--
 fs/bcachefs/buckets.c          |  4 +-
 fs/bcachefs/debug.c            | 12 +++--
 fs/bcachefs/ec.c               | 19 ++++---
 fs/bcachefs/enumerated_ref.h   | 12 +++++
 fs/bcachefs/fs-io.c            |  6 ++-
 fs/bcachefs/io_read.c          | 10 ++--
 fs/bcachefs/io_write.c         | 15 ++++--
 fs/bcachefs/journal.c          |  5 +-
 fs/bcachefs/journal_io.c       | 15 +++---
 fs/bcachefs/journal_reclaim.c  |  2 +-
 fs/bcachefs/sb-members.h       | 32 ++++++------
 fs/bcachefs/super-io.c         | 18 +++----
 fs/bcachefs/super.c            | 93 ++++++++++++++++++----------------
 fs/bcachefs/super.h            |  3 ++
 fs/bcachefs/sysfs.c            | 22 ++++----
 20 files changed, 236 insertions(+), 136 deletions(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index c7e50b1835ed..37cbbf86fe3c 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -1953,7 +1953,7 @@ static void bch2_do_discards_work(struct work_struct *work)
 	trace_discard_buckets(c, s.seen, s.open, s.need_journal_commit, s.discarded,
 			      bch2_err_str(ret));
 
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_dev_do_discards);
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard);
 }
 
@@ -1964,13 +1964,13 @@ void bch2_dev_do_discards(struct bch_dev *ca)
 	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_discard))
 		return;
 
-	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE))
+	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE, BCH_DEV_WRITE_REF_dev_do_discards))
 		goto put_write_ref;
 
 	if (queue_work(c->write_ref_wq, &ca->discard_work))
 		return;
 
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_dev_do_discards);
 put_write_ref:
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard);
 }
@@ -2048,7 +2048,7 @@ static void bch2_do_discards_fast_work(struct work_struct *work)
 	trace_discard_buckets_fast(c, s.seen, s.open, s.need_journal_commit, s.discarded, bch2_err_str(ret));
 
 	bch2_trans_put(trans);
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_discard_one_bucket_fast);
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard_fast);
 }
 
@@ -2062,13 +2062,13 @@ static void bch2_discard_one_bucket_fast(struct bch_dev *ca, u64 bucket)
 	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_discard_fast))
 		return;
 
-	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE))
+	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE, BCH_DEV_WRITE_REF_discard_one_bucket_fast))
 		goto put_ref;
 
 	if (queue_work(c->write_ref_wq, &ca->discard_fast_work))
 		return;
 
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_discard_one_bucket_fast);
 put_ref:
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_discard_fast);
 }
@@ -2262,8 +2262,8 @@ static void bch2_do_invalidates_work(struct work_struct *work)
 	bch2_trans_iter_exit(trans, &iter);
 err:
 	bch2_trans_put(trans);
-	percpu_ref_put(&ca->io_ref[WRITE]);
 	bch2_bkey_buf_exit(&last_flushed, c);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_do_invalidates);
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_invalidate);
 }
 
@@ -2274,13 +2274,13 @@ void bch2_dev_do_invalidates(struct bch_dev *ca)
 	if (!enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_invalidate))
 		return;
 
-	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE))
+	if (!bch2_dev_get_ioref(c, ca->dev_idx, WRITE, BCH_DEV_WRITE_REF_do_invalidates))
 		goto put_ref;
 
 	if (queue_work(c->write_ref_wq, &ca->invalidate_work))
 		return;
 
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_do_invalidates);
 put_ref:
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_invalidate);
 }
diff --git a/fs/bcachefs/backpointers.c b/fs/bcachefs/backpointers.c
index ff26bb515150..b870eedf4fd7 100644
--- a/fs/bcachefs/backpointers.c
+++ b/fs/bcachefs/backpointers.c
@@ -437,7 +437,8 @@ static int check_extent_checksum(struct btree_trans *trans,
 
 	bytes = p.crc.compressed_size << 9;
 
-	struct bch_dev *ca = bch2_dev_get_ioref(c, dev, READ);
+	struct bch_dev *ca = bch2_dev_get_ioref(c, dev, READ,
+				BCH_DEV_READ_REF_check_extent_checksums);
 	if (!ca)
 		return false;
 
@@ -474,7 +475,8 @@ static int check_extent_checksum(struct btree_trans *trans,
 	if (bio)
 		bio_put(bio);
 	kvfree(data_buf);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ],
+			   BCH_DEV_READ_REF_check_extent_checksums);
 	printbuf_exit(&buf);
 	return ret;
 }
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index d00c320fe973..3ed5ec5949b2 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -517,6 +517,51 @@ struct discard_in_flight {
 	u64			bucket:63;
 };
 
+#define BCH_DEV_READ_REFS()				\
+	x(bch2_online_devs)				\
+	x(trans_mark_dev_sbs)				\
+	x(read_fua_test)				\
+	x(sb_field_resize)				\
+	x(write_super)					\
+	x(journal_read)					\
+	x(fs_journal_alloc)				\
+	x(fs_resize_on_mount)				\
+	x(btree_node_read)				\
+	x(btree_node_read_all_replicas)			\
+	x(btree_node_scrub)				\
+	x(btree_node_write)				\
+	x(btree_node_scan)				\
+	x(btree_verify_replicas)			\
+	x(btree_node_ondisk_to_text)			\
+	x(io_read)					\
+	x(check_extent_checksums)			\
+	x(ec_block)
+
+enum bch_dev_read_ref {
+#define x(n) BCH_DEV_READ_REF_##n,
+	BCH_DEV_READ_REFS()
+#undef x
+	BCH_DEV_READ_REF_NR,
+};
+
+#define BCH_DEV_WRITE_REFS()				\
+	x(journal_write)				\
+	x(journal_do_discards)				\
+	x(dev_do_discards)				\
+	x(discard_one_bucket_fast)			\
+	x(do_invalidates)				\
+	x(nocow_flush)					\
+	x(io_write)					\
+	x(ec_block)					\
+	x(ec_bucket_zero)
+
+enum bch_dev_write_ref {
+#define x(n) BCH_DEV_WRITE_REF_##n,
+	BCH_DEV_WRITE_REFS()
+#undef x
+	BCH_DEV_WRITE_REF_NR,
+};
+
 struct bch_dev {
 	struct kobject		kobj;
 #ifdef CONFIG_BCACHEFS_DEBUG
@@ -527,8 +572,7 @@ struct bch_dev {
 	struct percpu_ref	ref;
 #endif
 	struct completion	ref_completion;
-	struct percpu_ref	io_ref[2];
-	struct completion	io_ref_completion[2];
+	struct enumerated_ref	io_ref[2];
 
 	struct bch_fs		*fs;
 
diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index fb20146d78d5..065fad831aae 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -1325,7 +1325,7 @@ static void btree_node_read_work(struct work_struct *work)
 	while (1) {
 		retry = true;
 		bch_info(c, "retrying read");
-		ca = bch2_dev_get_ioref(c, rb->pick.ptr.dev, READ);
+		ca = bch2_dev_get_ioref(c, rb->pick.ptr.dev, READ, BCH_DEV_READ_REF_btree_node_read);
 		rb->have_ioref		= ca != NULL;
 		rb->start_time		= local_clock();
 		bio_reset(bio, NULL, REQ_OP_READ|REQ_SYNC|REQ_META);
@@ -1350,7 +1350,7 @@ static void btree_node_read_work(struct work_struct *work)
 					"btree read error %s for %s",
 					bch2_blk_status_to_str(bio->bi_status), buf.buf);
 		if (rb->have_ioref)
-			percpu_ref_put(&ca->io_ref[READ]);
+			enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_read);
 		rb->have_ioref = false;
 
 		bch2_mark_io_failure(&failed, &rb->pick, false);
@@ -1612,7 +1612,8 @@ static void btree_node_read_all_replicas_endio(struct bio *bio)
 		struct bch_dev *ca = bch2_dev_have_ref(c, rb->pick.ptr.dev);
 
 		bch2_latency_acct(ca, rb->start_time, READ);
-		percpu_ref_put(&ca->io_ref[READ]);
+		enumerated_ref_put(&ca->io_ref[READ],
+			BCH_DEV_READ_REF_btree_node_read_all_replicas);
 	}
 
 	ra->err[rb->idx] = bio->bi_status;
@@ -1652,7 +1653,8 @@ static int btree_node_read_all_replicas(struct bch_fs *c, struct btree *b, bool
 
 	i = 0;
 	bkey_for_each_ptr_decode(k.k, ptrs, pick, entry) {
-		struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ);
+		struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ,
+					BCH_DEV_READ_REF_btree_node_read_all_replicas);
 		struct btree_read_bio *rb =
 			container_of(ra->bio[i], struct btree_read_bio, bio);
 		rb->c			= c;
@@ -1729,7 +1731,7 @@ void bch2_btree_node_read(struct btree_trans *trans, struct btree *b,
 		return;
 	}
 
-	ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ);
+	ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ, BCH_DEV_READ_REF_btree_node_read);
 
 	bio = bio_alloc_bioset(NULL,
 			       buf_pages(b->data, btree_buf_bytes(b)),
@@ -1934,7 +1936,7 @@ static void btree_node_scrub_work(struct work_struct *work)
 	printbuf_exit(&err);
 	bch2_bkey_buf_exit(&scrub->key, c);;
 	btree_bounce_free(c, c->opts.btree_node_size, scrub->used_mempool, scrub->buf);
-	percpu_ref_put(&scrub->ca->io_ref[READ]);
+	enumerated_ref_put(&scrub->ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scrub);
 	kfree(scrub);
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_node_scrub);
 }
@@ -1963,7 +1965,8 @@ int bch2_btree_node_scrub(struct btree_trans *trans,
 	if (ret <= 0)
 		goto err;
 
-	struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ);
+	struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ,
+						BCH_DEV_READ_REF_btree_node_scrub);
 	if (!ca) {
 		ret = -BCH_ERR_device_offline;
 		goto err;
@@ -2003,7 +2006,7 @@ int bch2_btree_node_scrub(struct btree_trans *trans,
 	return 0;
 err_free:
 	btree_bounce_free(c, c->opts.btree_node_size, used_mempool, buf);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scrub);
 err:
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_node_scrub);
 	return ret;
@@ -2172,7 +2175,8 @@ static void btree_node_write_endio(struct bio *bio)
 	 * btree writes yet (due to device removal/ro):
 	 */
 	if (wbio->have_ioref)
-		percpu_ref_put(&ca->io_ref[READ]);
+		enumerated_ref_put(&ca->io_ref[READ],
+				   BCH_DEV_READ_REF_btree_node_write);
 
 	if (parent) {
 		bio_put(bio);
diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index 81ee7ae88a77..7bd13438d5ef 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -271,7 +271,7 @@ static int read_btree_nodes_worker(void *p)
 err:
 	bio_put(bio);
 	free_page((unsigned long) buf);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scan);
 	closure_put(w->cl);
 	kfree(w);
 	return 0;
@@ -285,13 +285,13 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 
 	closure_init_stack(&cl);
 
-	for_each_online_member(c, ca) {
+	for_each_online_member(c, ca, BCH_DEV_READ_REF_btree_node_scan) {
 		if (!(ca->mi.data_allowed & BIT(BCH_DATA_btree)))
 			continue;
 
 		struct find_btree_nodes_worker *w = kmalloc(sizeof(*w), GFP_KERNEL);
 		if (!w) {
-			percpu_ref_put(&ca->io_ref[READ]);
+			enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scan);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -303,14 +303,14 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 		struct task_struct *t = kthread_create(read_btree_nodes_worker, w, "read_btree_nodes/%s", ca->name);
 		ret = PTR_ERR_OR_ZERO(t);
 		if (ret) {
-			percpu_ref_put(&ca->io_ref[READ]);
+			enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scan);
 			kfree(w);
 			bch_err_msg(c, ret, "starting kthread");
 			break;
 		}
 
 		closure_get(&cl);
-		percpu_ref_get(&ca->io_ref[READ]);
+		enumerated_ref_get(&ca->io_ref[READ], BCH_DEV_READ_REF_btree_node_scan);
 		wake_up_process(t);
 	}
 err:
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 09e84d4a76b5..7c267244966b 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -1139,10 +1139,10 @@ int bch2_trans_mark_dev_sb(struct bch_fs *c, struct bch_dev *ca,
 int bch2_trans_mark_dev_sbs_flags(struct bch_fs *c,
 			enum btree_iter_update_trigger_flags flags)
 {
-	for_each_online_member(c, ca) {
+	for_each_online_member(c, ca, BCH_DEV_READ_REF_trans_mark_dev_sbs) {
 		int ret = bch2_trans_mark_dev_sb(c, ca, flags);
 		if (ret) {
-			percpu_ref_put(&ca->io_ref[READ]);
+			enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_trans_mark_dev_sbs);
 			return ret;
 		}
 	}
diff --git a/fs/bcachefs/debug.c b/fs/bcachefs/debug.c
index 71d05ee7e6e3..18314329d84d 100644
--- a/fs/bcachefs/debug.c
+++ b/fs/bcachefs/debug.c
@@ -43,7 +43,8 @@ static bool bch2_btree_verify_replica(struct bch_fs *c, struct btree *b,
 	struct bio *bio;
 	bool failed = false, saw_error = false;
 
-	struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ);
+	struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ,
+				BCH_DEV_READ_REF_btree_verify_replicas);
 	if (!ca)
 		return false;
 
@@ -58,7 +59,8 @@ static bool bch2_btree_verify_replica(struct bch_fs *c, struct btree *b,
 	submit_bio_wait(bio);
 
 	bio_put(bio);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ],
+			   BCH_DEV_READ_REF_btree_verify_replicas);
 
 	memcpy(n_ondisk, n_sorted, btree_buf_bytes(b));
 
@@ -197,7 +199,8 @@ void bch2_btree_node_ondisk_to_text(struct printbuf *out, struct bch_fs *c,
 		return;
 	}
 
-	ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ);
+	ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ,
+			BCH_DEV_READ_REF_btree_node_ondisk_to_text);
 	if (!ca) {
 		prt_printf(out, "error getting device to read from: not online\n");
 		return;
@@ -298,7 +301,8 @@ void bch2_btree_node_ondisk_to_text(struct printbuf *out, struct bch_fs *c,
 	if (bio)
 		bio_put(bio);
 	kvfree(n_ondisk);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ],
+			   BCH_DEV_READ_REF_btree_node_ondisk_to_text);
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
index b4d78c0ca221..1dde0a036f5e 100644
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -707,6 +707,9 @@ static void ec_block_endio(struct bio *bio)
 	struct bch_dev *ca = ec_bio->ca;
 	struct closure *cl = bio->bi_private;
 	int rw = ec_bio->rw;
+	unsigned ref = rw == READ
+		? BCH_DEV_READ_REF_ec_block
+		: BCH_DEV_WRITE_REF_ec_block;
 
 	bch2_account_io_completion(ca, bio_data_dir(bio),
 				   ec_bio->submit_time, !bio->bi_status);
@@ -728,7 +731,7 @@ static void ec_block_endio(struct bio *bio)
 	}
 
 	bio_put(&ec_bio->bio);
-	percpu_ref_put(&ca->io_ref[rw]);
+	enumerated_ref_put(&ca->io_ref[rw], ref);
 	closure_put(cl);
 }
 
@@ -742,8 +745,11 @@ static void ec_block_io(struct bch_fs *c, struct ec_stripe_buf *buf,
 		? BCH_DATA_user
 		: BCH_DATA_parity;
 	int rw = op_is_write(opf);
+	unsigned ref = rw == READ
+		? BCH_DEV_READ_REF_ec_block
+		: BCH_DEV_WRITE_REF_ec_block;
 
-	struct bch_dev *ca = bch2_dev_get_ioref(c, ptr->dev, rw);
+	struct bch_dev *ca = bch2_dev_get_ioref(c, ptr->dev, rw, ref);
 	if (!ca) {
 		clear_bit(idx, buf->valid);
 		return;
@@ -789,14 +795,14 @@ static void ec_block_io(struct bch_fs *c, struct ec_stripe_buf *buf,
 		bch2_bio_map(&ec_bio->bio, buf->data[idx] + offset, b);
 
 		closure_get(cl);
-		percpu_ref_get(&ca->io_ref[rw]);
+		enumerated_ref_get(&ca->io_ref[rw], ref);
 
 		submit_bio(&ec_bio->bio);
 
 		offset += b;
 	}
 
-	percpu_ref_put(&ca->io_ref[rw]);
+	enumerated_ref_put(&ca->io_ref[rw], ref);
 }
 
 static int get_stripe_key_trans(struct btree_trans *trans, u64 idx,
@@ -1253,7 +1259,8 @@ static void zero_out_rest_of_ec_bucket(struct bch_fs *c,
 				       unsigned block,
 				       struct open_bucket *ob)
 {
-	struct bch_dev *ca = bch2_dev_get_ioref(c, ob->dev, WRITE);
+	struct bch_dev *ca = bch2_dev_get_ioref(c, ob->dev, WRITE,
+				BCH_DEV_WRITE_REF_ec_bucket_zero);
 	if (!ca) {
 		s->err = -BCH_ERR_erofs_no_writes;
 		return;
@@ -1269,7 +1276,7 @@ static void zero_out_rest_of_ec_bucket(struct bch_fs *c,
 			ob->sectors_free,
 			GFP_KERNEL, 0);
 
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_ec_bucket_zero);
 
 	if (ret)
 		s->err = ret;
diff --git a/fs/bcachefs/enumerated_ref.h b/fs/bcachefs/enumerated_ref.h
index 6d2283cf298d..d2d19da26cd5 100644
--- a/fs/bcachefs/enumerated_ref.h
+++ b/fs/bcachefs/enumerated_ref.h
@@ -38,6 +38,18 @@ static inline void enumerated_ref_put(struct enumerated_ref *ref, unsigned idx)
 }
 #endif
 
+static inline bool enumerated_ref_is_zero(struct enumerated_ref *ref)
+{
+#ifndef BCH_REFCOUNT_DEBUG
+	return percpu_ref_is_zero(&ref->ref);
+#else
+	for (unsigned i = 0; i < ref->nr; i++)
+		if (atomic_long_read(&ref->refs[i]))
+			return false;
+	return true;
+#endif
+}
+
 void enumerated_ref_stop_async(struct enumerated_ref *);
 void enumerated_ref_stop(struct enumerated_ref *, const char * const[]);
 void enumerated_ref_start(struct enumerated_ref *);
diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index a84b1baf02d8..801e9cd61a40 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -49,7 +49,8 @@ static void nocow_flush_endio(struct bio *_bio)
 	struct nocow_flush *bio = container_of(_bio, struct nocow_flush, bio);
 
 	closure_put(bio->cl);
-	percpu_ref_put(&bio->ca->io_ref[WRITE]);
+	enumerated_ref_put(&bio->ca->io_ref[WRITE],
+			   BCH_DEV_WRITE_REF_nocow_flush);
 	bio_put(&bio->bio);
 }
 
@@ -72,7 +73,8 @@ void bch2_inode_flush_nocow_writes_async(struct bch_fs *c,
 	for_each_set_bit(dev, devs.d, BCH_SB_MEMBERS_MAX) {
 		rcu_read_lock();
 		ca = rcu_dereference(c->devs[dev]);
-		if (ca && !percpu_ref_tryget(&ca->io_ref[WRITE]))
+		if (ca && !enumerated_ref_tryget(&ca->io_ref[WRITE],
+					BCH_DEV_WRITE_REF_nocow_flush))
 			ca = NULL;
 		rcu_read_unlock();
 
diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
index 680f4eeea52a..2bfbeecdedba 100644
--- a/fs/bcachefs/io_read.c
+++ b/fs/bcachefs/io_read.c
@@ -411,7 +411,7 @@ static inline struct bch_read_bio *bch2_rbio_free(struct bch_read_bio *rbio)
 
 	if (rbio->have_ioref) {
 		struct bch_dev *ca = bch2_dev_have_ref(rbio->c, rbio->pick.ptr.dev);
-		percpu_ref_put(&ca->io_ref[READ]);
+		enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_io_read);
 	}
 
 	if (rbio->split) {
@@ -1101,7 +1101,8 @@ int __bch2_read_extent(struct btree_trans *trans, struct bch_read_bio *orig,
 		goto err;
 	}
 
-	struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ);
+	struct bch_dev *ca = bch2_dev_get_ioref(c, pick.ptr.dev, READ,
+					BCH_DEV_READ_REF_io_read);
 
 	/*
 	 * Stale dirty pointers are treated as IO errors, but @failed isn't
@@ -1115,7 +1116,7 @@ int __bch2_read_extent(struct btree_trans *trans, struct bch_read_bio *orig,
 	    unlikely(dev_ptr_stale(ca, &pick.ptr))) {
 		read_from_stale_dirty_pointer(trans, ca, k, pick.ptr);
 		bch2_mark_io_failure(failed, &pick, false);
-		percpu_ref_put(&ca->io_ref[READ]);
+		enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_io_read);
 		goto retry_pick;
 	}
 
@@ -1148,7 +1149,8 @@ int __bch2_read_extent(struct btree_trans *trans, struct bch_read_bio *orig,
 		 */
 		if (pick.crc.compressed_size > u->op.wbio.bio.bi_iter.bi_size) {
 			if (ca)
-				percpu_ref_put(&ca->io_ref[READ]);
+				enumerated_ref_put(&ca->io_ref[READ],
+					BCH_DEV_READ_REF_io_read);
 			rbio->ret = -BCH_ERR_data_read_buffer_too_small;
 			goto out_read_done;
 		}
diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
index 755169c4e0e0..f7c5fcbfd73f 100644
--- a/fs/bcachefs/io_write.c
+++ b/fs/bcachefs/io_write.c
@@ -442,6 +442,10 @@ void bch2_submit_wbio_replicas(struct bch_write_bio *wbio, struct bch_fs *c,
 {
 	struct bkey_ptrs_c ptrs = bch2_bkey_ptrs_c(bkey_i_to_s_c(k));
 	struct bch_write_bio *n;
+	unsigned ref_rw  = type == BCH_DATA_btree ? READ : WRITE;
+	unsigned ref_idx = type == BCH_DATA_btree
+		? BCH_DEV_READ_REF_btree_node_write
+		: BCH_DEV_WRITE_REF_io_write;
 
 	BUG_ON(c->opts.nochanges);
 
@@ -453,7 +457,7 @@ void bch2_submit_wbio_replicas(struct bch_write_bio *wbio, struct bch_fs *c,
 		 */
 		struct bch_dev *ca = nocow
 			? bch2_dev_have_ref(c, ptr->dev)
-			: bch2_dev_get_ioref(c, ptr->dev, type == BCH_DATA_btree ? READ : WRITE);
+			: bch2_dev_get_ioref(c, ptr->dev, ref_rw, ref_idx);
 
 		if (to_entry(ptr + 1) < ptrs.end) {
 			n = to_wbio(bio_alloc_clone(NULL, &wbio->bio, GFP_NOFS, &c->replica_set));
@@ -728,7 +732,8 @@ static void bch2_write_endio(struct bio *bio)
 	}
 
 	if (wbio->have_ioref)
-		percpu_ref_put(&ca->io_ref[WRITE]);
+		enumerated_ref_put(&ca->io_ref[WRITE],
+				   BCH_DEV_WRITE_REF_io_write);
 
 	if (wbio->bounce)
 		bch2_bio_free_pages_pool(c, bio);
@@ -1325,7 +1330,8 @@ static void bch2_nocow_write(struct bch_write_op *op)
 		/* Get iorefs before dropping btree locks: */
 		struct bkey_ptrs_c ptrs = bch2_bkey_ptrs_c(k);
 		bkey_for_each_ptr(ptrs, ptr) {
-			struct bch_dev *ca = bch2_dev_get_ioref(c, ptr->dev, WRITE);
+			struct bch_dev *ca = bch2_dev_get_ioref(c, ptr->dev, WRITE,
+							BCH_DEV_WRITE_REF_io_write);
 			if (unlikely(!ca))
 				goto err_get_ioref;
 
@@ -1427,7 +1433,8 @@ static void bch2_nocow_write(struct bch_write_op *op)
 	return;
 err_get_ioref:
 	darray_for_each(buckets, i)
-		percpu_ref_put(&bch2_dev_have_ref(c, i->b.inode)->io_ref[WRITE]);
+		enumerated_ref_put(&bch2_dev_have_ref(c, i->b.inode)->io_ref[WRITE],
+				   BCH_DEV_WRITE_REF_io_write);
 
 	/* Fall back to COW path: */
 	goto out;
diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index e2c95192a577..f2963a6cca88 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1336,13 +1336,14 @@ int bch2_dev_journal_alloc(struct bch_dev *ca, bool new_fs)
 
 int bch2_fs_journal_alloc(struct bch_fs *c)
 {
-	for_each_online_member(c, ca) {
+	for_each_online_member(c, ca, BCH_DEV_READ_REF_fs_journal_alloc) {
 		if (ca->journal.nr)
 			continue;
 
 		int ret = bch2_dev_journal_alloc(ca, true);
 		if (ret) {
-			percpu_ref_put(&ca->io_ref[READ]);
+			enumerated_ref_put(&ca->io_ref[READ],
+					   BCH_DEV_READ_REF_fs_journal_alloc);
 			return ret;
 		}
 	}
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 50aa44665f1f..58e3983d860a 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1218,7 +1218,7 @@ static CLOSURE_CALLBACK(bch2_journal_read_device)
 out:
 	bch_verbose(c, "journal read done on device %s, ret %i", ca->name, ret);
 	kvfree(buf.data);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_journal_read);
 	closure_return(cl);
 	return;
 err:
@@ -1253,7 +1253,8 @@ int bch2_journal_read(struct bch_fs *c,
 
 		if ((ca->mi.state == BCH_MEMBER_STATE_rw ||
 		     ca->mi.state == BCH_MEMBER_STATE_ro) &&
-		    percpu_ref_tryget(&ca->io_ref[READ]))
+		    enumerated_ref_tryget(&ca->io_ref[READ],
+					  BCH_DEV_READ_REF_journal_read))
 			closure_call(&ca->journal.read,
 				     bch2_journal_read_device,
 				     system_unbound_wq,
@@ -1768,7 +1769,7 @@ static void journal_write_endio(struct bio *bio)
 	}
 
 	closure_put(&w->io);
-	percpu_ref_put(&ca->io_ref[WRITE]);
+	enumerated_ref_put(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_journal_write);
 }
 
 static CLOSURE_CALLBACK(journal_write_submit)
@@ -1779,7 +1780,8 @@ static CLOSURE_CALLBACK(journal_write_submit)
 	unsigned sectors = vstruct_sectors(w->data, c->block_bits);
 
 	extent_for_each_ptr(bkey_i_to_s_extent(&w->key), ptr) {
-		struct bch_dev *ca = bch2_dev_get_ioref(c, ptr->dev, WRITE);
+		struct bch_dev *ca = bch2_dev_get_ioref(c, ptr->dev, WRITE,
+					BCH_DEV_WRITE_REF_journal_write);
 		if (!ca) {
 			/* XXX: fix this */
 			bch_err(c, "missing device for journal write\n");
@@ -1842,8 +1844,9 @@ static CLOSURE_CALLBACK(journal_write_preflush)
 	}
 
 	if (w->separate_flush) {
-		for_each_rw_member(c, ca) {
-			percpu_ref_get(&ca->io_ref[WRITE]);
+		for_each_rw_member(c, ca, BCH_DEV_WRITE_REF_journal_write) {
+			enumerated_ref_get(&ca->io_ref[WRITE],
+					   BCH_DEV_WRITE_REF_journal_write);
 
 			struct journal_device *ja = &ca->journal;
 			struct bio *bio = &ja->bio[w->idx]->bio;
diff --git a/fs/bcachefs/journal_reclaim.c b/fs/bcachefs/journal_reclaim.c
index 3ec4175db574..66bfb95f1ea4 100644
--- a/fs/bcachefs/journal_reclaim.c
+++ b/fs/bcachefs/journal_reclaim.c
@@ -285,7 +285,7 @@ void bch2_journal_do_discards(struct journal *j)
 
 	mutex_lock(&j->discard_lock);
 
-	for_each_rw_member(c, ca) {
+	for_each_rw_member(c, ca, BCH_DEV_WRITE_REF_journal_do_discards) {
 		struct journal_device *ja = &ca->journal;
 
 		while (should_discard_bucket(j, ja)) {
diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
index 7fd971496f4f..0337e34dcb23 100644
--- a/fs/bcachefs/sb-members.h
+++ b/fs/bcachefs/sb-members.h
@@ -4,6 +4,7 @@
 
 #include "darray.h"
 #include "bkey_types.h"
+#include "enumerated_ref.h"
 
 extern char * const bch2_member_error_strs[];
 
@@ -20,7 +21,7 @@ struct bch_member bch2_sb_member_get(struct bch_sb *sb, int i);
 
 static inline bool bch2_dev_is_online(struct bch_dev *ca)
 {
-	return !percpu_ref_is_zero(&ca->io_ref[READ]);
+	return !enumerated_ref_is_zero(&ca->io_ref[READ]);
 }
 
 static inline struct bch_dev *bch2_dev_rcu(struct bch_fs *, unsigned);
@@ -163,33 +164,33 @@ static inline struct bch_dev *bch2_get_next_dev(struct bch_fs *c, struct bch_dev
 static inline struct bch_dev *bch2_get_next_online_dev(struct bch_fs *c,
 						       struct bch_dev *ca,
 						       unsigned state_mask,
-						       int rw)
+						       int rw, unsigned ref_idx)
 {
 	rcu_read_lock();
 	if (ca)
-		percpu_ref_put(&ca->io_ref[rw]);
+		enumerated_ref_put(&ca->io_ref[rw], ref_idx);
 
 	while ((ca = __bch2_next_dev(c, ca, NULL)) &&
 	       (!((1 << ca->mi.state) & state_mask) ||
-		!percpu_ref_tryget(&ca->io_ref[rw])))
+		!enumerated_ref_tryget(&ca->io_ref[rw], ref_idx)))
 		;
 	rcu_read_unlock();
 
 	return ca;
 }
 
-#define __for_each_online_member(_c, _ca, state_mask, rw)		\
+#define __for_each_online_member(_c, _ca, state_mask, rw, ref_idx)	\
 	for (struct bch_dev *_ca = NULL;				\
-	     (_ca = bch2_get_next_online_dev(_c, _ca, state_mask, rw));)
+	     (_ca = bch2_get_next_online_dev(_c, _ca, state_mask, rw, ref_idx));)
 
-#define for_each_online_member(c, ca)					\
-	__for_each_online_member(c, ca, ~0, READ)
+#define for_each_online_member(c, ca, ref_idx)				\
+	__for_each_online_member(c, ca, ~0, READ, ref_idx)
 
-#define for_each_rw_member(c, ca)					\
-	__for_each_online_member(c, ca, BIT(BCH_MEMBER_STATE_rw), WRITE)
+#define for_each_rw_member(c, ca, ref_idx)					\
+	__for_each_online_member(c, ca, BIT(BCH_MEMBER_STATE_rw), WRITE, ref_idx)
 
-#define for_each_readable_member(c, ca)				\
-	__for_each_online_member(c, ca,	BIT( BCH_MEMBER_STATE_rw)|BIT(BCH_MEMBER_STATE_ro), READ)
+#define for_each_readable_member(c, ca, ref_idx)				\
+	__for_each_online_member(c, ca,	BIT( BCH_MEMBER_STATE_rw)|BIT(BCH_MEMBER_STATE_ro), READ, ref_idx)
 
 static inline bool bch2_dev_exists(const struct bch_fs *c, unsigned dev)
 {
@@ -290,13 +291,14 @@ static inline struct bch_dev *bch2_dev_iterate(struct bch_fs *c, struct bch_dev
 	return bch2_dev_tryget(c, dev_idx);
 }
 
-static inline struct bch_dev *bch2_dev_get_ioref(struct bch_fs *c, unsigned dev, int rw)
+static inline struct bch_dev *bch2_dev_get_ioref(struct bch_fs *c, unsigned dev,
+						 int rw, unsigned ref_idx)
 {
 	might_sleep();
 
 	rcu_read_lock();
 	struct bch_dev *ca = bch2_dev_rcu(c, dev);
-	if (ca && !percpu_ref_tryget(&ca->io_ref[rw]))
+	if (ca && !enumerated_ref_tryget(&ca->io_ref[rw], ref_idx))
 		ca = NULL;
 	rcu_read_unlock();
 
@@ -306,7 +308,7 @@ static inline struct bch_dev *bch2_dev_get_ioref(struct bch_fs *c, unsigned dev,
 		return ca;
 
 	if (ca)
-		percpu_ref_put(&ca->io_ref[rw]);
+		enumerated_ref_put(&ca->io_ref[rw], ref_idx);
 	return NULL;
 }
 
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 872707e5fa95..d53cbc5f9925 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -260,11 +260,11 @@ struct bch_sb_field *bch2_sb_field_resize_id(struct bch_sb_handle *sb,
 
 		/* XXX: we're not checking that offline device have enough space */
 
-		for_each_online_member(c, ca) {
+		for_each_online_member(c, ca, BCH_DEV_READ_REF_sb_field_resize) {
 			struct bch_sb_handle *dev_sb = &ca->disk_sb;
 
 			if (bch2_sb_realloc(dev_sb, le32_to_cpu(dev_sb->sb->u64s) + d)) {
-				percpu_ref_put(&ca->io_ref[READ]);
+				enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_sb_field_resize);
 				return NULL;
 			}
 		}
@@ -967,7 +967,7 @@ static void write_super_endio(struct bio *bio)
 	}
 
 	closure_put(&ca->fs->sb_write);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_write_super);
 }
 
 static void read_back_super(struct bch_fs *c, struct bch_dev *ca)
@@ -985,7 +985,7 @@ static void read_back_super(struct bch_fs *c, struct bch_dev *ca)
 
 	this_cpu_add(ca->io_done->sectors[READ][BCH_DATA_sb], bio_sectors(bio));
 
-	percpu_ref_get(&ca->io_ref[READ]);
+	enumerated_ref_get(&ca->io_ref[READ], BCH_DEV_READ_REF_write_super);
 	closure_bio_submit(bio, &c->sb_write);
 }
 
@@ -1011,7 +1011,7 @@ static void write_one_super(struct bch_fs *c, struct bch_dev *ca, unsigned idx)
 	this_cpu_add(ca->io_done->sectors[WRITE][BCH_DATA_sb],
 		     bio_sectors(bio));
 
-	percpu_ref_get(&ca->io_ref[READ]);
+	enumerated_ref_get(&ca->io_ref[READ], BCH_DEV_READ_REF_write_super);
 	closure_bio_submit(bio, &c->sb_write);
 }
 
@@ -1043,13 +1043,13 @@ int bch2_write_super(struct bch_fs *c)
 	 * For now, we expect to be able to call write_super() when we're not
 	 * yet RW:
 	 */
-	for_each_online_member(c, ca) {
+	for_each_online_member(c, ca, BCH_DEV_READ_REF_write_super) {
 		ret = darray_push(&online_devices, ca);
 		if (bch2_fs_fatal_err_on(ret, c, "%s: error allocating online devices", __func__)) {
-			percpu_ref_put(&ca->io_ref[READ]);
+			enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_write_super);
 			goto out;
 		}
-		percpu_ref_get(&ca->io_ref[READ]);
+		enumerated_ref_get(&ca->io_ref[READ], BCH_DEV_READ_REF_write_super);
 	}
 
 	/* Make sure we're using the new magic numbers: */
@@ -1216,7 +1216,7 @@ int bch2_write_super(struct bch_fs *c)
 	/* Make new options visible after they're persistent: */
 	bch2_sb_update(c);
 	darray_for_each(online_devices, ca)
-		percpu_ref_put(&(*ca)->io_ref[READ]);
+		enumerated_ref_put(&(*ca)->io_ref[READ], BCH_DEV_READ_REF_write_super);
 	darray_exit(&online_devices);
 	printbuf_exit(&err);
 	return ret;
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 288e00779fff..bfb03213d4a5 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -78,13 +78,28 @@ MODULE_DESCRIPTION("bcachefs filesystem");
 
 typedef DARRAY(struct bch_sb_handle) bch_sb_handles;
 
-const char * const bch2_fs_flag_strs[] = {
 #define x(n)		#n,
+const char * const bch2_fs_flag_strs[] = {
 	BCH_FS_FLAGS()
-#undef x
 	NULL
 };
 
+const char * const bch2_write_refs[] = {
+	BCH_WRITE_REFS()
+	NULL
+};
+
+const char * const bch2_dev_read_refs[] = {
+	BCH_DEV_READ_REFS()
+	NULL
+};
+
+const char * const bch2_dev_write_refs[] = {
+	BCH_DEV_WRITE_REFS()
+	NULL
+};
+#undef x
+
 static void __bch2_print_str(struct bch_fs *c, const char *prefix,
 			     const char *str, bool nonblocking)
 {
@@ -490,7 +505,7 @@ static int __bch2_fs_read_write(struct bch_fs *c, bool early)
 	for_each_online_member_rcu(c, ca)
 		if (ca->mi.state == BCH_MEMBER_STATE_rw) {
 			bch2_dev_allocator_add(c, ca);
-			percpu_ref_reinit(&ca->io_ref[WRITE]);
+			enumerated_ref_start(&ca->io_ref[WRITE]);
 		}
 	rcu_read_unlock();
 
@@ -656,6 +671,12 @@ void __bch2_fs_stop(struct bch_fs *c)
 	bch2_fs_read_only(c);
 	up_write(&c->state_lock);
 
+	for (unsigned i = 0; i < c->sb.nr_devices; i++) {
+		struct bch_dev *ca = rcu_dereference_protected(c->devs[i], true);
+		if (ca)
+			bch2_dev_io_ref_stop(ca, READ);
+	}
+
 	for_each_member_device(c, ca)
 		bch2_dev_unlink(ca);
 
@@ -684,8 +705,6 @@ void __bch2_fs_stop(struct bch_fs *c)
 
 void bch2_fs_free(struct bch_fs *c)
 {
-	unsigned i;
-
 	mutex_lock(&bch_fs_list_lock);
 	list_del(&c->list);
 	mutex_unlock(&bch_fs_list_lock);
@@ -693,7 +712,7 @@ void bch2_fs_free(struct bch_fs *c)
 	closure_sync(&c->cl);
 	closure_debug_destroy(&c->cl);
 
-	for (i = 0; i < c->sb.nr_devices; i++) {
+	for (unsigned i = 0; i < c->sb.nr_devices; i++) {
 		struct bch_dev *ca = rcu_dereference_protected(c->devs[i], true);
 
 		if (ca) {
@@ -1261,11 +1280,11 @@ static void bch2_dev_io_ref_stop(struct bch_dev *ca, int rw)
 	if (rw == READ)
 		clear_bit(ca->dev_idx, ca->fs->online_devs.d);
 
-	if (!percpu_ref_is_zero(&ca->io_ref[rw])) {
-		reinit_completion(&ca->io_ref_completion[rw]);
-		percpu_ref_kill(&ca->io_ref[rw]);
-		wait_for_completion(&ca->io_ref_completion[rw]);
-	}
+	if (!enumerated_ref_is_zero(&ca->io_ref[rw]))
+		enumerated_ref_stop(&ca->io_ref[rw],
+				    rw == READ
+				    ? bch2_dev_read_refs
+				    : bch2_dev_write_refs);
 }
 
 static void bch2_dev_release(struct kobject *kobj)
@@ -1277,8 +1296,8 @@ static void bch2_dev_release(struct kobject *kobj)
 
 static void bch2_dev_free(struct bch_dev *ca)
 {
-	WARN_ON(!percpu_ref_is_zero(&ca->io_ref[WRITE]));
-	WARN_ON(!percpu_ref_is_zero(&ca->io_ref[READ]));
+	WARN_ON(!enumerated_ref_is_zero(&ca->io_ref[WRITE]));
+	WARN_ON(!enumerated_ref_is_zero(&ca->io_ref[READ]));
 
 	cancel_work_sync(&ca->io_error_work);
 
@@ -1298,8 +1317,8 @@ static void bch2_dev_free(struct bch_dev *ca)
 	bch2_time_stats_quantiles_exit(&ca->io_latency[WRITE]);
 	bch2_time_stats_quantiles_exit(&ca->io_latency[READ]);
 
-	percpu_ref_exit(&ca->io_ref[WRITE]);
-	percpu_ref_exit(&ca->io_ref[READ]);
+	enumerated_ref_exit(&ca->io_ref[WRITE]);
+	enumerated_ref_exit(&ca->io_ref[READ]);
 #ifndef CONFIG_BCACHEFS_DEBUG
 	percpu_ref_exit(&ca->ref);
 #endif
@@ -1311,7 +1330,7 @@ static void __bch2_dev_offline(struct bch_fs *c, struct bch_dev *ca)
 
 	lockdep_assert_held(&c->state_lock);
 
-	if (percpu_ref_is_zero(&ca->io_ref[READ]))
+	if (enumerated_ref_is_zero(&ca->io_ref[READ]))
 		return;
 
 	__bch2_dev_read_only(c, ca);
@@ -1333,20 +1352,6 @@ static void bch2_dev_ref_complete(struct percpu_ref *ref)
 }
 #endif
 
-static void bch2_dev_io_ref_read_complete(struct percpu_ref *ref)
-{
-	struct bch_dev *ca = container_of(ref, struct bch_dev, io_ref[READ]);
-
-	complete(&ca->io_ref_completion[READ]);
-}
-
-static void bch2_dev_io_ref_write_complete(struct percpu_ref *ref)
-{
-	struct bch_dev *ca = container_of(ref, struct bch_dev, io_ref[WRITE]);
-
-	complete(&ca->io_ref_completion[WRITE]);
-}
-
 static void bch2_dev_unlink(struct bch_dev *ca)
 {
 	struct kobject *b;
@@ -1408,8 +1413,6 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
 
 	kobject_init(&ca->kobj, &bch2_dev_ktype);
 	init_completion(&ca->ref_completion);
-	init_completion(&ca->io_ref_completion[READ]);
-	init_completion(&ca->io_ref_completion[WRITE]);
 
 	INIT_WORK(&ca->io_error_work, bch2_io_error_work);
 
@@ -1435,10 +1438,8 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
 
 	bch2_dev_allocator_background_init(ca);
 
-	if (percpu_ref_init(&ca->io_ref[READ], bch2_dev_io_ref_read_complete,
-			    PERCPU_REF_INIT_DEAD, GFP_KERNEL) ||
-	    percpu_ref_init(&ca->io_ref[WRITE], bch2_dev_io_ref_write_complete,
-			    PERCPU_REF_INIT_DEAD, GFP_KERNEL) ||
+	if (enumerated_ref_init(&ca->io_ref[READ],  BCH_DEV_READ_REF_NR,  NULL) ||
+	    enumerated_ref_init(&ca->io_ref[WRITE], BCH_DEV_WRITE_REF_NR, NULL) ||
 	    !(ca->sb_read_scratch = kmalloc(BCH_SB_READ_SCRATCH_BUF_SIZE, GFP_KERNEL)) ||
 	    bch2_dev_buckets_alloc(c, ca) ||
 	    !(ca->io_done	= alloc_percpu(*ca->io_done)))
@@ -1500,8 +1501,8 @@ static int __bch2_dev_attach_bdev(struct bch_dev *ca, struct bch_sb_handle *sb)
 		return -BCH_ERR_device_size_too_small;
 	}
 
-	BUG_ON(!percpu_ref_is_zero(&ca->io_ref[READ]));
-	BUG_ON(!percpu_ref_is_zero(&ca->io_ref[WRITE]));
+	BUG_ON(!enumerated_ref_is_zero(&ca->io_ref[READ]));
+	BUG_ON(!enumerated_ref_is_zero(&ca->io_ref[WRITE]));
 
 	ret = bch2_dev_journal_init(ca, sb->sb);
 	if (ret)
@@ -1520,7 +1521,7 @@ static int __bch2_dev_attach_bdev(struct bch_dev *ca, struct bch_sb_handle *sb)
 
 	ca->dev = ca->disk_sb.bdev->bd_dev;
 
-	percpu_ref_reinit(&ca->io_ref[READ]);
+	enumerated_ref_start(&ca->io_ref[READ]);
 
 	return 0;
 }
@@ -1667,8 +1668,8 @@ static void __bch2_dev_read_write(struct bch_fs *c, struct bch_dev *ca)
 	bch2_dev_allocator_add(c, ca);
 	bch2_recalc_capacity(c);
 
-	if (percpu_ref_is_zero(&ca->io_ref[WRITE]))
-		percpu_ref_reinit(&ca->io_ref[WRITE]);
+	if (enumerated_ref_is_zero(&ca->io_ref[WRITE]))
+		enumerated_ref_start(&ca->io_ref[WRITE]);
 
 	bch2_dev_do_discards(ca);
 }
@@ -1818,7 +1819,7 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
 err:
 	if (test_bit(BCH_FS_rw, &c->flags) &&
 	    ca->mi.state == BCH_MEMBER_STATE_rw &&
-	    !percpu_ref_is_zero(&ca->io_ref[READ]))
+	    !enumerated_ref_is_zero(&ca->io_ref[READ]))
 		__bch2_dev_read_write(c, ca);
 	up_write(&c->state_lock);
 	return ret;
@@ -2119,7 +2120,7 @@ int bch2_fs_resize_on_mount(struct bch_fs *c)
 {
 	down_write(&c->state_lock);
 
-	for_each_online_member(c, ca) {
+	for_each_online_member(c, ca, BCH_DEV_READ_REF_fs_resize_on_mount) {
 		u64 old_nbuckets = ca->mi.nbuckets;
 		u64 new_nbuckets = div64_u64(get_capacity(ca->disk_sb.bdev->bd_disk),
 					 ca->mi.bucket_size);
@@ -2130,7 +2131,8 @@ int bch2_fs_resize_on_mount(struct bch_fs *c)
 			int ret = bch2_dev_buckets_resize(c, ca, new_nbuckets);
 			bch_err_fn(ca, ret);
 			if (ret) {
-				percpu_ref_put(&ca->io_ref[READ]);
+				enumerated_ref_put(&ca->io_ref[READ],
+						   BCH_DEV_READ_REF_fs_resize_on_mount);
 				up_write(&c->state_lock);
 				return ret;
 			}
@@ -2148,7 +2150,8 @@ int bch2_fs_resize_on_mount(struct bch_fs *c)
 			if (ca->mi.freespace_initialized) {
 				ret = __bch2_dev_resize_alloc(ca, old_nbuckets, new_nbuckets);
 				if (ret) {
-					percpu_ref_put(&ca->io_ref[READ]);
+					enumerated_ref_put(&ca->io_ref[READ],
+							BCH_DEV_READ_REF_fs_resize_on_mount);
 					up_write(&c->state_lock);
 					return ret;
 				}
diff --git a/fs/bcachefs/super.h b/fs/bcachefs/super.h
index 502d6c57ebb2..dbf59547f67c 100644
--- a/fs/bcachefs/super.h
+++ b/fs/bcachefs/super.h
@@ -9,6 +9,9 @@
 #include <linux/math64.h>
 
 extern const char * const bch2_fs_flag_strs[];
+extern const char * const bch2_write_refs[];
+extern const char * const bch2_dev_read_refs[];
+extern const char * const bch2_dev_write_refs[];
 
 struct bch_fs *bch2_dev_to_fs(dev_t);
 struct bch_fs *bch2_uuid_to_fs(__uuid_t);
diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index 58be32bbd49c..7c840b470094 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -178,14 +178,9 @@ read_attribute(btree_reserve_cache);
 read_attribute(open_buckets);
 read_attribute(open_buckets_partial);
 read_attribute(nocow_lock_table);
-read_attribute(write_refs);
 
-static const char * const bch2_write_refs[] = {
-#define x(n)	#n,
-	BCH_WRITE_REFS()
-#undef x
-	NULL
-};
+read_attribute(read_refs);
+read_attribute(write_refs);
 
 read_attribute(internal_uuid);
 read_attribute(disk_groups);
@@ -314,7 +309,7 @@ static int bch2_read_fua_test(struct printbuf *out, struct bch_dev *ca)
 	bch2_time_stats_init_no_pcpu(&stats_fua);
 	bch2_time_stats_init_no_pcpu(&stats_random);
 
-	if (!bch2_dev_get_ioref(c, ca->dev_idx, READ)) {
+	if (!bch2_dev_get_ioref(c, ca->dev_idx, READ, BCH_DEV_READ_REF_read_fua_test)) {
 		prt_str(out, "offline\n");
 		return 0;
 	}
@@ -405,7 +400,7 @@ static int bch2_read_fua_test(struct printbuf *out, struct bch_dev *ca)
 err:
 	kfree(buf);
 	kfree(bio);
-	percpu_ref_put(&ca->io_ref[READ]);
+	enumerated_ref_put(&ca->io_ref[READ], BCH_DEV_READ_REF_read_fua_test);
 	bch_err_fn(c, ret);
 	return ret;
 }
@@ -905,6 +900,12 @@ SHOW(bch2_dev)
 	if (opt_id >= 0)
 		return sysfs_opt_show(c, ca, opt_id, out);
 
+	if (attr == &sysfs_read_refs)
+		enumerated_ref_to_text(out, &ca->io_ref[READ], bch2_dev_read_refs);
+
+	if (attr == &sysfs_write_refs)
+		enumerated_ref_to_text(out, &ca->io_ref[WRITE], bch2_dev_write_refs);
+
 	return 0;
 }
 
@@ -962,6 +963,9 @@ struct attribute *bch2_dev_files[] = {
 	/* debug: */
 	&sysfs_alloc_debug,
 	&sysfs_open_buckets,
+
+	&sysfs_read_refs,
+	&sysfs_write_refs,
 	NULL
 };
 
-- 
2.49.0


