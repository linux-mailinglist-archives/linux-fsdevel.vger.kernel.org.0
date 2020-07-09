Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E614121A834
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGITyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgGITsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:48:01 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A04C08E85B
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 12:48:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t12so2310629pju.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F8Vh+2Oj0e1Bz4p4CaEpLpu89IEB8oilLTMr2JnBHtA=;
        b=n/XchN266fqGBoCIT70QRrbSKL8BhsIGh3atkfrL+0wfDq/ITuCBBAwQFiwD29zrHo
         RjO2JizNIiO3Rvwi0LtaaItm6GvUOons1saevQ9aIy9GCDsecu+O5x3aZvIqzhIwt6Ap
         jwBA+lkwIT8AlS4+zuBI2BDea413RQdLMek8QcT8+eMzDoxlqYty2NGOEtoAgG3ViD5k
         uLRAbg36Cjuz6m/+QQmmfQPX3S/WRrOaid2M3uJ0/+vad0TZ6VHnsBsCgxr4A4AoOHK0
         omL+w4IbITj0XhF1IO0CaTO2QXaxuLEqIMNw+IgjiorB+/s2cF9r9dCip0/PmtPIZn/l
         w6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F8Vh+2Oj0e1Bz4p4CaEpLpu89IEB8oilLTMr2JnBHtA=;
        b=cEczMKCz61QKl4AWvc7r/ZDsGSYHP4IwEgM1HA0Fh4Oh+ENm8og9WNR1Ykq1/AX4Qq
         CPu+wfOg+grYvyb3zpTa4B0EAlavTzbsgs6Ri+stSfh/wHehS09es8t8+WpXGzwmE1Ju
         6WwBEGAqXyDhN+rqbzrnG70O6XLRmlRECyxxrcDjxZkSS0YRb4JIfbenm9XtmM9zfUGG
         RH5O1LX0M7q5GdickktcqDChzvCgjBJsVmg5Os4IBuzKwR1MNZY9m9K9S5n8iL2oSTdb
         32l2UqtJRrGvZtyYXlwS3OHXVzKXJtvvz3vGlyT5vtWdW1oMiK8zbdt+rDg3pK1qUwCz
         Zoiw==
X-Gm-Message-State: AOAM532fdWO1bFK6eigNlvkj5i5eWAMwgv1WIvY/aBa6JzPbv1QAsOJ3
        rGvzgjqJlDSuG9pM5wOuOXjSLK6Pv5U=
X-Google-Smtp-Source: ABdhPJwgF0eduoVEqL+5EnB4NT5k175DYmVz+vnVdiaT3ayIkgmltIZBeFIoEPNUTNM+7geNefWVH9TuAAQ=
X-Received: by 2002:a17:902:a50c:: with SMTP id s12mr41269918plq.119.1594324080790;
 Thu, 09 Jul 2020 12:48:00 -0700 (PDT)
Date:   Thu,  9 Jul 2020 19:47:49 +0000
In-Reply-To: <20200709194751.2579207-1-satyat@google.com>
Message-Id: <20200709194751.2579207-4-satyat@google.com>
Mime-Version: 1.0
References: <20200709194751.2579207-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 3/5] iomap: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up iomap direct I/O with the fscrypt additions for direct I/O,
and set bio crypt contexts on bios when appropriate.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..1e123d785199 100644
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
+	nr_pages = fscrypt_limit_dio_pages(inode, pos, nr_pages);
 
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
+		nr_pages = fscrypt_limit_dio_pages(inode, pos, nr_pages);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
-- 
2.27.0.383.g050319c2ae-goog

