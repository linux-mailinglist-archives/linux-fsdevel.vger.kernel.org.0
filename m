Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191AA497B64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiAXJLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiAXJLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:11:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779A4C061744;
        Mon, 24 Jan 2022 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zt4z0CCqxTu0ALe3IrRHpwIG3ETXoc3mZtIYo6QdQDM=; b=s3e61xH669mdB88dsM0ako/6hm
        YsdPOFv/+9bUrCprVe09zHwO1lKRo1xqZckfy+k3aI4O7evk+RiB0/o5y50HMgqybj6V8nydnHaqX
        mtMq31ULR3tuFniaKuzrkBKWQ9GLcEOIxcmh7CseGdVBvrlGNE+yQfMA1Ozavs6cDairUaII9NR8y
        ph4Ax4aY8fmmukVLpqEVBHr+JV24FvfuqKG6PehkdijYQ2882QgOVHZuvUklnkTyQ1NRkwXensI+H
        fb2buJqmJs6jYMIPQO5OmkHhgR28rV4GqNdGzaVKM7k+in5ebCQTHOLDzcJGZZNvSIJF2PMIzPxhK
        4yVDZYeA==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvNu-002kBG-B5; Mon, 24 Jan 2022 09:11:34 +0000
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
Subject: [PATCH 09/19] drbd: bio_alloc can't fail if it is allow to sleep
Date:   Mon, 24 Jan 2022 10:10:57 +0100
Message-Id: <20220124091107.642561-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124091107.642561-1-hch@lst.de>
References: <20220124091107.642561-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove handling of NULL returns from sleeping bio_alloc calls given that
those can't fail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_receiver.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6df2539e215ba..fb59b263deeef 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1281,14 +1281,13 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 {
 	struct bio *bio = bio_alloc(GFP_NOIO, 0);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
-	if (!bio || !octx) {
-		drbd_warn(device, "Could not allocate a bio, CANNOT ISSUE FLUSH\n");
+
+	if (!octx) {
+		drbd_warn(device, "Could not allocate a octx, CANNOT ISSUE FLUSH\n");
 		/* FIXME: what else can I do now?  disconnecting or detaching
 		 * really does not help to improve the state of the world, either.
 		 */
-		kfree(octx);
-		if (bio)
-			bio_put(bio);
+		bio_put(bio);
 
 		ctx->error = -ENOMEM;
 		put_ldev(device);
@@ -1646,7 +1645,6 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	unsigned data_size = peer_req->i.size;
 	unsigned n_bios = 0;
 	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
-	int err = -ENOMEM;
 
 	/* TRIM/DISCARD: for now, always use the helper function
 	 * blkdev_issue_zeroout(..., discard=true).
@@ -1688,10 +1686,6 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 */
 next_bio:
 	bio = bio_alloc(GFP_NOIO, nr_pages);
-	if (!bio) {
-		drbd_err(device, "submit_ee: Allocation of a bio failed (nr_pages=%u)\n", nr_pages);
-		goto fail;
-	}
 	/* > peer_req->i.sector, unless this is the first bio */
 	bio->bi_iter.bi_sector = sector;
 	bio_set_dev(bio, device->ldev->backing_bdev);
@@ -1726,14 +1720,6 @@ int drbd_submit_peer_request(struct drbd_device *device,
 		drbd_submit_bio_noacct(device, fault_type, bio);
 	} while (bios);
 	return 0;
-
-fail:
-	while (bios) {
-		bio = bios;
-		bios = bios->bi_next;
-		bio_put(bio);
-	}
-	return err;
 }
 
 static void drbd_remove_epoch_entry_interval(struct drbd_device *device,
-- 
2.30.2

