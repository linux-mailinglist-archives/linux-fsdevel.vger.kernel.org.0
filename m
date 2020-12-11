Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F52D6F25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 05:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395348AbgLKEYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 23:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395350AbgLKEXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:23:50 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906FBC061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:10 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so6221159pfg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpYaFCBP9ryR0HnwKGfpggL7bn85I6W2LvY3/jvWBMg=;
        b=T2ahvN7HcruB45VJZG2OJqfIapWawdOD8QtWwwwuD43vjFPlp2f0Yi8Gslq+3aVBN3
         QuexiT59I4+K7zRILtyttGcENl7TzkS+jsjA2Oh+lybl033Bptk3XduoWbvXn6xVDsAL
         7ee5f0G+Ld7Nk/1Y3Wh4XlEMomkWzrC1dLBL4zDjO8dWk8nn8cZPsKzWKj443KmhKlbA
         NKCRfX207fMkpWgeZ/0TF0rb0LteP1ZUhUv6MOH1oj64KFiCmTraUoFBRKZ2bpGW2vj5
         EG0+5TFj/Kc9+edCH85DQVHPkanMAhz8lGbgK+VXRAPkdeeGVlMCFhSbRk9PNWxS7rQK
         g/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpYaFCBP9ryR0HnwKGfpggL7bn85I6W2LvY3/jvWBMg=;
        b=DIWFjfq12fWdwLgwe9A/fKhb/ongly8gk8oqUS7QSeDnu9gdIqkjSq7qWTbF3639PA
         82P4P5zQ5tTeVbp81vqHkeGnyziQ2h0dpmE+CgNjmQpacjzk+mO44es3FLKcdsA58sNa
         PyL+/OPlC3Ycq7rlxSmGjsPTe+NnHl46G1+GsRQSIJoQatE3Ssu8NIyNiDSZjW9ZHPnd
         OwE2eOLk2CAlpsrfVw5cYFwhUWhxA2OrsWdj5L7UAQqTnzkG38ThX5eYTDyGF/nYvXpx
         1WUy6+EI5w34nP+TxDcylgkX9BctG1eGkTl/t41HrJAcZt/b0Bw8uvNmIYKjI7548BXY
         UPng==
X-Gm-Message-State: AOAM533IrS2a3bHLxY2c0vj7fv2xiG+lcxZ4/G540nYPsH7WJbChLanf
        ZWRE4TRxs0rpzKxPdDCbFIUDJg==
X-Google-Smtp-Source: ABdhPJz13P4aoeVkSVXowRznFKeGs6JEKzGT5V/ZC2LxOJuCCnhOD8neubcs+2TtN6B0lrJSzDSQTw==
X-Received: by 2002:a05:6a00:1596:b029:19d:96b8:6eab with SMTP id u22-20020a056a001596b029019d96b86eabmr9899521pfk.38.1607660590187;
        Thu, 10 Dec 2020 20:23:10 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.23.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:09 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 1/7] mm: memcontrol: fix NR_ANON_THPS accounting in charge moving
Date:   Fri, 11 Dec 2020 12:19:48 +0800
Message-Id: <20201211041954.79543-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201211041954.79543-1-songmuchun@bytedance.com>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
by one rather than nr_pages.

Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b80328f52fb4..8818bf64d6fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5653,10 +5653,8 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
+				__dec_lruvec_state(from_vec, NR_ANON_THPS);
+				__inc_lruvec_state(to_vec, NR_ANON_THPS);
 			}
 
 		}
-- 
2.11.0

