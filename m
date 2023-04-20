Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B26E8F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjDTKIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjDTKG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:06:56 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D441171D;
        Thu, 20 Apr 2023 03:06:18 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f167d0c91bso5444515e9.2;
        Thu, 20 Apr 2023 03:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985176; x=1684577176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdnAdvAKJlDAz7pM0pp8Diurpm3+TR0sCY4FonfaEe4=;
        b=Rqf7jaBh/8LOYrqd/Ye1XO/kTtgssmpHumrEKR2L4ngOoTsrp9Skv/WNAYVPqLMDVf
         iHshIrgED2YRB75AhZnYzc2SF/07PFMxdJIpo7CPo/22rWMCKIv0mTfECWb7VdgoVWFl
         iLDka5jZVaKPJYirtKe0ECRF9+t7vLYtNruSJgw4/lf5qJpJnWVl/Dnogn1wXn/iy5nB
         pu1v3zbQV9/wtMrqYnSeEWEokoSht90OFweQfUwLaL5X2qlxxFD+F29tj/O+cvvdUUgk
         Jgg+VCU/ndIHVgDJB1Gc2cRaGSWRAnq/5kbRSvJefzMhdAAuXUSJMaPeon1YP/Q//meA
         YNXw==
X-Gm-Message-State: AAQBX9eOuIitcBl+AQTHnXE8Bh3Y8tSv6DMnNlYuWqim88UeQmjc9vRU
        p/nxSaYVtnLjOdRUy4Ira7c=
X-Google-Smtp-Source: AKy350bs2gtzNI5cB6yEjD27bAOubU763Pln69XpJllBqakY/TYBXJ5mOXnM5tQ2B75UHodvDIFK3A==
X-Received: by 2002:a5d:6dcc:0:b0:2fa:43e7:4a32 with SMTP id d12-20020a5d6dcc000000b002fa43e74a32mr694948wrz.66.1681985176558;
        Thu, 20 Apr 2023 03:06:16 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-208.dynamic.mnet-online.de. [62.216.205.208])
        by smtp.googlemail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm201410wrw.88.2023.04.20.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:06:16 -0700 (PDT)
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
Subject: [PATCH v4 22/22] block: mark bio_add_folio as __must_check
Date:   Thu, 20 Apr 2023 12:05:01 +0200
Message-Id: <20230420100501.32981-23-jth@kernel.org>
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

Now that all callers of bio_add_folio() check the return value, mark it as
__must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 99fa832db836..36cfc091caed 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -466,7 +466,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
 int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
-bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
+bool __must_check bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.39.2

