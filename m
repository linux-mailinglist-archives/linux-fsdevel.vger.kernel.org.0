Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E47BAA55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjJETlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjJETlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:41:46 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E20CE;
        Thu,  5 Oct 2023 12:41:43 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c87e55a6baso10295595ad.3;
        Thu, 05 Oct 2023 12:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534903; x=1697139703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nPxETf/rkIvKMJBL1hY2qiSZWJpNY1p0t9ECt2ywEk=;
        b=HdfZgju817FRL1jJLyUrnuMElXmo29PeAuTZz7OUvO3GxKkFbln9xccwHrBcakSHG/
         X7ecW6QaN36TRUz69KB6wSQZYRjesQ6FXwlMGqfu/9vj1kKqj9VtmC9DXV44crxVMS9N
         7rS9sf45B6Pk9lVcjY28TbLeQ6m9yat9CkTyvr+BdDLfk5TpofYLtzANpKZbr5zasZQH
         Q1wXsfyELaRXa+95D8anm5bQefP+M1vl/Z5+a5/TIY7OPNpmzWw7f5nOifXu0xHcqNTm
         pRedN1ECF77Yhy+XIMiXlyremEDZGOetiEgyKIXYNDOhukGt2yrsNzbquBZUZ0q7iEma
         mddQ==
X-Gm-Message-State: AOJu0YxRLBusXl60L3cb4oGoVBvIVbdm1aMmEBD06MV/KTSOgd2js4Ys
        Y4Wm6a3V+pzIygdyRFgbx1k=
X-Google-Smtp-Source: AGHT+IHLzKCFJsY7a4M1BOadF4QOo5V3TgDLrmMfpvbznozSUDFP1uMTS/va5B+Qk6G+Jc2yTH3q+A==
X-Received: by 2002:a17:902:8e87:b0:1b2:4852:9a5f with SMTP id bg7-20020a1709028e8700b001b248529a5fmr5834371plb.54.1696534903150;
        Thu, 05 Oct 2023 12:41:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:41:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer bio->bi_ioprio bits
Date:   Thu,  5 Oct 2023 12:40:47 -0700
Message-ID: <20231005194129.1882245-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A later patch will store the data lifetime in the bio->bi_ioprio member
before bio_set_ioprio() is called. Make sure that bio_set_ioprio()
doesn't clear more bits than necessary.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         |  3 ++-
 include/linux/ioprio.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..bc086660ffd3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2926,7 +2926,8 @@ static void bio_set_ioprio(struct bio *bio)
 {
 	/* Nobody set ioprio so far? Initialize it based on task's nice value */
 	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
-		bio->bi_ioprio = get_current_ioprio();
+		ioprio_set_class_and_level(&bio->bi_ioprio,
+					   get_current_ioprio());
 	blkcg_set_ioprio(bio);
 }
 
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 7578d4f6a969..f2e768ab4b35 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -71,4 +71,14 @@ static inline int ioprio_check_cap(int ioprio)
 }
 #endif /* CONFIG_BLOCK */
 
+#define IOPRIO_CLASS_LEVEL_MASK ((IOPRIO_CLASS_MASK << IOPRIO_CLASS_SHIFT) | \
+				 (IOPRIO_LEVEL_MASK << 0))
+
+static inline void ioprio_set_class_and_level(u16 *prio, u16 class_level)
+{
+	WARN_ON_ONCE(class_level & ~IOPRIO_CLASS_LEVEL_MASK);
+	*prio &= ~IOPRIO_CLASS_LEVEL_MASK;
+	*prio |= class_level;
+}
+
 #endif
