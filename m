Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CCD8FAB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 08:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfHPGRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 02:17:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbfHPGRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:17:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G63kUW059006
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 02:17:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udn6j3em9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 02:17:01 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Fri, 16 Aug 2019 07:17:01 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 07:16:56 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7G6Gt0030671126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 06:16:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8495112063;
        Fri, 16 Aug 2019 06:16:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8013112061;
        Fri, 16 Aug 2019 06:16:52 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.23])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 06:16:52 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, chandanrmail@gmail.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, ebiggers@kernel.org,
        jaegeuk@kernel.org, yuchao0@huawei.com, hch@infradead.org
Subject: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Date:   Fri, 16 Aug 2019 11:48:01 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190816061804.14840-1-chandan@linux.ibm.com>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081606-0072-0000-0000-000004532E3B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011597; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01247516; UDB=6.00658410; IPR=6.01029025;
 MB=3.00028195; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-16 06:16:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081606-0073-0000-0000-00004CC4470F
Message-Id: <20190816061804.14840-6-chandan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160066
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

F2FS has a copy of "post read processing" code using which encrypted
file data is decrypted. This commit replaces it to make use of the
generic read_callbacks facility.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/f2fs/data.c  | 109 ++++--------------------------------------------
 fs/f2fs/f2fs.h  |   2 -
 fs/f2fs/super.c |   9 +---
 3 files changed, 11 insertions(+), 109 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 757f050c650a..3cf1eca2ece9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
+#include <linux/read_callbacks.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -25,11 +26,6 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-#define NUM_PREALLOC_POST_READ_CTXS	128
-
-static struct kmem_cache *bio_post_read_ctx_cache;
-static mempool_t *bio_post_read_ctx_pool;
-
 static bool __is_cp_guaranteed(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
@@ -69,19 +65,6 @@ static enum count_type __read_io_type(struct page *page)
 	return F2FS_RD_DATA;
 }
 
-/* postprocessing steps for read bios */
-enum bio_post_read_step {
-	STEP_INITIAL = 0,
-	STEP_DECRYPT,
-};
-
-struct bio_post_read_ctx {
-	struct bio *bio;
-	struct work_struct work;
-	unsigned int cur_step;
-	unsigned int enabled_steps;
-};
-
 static void __read_end_io(struct bio *bio)
 {
 	struct page *page;
@@ -93,7 +76,7 @@ static void __read_end_io(struct bio *bio)
 		page = bv->bv_page;
 
 		/* PG_error was set if any post_read step failed */
-		if (bio->bi_status || PageError(page)) {
+		if (bio->bi_status || read_callbacks_failed(page)) {
 			ClearPageUptodate(page);
 			/* will re-read again later */
 			ClearPageError(page);
@@ -103,42 +86,8 @@ static void __read_end_io(struct bio *bio)
 		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
 		unlock_page(page);
 	}
-	if (bio->bi_private)
-		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
-	bio_put(bio);
-}
 
-static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
-
-static void decrypt_work(struct work_struct *work)
-{
-	struct bio_post_read_ctx *ctx =
-		container_of(work, struct bio_post_read_ctx, work);
-
-	fscrypt_decrypt_bio(ctx->bio);
-
-	bio_post_read_processing(ctx);
-}
-
-static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
-{
-	switch (++ctx->cur_step) {
-	case STEP_DECRYPT:
-		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
-			INIT_WORK(&ctx->work, decrypt_work);
-			fscrypt_enqueue_decrypt_work(&ctx->work);
-			return;
-		}
-		ctx->cur_step++;
-		/* fall-through */
-	default:
-		__read_end_io(ctx->bio);
-	}
-}
-
-static bool f2fs_bio_post_read_required(struct bio *bio)
-{
-	return bio->bi_private && !bio->bi_status;
+	bio_put(bio);
 }
 
 static void f2fs_read_end_io(struct bio *bio)
@@ -149,15 +98,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
-	if (f2fs_bio_post_read_required(bio)) {
-		struct bio_post_read_ctx *ctx = bio->bi_private;
-
-		ctx->cur_step = STEP_INITIAL;
-		bio_post_read_processing(ctx);
-		return;
-	}
-
-	__read_end_io(bio);
+	read_callbacks_endio_bio(bio, __read_end_io);
 }
 
 static void f2fs_write_end_io(struct bio *bio)
@@ -556,8 +497,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
-	struct bio_post_read_ctx *ctx;
-	unsigned int post_read_steps = 0;
+	int err;
 
 	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))
 		return ERR_PTR(-EFAULT);
@@ -569,17 +509,10 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	if (f2fs_encrypted_file(inode))
-		post_read_steps |= 1 << STEP_DECRYPT;
-	if (post_read_steps) {
-		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
-		if (!ctx) {
-			bio_put(bio);
-			return ERR_PTR(-ENOMEM);
-		}
-		ctx->bio = bio;
-		ctx->enabled_steps = post_read_steps;
-		bio->bi_private = ctx;
+	err = read_callbacks_setup_bio(inode, bio);
+	if (err) {
+		bio_put(bio);
+		return ERR_PTR(err);
 	}
 
 	return bio;
@@ -2860,27 +2793,3 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
 						PAGECACHE_TAG_DIRTY);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
-
-int __init f2fs_init_post_read_processing(void)
-{
-	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, 0);
-	if (!bio_post_read_ctx_cache)
-		goto fail;
-	bio_post_read_ctx_pool =
-		mempool_create_slab_pool(NUM_PREALLOC_POST_READ_CTXS,
-					 bio_post_read_ctx_cache);
-	if (!bio_post_read_ctx_pool)
-		goto fail_free_cache;
-	return 0;
-
-fail_free_cache:
-	kmem_cache_destroy(bio_post_read_ctx_cache);
-fail:
-	return -ENOMEM;
-}
-
-void __exit f2fs_destroy_post_read_processing(void)
-{
-	mempool_destroy(bio_post_read_ctx_pool);
-	kmem_cache_destroy(bio_post_read_ctx_cache);
-}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 87f75ebd2fd6..cea79321b794 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3125,8 +3125,6 @@ void f2fs_destroy_checkpoint_caches(void);
 /*
  * data.c
  */
-int f2fs_init_post_read_processing(void);
-void f2fs_destroy_post_read_processing(void);
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 11b3a039a188..d7bbb4f1fdb3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3597,15 +3597,11 @@ static int __init init_f2fs_fs(void)
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_shrinker;
+
 	f2fs_create_root_stats();
-	err = f2fs_init_post_read_processing();
-	if (err)
-		goto free_root_stats;
+
 	return 0;
 
-free_root_stats:
-	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
 free_sysfs:
@@ -3626,7 +3622,6 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
-	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
-- 
2.19.1

