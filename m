Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09D37A502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhEKKw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKKw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:52:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11CC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n16so10630038plf.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKsKB4GYgRd6f8D/mWUIDZKZ0++0gc+VH9lM9TpP6RU=;
        b=VVp+A4ZecBFGFSRbIs1i2QqI6JPeI905+XDW/+4NUVYBpfJKdo2mbnRAZqBaYDT4fj
         4z4sAgYuQMO2Gzd88guaqjzr7QsSzWk0M6u3aSFhwuIAnhT5BWQL/0cgKQPTOI5FsaUz
         /gzItuJCZ+WqT7RPthjOskKDSNBtyhJ8fagVIok9ix6HJrCNF0IioVjIH4hIUBZQtzQP
         +jY9uc0H9L0xxB0RWb1XZatZrdQmzbCtqEVPUBVor82Q9kSw1DprU++yxJg4Ht9CyskU
         T1sCsNzpcnN61qhYTe6qncS6dSI8vpgLFlRmEJ5qpeRyJ1pQjYp/3sFEKP5R1+o1JB57
         mjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKsKB4GYgRd6f8D/mWUIDZKZ0++0gc+VH9lM9TpP6RU=;
        b=O9f0bjLc1+hZw0LhtOwwMIzu0WIlTv1vJsOAugzT9vuka/V6NgfwYOH2oM+KbDSlri
         geGKy4n96YOw7VRTV2/Jlf9/1RyVaB4D+oapLd82KNi47Ksv3QRghqiR2EN6gk5uxzmm
         ZA7PtuMnYYmLnxWMMwzcrSaTPIi1/yD78AEV6kkYR17MwYWP/o5rsSM+Et9HV+WuTISN
         eJcjmIAFuZq81es9wx1Ct8LE5jwdX8Kgt4N6hnM3WY4DJ3Vo/lDNHqzkv9gbcxBYkmBw
         8qw/S2QScuazqKttlAvHpn46oG3LaSQVeJefkulCROyyjYySe/2ZH3UDNawn12yXLWVe
         Q5dQ==
X-Gm-Message-State: AOAM533h0y++8TDgyoL8hcM+SHxa8ulp3LfhjylylcCHSAPPA1q9NzYt
        2i4gxjnhWRBSb2J6x1Zvq7hPLQ==
X-Google-Smtp-Source: ABdhPJydRosyrrbHMxbhHLsJ0w0mphTejG9nrk4d+o8QXBnZoaP/o2HTRqwJkBfCPH2wNNO8V3cQCg==
X-Received: by 2002:a17:902:e8cb:b029:ee:f963:4fd8 with SMTP id v11-20020a170902e8cbb02900eef9634fd8mr28864251plg.40.1620730312287;
        Tue, 11 May 2021 03:51:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:51 -0700 (PDT)
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
Subject: [PATCH 05/17] mm: list_lru: remove holding lru node lock
Date:   Tue, 11 May 2021 18:46:35 +0800
Message-Id: <20210511104647.604-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit e5bc3af7734f ("rcu: Consolidate PREEMPT and !PREEMPT
synchronize_rcu()"), the critical section of spinlock can serve
as RCU read-side critical section. So we can remove redundant
locking from memcg_update_list_lru_node().

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

