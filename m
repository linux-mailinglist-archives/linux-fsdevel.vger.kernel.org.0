Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F8A6313F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKTMrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTMrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:47:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D622BC3;
        Sun, 20 Nov 2022 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kxBu+ZULN5/wC7dMCaCV46Hyc6YfDgFzuCV//Z8v2sw=; b=F1FDGT7OB/kbEwAIM2YfjNqlzE
        wWa50N9pvKIcOsGa0qOx35CF08aWVM9YKbLEgPtTpCa5yg1bWs8xfu7q2WeuBR0OIq457upWdWSa/
        /n28YMlOEXUeC4mL4B4vSxGxL6PXoJoiFO0uokVDgfRhDzNVAS5SboBKF/C39gMjpm5c/3pv7eD1+
        8fWWXyw6UFOTqdWKgNcPskj6oWpWLiRmOrPeiC/L5tL84LXkSxCdQQFr9Ry8lmKGxRd9r7NqdARsI
        /sUgdFIJlrIgp7OLXUbVF4FAfk5e6OJj1K+Lq4jAeNg8M6nOqve+syG7VswdTMRyBZbmc+mJQgLUu
        YJHs5XAw==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjjX-004I4h-Pp; Sun, 20 Nov 2022 12:47:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/19] block: export bio_split_rw
Date:   Sun, 20 Nov 2022 13:47:16 +0100
Message-Id: <20221120124734.18634-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_split_rw can be used by file systems to split and incoming write
bio into multiple bios fitting the hardware limit for use as ZONE_APPEND
bios.  Export it for initial use in btrfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index 2c5806997bbf7..730afea66cc89 100644
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

