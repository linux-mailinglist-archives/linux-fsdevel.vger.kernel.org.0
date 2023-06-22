Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F50739B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjFVI6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjFVI5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:57:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BA270E
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b693afe799so2465005ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424140; x=1690016140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qqb5b2GNvTgVTRVLR7iEMYBQ9KFY39GKHYb23c1SNH4=;
        b=DTUuH0I9uHLii3LJ9Zyuu9c+EPbxYZC20xJ5+3ma+Kp5qpBNFOFTSMnclhdsEVCqLi
         IhMw89U+Z8kUvjOX0p1/U1TPShfVW/vJXGuaCCTRG1bGCD9nXSC4/ZiagSGalcNeTARf
         jURjtWkQSw5PrzWP1wBPTMrMWiplRo47rrBJgWE68ZF11RySU51PM2cKEbziuuvrByZZ
         Zy6z/i7b8JtNNsvUGe9g7/sl4BzjGsT0dMzcCmwPn8WMxyE8EEE7gXWjStqzol2ehPl/
         69+rSZ9IFQ8XiOW8vY+908jjX5pcw5aN354YWworQkitYsT+fnzRPZItmEL7YHvgl8Dv
         6USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424140; x=1690016140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqb5b2GNvTgVTRVLR7iEMYBQ9KFY39GKHYb23c1SNH4=;
        b=URamXAGaSaHwEqlm1fy67FQbxFR/P8aI93ujIBtT0QzYPWkvlKCJSXo01FxIMqfYNJ
         7ZmMnTs4/OpRrWOUO1B0ouI+PA1ykeqwuD02UrMhywYClDnsAq0j2fddXjaWGvQRg2ts
         3CFFmGixlk1bqlmm0Mel+8an67NvM24c+dLv8B8lwQdbZEBAvcNB3fBbGze8ALDvwljI
         ZSJ+yOl5IFq5FSRzgd2yGD5sCqVrTGvussr1/23TtAq2k0bbR2QgpXiVNNEhrwXa4dAt
         pR9TpGdO9VB5s9JhzLOdw0WlcPp8O2iQUJkKzfzauKQqmCXpxW25jV+KnAcgfrR+2oD2
         ez5w==
X-Gm-Message-State: AC+VfDxk9SRdgYRKAJ3Jis23vDOmx9B+cWRlz3Dfj1pNb1VdJWwQORYJ
        LuVdP5JLXWOONjQTT1rD+Qw6eQ==
X-Google-Smtp-Source: ACHHUZ4U5RlW8/2AChRXKukLEKek4tD/ljCLASAoWCRPvf/eu3Wdfis/k+W/YQGMZOvsRYh9ePd5+g==
X-Received: by 2002:a17:902:d509:b0:1af:a349:3f31 with SMTP id b9-20020a170902d50900b001afa3493f31mr21732029plg.3.1687424140189;
        Thu, 22 Jun 2023 01:55:40 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:39 -0700 (PDT)
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
Subject: [PATCH 12/29] mbcache: dynamically allocate the mbcache shrinker
Date:   Thu, 22 Jun 2023 16:53:18 +0800
Message-Id: <20230622085335.77010-13-zhengqi.arch@bytedance.com>
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
we need to dynamically allocate the mbcache shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct mb_cache.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/mbcache.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 2a4b8b549e93..fec393e55a66 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -37,7 +37,7 @@ struct mb_cache {
 	struct list_head	c_list;
 	/* Number of entries in cache */
 	unsigned long		c_entry_count;
-	struct shrinker		c_shrink;
+	struct shrinker		*c_shrink;
 	/* Work for shrinking when the cache has too many entries */
 	struct work_struct	c_shrink_work;
 };
@@ -293,8 +293,7 @@ EXPORT_SYMBOL(mb_cache_entry_touch);
 static unsigned long mb_cache_count(struct shrinker *shrink,
 				    struct shrink_control *sc)
 {
-	struct mb_cache *cache = container_of(shrink, struct mb_cache,
-					      c_shrink);
+	struct mb_cache *cache = shrink->private_data;
 
 	return cache->c_entry_count;
 }
@@ -333,8 +332,8 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 static unsigned long mb_cache_scan(struct shrinker *shrink,
 				   struct shrink_control *sc)
 {
-	struct mb_cache *cache = container_of(shrink, struct mb_cache,
-					      c_shrink);
+	struct mb_cache *cache = shrink->private_data;
+
 	return mb_cache_shrink(cache, sc->nr_to_scan);
 }
 
@@ -370,26 +369,30 @@ struct mb_cache *mb_cache_create(int bucket_bits)
 	cache->c_hash = kmalloc_array(bucket_count,
 				      sizeof(struct hlist_bl_head),
 				      GFP_KERNEL);
-	if (!cache->c_hash) {
-		kfree(cache);
-		goto err_out;
-	}
+	if (!cache->c_hash)
+		goto err_c_hash;
+
 	for (i = 0; i < bucket_count; i++)
 		INIT_HLIST_BL_HEAD(&cache->c_hash[i]);
 
-	cache->c_shrink.count_objects = mb_cache_count;
-	cache->c_shrink.scan_objects = mb_cache_scan;
-	cache->c_shrink.seeks = DEFAULT_SEEKS;
-	if (register_shrinker(&cache->c_shrink, "mbcache-shrinker")) {
-		kfree(cache->c_hash);
-		kfree(cache);
-		goto err_out;
-	}
+	cache->c_shrink = shrinker_alloc_and_init(mb_cache_count, mb_cache_scan,
+						  0, DEFAULT_SEEKS, 0, cache);
+	if (!cache->c_shrink)
+		goto err_shrinker;
+
+	if (register_shrinker(cache->c_shrink, "mbcache-shrinker"))
+		goto err_register;
 
 	INIT_WORK(&cache->c_shrink_work, mb_cache_shrink_worker);
 
 	return cache;
 
+err_register:
+	shrinker_free(cache->c_shrink);
+err_shrinker:
+	kfree(cache->c_hash);
+err_c_hash:
+	kfree(cache);
 err_out:
 	return NULL;
 }
@@ -406,7 +409,7 @@ void mb_cache_destroy(struct mb_cache *cache)
 {
 	struct mb_cache_entry *entry, *next;
 
-	unregister_shrinker(&cache->c_shrink);
+	unregister_and_free_shrinker(cache->c_shrink);
 
 	/*
 	 * We don't bother with any locking. Cache must not be used at this
-- 
2.30.2

