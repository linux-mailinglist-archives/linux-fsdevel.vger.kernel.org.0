Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887D6E7BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjDSOLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjDSOKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:10:50 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125E167CF;
        Wed, 19 Apr 2023 07:10:34 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-2fde2879eabso1129156f8f.1;
        Wed, 19 Apr 2023 07:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913433; x=1684505433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asKpmswp0ZeanhVo76Eo+6VNkXdxI3jhQK0PDuQZThY=;
        b=LESxIXcLP8mKifXeelR1qB9JZaFg023YEH8+ALZP4nnG1vhK7tzPll2TJvavSNSKQ9
         XC4fgLf3B7k/a4wuooQw9WXBx35/qxiMsi8lpshDJqHrneefLORxpKrwfNoYU0VTAFjU
         oAQsWvk+SRWrwMNEvORbG96LHU/l8LXYQ9q/BnuSS6mlIovRQrFqaFrn2KvfZDi4VDNe
         sNDwTVZbGWNkeINlcjQQb/iyxgSXNxv6d5My+/nR26cyZAbUcD5I8+l3bBhDzYBokT7a
         SBTKECVAuEo4NBzq7wGzJuB0N7QPWRs+x88VbDRKzEz60UtEKVWjR+rYkCeHz14LPqXM
         XiGQ==
X-Gm-Message-State: AAQBX9fqtnrufQAv2wadgOmHWpnX3NkFXo5GimUnOavT/cq8Pyv5lo8i
        DVyD1MnCx2vfL+E0KEUr8Fk=
X-Google-Smtp-Source: AKy350YqBEkn+VSvf2DvOCXN7mDa/WvroFJZvGVNeDs7bs2faerUsWpsWUIcEH/19Lk45zhWOo8M7g==
X-Received: by 2002:adf:e892:0:b0:2f8:67ee:5ca9 with SMTP id d18-20020adfe892000000b002f867ee5ca9mr4765546wrm.65.1681913433175;
        Wed, 19 Apr 2023 07:10:33 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm7612089wrv.58.2023.04.19.07.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:10:32 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     axboe@kernel.dk
Cc:     johannes.thumshirn@wdc.com, agruenba@redhat.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 03/19] dm: dm-zoned: use __bio_add_page for adding single metadata page
Date:   Wed, 19 Apr 2023 16:09:13 +0200
Message-Id: <20230419140929.5924-4-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419140929.5924-1-jth@kernel.org>
References: <20230419140929.5924-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

dm-zoned uses bio_add_page() for adding a single page to a freshly created
metadata bio.

Use __bio_add_page() instead as adding a single page to a new bio is
always guaranteed to succeed.

This brings us a step closer to marking bio_add_page() __must_check

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index cf9402064aba..8dbe102ab271 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -577,7 +577,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
 	return mblk;
@@ -728,7 +728,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
 	return 0;
@@ -752,7 +752,7 @@ static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
 	bio = bio_alloc(dev->bdev, 1, op | REQ_SYNC | REQ_META | REQ_PRIO,
 			GFP_NOIO);
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
-- 
2.39.2

