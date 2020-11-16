Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1218B2B47C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgKPPAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbgKPO76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729EC0613CF;
        Mon, 16 Nov 2020 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x6ThtvQgvwHIscZfOUELeo3Uy7svW74ISAsOiTBJTd8=; b=wYjWzLfzQlz5nMoIrs2dUqAKes
        QFt+YLi/Ow0cGCkVgOnqteaZCNuUDwCov7PJB5hvC6nYp5cVF5aDTygDVep1VuFeVLzibRXVrb0PG
        FwRPx4XB6Y0FbjEFe92tnC6Dld2W5KJSeAc8kJg120u3mpOcZ4tc9ydP5qFtsdEWA6KBA1phfelhv
        ykkNgsnmusDbP9O5T8K6xNSTSx6pFYwqjKwfuv8O23V0jhAmUMdhinoTTyaCbb1UQNoqaNS8S8OhY
        IkQHzpe8v4SVvuc9YJmie1VvzG8FrG8PonETyiwJgsN7wW5Xu/ggXJWk0IApLZbQQsH5DPzic6AvO
        6QnJMDVw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyo-0004DN-O9; Mon, 16 Nov 2020 14:59:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 64/78] dm: simplify flush_bio initialization in __send_empty_flush
Date:   Mon, 16 Nov 2020 15:57:55 +0100
Message-Id: <20201116145809.410558-65-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't really need the struct block_device to initialize a bio.  So
switch from using bio_set_dev to manually setting up bi_disk (bi_partno
will always be zero and has been cleared by bio_init already).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 54739f1b579bc8..6d7eb72d41f9ea 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1422,18 +1422,12 @@ static int __send_empty_flush(struct clone_info *ci)
 	 */
 	bio_init(&flush_bio, NULL, 0);
 	flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
+	flush_bio.bi_disk = ci->io->md->disk;
+	bio_associate_blkg(&flush_bio);
+
 	ci->bio = &flush_bio;
 	ci->sector_count = 0;
 
-	/*
-	 * Empty flush uses a statically initialized bio, as the base for
-	 * cloning.  However, blkg association requires that a bdev is
-	 * associated with a gendisk, which doesn't happen until the bdev is
-	 * opened.  So, blkg association is done at issue time of the flush
-	 * rather than when the device is created in alloc_dev().
-	 */
-	bio_set_dev(ci->bio, ci->io->md->bdev);
-
 	BUG_ON(bio_has_data(ci->bio));
 	while ((ti = dm_table_get_target(ci->map, target_nr++)))
 		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
-- 
2.29.2

