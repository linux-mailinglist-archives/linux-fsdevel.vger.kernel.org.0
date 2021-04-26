Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0747836B451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhDZNzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:55:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF499C061574;
        Mon, 26 Apr 2021 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9SbBr1by35FoFBLhYEbZYkU7Qe9kHfjLM/wxBmc4fMU=; b=iLSCWaK8Wwfyn7WlfSKQgOcgof
        96hTkCTJIPHEbAJKO0ndEVPZbTR8cNrjSz0WX0qGuT958ldWmEAC9djhwQPdyn4RLzPDG7E8cBt+z
        OQGNaEgd3lOqTqyNJdcq0zzbOK8Bl+olMP7MO8xNzIyLYa5rTbfCXcxWNQNEY4vAlg9wfMeqrgrh4
        J6C2VUeRNMaGTkteEWT/v8ie2XIveauvmMuxvbKSN39X8z/8iVQRrB1EWscNGi29SO1Ue6prnU4O8
        qcgrSS6rKJBe2VeK/8eRnkCZ86j0sJdKx4EzF72CwmZtrC6e6+Zp9LRrQ+64XPF5NofcqkFRSzQfp
        WBlu9VCg==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hW-00FznZ-Uz; Mon, 26 Apr 2021 13:55:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] iomap: don't try to poll multi-bio I/Os in __iomap_dio_rw
Date:   Mon, 26 Apr 2021 15:48:12 +0200
Message-Id: <20210426134821.2191160-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
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
index bdd0d89bbf0a..357419f39654 100644
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
@@ -571,6 +583,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
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
2.30.1

