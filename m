Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D187334569
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhCJRqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhCJRqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:25 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E2C061760;
        Wed, 10 Mar 2021 09:46:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o38so11866967pgm.9;
        Wed, 10 Mar 2021 09:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWUIbkbeLDVeoKhz04HlwT305yWIUKH2N08ijUlQ/LU=;
        b=RQpXtzHP6YLnQC3J09daZ1GQ7Qy/ODQBOv6H7Z+LvqIS0e7lDgCcOoaNdrznD3roDt
         uXG/8UkhVivBJ8R+uu0pyD7qtpuNK+1eCaa6UEA6Dzcjetx7RIE67JyTSZ5xtx4/XZAU
         FsggF8rrvj+qXONgVtNy+LbbkKjX4JqcNtC1AwMVW1WyLWzJ1tA/UMRQDyKyU6Wkv6od
         UAHFvYXXOHo5zV6UlRE6sFxrR4vBxmNfqGqIXhBGwvWO5CU2ru8uApAI5iX6vp0N6pAM
         PoV6D18R+RvVz7ohociHFzTV3UkHctNUy3+zaK2C1vtCMH1hSL3WSRx8n/2PEdMrs/Ve
         6WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWUIbkbeLDVeoKhz04HlwT305yWIUKH2N08ijUlQ/LU=;
        b=PY3vMN+I51F0VwIvZOwGtyEFgfMYh4B2YfpS5ZYtkxSG9qaHP1/FuE3+ylZcOtOeB6
         SJSfdDH4EXv2NFLC6m00S5XdFDMHIM6gDds0PjKGs3PAQdpJ+J+4U3qnwJw4cx0eA0Eb
         OJP+XaGAT6BovYh3/gbaClAKxqp2AGDLnQNhVxQz68uS1YboxFoZ67KyeDUCX9ZUfAYT
         U6T6pGGOqVJ/Cs4wnbhq0/GA/mVc6rH0Sb/c8ixNaT9kEIQdtcxyDY5BTAATM8UR4J0u
         QfC9Ygldl1ESZO/w/H8CINqt1PSwtPkYWo/vQncDjkdm8pFyoBeiPDbiHTIWDG7SrRRk
         P8tw==
X-Gm-Message-State: AOAM530x4TkkNG7g2rUpwtUAZtdh3Rs55MlvEq41d+6MAJfW3DYeqn3+
        Qf0bIdoxlr8H4nSih4VHYAQ=
X-Google-Smtp-Source: ABdhPJwG6polu59DK+rBm2AeJddhoqFoysCxyy7Lndk7oMONee3tmfH81DaB99JjMA4u3gQUliU3Dg==
X-Received: by 2002:a63:c84a:: with SMTP id l10mr3724168pgi.159.1615398385023;
        Wed, 10 Mar 2021 09:46:25 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:24 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
Date:   Wed, 10 Mar 2021 09:45:55 -0800
Message-Id: <20210310174603.5093-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
We don't have to define a dedicated callback for call_rcu() anymore.

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bda67e1ac84b..c9898e66011e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
 	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
 }
 
-static void free_shrinker_map_rcu(struct rcu_head *head)
-{
-	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
-}
-
 static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 				   int size, int old_size)
 {
@@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset((void *)new->map + old_size, 0, size - old_size);
 
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
-		call_rcu(&old->rcu, free_shrinker_map_rcu);
+		kvfree_rcu(old, rcu);
 	}
 
 	return 0;
-- 
2.26.2

