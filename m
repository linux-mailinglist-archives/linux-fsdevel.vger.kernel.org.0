Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF56E8F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjDTKGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjDTKGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:06:11 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA74C3D;
        Thu, 20 Apr 2023 03:05:59 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f1833c5991so3500295e9.1;
        Thu, 20 Apr 2023 03:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985157; x=1684577157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fzr57yVT4AGfP8f/rHc++3o/RNaaVBknK7ki+b7wqg=;
        b=iNJWtfUoZm3M1WdPvfKmaekuBz73pmk+zGU25UL9V4xm/wrEOshGfFZelYcpiG6lZC
         WgPJIJ1C1mMnemN2epVQ4O/3TCGqp+7HNKhVrP9844LsryGKsBesbswI28UaV9DwY52r
         NyH7RECmUgJcawBVGK9WVXiNit1caEEmN4k9GCIW6YpMGZC9n/qAIUcjPiGtegYgHn4T
         iBDUwLpWI95I6+EEAD52ch2jE899Z8e0UdR+fEN6uvwgrLMvEubetW5JtrN8xZXKeQld
         7QYm7Qb2eEyF6LImk+sWVVeL7pKpOB7MlWgMNtz+dWxRov7KCMlzrtw7CGJoKJCpkXD9
         bF5A==
X-Gm-Message-State: AAQBX9fRUE9PKFBMyZIo7zSzLtQ/aktRe0s0Hi4xOhCTDJe1FJCOwjmA
        WIA2gM59WKyVIlQMe3HhV+I=
X-Google-Smtp-Source: AKy350bLyO4KQbV/PoPdUqDGkkMZX7ZfuVuX5huOYxZIzQyFuycseqFdIVwkpU3U96njdfQtavhtJw==
X-Received: by 2002:a05:6000:1201:b0:2f2:c46b:1eb5 with SMTP id e1-20020a056000120100b002f2c46b1eb5mr939686wrx.59.1681985157174;
        Thu, 20 Apr 2023 03:05:57 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-208.dynamic.mnet-online.de. [62.216.205.208])
        by smtp.googlemail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm201410wrw.88.2023.04.20.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:05:56 -0700 (PDT)
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
Subject: [PATCH v4 06/22] md: raid5-log: use __bio_add_page to add single page
Date:   Thu, 20 Apr 2023 12:04:45 +0200
Message-Id: <20230420100501.32981-7-jth@kernel.org>
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

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/raid5-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 46182b955aef..852b265c5db4 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -792,7 +792,7 @@ static struct r5l_io_unit *r5l_new_meta(struct r5l_log *log)
 	io->current_bio = r5l_bio_alloc(log);
 	io->current_bio->bi_end_io = r5l_log_endio;
 	io->current_bio->bi_private = io;
-	bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
+	__bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
 
 	r5_reserve_log_entry(log, io);
 
-- 
2.39.2

