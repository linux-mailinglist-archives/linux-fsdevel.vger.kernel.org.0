Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA7772159
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjHGLVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjHGLUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:20:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB23AB5
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 04:19:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-790b9d7d643so44591039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 04:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407059; x=1692011859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+7Rjo519K3FhaZ9jqPWNUITMom2L2BqSXFVMuCYJXE=;
        b=ip0wYuQW2+/exFbWgV8xiqSMo5oTQ+OAdV6N1Ar0LEuRT0eIq620KDbMvERQspVuIX
         AL+wevZXKdon9YRPQjclhoX9H3SrxByFFe9jR5690ffz3lESe4Q0ZFhT9ousgzw0xt/w
         5RRxxYEFUQ/KP/U5y/hPXXWHBw2c8mi1xHmKIZ7mZeQKJVTuYBj/qteoNFG9SyZ1tjUE
         RbAUg65PVJJ+WhDtWwqZYb434jDUE36PynN0DkYIbM09s/1BNwwPxkk2HM9wFLeNzyaL
         lqpAqgXw+Mhtz5SgHNy0c1hVzxk4Y6rOc9m8zwrbUN+lDejRoW7+lKGMq2jSF6Ub2+cH
         D5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407059; x=1692011859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+7Rjo519K3FhaZ9jqPWNUITMom2L2BqSXFVMuCYJXE=;
        b=PyOe3hEz/SX6X91URKE6FhmbRNgQMW9mfKdyepEi8v8dCRl4O43TyjfA7nN+w+p9Rd
         PazEu9pc71c7lfmCWNslq5udMdxBLMdEe6e2mmiuwHcK5v+02DeGLekljtpki50sv1OX
         vQgKWcL13OiQyiPiGSrvpCI09jytwUrpUQMs1a7BbKoFgLYP1aiQNUklpWPtNKQTFrri
         WBLahA0mtDBfPqwIg8165xHnbdfYnITjKlO5mmpUOoeJT2mCSU1UwOlOipB4W/Bfbl8d
         bDEpy/70gsmnrrfxb7WvUpq7XC6L/z9gynTheNk/nWQHMllxhL5+Nzqv1mCWxLJW1Uy6
         jBig==
X-Gm-Message-State: ABy/qLZV8khmRt7UEMC45U0RgNFt6Ta1uI8rGGxbDqwW33xxhZzvqsXy
        IHpJrmHuJyPBHz90p6PbsUOHDA==
X-Google-Smtp-Source: APBJJlEqWtJMEzUOeETqs91YS6OhZnccr6gvE839NK54utINPmY3rqSAbE5saT2wFNMSrRFNpkUXNA==
X-Received: by 2002:a05:6e02:8ef:b0:349:1d60:7250 with SMTP id n15-20020a056e0208ef00b003491d607250mr23020165ilt.0.1691407058833;
        Mon, 07 Aug 2023 04:17:38 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:17:38 -0700 (PDT)
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
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 36/48] nfsd: dynamically allocate the nfsd-reply shrinker
Date:   Mon,  7 Aug 2023 19:09:24 +0800
Message-Id: <20230807110936.21819-37-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-reply shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct nfsd_net.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
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
index 80621a709510..fd56a52aa5fb 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -201,26 +201,29 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
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
@@ -229,7 +232,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 
 	return 0;
 out_shrinker:
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	kvfree(nn->drc_hashtbl);
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -239,7 +242,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct nfsd_cacherep *rp;
 	unsigned int i;
 
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	shrinker_free(nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
@@ -323,8 +326,7 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	return atomic_read(&nn->num_drc_entries);
 }
@@ -343,8 +345,7 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
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

