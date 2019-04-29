Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91DE88C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfD2RNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:13:49 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52139 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2RNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:13:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id i38so6704972qte.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eAfjg0nGPcLWfxJJhGXBjl7FIwajcYkmLSUZC9BoAVo=;
        b=FKmZgoHbVGCO97K3BcQ+ic4v++s8rwzSXFy75ckZdej+bpKpVXnUNuY3AXrL33BVgJ
         Hqz2qDXRzmxVtOoIbcV+h21LE3UduSmU2SvSZoF6iZ6fTU/Uda98vcUkpqI6iB9iB4m3
         ts6v/RxvQwZAPpQgbA2bqqm1snmfVmcGk/alcHvia2mC0gY7WxDx3MzXcsdnuqA/gMZJ
         XBYlW9aAVRGre8B6TOocT9qUo0Kl2vE6THP1e5dwTEiMa3I9hqxw/zuSjkYo1tPPGfr0
         F47SccgEZEd4YLwQlE/5seZLLVVmyOrAhtyFNqs1W697mP3Z5oznCNev6CK6HYxdQwla
         tG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eAfjg0nGPcLWfxJJhGXBjl7FIwajcYkmLSUZC9BoAVo=;
        b=I07y/HLCvE/DWr8SGlFw3NFFOXN34t5LEKhNdISLmgJLYKcIkXHIC28M4j0igvjqGV
         ra2kKYTEdEACfDA/CMHoIaaWmSEm0HIwNVnBUjDnuGfX0KRmj9aLBpo3trMo1FGkgm3s
         qOyR37btlyIhJOPDsGQCt1Hgn6rxjm8cIax21QjR9rppsZ+IieJgb0XqbaFOfj1HGmhs
         2Hy4D0DqdTf/tyl0DCd70cISzNXJeKPYQHvPXCpTigHXixCxfh8PYGeq4qu4RjoIymdg
         VbXb83IYIAPaxgzaqdOEJbNQyDAhwgfbTqL022iojzvgNzgJoicRBJ1vsPSmLTa1XxNL
         0pYg==
X-Gm-Message-State: APjAAAUQqN3yFEJvMA7SdyzZSictHmjjHleu4MA/v/kOnRNjBsByRj0Y
        ZY5r0t+d7c+IvzHPXxsseVzlV6b1Hk9nFg==
X-Google-Smtp-Source: APXvYqwwgWs3zy3FLOkSJFSV4QCkVGyC8pGPoFtNLJRMe+t9+l0sHrdTDJroLj5qqsGFZEw5ucWIBmehPElR7Q==
X-Received: by 2002:a0c:c18d:: with SMTP id n13mr19796452qvh.109.1556558027954;
 Mon, 29 Apr 2019 10:13:47 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:13:31 -0700
Message-Id: <20190429171332.152992-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 1/2] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
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
index 2713b45ec3f0..99eca724ed3b 100644
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
2.21.0.593.g511ec345e18-goog

