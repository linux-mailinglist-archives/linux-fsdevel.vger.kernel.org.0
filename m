Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87C321A838
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGITyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 15:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgGITsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:48:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFECC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 12:47:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m81so4127389ybf.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ypiy4fZMSHzKt5otJAVuZ4wRDcklaH0IoN6SqVj7WRE=;
        b=XSToy1Un+kanZIP/v7I36gilu8B8WWrWl9iO24C66p3jtXJiKaYdsyayZ1DDUtA8RR
         VjWimECct82y/QACP32b1OKg2j4nO6PH8dRrhvXaTUpYW7LqFORAfQuUQSELOVMEeX9+
         cRFRCr+eHO0opvt9lKdKzlMPg5NBfhW52yQ6Ytib5ylohaZ5FQjuBy0ZAh3JnopzzD6R
         4ZD6oa3W8S+TwWlZEOqU3Af3wfN811e60QYmu9DNPY2q1b5jUfVFHVuVdv43lzO4cahH
         Nr/6VPCIs+Dpz1Fxjr15ZWXbxDyZiyfA3UeVPLzA2zZbVhh0XDsOYm2ODMqmVBbRR70t
         0lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ypiy4fZMSHzKt5otJAVuZ4wRDcklaH0IoN6SqVj7WRE=;
        b=jRqWBisSO4btRv0FJlvgUEm2H4g8iYjFwN4dcO1YxbFnYlpsq7pBDNQl/wiXPpnnzQ
         +I2fjmmw4U21J03Hzzvwi1HQwLjIZXHId9U5ncYAt7EwzctlqsWp2G9HvwfHVCEj42Ix
         gklf81HtDAfGLj9ZV7MxMy4Wh5p0/mTNltb4bmACXBJTuFcOkgrPHyvFpe4A1hcFNawZ
         ZtNf+UU/+TeotuMHt+dUKYYIskEx6yojfD7BjeaC5dAJ2QiJZVlItboJeQ/kzCU2cieq
         nWXXvNzS0G0mWw9x90IPgV8d1LaKOVifkoc/0hiLHhMPH0BpxukFgKH9DTZA8ss9Yc3C
         jNTg==
X-Gm-Message-State: AOAM533WzgiQ1AXhGprlDoeuEyz9EiYa+vMXeoc9k5nYf0Y440n2lL9f
        x0rEAftp5T2QTLjoDH/LCY6+4y15bmM=
X-Google-Smtp-Source: ABdhPJwH95zt89pXB801EtQRqTBhoBOukmXpLUJNIbCr8au8pzQNgzGnXZYLrnCTro9o7o1SjhJQrRugcl8=
X-Received: by 2002:a25:56c3:: with SMTP id k186mr79785452ybb.183.1594324079089;
 Thu, 09 Jul 2020 12:47:59 -0700 (PDT)
Date:   Thu,  9 Jul 2020 19:47:48 +0000
In-Reply-To: <20200709194751.2579207-1-satyat@google.com>
Message-Id: <20200709194751.2579207-3-satyat@google.com>
Mime-Version: 1.0
References: <20200709194751.2579207-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 2/5] direct-io: add support for fscrypt using blk-crypto
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

Set bio crypt contexts on bios by calling into fscrypt when required,
and explicitly check for DUN continuity when adding pages to the bio.
(While DUN continuity is usually implied by logical block contiguity,
this is not the case when using certain fscrypt IV generation methods
like IV_INO_LBLK_32).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/direct-io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6d5370eac2a8..f27f7e3780ee 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -411,6 +412,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	      sector_t first_sector, int nr_vecs)
 {
 	struct bio *bio;
+	struct inode *inode = dio->inode;
 
 	/*
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
@@ -418,6 +420,9 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 */
 	bio = bio_alloc(GFP_KERNEL, nr_vecs);
 
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+				  sdio->cur_page_fs_offset >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_sector;
 	bio_set_op_attrs(bio, dio->op, dio->op_flags);
@@ -782,9 +787,17 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 		 * current logical offset in the file does not equal what would
 		 * be the next logical offset in the bio, submit the bio we
 		 * have.
+		 *
+		 * When fscrypt inline encryption is used, data unit number
+		 * (DUN) contiguity is also required.  Normally that's implied
+		 * by logical contiguity.  However, certain IV generation
+		 * methods (e.g. IV_INO_LBLK_32) don't guarantee it.  So, we
+		 * must explicitly check fscrypt_mergeable_bio() too.
 		 */
 		if (sdio->final_block_in_bio != sdio->cur_page_block ||
-		    cur_offset != bio_next_offset)
+		    cur_offset != bio_next_offset ||
+		    !fscrypt_mergeable_bio(sdio->bio, dio->inode,
+					   cur_offset >> dio->inode->i_blkbits))
 			dio_bio_submit(dio, sdio);
 	}
 
-- 
2.27.0.383.g050319c2ae-goog

