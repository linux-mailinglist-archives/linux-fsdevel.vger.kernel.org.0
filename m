Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E496B201B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCIJcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjCIJbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:31:37 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0AA1FE9
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 01:31:35 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t24-20020a1709028c9800b0019eaa064a51so827666plo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 01:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678354295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEwBMGSn5GpbGlanBqXFsfdHu3Z53NaeJ1a3nMwnQiU=;
        b=Ze5OIdzu8ujFo9cbq83YqFk9GJOpYr3a3BQKfOSfr4rWI6Yo1wqOYG0VZvkRQl/DgU
         ONZDb780V2AJLPqQWE3i1IZDOj2DrlnYx2p9SESApSRJk73I5fI+TzBG7cY4phGhOfvE
         fsxBi+Mbo+Sti9UuMrxl9QnG0QjPUVEa7+s1cz+Q3wYagCiAWB2+bxT6WbOhwW63YCyL
         vx4QV8MkTkeQi+EJ1ehIcECB6ITq43CvVn8IyyqwmqR4ySJXDiat0u00fzVgzef7Kjx0
         9ui6RevSQ/etQzip+tetVSB6hNPcbI8D0n9SoMlj9xGPz0n+yHL+qWibozRsuDEXX+zi
         /5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEwBMGSn5GpbGlanBqXFsfdHu3Z53NaeJ1a3nMwnQiU=;
        b=T/rOx80ORcCaRlTWuyqg3Kj0v9oRON7y8bvnMUdwiYGNI9fBTGdO8QPd/JOa+fwuf5
         REH/I6Zj9z3F2+oCdfOARII9ywJCi8VQE0RBGcISBn7U9Mbxn20bh7ojVgmiJfSNjoRe
         Kp6fOaWvPvIzlsocUgxQFrWLryrA2K4JfvjJTGbiQpmdG6b5GzBrXn1WoSByJAyioV+E
         Zj1qEdxdPXTohn8cs6cfoFve72XFUwxYOmhMoP7uVz8depvKRkWBqtpxn5rpJXkJvORv
         9ghOg+7Uk6S1q19fBREMnJHLBJo6cl9ePp6NuzWuiqyn3h+NvM/tav9p5m7Uu3VvVUiI
         2IfA==
X-Gm-Message-State: AO0yUKXhwhuBTybcmEFIkBFf+FT0LyAdpfLebAN3kSOEu8e0eKBjdxHX
        5jFvA+AvbykZgg1goDhPZjdOwWrbZgUrFvdh
X-Google-Smtp-Source: AK7set/0zSElUk4SV6Jx9e5eK8m600vzb0RCF1MUNHWJepBbU4SjCTMuv6lVZNxTeTFxx/o7bLiMKSNeOfppeLHP
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:2953:0:b0:502:ecb9:4f23 with SMTP
 id bu19-20020a632953000000b00502ecb94f23mr7361890pgb.5.1678354295295; Thu, 09
 Mar 2023 01:31:35 -0800 (PST)
Date:   Thu,  9 Mar 2023 09:31:09 +0000
In-Reply-To: <20230309093109.3039327-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230309093109.3039327-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230309093109.3039327-4-yosryahmed@google.com>
Subject: [PATCH v2 3/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
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
buffer pages, there is no simple way to currently link them to the memcg
under reclaim.

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
 mm/vmscan.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a3e38851b34a..bf9d8e175e92 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -533,7 +533,35 @@ EXPORT_SYMBOL(mm_account_reclaimed_pages);
 static void flush_reclaim_state(struct scan_control *sc,
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
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

