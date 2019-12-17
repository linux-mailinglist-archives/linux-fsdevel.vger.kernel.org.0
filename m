Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D82122A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLQLbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:31:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37099 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLQLbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:31:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so5982289plz.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fFfoleXjv3JSEmvkK0O9oMZGbyG7YMfuDochkkrQvOQ=;
        b=Ay5w39y6OP8b3+PSyWbNiB80MxHJVJSkjW+k+erc0+AmU1eBRpUnMfmFdSpTt3lBiL
         WXKb1e+X82cm+QC6jSydUQ6aqBNsbSp40uxC77iTvEE/hBw1nGeZiGyQrZek3edQH7Gl
         ifi8kZqgJUVhbSMYNppmKS5VPIFpQoxn8FW8OZfVzMArfXENhsNhFjv7OoOs906svNnk
         UyazUX4Lne2F3b0VB4++90jelJF4NorPxOROqwdwtNfnKoAq9gzFSoiF/IYMstPeSHeg
         3O7TOCPm2IasOAdlxc7HFvCLj70+9f37uu7qlYmhyeS8aHA9bjFxLAUttL9nUe8+YMnG
         okPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fFfoleXjv3JSEmvkK0O9oMZGbyG7YMfuDochkkrQvOQ=;
        b=NQ+0mBO8XPuTaFqTNuXzn7n1UALlGH/CPeNg1c2EjwlYY0gldSBEuwD+q6Br8NYn8r
         jOGV+ShyhVT75ZFj3lYfmKHnwDvIlD1tnXtDAb1XaOg9Nt0zI7LPHRYTgfb8hica46oD
         t5iPKzFXffNRnXSfhllCJ2Tc2FLSvDBbdBQcYOe20ahCHEiHrIvi9QWc9otBi9URaOPW
         42WpCLvkKyfCO7KquBOQLxWXThqtU3pgcR5l45RUxhQvGO+hg332nOD1fvcNp4EKlx5J
         vtPlI2mkzbNSfpDwC725inR3//Jm/3ncaLGKkgJ/omqQJxEKPLC+YGPP5tKO0kKQ69Lu
         DW2Q==
X-Gm-Message-State: APjAAAXvwHIpyu6CAcczMC30dCC0o7DP4M15MH3freJVhl670sVUNQ92
        m0KrBu0oA+5/4UHUe5TxRCg=
X-Google-Smtp-Source: APXvYqwgOIO9DkR9d5dmrB5DvMfBD6fXB5FS6maFa7bVNVo9BDd0ix+SDlXBo+0I1chqAKdB25eFeg==
X-Received: by 2002:a17:902:9b86:: with SMTP id y6mr20608166plp.253.1576582283572;
        Tue, 17 Dec 2019 03:31:23 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm26246460pff.105.2019.12.17.03.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:31:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/4] mm, memcg: introduce MEMCG_PROT_SKIP for memcg zero usage case
Date:   Tue, 17 Dec 2019 06:29:17 -0500
Message-Id: <1576582159-5198-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
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

