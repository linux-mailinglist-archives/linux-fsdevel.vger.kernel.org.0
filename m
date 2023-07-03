Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78114745911
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGCJuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGCJtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:55 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECF491B2;
        Mon,  3 Jul 2023 02:49:52 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-fa-64a299b4f969
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 18/25] dept: Apply timeout consideration to wait_for_completion()/complete()
Date:   Mon,  3 Jul 2023 18:47:45 +0900
Message-Id: <20230703094752.79269-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ5773NvO+tuqomPkOyl0ZCwqWhgOVsWY5ZsPh9mMFkMifuw
        dfZmVKE0RRA2t/AmKgoIETqQOaimNsBAbtlSpsUKWmAEZKNxaGgHzM2x8qK4Mhkooyx+Ofnn
        nN//9+lInN4jxEhmyxHFZjGmGYiW106vdWxtr3GYEh4FNkLFmQSI/H2Sh7rWZgJDLU0Imtvz
        MUze2gO/zE8hWBy4zYG9aghBw3iQg3Z/CIHXVUBg+P46CERmCfRVnSZQeLGVwE/hJQyj1ZUY
        mtS90H/WgcG38IAH+ySB8/ZCvDL+xLDgbBTBmbcFJly1IiyN74C+0B0BvPdeg5oLowSueft4
        8HsmMAz/UEcg1LwsQL+/l4ehilIBvp1xEAjPOzlwRmZF+NlXj+FK0Yqo+PEzAXpKfRiKL7Vh
        CNy9iqDz5BgGtfkOge7IFAa3WsXBv5dvIZgomxbh+JkFEc7nlyE4fbyah9tPewQoGk2CxSd1
        ZPdbrHtqlmNF7qPMO1/Psx8dlHXUBkVW1HlPZPVqFnO74tnFa5OYNcxFBKY2niJMnasUWcl0
        ALOZwUGR9X61yLP7ATveF3tA+7ZJSTNnK7btuz7WptYu20XrBW3O3fw2nIfGpBIkSVROpOVd
        h55H9TtUgjQSkePoyMgCF80b5Feou/QPoQRpJU4+8QJ1PRwgUX69bKWt4ZQow8tbaMflxtWu
        Tn6Dnupuw9FM5Zdp0xXfqkezsv/9Sdkqo5eT6GhNiESdVD6hoTf6/hH+L2yiN1wj/Fmkq0dr
        GpHebMlON5rTErel5lrMOdsOZqSraOWfnF8sfehBc0MfdCFZQoa1upHPG0x6wZidmZvehajE
        GTboCse/Mel1JmPuZ4ot4yNbVpqS2YViJd6wUbdz/qhJL39qPKIcVhSrYnt+xZImJg8Vv1sz
        bKndfqg17E/Ud25e12HuyRnTlccNfJl8yTrTsrdg99empEItKzjnjD/2iclCY/e8+vqbNzfF
        uZU1D67/umxtkVMq1IODnt8ItZY/2p+iO+d/+P2LRl9/wtPkZ1PrvdO9u95Ldr8T3h8az9K8
        tDO4Naby/X2ev6qDkHHscXCzgc9MNe6I52yZxv8AioNHJUsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pz46zxwnP/IqbYklqlA+Zsdk8bMz8oWmTbu6ZburKXSJm
        SolSTSynOlTsOnVUz4VDWevWj2P9cpWyNDVJ65LFNSk/qs0/7733/rw+77/eLKHIp5ayGm2c
        qNOqopS0jJQdCEneYM0tUgcMS9shOyMA3D+ukmAss9DQ+rgUgaUyCcNQ3R54N+5CMNnUQoAh
        pxVBYd8HAirrexFUmy/R4Pw0H9rdozQ4cq7RkHy/jIa24SkMPbduYCiV9sOb60UYaiYGSTAM
        0ZBvSMbT8gXDhKmEAVOiN/Sb8xiY6gsER28nBfY7Dgqq36+H3Ls9NFRVO0iot/VjcL4w0tBr
        +UvBm/pGElqzMyl49LWIhuFxEwEm9ygDb2sKMJSnTLelfv9DQUNmDYbUBxUY2rtfInh19SMG
        ydJJg93twmCVcgj4VVyHoD9rhIHLGRMM5CdlIbh2+RYJLb8bKEjpCYLJn0Z6Z4hgd40SQor1
        jFA9XkAKr4t44XneB0ZIefWeEQqk04LV7CvcrxrCQuGYmxKkkjRakMZuMEL6SDsWvjY3M0Lj
        7UlS+NRuwAeXh8m2q8UoTbyo27gjQhaZ99fAxN6Vne1OqsCJ6CObjliW5zbz0hOUjjxYmlvL
        d3VNEDPek1vFWzM/U+lIxhLclbm8+VsTPcMv5GL5suHQGYbkvPnnxSWzv3IumE+zV+AZz3Ne
        fGl5zWyPx3Q+8DNrllFwQXxPbi99HckK0JwS5KnRxkerNFFB/vqTkQlazVn/4zHREpqejOnC
        VLYN/XDuqUUci5Tz5F3nC9UKShWvT4iuRTxLKD3lyX331Aq5WpVwTtTFHNOdjhL1tWgZSyqX
        yPeFihEK7oQqTjwpirGi7v8Vsx5LExHuDh4wrPxm3Glef6xyQXbrlcUuv7DlY50cLtZ1XLKF
        707du2XQkmZLOHwo4Gl4sXZ0nbdP7ODR1cbg2z73Bo50OA7abTE31zTvYqrmerlW1J4L8Up6
        Vqfd5u/niYz6L6ozfMTWlRfSNqx9h5ybFr0+1dDW9/C4x0VnZ8aA79jkeaWS1EeqAn0JnV71
        D1FprvouAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 32d535abebf3..15eede01a451 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index d57a5c1c1cd9..261807fa7118 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -100,7 +100,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1

