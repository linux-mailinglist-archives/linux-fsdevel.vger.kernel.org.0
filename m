Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA29688ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjBBXcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 18:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjBBXci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:32:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B195D4ED9
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 15:32:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id oo13-20020a17090b1c8d00b0022936a63a22so3568188pjb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNiCqwzESyAJCUAtzOveFlWcEoCPQvaoYU5oWya4UE=;
        b=hOhCADwPkxUGmi7V1P/nnFPjlarle5tUS/LLXkpE2OMQZSESuPz1Yg7ch5+w2lQPvZ
         Tg/E8g4ve+TuLwEeRfChTbEYbLJeSDJDBhmLL+z83Q3UbkFRR/7iALI3n//9YzuETtUk
         /td2TUtQtadczPSW8P9uXTi/L7bXWxzWMSBHRmqrt9SBSEfcBH/jtfBlcjWv7c1f+PLe
         QQJMnYWOv7ywl4B7eaZ7s3dALT60pveMbI3kcs7UOtDp14gKlyebUk9ejlg7acW+153Z
         oPfBCDEgRhQOIX+ZejkUx9YYjTBJC43e4lfmtvzzmccRB1Rl0AHErHGP8WlCALz8YStS
         jSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNiCqwzESyAJCUAtzOveFlWcEoCPQvaoYU5oWya4UE=;
        b=nDn/HcCck3WpNM1PUU4WcAaGpU0f6yttL2mhGL6gd73YkIRjaE3fH0MMlI8Lbz+RFW
         1KAVF7qElNT3X9CKULsWicUVj4twBnidcFmilUa8+Kd1p9/AqM2WX3VVq0TKyqC90crv
         VdBgoe3tCwwDS4ufWZFYgAPpKExe06hi9PSSctc+sLRxUotTVyJjPQc8fdtW4lLxjcBe
         gC0RambAZxnFZej1+3a7kvS1joxIANoEtEk09W4Bny1kK3ZVfhD7Vr9hbHY49K817xJu
         04GRqr7sJ601gq79e6AjmsZ57tF0p70YYgvRJiyKfGNh/u2+NIj9/ZeDa5b2FMXuMvo7
         XKeg==
X-Gm-Message-State: AO0yUKUBq9dbaBbxX8wsmreuIKms1MU6fAH5Ihy8/Owx0YNzOUU52qAu
        VVUk75D1iMKzoUue4TW+ZaBzxzrSYuCHDCqY
X-Google-Smtp-Source: AK7set/gX+d7qL2VYRm0mNT1mURMK3jqpTnNExhfErr1wouO0vmd1XoXrrDp0BwbdxbCN+7oo8RXZwzOeOx6nPe4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:1c8:b0:193:9ec:fc13 with SMTP
 id e8-20020a17090301c800b0019309ecfc13mr1942596plh.33.1675380757137; Thu, 02
 Feb 2023 15:32:37 -0800 (PST)
Date:   Thu,  2 Feb 2023 23:32:29 +0000
In-Reply-To: <20230202233229.3895713-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202233229.3895713-3-yosryahmed@google.com>
Subject: [RFC PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
for clean file pages from pruned inodes or xfs buffer pages, there is no
way to link them to the memcg under reclaim.

Stop reporting those freed pages as reclaimed pages during memcg
reclaim. This should make the return value of writing to memory.reclaim,
and may help reduce unnecessary reclaim retries during memcg charging.

Generally, this should make the return value of
try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
freed a slab page that was mostly charged to the memcg under reclaim),
the return value of try_to_free_mem_cgroup_pages() can be
underestimated, but this should be fine as it is mostly called in a
retry loop.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 63a27d2f6f31..207998b16e5f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6181,7 +6181,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state) {
+	if (reclaim_state && !cgroup_reclaim(sc)) {
 		sc->nr_reclaimed += reclaim_state->reclaimed;
 		reclaim_state->reclaimed = 0;
 	}
-- 
2.39.1.519.gcb327c4b5f-goog

