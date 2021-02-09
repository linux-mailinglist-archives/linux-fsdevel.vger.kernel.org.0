Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084B131559A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhBISFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhBIRsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:48:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15C8C061797;
        Tue,  9 Feb 2021 09:47:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b21so12919260pgk.7;
        Tue, 09 Feb 2021 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AX6V0BvcTn1weE8/ZJGdvy6BSiCFsYPbqmrEZf2HeZY=;
        b=W6NXL6IpNXDaVEQv0X3zKJCU+Kq98htBiQpelM2gUTQC23iqlOjgk6/gYz7AMZT+Yf
         w1nA0oEMpjHsgmyphYdVEsYcfSJzQHy9gL0Cu15+YcUWyEtNSIYBbUQSWSjWTtvkWfWT
         GX62nAW5Xioiot59VRDfH4/zt64d42Su0yrsC8WtgpWrbdM8RfE7KBJRhY1U/PK5siSF
         7ftHsRhzoUEUythqNJ7tpo1ldvn6tsT4XIBI7MajdCqHageGD95Uk639qEjbisuiWWTy
         Bhfvl8lfacdTm5CojxrlCIi9BXV0Lqzw8lXrebFQPctNYnotIqsSgcfGB6VCgqy0Ssxp
         DRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AX6V0BvcTn1weE8/ZJGdvy6BSiCFsYPbqmrEZf2HeZY=;
        b=Oh0QTXAlRjSsTzowbM3Fvt355TMmTpl5YGLJsxgOJMT8SDwQ50XSlN6ApRSRNUKhfk
         p1klJzWwS06e2GPy3qbai/5YBnX3oisgJ5sjvOp0YTF5KZTFKcQYJ/7AVjNk8qq/zhQN
         cCVnnqu+2g4ZpbBWjtRrxK1Kmnu7G0GB/ubniZY+2H/jrQJ06FTzeGhL3VUXYddwzktR
         dPdS62dtvKgCA5ndkQnyW1jFCXbigk994FfTgZgX5O1z8uzGMPntcswHn4XTHKkq4C27
         kgmYr0n3B7QVOBCe7kyxWY4SjqsKOZvUqsaGICkqofzDxT10DY9hjaIwfH+0XQIsUf2t
         YJMw==
X-Gm-Message-State: AOAM533y7Gkre6/o+O+iGsPAyusW+r8BKDRI8I6HSeQzvuTiFVqBfLQr
        B9JRVvQFvA6A0O4ffzwhsFU=
X-Google-Smtp-Source: ABdhPJylfkR4RNuMaBkK1DV4MxLb32qE/adS2oaKsPC5eDZCdrkTWopj1y1vlm7v79AqsCXNLunWhw==
X-Received: by 2002:aa7:8485:0:b029:1dd:bf6a:a9ec with SMTP id u5-20020aa784850000b02901ddbf6aa9ecmr9988270pfn.47.1612892847324;
        Tue, 09 Feb 2021 09:47:27 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:25 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 10/12] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Tue,  9 Feb 2021 09:46:44 -0800
Message-Id: <20210209174646.1310591-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
allocate shrinker->nr_deferred for such shrinkers anymore.

The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
This makes the implementation of this patch simpler.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 748aa6e90f83..dfde6e7fd7f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -338,6 +338,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
@@ -417,7 +420,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -528,8 +531,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
 
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (err != -ENOSYS)
+			return err;
+
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
+
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -537,26 +550,16 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
-	}
 
 	return 0;
-
-free_deferred:
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		unregister_memcg_shrinker(shrinker);
+		return;
+	}
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.26.2

