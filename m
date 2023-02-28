Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005176A54C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjB1Iud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 03:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjB1IuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:50:18 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874151A96C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 00:50:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5376fa4106eso197505577b3.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677574209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=th38ntbA4Oc2oiVVTEFN7kVCZXMfBHW5bqzoJX/NKxM=;
        b=Qx1HMjnOH9OsA3ycuQn28p/IaZ+Hp3kNuLp2QUi9h0Ycfnoty+yQNpg+WRxNuY/vYp
         jOY7XFohXtJylm8Zhy5PNGpA0U7IS0oAfCING0t+nz1L/hwrLlAjdn6QB4BQ7g4vN6HH
         OAiYlZHTTmYK4E/ibEh6T98sf4VZmgYow+qhvCLJm9G0PRCymGehRtI1hbaEgguuPSwP
         c7t1cNU/lIriIMXf5vdSZTLjo71hA+1rjgeHrdym+NEDcQOTi8Gy7EZ3GPG7NMQg7zho
         MG8uusZE7ELVwRFmlhIaXFZ9jTXMsB870R8rLfTvIx/zMtY4Y5kaKuhA8atMfdGBrjnt
         RIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677574209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th38ntbA4Oc2oiVVTEFN7kVCZXMfBHW5bqzoJX/NKxM=;
        b=JiKPs1vZM4QvYm5UMXFuPbYp96r8PqwyIMyyJXNhpdcsFLKEjmKEZ/cLPG78rA8xU3
         YK3j8/YtbzMoZd1bEbrtxrAsR9XcFEix/ydfI8S4c3M0KJEam4EZtLeGeD3vOx8lNsYB
         Ci9nZTPS88iJGd4DPNt0iApbdkDk0i5/5JkFNhmZ4RDfNFhQU1ob0j+HDDjnmZNzIWQQ
         obpimWoDyDOVPckvgUxEuIeeWNfBaQeBMKCneCiY9CaBbYZTtYF0saR7/bKfQNBETiS7
         LmFsteeUue6iSRTzXltl48nNmNmKIQKS7F3nlO8r1NNWBfxxcaCzw04uCk5hQxzMBm0P
         6qpw==
X-Gm-Message-State: AO0yUKV8m3cjy7rYl3FMOHfe+uGPQZLV5WXTIN6ljHwM28YiHWZueQ9n
        DdQdEIi4ImJ3+12sMqQ94EQUzckyjtIxHUAa
X-Google-Smtp-Source: AK7set+DvIV3bw19wB6Hwqeb1fxI1Ob9E6fp4FkYQsDq5MINr8X9kGIXdnH2rMDNI8ge0fm/8/tJGYKLqoW41WxG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:ad67:0:b0:525:2005:7dc2 with SMTP
 id l39-20020a81ad67000000b0052520057dc2mr1184169ywk.1.1677574209698; Tue, 28
 Feb 2023 00:50:09 -0800 (PST)
Date:   Tue, 28 Feb 2023 08:50:02 +0000
In-Reply-To: <20230228085002.2592473-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230228085002.2592473-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228085002.2592473-3-yosryahmed@google.com>
Subject: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We keep track of different types of reclaimed pages through
reclaim_state->reclaimed, and we add them to the reported number of
reclaimed pages. For non-memcg reclaim, this makes sense. For memcg
reclaim, we have no clue if those pages are charged to the memcg under
reclaim.

Slab pages are shared by different memcgs, so a freed slab page may have
only been partially charged to the memcg under reclaim. The same goes
for clean file pages from pruned inodes (on highmem systems) or xfs
buffer pages, there is no way to link them to the memcg under reclaim.

Stop reporting those freed pages as reclaimed pages during memcg
reclaim. This should make the return value of writing to memory.reclaim,
and may help reduce unnecessary reclaim retries during memcg charging.

Generally, this should make the return value of
try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
freed a slab page that was mostly charged to the memcg under reclaim),
the return value of try_to_free_mem_cgroup_pages() can be
underestimated, but this should be fine. The freed pages will be
uncharged anyway, and we can charge the memcg the next time around as we
usually do memcg reclaim in a retry loop.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8846531e85a4..c53659221965 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -188,6 +188,16 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
+static bool cgroup_reclaim(struct scan_control *sc)
+{
+	return sc->target_mem_cgroup;
+}
+
+static bool global_reclaim(struct scan_control *sc)
+{
+	return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
+}
+
 static void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
 {
@@ -217,7 +227,35 @@ EXPORT_SYMBOL(report_freed_pages);
 static void add_non_vmscan_reclaimed(struct scan_control *sc,
 				     struct reclaim_state *rs)
 {
-	if (rs) {
+	/*
+	 * Currently, reclaim_state->reclaimed includes three types of pages
+	 * freed outside of vmscan:
+	 * (1) Slab pages.
+	 * (2) Clean file pages from pruned inodes.
+	 * (3) XFS freed buffer pages.
+	 *
+	 * For all of these cases, we have no way of finding out whether these
+	 * pages were related to the memcg under reclaim. For example, a freed
+	 * slab page could have had only a single object charged to the memcg
+	 * under reclaim. Also, populated inodes are not on shrinker LRUs
+	 * anymore except on highmem systems.
+	 *
+	 * Instead of over-reporting the reclaimed pages in a memcg reclaim,
+	 * only count such pages in system-wide reclaim. This prevents
+	 * unnecessary retries during memcg charging and false positive from
+	 * proactive reclaim (memory.reclaim).
+	 *
+	 * For uncommon cases were the freed pages were actually significantly
+	 * charged to the memcg under reclaim, and we end up under-reporting, it
+	 * should be fine. The freed pages will be uncharged anyway, even if
+	 * they are not reported properly, and we will be able to make forward
+	 * progress in charging (which is usually in a retry loop).
+	 *
+	 * We can go one step further, and report the uncharged objcg pages in
+	 * memcg reclaim, to make reporting more accurate and reduce
+	 * under-reporting, but it's probably not worth the complexity for now.
+	 */
+	if (rs && !cgroup_reclaim(sc)) {
 		sc->nr_reclaimed += rs->reclaimed;
 		rs->reclaimed = 0;
 	}
@@ -463,16 +501,6 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	up_read(&shrinker_rwsem);
 }
 
-static bool cgroup_reclaim(struct scan_control *sc)
-{
-	return sc->target_mem_cgroup;
-}
-
-static bool global_reclaim(struct scan_control *sc)
-{
-	return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
-}
-
 /**
  * writeback_throttling_sane - is the usual dirty throttling mechanism available?
  * @sc: scan_control in question
-- 
2.39.2.722.g9855ee24e9-goog

