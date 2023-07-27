Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E795764C15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjG0IU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjG0IS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:18:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269075FE9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:10:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f6231bdeso113072b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445393; x=1691050193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHU8OaKZwBmHAPsd+ulZSL5GxfVyMtJ49ZlHBntG+/k=;
        b=Ws66ywmifmcLi+WS7kmIq1OGsH1BFTj57lSknLEKHfbjZoq0FCk32P7hFix2O77y/C
         4VExY7boGbko1TLXa8rf04m6+c8ScNg+Ye07GBCAr/bT75kG0yI8bdxHraEPkF+rcUYR
         8BmftTtO1b4i7ZeslsgPT7KHdxn3xY8ziOGXEmWj+FzniwFS8tNvAxdGJbvq/4djXF38
         gQDVTQD96XEDgWvn9v9d4yLEL0qbZzBxPnvHBbbs4StP2CGFCs0AHk/pzAfhLwFN3LYv
         MATNwQY8c4ti2yb34XlOR1fjl5eoQUN5qPDBlkMol6h4RrCuQdh3qGqhSkTUZQAnG9Jo
         zXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445393; x=1691050193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHU8OaKZwBmHAPsd+ulZSL5GxfVyMtJ49ZlHBntG+/k=;
        b=VIC/XnhcXFG04Hw+qfaxTYC+4Co1P0NoHm8qxzkx+8F0wKkg6OfYy3blFOMbHRpxfS
         GJIVLWIn4EUGH2A4Yw0BVHwc7y+GnqUzWl6hpY57jXbIvhClMq1LMaIygromrT23xFQa
         6VcERgrCDWyJ6DaUYOpvtnTDRkjbfIDZBjZKc1/UaltDpYaFK0zA8oEdii6E4YOwVwwT
         /AiWcassXS4SnPlgs9m/NQSvEz0/x3S/S4UUlHyfto7kFXl3EO8kK/SNtMTqDInvcQpK
         Fb7MNQC6ac/LKARt+JvxrfF0cNYJwV4oqIOPnW88p5tB6F4gJyDU9XDqDHZxyX8cLSVt
         LEwA==
X-Gm-Message-State: ABy/qLb6nicIa54iO9e3IGwpKnKwW7xHw6zhd9ySZ4Zj5kCMxDRW/kVZ
        H8xR5aJjEMRVaamgilx07Ec/1Q==
X-Google-Smtp-Source: APBJJlFl46sZLt7x9x1yarGXcrDY9BzfubiI/ML/2A4f5iYMwILGEdxBDjTGuKdYIeQS2k9MfMDqhg==
X-Received: by 2002:a05:6a00:4a0e:b0:677:3439:874a with SMTP id do14-20020a056a004a0e00b006773439874amr5199798pfb.3.1690445393467;
        Thu, 27 Jul 2023 01:09:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:09:53 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 20/49] rcu: dynamically allocate the rcu-kfree shrinker
Date:   Thu, 27 Jul 2023 16:04:33 +0800
Message-Id: <20230727080502.77895-21-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the rcu-kfree shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/rcu/tree.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..6d2f82f79c65 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3449,13 +3449,6 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return freed == 0 ? SHRINK_STOP : freed;
 }
 
-static struct shrinker kfree_rcu_shrinker = {
-	.count_objects = kfree_rcu_shrink_count,
-	.scan_objects = kfree_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
-
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
@@ -4931,6 +4924,7 @@ static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
 	int i, j;
+	struct shrinker *kfree_rcu_shrinker;
 
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
@@ -4962,8 +4956,18 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
-	if (register_shrinker(&kfree_rcu_shrinker, "rcu-kfree"))
-		pr_err("Failed to register kfree_rcu() shrinker!\n");
+
+	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
+	if (!kfree_rcu_shrinker) {
+		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
+		return;
+	}
+
+	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
+	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
+	kfree_rcu_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(kfree_rcu_shrinker);
 }
 
 void __init rcu_init(void)
-- 
2.30.2

