Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5926A6E7BD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjDSOLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjDSOLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:11:08 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A2167F0;
        Wed, 19 Apr 2023 07:10:56 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-2fa2fc747easo1721448f8f.2;
        Wed, 19 Apr 2023 07:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913455; x=1684505455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vsuN/DXTgv6nXT8tixf/9v37orpsS/ZRMb3IsbWCsU=;
        b=TRlQWB2N7YfZxBTIexDJHldR8L/JC9e545yIx+J9H7+Lobv11hqOBQ0bXspTnQEA40
         UVuzBUwPwfJh6CJj/ry4elMmDVfZd6t4BsUZuTToYulR+BwiJDibd9mURD40TqXs5Hlo
         JHdrxZq16WfhwRlV0+nfyMCWCj+kCRn/bwI79RxcwhaETLMt+NBj0P+eRrLf1H7JwMvI
         aiFB4cQ0gpu2m5d/Z29fn8kG/ioVARlEJNZZsJ5X1zC+O95j6YW/6n9MFhay2LqK7ESb
         Hyzqf52UiJ4Kpf+cdA+ic5NTxDME/mnG1ow/AddcZuRB70Bhy8t14a5esNw8Qscwl5Ge
         xT8Q==
X-Gm-Message-State: AAQBX9fa9prKlXgLgG4kTD9Qxb6WQZ1oJ9D/uGqXkrwCckdVOaBBmISJ
        fGRI6Bsspx6nfU0zMmZSbUo=
X-Google-Smtp-Source: AKy350ZtqTfiMh/3xTzWhxaqnfC6KE+V7qat1q3S3ZwFV6mDgq1XPDVNE2nS1h2LUGMDwyBUmS7crw==
X-Received: by 2002:a5d:4a0b:0:b0:2fb:ca40:e42c with SMTP id m11-20020a5d4a0b000000b002fbca40e42cmr4564600wrq.6.1681913455062;
        Wed, 19 Apr 2023 07:10:55 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm7612089wrv.58.2023.04.19.07.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:10:54 -0700 (PDT)
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
Subject: [PATCH v3 16/19] md: raid1: use __bio_add_page for adding single page to bio
Date:   Wed, 19 Apr 2023 16:09:26 +0200
Message-Id: <20230419140929.5924-17-jth@kernel.org>
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

The sync request code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8283ef177f6c..ff89839455ec 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2917,7 +2917,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				 * won't fail because the vec table is big
 				 * enough to hold all these pages
 				 */
-				bio_add_page(bio, page, len, 0);
+				__bio_add_page(bio, page, len, 0);
 			}
 		}
 		nr_sectors += len>>9;
-- 
2.39.2

