Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD667645E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjAUGv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAUGvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0532C61D44;
        Fri, 20 Jan 2023 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rE42VId0rOcPjuR7QzxZ4CqkdeF4wSyuqh1wi4fe7NE=; b=I8ypRK5otUYzYPHxkwhSnmYUvI
        1Q+ajholbzWGeyrkskGAyMpUOsmfGgbHKFnIah+fJe53VbhBM/d4iGRLYUzuQD8pk97Pcq7+SxZZt
        H0fG40ESB5d8oeyrud6+awjP2RAmGSWX1SGP/fZA3NtX4MjAP2smMp5g8AECpNSOkhVEFzEAN108+
        A6yPNEDaHLL5bBjOOI+5ba5zn0a/aWjWbvl1giBrxK1Te0oXH1LVbyjqRKBQEHxr+d5Mi7VLAvSc6
        t3ofscv0fwSXeegEVqGkAAf05l8UfyCoBDZiBi1v50EtIJpm4IOVONqLDbFLmr4rnZS1UcDpawF1i
        ZeAhBzxg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iT-00DRPq-Bb; Sat, 21 Jan 2023 06:51:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/34] btrfs: remove btrfs_bio_for_each_sector
Date:   Sat, 21 Jan 2023 07:50:09 +0100
Message-Id: <20230121065031.1139353-13-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_bio_for_each_sector is unused now, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 996275eb106260..2e799c3348d5a6 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -94,22 +94,6 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	bbio->end_io(bbio);
 }
 
-/*
- * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
- *
- * bvl        - struct bio_vec
- * bbio       - struct btrfs_bio
- * iters      - struct bvec_iter
- * bio_offset - unsigned int
- */
-#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	\
-	for ((iter) = (bbio)->iter, (bio_offset) = 0;			\
-	     (iter).bi_size &&					\
-	     (((bvl) = bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
-	     (bio_offset) += fs_info->sectorsize,			\
-	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
-	     (fs_info)->sectorsize))
-
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		      int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-- 
2.39.0

