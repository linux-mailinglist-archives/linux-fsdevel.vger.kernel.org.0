Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6665436D510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhD1Jyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbhD1Jyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:54:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C778C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h7so3951843plt.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oUrOqpAChDXaXDoRREdcI5L9MHP6oIlBRQpnJzUeII=;
        b=KjmVrYt4/mY4WAr2kGNuBttDXe558+QJuBQ0FarvEbVpYaJKm1byHI0esEdym/Sbms
         ro0NbPCCKfv5HOUetWMK0UzUV/wBvWj1pdq6vDvbMZJSDoWUsAEaM5qnn0Zn94mGyu76
         CIdM0kJHKdvY2YznYTJNRCQjsDJ89lLa/6V9en+m4TrMBSXszIAsfpheCjK7mXscPLii
         f4WMz1stInaW9MZwHqi5sRS8/FdZ3f75T59LuLxAzP9za4ip+85ii2835JA9zLFnKkwg
         /7LBEqHUDEYbsKjDOXcN00GLzP6ZQcqmZwgmfvE5wno6F5pVKaC2ocCOaWtiQmLDvMik
         WWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oUrOqpAChDXaXDoRREdcI5L9MHP6oIlBRQpnJzUeII=;
        b=Gv7zf70dg1rMoxcTyzvSd4xbUSpUvmCOpGVuWz1sTYeupyfG9J1n7T6cKoLQnJSDEX
         tj714McJmsItMuUD74FDGktOz5DHBMnaAFUiBkwVvn+T87mGSAlXxJqSuhVhpAxxt+PV
         4AbWxuq8jkkRoylHGoDHmy3cOCR6j5DxGYLHrx6/vB9ZQn93BUHjhmmrtDQXmLFpz09J
         7Ub/Fu/9KWvBydwOpIpuhvjjwsH67oZANbp/ZEAv9MkMV8mEnMbw6DUvT30/MwcFTtR0
         riVZEwF79//L35rmjsDkKgxEIsU7Vv4K6Az5jMuGeN5son6bIzHekMd4ZTokBwdskSQG
         i81Q==
X-Gm-Message-State: AOAM532RSuUM1t2jQBfn7QTc7KR1y+ACd1k/8VlNgB9fm6IuuR3pMsSx
        yoGsNluhQhR+wwGv6sDk7Xs27w==
X-Google-Smtp-Source: ABdhPJxBl/GM8wieywRB0WXvNHzOvK1MwlC3y0XOZRlQNnVIeOPVORj003QMYJqVZivfXIWTUHMcqg==
X-Received: by 2002:a17:902:7d89:b029:ec:c084:d4bc with SMTP id a9-20020a1709027d89b02900ecc084d4bcmr29571045plm.18.1619603645050;
        Wed, 28 Apr 2021 02:54:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/9] mm: list_lru: fix list_lru_count_one() return value
Date:   Wed, 28 Apr 2021 17:49:41 +0800
Message-Id: <20210428094949.43579-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 2788cf0c401c ("memcg: reparent list_lrus and free kmemcg_id
on css offline"), the ->nr_items can be negative during memory cgroup
reparenting. In this case, list_lru_count_one() can returns an unusually
large value. In order to not surprise the user. So return zero when
->nr_items is negative.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..4962d48d4410 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -176,13 +176,16 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
-	unsigned long count;
+	long count;
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 	count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
+	if (unlikely(count < 0))
+		count = 0;
+
 	return count;
 }
 EXPORT_SYMBOL_GPL(list_lru_count_one);
-- 
2.11.0

