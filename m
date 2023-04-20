Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421F86E8F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjDTKHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjDTKGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:06:19 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183B55B7;
        Thu, 20 Apr 2023 03:06:07 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f17eb6b10fso3444915e9.3;
        Thu, 20 Apr 2023 03:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985166; x=1684577166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D58hy5/Cr3/DLqz8bPLF+cijdU1EeyUsaB6+w7+K1A4=;
        b=L3E/hhO6wKDOzo1l4THZefDdHxtz9VgiXIemZfs7FNn58ED1i4URAD9LybeGhp4UPN
         xT/nViieJphx7uViLNdqS4GzUqUxqJHExh8qolMyrU/ULVvPrT5be7p+gwZGFmmr9Otl
         JzwFvbJDW5gxuEo5pwfma9NyYjH917HQysm2MXrICprWsdZvGFQ9YhdUlqajF5sQwaTQ
         MgPpbhpPNHlf6xpHtTFwdwLKm6brcUwzKD94smSdHSCytIUcQwSw9q/z7UM+9rbrFpKV
         E/rYEy4Pi2b32dyXVKRdS9IB/JW+Tn5l0llWMX7B7Rj5ttMula4uUm3PjuwvW/RI1Fw1
         gCAg==
X-Gm-Message-State: AAQBX9fwhSsxFFkvL8tdjG234C8DZ3xhC3hzx14f3aVnC7S474L2xO/G
        bMed0d4ReCbcRWXe5O9jJTU=
X-Google-Smtp-Source: AKy350bXJClLxz7rmMe8gZjcJmijV8o1TvktEKHe1Qv5MkDKw9WPVystlZxB2+xk1NShvg63MQKQYA==
X-Received: by 2002:adf:fec6:0:b0:2ef:1c8c:1113 with SMTP id q6-20020adffec6000000b002ef1c8c1113mr929778wrs.9.1681985165839;
        Thu, 20 Apr 2023 03:06:05 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-208.dynamic.mnet-online.de. [62.216.205.208])
        by smtp.googlemail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm201410wrw.88.2023.04.20.03.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:06:05 -0700 (PDT)
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
Subject: [PATCH v4 13/22] zram: use __bio_add_page for adding single page to bio
Date:   Thu, 20 Apr 2023 12:04:52 +0200
Message-Id: <20230420100501.32981-14-jth@kernel.org>
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

The zram writeback code uses bio_add_page() to add a page to a newly
created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef2..9179bd0f248c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -760,7 +760,7 @@ static ssize_t writeback_store(struct device *dev,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 
-		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
+		__bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
 				bvec.bv_offset);
 		/*
 		 * XXX: A single page IO would be inefficient for write
-- 
2.39.2

