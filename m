Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57441ACFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfELQJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 12:09:42 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47669 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELQJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 12:09:42 -0400
Received: by mail-vk1-f202.google.com with SMTP id x77so5312216vke.14
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2019 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZQi/sjipIMJL03RXDXGUBdRsbi1X2/+nI6E1TTfR44o=;
        b=rT6GYZe9JljSs+O2RaDoCdYaRjz42r+UWesVjP61KLuG6brTai+B8I0s6wONcIdeUT
         ZgBS6h91WxDWjJLdDl7mdy4nSk0wB5tEBBSyUohFeLAeQOweZF4nSJgoeSX+Z5lOzW7w
         w1Kh4U5cruF03Fr6NcBIc2mu420URojoYNetRwXEgPNIIXNvzdCfMX4cuXwBaod2hE8y
         AcVWU+jdpmBSZ75RVzArG/oirAEeyO6gh8KNjZ7rVUrwOjObNx6lGpqFGYsn7BWv0Bz4
         yPD+2/26OCSf5xX0lvA/2dklhzgpKqeKHWI2sajCsyjGu0mYRjb04/FHoNtrsslXB/MH
         Fe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZQi/sjipIMJL03RXDXGUBdRsbi1X2/+nI6E1TTfR44o=;
        b=EDfSmXsFGCwmg7EFMJHmuLrVZme78WJDZ4b66eC9mygScWDbJcWFX6f2rzMYsXIQKo
         k0zqbXhGAugwEP7npiUpHgt5Ql7AI5pZAi0dtakO8fxeI31CnATo0Hr/kVz/qQSr2V/q
         UOT78q0uokPbEkgnsoP5XMPV9fUgN2TCqNnVKmUDAQXsA39li4I/nyA5PcSRw5TXCUNa
         g32VzpRFvJ/Ngv/rI32qf3WXEiPFmyUo0jag8ydUTCNUk+w9QCzN19J1fUSyq70MtvXv
         ULIZSDLQ2teQO4cxR1eBEpKTc8czh948uk4cw/vb7GWi6KHgj5AdxdiRcmnrPcLPOLx7
         cJzA==
X-Gm-Message-State: APjAAAWBNhKAHhce2FKiePEDqmMJJ8JzHE3b+FS0GNLO0O0/0qUSif1D
        bGFiZj5jWMmLCQ8Idpu5ch5+qhFTArJnEg==
X-Google-Smtp-Source: APXvYqzwH4rxmIbxD+iMOiqD9UQKKFw9tWXDR5aDKuxRx6lP62JMAnkQ546tt3tD+hmPNt6X3Uoy8PlTi8nDoA==
X-Received: by 2002:a67:dd0c:: with SMTP id y12mr1988351vsj.119.1557677381452;
 Sun, 12 May 2019 09:09:41 -0700 (PDT)
Date:   Sun, 12 May 2019 09:09:26 -0700
Message-Id: <20190512160927.80042-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RESEND PATCH v2 1/2] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
OOM killer will not be triggered and indeed the page alloc does not
invoke OOM killer for such allocations. However we do trigger memcg
OOM killer for __GFP_RETRY_MAYFAIL. Fix that. This flag will used later
to not trigger oom-killer in the charging path for fanotify and inotify
event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog since v1:
- commit message updated.

 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2535e54e7989..9548dfcae432 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
-	bool oomed = false;
 	enum oom_status oom_status;
 
 	if (mem_cgroup_is_root(memcg))
@@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (nr_retries--)
 		goto retry;
 
-	if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
+	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
 	if (gfp_mask & __GFP_NOFAIL)
@@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	switch (oom_status) {
 	case OOM_SUCCESS:
 		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
-		oomed = true;
 		goto retry;
 	case OOM_FAILED:
 		goto force;
-- 
2.21.0.1020.gf2820cf01a-goog

