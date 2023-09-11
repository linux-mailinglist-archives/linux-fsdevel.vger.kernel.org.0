Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9244679AD0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjIKUyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjIKJpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:45:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C25E4A
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a4dab8172so1088013b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425534; x=1695030334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUoMNQAb0HDNERTf3y3lU6vkCLiBk8akZS8yI7+n5rc=;
        b=CoasD1d31XlhCnitJBmmOtobDcAOcLVXMBlgePDlpoEVWi0XIhce2Lb2mpsz2Ugdfc
         m5ujhriWdZWO/81Hj+NDQkqrJC00K/OVER7H6X6v3TqPNuIKQoRrXw6WVNHrnQLmpJPz
         VjADbX3K3BL37cRJTTf8iXGaaYyWoePNhT4x5emVAvXq1HpwHQ0fSPYTug38SORXF+qr
         gel4ubEo5a4MM/zNKOIfpbAuZsg8QFL+6qF2IbrUzzOuGPmQFzkRHkVFrcBtv/n7PDBE
         TRxQrYm3qtEt2VINVOICoQ+h467/wwoV4HZ6nB9tkKptwobT/ibvywYWgSaq0vob9VrM
         zCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425534; x=1695030334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUoMNQAb0HDNERTf3y3lU6vkCLiBk8akZS8yI7+n5rc=;
        b=uhN5DqFaIr7rUmeaVSrOV0fsZuBT5/ogq0dF6MyoFrx6MTD/9EbT0WINmTKxOMFoi5
         eqwjpFuFiL/RJ12CN3L4N1QxbyYExBfPrKKGhsc8Nr31AR8978+er8xIg/7fLOCbLbke
         +P+zbPo3cB90aTiwRFtPfXOWTpaU9H0qZ1yhLZoPpF1e7qU3iLUmuZkZkdQbp3+pu1cQ
         lHUt0y5DvPDHVLQUUHTfMX1P0RhtAmSilYBE3vY2tDhxHKfUnjo1DbTI4UOCvBtcw0Vy
         Dbj5aSJyu73JsaakBfBJ6sfH3op3MGjb+cOnBtFmTyw4vfrH8ZcK2JYnjQft/EUg2o5f
         0oTg==
X-Gm-Message-State: AOJu0YzKIUORjm7T/iM7NQmTWp5+rLSyvFWK+EWNZ3HlY9QrI7EHoZYm
        4uMwrdMwnh3qHpbNcVEmR/tSlg==
X-Google-Smtp-Source: AGHT+IFTLTKyDsfu1NylfkAEUjAx8ahS4NnLvg9xanza3vKrJB8S7jYrE7HTHnlVMC2Ur/FZ9D9EPw==
X-Received: by 2002:a05:6a20:394c:b0:13d:7aa3:aa6c with SMTP id r12-20020a056a20394c00b0013d7aa3aa6cmr9989617pzg.0.1694425533979;
        Mon, 11 Sep 2023 02:45:33 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:45:33 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH v6 03/45] binder: dynamically allocate the android-binder shrinker
Date:   Mon, 11 Sep 2023 17:44:02 +0800
Message-Id: <20230911094444.68966-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the android-binder shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder_alloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e3db8297095a..138f6d43d13b 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1053,11 +1053,7 @@ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			    NULL, sc->nr_to_scan);
 }
 
-static struct shrinker binder_shrinker = {
-	.count_objects = binder_shrink_count,
-	.scan_objects = binder_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *binder_shrinker;
 
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
@@ -1077,19 +1073,29 @@ void binder_alloc_init(struct binder_alloc *alloc)
 
 int binder_alloc_shrinker_init(void)
 {
-	int ret = list_lru_init(&binder_alloc_lru);
+	int ret;
 
-	if (ret == 0) {
-		ret = register_shrinker(&binder_shrinker, "android-binder");
-		if (ret)
-			list_lru_destroy(&binder_alloc_lru);
+	ret = list_lru_init(&binder_alloc_lru);
+	if (ret)
+		return ret;
+
+	binder_shrinker = shrinker_alloc(0, "android-binder");
+	if (!binder_shrinker) {
+		list_lru_destroy(&binder_alloc_lru);
+		return -ENOMEM;
 	}
-	return ret;
+
+	binder_shrinker->count_objects = binder_shrink_count;
+	binder_shrinker->scan_objects = binder_shrink_scan;
+
+	shrinker_register(binder_shrinker);
+
+	return 0;
 }
 
 void binder_alloc_shrinker_exit(void)
 {
-	unregister_shrinker(&binder_shrinker);
+	shrinker_free(binder_shrinker);
 	list_lru_destroy(&binder_alloc_lru);
 }
 
-- 
2.30.2

