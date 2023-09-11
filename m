Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5979BDDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjIKUzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjIKJqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84257E4B
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3aa44c0faso1779945ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425553; x=1695030353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FwhLiYYaF8GJm0hS886+94gWet3PBBx4VE+fsMZAKg=;
        b=UXG+ki6KpE79lGWI/vLWYtPwSirCzFjrjqHD5AA+xSFdL7ZTr9zq9xQxx80j5+244C
         04VPXUdFnMTXkRn71wO4D6FYh1jybOzlomBKg1YyyV/af66QUwDJZLkhUBYfmZxlBs9p
         p9H7GdXB7hX3l8du+stvXCdr87QYH4f1Udp5gSVrbND0H6UgfkMZsHMRnma8SIUF/9Vh
         lOSuG4PbbQTAhOKmr7E4MnftaQTxuZ0IBJ7Djh8htjmVkZX2jSXoy3ci/4rHVRUQEYuy
         XCLsVn1rHNlBGyMYUOZddtlGJOgMmfZqUOn9JyjEQupGaYPL2w6Awod1OSVC/V+MrNxn
         zTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425553; x=1695030353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FwhLiYYaF8GJm0hS886+94gWet3PBBx4VE+fsMZAKg=;
        b=sp2PHYyTyquoU1yJN9Iiy8FSY3D6wQARogVbq5d04LS8ruUZhWjiQnw1c7zMRQ9ouw
         sgjId10Llwnc+l/E79PRV2C4fPc6wCkPS9DTfd0Pk3iPkbAW7S9mJ6jb9Tb+lXXVMJNz
         UN8XJuHqqGFdkVTRTdhFGUgkUBAocEFma3mEuApTAAx0caTZRhLxNYmDChxqdXqdz3Fk
         IN/YmCj6SvzZBWF/pibOjtdtGuGY0iETYXqWB1u7wXp9M97CA5kO9NHLYaFDd8NJ68HR
         kRkG7r11qfGiQ7DmpTIpplB+Vu3inuo/5+U1JNF/Xm3Vu3jZnpp7QpEZX+hn9idEvrgs
         6smQ==
X-Gm-Message-State: AOJu0Yw8KoGoTN+u6XKRc7jnofKXg74HnwfR+xU1btCzx638h3sZD2b1
        y6Zuza3Z/odTepQtHfHIOEz/PA==
X-Google-Smtp-Source: AGHT+IHJaWa+7S6PEpk0MEo5uFVZCUWjKmc0DPmv6mKvqIMnxGI/EF90IQq3u3ePRTZciiGyrN8JSg==
X-Received: by 2002:a17:903:41c8:b0:1c0:bf60:ba4f with SMTP id u8-20020a17090341c800b001c0bf60ba4fmr11505655ple.4.1694425553045;
        Mon, 11 Sep 2023 02:45:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:45:52 -0700 (PDT)
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
Subject: [PATCH v6 05/45] xenbus/backend: dynamically allocate the xen-backend shrinker
Date:   Mon, 11 Sep 2023 17:44:04 +0800
Message-Id: <20230911094444.68966-6-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the xen-backend shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: xen-devel@lists.xenproject.org
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index da96c260e26b..5ebb7233076f 100644
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
@@ -305,8 +301,15 @@ static int __init xenbus_probe_backend_init(void)
 
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
+
+	shrinker_register(backend_memory_shrinker);
 
 	return 0;
 }
-- 
2.30.2

