Return-Path: <linux-fsdevel+bounces-10249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A960E8495FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308601F22027
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D813AE0;
	Mon,  5 Feb 2024 09:06:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249A179A7;
	Mon,  5 Feb 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123994; cv=none; b=K5abp4V3chBxvU4bTPszI4wJEYGAUl6oS3RWC6xQVDBCW1QBhZet95r5Ig1SXArsUxta/VM5dVabaCIR/2HudlkJxPL5rFwuNMJSt8qs8aGbeArL8j7YmwXq6uFWeQhauSLYpk2nItGcwsuiDLzirKb6MiNxADq2kO6a0THSR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123994; c=relaxed/simple;
	bh=PDAFWnh9a+ea8WSwjnOVDSSW9QVnF4JmFry3dryJTpk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dmogophe3enVVdfDNT5DFQEh2jwgGXF9XJ8MYr2+kLQPUaM363WVdopkuVpvzXLzOpMXkER9gB7A5f2a2D5he8wItM/JNZyU4o3I0JREgHrXuLxAUIFsBP9LQrxeyMapL4dSvTGOkBqAtO0o4yHUGQtjYQj8H9TjOzvNGn+5R4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41595xRB088167;
	Mon, 5 Feb 2024 17:05:59 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TT0pq29X7z2SQS27;
	Mon,  5 Feb 2024 17:05:55 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 5 Feb 2024 17:05:57 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Yu
 Zhao <yuzhao@google.com>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang
 Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv8 1/1] block: introduce content activity based ioprio
Date: Mon, 5 Feb 2024 17:05:52 +0800
Message-ID: <20240205090552.40567-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41595xRB088167

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Currently, request's ioprio are set via task's schedule priority(when no
blkcg configured), which has high priority tasks possess the privilege on
both of CPU and IO scheduling. Furthermore, most of the write requestes
are launched asynchronosly from kworker which can't know the submitter's
priorities.
This commit works as a hint of original policy by promoting the request
ioprio based on the page/folio's activity. The original idea comes from
LRU_GEN which provides more precised folio activity than before. This
commit try to adjust the request's ioprio when certain part of its folios
are hot, which indicate that this request carry important contents and
need be scheduled ealier.

This commit provide two sets of exclusive APIs.

*counting activities by iterating the bio's pages
The filesystem should call bio_set_active_ioprio() before submit_bio on the
spot where they want(buffered read/write/sync etc).

*counting activities during each call
The filesystem should call bio_set_active_ioprio_page/folio() after
calling bio_add_page/folio. Please be noted that this set of API can not
handle bvec_try_merge_page cases.

This commit is verified on a v6.6 6GB RAM android14 system via 4 test cases
by calling bio_set_active_ioprio in erofs, ext4, f2fs and blkdev(raw
partition of gendisk)

Case 1:
script[a] which get significant improved fault time as expected[b]*
where dd's cost also shrink from 55s to 40s.
(1). fault_latency.bin is an ebpf based test tool which measure all task's
   iowait latency during page fault when scheduled out/in.
(2). costmem generate page fault by mmaping a file and access the VA.
(3). dd generate concurrent vfs io.

[a]
./fault_latency.bin 1 5 > /data/dd_costmem &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
dd if=/dev/block/sda of=/data/ddtest bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest1 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest2 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest3 bs=1024 count=2048000
[b]
                       mainline		commit
io wait                736us            523us

* provide correct result for test case 1 in v7 which was compared between
EMMC and UFS wrongly.

Case 2:
fio -filename=/dev/block/by-name/userdata -rw=randread -direct=0 -bs=4k -size=2000M -numjobs=8 -group_reporting -name=mytest
mainline: 513MiB/s
READ: bw=531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), io=15.6GiB (16.8GB), run=30137-30137msec
READ: bw=543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), io=15.6GiB (16.8GB), run=29469-29469msec
READ: bw=474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), io=15.6GiB (16.8GB), run=33724-33724msec
READ: bw=535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=15.6GiB (16.8GB), run=29928-29928msec
READ: bw=523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), io=15.6GiB (16.8GB), run=30617-30617msec
READ: bw=492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), io=15.6GiB (16.8GB), run=32518-32518msec
READ: bw=533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), io=15.6GiB (16.8GB), run=29993-29993msec
READ: bw=524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), io=15.6GiB (16.8GB), run=30526-30526msec
READ: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=15.6GiB (16.8GB), run=30269-30269msec
READ: bw=449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), io=15.6GiB (16.8GB), run=35629-35629msec

commit: 633MiB/s
READ: bw=668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), io=15.6GiB (16.8GB), run=23952-23952msec
READ: bw=589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), io=15.6GiB (16.8GB), run=27164-27164msec
READ: bw=638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), io=15.6GiB (16.8GB), run=25071-25071msec
READ: bw=714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), io=15.6GiB (16.8GB), run=22409-22409msec
READ: bw=600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=15.6GiB (16.8GB), run=26669-26669msec
READ: bw=592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), io=15.6GiB (16.8GB), run=27036-27036msec
READ: bw=691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), io=15.6GiB (16.8GB), run=23150-23150msec
READ: bw=569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), io=15.6GiB (16.8GB), run=28142-28142msec
READ: bw=563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), io=15.6GiB (16.8GB), run=28429-28429msec
READ: bw=712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), io=15.6GiB (16.8GB), run=22478-22478msec

Case 3:
This commit is also verified by the case of launching camera APP which is
usually considered as heavy working load on both of memory and IO, which
shows 12%-24% improvement.

		ttl = 0		ttl = 50	ttl = 100
mainline        2267ms		2420ms		2316ms
commit          1992ms          1806ms          1998ms

case 4:
androbench has no improvment as well as regression in RD/WR test item
while make a 3% improvement in sqlite items.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: calculate page's activity via helper function
change of v3: solve layer violation by move API into mm
change of v4: keep block clean by removing the page related API
change of v5: introduce the macros of bio_add_folio/page for read dir.
change of v6: replace the macro of bio_add_xxx by submit_bio which
                iterating the bio_vec before launching bio to block layer
change of v7: introduce the function bio_set_active_ioprio
	      provide updated test result
change of v8: provide two sets of APIs for bio_set_active_ioprio_xxx
---
---
 block/Kconfig             | 27 +++++++++++
 block/bio.c               | 94 +++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h       |  3 ++
 include/linux/blk_types.h |  7 ++-
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index f1364d1c0d93..5e721678ea3d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -228,6 +228,33 @@ config BLOCK_HOLDER_DEPRECATED
 config BLK_MQ_STACKING
 	bool
 
+config BLK_CONT_ACT_BASED_IOPRIO
+	bool "Enable content activity based ioprio"
+	depends on LRU_GEN
+	default n
+	help
+	  This item enable the feature of adjust bio's priority by
+	  calculating its content's activity.
+	  This feature works as a hint of original bio_set_ioprio
+	  which means rt task get no change of its bio->bi_ioprio
+	  while other tasks have the opportunity to raise the ioprio
+	  if the bio take certain numbers of active pages.
+	  The file system should use this by modifying their buffered
+	  read/write/sync function to raise the bio->bi_ioprio before
+	  calling submit_bio or after bio_add_page/folio
+
+config BLK_CONT_ACT_BASED_IOPRIO_ITER_BIO
+	bool "Counting bio's activity by iterating bio's pages"
+	depends on BLK_CONT_ACT_BASED_IOPRIO
+	help
+	  The API under this config counts bio's activity by iterating the bio.
+
+config BLK_CONT_ACT_BASED_IOPRIO_ADD_PAGE
+	bool "Counting bio's activity when adding page or folio"
+	depends on BLK_CONT_ACT_BASED_IOPRIO && !BLK_CONT_ACT_BASED_IOPRIO_ITER_BIO
+	help
+	  The API under this config count activity during each call buy can't
+	   handle bvec_try_merge_page cases, please be sure you are ok with that.
 source "block/Kconfig.iosched"
 
 endif # BLOCK
diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..73916a6c319f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1476,6 +1476,100 @@ void bio_set_pages_dirty(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
+/*
+ * bio_set_active_ioprio() is helper function for fs to adjust the bio's ioprio via
+ * calculating the content's activity which measured from MGLRU.
+ * The file system should call this function before submit_bio for the buffered
+ * read/write/sync.
+ */
+#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
+#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO_ITER_BIO
+void bio_set_active_ioprio(struct bio *bio)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	struct page *page;
+	int class, level, hint;
+	int activity = 0;
+	int cnt = 0;
+
+	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+	/*apply legacy ioprio policy on RT task*/
+	if (task_is_realtime(current)) {
+		bio->bi_ioprio = IOPRIO_PRIO_VALUE_HINT(IOPRIO_CLASS_RT, level, hint);
+		return;
+	}
+	bio_for_each_bvec(bv, bio, iter) {
+		page = bv.bv_page;
+		activity += PageWorkingset(page) ? 1 : 0;
+		cnt++;
+		if (activity > bio->bi_vcnt / 2) {
+			class = IOPRIO_CLASS_RT;
+			break;
+		} else if (activity > bio->bi_vcnt / 4) {
+			/*
+			 * all itered pages are all active so far
+			 * then raise to RT directly
+			 */
+			if (activity == cnt) {
+				class = IOPRIO_CLASS_RT;
+				break;
+			} else
+				class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()),
+						IOPRIO_CLASS_BE);
+		}
+	}
+	if (!class && activity > cnt / 2)
+		class = IOPRIO_CLASS_RT;
+	else if (!class && activity > cnt / 4)
+		class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE_HINT(class, level, hint);
+}
+void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio) {}
+void bio_set_active_ioprio_page(struct bio *bio, struct page *page) {}
+#endif
+#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO_ADD_PAGE
+/*
+ * bio_set_active_ioprio_page/folio are helper functions for counting
+ * the bio's activity during each all. However, it can't handle the
+ * scenario of bvec_try_merge_page. The submitter can use them if there
+ * is no such case in the system(block size < page size)
+ */
+void bio_set_active_ioprio_page(struct bio *bio, struct page *page)
+{
+	int class, level, hint;
+
+	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+	bio->bi_cont_act += PageWorkingset(page) ? 1 : 0;
+
+	if (bio->bi_cont_act > bio->bi_vcnt / 2)
+		class = IOPRIO_CLASS_RT;
+	else if (bio->bi_cont_act > bio->bi_vcnt / 4)
+		class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE_HINT(class, level, hint);
+}
+
+void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)
+{
+	bio_set_active_ioprio_page(bio, &folio->page);
+}
+void bio_set_active_ioprio(struct bio *bio) {}
+#endif
+#else
+void bio_set_active_ioprio(struct bio *bio) {}
+void bio_set_active_ioprio_page(struct bio *bio, struct page *page) {}
+void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio) {}
+#endif
+EXPORT_SYMBOL_GPL(bio_set_active_ioprio);
+EXPORT_SYMBOL_GPL(bio_set_active_ioprio_page);
+EXPORT_SYMBOL_GPL(bio_set_active_ioprio_folio);
+
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
  * If they are, then fine.  If, however, some pages are clean then they must
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 41d417ee1349..35221ee3dd54 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -487,6 +487,9 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
+extern void bio_set_active_ioprio(struct bio *bio);
+extern void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio);
+extern void bio_set_active_ioprio_page(struct bio *bio, struct page *page);
 
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..a3a18b9a5168 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -314,7 +314,12 @@ struct bio {
 	struct bio_vec		*bi_io_vec;	/* the actual vec list */
 
 	struct bio_set		*bi_pool;
-
+#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
+	/*
+	 * bi_cont_act record total activities of bi_io_vec->pages
+	 */
+	u64			bi_cont_act;
+#endif
 	/*
 	 * We can inline a number of vecs at the end of the bio, to avoid
 	 * double allocations for a small number of bio_vecs. This member
-- 
2.25.1


