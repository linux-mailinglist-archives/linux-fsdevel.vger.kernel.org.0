Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7202F4E4384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiCVP6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiCVP6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA406C927;
        Tue, 22 Mar 2022 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LmOy6lZk+zYWpF0ntQumFrGscOHUuIp55gVDzI0gXM8=; b=IhoYfjP62PSTxnkXJEiDVbfR+l
        VsGM1CTENY0KcCM02KCaif9XQfL9/4c4oa5qVvAtSgTLJ2CkPzQl1T2wgG4bQhIQCrCXcLwRccjv4
        i+XKox8DoY0h6c8zDZR4PRGNHxw8bkw3wi91EuuWT+eqa/GWAL5SFPkFPDFk4EC9myeriYDfsm0N5
        Ir8VO/6e54RglcVkMKOiyc8UqatmJmSKZpSe23xy51BndIT2Wpozn8Efhzl5t0XEBDxtw4mM2qWsT
        f4qb6f2H4FJ3kxkJjAyB5Jqx6MiImzjc8ki82ff561cwtwq35BotZQXj/dma1OYp8ERmPnegN+adv
        /yBC1Dag==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgs4-00Bags-3z; Tue, 22 Mar 2022 15:56:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/40] btrfs: simplify scrub_recheck_block
Date:   Tue, 22 Mar 2022 16:55:35 +0100
Message-Id: <20220322155606.1267165-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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
---
 fs/btrfs/scrub.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 605ecc675ba7c..508c91e26b6e9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1462,8 +1462,9 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		return scrub_recheck_block_on_raid56(fs_info, sblock);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
-		struct bio *bio;
 		struct scrub_page *spage = sblock->pagev[page_num];
+		struct bio bio;
+		struct bio_vec bvec;
 
 		if (spage->dev->bdev == NULL) {
 			spage->io_error = 1;
@@ -1472,20 +1473,17 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!spage->page);
-		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, spage->dev->bdev);
-
-		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
-		bio->bi_iter.bi_sector = spage->physical >> 9;
-		bio->bi_opf = REQ_OP_READ;
+		bio_init(&bio, spage->dev->bdev, &bvec, 1, REQ_OP_READ);
+		__bio_add_page(&bio, spage->page, fs_info->sectorsize, 0);
+		bio.bi_iter.bi_sector = spage->physical >> 9;
 
-		btrfsic_check_bio(bio);
-		if (submit_bio_wait(bio)) {
+		btrfsic_check_bio(&bio);
+		if (submit_bio_wait(&bio)) {
 			spage->io_error = 1;
 			sblock->no_io_error_seen = 0;
 		}
 
-		bio_put(bio);
+		bio_uninit(&bio);
 	}
 
 	if (sblock->no_io_error_seen)
-- 
2.30.2

