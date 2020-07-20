Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E280227310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGTXhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgGTXhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:37:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29264C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x184so23547995ybx.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t24CFwj7eZURk4UC7tWBzhFCIdKtl5EAgLElefYpFNE=;
        b=GaSqESuQmG/FX3ZRcGOFu7fgGXrhxJFfKAhlwNTUj+EUo/QWtj1/gnsPkrnngQvj5V
         OCaCL4Arakh0xG2ANKdDLEK2Kr0jXfkjA314DNINIOX7PyCSqNdOENOjVR3HN4kRjoTe
         Ckb8M7zLSVBcNHHxkf0XEdBL3nyZUKDzbqsLy0nsi6qh9y4LiUD8gKQa0XiXwgNz/Cyr
         fM27fuLxzicL36J0NF1SZe8k2UzcoOG29PR0pMRcty8QEHHb0WlG2udOwmaG1Jnx/tIS
         xZsKBL0sO++BgwCN9/MpdLVM1BnHyGGslEvZ9vYx2BvrQsD1+skFNa+WEdXaeXOVsjEy
         Qucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t24CFwj7eZURk4UC7tWBzhFCIdKtl5EAgLElefYpFNE=;
        b=rqK0sbHEQnnAwvL0fFmlZwCgs6bvLnK4N2qpb6tCpbVbOJWIdqefY4yjK8av8Z/hZ6
         Z5zCFumbegxMgQbcJ56jZbUFaPx3qMCkl+Ha9XD1ASlGzIIY3Zp3paQ0d5OCn2VV7D0K
         EVBM/8mgsEPg6KGCgE/0APKO54m6LIBvhYE1+mi7ne2mgfhzHN04blkmbqc3JvXd61Hx
         XX/0Avq0Htyz2EGmxWbhspRIfhW/pp9LymuJqPJMBDT1Y766Ug+rEzHBk55tiU5qOq4D
         Y6qoZF/DWZROj3BB/a9CuZ2HSkRfY6l8Q6OKifT1H4EngZz024FshX2q6L+adgu/ujsR
         meQA==
X-Gm-Message-State: AOAM530BacJyCvReGVk4Eft4gdgtTdvZN2keB6GK2ZkWDJCvbLWTO8RA
        l0ALidzO2MmfAyNDwgqyUTLjmdUIm/0=
X-Google-Smtp-Source: ABdhPJwDsMMJwPLHK9Bp+Cwu9CfcdZpjyQWJiHRkZx1avD2YLM3cw3lkr8Pd/tl4V7GYFevYfYj6wMk5AGY=
X-Received: by 2002:a25:a441:: with SMTP id f59mr37237298ybi.412.1595288267387;
 Mon, 20 Jul 2020 16:37:47 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:37:35 +0000
In-Reply-To: <20200720233739.824943-1-satyat@google.com>
Message-Id: <20200720233739.824943-4-satyat@google.com>
Mime-Version: 1.0
References: <20200720233739.824943-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using blk-crypto
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

Wire up iomap direct I/O with the fscrypt additions for direct I/O.
This allows ext4 to support direct I/O on encrypted files when inline
encryption is enabled.

This change consists of two parts:

- Set a bio_crypt_ctx on bios for encrypted files, so that the file
  contents get encrypted (or decrypted).

- Ensure that encryption data unit numbers (DUNs) are contiguous within
  each bio.  Use the new function fscrypt_limit_io_pages() for this,
  since the iomap code works directly with logical ranges and thus
  doesn't have a chance to call fscrypt_mergeable_bio() on each page.

Note that fscrypt_limit_io_pages() is normally a no-op, as normally the
DUNs simply increment along with the logical blocks.  But it's needed to
handle an edge case in one of the fscrypt IV generation methods.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..12064daa3e3d 100644
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
@@ -183,11 +184,16 @@ static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
+	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
+
+	/* encrypted direct I/O is guaranteed to be fs-block aligned */
+	WARN_ON_ONCE(fscrypt_needs_contents_encryption(inode));
+
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 	bio->bi_private = dio;
@@ -253,6 +259,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		ret = nr_pages;
 		goto out;
 	}
+	nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
 
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
@@ -270,6 +277,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
@@ -306,9 +315,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		dio->size += n;
 		copied += n;
 
-		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
+		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
 	} while (nr_pages);
 
 	/*
-- 
2.28.0.rc0.105.gf9edc3c819-goog

