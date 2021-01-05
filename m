Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0C2EB5B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbhAEXAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbhAEXAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:00:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ACEC0617A4;
        Tue,  5 Jan 2021 14:59:04 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so567993plp.2;
        Tue, 05 Jan 2021 14:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnMlP5mohrX3bvCSvWrNTxzp8rn+yEf+Jg5XouhGMW8=;
        b=VfKzNUjMJmuArEaHfpqnslSBVuqZOQjrYZbMQtPQjbs3dE0oYJ2cgQ1rN9OkzKriYB
         QRfZgVB1tjfgE8Uu6nS6zawm4Dyax8d9B7r1Pu3S0Whtox5LxMYX9KD/hKUiE8dS8R9x
         g777bezaoqX7KjKNgzsr4x6779qhSqO1hgrsYJb660FtfDvZMeKlOknsSkEMbZPfKhY8
         qbZ5RQ2sw9+O/uMmWcXt4xZIqYTh+9+knsjziZgGeeMlsDCsaAj/SDSgLKN2hI0aMrch
         0dYurd+5FU+W6D6aXK4OkteMVGsCGlVt8IaA4N2kzWj//PWKAVOXmJxOzcTbs7w6fy9N
         XYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnMlP5mohrX3bvCSvWrNTxzp8rn+yEf+Jg5XouhGMW8=;
        b=KN7PS8hhH/Mymx9UCQT7EigbgildMQJJHee0TofH13wCz3qVausYS1Tck3zRmPeOW/
         xl3rNSmeWzmxglCV9pH+McuKjw1/mcgslzC7phiI76QsaF34PrwuV/7+r7ZQzhFGaGln
         /k+RnOQgQBpFYXNFDS26DIZ4KJfsFjxiRWreH6DHrFoHJAbY8y+UGPuifBIQUGapa9Xn
         JhAO/exWMbUpjxJEHgo+vVqqMenwTxPm9HnhA62e6vKFcp86Z/y2C8LDU8SFVobho1pM
         /KUYk+VPuRkUMNnMqnYROjGT9jEQrOdn3re2bz0J7onsQLF+q21PyxF8ap8o9TcCr+9l
         xnsg==
X-Gm-Message-State: AOAM530VI8kESG59HShVR/pgLK9sCNJGkRpu5zf0z0X0bH5tjuSHQRZh
        zpxnbaeHFpFigL8VyXcNMjs=
X-Google-Smtp-Source: ABdhPJw7TMu00abpfLHlFdGgRt+lmRt41rnt1svrizMh0Lj4ti/rve6qS9uCxXYsPIfEIz31zFZbCw==
X-Received: by 2002:a17:902:d90c:b029:da:9930:9da7 with SMTP id c12-20020a170902d90cb02900da99309da7mr1668658plz.85.1609887543779;
        Tue, 05 Jan 2021 14:59:03 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:59:02 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 09/11] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Tue,  5 Jan 2021 14:58:15 -0800
Message-Id: <20210105225817.1036378-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f20ed8e928c2..d9795fb0f1c5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -340,6 +340,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
@@ -424,7 +427,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -535,8 +538,20 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (!err)
+			return 0;
+		if (err != -ENOSYS)
+			return err;
+
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
 
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -544,26 +559,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
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
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+		return unregister_memcg_shrinker(shrinker);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.26.2

