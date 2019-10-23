Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BEE109A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 05:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfJWDeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 23:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbfJWDeA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:34:00 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457C12173B;
        Wed, 23 Oct 2019 03:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571801639;
        bh=ov7QJSp0r4rJzD1FJNkGgfl4svt3RP0z8aSuOGd5cp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAj3pPw9S4Q7SGp+Yr+8HXsMcUuif/PHsqEBhkNhTuUK8imsdK35Ns3yMHThpSu2o
         jY1mLuGI7kSAwdWCoKWzqLnxxlhFoAbv7EEnGLETq4PKYagyka8VgOc/xmnHG4WpUQ
         z5BncMhrKWIsSR/48WkEhmd2e2HRaLJRkG1pA5LY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH v2 1/2] fs/buffer.c: support fscrypt in block_read_full_page()
Date:   Tue, 22 Oct 2019 20:33:11 -0700
Message-Id: <20191023033312.361355-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023033312.361355-1-ebiggers@kernel.org>
References: <20191023033312.361355-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

After each filesystem block (as represented by a buffer_head) has been
read from disk by block_read_full_page(), decrypt it if needed.  The
decryption is done on the fscrypt_read_workqueue.

This is the final change needed to support ext4 encryption with
blocksize != PAGE_SIZE, and it's a fairly small change now that
CONFIG_FS_ENCRYPTION is a bool and fs/crypto/ exposes functions to
decrypt individual blocks and to enqueue work on the fscrypt workqueue.

Don't try to add fs-verity support yet, as the fs/verity/ support layer
isn't ready for sub-page blocks yet.  Just add fscrypt support for now.

Almost all the new code is compiled away when CONFIG_FS_ENCRYPTION=n.

Cc: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/buffer.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 86a38b979323..d39838090b22 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -47,6 +47,7 @@
 #include <linux/pagevec.h>
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
+#include <linux/fscrypt.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
@@ -246,10 +247,6 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	return ret;
 }
 
-/*
- * I/O completion handler for block_read_full_page() - pages
- * which come unlocked at the end of I/O.
- */
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
 	unsigned long flags;
@@ -307,6 +304,47 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	return;
 }
 
+struct decrypt_bh_ctx {
+	struct work_struct work;
+	struct buffer_head *bh;
+};
+
+static void decrypt_bh(struct work_struct *work)
+{
+	struct decrypt_bh_ctx *ctx =
+		container_of(work, struct decrypt_bh_ctx, work);
+	struct buffer_head *bh = ctx->bh;
+	int err;
+
+	err = fscrypt_decrypt_pagecache_blocks(bh->b_page, bh->b_size,
+					       bh_offset(bh));
+	end_buffer_async_read(bh, err == 0);
+	kfree(ctx);
+}
+
+/*
+ * I/O completion handler for block_read_full_page() - pages
+ * which come unlocked at the end of I/O.
+ */
+static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
+{
+	/* Decrypt if needed */
+	if (uptodate && IS_ENABLED(CONFIG_FS_ENCRYPTION) &&
+	    IS_ENCRYPTED(bh->b_page->mapping->host) &&
+	    S_ISREG(bh->b_page->mapping->host->i_mode)) {
+		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+
+		if (ctx) {
+			INIT_WORK(&ctx->work, decrypt_bh);
+			ctx->bh = bh;
+			fscrypt_enqueue_decrypt_work(&ctx->work);
+			return;
+		}
+		uptodate = 0;
+	}
+	end_buffer_async_read(bh, uptodate);
+}
+
 /*
  * Completion handler for block_write_full_page() - pages which are unlocked
  * during I/O, and which have PageWriteback cleared upon I/O completion.
@@ -379,7 +417,7 @@ EXPORT_SYMBOL(end_buffer_async_write);
  */
 static void mark_buffer_async_read(struct buffer_head *bh)
 {
-	bh->b_end_io = end_buffer_async_read;
+	bh->b_end_io = end_buffer_async_read_io;
 	set_buffer_async_read(bh);
 }
 
-- 
2.23.0

