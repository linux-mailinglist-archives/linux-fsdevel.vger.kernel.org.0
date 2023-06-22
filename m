Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB4739B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjFVI5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjFVIzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:55:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC422694
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b5585e84b4so6827435ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424115; x=1690016115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gb8UpD3lZt4bh5cbhFKOyQevww2sfofkVlmbPNwxg8=;
        b=D5LVC+4HokJCz4FPeXcY+dsaTssife3Qqo2QFad+aTpXncu7uEYIb5Esgo0X9193yq
         JD9ShpMbmoNV55hSp3a3PNB6eqKE4aEEgjXjfXMhn0CWCq43W/gk5ji4OA6QFiz5YEbm
         Of780eCZQIl3oU3nzqHMjitXTfpqsvwkQAoJ3/aSYN48pFnlXdDicr+5TJONhzqSsJ8t
         IgcwK0tiB9rdlMicFxhfFEkVC1N5FWb0hV5n3c+iSTxmBlXa0ZlHHEAwcq0BLcrHgmll
         f7y7d2fR0/LzWuGi/rCVXp+lACayEzs+7pdEprt9XcBuFLw9Vycb7reaOybOjmFS0TWh
         I1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424115; x=1690016115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Gb8UpD3lZt4bh5cbhFKOyQevww2sfofkVlmbPNwxg8=;
        b=lgr5WvXY8knVwN9us8a617N8z1KWbd5onWfAhzu6MpYV6JxjAcMoosvZCw62W8kyy8
         w8wnW6dGeWyQRCns/LaSwKvlmk2DjKL1NLtLzU5Dw7Ly+nl9G96JayIEEfQ14VTUN8h0
         ns6k/6YIoaxanBtC/DKvXFOFDEzgGWYi6/XzUtreDYFfnXlymbdqxxpENWHz4S6Ta728
         7yj4F+761JFK6dxHxkHeB4og7guHP8O25C3lbLgFijmXF4RcL8vAUwgFA19jAs+5WY7O
         9C1hFlzR6ftZ17jHeyQdZfYbZUV9Cr+lh8tvndI1878mB6dKi1HkC4XdoueC6vm6epoW
         9LgQ==
X-Gm-Message-State: AC+VfDzbkx2qGfRGpAqLsbdr4lkmoJKaEQAQKn2UgPjW/nK5FgQ+27HT
        AlZj8sS27gemHlYNm06/YgUGmw==
X-Google-Smtp-Source: ACHHUZ4eMYIbb4I7cyZSyRLa7A39+u7jKZFqr72/TYsRg3oKUy2dca/PQ8JGq6DHBe5p8nrFI+JLcw==
X-Received: by 2002:a17:903:2451:b0:1b0:34c6:3bf2 with SMTP id l17-20020a170903245100b001b034c63bf2mr21539426pls.5.1687424114850;
        Thu, 22 Jun 2023 01:55:14 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:14 -0700 (PDT)
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
Subject: [PATCH 09/29] bcache: dynamically allocate the md-bcache shrinker
Date:   Thu, 22 Jun 2023 16:53:15 +0800
Message-Id: <20230622085335.77010-10-zhengqi.arch@bytedance.com>
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
we need to dynamically allocate the md-bcache shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct cache_set.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/btree.c  | 23 ++++++++++++++---------
 drivers/md/bcache/sysfs.c  |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 700dc5588d5f..53c73b372e7a 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -541,7 +541,7 @@ struct cache_set {
 	struct bio_set		bio_split;
 
 	/* For the btree cache */
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 
 	/* For the btree cache and anything allocation related */
 	struct mutex		bucket_lock;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 569f48958bde..1131ae91f62a 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
 static unsigned long bch_mca_scan(struct shrinker *shrink,
 				  struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 	struct btree *b, *t;
 	unsigned long i, nr = sc->nr_to_scan;
 	unsigned long freed = 0;
@@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 static unsigned long bch_mca_count(struct shrinker *shrink,
 				   struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 
 	if (c->shrinker_disabled)
 		return 0;
@@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
 
 	closure_init_stack(&cl);
 
-	if (c->shrink.list.next)
-		unregister_shrinker(&c->shrink);
+	if (c->shrink->list.next)
+		unregister_and_free_shrinker(c->shrink);
 
 	mutex_lock(&c->bucket_lock);
 
@@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
 		c->verify_data = NULL;
 #endif
 
-	c->shrink.count_objects = bch_mca_count;
-	c->shrink.scan_objects = bch_mca_scan;
-	c->shrink.seeks = 4;
-	c->shrink.batch = c->btree_pages * 2;
+	c->shrink = shrinker_alloc_and_init(bch_mca_count, bch_mca_scan,
+					    c->btree_pages * 2, 4, 0, c);
+	if (!c->shrink) {
+		pr_warn("bcache: %s: could not allocate shrinker\n",
+				__func__);
+		return -ENOMEM;
+	}
 
-	if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
+	if (register_shrinker(c->shrink, "md-bcache:%pU", c->set_uuid)) {
 		pr_warn("bcache: %s: could not register shrinker\n",
 				__func__);
+		shrinker_free(c->shrink);
+	}
 
 	return 0;
 }
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index c6f677059214..771577581f52 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -866,7 +866,7 @@ STORE(__bch_cache_set)
 
 		sc.gfp_mask = GFP_KERNEL;
 		sc.nr_to_scan = strtoul_or_return(buf);
-		c->shrink.scan_objects(&c->shrink, &sc);
+		c->shrink->scan_objects(c->shrink, &sc);
 	}
 
 	sysfs_strtoul_clamp(congested_read_threshold_us,
-- 
2.30.2

