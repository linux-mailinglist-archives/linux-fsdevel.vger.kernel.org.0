Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1925A223078
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGQBfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGQBfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:35:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DBC08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:35:31 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id h93so6676053pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+UBFxrt4pNJbQqfKhET/4plBmEv6gpLPjB+6J7RRg5k=;
        b=S9hUMdztXXvOY4ssFaJ9x50x8aFoXJPR1Ord6CgvNBpR6vnJ1HcxEp+eSdaGY2wu49
         f3fn0Te4kWifwbc6OZ2yWU1j5vyM+/dIh9NQBMQelj7AihRRtRxZWdcI+Qm/qQb+JSZ1
         4vatdj6y/6H9IPDw31RFvJBnXZAEWZbrTIeQ4n+CYYf5Ls9iTkaDeHulKw5UxKN3y0t7
         zfn3cXRsUyUuNwYuMX4HUH1SILLzTcAjK5hnXBz6/fju1dXdZTfC0wUHMfBLejmNNWiV
         2zSjQ0QinEPAhWayJplF9JFzkA1NeMZT/PHLH5AVbbg/wAeJA+k9Fp7jqWMsVvb0ahs1
         nmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UBFxrt4pNJbQqfKhET/4plBmEv6gpLPjB+6J7RRg5k=;
        b=obAe8cpgzDXh80x1Jfd7X8vPHH3c2lSA0db1QFYcLNkdT7FalE0J7LUMFPaI2QXyyX
         UyiZF9m3MKnvZM7gjq1t6SsGgQH2W1myE5CfVHhOkymBDqYYp0GChpsZ51U0/rpIt8ha
         BXOHyJFP31aNao9CakxIUCpDnzh4GauoqptKrwCoO/BGGQ9aPDtb3mq1wRRfy+U2fyKn
         3Xk0KNaUW13Bw07xwQQ/2bzMv3yLyzD3VV7XfUkYGYyUgUpVWacalUCluOp+KFJsqOmS
         2hcpsZehkA2TAEi6x5bfEW+nhwiexLlVjq5jswk3u3V8yuprMR4ZjFU5cF+SfWH3SQZl
         R8DQ==
X-Gm-Message-State: AOAM533ULppv9Qo31K7kdn0WvqCqRwohjqBl1GLijR6Z/QRgdZPAElVs
        +08cVuwMdwPN1oW5JHmIR8yBqs3J7kM=
X-Google-Smtp-Source: ABdhPJyUKbNKbPD52mHlMT2ZSrU8LempwbQ8BXLBZXihRGAVepOXrVcw0EfQ5Li0VQYXBx83T3iUPhq+8QI=
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr2171526pjz.1.1594949730708;
 Thu, 16 Jul 2020 18:35:30 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:35:14 +0000
In-Reply-To: <20200717013518.59219-1-satyat@google.com>
Message-Id: <20200717013518.59219-4-satyat@google.com>
Mime-Version: 1.0
References: <20200717013518.59219-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2 3/7] iomap: support direct I/O with fscrypt using blk-crypto
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

