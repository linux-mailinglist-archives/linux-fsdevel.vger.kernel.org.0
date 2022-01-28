Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFEC4A0463
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351800AbiA1XkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 18:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiA1XkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:40:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6405AC06173B;
        Fri, 28 Jan 2022 15:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F08BB8272E;
        Fri, 28 Jan 2022 23:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD01C340EF;
        Fri, 28 Jan 2022 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413202;
        bh=nHFxT7m7n/PO9ZU3JSReFnLKGQ9T4BVIVZVRwmNnf2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fj+13BS78mdCrmo5S6M/b382/MAfnkitlX3HyZoWmg4D+9S0x/95C5cct4w4L9zBW
         VjsPvxInYpZiwtX4aOKrk/DlSBmvh6e4WBo34Pdv1quVkpRO1NW/F7WTht7toJ+SoG
         IsWT0ATowuzfE57mX9sMPlYEQaGPf3HDehY7aecPAI93s3dtWaVQPd1vbJCa8uhglS
         nufOl+TZz3h/qsbsVyjEBWtnDXq2teEP/DMidl5gsMnWNaCEG24rXCxMzWNLHn1DPN
         8os7U5SMIGS1+SJu5EgxfDU+HQS7FnKhlNduWLwTVnCzBNZdQghd1dWynd4il7K2T2
         BXrL26K8jIJ+g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v11 2/5] iomap: support direct I/O with fscrypt using blk-crypto
Date:   Fri, 28 Jan 2022 15:39:37 -0800
Message-Id: <20220128233940.79464-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128233940.79464-1-ebiggers@kernel.org>
References: <20220128233940.79464-1-ebiggers@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
2.35.0

