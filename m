Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C78334589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhCJRrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJRqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB4DC061760;
        Wed, 10 Mar 2021 09:46:37 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a188so12597472pfb.4;
        Wed, 10 Mar 2021 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaxJJOVv7LgdCo9yE7MuyRBn9qNHRZNOLyYzzoINruU=;
        b=c/DvCf9Nn8eVdeoELtlskBSsceIxBGXO+pGtMzYQWwDbGAtl4IBbN02T5i3OP/VsdG
         9ICBeRVNqvOzLaUf9kj/zkRR1MwWIGq1b2vnhEwMwqjm9iikDM8eH5nCHNHOpnpDbiHC
         KDqyAvntuiCVKY10oIjRqz0QJH56nZd+oIZ+xJk93ySIBWQ+TiP4icuGCGHpEmbTS2U0
         R1WZVYs5c3cbmzAm2fDvz53zAxv/Kx/hMt62h3VtrTsfFONIOg+eg73mRcFALzWY9BKf
         Axti/UDZq8bIreJS7rNwhmq80BgMaS1aYmhDYmPUNyk1/wxY3BdD9N5s8mr03Sh9kDNm
         245Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaxJJOVv7LgdCo9yE7MuyRBn9qNHRZNOLyYzzoINruU=;
        b=bpXht5KuHe7K3YY3TCrGdAhV5hPwBVJw42L1N1bMp/GG9m5AQsuSAdaDrp6vdwagxU
         pM79QwRcYdzWQJkdvfv4b5NGmGCrjApSInev8OPipmMbncT6DeaRiKnnUlMWw+zO7WDX
         nnyQ4t0jSuswLDBvv+FRqUHmshZcNFxrkSoFIC/UDkE/dMGfD6Kq7/wRhOahbbIscVVa
         WZHrJY2yERb8FC4U4H3OfTYEFC4RABowKpUjIcuM/IoxL9ZjaUW8h6XjA988I75oJ838
         qWT7WMXzQ+ktaf6AdTsxFUVqYXHHslTyIfH6nzTxejJdncFvy8T6CT6Kyjs2t8tSbFGH
         jy2Q==
X-Gm-Message-State: AOAM533rZULqrVqNE7w/WjuJG6MG5+adzw5GOGdOPW3hlmTSa4d1Krq+
        jtzrPoyObfyysbvhuDMaXoI=
X-Google-Smtp-Source: ABdhPJzcqpIQDE7VuURNT6V1tgUthG66dbUo1skbXfxFFImty1y9kA3R8cyFlnyHF2RAg89YmpUSOw==
X-Received: by 2002:a05:6a00:8d2:b029:1f1:5b57:85ae with SMTP id s18-20020a056a0008d2b02901f15b5785aemr3840622pfu.60.1615398397512;
        Wed, 10 Mar 2021 09:46:37 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:36 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 11/13] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Wed, 10 Mar 2021 09:46:01 -0800
Message-Id: <20210310174603.5093-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
index 326f0e0c4356..cf25c78661d1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -344,6 +344,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
@@ -423,7 +426,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -535,8 +538,18 @@ static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
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
 
@@ -544,28 +557,16 @@ int prealloc_shrinker(struct shrinker *shrinker)
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

