Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9D122A14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfLQLb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:31:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35006 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLQLb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:31:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so7397653pfo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PfAZz+7YFL5P4jlslEzjz2qfIRhr8Qk9D33rUR/m3Pc=;
        b=rFBgOLw5GBbA5M6JYtyuopWqCS7rTgK8GrRgyaJZh1EwcwoZ4adsA7i45dxIH3ks1E
         cA2ShGT5a87N90+9y/AWBHgw7Lf9duh3wh6k7jK23S5xE38qGx7w/tTaPsAgKYDeCbgR
         qXasE3JU3WZBesFJ+CLsGJzaVeKYysjUCV32mI8wvz0bafDNCtRXZgdXXvXc/huTpRk5
         VF+QSU/YyBf3afiP4m8kPjHDwt+ETnPXi9fap5jkKdx6Nw+j2uHfk6PZ+Cheyd2oXDEN
         2/wLFGhXHmWHa1niJ7qkuiAbDyQr1Gc4aj+s0FOfPe95qklSqw9a/gvAPNINJ6cLkkoS
         atDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PfAZz+7YFL5P4jlslEzjz2qfIRhr8Qk9D33rUR/m3Pc=;
        b=GagtX7wzen0ekt46rXdZtfwCs1VN4RgOkHHoUGqtLK7sJbYqtB8gBGPEBrT9IWkI1p
         tGpK/AW22Bjoihz4j3eBapmeSr3Attnio/eAOT9excvcY+Bt2xnmUMF6OuQjxJIYTuA0
         Dy5UfKcP2vdNyiOAkEv+p9SQ4fTwHbH5iSrId+6xYreu+l18esg0DrqtqQYvpnLzq49E
         Mbp9risH9V1k4bNmD+97Wht4l4Qoh8DlHGsC8OVRzYM0P5UMbJBn+nCN95jB8GrUngc7
         B4dZNCw8Pjwb570oBVEVTaMlurvg+U5dLwPoTXIvYFq80lItgQYxMxsPLtKr5tQ3oPhN
         5lBA==
X-Gm-Message-State: APjAAAXpHcTO5XVNH6YZCGupYOW+qVMIFXQJw/gKcRqTBnsRAktTo+VL
        CyOGIeUmlabu/3ewwV7YL7o=
X-Google-Smtp-Source: APXvYqxKC4uL4weF1OEd7OR+j+1clxzVjXRygLvMNhVRBcvixxJuond5I2PkqDo/eiZsiVduAVa7ZA==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr25047436pgs.167.1576582286912;
        Tue, 17 Dec 2019 03:31:26 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm26246460pff.105.2019.12.17.03.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:31:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH 3/4] mm, memcg: reset memcg's memory.{min, low} for reclaiming itself
Date:   Tue, 17 Dec 2019 06:29:18 -0500
Message-Id: <1576582159-5198-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
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

Cc: Chris Down <chris@chrisdown.name>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/memcontrol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f35fcca..234370c 100644
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
+			memcg->memory.emin = 0;
+		}
 		return MEMCG_PROT_NONE;
+	}
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-- 
1.8.3.1

