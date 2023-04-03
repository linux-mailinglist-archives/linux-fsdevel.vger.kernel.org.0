Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924F6D5468
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjDCWDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCWDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:03:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EA2D60
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 15:03:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b1-20020a17090a8c8100b002400db03706so7963273pjo.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kId3QKjERA5KglVeO1VKvGvv5azlGeISt3c2gJrYgyo=;
        b=W/ze/sAlU7O+7GhoVMA+gO+b3zK1GLSBb2wxG7cqOl+9vjmm6QdV40GnYhvFBAr6we
         6QpU1r1iDXHFCTCDI3KvZCA5Fdx66xMvZLtqAf+RggvSzScbqU6Qb+D3U4BXwhb/OMA1
         mj7EUoKa/2hKudyISX9IDUT5QtGjglqN6doUhxmfcL1+w5LR9gcm9RCdAs4iQ3yY+fKw
         8EP2M2Ss5aeWYRlPCW8BW8qsios85nr5jm7RooCKJYkRU/xUY3Tcdg08l4PT4At3QjPp
         8RJrh+/qwzB7v9VlZ60Az/txlakHCjAKDKadt2/B61f8k1qeYBs4X+ujruMC4SFwxMjN
         IvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kId3QKjERA5KglVeO1VKvGvv5azlGeISt3c2gJrYgyo=;
        b=eT9r6gp7S7CkrnsQZRBYLLi1V2KTbyAj5v8Obh3cAS8VU1aJNdhoYo2ujmczRukVO+
         2kX1R2r6NL9yhEotp69OSs1U2O8CAoNKhpPtiMp5U4biBTteI1vZzoq9x0ZV1VJeos/G
         DEr/AGKwcwa9QUrHVwpbj39RdzJ7FfJ75wkyjwdQRwSoGpCg4N4wP0SVGqo90Y2NMPRs
         8dUHZkG/dfz04hOP15YP1dyeseEeXjfTCvuBFQIzXHmlVZnNP3RXu910WZnt4qudjs5o
         uPkJR6vlK8Cty5mb4AWQ0yFsNPx43YHFbeWjrHgPVKRQuFj0J17oimqydmIImq3hEp5/
         /6hw==
X-Gm-Message-State: AAQBX9clzcvamzFv/ao+3pfI9VXrDnQB+dXqeRasWUh/r+25OxTYb5q+
        F7DgZNOLk8ra83EEpIrSqpHOS5JuirKc7lmR
X-Google-Smtp-Source: AKy350bROYdy/7K8uGxBM0X/ZxH2AG6/5IpCycN9GV2HdX4MbVmRhF2WLCfVj205eUvkzCs7+3h4yAAbVuROFoGd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:f307:0:b0:50c:bd0:eb8c with SMTP id
 l7-20020a63f307000000b0050c0bd0eb8cmr39435pgh.6.1680559421112; Mon, 03 Apr
 2023 15:03:41 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:33 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-2-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh() call
 outside lock section
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
flush, which can be expensive on large systems. Currently,
wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
have to make the rstat flush atomically. On systems with a lot of
cpus/cgroups, this can cause us to disable irqs for a long time,
potentially causing problems.

Move the call to wb_over_bg_thresh() outside the lock section in
preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
The list_empty(&wb->work_list) should be okay outside the lock section
of wb->list_lock as it is protected by a separate lock (wb->work_lock),
and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_*
lists the wb->list_lock is protecting. Also, the loop seems to be
already releasing and reacquring the lock, so this refactoring looks
safe.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 fs/fs-writeback.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 195dc23e0d831..012357bc8daa3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct blk_plug plug;
 
 	blk_start_plug(&plug);
-	spin_lock(&wb->list_lock);
 	for (;;) {
 		/*
 		 * Stop writeback when nr_pages has been consumed
@@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb,
 		if (work->for_background && !wb_over_bg_thresh(wb))
 			break;
 
+
+		spin_lock(&wb->list_lock);
+
 		/*
 		 * Kupdate and background works are special and we want to
 		 * include all inodes that need writing. Livelock avoidance is
@@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress)
+		if (progress) {
+			spin_unlock(&wb->list_lock);
 			continue;
+		}
+
 		/*
 		 * No more inodes for IO, bail
 		 */
-		if (list_empty(&wb->b_more_io))
+		if (list_empty(&wb->b_more_io)) {
+			spin_unlock(&wb->list_lock);
 			break;
+		}
+
 		/*
 		 * Nothing written. Wait for some inode to
 		 * become available for writeback. Otherwise
@@ -2093,9 +2101,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		spin_unlock(&wb->list_lock);
 		/* This function drops i_lock... */
 		inode_sleep_on_writeback(inode);
-		spin_lock(&wb->list_lock);
 	}
-	spin_unlock(&wb->list_lock);
 	blk_finish_plug(&plug);
 
 	return nr_pages - work->nr_pages;
-- 
2.40.0.348.gf938b09366-goog

