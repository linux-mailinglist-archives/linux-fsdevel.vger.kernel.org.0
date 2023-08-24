Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1423786606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbjHXDpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbjHXDo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:44:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852F10F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a32506e90so1062093b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848671; x=1693453471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL9UzNFH9xRc40ovijxQr7+deLFTeJc0QRJlNk7UAJE=;
        b=bY9LD4tgkqWxkQKKd/RDOoX5W8qpuGAecHeEhLMfDjHuJUY0svZZBxoximm9J6Y19i
         IqrrH7xW9H7peP2arsnyh17grC5SQNfshLtri8kPslLmcIm+7WgUocRo8Yx/4Tfw2jXR
         c3uYDXcSM/kuK3tPVglakJG9pBHZK8VSYZiPXSkCgitJGmj1bNL4q/waTdyTfhOKwshR
         aTWnSB7OVezKYHSxHn7x3sc27R1ATOK+S6Og+iQUPKgoVWwop02aWHbGt7Gzi+eH1aCx
         GxgOchcaZoRBNIXtV5nUG7kDq0z3sxxuYYxZNhstl4e05qGO/BrwD9AQR8U5OepcAJBK
         FutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848671; x=1693453471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL9UzNFH9xRc40ovijxQr7+deLFTeJc0QRJlNk7UAJE=;
        b=VC8UkmIxtBqUb+awOETCqdy31zHtcjLPnQ3pzRhUS9U20p+r5SRvddc9krW40H9rWX
         nojn6/ChKOXem5J8HbCdzwORQsSaO6JTC0X2syB3qrW3oa2YJ3iVxCj3mwDktVm5+IIr
         iEcmuEgeRlRVWqfse0t0ANZlSzXfXP6IQe8sbP6uRdk7z3htwF71ZHxHRjIHfpX4sb63
         PSdO/FoODBLTPochcOME+X+LJyqBNlX4ryFZq1409l615QW0lFk2ryJHc6Sx76+qHPmO
         6dzFUnC4q5MlmyDc9/rCgQlSjlrNWbFXtLLcZJ5avVWDs0MevZ7zeyonCokWmgUkVn8u
         ClCA==
X-Gm-Message-State: AOJu0YzxNYN/9N3YWDAFwfhyPwBpb7xkzEUen6aZw1qTtRSp0ItP9Cnw
        EQY8A/hmwzsOcM/HrGwVcFqDuA==
X-Google-Smtp-Source: AGHT+IF9XwmI1K/7s22ZAfh1q1VXcTL8c0ROJkv/uTQnOzzzUix0h5W4i5ROCPEGbt2KzyOxEQAr3A==
X-Received: by 2002:a05:6a20:938d:b0:13c:bda3:79c3 with SMTP id x13-20020a056a20938d00b0013cbda379c3mr17551017pzh.4.1692848671217;
        Wed, 23 Aug 2023 20:44:31 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:30 -0700 (PDT)
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
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v5 05/45] xenbus/backend: dynamically allocate the xen-backend shrinker
Date:   Thu, 24 Aug 2023 11:42:24 +0800
Message-Id: <20230824034304.37411-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the xen-backend shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: xen-devel@lists.xenproject.org
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index da96c260e26b..929c41a5ccee 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -284,13 +284,9 @@ static unsigned long backend_shrink_memory_count(struct shrinker *shrinker,
 	return 0;
 }
 
-static struct shrinker backend_memory_shrinker = {
-	.count_objects = backend_shrink_memory_count,
-	.seeks = DEFAULT_SEEKS,
-};
-
 static int __init xenbus_probe_backend_init(void)
 {
+	struct shrinker *backend_memory_shrinker;
 	static struct notifier_block xenstore_notifier = {
 		.notifier_call = backend_probe_and_watch
 	};
@@ -305,8 +301,16 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
-	if (register_shrinker(&backend_memory_shrinker, "xen-backend"))
-		pr_warn("shrinker registration failed\n");
+	backend_memory_shrinker = shrinker_alloc(0, "xen-backend");
+	if (!backend_memory_shrinker) {
+		pr_warn("shrinker allocation failed\n");
+		return 0;
+	}
+
+	backend_memory_shrinker->count_objects = backend_shrink_memory_count;
+	backend_memory_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(backend_memory_shrinker);
 
 	return 0;
 }
-- 
2.30.2

