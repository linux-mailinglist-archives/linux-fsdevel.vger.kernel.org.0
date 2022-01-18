Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CFF492001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiARHUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244820AbiARHUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:20:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3AC061574;
        Mon, 17 Jan 2022 23:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f2brK3c1r//byFNtb7H+AigJJebcgGaABpKjDxFp+eg=; b=u24yUmqxGf8p+pGDi/NFrHE6oM
        tiw9ctFdhfoYibfXwKUv3fIcDXOsDIFrGfOv4Px/yVVx5O3fJemb3jHK0ChVy2Zxxdw2O6vKLCjAu
        vWPIJnLQVQWOcBFRlCPyeoMNOO+Q4CVRU5MshJ99sGKuBHaPT4SgFnhjNMaD7dJRzew884XXg2d9u
        Z3KM/jwMW5XPRrVcvPhZ9TybnvF7+PrdUAiM57Ba/ijIX/UdOixiz9iNq2ll6gZU0zcT5QK/+NTDA
        13wiEXXo+DkO28tZczO8n6Z7sN3wC80auX/loORY0ucWpLjKoQNWoO0hfZJinRZxFQ+vnhVO9NB8D
        +pBCOQ6A==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9in0-000ZXZ-GY; Tue, 18 Jan 2022 07:20:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 10/19] rnbd-srv: simplify bio mapping in process_rdma
Date:   Tue, 18 Jan 2022 08:19:43 +0100
Message-Id: <20220118071952.1243143-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memory mapped in process_rdma is contiguous, so there is no need
to loop over bio_add_page.  Remove rnbd_bio_map_kern and just open code
the bio allocation and mapping in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 57 -------------------------------
 drivers/block/rnbd/rnbd-srv-dev.h |  5 ---
 drivers/block/rnbd/rnbd-srv.c     | 20 ++++++++---
 3 files changed, 15 insertions(+), 67 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
index b241a099aeae2..98d3e591a0885 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -44,60 +44,3 @@ void rnbd_dev_close(struct rnbd_dev *dev)
 	blkdev_put(dev->bdev, dev->blk_open_flags);
 	kfree(dev);
 }
-
-void rnbd_dev_bi_end_io(struct bio *bio)
-{
-	struct rnbd_dev_blk_io *io = bio->bi_private;
-
-	rnbd_endio(io->priv, blk_status_to_errno(bio->bi_status));
-	bio_put(bio);
-}
-
-/**
- *	rnbd_bio_map_kern	-	map kernel address into bio
- *	@data: pointer to buffer to map
- *	@bs: bio_set to use.
- *	@len: length in bytes
- *	@gfp_mask: allocation flags for bio allocation
- *
- *	Map the kernel address into a bio suitable for io to a block
- *	device. Returns an error pointer in case of error.
- */
-struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
-			      unsigned int len, gfp_t gfp_mask)
-{
-	unsigned long kaddr = (unsigned long)data;
-	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	unsigned long start = kaddr >> PAGE_SHIFT;
-	const int nr_pages = end - start;
-	int offset, i;
-	struct bio *bio;
-
-	bio = bio_alloc_bioset(gfp_mask, nr_pages, bs);
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
-
-	offset = offset_in_page(kaddr);
-	for (i = 0; i < nr_pages; i++) {
-		unsigned int bytes = PAGE_SIZE - offset;
-
-		if (len <= 0)
-			break;
-
-		if (bytes > len)
-			bytes = len;
-
-		if (bio_add_page(bio, virt_to_page(data), bytes,
-				    offset) < bytes) {
-			/* we don't support partial mappings */
-			bio_put(bio);
-			return ERR_PTR(-EINVAL);
-		}
-
-		data += bytes;
-		len -= bytes;
-		offset = 0;
-	}
-
-	return bio;
-}
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 0eb23850afb95..1a14ece0be726 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -41,11 +41,6 @@ void rnbd_dev_close(struct rnbd_dev *dev);
 
 void rnbd_endio(void *priv, int error);
 
-void rnbd_dev_bi_end_io(struct bio *bio);
-
-struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
-			      unsigned int len, gfp_t gfp_mask);
-
 static inline int rnbd_dev_get_max_segs(const struct rnbd_dev *dev)
 {
 	return queue_max_segments(bdev_get_queue(dev->bdev));
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1ee808fc600cf..65c670e96075b 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -114,6 +114,14 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 	return sess_dev;
 }
 
+static void rnbd_dev_bi_end_io(struct bio *bio)
+{
+	struct rnbd_dev_blk_io *io = bio->bi_private;
+
+	rnbd_endio(io->priv, blk_status_to_errno(bio->bi_status));
+	bio_put(bio);
+}
+
 static int process_rdma(struct rnbd_srv_session *srv_sess,
 			struct rtrs_srv_op *id, void *data, u32 datalen,
 			const void *usr, size_t usrlen)
@@ -144,11 +152,11 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	/* Generate bio with pages pointing to the rdma buffer */
-	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
-	if (IS_ERR(bio)) {
-		err = PTR_ERR(bio);
-		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %d\n", err);
+	bio = bio_alloc_bioset(GFP_KERNEL, 1, sess_dev->rnbd_dev->ibd_bio_set);
+	if (bio_add_page(bio, virt_to_page(data), datalen,
+			offset_in_page(data))) {
+		rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
+		err = -EINVAL;
 		goto sess_dev_put;
 	}
 
@@ -170,6 +178,8 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 
 	return 0;
 
+bio_put:
+	bio_put(bio);
 sess_dev_put:
 	rnbd_put_sess_dev(sess_dev);
 err:
-- 
2.30.2

