Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADD640A784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhINHfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbhINHey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:34:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0958BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o8so4513778pll.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdSMr5/T83fWycgKHeCNyglH8dIFjVjgVfZi+3aGb/o=;
        b=lcF2FdRL9SmDj6sPoOKJRFfCDRkvqUq7bcdi+w6EjU85E25KLBbP9RZIf1g1RF1VGF
         dYD9vWNLARJj2aso1D0zfM0tnh4+8LLXP8x/ks1iAmoSo5bmlyG8s7Z4L6t/Hzh3kAb5
         aiqgfjgCJg0JeYJHrRHvuB3Z0Z7gozQJUUV59v99TdjJn4MNtsOzrrf2X0U15bNWONQM
         5+CLF53XPlAE3WN/08ilsg/S9SSdjV5YOvnjHcNrUELXww7m4qHx+z7E74VGqXqULLTE
         484Bt5XKw+KSNOZ871DW0obWlvMU3XQsR/zX7L4m/X/CtmizI8nwl5rOukLwJO8Bpky4
         qO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdSMr5/T83fWycgKHeCNyglH8dIFjVjgVfZi+3aGb/o=;
        b=ars84/CB6snKfcvJPU5DaiPilLfkpeRzMXK0MDpto1ceXoQczLKgubsmxOxTPPjn3I
         DtMuVuE2ipKJSZLfW6KgNvS1OBNlHktgDvTIKxxZjDj6OzbMYUcmPNaZiboQFyVP71kX
         qOjzLNrtkUiPOH4AJjDdKkAxswZvNdWirMctP2HK1RlK8beTdxzGd4XKBOX/B0iSfzI9
         gqpNZ8zTmQzQYvax59OHpGU6hczb+b/mLQrOCe0+KY97C9s2xX3sQ5RyjSI8kD6wYzCf
         bwGa9UErzhYEmtTEW2/DxsiF2PLg/2VffQCAXN7Q9owE99EXeipqeyNZ6vhfFzCx4s71
         Fxkg==
X-Gm-Message-State: AOAM5319BSJ1gQYEM9JXXqdd80PVxAk8cuioDmsOxRKztjRQ1J8r1ERv
        3DCKo60ybEqQDmjLc/b8nhl/Mw==
X-Google-Smtp-Source: ABdhPJyd7C7ap9YT7ZyYr6oDPQ1gvF/rR4tIJydHVVLbWcwDTcRs26m4qzANk3uL3N76KhhkCvYSxA==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr544287pjt.170.1631604810566;
        Tue, 14 Sep 2021 00:33:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 05/76] mm: list_lru: remove holding lru lock
Date:   Tue, 14 Sep 2021 15:28:27 +0800
Message-Id: <20210914072938.6440-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit e5bc3af7734f ("rcu: Consolidate PREEMPT and !PREEMPT
synchronize_rcu()"), the critical section of spin lock can serve
as an RCU read-side critical section which already allows readers
that hold nlru->lock avoid taking rcu lock. So just to remove
holding lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4962d48d4410..6b2f3cbe5f67 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -402,18 +402,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	}
 
 	memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
-
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
 	return 0;
 }
-- 
2.11.0

