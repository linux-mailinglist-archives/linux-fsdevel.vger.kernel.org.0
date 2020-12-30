Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AC2E7549
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 01:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgL3AKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Dec 2020 19:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgL3AKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Dec 2020 19:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609286919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e4GWSW+b7uP2mt0kRauq4WQsKZBizIfrti+Jx+uuuGk=;
        b=VzCSJCT7BGXMzWr/RhxGWErehcdvzknKmhFWTUSNnu3MAwYWO8RwcGht0eyu7LTIQ0c2d0
        2F/w6vImjoAu9r+MVhhfTcpCchmhg10mrxYJvVUXVBHEq6BR/CE+tbhETDZ9nJWW0iwUJ+
        0cHkZniQzj9ig8UA+ze5j04fB5NKyZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ZgkwbmrHOM-ZYKoGABN4jA-1; Tue, 29 Dec 2020 19:08:35 -0500
X-MC-Unique: ZgkwbmrHOM-ZYKoGABN4jA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1DE4801817;
        Wed, 30 Dec 2020 00:08:33 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A34660BFA;
        Wed, 30 Dec 2020 00:08:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs/buffer: try to submit writeback bio in unit of page
Date:   Wed, 30 Dec 2020 08:08:15 +0800
Message-Id: <20201230000815.3448707-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is observed that __block_write_full_page() always submit bio with size of block size,
which is often 512 bytes.

In case of sequential IO, or >=4k BS random/seq writeback IO, most of times IO
represented by all buffer_head in each page can be done in single bio. It is actually
done in single request IO by block layer's plug merge too.

So check if IO represented by buffer_head can be merged to single page
IO, if yes, just submit single bio instead of submitting one bio for each buffer_head.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/buffer.c | 112 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 22 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 32647d2011df..6bcf9ce5d7f8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -54,6 +54,8 @@
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 enum rw_hint hint, struct writeback_control *wbc);
+static int submit_page_wbc(int op, int op_flags, struct buffer_head *bh,
+			 enum rw_hint hint, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1716,10 +1718,12 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	int err;
 	sector_t block;
 	sector_t last_block;
-	struct buffer_head *bh, *head;
+	struct buffer_head *bh, *head, *prev_bh;
 	unsigned int blocksize, bbits;
 	int nr_underway = 0;
 	int write_flags = wbc_to_write_flags(wbc);
+	unsigned int total_size = 0;
+	bool continuous = true;
 
 	head = create_page_buffers(page, inode,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
@@ -1774,6 +1778,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		block++;
 	} while (bh != head);
 
+	prev_bh = NULL;
 	do {
 		if (!buffer_mapped(bh))
 			continue;
@@ -1792,9 +1797,17 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		}
 		if (test_clear_buffer_dirty(bh)) {
 			mark_buffer_async_write_endio(bh, handler);
+			total_size += bh->b_size;
 		} else {
 			unlock_buffer(bh);
 		}
+
+		if (continuous && prev_bh && !(
+		    prev_bh->b_blocknr + 1 == bh->b_blocknr &&
+		    prev_bh->b_bdev == bh->b_bdev &&
+		    buffer_meta(prev_bh) == buffer_meta(bh)))
+			continuous = false;
+		prev_bh = bh;
 	} while ((bh = bh->b_this_page) != head);
 
 	/*
@@ -1804,15 +1817,21 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 
-	do {
-		struct buffer_head *next = bh->b_this_page;
-		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
-					inode->i_write_hint, wbc);
-			nr_underway++;
-		}
-		bh = next;
-	} while (bh != head);
+	if (total_size == PAGE_SIZE && continuous) {
+		submit_page_wbc(REQ_OP_WRITE, write_flags, bh,
+				inode->i_write_hint, wbc);
+		nr_underway = MAX_BUF_PER_PAGE;
+	} else {
+		do {
+			struct buffer_head *next = bh->b_this_page;
+			if (buffer_async_write(bh)) {
+				submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
+						inode->i_write_hint, wbc);
+				nr_underway++;
+			}
+			bh = next;
+		} while (bh != head);
+	}
 	unlock_page(page);
 
 	err = 0;
@@ -3006,8 +3025,28 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }
 
-static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 enum rw_hint write_hint, struct writeback_control *wbc)
+static void end_bio_page_io_sync(struct bio *bio)
+{
+	struct buffer_head *head = bio->bi_private;
+	struct buffer_head *bh = head;
+
+	do {
+		struct buffer_head *next = bh->b_this_page;
+
+		if (unlikely(bio_flagged(bio, BIO_QUIET)))
+			set_bit(BH_Quiet, &bh->b_state);
+
+		bh->b_end_io(bh, !bio->bi_status);
+		bh = next;
+	} while (bh != head);
+
+	bio_put(bio);
+}
+
+static int __submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
+			   enum rw_hint write_hint,
+			   struct writeback_control *wbc, unsigned int size,
+			   bio_end_io_t   *end_io_handler)
 {
 	struct bio *bio;
 
@@ -3017,12 +3056,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	BUG_ON(buffer_delay(bh));
 	BUG_ON(buffer_unwritten(bh));
 
-	/*
-	 * Only clear out a write error when rewriting
-	 */
-	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
-		clear_buffer_write_io_error(bh);
-
 	bio = bio_alloc(GFP_NOIO, 1);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
@@ -3031,10 +3064,10 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
 
-	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
-	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
+	bio_add_page(bio, bh->b_page, size, bh_offset(bh));
+	BUG_ON(bio->bi_iter.bi_size != size);
 
-	bio->bi_end_io = end_bio_bh_io_sync;
+	bio->bi_end_io = end_io_handler;
 	bio->bi_private = bh;
 
 	if (buffer_meta(bh))
@@ -3048,13 +3081,48 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
-		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
+		wbc_account_cgroup_owner(wbc, bh->b_page, size);
 	}
 
 	submit_bio(bio);
 	return 0;
 }
 
+static inline int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
+				enum rw_hint write_hint,
+				struct writeback_control *wbc)
+{
+	/*
+	 * Only clear out a write error when rewriting
+	 */
+	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
+		clear_buffer_write_io_error(bh);
+
+	return __submit_bh_wbc(op, op_flags, bh, write_hint, wbc, bh->b_size,
+			       end_bio_bh_io_sync);
+}
+
+static int submit_page_wbc(int op, int op_flags, struct buffer_head *head,
+			   enum rw_hint write_hint,
+			   struct writeback_control *wbc)
+{
+	struct buffer_head *bh = head;
+
+	WARN_ON(bh_offset(head) != 0);
+
+	/*
+	 * Only clear out a write error when rewriting
+	 */
+	do {
+		if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
+			clear_buffer_write_io_error(bh);
+		bh = bh->b_this_page;
+	} while (bh != head);
+
+	return __submit_bh_wbc(op, op_flags, head, write_hint, wbc, PAGE_SIZE,
+			       end_bio_page_io_sync);
+}
+
 int submit_bh(int op, int op_flags, struct buffer_head *bh)
 {
 	return submit_bh_wbc(op, op_flags, bh, 0, NULL);
-- 
2.28.0

