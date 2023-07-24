Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1900675EFA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjGXJqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 05:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjGXJqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:46:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C610C8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:45:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba9539a23so639965ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690191943; x=1690796743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaxJS65ntPERL7le+nmtmDDoPHIKL7Svp/IgETL6ZeE=;
        b=bsUNhBCXwNUzkDR0ZBYGRWY6QU8jf6SXW0GNGt2FOx6GMmf4JYDUwOhZCN0a9aNwPh
         pTka7+wy4J6SiQlycedqXCWLDNsWz3aJioSMhFKKX+Cimy7bU+oF7hjqxyvShR8A2yEG
         Bu7LESrzTJZCH9TPtc2I9FzALspZlYdCLyw0Gn9itfPl/wiIrNjf25JL50bsQdJ04tcL
         SlbyOamKluDXUz4pmzuKSCdYj+rqtmnfikA7iqukCNA9GBpbd9F7GXY8//WwnDt8lif7
         VBbsqb4LU2WF81b1loSTallposIksCkIrM7zY2O8grvdOy/OC2xy9l8uFRAuNMFBjkRJ
         /Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191943; x=1690796743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaxJS65ntPERL7le+nmtmDDoPHIKL7Svp/IgETL6ZeE=;
        b=i2ePJyrDz4Oik3zrnMBF5+pY7pIf2HeKDMVToUmjmPvQrHFBMuY3Q/pU6NP637F0pC
         80ysFsItsuGI0k6KNFB/WjFLiO1ZegFtl8FlSD7HrGH3heL5KhIbp7SGTEoWiXEykmk7
         zn055HHBSD0/s/eKGxiUjfF/nDEseCwjAreE4dHD/qZxvyh5lTsUJqCLnzt7AGkw++Ua
         RzNLn1aSLzVgIdqMyOPKaMV5P+mXiU9HgIz5WlX1SHq1LOlezzwsA9zVCA38OH/V8esJ
         iIWtqoeHm3vAFzcHjtxz4Ia0h/q9XoUwEAaF+DfA8ijMb6gre8Nn7tTDi4Fx8Er9j6uZ
         wbvg==
X-Gm-Message-State: ABy/qLbB6l4laWM+NLny6y566hug592BqgzZdNnxJENaZ/ineJyzP/0u
        /MRsF9Sc2sWhVGncs6AikyuIJA==
X-Google-Smtp-Source: APBJJlGWwe+Wn5SAE9CC225imGBvK3oJNP2MQHqUiC6fnoUxBGqj3ofPftHC2Yw9p8SUIC56L+2IOQ==
X-Received: by 2002:a17:903:2305:b0:1b8:b0c4:2e3d with SMTP id d5-20020a170903230500b001b8b0c42e3dmr12236473plh.4.1690191942806;
        Mon, 24 Jul 2023 02:45:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:45:42 -0700 (PDT)
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
Subject: [PATCH v2 03/47] mm: shrinker: add infrastructure for dynamically allocating shrinker
Date:   Mon, 24 Jul 2023 17:43:10 +0800
Message-Id: <20230724094354.90817-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the shrinker instances can be divided into the following three
types:

a) global shrinker instance statically defined in the kernel, such as
   workingset_shadow_shrinker.

b) global shrinker instance statically defined in the kernel modules, such
   as mmu_shrinker in x86.

c) shrinker instance embedded in other structures.

For case a, the memory of shrinker instance is never freed. For case b,
the memory of shrinker instance will be freed after synchronize_rcu() when
the module is unloaded. For case c, the memory of shrinker instance will
be freed along with the structure it is embedded in.

In preparation for implementing lockless slab shrink, we need to
dynamically allocate those shrinker instances in case c, then the memory
can be dynamically freed alone by calling kfree_rcu().

So this commit adds the following new APIs for dynamically allocating
shrinker, and add a private_data field to struct shrinker to record and
get the original embedded structure.

1. shrinker_alloc()

Used to allocate shrinker instance itself and related memory, it will
return a pointer to the shrinker instance on success and NULL on failure.

2. shrinker_free_non_registered()

Used to destroy the non-registered shrinker instance.

3. shrinker_register()

Used to register the shrinker instance, which is same as the current
register_shrinker_prepared().

4. shrinker_unregister()

Used to unregister and free the shrinker instance.

In order to simplify shrinker-related APIs and make shrinker more
independent of other kernel mechanisms, subsequent submissions will use
the above API to convert all shrinkers (including case a and b) to
dynamically allocated, and then remove all existing APIs.

This will also have another advantage mentioned by Dave Chinner:

```
The other advantage of this is that it will break all the existing
out of tree code and third party modules using the old API and will
no longer work with a kernel using lockless slab shrinkers. They
need to break (both at the source and binary levels) to stop bad
things from happening due to using uncoverted shrinkers in the new
setup.
```

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h |   6 +++
 mm/shrinker.c            | 113 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 961cb84e51f5..296f5e163861 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -70,6 +70,8 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	void *private_data;
+
 	/* These are for internal use */
 	struct list_head list;
 #ifdef CONFIG_MEMCG
@@ -98,6 +100,10 @@ struct shrinker {
 
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
+struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
+void shrinker_free_non_registered(struct shrinker *shrinker);
+void shrinker_register(struct shrinker *shrinker);
+void shrinker_unregister(struct shrinker *shrinker);
 
 extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
 					    const char *fmt, ...);
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 0a32ef42f2a7..d820e4cc5806 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -548,6 +548,119 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 	return freed;
 }
 
+struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
+{
+	struct shrinker *shrinker;
+	unsigned int size;
+	va_list __maybe_unused ap;
+	int err;
+
+	shrinker = kzalloc(sizeof(struct shrinker), GFP_KERNEL);
+	if (!shrinker)
+		return NULL;
+
+#ifdef CONFIG_SHRINKER_DEBUG
+	va_start(ap, fmt);
+	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+	if (!shrinker->name)
+		goto err_name;
+#endif
+	shrinker->flags = flags;
+
+	if (flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (err == -ENOSYS)
+			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+		else if (err == 0)
+			goto done;
+		else
+			goto err_flags;
+	}
+
+	/*
+	 * The nr_deferred is available on per memcg level for memcg aware
+	 * shrinkers, so only allocate nr_deferred in the following cases:
+	 *  - non memcg aware shrinkers
+	 *  - !CONFIG_MEMCG
+	 *  - memcg is disabled by kernel command line
+	 */
+	size = sizeof(*shrinker->nr_deferred);
+	if (flags & SHRINKER_NUMA_AWARE)
+		size *= nr_node_ids;
+
+	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
+	if (!shrinker->nr_deferred)
+		goto err_flags;
+
+done:
+	return shrinker;
+
+err_flags:
+#ifdef CONFIG_SHRINKER_DEBUG
+	kfree_const(shrinker->name);
+	shrinker->name = NULL;
+err_name:
+#endif
+	kfree(shrinker);
+	return NULL;
+}
+EXPORT_SYMBOL(shrinker_alloc);
+
+void shrinker_free_non_registered(struct shrinker *shrinker)
+{
+#ifdef CONFIG_SHRINKER_DEBUG
+	kfree_const(shrinker->name);
+	shrinker->name = NULL;
+#endif
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		down_write(&shrinker_rwsem);
+		unregister_memcg_shrinker(shrinker);
+		up_write(&shrinker_rwsem);
+	}
+
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+
+	kfree(shrinker);
+}
+EXPORT_SYMBOL(shrinker_free_non_registered);
+
+void shrinker_register(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	list_add_tail(&shrinker->list, &shrinker_list);
+	shrinker->flags |= SHRINKER_REGISTERED;
+	shrinker_debugfs_add(shrinker);
+	up_write(&shrinker_rwsem);
+}
+EXPORT_SYMBOL(shrinker_register);
+
+void shrinker_unregister(struct shrinker *shrinker)
+{
+	struct dentry *debugfs_entry;
+	int debugfs_id;
+
+	if (!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))
+		return;
+
+	down_write(&shrinker_rwsem);
+	list_del(&shrinker->list);
+	shrinker->flags &= ~SHRINKER_REGISTERED;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
+	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
+	up_write(&shrinker_rwsem);
+
+	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
+
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+
+	kfree(shrinker);
+}
+EXPORT_SYMBOL(shrinker_unregister);
+
 /*
  * Add a shrinker callback to be called from the vm.
  */
-- 
2.30.2

