Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A249A2DA38A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502692AbgLNWjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502576AbgLNWjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:39:12 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20437C061248;
        Mon, 14 Dec 2020 14:37:57 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id m6so3426661pfm.6;
        Mon, 14 Dec 2020 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SadIRfB1ozL+BvgNvi56acGK40sGczeZRbLfcOjsgUI=;
        b=Mc+/YW20XwmOUSCsmjbxlbhWLn0udfDF1hb/tFJNMCo26ixOoN4By9QolVjs97PCec
         OsGBYh8BNUOvZrxJdfXaWJP7hwH9ofY7oommJ7G+EXI5WXBBZv9A1gWNQb6wYY/Gu8Pr
         y7qK59t7ZdEHMj/A29Kbg2Stu7UteCZvXBPx5QN5VjvG55neVSTwoUcRrRZATYVQq1+j
         sLl+9sM+yMHaC339qQHpau96kBWG90pfG+0EVfBmEmFcjatC2mX+U2j2Hx7L9vbXdaGX
         SiBpXoYwWKsqJoqzhFhgjkjALrzhvgF9hunAQTYfmtDdbvm42WW6Ll9PO/QZK02jtOSv
         frGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SadIRfB1ozL+BvgNvi56acGK40sGczeZRbLfcOjsgUI=;
        b=KhEAgHocDIdZ/3x6S+6oaTahwLoa6DGGMad4i0OgvEfghPMi/yBAp3wq9+NsLogK1F
         vFE6pwnwzmH3cga0bPbhL57uGivxb83A4UiHjyIKW5HuZX2+zK42zWUDPhvoFX8eSlYs
         +nrFGuQm26PZTk6MJ0cNvnQZZETOiSNwalxL6mEhWgFoQBeoAMIWE9O3sXfjUOLaZ8vR
         6YZtmnynXaTyLAf33cOg5y5ASUyRYXT6PJ7/jXTYHVvZre3DA2N3V1o4LHWX6u3qVbfF
         QbYq0pKExY9EZewUstwYg5jpwtDhL3ZCQbhz9/fiAjn2Xuf54Zt8FE97s2S6g748k2zB
         DXtw==
X-Gm-Message-State: AOAM533icloDdMI3w7DQ7LAIRqTo8nhN/TBd9oAcjuD48qKUedvsOHuC
        EwgLmjN2U/9q/9X6WTbbEWk=
X-Google-Smtp-Source: ABdhPJxLNoStEmuqK/WqKcnP4+Gjaztl1jLEFeEywadhkRJ+a/8qnPy/51MZKB/GCDpJoTDGEkDQVQ==
X-Received: by 2002:a05:6a00:1596:b029:19d:96b8:6eab with SMTP id u22-20020a056a001596b029019d96b86eabmr25860773pfk.38.1607985476760;
        Mon, 14 Dec 2020 14:37:56 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:55 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 7/9] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Mon, 14 Dec 2020 14:37:20 -0800
Message-Id: <20201214223722.232537-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
allocate shrinker->nr_deferred for such shrinkers anymore.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bce8cf44eca2..8d5bfd818acd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -420,7 +420,15 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+
+	if (is_deferred_memcg_aware(shrinker)) {
+		if (prealloc_memcg_shrinker(shrinker))
+			return -ENOMEM;
+		return 0;
+	}
+
+	size = sizeof(*shrinker->nr_deferred);
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
@@ -429,26 +437,18 @@ int prealloc_shrinker(struct shrinker *shrinker)
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
+	if (is_deferred_memcg_aware(shrinker)) {
+		unregister_memcg_shrinker(shrinker);
 		return;
+	}
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+	if (!shrinker->nr_deferred)
+		return;
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.26.2

