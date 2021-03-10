Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C1334564
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhCJRqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJRqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD34C061760;
        Wed, 10 Mar 2021 09:46:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e2so3577977pld.9;
        Wed, 10 Mar 2021 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xfk/5hVVyAFMJCQGuT9bj2CxEXYg++EdZvSN0UtrQ3I=;
        b=PuEAhbWT7AWcBZuIbjQlpcFqTlG4qBBXxKDlR3RNaDYY+O8Cuc1PJsqDEbN4ODv1qW
         WgkRvJEqkqUwjyt9mVwA4bjt6ilyzahwH3Rd8zrbkgvnRKJXyV/GZMJTR1/jfvMSEXAx
         XL+DZezGFRC3uyMWhkvVe0f5vledaguk3UoqU81EXYpTWVl4lzTH7Ab1Hc8tYXCuSQIT
         7A0gVhxnpuNNfe1nn2lz0YRZvSAsn2Qy5yoQZUCUflax5lXpCNZ7Np6piNXmsstFi7ZJ
         6+o9dHfCGvDbuoUFt3vb/VTRZy3AQiJSHFx6D4Hh0z+JmnKtHChQdb+Q7ocSD7SYtjKp
         8PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xfk/5hVVyAFMJCQGuT9bj2CxEXYg++EdZvSN0UtrQ3I=;
        b=bxvcRcZVELUCU9aLuytmNUv22a6g8wREcl3AMgiR/AwYzl0F5DYvZwPJa4rqNsJuCN
         GDiua3RC0GPUvnzcpxe45yJg/2E9WORh4jNWPNVLrVb9TPqJ4F8eIa5LfMWqZ2el5nRU
         UsCorT9UE7tF+7D5TlSfyI9TkSMcJofT1Kx3c+03/aWNxtY6jBtnjNYVQVOh0ZFxMJyp
         QjjiiNXwFepoRiTyVpKu1Ao6zfaYtB1DoMwlABEftC8Nrz+W2escL/BYzE6/fAB8pNgX
         OY0X6sn76Uofcaz42opesvkpYxkQo44wZk/wqwnf0bkHkIFiLCoFe9OqlL0ZNoQNDzFY
         qx1g==
X-Gm-Message-State: AOAM5339uKoVcA7GDLxDNmdmg8gI05eQN+jmW7wGwfBK3e7TJ3nti1Gp
        CfdBcuwUDXJWIlP5WDlM+wk=
X-Google-Smtp-Source: ABdhPJwo0iozQkYECa6RLbEYLMRLVPxCBqIC2dkepEvixp18RaJjtZQmoxcIUawP1U67Dep2wKAuoA==
X-Received: by 2002:a17:902:e78e:b029:e4:84c1:51ce with SMTP id cp14-20020a170902e78eb02900e484c151cemr3827631plb.25.1615398376908;
        Wed, 10 Mar 2021 09:46:16 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:16 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 01/13] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Wed, 10 Mar 2021 09:45:51 -0800
Message-Id: <20210310174603.5093-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The tracepoint's nid should show what node the shrink happens on, the start tracepoint
uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
shrinker is not NUMA aware, so the tracing log may show the shrink happens on one
node but end up on the other node.  It seems confusing.  And the following patch
will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
the code.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..31d116ea59a9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -536,7 +536,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	else
 		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
 }
 
-- 
2.26.2

