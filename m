Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0873129EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfLXHzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 02:55:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33783 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXHzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:55:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so10413875pfk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 23:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jfKPUo9lIku1R2ahp2lE/JKldZJ7MZdv3GlFZ3kEMlk=;
        b=Gaa4LRfGyOoT4mcvSupClLdax8k3FG9KAqjHzo4kjy2lKdgb3gPtZxcshF8/w3UAYw
         oUzjAC2i6C/3lX3na16TLMtL1zEK2qnJaS8GpN4bxtVgQsXe3V+x0OZd8AVYwK52v+Jz
         KVqPoe42Dawe3tmBAST+AdjrL773RmDLid0ehT9oSBdbO7+wpvEtckN5571GyeA9IQJH
         ZR9zEaA4R9iTKVFon3OHlwHGbB6rsWF+8jRhYoGRmEYlYogg/tn+AdOKmkDf9w2AFnzr
         LM+BExf+n/Ii13V1sA51PNpGoRjE5oXcLqrRjTznnP0eIqBQRVzLf1J1fov7ggl5tz0i
         w6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jfKPUo9lIku1R2ahp2lE/JKldZJ7MZdv3GlFZ3kEMlk=;
        b=CBKwAhtJsxeYvKwloCGPs0ZFrr9QwCsulQD/p762eA1nfCxx12gWKd42xCNKu+eB4t
         xLMrjSs4XJ2WxHSBBRjmwIjdpjvWuhVUVOHQrwHDHZjkDqkl7iikjQUiLYgjdi+AGG+i
         JCBAvW+m5Lagp32TfAsaFRCsll/wkG9peL8kdmR3hIWJUxrt8Fv1u6oyQIsnfDCgDnPf
         45s8Wj+2rH2p/Ff4rtT4wubpE95wUpsOK54Zbs87QRZMWmIeoLDpPIov3Mnoyq6SX8dX
         vdOqQzjIR7UHpO2fxYMAgTG9wu4uV5izs446JVGckMX1rkVk9ScNOJFprb+PCUwDrYgD
         grig==
X-Gm-Message-State: APjAAAXwzg1RqTQIfbCZiXlliuWAHkM0luhloRmZ+O15evtyOiiKqv3C
        tP0SWL4LK7x+APMf86NH7gYjgg7BcN4=
X-Google-Smtp-Source: APXvYqx5yy+fa0xyry+JOfLiSMfzbupoakJJbuMOlC+zi6L36BrPLDVcL6DMDnAvbUxjPELtPhMdgg==
X-Received: by 2002:a63:554c:: with SMTP id f12mr36614237pgm.23.1577174123459;
        Mon, 23 Dec 2019 23:55:23 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c2sm2004064pjq.27.2019.12.23.23.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:55:22 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, david@fromorbit.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH v2 3/5] mm, memcg: reset memcg's memory.{min, low} for reclaiming itself
Date:   Tue, 24 Dec 2019 02:53:24 -0500
Message-Id: <1577174006-13025-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memory.{emin, elow} are set in mem_cgroup_protected(), and the values of
them won't be changed until next recalculation in this function. After
either or both of them are set, the next reclaimer to relcaim this memcg
may be a different reclaimer, e.g. this memcg is also the root memcg of
the new reclaimer, and then in mem_cgroup_protection() in get_scan_count()
the old values of them will be used to calculate scan count, that is not
proper. We should reset them to zero in this case.

Here's an example of this issue.

    root_mem_cgroup
         /
        A   memory.max=1024M memory.min=512M memory.current=800M

Once kswapd is waked up, it will try to scan all MEMCGs, including
this A, and it will assign memory.emin of A with 512M.
After that, A may reach its hard limit(memory.max), and then it will
do memcg reclaim. Because A is the root of this reclaimer, so it will
not calculate its memory.emin. So the memory.emin is the old value
512M, and then this old value will be used in
mem_cgroup_protection() in get_scan_count() to get the scan count.
That is not proper.

Cc: Chris Down <chris@chrisdown.name>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/memcontrol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f35fcca..2e78931 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6287,8 +6287,17 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	if (!root)
 		root = root_mem_cgroup;
-	if (memcg == root)
+	if (memcg == root) {
+		/*
+		 * Reset memory.(emin, elow) for reclaiming the memcg
+		 * itself.
+		 */
+		if (memcg != root_mem_cgroup) {
+			memcg->memory.emin = 0;
+			memcg->memory.elow = 0;
+		}
 		return MEMCG_PROT_NONE;
+	}
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-- 
1.8.3.1

