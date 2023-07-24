Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52A75F2C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGXKTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjGXKSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:18:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E365A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:10:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-576db978e8aso5205337b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193404; x=1690798204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeaWGlGrVDaX2KSqXlTQooW5ZfkYFYzGyaP55BE4cnU=;
        b=a2PE/VqAYxZormHldFHSmv31dk/N4jh/e+b2hxkQoGyouQEb0COvSrth6SQBXF33ef
         S67ToBGBKoDzrj5DjBKiv8TaMHQu7TmahWZRUfwyv6mWRMX7tH7sQ4iYeog9YINBoOBv
         N1HBcK0oBn8gQGlnVuzteVMgEtPeiZquAXMP2t93EEJdjj14rxdDAq+7eFsvV5Jvvsue
         otJTLdfiyKOJ9E7V6Aki0RmK+wc1Ymc1u6euiY5vYp/SlAy5x453F6iFSc12U8WzxcvD
         cbdKo3cTglT6x3gNbR28aI+1S9tLlcDbAemNpTTOcdXUxrN48qHGz8FRvJQFGuaO1osn
         L+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193404; x=1690798204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeaWGlGrVDaX2KSqXlTQooW5ZfkYFYzGyaP55BE4cnU=;
        b=lvUvsVj2vJl+dgFHB6564CgbgndVJCRG35G/zRhnPpvjs60YkJSideszijTBMD5C8O
         /nAh7R5eokLVXluzY1tZp4tRkMnpQACgzqVac4kVo5+Qa2n2YHbRSBwQr5o0FrBMFuXZ
         rATiNawmFMwzgvA4lWY5f+0uW0cVFuEPY5lWJ0HAN5y++lZOkyIedCCl0zjsLDYlNW2u
         LeKfx/GrEKiLf/T+qDnmXm2jYjnsvFLLya/9sy00Gyuma3a2jeKBCsZeu1NY1wUBQU7O
         U7OmxgZZieCIWnYO/5Nlo0w/4u1cQ+m3IwucJBfODCjflZZXx2F1B9cYgiR08jQGEpv3
         NVFw==
X-Gm-Message-State: ABy/qLYRtwZpj56+8E1WX3/l9WuH7tWAB4iFIhWrXb5ptB66JtIkfC33
        Aqv+aaWm5MiU+aa8bWm450RZyXyY/Q3/hmSTfaw=
X-Google-Smtp-Source: APBJJlEv/cxcU4CX85hgEplaAz1eX7+5tW063l2dwuRz+2PjFKejJ2gbKnkgXcFETviQG8sX+JGIQQ==
X-Received: by 2002:a17:902:ecce:b0:1b8:b55d:4cff with SMTP id a14-20020a170902ecce00b001b8b55d4cffmr12430579plh.2.1690192326485;
        Mon, 24 Jul 2023 02:52:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:52:06 -0700 (PDT)
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 35/47] nfsd: dynamically allocate the nfsd-reply shrinker
Date:   Mon, 24 Jul 2023 17:43:42 +0800
Message-Id: <20230724094354.90817-36-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-reply shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct nfsd_net.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/nfsd/netns.h    |  2 +-
 fs/nfsd/nfscache.c | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index f669444d5336..ab303a8b77d5 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -177,7 +177,7 @@ struct nfsd_net {
 	/* size of cache when we saw the longest hash chain */
 	unsigned int             longest_chain_cachesize;
 
-	struct shrinker		nfsd_reply_cache_shrinker;
+	struct shrinker		*nfsd_reply_cache_shrinker;
 
 	/* tracking server-to-server copy mounts */
 	spinlock_t              nfsd_ssc_lock;
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 6eb3d7bdfaf3..9f0ab65e4125 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -200,26 +200,29 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
 	unsigned int i;
-	int status = 0;
 
 	nn->max_drc_entries = nfsd_cache_size_limit();
 	atomic_set(&nn->num_drc_entries, 0);
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
-	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
-	nn->nfsd_reply_cache_shrinker.seeks = 1;
-	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
-				   "nfsd-reply:%s", nn->nfsd_name);
-	if (status)
-		return status;
-
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
 	if (!nn->drc_hashtbl)
+		return -ENOMEM;
+
+	nn->nfsd_reply_cache_shrinker = shrinker_alloc(0, "nfsd-reply:%s",
+						       nn->nfsd_name);
+	if (!nn->nfsd_reply_cache_shrinker)
 		goto out_shrinker;
 
+	nn->nfsd_reply_cache_shrinker->scan_objects = nfsd_reply_cache_scan;
+	nn->nfsd_reply_cache_shrinker->count_objects = nfsd_reply_cache_count;
+	nn->nfsd_reply_cache_shrinker->seeks = 1;
+	nn->nfsd_reply_cache_shrinker->private_data = nn;
+
+	shrinker_register(nn->nfsd_reply_cache_shrinker);
+
 	for (i = 0; i < hashsize; i++) {
 		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);
 		spin_lock_init(&nn->drc_hashtbl[i].cache_lock);
@@ -228,7 +231,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 
 	return 0;
 out_shrinker:
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	kvfree(nn->drc_hashtbl);
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -238,7 +241,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct nfsd_cacherep *rp;
 	unsigned int i;
 
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	shrinker_unregister(nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
@@ -322,8 +325,7 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	return atomic_read(&nn->num_drc_entries);
 }
@@ -342,8 +344,7 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 	unsigned long freed = 0;
 	LIST_HEAD(dispose);
 	unsigned int i;
-- 
2.30.2

