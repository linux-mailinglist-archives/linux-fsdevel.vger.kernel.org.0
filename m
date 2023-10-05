Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94F7BAA58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjJETls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjJETlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:41:47 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C09DDE;
        Thu,  5 Oct 2023 12:41:45 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c63164a2b6so19659625ad.0;
        Thu, 05 Oct 2023 12:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534905; x=1697139705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XU7/rD9j0ZREmbTpKb/UlDGnlHS1ysYVPW/Elt+b7Dc=;
        b=jTwYMkrNktxKahHmiV1QxNnJQ8eUle+KhsVeekifZgEmuui0d3ULvR3LzW8AQEDpkG
         cg+iR86U+b4vuHCWAb/McpM39i+HzWFkzUb8/QkjdUCjr4tcgmdsrIqtCQOWJ1hrpgjb
         r0FnDp2ckdqyQOgMtP+5LNVsX+mX94hBBPi0DnEBWCi3XYzcvAVMErLFup6SdPcwpmPY
         Q1mUeOGo80+UZxTL82fN1A0DyFjNVmIZt7ym1BFGCYN0eiaT3BaQ+fE59egHyXOG1zcB
         D9C03/FkGdlRNp7yLexrTQXT4U4RxfJyFkGWXd1msVJEbvmD5gLgUaAv15Dc3m565kSV
         Iq5g==
X-Gm-Message-State: AOJu0YzhIcjVqOIUzLhc94si/uR84fUphYaZyxdOblxTvOmdyXUy4nrz
        bREqGCqDCWUQZMtJSwgnQIs=
X-Google-Smtp-Source: AGHT+IETPVOsJ6HpAuJoon2e2+9Y9KnVVJKAQbD5MSFSiVZVMuG1Y4YU1C8amTv1y8SwQVd3Ipc8zw==
X-Received: by 2002:a17:902:e5d1:b0:1c6:362:3553 with SMTP id u17-20020a170902e5d100b001c603623553mr4430523plf.31.1696534904623;
        Thu, 05 Oct 2023 12:41:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:41:44 -0700 (PDT)
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
Subject: [PATCH v2 02/15] blk-ioprio: Modify fewer bio->bi_ioprio bits
Date:   Thu,  5 Oct 2023 12:40:48 -0700
Message-ID: <20231005194129.1882245-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A later patch will store the data lifetime in the bio->bi_ioprio member
before the blk-ioprio policy is applied. Make sure that this policy doesn't
clear more bits than necessary.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-ioprio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 4051fada01f1..2db86f153b6d 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -202,7 +202,8 @@ void blkcg_set_ioprio(struct bio *bio)
 		 * to achieve this.
 		 */
 		if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
-			bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4);
+			ioprio_set_class_and_level(&bio->bi_ioprio,
+					IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4));
 		return;
 	}
 
@@ -213,10 +214,10 @@ void blkcg_set_ioprio(struct bio *bio)
 	 * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
 	 * priority is assigned to the bio.
 	 */
-	prio = max_t(u16, bio->bi_ioprio,
+	prio = max_t(u16, bio->bi_ioprio & IOPRIO_CLASS_LEVEL_MASK,
 			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
-	if (prio > bio->bi_ioprio)
-		bio->bi_ioprio = prio;
+	if (prio > (bio->bi_ioprio & IOPRIO_CLASS_LEVEL_MASK))
+		ioprio_set_class_and_level(&bio->bi_ioprio, prio);
 }
 
 void blk_ioprio_exit(struct gendisk *disk)
