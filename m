Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3473E764C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjG0IVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjG0ISg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:18:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFDC61B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:11:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f74a8992so77893b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445429; x=1691050229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDu/4z0sff3MNLq2Hem41DvJLtW9HR7Ht2OY0+o3IBw=;
        b=iVGfsyXkMcKNuSj4S4+ETT1e5FnNKRSLwcupS7aKQrOa2P/cg11EPb/fa7MepSVN0c
         souD70V3XZBCWCF1GY2G8kOBoazYK/GwCZP5iJVITEwRi2CFhPhtCnmN6NHRYDRfscjM
         ei11bn/3SqGlS2cI+uWxsIZ60GgV8/Th1+KRHAcGdOM/vcClXnAdg9IcKu5dXKtmCkaz
         1Uv1368bMlurEfH1GvebpNgAfjlYTQWl+OVWRYv+SAitVhKYxMqk7I6vstlqXAV5ZTFg
         13mCns35aGRuj+msRJnkqY3lYp1C9AqbhcZNDVttxslcFzKIxthPN+0g8mDIqHh31rTQ
         XhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445429; x=1691050229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDu/4z0sff3MNLq2Hem41DvJLtW9HR7Ht2OY0+o3IBw=;
        b=SyVXsTbIYe5in8m13lRyVF5H5ivLGNKoH6XEEfYKDDI4R6+9irzvlod/K+zgFZ+KZO
         +/cJRC0IfLbV/OTrUEHq62yihE4lJlvU5qmj75hwiiDZ9+XTYnAzo4iSKgq8xA3X9JCN
         Zh0q14TMpbaS/Ok7Oegg+BKFfEy5/cE79zg7NABmMrxJQQrV2oSfLAx2qLVYnvnUAgaJ
         +qfvQZ7ceDt0ZU0Dnlb2JO6NCXVl+y14YcLirmiFdcjOVP5x3yBE7zMpsrAToPv/cfaj
         bLLrl5Snbtsh1t6h+oGengN05hURTq90QWMW/qpW2+RmGcfkQwfIxCcWYl1Mv2CW5Fs1
         tezA==
X-Gm-Message-State: ABy/qLY5Hbjxol7HtZ8FtP8KTo5mXlKbEVkdemey2tlaUemzEJtpn863
        TrhXocu5qODE6ojIEVU/DyLPeg==
X-Google-Smtp-Source: APBJJlHGswV8UzzwdSNooBFOlXCa2QxTNwcJjWEIeOA/B6KtVME+e61/tgitLanHgBraDSTbcyHPAw==
X-Received: by 2002:a05:6a20:1595:b0:137:30db:bc1e with SMTP id h21-20020a056a20159500b0013730dbbc1emr5696433pzj.3.1690445429121;
        Thu, 27 Jul 2023 01:10:29 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:10:28 -0700 (PDT)
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
Subject: [PATCH v3 23/49] mm: workingset: dynamically allocate the mm-shadow shrinker
Date:   Thu, 27 Jul 2023 16:04:36 +0800
Message-Id: <20230727080502.77895-24-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the mm-shadow shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..3c53138903a7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -763,13 +763,6 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 					NULL);
 }
 
-static struct shrinker workingset_shadow_shrinker = {
-	.count_objects = count_shadow_nodes,
-	.scan_objects = scan_shadow_nodes,
-	.seeks = 0, /* ->count reports only fully expendable nodes */
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
-};
-
 /*
  * Our list_lru->lock is IRQ-safe as it nests inside the IRQ-safe
  * i_pages lock.
@@ -778,9 +771,10 @@ static struct lock_class_key shadow_nodes_key;
 
 static int __init workingset_init(void)
 {
+	struct shrinker *workingset_shadow_shrinker;
 	unsigned int timestamp_bits;
 	unsigned int max_order;
-	int ret;
+	int ret = -ENOMEM;
 
 	BUILD_BUG_ON(BITS_PER_LONG < EVICTION_SHIFT);
 	/*
@@ -797,17 +791,24 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
-	if (ret)
+	workingset_shadow_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						    SHRINKER_MEMCG_AWARE,
+						    "mm-shadow");
+	if (!workingset_shadow_shrinker)
 		goto err;
+
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
-			      &workingset_shadow_shrinker);
+			      workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
-	register_shrinker_prepared(&workingset_shadow_shrinker);
+
+	workingset_shadow_shrinker->count_objects = count_shadow_nodes;
+	workingset_shadow_shrinker->scan_objects = scan_shadow_nodes;
+
+	shrinker_register(workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	free_prealloced_shrinker(&workingset_shadow_shrinker);
+	shrinker_free(workingset_shadow_shrinker);
 err:
 	return ret;
 }
-- 
2.30.2

