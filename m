Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB956F3416
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjEAQ50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjEAQ42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:56:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07A10C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:55:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7df507c5so5360396276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960131; x=1685552131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDL+lQo0P3G6fblFMKJonaRbqsrkB9ljveMgEFO8c80=;
        b=MVmPTJvnt/d4OHnObDpLo5Yx/m0JxigNMHefGJUQ6YHCHiKWwXI+TPB1lVnlbOYOEt
         5jgACI5oKYMCB7Pq7cz3X81+bpZcuEUKDUynk+/ZyYCZwjUk5TCfCarGFU4MMvcurlND
         oln4td3qiCopzaVDD/Q4rMLFlXyQJx4wDKAU0Wzgmky/qZcwJ14zhRRSwMOBlU9Kez/h
         x9gFamkwY5h9zdy2v/nUepQsOsBIbNt92VQg8iIvlxGC803m7Adm/vEjtGzf8sBaILXc
         DjUHk8NLlqyBasCJKVPDW64fh5SwGVhMkreauSlsOSNHTVu6NR6T/SSX4RnGRR6l1W62
         EEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960131; x=1685552131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDL+lQo0P3G6fblFMKJonaRbqsrkB9ljveMgEFO8c80=;
        b=lVDK1qqLvcZDVS60AxaoXebsmVJx2aT2lInoiKjXH7Mxcy25G2v8iJsN+M/UH2TcCi
         5PUYbaZ/T6Tao59x7BiZ/m7CACyZ2fYinqEXx3oo57QvN76jmJ5ehCoT2uuNtTNsgXfB
         UMqzUgN8YBRh2zRzl3laydMIuiYaJN8AD7D/hv2nRm2I6HF/4pJRQEKSNW5z5JFlnFxV
         z8zXdyguEIWvU8n3SMK8ZybpYvcSdMXZVpmPD7ltdIfd94XABtVxV5j3RGJwty9Xi3ET
         Fbcx6NQsixyhFVDKLTG6rSyGMjWRggD3+Ed/w0UJCZve1XdCPU6AkGys5BXtvn0SYVwo
         C3Ig==
X-Gm-Message-State: AC+VfDxSIBDNAj2m93GbeBAOs8hQZe5Am9t/A1MTya1UsAZoC+95wj/g
        1FEWQIcECGd/OMs3WaM+AhuStWlfQu4=
X-Google-Smtp-Source: ACHHUZ6enP7kBREmhiQ0i0LYDuH3RuGEJuyGpBzYXGRy3FeK34ct4OWkfjl1R+bRIQUodsczhvp1FyVsBhk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:6b05:0:b0:b8b:f5fb:5986 with SMTP id
 g5-20020a256b05000000b00b8bf5fb5986mr8475612ybc.10.1682960131180; Mon, 01 May
 2023 09:55:31 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:20 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-11-surenb@google.com>
Subject: [PATCH 10/40] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/slab.h | 7 +++++++
 mm/slab.c            | 2 +-
 mm/slub.c            | 5 +++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6b3e155b70bf..99a146f3cedf 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -147,6 +147,13 @@
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/* Slab created using create_boot_cache */
+#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_NO_OBJ_EXT         0
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.c b/mm/slab.c
index bb57f7fdbae1..ccc76f7455e9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1232,7 +1232,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 		offsetof(struct kmem_cache, node) +
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
-				  SLAB_HWCACHE_ALIGN, 0, 0);
+				  SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 	list_add(&kmem_cache->list, &slab_caches);
 	slab_state = PARTIAL;
 
diff --git a/mm/slub.c b/mm/slub.c
index c87628cd8a9a..507b71372ee4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5020,7 +5020,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5030,7 +5031,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.40.1.495.gc816e09b53d-goog

