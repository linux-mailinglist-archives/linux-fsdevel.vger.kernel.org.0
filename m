Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C479B33C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbjIKUzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjIKJtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:49:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07FED
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf1876ef69so11142435ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425755; x=1695030555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv4+I9qs+KANLJaK53QHVxwskZBXOowpEQY9lGK28w4=;
        b=hJXqsjP6dk0XDG254Xjpm7dA1/G+soUaYNYpPDObvT5qkOLntpMGbpbz6Ngna/ZfBN
         Uld9UPpKCZbfqiaVxApFmzviTn04DVFr0qwMfQATuQw2fAFKqsGFNcHSjX1dZTgWQQxf
         VZVSzhT2dL1u12EqW96uR+YPVmk2WeQmNzYaKEUcn/YHXrjVr8raNVPOyHmdwjxoDIbt
         07admHzxh3L40ZqnpjckgDn7lMUTH8CIVkSBfeiOZSQT9WsFiWt4XGMDMAXCeXGoWcul
         zGTK2z8FZLtR9Pjd6MX7z0qgQgmvBZ5ZQt+W25q9viTCll787FolyFuyxde5M9lLx8kJ
         1oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425755; x=1695030555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iv4+I9qs+KANLJaK53QHVxwskZBXOowpEQY9lGK28w4=;
        b=ZT+5rUQShHv82/4GLhEYtyoqVxfDYBIqWR4fDINUKf5YXKr3mRJqdC/iWTY3Z7urRk
         NJQaXEJ3gt7kRAf53oP+7n4Sf+XH14Z1y5FFg4Gde+GccKqpskZv5rVdyCT9zKrjtJqz
         eP6dykeEfEJNxd2ax3w14Rh3vlrp0p49T0DZNTJBK7mY04KkQrLbcrcMFB8I2Ntmqc1E
         OeMAtg5YWVxqgQD3k/N6/cK1fy78bcYSYvQSX4fxntSsLJQwEr384qKrpW7h0UAuDJAS
         Za5H/R5o8A44spTvmJlwoikRi0vi7zXmZEcoB+PE3qdWA2GygnCdnEde54dutXqMwiRS
         qpNQ==
X-Gm-Message-State: AOJu0Yz6JJoioI/2cRmkrhJvWrKqFf+TZdQ1EQVJCCmbJTYosMW7w9Ha
        gIFf3wv1HFhcXQDtWMbBBgpEQA==
X-Google-Smtp-Source: AGHT+IEdRnAd72WYbN/lPKVmYN7Gm8oLIBUCIcL/8BMMQo0OE3Z9NszhBcdotvpIkMipjaUIUmLwpA==
X-Received: by 2002:a17:902:d508:b0:1c1:fbec:bc32 with SMTP id b8-20020a170902d50800b001c1fbecbc32mr10682658plg.6.1694425755638;
        Mon, 11 Sep 2023 02:49:15 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:49:15 -0700 (PDT)
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
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 27/45] vmw_balloon: dynamically allocate the vmw-balloon shrinker
Date:   Mon, 11 Sep 2023 17:44:26 +0800
Message-Id: <20230911094444.68966-28-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the vmw-balloon shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct vmballoon.

And we can simply exit vmballoon_init() when registering the shrinker
fails. So the shrinker_registered indication is redundant, just remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Nadav Amit <namit@vmware.com>
CC: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_balloon.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9ce9b9e0e9b6..c817d8c21641 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -380,16 +380,7 @@ struct vmballoon {
 	/**
 	 * @shrinker: shrinker interface that is used to avoid over-inflation.
 	 */
-	struct shrinker shrinker;
-
-	/**
-	 * @shrinker_registered: whether the shrinker was registered.
-	 *
-	 * The shrinker interface does not handle gracefully the removal of
-	 * shrinker that was not registered before. This indication allows to
-	 * simplify the unregistration process.
-	 */
-	bool shrinker_registered;
+	struct shrinker *shrinker;
 };
 
 static struct vmballoon balloon;
@@ -1568,29 +1559,27 @@ static unsigned long vmballoon_shrinker_count(struct shrinker *shrinker,
 
 static void vmballoon_unregister_shrinker(struct vmballoon *b)
 {
-	if (b->shrinker_registered)
-		unregister_shrinker(&b->shrinker);
-	b->shrinker_registered = false;
+	shrinker_free(b->shrinker);
+	b->shrinker = NULL;
 }
 
 static int vmballoon_register_shrinker(struct vmballoon *b)
 {
-	int r;
-
 	/* Do nothing if the shrinker is not enabled */
 	if (!vmwballoon_shrinker_enable)
 		return 0;
 
-	b->shrinker.scan_objects = vmballoon_shrinker_scan;
-	b->shrinker.count_objects = vmballoon_shrinker_count;
-	b->shrinker.seeks = DEFAULT_SEEKS;
+	b->shrinker = shrinker_alloc(0, "vmw-balloon");
+	if (!b->shrinker)
+		return -ENOMEM;
 
-	r = register_shrinker(&b->shrinker, "vmw-balloon");
+	b->shrinker->scan_objects = vmballoon_shrinker_scan;
+	b->shrinker->count_objects = vmballoon_shrinker_count;
+	b->shrinker->private_data = b;
 
-	if (r == 0)
-		b->shrinker_registered = true;
+	shrinker_register(b->shrinker);
 
-	return r;
+	return 0;
 }
 
 /*
@@ -1883,7 +1872,7 @@ static int __init vmballoon_init(void)
 
 	error = vmballoon_register_shrinker(&balloon);
 	if (error)
-		goto fail;
+		return error;
 
 	/*
 	 * Initialization of compaction must be done after the call to
@@ -1905,9 +1894,6 @@ static int __init vmballoon_init(void)
 	vmballoon_debugfs_init(&balloon);
 
 	return 0;
-fail:
-	vmballoon_unregister_shrinker(&balloon);
-	return error;
 }
 
 /*
-- 
2.30.2

