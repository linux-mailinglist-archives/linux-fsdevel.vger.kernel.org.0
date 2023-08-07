Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E7772144
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjHGLUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjHGLUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:20:13 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F230C8
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 04:18:39 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-56462258cdeso525776a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691406764; x=1692011564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXAG7UeexodYStcT1Y2gz+/6q+0E2xrK+D1h2eKApUE=;
        b=aL2IlnUybxJBSaUyx5/2hb4H2bp/OBgBmpkvxoB1jU+rSMlmYgotW9aghIyS5IGFTu
         jFnKPHdHImGCYC2E/ABE0MKtaUZM35JefrItnSynMzWwfh9y6Muq0ow4RXH7tUjQQfcP
         Mb/jNbJTqI64OH5TZAbe/9B64ipZHwjSbqJcPzS81ONTFfdvn1WQf8A1oxt4tY2+xFm3
         qLJTVdHdHHLy/H07ztqOBHi1YT6PCSLEiwm3BmVRH+v8KbcNGmsDXIWIkoSvX1jpUSeE
         +aIaBM9zmcPun7sjvVC0D+UUovECfFdX/YnWZ3U8UI2BqXU1g5ckeiBNnyvyn5q9jj5E
         E1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406764; x=1692011564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXAG7UeexodYStcT1Y2gz+/6q+0E2xrK+D1h2eKApUE=;
        b=UrzZYb4j5tEhwd4kYBjOfiTcQcs8T+mY66Dl/5BDJ8FJntN4bSwuJRCX6bSedsCS4B
         mRBAPMB7pKja1aRr5jsVnelTTyKjL5Bn7xIvegxyX+r5YjEAomZBsw1+JqEb2VyT9DJV
         KASBmDyM9+U3rtyoll7dQ7X1X2J0hmQ1FxyO6QHmfQc0wQamg3G87F7AtAiWocTZHUVv
         DFteDAKj7hXIb6bdig2xV//Fu1e1IcszkAsySYTH4QnC8dlOAKxF64w2tIRa1fi/TS16
         9Th9HJSDS/bAPyXKz+uPn6D8lO+VeGUuU9KBu6COAZ+TyK96qg7PGWd/Ej6xbuks9QUD
         35EQ==
X-Gm-Message-State: AOJu0Yxj/suuammAG//HaLE/mYgZKoGvHkphMNLnLnveD4Yv30+QNed+
        00Su5rpJbhpNtS0rUM0fgD/vUg==
X-Google-Smtp-Source: AGHT+IE0EldDhRUbVC2QQ5qQQy0UrFFq3L83zUgt+LShkd8AG+beTExy84fPX5FeRRz/rZ+raVP35g==
X-Received: by 2002:a17:90a:9c3:b0:269:41cf:7212 with SMTP id 61-20020a17090a09c300b0026941cf7212mr4959141pjo.4.1691406764622;
        Mon, 07 Aug 2023 04:12:44 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:12:44 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 13/48] NFSv4.2: dynamically allocate the nfs-xattr shrinkers
Date:   Mon,  7 Aug 2023 19:09:01 +0800
Message-Id: <20230807110936.21819-14-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the nfs-xattr shrinkers.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfs/nfs42xattr.c | 87 +++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 911f634ba3da..2ad66a8922f4 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -796,28 +796,9 @@ static unsigned long nfs4_xattr_cache_scan(struct shrinker *shrink,
 static unsigned long nfs4_xattr_entry_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
 
-static struct shrinker nfs4_xattr_cache_shrinker = {
-	.count_objects	= nfs4_xattr_cache_count,
-	.scan_objects	= nfs4_xattr_cache_scan,
-	.seeks		= DEFAULT_SEEKS,
-	.flags		= SHRINKER_MEMCG_AWARE,
-};
-
-static struct shrinker nfs4_xattr_entry_shrinker = {
-	.count_objects	= nfs4_xattr_entry_count,
-	.scan_objects	= nfs4_xattr_entry_scan,
-	.seeks		= DEFAULT_SEEKS,
-	.batch		= 512,
-	.flags		= SHRINKER_MEMCG_AWARE,
-};
-
-static struct shrinker nfs4_xattr_large_entry_shrinker = {
-	.count_objects	= nfs4_xattr_entry_count,
-	.scan_objects	= nfs4_xattr_entry_scan,
-	.seeks		= 1,
-	.batch		= 512,
-	.flags		= SHRINKER_MEMCG_AWARE,
-};
+static struct shrinker *nfs4_xattr_cache_shrinker;
+static struct shrinker *nfs4_xattr_entry_shrinker;
+static struct shrinker *nfs4_xattr_large_entry_shrinker;
 
 static enum lru_status
 cache_lru_isolate(struct list_head *item,
@@ -943,7 +924,7 @@ nfs4_xattr_entry_scan(struct shrinker *shrink, struct shrink_control *sc)
 	struct nfs4_xattr_entry *entry;
 	struct list_lru *lru;
 
-	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
+	lru = (shrink == nfs4_xattr_large_entry_shrinker) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
 	freed = list_lru_shrink_walk(lru, sc, entry_lru_isolate, &dispose);
@@ -971,7 +952,7 @@ nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long count;
 	struct list_lru *lru;
 
-	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
+	lru = (shrink == nfs4_xattr_large_entry_shrinker) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
 	count = list_lru_shrink_count(lru, sc);
@@ -991,18 +972,34 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
 
-static int nfs4_xattr_shrinker_init(struct shrinker *shrinker,
-				    struct list_lru *lru, const char *name)
+typedef unsigned long (*count_objects_cb)(struct shrinker *s,
+					  struct shrink_control *sc);
+typedef unsigned long (*scan_objects_cb)(struct shrinker *s,
+					 struct shrink_control *sc);
+
+static int __init nfs4_xattr_shrinker_init(struct shrinker **shrinker,
+					   struct list_lru *lru, const char *name,
+					   count_objects_cb count,
+					   scan_objects_cb scan, long batch, int seeks)
 {
-	int ret = 0;
+	int ret;
 
-	ret = register_shrinker(shrinker, name);
-	if (ret)
+	*shrinker = shrinker_alloc(SHRINKER_MEMCG_AWARE, name);
+	if (!*shrinker)
+		return -ENOMEM;
+
+	ret = list_lru_init_memcg(lru, *shrinker);
+	if (ret) {
+		shrinker_free(*shrinker);
 		return ret;
+	}
 
-	ret = list_lru_init_memcg(lru, shrinker);
-	if (ret)
-		unregister_shrinker(shrinker);
+	(*shrinker)->count_objects = count;
+	(*shrinker)->scan_objects = scan;
+	(*shrinker)->batch = batch;
+	(*shrinker)->seeks = seeks;
+
+	shrinker_register(*shrinker);
 
 	return ret;
 }
@@ -1010,7 +1007,7 @@ static int nfs4_xattr_shrinker_init(struct shrinker *shrinker,
 static void nfs4_xattr_shrinker_destroy(struct shrinker *shrinker,
 					struct list_lru *lru)
 {
-	unregister_shrinker(shrinker);
+	shrinker_free(shrinker);
 	list_lru_destroy(lru);
 }
 
@@ -1026,27 +1023,31 @@ int __init nfs4_xattr_cache_init(void)
 		return -ENOMEM;
 
 	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_cache_shrinker,
-				       &nfs4_xattr_cache_lru,
-				       "nfs-xattr_cache");
+				       &nfs4_xattr_cache_lru, "nfs-xattr_cache",
+				       nfs4_xattr_cache_count,
+				       nfs4_xattr_cache_scan, 0, DEFAULT_SEEKS);
 	if (ret)
 		goto out1;
 
 	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_entry_shrinker,
-				       &nfs4_xattr_entry_lru,
-				       "nfs-xattr_entry");
+				       &nfs4_xattr_entry_lru, "nfs-xattr_entry",
+				       nfs4_xattr_entry_count,
+				       nfs4_xattr_entry_scan, 512, DEFAULT_SEEKS);
 	if (ret)
 		goto out2;
 
 	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_large_entry_shrinker,
 				       &nfs4_xattr_large_entry_lru,
-				       "nfs-xattr_large_entry");
+				       "nfs-xattr_large_entry",
+				       nfs4_xattr_entry_count,
+				       nfs4_xattr_entry_scan, 512, 1);
 	if (!ret)
 		return 0;
 
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_entry_shrinker,
 				    &nfs4_xattr_entry_lru);
 out2:
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_cache_shrinker,
 				    &nfs4_xattr_cache_lru);
 out1:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
@@ -1056,11 +1057,11 @@ int __init nfs4_xattr_cache_init(void)
 
 void nfs4_xattr_cache_exit(void)
 {
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_large_entry_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_large_entry_shrinker,
 				    &nfs4_xattr_large_entry_lru);
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_entry_shrinker,
 				    &nfs4_xattr_entry_lru);
-	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+	nfs4_xattr_shrinker_destroy(nfs4_xattr_cache_shrinker,
 				    &nfs4_xattr_cache_lru);
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 }
-- 
2.30.2

