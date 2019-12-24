Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B962129EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 08:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfLXHzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 02:55:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53536 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXHzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:55:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so872003pjc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 23:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fFfoleXjv3JSEmvkK0O9oMZGbyG7YMfuDochkkrQvOQ=;
        b=Rya8+jtCyVchuEd4ioU+noODodMq+INQiLX/PL4jSKcYg5GvOf/SXNDOQHJtEgbW8y
         xKL05hnbQGUtL3Acr7ahz8ME2eCZf7ZuMunCKvbRRAimebxigKbETepsyTSzWlQ9BgXB
         3GWj0gLhRxLYw/JJUiPcpH5hRxy5+e+SEzVL3VAEoj1PGXL6tzT9xSp+STluqj8AzL/j
         MOWHh7EVc9HXo7isZza9cfU/KNvur+BDPfzHuBNNWOckvpzIdobDCGncrm7kproAsgCm
         nYd9QDN5QIDzAXYaZ6OccZH5PF/Aw9nhoe4DlLL++4qM2OcHdVA8Z5lRMeNFWbez74aW
         24vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fFfoleXjv3JSEmvkK0O9oMZGbyG7YMfuDochkkrQvOQ=;
        b=Ck4z/RzBryQXGf8vgSwFVsJdWnEG2uKWI9yfoI1xMsql2C8raPWwYMDGrVINFLlBV2
         +8Qpt2XRK19rKmIkU94e/Ae+HDkeLH/UTo8e3+eYbtE5bnJ00Xn5xVBftwB7tQOntuBX
         /7KjfwXJ5NM4ogMrwxVFpF6UU42Ppw/+er5cQiG+uwuXCJVwRvIZv9TSsTmpsYajgNLE
         vfF/j0nBLQrSLRKSlUYY4wppbdDOd3C/LFk7nlnEL+MZOTYiaGuPETb41/Z9m/P9fq2+
         nL2+Rqrowqp/lJhajKT7NGvOmGR41OR/8uBrmNO4rCNcJbYWfVdk9CEkLGNv5SGc74ZO
         K0Aw==
X-Gm-Message-State: APjAAAWoMM2LoTbNHhcLALLzRln+kW2IkPzFHsucYL+W9C7oG2mLzdc2
        8ZwQaFjJ+8FeMMF8WavSBVU=
X-Google-Smtp-Source: APXvYqzwb5nZVKnI+8k0kQUlZltmzZl2BXhecd6/pm7gYC87WxNmmvp1PaWB32bCf3nsZxt4xB3f0Q==
X-Received: by 2002:a17:90a:ead3:: with SMTP id ev19mr4262063pjb.80.1577174120029;
        Mon, 23 Dec 2019 23:55:20 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c2sm2004064pjq.27.2019.12.23.23.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:55:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, david@fromorbit.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 2/5] mm, memcg: introduce MEMCG_PROT_SKIP for memcg zero usage case
Date:   Tue, 24 Dec 2019 02:53:23 -0500
Message-Id: <1577174006-13025-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the usage of a memcg is zero, we don't need to do useless work to scan
it. That is a minor optimization.

Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 1 +
 mm/memcontrol.c            | 2 +-
 mm/vmscan.c                | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 612a457..1a315c7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -54,6 +54,7 @@ enum mem_cgroup_protection {
 	MEMCG_PROT_NONE,
 	MEMCG_PROT_LOW,
 	MEMCG_PROT_MIN,
+	MEMCG_PROT_SKIP,	/* For zero usage case */
 };
 
 struct mem_cgroup_reclaim_cookie {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74..f35fcca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6292,7 +6292,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-		return MEMCG_PROT_NONE;
+		return MEMCG_PROT_SKIP;
 
 	emin = memcg->memory.min;
 	elow = memcg->memory.low;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a6445e..3c4c2da 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2677,6 +2677,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			 * thresholds (see get_scan_count).
 			 */
 			break;
+		case MEMCG_PROT_SKIP:
+			/*
+			 * Skip scanning this memcg if the usage of it is
+			 * zero.
+			 */
+			continue;
 		}
 
 		reclaimed = sc->nr_reclaimed;
-- 
1.8.3.1

