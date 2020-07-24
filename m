Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7956922C4D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGXMM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgGXML5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:11:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB977C0619E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:11:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id fr7so5877124pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=;
        b=KoB83sJ7CUVdLVzAAXXB1d5HIww3b9w4WXANf6RJDhlArPSiHhTK/PK8WuhB2tEWdE
         kCcFKQn/yySmnkf4jT6de1v2OPxpX9sjJn+U5/tromL2TKBfU60c+bjV00XwXIrTLEu4
         8vI0PugTGuvm/QxFdiB0sqTcNW/MonZSsudP+hxmFGx4UuhVFhTp54Uxrhu5H9iG4l9R
         KkcujV6MJnRby0uWob+6hiQIuEJret9I5UCLvXr8+0CAJYPwHv6lDGhKsfT9uWS8Cli0
         18olVrcMqQGc8/lazYnAKA5yuqsfJKFeFrR+BYovE5b8eq9DSEwSvqm/zrJXl71JukyE
         b5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=;
        b=Pa/tcLwplEseNoHcZWHWqIGEh8lOCU8GSs1QXh+DlEZebvyMMlzDhmuu2zze6XSUrk
         P+jLy0TxM5JhpLQD0y+DQ+p15CrZBBoHiCnAM3kH1UYBjSn0Krv2KsDM00XHb6OYkTuc
         s6YRaGW2UyP9fFrPH8ccy+FyDBMMDDf4pwQE74j3bHk6rONr7lQLPOgiESsknfF+S7Iu
         t8b4rU70StBjmnjt3jWVaqZb6FcvV2zWiHRT+g4P5OjnxL6dCVBSMCi/WhP2GsPmL3uh
         J85MBGLBaPORAuNPQfzyO3782zV0S5e5TpkPUMJWqFZxcDIiZqrqwxO6zp1RGpnSc1+z
         Usog==
X-Gm-Message-State: AOAM530S6S7GGIPNhQFDJYjWBh6jw7pCBGy3LnQEhS19AU+qQPQJRZLT
        8uhGSmlTqxueI3og4nQm0k1c3I2ckuE=
X-Google-Smtp-Source: ABdhPJzqW0b3TqyL5cn0deoeV5HaYLyzoiAc0kf0C/GsHjnYYMOhspEGJ3mRFCHxl3UhNASvV8FA7vQBd2k=
X-Received: by 2002:a17:90b:f05:: with SMTP id br5mr5218030pjb.42.1595592714411;
 Fri, 24 Jul 2020 05:11:54 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:11:39 +0000
In-Reply-To: <20200724121143.1589121-1-satyat@google.com>
Message-Id: <20200724121143.1589121-4-satyat@google.com>
Mime-Version: 1.0
References: <20200724121143.1589121-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v5 3/7] iomap: support direct I/O with fscrypt using blk-crypto
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

Set bio crypt contexts on bios by calling into fscrypt when required.
No DUN contiguity checks are done - callers are expected to set up the
iomap correctly to ensure that each bio submitted by iomap will not have
blocks with incontiguous DUNs by calling fscrypt_limit_io_blocks()
appropriately.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..a8785bffdc7c 100644
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
@@ -270,6 +274,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
-- 
2.28.0.rc0.142.g3c755180ce-goog

