Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B44F0E3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377180AbiDDEsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbiDDEsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:48:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878E8338AE;
        Sun,  3 Apr 2022 21:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nsUZ3Lx76HRNTI7ctEWp+CEJB6lY6f4YhgBiZMKYLaE=; b=QAtcC7oEpRyxd7EFu6vVgy+PRc
        7pHGye9mq2/I864Rx7NxCJBdG/gLtm3MzeGGm6M52r4AI3r55oOGw+sD4JfwKyJX+S0zkQwFCEYHa
        Tdg3h75IJd73uMzdO65DOd1rCCJ9FRy8AHsmdxML6tLS+UBMkslaRkuERfDQ4ic6obovLGIkZeh5d
        iFucPBQF6oeBe2hS9WmdtVuleroO0xrf9MDtHP4CU2MO4vb/b+h7CQXUtafW9A7n0WvbzYQ0/MViS
        db0/7gw7h6Xqn9U9UJgH0omcE782qFIHyCJkwcIgw85791iuucW99TWcKZD4nfw6MM0WWkKagqOMN
        7/A+I36Q==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEbM-00D3ha-BG; Mon, 04 Apr 2022 04:46:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] btrfs: don't allocate a btrfs_bio for raid56 per-stripe bios
Date:   Mon,  4 Apr 2022 06:45:26 +0200
Message-Id: <20220404044528.71167-11-hch@lst.de>
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

Except for the spurious initialization of ->device just after allocation
nothing uses the btrfs_bio, so just allocate a normal bio without extra
data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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

