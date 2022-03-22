Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED014E4379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiCVP63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiCVP6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD96D4E2;
        Tue, 22 Mar 2022 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K7vQbYjaLE2gw5AtiIoBkjHYqv/oMNH2hku/X9M/OjI=; b=QyPrS2uUQJQRYb4uTgG50iHSNM
        ht3Gz8P4dXleamSzNkgnywy2KuFRr/C0CMrfbNXdZe2wmraR3RRXpboChSXVCfVZhw01oFKUYq/QG
        bEIMFgUAc39ONopsBQ9qqW0UyRU7x8PZqrpCPi5qL8qvu2OBE9+Nl86rwOGtMKJQI+7hdoiOhEuXw
        Tp5A2ZcztobWAA7nUqaMO5xH8qoNiXwgmsdL7+Ddt6J70F2MnSeMs3lbS/RGgtd/WhO3qWp2sn5sR
        OEdJiiQjr7TM3kEUo1O9yKZCxwlsXcitrqAG7M4ZZoN/asxx5e0mtTVObloffI4URuL+TO2DEDQGj
        TdiWADoA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsG-00Bajm-Uo; Tue, 22 Mar 2022 15:56:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/40] btrfs: don't allocate a btrfs_bio for raid56 per-stripe bios
Date:   Tue, 22 Mar 2022 16:55:40 +0100
Message-Id: <20220322155606.1267165-15-hch@lst.de>
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

Except for the spurious initialization of ->device just after allocation
nothing uses the btrfs_bio, so just allocate a normal bio without extra
data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2f1f7ca27acd5..a0d65f4b2b258 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1103,11 +1103,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = btrfs_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
-	btrfs_bio(bio)->device = stripe->dev;
-	bio->bi_iter.bi_size = 0;
-	bio_set_dev(bio, stripe->dev->bdev);
-	bio->bi_opf = opf;
+	bio = bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1UL),
+			opf, GFP_NOFS);
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
-- 
2.30.2

