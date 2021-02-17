Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC98231D34A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBQAPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhBQAOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:55 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38600C06178C;
        Tue, 16 Feb 2021 16:13:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 75so3955688pgf.13;
        Tue, 16 Feb 2021 16:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSn3NqB9VD7rWht7Szy8nfdBgp8H6px/y36iWOtZRrk=;
        b=ogEtLEdngbkvDqPH+9k1j7lFEVEQ8Pd5ZYB0zf2c1AslkcEufULjGU+i0U3pl1UYk5
         f5/W8fn/VgbPSXrYB+U0zZqI7wvw86WUOM2p19OmoYw+vgFqPHM2qKOUPJEAcb8sUB22
         kOoR1jsGwnef7/cE1UjbwbmpYWZxsN+UkULCCzH5TJODl+B/r+ckbYkYXit2GDJGzHbG
         qtT9ePpxLmGZl2AOhwlO7uq0KPS3ucBzM7w/wpl1nUhVZ7onoGk/fIc75IYZWtOMBpAZ
         d0/5bkkS60b2K7Iwd8Eiso8NX9jLDCbHZ+XAwisXEb77hIatNJMA3UWwh7iPHdPdbhsz
         Yslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSn3NqB9VD7rWht7Szy8nfdBgp8H6px/y36iWOtZRrk=;
        b=rhNS0863/p/zbErXeh/lupDlwergAEEaUegeWkyZM9ezTUdhQZ/VkV1FRQkBxuTXU5
         zxv2iLwVPzVjmONGcoBMenO0WtAamNQt8SOWsT69KxJrbzoC/9/Oh6YRrNNG26faruNI
         ViLaIz2C1mMzHiTJgPnt1m+13vBJwvorOKs9vbDcAI6N0RxnXICBI9mjlxPhXlyswfOS
         pB3kc4H6OfSL/fAfDfjokw+KSoiWSNZKa7v2mgLjelediFFR3SDe4LI8EOF+bpaUtOSF
         lLw8Q9JIfQInkZnhqvlzfDGlsMDjaM4CcO0SE/nD8Jog3wvSDHcW4DJlLDLlg7EARur0
         bt0g==
X-Gm-Message-State: AOAM530O+79/9vp8dEjkKz6t+8pH+k8BaRXIYt2aAIzKUCqW5rHI8nem
        0M9vGBibt13eZ2PdqjcHwT/YwqZ1aTepAw==
X-Google-Smtp-Source: ABdhPJwZEecYz6LkZS+2+ihMK2GWDVgJ6bjhlNP1SYaJC1fdnuVWtBc+oQ3w2THvYZWNwjTWlxlzXQ==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr21192416pgg.195.1613520824890;
        Tue, 16 Feb 2021 16:13:44 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:44 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 07/13] mm: vmscan: add shrinker_info_protected() helper
Date:   Tue, 16 Feb 2021 16:13:16 -0800
Message-Id: <20210217001322.2226796-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
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

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c94861a3ea3e..fe6e25f46b55 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -192,6 +192,13 @@ static inline int shrinker_map_size(int nr_items)
 	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
 }
 
+static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
+						     int nid)
+{
+	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+}
+
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				    int size, int old_size)
 {
@@ -199,8 +206,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 	int nid;
 
 	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
+		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -231,7 +237,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -673,8 +679,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
-	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 true);
+	info = shrinker_info_protected(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-- 
2.26.2

