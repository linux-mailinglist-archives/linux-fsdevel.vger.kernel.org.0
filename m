Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43644BFD5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiBVPrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 10:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBVPrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:47:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E520184;
        Tue, 22 Feb 2022 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sd9RxJShPGiAFRICO73ZkjFAfnS+ztcq1MfxJ2y9BeM=; b=eiFrWaVPt5ZxRL5mRXxJlrXxZN
        AtUo1z+jidH2+odsHyo1urmrJ6GQPMjkJ0fn4aDuvs883+kOmYRsRxwUdQuQvOwCIgkXPP23LWCNT
        TwwAXu6Pdk2xIzqIH5Bjejr4s6wdBp5w4Fk6sBTE0AvP+1zmbyUfk6UJnZE2ReTvQfjZz7Hf4wCuL
        6gbDDg8JUYora+UTNAYZSvU89KaMrj2LIFtbGZi242pXwbAllNPTiLx5Up7fGExDpdMoNvpVNfx2/
        5JV+EJve3iRsb7qYfv1Y6/sQcEX1tX2I/jaSUhlVbQVtafSFZ+4WB26VFnAnqsdSfXsYA0k77IE3J
        NDqPrulw==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXNB-00ANZd-Uv; Tue, 22 Feb 2022 15:46:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 2/3] ext4: pass the operation to bio_alloc
Date:   Tue, 22 Feb 2022 16:46:33 +0100
Message-Id: <20220222154634.597067-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222154634.597067-1-hch@lst.de>
References: <20220222154634.597067-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor the readpage code to pass the op to bio_alloc instead of setting
it just before the submission.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/page-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 1253982268730..35ada7baf41e5 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -372,10 +372,9 @@ void ext4_io_submit(struct ext4_io_submit *io)
 	struct bio *bio = io->io_bio;
 
 	if (bio) {
-		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
-				  REQ_SYNC : 0;
+		if (io->io_wbc->sync_mode == WB_SYNC_ALL)
+			io->io_bio->bi_opf |= REQ_SYNC;
 		io->io_bio->bi_write_hint = io->io_end->inode->i_write_hint;
-		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
 		submit_bio(io->io_bio);
 	}
 	io->io_bio = NULL;
@@ -398,7 +397,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * bio_alloc will _always_ be able to allocate a bio if
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
-	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, 0, GFP_NOIO);
+	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
-- 
2.30.2

