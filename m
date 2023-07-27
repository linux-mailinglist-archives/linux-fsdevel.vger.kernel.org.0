Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF4764DC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjG0Ijp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjG0IiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:38:01 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626216C0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:20:38 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so168983b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445734; x=1691050534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ij/O+E/bk/tTzX9mgxwiCynzBHcXx4EKtI9EsHayo=;
        b=j4pDVeMcXcw7i7IAx1DNlz6iKEYUEIabVz59nN5q7bAhCS1y2gOKuzdzTgG4j/dBwO
         H4HIbZq+pOLjZVM5UGP2bbBpIOa2ebzQlUp84F0j/JFisMPJqEmZ2hJuFivDCiuZb9qk
         P5NgTQLX0gtg3X+vGmP6/3oCCgeQ9FljDUkAtb6pQhQ/VT+3lIzONbNoOLFITLjS+g+5
         Vjj6M2H3z3FRG2iT9u3T7VH/LPW2zOuTNtSoF+jLae0SEMd2/P/I3VxNY7Hl9q3RH2MH
         NSqRY7EFleJMoWuU3X7ly6d0/rJ15DhvMCCJQ4sCCtoszhR0yDF7rbG/n/mEuDtWN3AJ
         wtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445734; x=1691050534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5ij/O+E/bk/tTzX9mgxwiCynzBHcXx4EKtI9EsHayo=;
        b=Y7leeiAEAoCQ4ZLac8bYsxvO3+dq0Glr6zaA5eTqbZvIYkvG4TZBCwLaOI1jaIq4vn
         O1Qy+3OyZKcbIxucaj/xD9Vb4xKw99Yglq+Xz9T3jdwuoM8UqOeZKFaCA69+wbJ/KcKk
         w/yZMhU4kGPSxr8OtgnZMQbzsF2hWTuojUmKjnzBLLM+5E4rgt2gKVGaMQHwnh7Dhh83
         npZCWnOcJhTGD4mT77xrCyZr6sMqj9uaqfquAYqTNqMb1OrJPJX4tnSqFXmT4Qc0QQoN
         pR+DHbw461pqJQ3gQapclDeAuIperbelfKEWI6mmPrbrphwCyALGMpMp2/Nt5XeoMTdB
         oyhA==
X-Gm-Message-State: ABy/qLaJskn+PfmZjVCh/eH5aYLZAUn3N1E00tSj6v0Il9mep5d6c54j
        X9+Jue4+iNIwWL9QHO1LQ7TtYw==
X-Google-Smtp-Source: APBJJlGCk2Vrs4jG84R1mGLjwsvlQmrr2Zz0KCmUr/tZ9etimLEYhkynVpF/d5AFiEeYea7/v2C0Wg==
X-Received: by 2002:a05:6a20:7d87:b0:12e:f6e6:882b with SMTP id v7-20020a056a207d8700b0012ef6e6882bmr6451328pzj.1.1690445734330;
        Thu, 27 Jul 2023 01:15:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:15:33 -0700 (PDT)
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
Subject: [PATCH v3 48/49] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date:   Thu, 27 Jul 2023 16:05:01 +0800
Message-Id: <20230727080502.77895-49-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, reparent_shrinker_deferred() is the only holder of read lock of
shrinker_rwsem. And it already holds the global cgroup_mutex, so it will
not be called in parallel.

Therefore, in order to convert shrinker_rwsem to shrinker_mutex later,
here we change to hold the write lock of shrinker_rwsem to reparent.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index fee6f62904fb..a12dede5d21f 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -299,7 +299,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -312,7 +312,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			}
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 #else
 static int shrinker_memcg_alloc(struct shrinker *shrinker)
-- 
2.30.2

