Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A76E7BE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjDSOLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDSOLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:11:09 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9180516DD6;
        Wed, 19 Apr 2023 07:10:58 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-2fe3fb8e2f7so703060f8f.0;
        Wed, 19 Apr 2023 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913457; x=1684505457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0hLQVWAy93GtM7oc6TpMOtkbIMql7YOXfxv+ovXyBI=;
        b=G4cc5dGkkDNaiDS6LDJLs4MNke9gNqfCWnWv3ZALpHSfa22lUxouevYuGt0+dtB7L+
         1UvLrfOT+fZRrU4clUdq6wzas58HCdtbTKNO1SIeY3pTA7FX9hc8zBpY2ZQatyUEUeAH
         uR3A1ztO/1LR2+Om0nw9NyHaBtNXNK1/gN/lxv1V0dl8ADYY1rjig2a49baml3kEdduR
         vmu3Mgx4q1d+LmzbMnFIHl3XautP0CEXl4qGhdL8+LTvoasg/yO5N5iKc/5TKSu+BH37
         25P84NPN5NQzmEiROxm6FPIi2114gEZMgmVt0tc64GZdcupuxNw/vFrq2LKaFPhAseLM
         1ItQ==
X-Gm-Message-State: AAQBX9eefwMxW+4NHFX38F8rFWzGnPLTESJTkygwE8Ihwh/yRN7tADPe
        t0lLnmrAViricZk3UWswkjU=
X-Google-Smtp-Source: AKy350aVLE+txxcZm9LeX2yItutcTFI6YYsrFgCoIWHLD8EDS9H+yj3niCnWRjhD3VeCviDrTQZ6vw==
X-Received: by 2002:a05:6000:1a47:b0:2ce:d84d:388f with SMTP id t7-20020a0560001a4700b002ced84d388fmr5447194wry.40.1681913456733;
        Wed, 19 Apr 2023 07:10:56 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm7612089wrv.58.2023.04.19.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:10:56 -0700 (PDT)
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
Subject: [PATCH v3 17/19] md: raid1: check if adding pages to resync bio fails
Date:   Wed, 19 Apr 2023 16:09:27 +0200
Message-Id: <20230419140929.5924-18-jth@kernel.org>
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

Check if adding pages to resync bio fails and if bail out.

As the comment above suggests this cannot happen, WARN if it actually
happens.

This way we can mark bio_add_pages as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/raid1-10.c | 11 ++++++-----
 drivers/md/raid10.c   | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index e61f6cad4e08..cd349e69ed77 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -101,11 +101,12 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		struct page *page = resync_fetch_page(rp, idx);
 		int len = min_t(int, size, PAGE_SIZE);
 
-		/*
-		 * won't fail because the vec table is big
-		 * enough to hold all these pages
-		 */
-		bio_add_page(bio, page, len, 0);
+		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+			bio->bi_status = BLK_STS_RESOURCE;
+			bio_endio(bio);
+			return;
+		}
+
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..59e52cf01569 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3804,11 +3804,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		for (bio= biolist ; bio ; bio=bio->bi_next) {
 			struct resync_pages *rp = get_resync_pages(bio);
 			page = resync_fetch_page(rp, page_idx);
-			/*
-			 * won't fail because the vec table is big enough
-			 * to hold all these pages
-			 */
-			bio_add_page(bio, page, len, 0);
+			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+				goto giveup;
+			}
 		}
 		nr_sectors += len>>9;
 		sector_nr += len>>9;
@@ -4985,11 +4985,11 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		if (len > PAGE_SIZE)
 			len = PAGE_SIZE;
 		for (bio = blist; bio ; bio = bio->bi_next) {
-			/*
-			 * won't fail because the vec table is big enough
-			 * to hold all these pages
-			 */
-			bio_add_page(bio, page, len, 0);
+			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+				return sectors_done;
+			}
 		}
 		sector_nr += len >> 9;
 		nr_sectors += len >> 9;
-- 
2.39.2

