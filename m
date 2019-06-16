Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0254F475CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2019 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFPQI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 12:08:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbfFPQI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:08:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5GG6Rn7070579
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2019 12:08:27 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t5dsqf3ux-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2019 12:08:27 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Sun, 16 Jun 2019 17:08:26 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Jun 2019 17:08:22 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5GG8Lxa35389892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 16:08:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 235186E04E;
        Sun, 16 Jun 2019 16:08:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 279306E052;
        Sun, 16 Jun 2019 16:08:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.181])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jun 2019 16:08:16 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, jaegeuk@kernel.org,
        yuchao0@huawei.com, hch@infradead.org
Subject: [PATCH V3 6/7] Add decryption support for sub-pagesized blocks
Date:   Sun, 16 Jun 2019 21:38:12 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190616160813.24464-1-chandan@linux.ibm.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061616-0004-0000-0000-0000151D48A5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011273; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01218855; UDB=6.00641061; IPR=6.00999987;
 MB=3.00027334; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-16 16:08:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061616-0005-0000-0000-00008C1BAF5C
Message-Id: <20190616160813.24464-7-chandan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To support decryption of sub-pagesized blocks this commit adds code to,
1. Track buffer head in "struct read_callbacks_ctx".
2. Pass buffer head argument to all read callbacks.
3. Add new fscrypt helper to decrypt the file data referred to by a
   buffer head.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/buffer.c                    |  55 +++++++++------
 fs/crypto/bio.c                |  21 +++++-
 fs/f2fs/data.c                 |   2 +-
 fs/mpage.c                     |   2 +-
 fs/read_callbacks.c            | 118 +++++++++++++++++++++++++--------
 include/linux/buffer_head.h    |   1 +
 include/linux/read_callbacks.h |  13 +++-
 7 files changed, 158 insertions(+), 54 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e450c55f6434..dcb67525dac9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -46,6 +46,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/pagevec.h>
 #include <linux/sched/mm.h>
+#include <linux/read_callbacks.h>
 #include <trace/events/block.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
@@ -246,11 +247,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	return ret;
 }
 
-/*
- * I/O completion handler for block_read_full_page() - pages
- * which come unlocked at the end of I/O.
- */
-static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
+void end_buffer_async_read(struct buffer_head *bh)
 {
 	unsigned long flags;
 	struct buffer_head *first;
@@ -258,17 +255,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	struct page *page;
 	int page_uptodate = 1;
 
-	BUG_ON(!buffer_async_read(bh));
-
 	page = bh->b_page;
-	if (uptodate) {
-		set_buffer_uptodate(bh);
-	} else {
-		clear_buffer_uptodate(bh);
-		buffer_io_error(bh, ", async page read");
-		SetPageError(page);
-	}
-
 	/*
 	 * Be _very_ careful from here on. Bad things can happen if
 	 * two buffer heads end IO at almost the same time and both
@@ -307,6 +294,31 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 }
 
+/*
+ * I/O completion handler for block_read_full_page().  Pages are unlocked
+ * after the I/O completes and the read callbacks (if any) have executed.
+ */
+static void __end_buffer_async_read(struct buffer_head *bh, int uptodate)
+{
+	struct page *page;
+
+	BUG_ON(!buffer_async_read(bh));
+
+	if (read_callbacks_end_bh(bh, uptodate))
+		return;
+
+	page = bh->b_page;
+	if (uptodate) {
+		set_buffer_uptodate(bh);
+	} else {
+		clear_buffer_uptodate(bh);
+		buffer_io_error(bh, ", async page read");
+		SetPageError(page);
+	}
+
+	end_buffer_async_read(bh);
+}
+
 /*
  * Completion handler for block_write_full_page() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
@@ -379,7 +391,7 @@ EXPORT_SYMBOL(end_buffer_async_write);
  */
 static void mark_buffer_async_read(struct buffer_head *bh)
 {
-	bh->b_end_io = end_buffer_async_read;
+	bh->b_end_io = __end_buffer_async_read;
 	set_buffer_async_read(bh);
 }
 
@@ -2294,10 +2306,15 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	 */
 	for (i = 0; i < nr; i++) {
 		bh = arr[i];
-		if (buffer_uptodate(bh))
-			end_buffer_async_read(bh, 1);
-		else
+		if (buffer_uptodate(bh)) {
+			__end_buffer_async_read(bh, 1);
+		} else {
+			if (WARN_ON(read_callbacks_setup(inode, NULL, bh, NULL))) {
+				__end_buffer_async_read(bh, 0);
+				continue;
+			}
 			submit_bh(REQ_OP_READ, 0, bh);
+		}
 	}
 	return 0;
 }
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 4076d704e2e4..b836d648fd27 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <linux/buffer_head.h>
 #include <linux/read_callbacks.h>
 #include "fscrypt_private.h"
 
@@ -41,12 +42,30 @@ static void fscrypt_decrypt_bio(struct bio *bio)
 	}
 }
 
+static void fscrypt_decrypt_bh(struct buffer_head *bh)
+{
+	struct page *page;
+	int ret;
+
+	page = bh->b_page;
+
+	ret = fscrypt_decrypt_pagecache_blocks(page, bh->b_size,
+					bh_offset(bh));
+	if (ret)
+		SetPageError(page);
+}
+
 void fscrypt_decrypt_work(struct work_struct *work)
 {
 	struct read_callbacks_ctx *ctx =
 		container_of(work, struct read_callbacks_ctx, work);
 
-	fscrypt_decrypt_bio(ctx->bio);
+	WARN_ON(!ctx->bh && !ctx->bio);
+
+	if (ctx->bio)
+		fscrypt_decrypt_bio(ctx->bio);
+	else
+		fscrypt_decrypt_bh(ctx->bh);
 
 	read_callbacks(ctx);
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 23b34399d809..1e8b1eb68a90 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -520,7 +520,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	ret = read_callbacks_setup(inode, bio, f2fs_end_page_op);
+	ret = read_callbacks_setup(inode, bio, NULL, f2fs_end_page_op);
 	if (ret) {
 		bio_put(bio);
 		return ERR_PTR(ret);
diff --git a/fs/mpage.c b/fs/mpage.c
index 611ad122fc92..387c23b529eb 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -313,7 +313,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		if (args->bio == NULL)
 			goto confused;
 
-		if (read_callbacks_setup(inode, args->bio, NULL)) {
+		if (read_callbacks_setup(inode, args->bio, NULL, NULL)) {
 			bio_put(args->bio);
 			args->bio = NULL;
 			goto confused;
diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
index 4b7fc2a349cd..7b3ab11c1652 100644
--- a/fs/read_callbacks.c
+++ b/fs/read_callbacks.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/fscrypt.h>
 #include <linux/read_callbacks.h>
 
@@ -57,35 +58,27 @@ static void end_read_callbacks_bio(struct bio *bio)
 	bio_put(bio);
 }
 
-/**
- * read_callbacks() - Execute the read callbacks state machine.
- * @ctx: The context structure tracking the current state.
- *
- * For each state, this function enqueues a work into appropriate subsystem's
- * work queue. After performing further processing of the data in the bio's
- * pages, the subsystem should invoke read_calbacks() to continue with the next
- * state in the state machine.
- */
-void read_callbacks(struct read_callbacks_ctx *ctx)
+static void end_read_callbacks_bh(struct buffer_head *bh)
 {
-	/*
-	 * We use different work queues for decryption and for verity because
-	 * verity may require reading metadata pages that need decryption, and
-	 * we shouldn't recurse to the same workqueue.
-	 */
-	switch (++ctx->cur_step) {
-	case STEP_DECRYPT:
-		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
-			fscrypt_enqueue_decrypt_work(&ctx->work);
-			return;
-		}
-		ctx->cur_step++;
-		/* fall-through */
-	default:
-		end_read_callbacks_bio(ctx->bio);
-	}
+	struct read_callbacks_ctx *ctx;
+
+	if (!PageError(bh->b_page))
+		set_buffer_uptodate(bh);
+
+	ctx = bh->b_private;
+
+	end_buffer_async_read(bh);
+
+	put_read_callbacks_ctx(ctx);
+}
+
+static void end_read_callbacks(struct bio *bio, struct buffer_head *bh)
+{
+	if (bio)
+		end_read_callbacks_bio(bio);
+	else
+		end_read_callbacks_bh(bh);
 }
-EXPORT_SYMBOL(read_callbacks);
 
 /**
  * read_callbacks_end_bio() - Initiate the read callbacks state machine.
@@ -113,10 +106,69 @@ int read_callbacks_end_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(read_callbacks_end_bio);
 
+/**
+ * read_callbacks_end_bh() - Initiate the read callbacks state machine.
+ * @bh: buffer head on which read I/O operation has just been completed.
+ * @uptodate: Buffer head's I/O status.
+ *
+ * Initiates the execution of the read callbacks state machine when the read
+ * operation has been completed successfully. If there was an error associated
+ * with the buffer head, this function frees the read callbacks context
+ * structure stored in bh->b_private (if any).
+ *
+ * Return: 1 to indicate that the buffer head has been handled (including
+ * unlocking the buffer head and the corresponding page if applicable); 0
+ * otherwise.
+ */
+int read_callbacks_end_bh(struct buffer_head *bh, int uptodate)
+{
+	if (uptodate && bh->b_private) {
+		read_callbacks((struct read_callbacks_ctx *)(bh->b_private));
+		return 1;
+	}
+
+	if (bh->b_private)
+		put_read_callbacks_ctx((struct read_callbacks_ctx *)(bh->b_private));
+
+	return 0;
+}
+EXPORT_SYMBOL(read_callbacks_end_bh);
+
+/**
+ * read_callbacks() - Execute the read callbacks state machine.
+ * @ctx: The context structure tracking the current state.
+ *
+ * For each state, this function enqueues a work into appropriate subsystem's
+ * work queue. After performing further processing of the data in the bio's
+ * pages, the subsystem should invoke read_calbacks() to continue with the next
+ * state in the state machine.
+ */
+void read_callbacks(struct read_callbacks_ctx *ctx)
+{
+	/*
+	 * We use different work queues for decryption and for verity because
+	 * verity may require reading metadata pages that need decryption, and
+	 * we shouldn't recurse to the same workqueue.
+	 */
+	switch (++ctx->cur_step) {
+	case STEP_DECRYPT:
+		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
+			fscrypt_enqueue_decrypt_work(&ctx->work);
+			return;
+		}
+		ctx->cur_step++;
+		/* fall-through */
+	default:
+		end_read_callbacks(ctx->bio, ctx->bh);
+	}
+}
+EXPORT_SYMBOL(read_callbacks);
+
 /**
  * read_callbacks_setup() - Initialize the read callbacks state machine
  * @inode: The file on which read I/O is performed.
  * @bio: bio holding page cache pages on which read I/O is performed.
+ * @bh: Buffer head on which read I/O is performed.
  * @page_op: Function to perform filesystem specific operations on a page.
  *
  * Based on the nature of the file's data (e.g. encrypted), this function
@@ -128,11 +180,14 @@ EXPORT_SYMBOL(read_callbacks_end_bio);
  * Return: 0 on success; An error code on failure.
  */
 int read_callbacks_setup(struct inode *inode, struct bio *bio,
-			end_page_op_t page_op)
+			struct buffer_head *bh, end_page_op_t page_op)
 {
 	struct read_callbacks_ctx *ctx = NULL;
 	unsigned int enabled_steps = 0;
 
+	if (!bh && !bio)
+		return -EINVAL;
+
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 		enabled_steps |= 1 << STEP_DECRYPT;
 
@@ -140,12 +195,17 @@ int read_callbacks_setup(struct inode *inode, struct bio *bio,
 		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
 		if (!ctx)
 			return -ENOMEM;
+
+		ctx->bh = bh;
 		ctx->bio = bio;
 		ctx->inode = inode;
 		ctx->enabled_steps = enabled_steps;
 		ctx->cur_step = STEP_INITIAL;
 		ctx->page_op = page_op;
-		bio->bi_private = ctx;
+		if (bio)
+			bio->bi_private = ctx;
+		else
+			bh->b_private = ctx;
 	}
 
 	return 0;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7f902d..42d0d63c7a3b 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -165,6 +165,7 @@ void create_empty_buffers(struct page *, unsigned long,
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_async_write(struct buffer_head *bh, int uptodate);
+void end_buffer_async_read(struct buffer_head *bh);
 
 /* Things to do with buffers at mapping->private_list */
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
diff --git a/include/linux/read_callbacks.h b/include/linux/read_callbacks.h
index aa1ec8ed7a6a..0b52d7961fb2 100644
--- a/include/linux/read_callbacks.h
+++ b/include/linux/read_callbacks.h
@@ -5,6 +5,7 @@
 typedef void (*end_page_op_t)(struct bio *bio, struct page *page);
 
 struct read_callbacks_ctx {
+	struct buffer_head *bh;
 	struct bio *bio;
 	struct inode *inode;
 	struct work_struct work;
@@ -16,8 +17,9 @@ struct read_callbacks_ctx {
 #ifdef CONFIG_FS_READ_CALLBACKS
 void read_callbacks(struct read_callbacks_ctx *ctx);
 int read_callbacks_end_bio(struct bio *bio);
+int read_callbacks_end_bh(struct buffer_head *bh, int uptodate);
 int read_callbacks_setup(struct inode *inode, struct bio *bio,
-			end_page_op_t page_op);
+			struct buffer_head *bh, end_page_op_t page_op);
 #else
 static inline void read_callbacks(struct read_callbacks_ctx *ctx)
 {
@@ -28,8 +30,13 @@ static inline int read_callbacks_end_bio(struct bio *bio)
 	return -EOPNOTSUPP;
 }
 
-static inline int read_callbacks_setup(struct inode *inode,
-				struct bio *bio, end_page_op_t page_op)
+static inline int read_callbacks_end_bh(struct buffer_head *bh, int uptodate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int read_callbacks_setup(struct inode *inode, struct bio *bio,
+				struct buffer_head *bh, end_page_op_t page_op)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.19.1

