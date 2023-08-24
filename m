Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E3786652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbjHXDwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbjHXDuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:50:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5450A270D
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so756315b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848913; x=1693453713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC9WqkIww9J/yjcNVRfpW3XQ6AEKQ/LjI/iUfI4jlaA=;
        b=glrCcAGlI9tORwLN4JeOX2Ojmpg3nd+ma/3S7SfNP2JPT41zIZ0IQM10eTVKPLkYqI
         pg2c3cj/mxF72M7VVk2LY+U28qMFYAPfxu7KPD67Jpu5o7z+DfyV007ggfjzdgLysN82
         cVDAiZHzpVRc6gETtIv1NBFK6Hvgz9JH2aOGng4fmagYixWYge8xFOfj1w99o4OKSpcR
         lqLQMu8XVXXZKfG0W+wqfQnFIKtFhj4kiY4i3y6Fokx88A3jo9QjLRBpri3lqrfzuIJu
         U/0aQHnJg90B6KEbY8BJ7rA54knmfENUkK0fN4nXKSLjT+G6swoIKswdwLSd7IVK09ma
         wTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848913; x=1693453713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC9WqkIww9J/yjcNVRfpW3XQ6AEKQ/LjI/iUfI4jlaA=;
        b=LN0d5fHZ8deXcHftQgU7FEpBMn3jS2J1a69/aKMvkD1sKD8aNemPrqoEpU7l3us2qA
         MFXGuInMuUDoHeR9dUOY8IDQRAhPC73Ed/vetBWuKV3cxho1vYffJ0W2EMI3DWModapf
         +w1VGnHw1XIKyE+Y5ytm7gt81dH7j8qyQ6yd6BrDSFlxtiq5NQBf50agxHq5d8OofVLq
         8jSVnKZO1HVsyn9pZ60ol/sjxIjOBie86PPY6uHjKuwJv08UCd3vJV3ktfokxmjuExlp
         VNWdXy5Zdg+4XKohIA25nnnk8KHVI4nPk70RmLQj+zyFUDBidZ55trbn1rvV4xqdInPF
         uYoA==
X-Gm-Message-State: AOJu0Yyyt+iZAIcuww9eIkmAdKIImp9WLIboDKykzH8KkypIu7YcwHh0
        3D6XY4qqJ8/BpRJqKtqcw8lnDA==
X-Google-Smtp-Source: AGHT+IEQ29rJQXeZVflVKNLar0GggbK4xIRfj9VbHOaq33vMQI6xRJWrdG4vksRQlcd6vKsocE2yjA==
X-Received: by 2002:a05:6a21:78aa:b0:133:7a67:b477 with SMTP id bf42-20020a056a2178aa00b001337a67b477mr18675611pzc.1.1692848913047;
        Wed, 23 Aug 2023 20:48:33 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:48:32 -0700 (PDT)
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
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v5 32/45] nfsd: dynamically allocate the nfsd-client shrinker
Date:   Thu, 24 Aug 2023 11:42:51 +0800
Message-Id: <20230824034304.37411-33-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-client shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct nfsd_net.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: linux-nfs@vger.kernel.org
---
 fs/nfsd/netns.h     |  2 +-
 fs/nfsd/nfs4state.c | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..f669444d5336 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -195,7 +195,7 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
-	struct shrinker		nfsd_client_shrinker;
+	struct shrinker		*nfsd_client_shrinker;
 	struct work_struct	nfsd_shrinker_work;
 };
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4c6a94a9699d..b2742065a813 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4400,8 +4400,7 @@ static unsigned long
 nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int count;
-	struct nfsd_net *nn = container_of(shrink,
-			struct nfsd_net, nfsd_client_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	count = atomic_read(&nn->nfsd_courtesy_clients);
 	if (!count)
@@ -8149,12 +8148,17 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
-	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
-	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
-	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
-
-	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
+	nn->nfsd_client_shrinker = shrinker_alloc(0, "nfsd-client");
+	if (!nn->nfsd_client_shrinker)
 		goto err_shrinker;
+
+	nn->nfsd_client_shrinker->scan_objects = nfsd4_state_shrinker_scan;
+	nn->nfsd_client_shrinker->count_objects = nfsd4_state_shrinker_count;
+	nn->nfsd_client_shrinker->seeks = DEFAULT_SEEKS;
+	nn->nfsd_client_shrinker->private_data = nn;
+
+	shrinker_register(nn->nfsd_client_shrinker);
+
 	return 0;
 
 err_shrinker:
@@ -8252,7 +8256,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	unregister_shrinker(&nn->nfsd_client_shrinker);
+	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
-- 
2.30.2

