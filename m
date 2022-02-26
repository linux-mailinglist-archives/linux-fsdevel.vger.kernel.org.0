Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D264C587C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 23:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiBZWSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 17:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBZWSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:18:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDB1ED4F4
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 14:18:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x5so12190175edd.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcLz0IQv+GxbHx11Cvz5sFXp7fVix4wot2Bxm7nCzAM=;
        b=gc48qzr36opkGz+Nh0dHjUOqQwzk1Yf4gVdw8UiSk9a3eKLjSmYnot7LPiszc4V8Q4
         AbhxSAnoLL081VFSP5Pfs7cEBlO57VSIk1VzLFcgrEigo7b4DD62uNFZ92kwE6OcKMxY
         Bm7EdSq2MddXTrmnPh6KPXv7VC+3mnIXmdw2E1gwigjmCLZ6cd6DMDPRHZqx/IXCcXMp
         eZIX0NuJ3PL9JiqRvwjcpt37GvI05yK+Z0ImLBUrqetN6CSq9d4f2/gSG9oaVo+jUFPK
         7OwIXDxVSpWtIDrGbBov/fuj5cZl4e/m4lbog2QbDsVFJhIK9GWYS9iF/hEkpw9l/oER
         9Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcLz0IQv+GxbHx11Cvz5sFXp7fVix4wot2Bxm7nCzAM=;
        b=wM4ppZQXPbRuYzFeiYp74+JzAnTJbfxwC4aLFtZbfhKVOmZ6MVhcAJvE/m+BQLx/iv
         isvwbNCZmGIqr9vlNlldVj4MZrzkgHuCtTY9KIol+Sh1HHjIGHZtrv8xQZ0Y+hritoyI
         8E8zdzy0dejHVbfLmBK2AUveFXsDm6pBjiOGRZihzfgT9kKpJ0Op4WAQPMCU5IlrChnp
         KeW/WtGunqAfmokl6rO/xffGVDStU3Gzl1VXqYjVbF60iz8tKDQmF549N0DaDGSO2Hk3
         k2Xuz9vYke2WsV3AG55bSoMDqiTZBaHDjSuf78Jn4UwdNVrciIpPbFDlGEcmst7UFBB1
         LsbA==
X-Gm-Message-State: AOAM533mR/KdrhHnRPQ9tZ9vTyd+UHmyAW6NTEyUciGaHB3UpbZB8G1N
        b43oUSy3zBnaL7d+Uq8RK0CeBYbLRak=
X-Google-Smtp-Source: ABdhPJyvnBbQc2dCeVtr96gSXRACn4nQFI2gME1B3me9nX72lcdlLzY5HZw8D5adR3sSCnqx53veew==
X-Received: by 2002:a05:6402:350e:b0:412:d02f:9004 with SMTP id b14-20020a056402350e00b00412d02f9004mr13248999edd.59.1645913891644;
        Sat, 26 Feb 2022 14:18:11 -0800 (PST)
Received: from nlaptop.localdomain (178-117-137-225.access.telenet.be. [178.117.137.225])
        by smtp.gmail.com with ESMTPSA id s23-20020a1709062ed700b006b3fce6f91esm2692513eji.89.2022.02.26.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 14:18:11 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] direct-io: prevent possible race condition on bio_list
Date:   Sat, 26 Feb 2022 23:17:48 +0100
Message-Id: <20220226221748.197800-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prevent bio_list from changing in the while loop condition such that the
body of the loop won't execute with a potentially NULL pointer for
bio_list, which causes a NULL dereference later on.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 fs/direct-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 654443558047..806f05407019 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -545,19 +545,22 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
 	int ret = 0;
 
 	if (sdio->reap_counter++ >= 64) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dio->bio_lock, flags);
 		while (dio->bio_list) {
-			unsigned long flags;
 			struct bio *bio;
 			int ret2;
 
-			spin_lock_irqsave(&dio->bio_lock, flags);
 			bio = dio->bio_list;
 			dio->bio_list = bio->bi_private;
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			ret2 = blk_status_to_errno(dio_bio_complete(dio, bio));
 			if (ret == 0)
 				ret = ret2;
+			spin_lock_irqsave(&dio->bio_lock, flags);
 		}
+		spin_unlock_irqrestore(&dio->bio_lock, flags);
 		sdio->reap_counter = 0;
 	}
 	return ret;
-- 
2.35.1

