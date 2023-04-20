Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3566E8F65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjDTKIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjDTKGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:06:34 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925E3C24;
        Thu, 20 Apr 2023 03:06:14 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so2775066wmq.5;
        Thu, 20 Apr 2023 03:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985173; x=1684577173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExnlLXqiP3hLS8bpFiqaYIxJLAKQF5DCX5VPxtSPsPo=;
        b=fDZ7PWmFwNLkdiwCosBFV9kAnsBgdGLxIkRgOYRV3ZocNNEriHz3n4zomXjV/s2V2O
         rlxMi/Qx09m5evFiDlwvywk2uCjIDZsTn2yub5ekuzYDZfxpGgTgsPxAm6TZ7OGktFx7
         3Pfhmhtt02Xiq9mPEFQbJ8W5HuY/Fh6tLMNQPN+SGP8vBczPeFrZ080LvTDRiRuoxfea
         Hj+XUkEV+c43Oa/pYzFPQQ3DzjJB5lilaXfLp5EL9+fY/9ZrvaWumQmbvrSqA4cM4Y10
         X7/+/JI/W0LAHLMCw1pa3B7Xx9PxR9mK875jy+Z1aUpuXVc6oirigQLrOFSt6ySrflGr
         9dTg==
X-Gm-Message-State: AAQBX9cTPudflq0VoqrCnV3a0xkL2DY0yjzHRswxPDbbZU1ZSLINkrPY
        NxaY8kBLTmjiGjLrcKVygaY=
X-Google-Smtp-Source: AKy350Y9Lh9XIY3qybGhOCpyPMv4/qCxT9O5teS3GZxkrMtKC5XpeBENII5mka0Be7VFkgyszAIoCQ==
X-Received: by 2002:a7b:c4c6:0:b0:3f1:7006:e782 with SMTP id g6-20020a7bc4c6000000b003f17006e782mr804698wmk.25.1681985173032;
        Thu, 20 Apr 2023 03:06:13 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-208.dynamic.mnet-online.de. [62.216.205.208])
        by smtp.googlemail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm201410wrw.88.2023.04.20.03.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:06:12 -0700 (PDT)
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
Subject: [PATCH v4 19/22] block: mark bio_add_page as __must_check
Date:   Thu, 20 Apr 2023 12:04:58 +0200
Message-Id: <20230420100501.32981-20-jth@kernel.org>
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

Now that all users of bio_add_page check for the return value, mark
bio_add_page as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..0f8a8d7a6384 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -465,7 +465,7 @@ extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
-int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
+int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
 bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
-- 
2.39.2

