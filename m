Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623DB739B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjFVI6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjFVI53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:57:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B42113
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b5466bc5f8so9654015ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424123; x=1690016123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/vExFBLW3qTniAw4XeP9KQ69i9zow/4wwrpInqlwjM=;
        b=f9niG/1nDZCnLyGAdmXOPnr0UhYRgdnlIknKHTp5fpAvQQctnSzqFRWkCf20Ww177d
         QG9jeeQWMuTex/IwaFDMA8vXlH6fpJPO6Zn2dpmhMfbdqmxsLU2UIGO2NDOzTGYWiDw7
         ywIPFwnvUTjEHuZeccmcjrjEkLsXSYquHahbHd6ZdjnzqEP2RHdSMNMWgiY9L8TVZ0lC
         G4aVTSqjJ5NrWtnVCJTDf1mbR/bEFK3aai4gwzFQmPA34Ikuzxs8i6IqNfr5Nxc5N0yO
         /Hq8+LGyQI4XHPCqHbrNX4k2UTVR4h1zk7vD27aNaHUnKMeOkCqJba/XQtzAGJZToHzN
         Aj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424123; x=1690016123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/vExFBLW3qTniAw4XeP9KQ69i9zow/4wwrpInqlwjM=;
        b=AhF2pd7JT9ANMmEFHw7bSj65+wRfMX2KKPoLtW6+ANJpJgtQKoCr1iqb1H6wNxkcCp
         7OHx9r8BFDmDCWVTNygilVNpzKREC4HTOJQTixs7Xt+jT6/znH695Oi0QZLYYZX314n5
         4cg10VoN40ePPRJscGxgJIpPKhRxZR2GsnS4axj5yJgF87vzZ3R3RVoKOXUEgbkHOTuM
         48lvqnMoHCbyjoXH2zjhebp4ozMCWWRddE5QB4uqu/GS4Xt1J0iWJFxFzqwbSCk7fBH/
         CMjDWWPKJiI+ypKlsOt+mHN/uyeZUw1Frj3E4JbNjZbFFVb2t87Qi+2gatM/Q7SUuzxg
         cFdg==
X-Gm-Message-State: AC+VfDyLTzeYU7W+3CdN1i7D6qkwvDOxVSpPrSR4PNmvKhaPj4KwllfL
        REva5kgVZiGIK5skn+ltgBJGoQ==
X-Google-Smtp-Source: ACHHUZ4R6XsCch8DMbBn2ilzIIAPskFMWcDdECndDXpbpwroXAZTFBoXbn8TaLTiXdt1Xz94/St+OA==
X-Received: by 2002:a17:902:dac6:b0:1a1:956d:2281 with SMTP id q6-20020a170902dac600b001a1956d2281mr22035085plx.3.1687424123198;
        Thu, 22 Jun 2023 01:55:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:22 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 10/29] vmw_balloon: dynamically allocate the vmw-balloon shrinker
Date:   Thu, 22 Jun 2023 16:53:16 +0800
Message-Id: <20230622085335.77010-11-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the vmw-balloon shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct vmballoon.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/misc/vmw_balloon.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9ce9b9e0e9b6..2f86f666b476 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -380,7 +380,7 @@ struct vmballoon {
 	/**
 	 * @shrinker: shrinker interface that is used to avoid over-inflation.
 	 */
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 	/**
 	 * @shrinker_registered: whether the shrinker was registered.
@@ -1569,7 +1569,7 @@ static unsigned long vmballoon_shrinker_count(struct shrinker *shrinker,
 static void vmballoon_unregister_shrinker(struct vmballoon *b)
 {
 	if (b->shrinker_registered)
-		unregister_shrinker(&b->shrinker);
+		unregister_and_free_shrinker(b->shrinker);
 	b->shrinker_registered = false;
 }
 
@@ -1581,14 +1581,18 @@ static int vmballoon_register_shrinker(struct vmballoon *b)
 	if (!vmwballoon_shrinker_enable)
 		return 0;
 
-	b->shrinker.scan_objects = vmballoon_shrinker_scan;
-	b->shrinker.count_objects = vmballoon_shrinker_count;
-	b->shrinker.seeks = DEFAULT_SEEKS;
+	b->shrinker = shrinker_alloc_and_init(vmballoon_shrinker_count,
+					      vmballoon_shrinker_scan,
+					      0, DEFAULT_SEEKS, 0, b);
+	if (!b->shrinker)
+		return -ENOMEM;
 
-	r = register_shrinker(&b->shrinker, "vmw-balloon");
+	r = register_shrinker(b->shrinker, "vmw-balloon");
 
 	if (r == 0)
 		b->shrinker_registered = true;
+	else
+		shrinker_free(b->shrinker);
 
 	return r;
 }
-- 
2.30.2

