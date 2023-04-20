Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598A6E8F62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 12:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjDTKI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjDTKGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:06:44 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B202430DC;
        Thu, 20 Apr 2023 03:06:15 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f177cb2c6cso3448475e9.2;
        Thu, 20 Apr 2023 03:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985174; x=1684577174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybte8ln4cL1imogQbfLUc6IIuAFaJLWmv8LuzJpUUJE=;
        b=bpV3K7/z51UhdxmU2aTI1Bjpb4GM92Sn6vynzmK6wh2unGdfiOLQJZPjcKKwqRLuId
         fuFnbUAZOJMHgveXqd4uqudzfQVqgXU2Svd+mX375bsVkEidDwIn9ejLrELUKxgWbRo6
         SLj5nCDFVHtwjRDdKfc+jPTbRycpXYPeTFpo4EWvE3Fel7RqhHqgx4l4OzOVIEqkKZWO
         p7gPzYEv4XxMaXabgn/agIg1IR6IKNrbGAyrzChuYpmRDL6UxcWhNYHzcMIBNE4t4ArS
         0tvZd9dU5ih4MaA2fgFepGtt/Z1eaJE2imdIvKmCXP8Z0K+Vut6a7PU5bOISfMgT3b7+
         3oGw==
X-Gm-Message-State: AAQBX9d8m8nvCfUvipqdZ8m0GcrVld9IvdWHhYXPUEcqYZrrl3AFet+R
        5R/gtBZcGNvdZjH8pTjwQak=
X-Google-Smtp-Source: AKy350ZrFHrJO95XpjLsqvNhaT3Lj7em6PpVK0jNKwO81XYdkMaIRUgqMSWWRox8APZBVDphzDkYwQ==
X-Received: by 2002:adf:f384:0:b0:2f2:9198:f0f with SMTP id m4-20020adff384000000b002f291980f0fmr833210wro.10.1681985174142;
        Thu, 20 Apr 2023 03:06:14 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-208.dynamic.mnet-online.de. [62.216.205.208])
        by smtp.googlemail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm201410wrw.88.2023.04.20.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:06:13 -0700 (PDT)
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
        song@kernel.org, willy@infradead.org
Subject: [PATCH v4 20/22] block: add __bio_add_folio
Date:   Thu, 20 Apr 2023 12:04:59 +0200
Message-Id: <20230420100501.32981-21-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420100501.32981-1-jth@kernel.org>
References: <20230420100501.32981-1-jth@kernel.org>
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

Just like for bio_add_pages() add a no-fail variant for bio_add_folio().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 8 ++++++++
 include/linux/bio.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index fd11614bba4d..f3a3524b53e4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1138,6 +1138,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+void __bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		     size_t off)
+{
+	WARN_ON_ONCE(len > UINT_MAX);
+	WARN_ON_ONCE(off > UINT_MAX);
+	__bio_add_page(bio, &folio->page, len, off);
+}
+
 /**
  * bio_add_folio - Attempt to add part of a folio to a bio.
  * @bio: BIO to add to.
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0f8a8d7a6384..99fa832db836 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -473,6 +473,7 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+void __bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.39.2

