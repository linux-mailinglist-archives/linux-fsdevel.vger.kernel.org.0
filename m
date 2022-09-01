Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD35A90B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiIAHmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiIAHma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DEEE68F8;
        Thu,  1 Sep 2022 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q0cJ+yGC6IUGRmsPYw8GA1ONb9WnpEqPOZmuK5m2FYw=; b=QxFW6/SjNqpBtJF8DfEGKFPX4U
        9loTVeTVfaX8NVNt03i4qwX+aY186HoD522Rqxb2QOwOHPw7RwWvUXgK/IVWwD8LlOAbgD0qgRMzU
        H3f5yojgnOQqlFc4aG110rQ2IiQxsvi3lP1uJOwgN3J4NTnkMuaXHsEUHb0Qm0+dd3/NYAGh8Mzif
        VmTWBe+wwrh2s6X5+lbbzDYP9vpeelHMDXu6QhdJqh+rWXOo74Owx4GZAKL87mqlo/8IBNQJvYXlB
        uainKj0jMBipH6tI8Z6SCUu8UybPFVbSKuatzvgOA/HI76ieUXSXf1lIpHknwOiKN5/nFcdgaVl/I
        KV6MXBPQ==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqG-00ANUr-OO; Thu, 01 Sep 2022 07:42:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/17] block: export bio_split_rw
Date:   Thu,  1 Sep 2022 10:42:00 +0300
Message-Id: <20220901074216.1849941-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_split_rw can be used by file systems to split and incoming write
bio into multiple bios fitting the hardware limit for use as ZONE_APPEND
bios.  Export it for initial use in btrfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c   | 3 ++-
 include/linux/bio.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ff04e9290715a..e68295462977b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -267,7 +267,7 @@ static bool bvec_split_segs(struct queue_limits *lim, const struct bio_vec *bv,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
-static struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
+struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
 		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
@@ -317,6 +317,7 @@ static struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
 	bio_clear_polled(bio);
 	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
 }
+EXPORT_SYMBOL_GPL(bio_split_rw);
 
 /**
  * __bio_split_to_limits - split a bio to fit the queue limits
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ca22b06700a94..46890f8235401 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -12,6 +12,8 @@
 
 #define BIO_MAX_VECS		256U
 
+struct queue_limits;
+
 static inline unsigned int bio_max_segs(unsigned int nr_segs)
 {
 	return min(nr_segs, BIO_MAX_VECS);
@@ -375,6 +377,8 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
 void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
+struct bio *bio_split_rw(struct bio *bio, struct queue_limits *lim,
+		unsigned *segs, struct bio_set *bs, unsigned max_bytes);
 
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
-- 
2.30.2

