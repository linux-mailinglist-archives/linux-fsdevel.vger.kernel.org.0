Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42F494814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358978AbiATHQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41220 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358940AbiATHQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6C53CE1BF4;
        Thu, 20 Jan 2022 07:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9082C340EA;
        Thu, 20 Jan 2022 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642662975;
        bh=XFRJyq9JwA9XPF4vR5ySTRSqsenmdAT9W838NjzwtMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgNVR2Z3+6Ee+qaX0ZbXbjAKDC07UhzIqb3SGXNLadLSv5hhejusWthRe4qnTC3k5
         Z/W7M97ZR/sdHMLYagSBimRYJ21iEwxtLQsjhE7h3SgTZb8vvoOLraHWyf9fu9c7CK
         NeuXH/yUGskmKxdRSxjXF2IH4MlfWQbv51/fh8HodUP0Q0Dy7kHc6FFgAA0oXWWej6
         mKhBol/dHRJzXePgQEAAI7MTAr3l2WzGuBykz4FjODp/dssy8J4psT0Asl7w9iIy8k
         tfORdcwRHeGQTQNN9cFhqAg9+NEACVxUYFfk7rqAJ1dKMV8XiGbHXrXjdu5EYeliLo
         JR613w5Npkc/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v10 2/5] iomap: support direct I/O with fscrypt using blk-crypto
Date:   Wed, 19 Jan 2022 23:12:12 -0800
Message-Id: <20220120071215.123274-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120071215.123274-1-ebiggers@kernel.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Encrypted files traditionally haven't supported DIO, due to the need to
encrypt/decrypt the data.  However, when the encryption is implemented
using inline encryption (blk-crypto) instead of the traditional
filesystem-layer encryption, it is straightforward to support DIO.

Add support for this to the iomap DIO implementation by calling
fscrypt_set_bio_crypt_ctx() to set encryption contexts on the bios.

Don't check for the rare case where a DUN (crypto data unit number)
discontiguity creates a boundary that bios must not cross.  Instead,
filesystems are expected to handle this in ->iomap_begin() by limiting
the length of the mapping so that iomap doesn't have to worry about it.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/iomap/direct-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 03ea367df19a4..20325b3926fa3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/pagemap.h>
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
@@ -179,11 +180,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
+	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, iter->iomap.bdev);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
@@ -310,6 +314,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
-- 
2.34.1

