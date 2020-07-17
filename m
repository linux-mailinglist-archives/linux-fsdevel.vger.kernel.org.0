Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA422309E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGQBpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGQBpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:45:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5852C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id 65so5628160plf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+UBFxrt4pNJbQqfKhET/4plBmEv6gpLPjB+6J7RRg5k=;
        b=Y8lKGfODiCH69PDF5B/+rpXL+KjApYk7Uwv8d7TW4/tBPWIRzzbi8MlNs0lgzM9hUA
         24xdsrYMFvCtK6M14TEO9ufqFEUZyUmF7u7s96e3sOwuy+UVYB4S0yx9V5+9sE0TTsfd
         IXR2ZuOpdoWZucP+43oYiGInuo7RTGa+WTm/s+hBcRwZPq2VuKi9yodj0lcEAJSkK53a
         y4B5qKPAJ49xq+wQw24RR55Hm1r3sJ9RTK87APxuU44mtsvQueWlGAjMWZ86HA7WsxXz
         9LxhsNeXas/TjWNR3OA8HzqsqV1njMtHL+i9+Gthr7VQw8et6WosGrnGcz509ucqbACW
         wnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UBFxrt4pNJbQqfKhET/4plBmEv6gpLPjB+6J7RRg5k=;
        b=DBLUFNE6T2Jdet41m9ZXddGhzxDwBAp3umHHTa3spx70Z7dBWpUQCv9DJAs0g3W/L4
         nn4C6Nr71xbQpOJYPZJTGYMqL/nnWlsyudfGcSL1wX04I3esWYUs6VINQGw6ipjJtwyv
         Gs9NaLEskguPgw2a1L+DxoAm0axVKXH7KEqU+JSkjGFeMJi7AS/fxkvyV0DWzObOnir6
         FXX6bJ+Eh7n7t1f4dBBsHahJdo625SmzAUrQ8+bzRa4hGVOuM8n/t1YUDPBKqLY5JHjv
         bCJdsPSUNjfzmvEhIdmkk5Pi5MqIHAQO0/ajTpGDd3Z3lhHzKYvPbAcywrwWNQRYAZco
         EuMA==
X-Gm-Message-State: AOAM532V4jZZN2KvhONsXLFYvXLXQhqurIYREzLbtFJK0+RUCF6Iehx+
        gWN1d6Gfo8WnSe7nrPnVpzriDuLA8f8=
X-Google-Smtp-Source: ABdhPJy344HqXVu0ud6H52mg8U/EcQXRq9AwgZAuxUTo1u0ex5Qpvg/3IucFIPXhG+x/kepE10JdnQtEHu8=
X-Received: by 2002:a17:90b:4c12:: with SMTP id na18mr2174906pjb.0.1594950349133;
 Thu, 16 Jul 2020 18:45:49 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:45:36 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-4-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 3/7] iomap: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up iomap direct I/O with the fscrypt additions for direct I/O,
and set bio crypt contexts on bios when appropriate.

Make iomap_dio_bio_actor() call fscrypt_limit_io_pages() to ensure that
DUNs remain contiguous within a bio, since it works directly with logical
ranges and can't call fscrypt_mergeable_bio() on each page.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..4507dc16dbe5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
@@ -183,11 +184,14 @@ static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
+	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 	bio->bi_private = dio;
@@ -253,6 +257,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		ret = nr_pages;
 		goto out;
 	}
+	nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
 
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
@@ -270,6 +275,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
@@ -307,6 +314,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
-- 
2.28.0.rc0.105.gf9edc3c819-goog

