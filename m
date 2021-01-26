Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69F93041FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392691AbhAZPOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbhAZPOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:14:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC12C061A31;
        Tue, 26 Jan 2021 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jUX/nPv36iBJWdAHLrELJid7jXvEdNR6cRFF7NPxZ3A=; b=IpTioxravckm1qWlFlhuTXqcRU
        NUrQRXmnYaUUkiw+vad9k9lpdmMyYrpgXEgukSClL8PPJYRMAlC6PbXKGyHzkg4QgCq5ytPbIctU0
        Wu+AAg1vTUjodle4xRBeGFJxUuV90SjBomvdcXWoLsGxNckVxTg/NO0lV2QQg3NnOBl2C8ucoaGEh
        e1e0LT8AvFm3CKPyjDORVskFTIoraKd9UA3fA3R7jCx0mHdzlJoYhJv4fTxkNjiCdEnjZjfhVcdEP
        wpDTJ0dmomAG1DDIPybWzoJF6Nb0MGrzyoAKs8QVsymaQzhznpqBFzqeBp8JY+LKtIDBeAIgk0+OS
        j0VgL1sQ==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Pxm-005nbR-LQ; Tue, 26 Jan 2021 15:09:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/17] drbd: remove drbd_req_make_private_bio
Date:   Tue, 26 Jan 2021 15:52:40 +0100
Message-Id: <20210126145247.1964410-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Open code drbd_req_make_private_bio in the two callers to prepare
for further changes.  Also don't bother to initialize bi_next as the
bio code already does that that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_req.c    |  5 ++++-
 drivers/block/drbd/drbd_req.h    | 12 ------------
 drivers/block/drbd/drbd_worker.c |  5 ++++-
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index ea0f31ab334361..9dbb660a7d7c8e 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -30,7 +30,10 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 		return NULL;
 	memset(req, 0, sizeof(*req));
 
-	drbd_req_make_private_bio(req, bio_src);
+	req->private_bio = bio_clone_fast(bio_src, GFP_NOIO, &drbd_io_bio_set);
+	req->private_bio->bi_private = req;
+	req->private_bio->bi_end_io = drbd_request_endio;
+
 	req->rq_state = (bio_data_dir(bio_src) == WRITE ? RQ_WRITE : 0)
 		      | (bio_op(bio_src) == REQ_OP_WRITE_SAME ? RQ_WSAME : 0)
 		      | (bio_op(bio_src) == REQ_OP_WRITE_ZEROES ? RQ_ZEROES : 0)
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index 55bb0f8721faa3..511f39a08de453 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -256,18 +256,6 @@ enum drbd_req_state_bits {
 #define MR_WRITE       1
 #define MR_READ        2
 
-static inline void drbd_req_make_private_bio(struct drbd_request *req, struct bio *bio_src)
-{
-	struct bio *bio;
-	bio = bio_clone_fast(bio_src, GFP_NOIO, &drbd_io_bio_set);
-
-	req->private_bio = bio;
-
-	bio->bi_private  = req;
-	bio->bi_end_io   = drbd_request_endio;
-	bio->bi_next     = NULL;
-}
-
 /* Short lived temporary struct on the stack.
  * We could squirrel the error to be returned into
  * bio->bi_iter.bi_size, or similar. But that would be too ugly. */
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 02044ab7f767d5..64563bfdf0da02 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1523,8 +1523,11 @@ int w_restart_disk_io(struct drbd_work *w, int cancel)
 	if (bio_data_dir(req->master_bio) == WRITE && req->rq_state & RQ_IN_ACT_LOG)
 		drbd_al_begin_io(device, &req->i);
 
-	drbd_req_make_private_bio(req, req->master_bio);
+	req->private_bio = bio_clone_fast(req->master_bio, GFP_NOIO,
+					  &drbd_io_bio_set);
 	bio_set_dev(req->private_bio, device->ldev->backing_bdev);
+	req->private_bio->bi_private = req;
+	req->private_bio->bi_end_io = drbd_request_endio;
 	submit_bio_noacct(req->private_bio);
 
 	return 0;
-- 
2.29.2

