Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889A537BDDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhELNR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhELNRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35348C06174A;
        Wed, 12 May 2021 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QV8H2JiB9CJxNbpu7PfrVC25LYjNfXKcBsDwiceEXG4=; b=vNnu39MxIFh6qMDlw8iUkG7nhj
        695SgCuuvvD6ERwCv/EV4PGHfop1hj7bSzU7+nEFaILxV/CH5tNTuCaldGGNTrcim3ibY+vk3ZSPF
        w3v1zIhyPGypvvyx4Yu+7k4KX6hwcLGpsAmErIbTuoIC8WQbyVLu2W+l/TXUOwJqvBmbG1Bom9qGr
        2sC2fkSfDmtPwynoYAN2ItbITkJwVLrfwpXXVCnuavEr4ZdHv5+manUk5GoDzH5Ll1ql6gMeLE3cz
        tHITGyBUw126Jh01JnpKjyKGz4bQS/e9y4xSFc/HQ0aut11k43+OdOoDahMh7X6emjOYR+SFsB8Tv
        NBwqWWJQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoiR-00AO1x-Ik; Wed, 12 May 2021 13:15:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 03/15] iomap: don't try to poll multi-bio I/Os in __iomap_dio_rw
Date:   Wed, 12 May 2021 15:15:33 +0200
Message-Id: <20210512131545.495160-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an iocb is split into multiple bios we can't poll for both.  So don't
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..d5637f467109 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -282,6 +282,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	if (!iov_iter_count(dio->submit.iter))
 		goto out;
 
+	/*
+	 * We can only poll for single bio I/Os.
+	 */
+	if (need_zeroout ||
+	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
+		dio->iocb->ki_flags &= ~IOCB_HIPRI;
+
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
@@ -339,6 +346,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
 						 BIO_MAX_VECS);
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		if (nr_pages)
+			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
@@ -579,6 +591,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iov_iter_revert(iter, pos - dio->i_size);
 			break;
 		}
+
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		iocb->ki_flags &= ~IOCB_HIPRI;
 	} while ((count = iov_iter_count(iter)) > 0);
 	blk_finish_plug(&plug);
 
-- 
2.30.2

