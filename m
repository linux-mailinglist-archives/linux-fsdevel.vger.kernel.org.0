Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5778661C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjHXDrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbjHXDq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:46:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024901FCA
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68824a0e747so1237991b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848743; x=1693453543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jemklUFFCXuSkFimtib823G6Ct+c21vKLbvuJ2OztTU=;
        b=LgRdO1FrpQYjfdqKgY7kw9rvoqVC5S1JSj2Ky2tibLl0UkGXBa01sM6tJJtw+HUSpw
         vVOTPvHxNt/AqID6/gQaE/EJ2lmfNE/O2FmAZf55yMpKB3nOPksaDOXPjXEx/JrJ/a0H
         7gzGX2I8Vak7oBpce2JEArh1Aby2I+koavv0vi78GW6RbE0dsrPp96+DvKW7HORmZPSO
         5Q5/QNviG9nWkifZ6ozu08jFzQCHMGjACqD/YSaShhiFDDnoKbe9ZymHxmhZSz5LBYKL
         CQ08NNQGQGVLqg6/kIhSxdlHIrjFXLf/hUuCrGaitNQv+hunrwi58eG4NHlJ6VOTyQNH
         ZNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848743; x=1693453543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jemklUFFCXuSkFimtib823G6Ct+c21vKLbvuJ2OztTU=;
        b=PY/lXGHgx3EavAXnTFk+TYi0zBVHPq4O6YBr+TlRnGXL8jWiHkn6CjbX8uj3wd04re
         HMBo/pTdosDcCRM4SELAvPk9RdZPDBAgW/f3ZLm9KSBLYE5XRPCfmSGi1jARhQbJR7J0
         mbmvqdUCdRzwlcw+c0T/bBNODQcJgUwGwAqwqkT2e/9Qp/ln9iTcSh2YMq6WS6OCo5F2
         X5P+GsWXYdv8aXOCklPsdMpsLzExNV826l7C+oOmcfr5JDBOQvtEiYm0R4jEWyfGcL8k
         zZZ/DyPECdEa7+R2LZFXXozUyyJ9T66s+zH6Cq+ZP3tPjcGxhanIRlvFpQUx/uQLb8S7
         B6uQ==
X-Gm-Message-State: AOJu0YyH/JtF4j/3VpBhUgmXGY1WStyQ1nOlSYFRxA5OpavRMIUXUuw2
        NRov+dvWRnMZM91CNCy0f6sOBQ==
X-Google-Smtp-Source: AGHT+IH5OwQqnaWM1iDwEtDztgpiT/vGMc3PO1GrsFb4dQKDl+nnRio//nIXOrYlRi+zRRJZJd2wxA==
X-Received: by 2002:a05:6a20:a10c:b0:13e:1d49:7249 with SMTP id q12-20020a056a20a10c00b0013e1d497249mr15190972pzk.2.1692848743163;
        Wed, 23 Aug 2023 20:45:43 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:45:42 -0700 (PDT)
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
        Jan Kara <jack@suse.com>
Subject: [PATCH v5 13/45] quota: dynamically allocate the dquota-cache shrinker
Date:   Thu, 24 Aug 2023 11:42:32 +0800
Message-Id: <20230824034304.37411-14-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the dquota-cache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Jan Kara <jack@suse.com>
---
 fs/quota/dquot.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9e72bfe8bbad..c303cffdf433 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -791,12 +791,6 @@ dqcache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	percpu_counter_read_positive(&dqstats.counter[DQST_FREE_DQUOTS]));
 }
 
-static struct shrinker dqcache_shrinker = {
-	.count_objects = dqcache_shrink_count,
-	.scan_objects = dqcache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
-
 /*
  * Safely release dquot and put reference to dquot.
  */
@@ -2956,6 +2950,7 @@ static int __init dquot_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
+	struct shrinker *dqcache_shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -2990,8 +2985,15 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
-		panic("Cannot register dquot shrinker");
+	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
+	if (!dqcache_shrinker)
+		panic("Cannot allocate dquot shrinker");
+
+	dqcache_shrinker->count_objects = dqcache_shrink_count;
+	dqcache_shrinker->scan_objects = dqcache_shrink_scan;
+	dqcache_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(dqcache_shrinker);
 
 	return 0;
 }
-- 
2.30.2

