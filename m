Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BAB10F23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfEAWqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfEAWqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF7B217D4;
        Wed,  1 May 2019 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750768;
        bh=MD0odVaqGugDxW5LgC1mpPZYmPzyX84lrHGaYtQySpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/JaF+Jg+0KaUATWZ4jGQmaNT56l1o8UGWm8m7Nz4jsyQGcFjqe5dltm17Vh+qzbh
         NRptOen6FYQC/ZKzCD2BKX9HDn0iXz0BkrqFErFwh9LkZTiZ0vRJeu0uS3gRFYrhlF
         dch5lZqLugIcJlXNwyjnFeRciOkEosa6xhlzCdI8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 11/13] ext4: decrypt only the needed blocks in ext4_block_write_begin()
Date:   Wed,  1 May 2019 15:45:13 -0700
Message-Id: <20190501224515.43059-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chandan Rajendra <chandan@linux.ibm.com>

In ext4_block_write_begin(), only decrypt the blocks that actually need
to be decrypted (up to two blocks which intersect the boundaries of the
region that will be written to), rather than assuming blocksize ==
PAGE_SIZE and decrypting the whole page.

This is in preparation for allowing encryption on ext4 filesystems with
blocksize != PAGE_SIZE.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
(EB: rebase onto previous changes and improve the commit message)
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9382e1bcefe49..d24c50e4598f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1160,8 +1160,10 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	int err = 0;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	unsigned bbits;
-	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
+	struct buffer_head *bh, *head, *wait[2];
+	int nr_wait = 0;
 	bool decrypt = false;
+	int i;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(from > PAGE_SIZE);
@@ -1213,24 +1215,31 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		    !buffer_unwritten(bh) &&
 		    (block_start < from || block_end > to)) {
 			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-			*wait_bh++ = bh;
+			wait[nr_wait++] = bh;
 			decrypt = IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode);
 		}
 	}
 	/*
 	 * If we issued read requests, let them complete.
 	 */
-	while (wait_bh > wait) {
-		wait_on_buffer(*--wait_bh);
-		if (!buffer_uptodate(*wait_bh))
+	for (i = 0; i < nr_wait; i++) {
+		wait_on_buffer(wait[i]);
+		if (!buffer_uptodate(wait[i]))
 			err = -EIO;
 	}
 	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
 	} else if (decrypt) {
-		err = fscrypt_decrypt_pagecache_blocks(page, PAGE_SIZE, 0);
-		if (err)
-			clear_buffer_uptodate(*wait_bh);
+		for (i = 0; i < nr_wait; i++) {
+			int err2;
+
+			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
+								bh_offset(wait[i]));
+			if (err2) {
+				clear_buffer_uptodate(wait[i]);
+				err = err2;
+			}
+		}
 	}
 
 	return err;
-- 
2.21.0.593.g511ec345e18-goog

