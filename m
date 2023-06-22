Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E3E739B9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFVJBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVJAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:00:25 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5746E3598
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:56:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-54fd4a7ce25so1096259a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424172; x=1690016172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUNTs2D5J+Px6+8NyTz0IGsKdVlRq3fVdCNXQo6zMeo=;
        b=PB56VJEtwK39jb6ujoKeOUgYB/PJLrruyxKRjJr7vrytJTdiBm6YHrGem+eoP0b4tN
         ySO0Fp6iHJx1jYG5cUtED8VGJ9nuR5OzkvfKjRzGq011b3+5HaAEFO0JOZ1JrJyRnWbE
         zD+J47hPkoBpD2IoCQquNzCqiGwmlgwN3y5YbOJ5VGLqEl2FtVJoITLOXOxAzhFddu+k
         6lt/tmVHj10PbE9jdwz/MvuKMpEDpm3abrU9F/6h0dgBlWZ5OjmzxDq5+jKr9MCDVLPh
         Sp8IUY5vM81KMKjfLSjlTI62E4wEBy9NQ8VxDpQ2xwoZwC4ItSHDc6u/r/EGjzaiDmrG
         iUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424172; x=1690016172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUNTs2D5J+Px6+8NyTz0IGsKdVlRq3fVdCNXQo6zMeo=;
        b=lD2n+c4cfFTVDEBHQXZ0oio2ZtJDnwT/NUMONnkACVv+v5XectbmJGb/h/Iv7CVknd
         pQEVGuE+GJwae3o/1umJTVesOHO3uYL1eD7PaeL9xmXzkFSuTS2HjvNq7c0ShuKUNWWG
         8ldFh3TgDZw6oWM4EhltPUbH4yR1IBj79TyDMtkMlda1e0Sy+nXvE09L6HUiB+xwl0Vx
         5qiNeRy3iE7YghY7el0zZkztpbHxXfPbt+LtIi31fVI32Et2RoZKFHBxW8powgKoLImd
         tYaTm0fBaZX7GN2sxtLkyhK/AVzXQ6M+jsrnBEp8NnEs5ZVWRdrSqoitlSrHYLPD/qTA
         MSFg==
X-Gm-Message-State: AC+VfDzyQECsiTQau7YBMZFZqv1gGvQrrk1nhwmUultiQJ06Tc353vqJ
        /HWo6MT21DjasUlSQ5OBSD9raw==
X-Google-Smtp-Source: ACHHUZ7RZPPxDHHt9nXlq48w0UysjH5yX+GnVgYNyQdTPpVzG1MBfOvOCSKK+16aR/H5lLV5H8OFJg==
X-Received: by 2002:a17:902:f688:b0:1ad:e3a8:3c4 with SMTP id l8-20020a170902f68800b001ade3a803c4mr20681104plg.4.1687424171977;
        Thu, 22 Jun 2023 01:56:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:56:11 -0700 (PDT)
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
Subject: [PATCH 16/29] NFSD: dynamically allocate the nfsd-reply shrinker
Date:   Thu, 22 Jun 2023 16:53:22 +0800
Message-Id: <20230622085335.77010-17-zhengqi.arch@bytedance.com>
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
we need to dynamically allocate the nfsd-reply shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct nfsd_net.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/nfsd/netns.h    |  2 +-
 fs/nfsd/nfscache.c | 33 +++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 15 deletions(-)

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
index 041faa13b852..ec33de8e418b 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -173,19 +173,23 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	if (status)
 		goto out_nomem;
 
-	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
-	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
-	nn->nfsd_reply_cache_shrinker.seeks = 1;
-	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
-				   "nfsd-reply:%s", nn->nfsd_name);
-	if (status)
-		goto out_stats_destroy;
-
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
 	if (!nn->drc_hashtbl)
+		goto out_stats_destroy;
+
+	nn->nfsd_reply_cache_shrinker =
+		shrinker_alloc_and_init(nfsd_reply_cache_count,
+					nfsd_reply_cache_scan,
+					0, 1, 0, nn);
+	if (!nn->nfsd_reply_cache_shrinker)
 		goto out_shrinker;
 
+	status = register_shrinker(nn->nfsd_reply_cache_shrinker,
+				   "nfsd-reply:%s", nn->nfsd_name);
+	if (status)
+		goto out_register;
+
 	for (i = 0; i < hashsize; i++) {
 		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);
 		spin_lock_init(&nn->drc_hashtbl[i].cache_lock);
@@ -193,8 +197,11 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	nn->drc_hashsize = hashsize;
 
 	return 0;
+
+out_register:
+	shrinker_free(nn->nfsd_reply_cache_shrinker);
 out_shrinker:
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	kvfree(nn->drc_hashtbl);
 out_stats_destroy:
 	nfsd_reply_cache_stats_destroy(nn);
 out_nomem:
@@ -207,7 +214,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct svc_cacherep	*rp;
 	unsigned int i;
 
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	unregister_and_free_shrinker(nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
@@ -297,8 +304,7 @@ prune_cache_entries(struct nfsd_net *nn)
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	return atomic_read(&nn->num_drc_entries);
 }
@@ -306,8 +312,7 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	return prune_cache_entries(nn);
 }
-- 
2.30.2

