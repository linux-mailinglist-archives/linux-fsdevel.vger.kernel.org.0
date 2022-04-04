Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F128D4F0E44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbiDDErx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377154AbiDDErv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F83335B;
        Sun,  3 Apr 2022 21:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/avzwxJe7vQT/n5f7nDpa9Le9w4aJiHouTAgqpbrAmQ=; b=p8zMemVzum2GcEt/NBqhBeNOwD
        sQFdtSacVQX5nwonIP05K/SISproIpImuEcjWbkUmyGVKpcuznP9yApHutlZheXmSzxW/X+7+O+3n
        cGuRwsEk9ZUg8LvChSh6Q5Tw2vdbt+aowkRhC5aV7MTAlySczc9zgKVmQMwmS39tYMWCLXIdgAAGT
        5+KO2Y6zWjreqeRfZFYG6mbaI6YLDbPOhRZ+jE4MHAsVUMb94clB5cEfHxj1SPAleozkOBeCe+imc
        Wv4NkUodMYxMtOimQ61pjctfv4XBuezK91/PG1sG91uaU3izWQoWrcRHJ0H8hMwxoYFNB3TNKb2/9
        yzvVvQww==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEb9-00D3a6-Qw; Mon, 04 Apr 2022 04:45:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] btrfs: simplify scrub_repair_page_from_good_copy
Date:   Mon,  4 Apr 2022 06:45:22 +0200
Message-Id: <20220404044528.71167-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404044528.71167-1-hch@lst.de>
References: <20220404044528.71167-1-hch@lst.de>
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

The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
so just use an on-stack bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 74c0557e6a2f9..93bb480de2164 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1544,7 +1544,8 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 	BUG_ON(spage_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
 	    sblock_bad->checksum_error || spage_bad->io_error) {
-		struct bio *bio;
+		struct bio bio;
+		struct bio_vec bvec;
 		int ret;
 
 		if (!spage_bad->dev->bdev) {
@@ -1553,26 +1554,20 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, spage_bad->dev->bdev);
-		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
-		bio->bi_opf = REQ_OP_WRITE;
+		bio_init(&bio, spage_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
+		bio.bi_iter.bi_sector = spage_bad->physical >> 9;
+		__bio_add_page(&bio, spage_good->page, sectorsize, 0);
 
-		ret = bio_add_page(bio, spage_good->page, sectorsize, 0);
-		if (ret != sectorsize) {
-			bio_put(bio);
-			return -EIO;
-		}
+		btrfsic_check_bio(&bio);
+		ret = submit_bio_wait(&bio);
+		bio_uninit(&bio);
 
-		btrfsic_check_bio(bio);
-		if (submit_bio_wait(bio)) {
+		if (ret) {
 			btrfs_dev_stat_inc_and_print(spage_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
-			bio_put(bio);
 			return -EIO;
 		}
-		bio_put(bio);
 	}
 
 	return 0;
-- 
2.30.2

