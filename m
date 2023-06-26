Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37273DEC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjFZMTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjFZMT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:19:28 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E9B810DC;
        Mon, 26 Jun 2023 05:19:03 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-9e-64997d6d97f8
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
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 16/25] dept: Apply sdt_might_sleep_{start,end}() to dma fence wait
Date:   Mon, 26 Jun 2023 20:56:51 +0900
Message-Id: <20230626115700.13873-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSf0yMcRwHcN/nx/e5jsvj/HrEsNuaYYgpHz+Gv/TMMjZjxkbHPXTr7thF
        P2xtxZVIjUhFcq7byXWou7S4jhylpBy1lF1Nt0iUtrjqFLnT/PPZa+/3Z5+/PiJS+pQOESk1
        JwWtRq6SYTElHphmWKFOLlCE9dwMgcsXw8D7M4OCwgcWDK77pQgsFakE9NVGwvvhfgRjTW9I
        yMt1Ibjd3UlCRV0XAkfJGQwtPcHQ6h3E0JCbieFs8QMMb7+NE+C+lkNAqXUHNF4yEFDj66Ug
        rw/DjbyzhH98IcBnMjNgSgkFT8l1Bsa7V0NDVxsNjg/LoaDIjaHa0UBBXZWHgJbHhRi6LBM0
        NNbVU+C6nEXDve8GDN+GTSSYvIMMvKvRE1Cm8x/6Ou4gIP3HHxpeZtX4ZSwnoLXDjuBJxkcC
        rJY2DM+9/QTYrLkk/LpTi8CTPcBA2kUfAzdSsxFkpl2j4M3vlzTo3OEwNlqIt27kn/cPkrzO
        lsA7hvUU/8rA8Y+udzK87skHhtdbT/G2kmV8cXUfwd8e8tK81Xwe89ahHIa/MNBK8O62asx/
        b25m+Pr8MWrXgv3iTQpBpYwXtKs2R4tj7GkP6ROpksSRxg6Ugj6JL6AgEceu5dJsOfR/e/Qt
        /4zZJVx7u48MeBa7mLNlffbnYhHJFk/leutfMIFiJruXS3V5qIApNpQrshtxwBI2gnudcZec
        PLqIKy2r+ecgf25/bUABS9lw7ozbiSd3rgRxFeWnJz2Pe1bSTl1CEj2aYkZSpSZeLVeq1q6M
        SdIoE1ceOa62Iv9bmZLHD1ShIdduJ2JFSDZNErYwXyGl5fFxSWon4kSkbJZkzmieQipRyJNO
        C9rjh7SnVEKcE80XUbK5kjXDCQope0x+UogVhBOC9n9LiIJCUlDs1c+Ruukfq85tLm7trHQd
        7FG/v7V4zpayPUWRQspRJB2kFPNCyyIyoozaxIiJbKkxll5XP3tnZXB4woamZk1mctOG9J59
        ZG9yfnDL3pGBPdtn2wnHlSPrKyOTat+ptmhejZoPT9BLt3/hfMEFUSO3ohuiflQ5Kcs2Y7e5
        I33VDBkVFyNfvYzUxsn/AqE8+OpSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxgG4L3n4z2Hauexopzg1KUGZnRqdWKeRLbwQ8OricbMRJPFRKs9
        kU4KpFWUZSRUQBGFCIoVRVOLdgjddKeaoG2VgFQqKmhJRa1EGhWZVZJqUaR+tFv258mV+07u
        Xw9Pq2xsKq/P2yEZ87S5aqxgFGuWlc43FNfrNI/KKag5qIHo2woGGs47MPT+1YLAcdFMwXBn
        NtwfDSMYv91Dg6WuF8Hpwcc0XPQOIPA07cHgf/o19EVHMPjqDmAobTyP4e7LGAXBo7UUtMir
        ofuQjYK2sSEGLMMYTlhKqfh5QcGYvZkDe0kahJqOcxAbXAS+gQALHSd9LHgezoP6U0EMbo+P
        AW9riAL/lQYMA47PLHR7uxjorali4c/XNgwvR+002KMjHNxrs1JwoSy+9k/MQ8HeN59YuFHV
        FteZvynoe+BCcLXiCQWyI4ChIxqmwCnX0fDhj04EoepXHJQfHOPghLkawYHyowz0fLzBQlkw
        A8bfN+CsTNIRHqFJmXMX8YxaGXLTJpLLxx9zpOzqQ45Y5Z3E2TSXNLqHKXI6EmWJ3LwfEzlS
        y5HKV30UCQbcmLy+c4cjXcfGmbUzflFk6qRcfaFkXPjTZkWOq/wSW2BW7n7X/QCVoGeKSpTE
        i8ISMWT1swlj4Tuxv3+MTjhZ+FZ0Vj2P5wqeFhoniENd17lEMUVYL5p7Q0zCjJAmnnKdwQkr
        haXirYpz9H+js8SWC23/Oimeu27ZUMIqIUPcE2zHh5DCir5qRsn6vEKDVp+bscC0PacoT797
        wdZ8g4zin2MvjtW0orf+7HYk8Eg9UamZeUynYrWFpiJDOxJ5Wp2snPbeolMpddqi3yRj/ibj
        zlzJ1I6m84w6Rblqg7RZJWzT7pC2S1KBZPy/pfik1BJUsZr2vmE1xciYcjulf/Jg9YuptfNX
        LN3Wyc/0L3cenn323N0N10q9mnoyEbLWp/7u3tJ/pCd9X2Tt5NmhcDjSOulk/vdqt/3n7DkB
        9xNX18rrSkPkhyFf4Ef/vtiyNNU64zdiAb1VzrLMaw5UTq/Uyuaip9kbM1WLW8/a0tMdv6oZ
        U4520VzaaNJ+AT5cFyg1AwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dma fence waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 406b4e26f538..1db4bc0e8adc 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -782,6 +783,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -795,6 +797,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -884,6 +887,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -898,6 +902,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1

