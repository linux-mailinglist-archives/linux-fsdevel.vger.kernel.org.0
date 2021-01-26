Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20FE30422D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406259AbhAZPTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406211AbhAZPTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:19:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8631AC061A29;
        Tue, 26 Jan 2021 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W8aYaHALoHXbZuaFOXKQTvVh+y8Fd7IAvJYrZZoNhdA=; b=JGt1JH63w8eiaQAEI4n5kVSxVw
        Yb98hQCjj4BuRaFELXNV4V1YWR5whaTFBuvsbS38JX90ZmqkewzosVaccIltP0wA2PaXodrpLDpB2
        dSjrXAgSsWvpd2IUnGUtb9AYtQSvL35vq7Nk0hrDytjnDJgyME8PkByHiOhSAl9mtgqEmnzC6m+1a
        27nBnbSxYEnE4x0UzJcki15gkshb+GwSUKKI0Oto59KylHdpnaNOwDbNnn+gdjEjJTFJ/NFEbW1sE
        0TONqXtHBo84FuLa/h+/kr81vIkdUY2Vm7qMY41RhMKFBZje5JtOQrBJAVRfoZsXINuN6WnyqR5mx
        9qSFgATA==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Q1A-005nvT-6a; Tue, 26 Jan 2021 15:13:04 +0000
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
Subject: [PATCH 12/17] md: simplify sync_page_io
Date:   Tue, 26 Jan 2021 15:52:42 +0100
Message-Id: <20210126145247.1964410-13-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use an on-stack bio and biovec for the single page synchronous I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e2b9dbb6e888f6..6a27f52007c871 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1021,29 +1021,29 @@ int md_super_wait(struct mddev *mddev)
 int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		 struct page *page, int op, int op_flags, bool metadata_op)
 {
-	struct bio *bio = md_bio_alloc_sync(rdev->mddev);
-	int ret;
+	struct bio bio;
+	struct bio_vec bvec;
+
+	bio_init(&bio, &bvec, 1);
 
 	if (metadata_op && rdev->meta_bdev)
-		bio_set_dev(bio, rdev->meta_bdev);
+		bio_set_dev(&bio, rdev->meta_bdev);
 	else
-		bio_set_dev(bio, rdev->bdev);
-	bio_set_op_attrs(bio, op, op_flags);
+		bio_set_dev(&bio, rdev->bdev);
+	bio.bi_opf = op | op_flags;
 	if (metadata_op)
-		bio->bi_iter.bi_sector = sector + rdev->sb_start;
+		bio.bi_iter.bi_sector = sector + rdev->sb_start;
 	else if (rdev->mddev->reshape_position != MaxSector &&
 		 (rdev->mddev->reshape_backwards ==
 		  (sector >= rdev->mddev->reshape_position)))
-		bio->bi_iter.bi_sector = sector + rdev->new_data_offset;
+		bio.bi_iter.bi_sector = sector + rdev->new_data_offset;
 	else
-		bio->bi_iter.bi_sector = sector + rdev->data_offset;
-	bio_add_page(bio, page, size, 0);
+		bio.bi_iter.bi_sector = sector + rdev->data_offset;
+	bio_add_page(&bio, page, size, 0);
 
-	submit_bio_wait(bio);
+	submit_bio_wait(&bio);
 
-	ret = !bio->bi_status;
-	bio_put(bio);
-	return ret;
+	return !bio.bi_status;
 }
 EXPORT_SYMBOL_GPL(sync_page_io);
 
-- 
2.29.2

