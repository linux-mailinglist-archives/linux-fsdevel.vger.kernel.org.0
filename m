Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD692786601
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbjHXDo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbjHXDoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:44:38 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A2510F3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:12 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57328758a72so32001eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848652; x=1693453452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDsQ7RYDMLqwy7twIXuFD5p94As+lf02HfuxyLHsCC8=;
        b=Iz2/0G+SOuFIIhaxK3w/LEcD9PS4zKZ/5RcLqJKJdh7uItCmfOpE5/jAV7CTQYQwrv
         9LBEDsGb7OQVTT0y75+W3hmVRKD+wPpekmo+U1aWv4VIpRlze67WWzhGK7PvHfv80+Aq
         22HTG7tQsAc/n7lxTDb50FgYJVxBohbov3zGbdkxBFRg2+u94qfoy1WCYE/6SjCv6IEm
         ltAHVGpsm97r2LYMNXe9UbJZYZZt9/2CCg8ESzyBAJkE7r6xfLbBYY9uJptQzOq9AB8z
         gdd+zPqCkxoqARc/NmfQ31JLb8MZu5Pxd2lkneChOp1kQa9CHtD0HIZqJbsdwGK/j8pA
         D8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848652; x=1693453452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDsQ7RYDMLqwy7twIXuFD5p94As+lf02HfuxyLHsCC8=;
        b=gxhzI6qcTtDZSujkyZcPQXe9IKkI2lJw0Seu0FrGl5Bv9A9PE0pggTPApPDCZLoY5B
         re4Jc1t1yt5bGAd6wnlehdYS+/WLnwC8YE7NV12403R8A6cV6l3qGD6xa5qa8ZgQetL+
         8e5c9/CIlHaJOCy25cCHmxCXKmfLrIg3qdv0EOx40KuZp1tIDyemwQtb02HShlrxXs45
         QCAye8qW2Yc34OCtJOM1oUI3tCrGYuliWUQUuF5AvmoH6omUpJl8NiiL9Qof2ZlyEyFi
         MD66uASoPqtTKu7YgqSu45rk4dNmFB8Ingz/WfLlX/NxHJ7fZncRYSxXGI+vGfNdHhNf
         DT4g==
X-Gm-Message-State: AOJu0YzCTfhLBpyokvoJ55hr+wG8q9DimwsQPyQ8EjxXQtwGVTH+D0ER
        gYUUsm4xuxRq55nXLKxTteMWpw==
X-Google-Smtp-Source: AGHT+IEM8N+jMmp+ItOCDi7GhGIbRWYtk0R7RyKurKUW+QPYSbNbY2W9LIX4qInIQ/vDJIM/8yTcQQ==
X-Received: by 2002:a05:6808:1a84:b0:3a6:f8e5:edad with SMTP id bm4-20020a0568081a8400b003a6f8e5edadmr13552232oib.4.1692848651831;
        Wed, 23 Aug 2023 20:44:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:11 -0700 (PDT)
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
Subject: [PATCH v5 03/45] binder: dynamically allocate the android-binder shrinker
Date:   Thu, 24 Aug 2023 11:42:22 +0800
Message-Id: <20230824034304.37411-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
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
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e3db8297095a..62675cedd38e 100644
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
@@ -1077,19 +1073,30 @@ void binder_alloc_init(struct binder_alloc *alloc)
 
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
+	binder_shrinker->seeks = DEFAULT_SEEKS;
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

