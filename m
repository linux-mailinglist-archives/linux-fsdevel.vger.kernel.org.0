Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3509B392764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhE0G0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhE0G00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F7C061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v14so2924450pgi.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Skb3PkDwb/3WBbW5QytVqXcn8HE8kv5ZTlpyL+++g4=;
        b=0i7WfGFj/SwesZLMTohEbH+Evib1sQbS+c7e0TNLaQ9zFvhes7YR7vBubu1DEN7o65
         U4kaKhsu0ps7yC0WmKlbpnH0Yp1uTp7xsDGZtgw9mvOCUbAxovpLxfdgb1Un1HEs1kD6
         vPZkVvlpwqjulQqgd6Lx6rRF9WdZktw/surrmqDbPHFe0cmXZ97ypZ4oLDN8fzh2IxHc
         48ovLGD59G7RK+b3/KI/CpYUUsU53ThIfbrik6hoygjAJR2Eib6bSSH51q+9wJb/G0ql
         37NfnccShXUqf+ftAHTWbtj9kN/fR4pwwzGjRik/DodaikwAh5Ue66hT25q3+VkSQG3k
         6asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Skb3PkDwb/3WBbW5QytVqXcn8HE8kv5ZTlpyL+++g4=;
        b=GFJWwCI838zlnrYsyim3JKNUNPLxLZeU6vrFCm9uJYLajq8zB5kTs5af9wre9OZ1Vj
         0z6vRAN0Zf6ra6tjM+O5LpylViWtAoc4OkWJlPgv6qYtAS7tdgmrqbx8DkioirTvmXPw
         OsC0oIOkj0nJ3NGR2cf7hd0CMmQaId29ewY2ARhOwkWMvn6uC2I/RugDO2suf5WK153J
         l/zVVrpkWes1SRjEbaIjltvP/CeZiDz5TPPYKNswCBNqjRA5HDXPgFwahM4hhAQs9UtM
         xx1YzGsD4pJmyLUwMSuzW/QuZEw4URWngQKPvqGqlDuaJHlyNasXt5Rc7Qs9YWvXfjn3
         eWCQ==
X-Gm-Message-State: AOAM531Pug3vGcauqYELyyHHesIDnkdz+6lYAM69NEOEbkJa7TcSiBpI
        x4optuAwOdXRb4tnRn8Y7LMiyw==
X-Google-Smtp-Source: ABdhPJw32otAEAGQ7wbA7Yy6KLbhe+rjlxJYa8gEkHEt45un6/ZtOcrGlPaiuyYswbLoNoB4qg5JRg==
X-Received: by 2002:a63:b243:: with SMTP id t3mr2257632pgo.253.1622096692910;
        Wed, 26 May 2021 23:24:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 05/21] mm: list_lru: remove lru node locking from memcg_update_list_lru_node
Date:   Thu, 27 May 2021 14:21:32 +0800
Message-Id: <20210527062148.9361-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit e5bc3af7734f ("rcu: Consolidate PREEMPT and !PREEMPT
synchronize_rcu()"), the critical section of spinlock can serve
as RCU read-side critical section. So we can remove the locking
from memcg_update_list_lru_node().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4962d48d4410..e86d4d055d3c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -403,18 +403,9 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 
 	memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
 
-	/*
-	 * The locking below allows readers that hold nlru->lock avoid taking
-	 * rcu_read_lock (see list_lru_from_memcg_idx).
-	 *
-	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
-	 * we have to use IRQ-safe primitives here to avoid deadlock.
-	 */
-	spin_lock_irq(&nlru->lock);
 	rcu_assign_pointer(nlru->memcg_lrus, new);
-	spin_unlock_irq(&nlru->lock);
-
 	kvfree_rcu(old, rcu);
+
 	return 0;
 }
 
-- 
2.11.0

