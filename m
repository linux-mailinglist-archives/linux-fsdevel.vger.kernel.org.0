Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3586337D48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhCKTJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhCKTJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC39C061574;
        Thu, 11 Mar 2021 11:09:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d8so10682420plg.10;
        Thu, 11 Mar 2021 11:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KRjLPceQFZWfN56pzAL4S7TxF614EkVjGd+2AFI1iu8=;
        b=Ba3D+YLmVCJ+UrsBxNrusvOurFMF0GizvxXy+rbFsNb20EJIN3RNgoNWWh29ly8tw1
         nwxuuvd0heENI0w8dr4FLMw7jhR+Okm1bLT2nwfqyGR5ZPmmK4Tf1gybOnD7BHGX+aIr
         M2As+IkvjxMoc6yjkBTEsv+stBsNyg6GyW1SKRZbakQyo6hqc3SD5r2HAMlia1fTWcKh
         6e7PCIuSZPQ8/9NIVLE1ynbs7pFmidWychavvHD9AYqsEvOyXSZWenF+CUQABb240Y1W
         LMFfTJDUrzJsEsWcTv3baolU9PdD5mTuEmqQiE5MNyqF/zJmb5g6vUzuq8JGitbwnptL
         W90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRjLPceQFZWfN56pzAL4S7TxF614EkVjGd+2AFI1iu8=;
        b=A0Q3qCZFeghV46a9ZOrSlosN91kM25k/VTGKurO+LbhiwFxuwMY38iObHgD2Ylsing
         zz3ZxSdEIKY+t3bPXcd2XTK74QHgsoi/3+W4K04hAKt3cHZKiLY1f74ryL/8r4Du4upW
         rt68fGm9U+cSQRYUL6x1ImKZ8I61owljKEluZCvHWSqgzRHEmxsYtCF9zoDGG1QgMdRv
         mSFVlAUs4vtO9vbq4b3XNiHuaZiXz8cZVHg3xTReNFJ/jvxsvjujRNipl+m8agP84Az4
         Bai0VKmUnSkb12n3cLW4aFbsxqQWpHDHh/pTk6o/xuVa1eWvb6YRbp/nrii4IN8Gcq6x
         CvCg==
X-Gm-Message-State: AOAM532QsXoZ+qjjpiwolXjsrasiAlmzcHAXRoqzwsFLWXTikrACus7n
        OSPYtv4Km9Cd7pI1Ej31zzg=
X-Google-Smtp-Source: ABdhPJyi+9KnFTLz7v5ac0t6Oomsbt4Jf4POupwR6yJqXXAM05xu/dsaKrVr9lkiWkjJtFGJ48k1rw==
X-Received: by 2002:a17:902:f547:b029:e4:6dbc:6593 with SMTP id h7-20020a170902f547b02900e46dbc6593mr9511144plf.4.1615489763282;
        Thu, 11 Mar 2021 11:09:23 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:22 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 11/13] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Thu, 11 Mar 2021 11:08:43 -0800
Message-Id: <20210311190845.9708-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5bc6975cb635..324c34c6e5cf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -346,6 +346,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
@@ -425,7 +428,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -537,8 +540,18 @@ static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (err != -ENOSYS)
+			return err;
 
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
+
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -546,28 +559,16 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
-	}
-
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
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
 		up_write(&shrinker_rwsem);
+		return;
 	}
 
 	kfree(shrinker->nr_deferred);
-- 
2.26.2

