Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF5315595
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhBISEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhBIRr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:47:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC901C06178C;
        Tue,  9 Feb 2021 09:47:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9so2091833pjl.5;
        Tue, 09 Feb 2021 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtIT/XRubfZjNifW2/Wx2dvhH4DsCPssoQQ3vaxaswY=;
        b=f3P7M8G1BnqPYIthcB/2g5SI/aoPY7wzYvH+tH6KFpKU5R0eDTwdhWH4K18kqBhQBm
         XbCd824CFY/j+gg3m2xEUdnUS5o6nQz6BWqdkgk3U9hKkri6rEZgztlxI2/o1pFw4QEV
         F1dkb13u/1T1/e3Zn4VRnoVyrGu40vkPWClywRVJWbo1dmwoh3pb5CjJLQ7tBGD9OaXG
         fcm+jIdzMevEaJ1fiTUGdiyu1euBYSgbAo9WOlqfqiDfrXkiJY1EH/7sLk04XoZcyVek
         LAUq4qdKGqd53x2AQKGySFtwoAsFh/Kuoy89afStR91jCBE5MGcOcO96HLpOVVsJUr+e
         NBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtIT/XRubfZjNifW2/Wx2dvhH4DsCPssoQQ3vaxaswY=;
        b=bNlFYQ3PkJl49w0MBQB/ezcm37cJMCjarAxW01wmWWZrjBDED9E3Kh2b4O2bkQ0AT+
         YHJNPZiz3LSa0eRKZF77mml2qI1qCc+/ZUUxN8xocRz58/R1upH9c9oT0agLsjGtDNZw
         /AslcR9qTU9Pb9VQQTopveJrWO13JpTUKxmP/sIHwwf3YRN010FpqjQwqrrJGmiFYpHt
         K5ecAj2Bk8poKz5jOOty4FSQKdPuEboCsNaVLE4+5dQ/Ppefk+4Rg3kii6YUTY6hV+pu
         67PSPU6MOjjXbjUyANY/YCRqUC45089BIuPDHypD8Zgj8h06G1UjafxisMq1u9Oz01Bm
         /L1g==
X-Gm-Message-State: AOAM531MCMF1VsIM4xP4pJcmKPeL22nm1KB+rklC553cKQ2Db39DKGcb
        +vxASOSPX8vz8PnoWRfj5sw=
X-Google-Smtp-Source: ABdhPJwn2hQAiH23fVtXQpzqorHAVfhxl9TB10b0gI+9q594PYZIw32xabvZJWQNOW1EMGNWJo+64A==
X-Received: by 2002:a17:902:c404:b029:e2:cb8e:6b78 with SMTP id k4-20020a170902c404b02900e2cb8e6b78mr13868552plk.3.1612892837299;
        Tue, 09 Feb 2021 09:47:17 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:16 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 06/12] mm: vmscan: add shrinker_info_protected() helper
Date:   Tue,  9 Feb 2021 09:46:40 -0800
Message-Id: <20210209174646.1310591-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
with different calling conventions, for example, using mem_cgroup_nodeinfo helper
or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
will add more dereference places.

So extract the dereference into a helper to make the code more readable.  No
functional change.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9436f9246d32..273efbf4d53c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -190,6 +190,13 @@ static int shrinker_nr_max;
 #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
 	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
 
+static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
+						     int nid)
+{
+	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+}
+
 static void free_shrinker_info_rcu(struct rcu_head *head)
 {
 	kvfree(container_of(head, struct shrinker_info, rcu));
@@ -202,8 +209,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 	int nid;
 
 	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
+		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -234,7 +240,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -674,8 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
-	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 true);
+	info = shrinker_info_protected(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-- 
2.26.2

