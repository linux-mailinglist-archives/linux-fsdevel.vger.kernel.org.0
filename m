Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0369422730F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 01:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGTXhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgGTXhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:37:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE3EC0619D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e81so23423635ybb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zp9IyNE/WOqMjmmUo5OQb7An9Jck4EABFW2ZtXIp0J8=;
        b=se5eGY6PRRXqrWQRBE/mzCAA5RErc7l2kj05TDRN7Jro80qb/pJ+rA+riJ/Xykv7F9
         NQ5EcWcqex+EPU0AL0qs5tmsavm6jy7rKVphM1+zpocIAHdvARYAtIGgDy3GBqqpd3xa
         aBmkNWC1mgTceW2cH+pPKpVnviueK1DVlwESp8gXuDHR4UQLn8uHTruCGCPv/BvQRicd
         S1LlPhpAkgsAFimnUYIYUdsCrDJG80+1qUF4CXWZjigFnFEbVHUyzLf9Uk5tjRgFKYhx
         TaA9J/wV992TQY5EbqsiWdVrqMzJkVUO70+qXkefnqGr+h4AZ2vo+qBrDjxey9sz1bqD
         7tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zp9IyNE/WOqMjmmUo5OQb7An9Jck4EABFW2ZtXIp0J8=;
        b=oZMG2bK8pmjrEarRY2oxboOoqS2QKJFney460/XnQk6YrGxPGOSYWZsRDRSeX7VkbH
         MY9mvmfQy9IOAQmk6E8IfsfDhvCiZYVPpSA2KQyC9hjRbnmy4uug0TMPaqWe1T9MFtrz
         p9lAWQIBQ6pzUlRu7ihmzV/ObjpZ8X9kAdDQSSpI4alC0ZXz0aZTE9IpmUxwVawAvEgW
         ERjOH9vX/+y4BIvTj66HOGJ7R54K+BecfiTHG3x22SFx3wqtSCssb2bXE4rEyD2Khcy+
         0UkG8xqA4lb1y0Dg4EH8bJTGvrrZxlmCPudq82M77Oz0HnSfEgx/XP55pqPidozw2ksb
         IYPg==
X-Gm-Message-State: AOAM532Rs4jZXZ5lcW/O/H47prhOo660BVc3Vzw38+uTntiIDcqZYOa8
        xJZxEYALq64x+t7UZviozJ95jWBeUoE=
X-Google-Smtp-Source: ABdhPJyKficGk3ieKw3vV0YvwmGNGBZ7vrBM2X1BKiz+4fP3nNViUcmmhhj708RT1qDOLsOq29xR99aneog=
X-Received: by 2002:a25:6dd5:: with SMTP id i204mr8527687ybc.319.1595288265808;
 Mon, 20 Jul 2020 16:37:45 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:37:34 +0000
In-Reply-To: <20200720233739.824943-1-satyat@google.com>
Message-Id: <20200720233739.824943-3-satyat@google.com>
Mime-Version: 1.0
References: <20200720233739.824943-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v4 2/7] direct-io: add support for fscrypt using blk-crypto
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

Set bio crypt contexts on bios by calling into fscrypt when required,
and explicitly check for DUN continuity when adding pages to the bio.
(While DUN continuity is usually implied by logical block contiguity,
this is not the case when using certain fscrypt IV generation methods
like IV_INO_LBLK_32).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
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
2.28.0.rc0.105.gf9edc3c819-goog

