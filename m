Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF973DEE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFZMVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFZMU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:20:27 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5CB1990;
        Mon, 26 Jun 2023 05:20:05 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-06-64997d6d445e
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
Subject: [PATCH v10 22/25] dept: Apply timeout consideration to dma fence wait
Date:   Mon, 26 Jun 2023 20:56:57 +0900
Message-Id: <20230626115700.13873-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG/Z/L/5x21pzUyw6M6FKDJl5hUfNmzsXED/4THbpo1OgHbehR
        qqWyoiguKgreqhDUAApMazGlFlAsqCjU1Co3FYGBtZJSJxMVuS3MVi7dpdT45c0vz/s8z6eH
        p5VONpLX6vdIBr1ap8JyRt4/0Txff/CiJqbJJcDZMzHg/3iSgcIbpRharpcgKK08QkFP7Up4
        EehDMNbUTENeTguCK687aais8yFwWI9iaHszCdr9gxgac05jSC+6gaG1N0iBN/ccBSX2n+BJ
        tpkC58g7BvJ6MBTkpVOh856CEYuNA0taNHRZ8zkIvo6FRp+bBUfHXLh4yYuhxtHIQF1VFwVt
        9wox+Er/Y+FJXQMDLWczWSgbMGPoDVhosPgHOfjdaaKgPCNU9CHooOD43/+yUJ/pDNHVmxS0
        v6xGcP/kHxTYS90YHvr7KKiw59AwWlyLoCurn4NjZ0Y4KDiSheD0sVwGmv+pZyHDuxjGhgvx
        8qXkYd8gTTIq9hFHwMSQx2aR3M3v5EjG/Q6OmOx7SYV1Dimq6aHIlSE/S+y2U5jYh85xxNjf
        ThGvuwaTgWfPONJwYYxZG7VZ/oNG0mlTJMPCH7fJEx6N2dikNn6/57kNp6ESzohkvCgsEqu7
        XfQXNl3rZcYZC7NFj2ckrE8RvhUrMt+yRiTnaaHoK/Fdw6NweLIQJ9Z6ysImRogWy//KosZZ
        ISwRK0dN6HPpDLGk3Bn2yEJ69VNzWFcKi8WjXhceLxWF8zKx+Wkm8zkQIT6wephspDChCTak
        1OpTEtVa3aIFCal67f4F8bsT7Si0K8vB4JYqNNSyzoUEHqkmKmKmX9AoWXVKcmqiC4k8rZqi
        mDacp1EqNOrUA5Jh91bDXp2U7ELf8Izqa8V3gX0apbBDvUfaJUlJkuHLl+JlkWlIGf1b66uO
        jT2W69r8VT9PvXPgTcTmD2/XyOJWPK7yde5M37S9bFn0su7RWPf61ZjT5W6s/6g69GfHiWJ3
        xC/kUHzU2tbvzYFNp+Ydjqcbgxua9Nt86bd+zT3syMqfFWWsjIgxFt+eZXV/ulxHz0yKz74a
        OVA4L9HavaTLU2CZELdi57CKSU5Qx86hDcnq/wHaIHOuUwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0iTeRzH7/t9nuf7PC4XD0vqodBiFEKRGWV8oIgiwieP6zqIO7grcrWH
        XG6rNlsaBpYWnTVTyaZpMafsbLOyzT+snIi/l3dpabZkWdrPpenRNWlO66bRP29evD/v9/uv
        D0cpbMxiTqPPkAx6lVZJZLRs58bc1bqTZerEztfroOhCIgQ/naOh4lYtgd6bTgS19acwBNqT
        4cnkGILwPz0UWEp6EVQOP6OgvmMIgafmNIG+V/OhPzhBwFtynkBu1S0CD0enMfgvF2Nwun6C
        7kIbhubQWxosAQLlllwckXcYQnYHC/acFTBSc4WF6eG14B0aYKD1qpcBz+AqKLvmJ9Do8dLQ
        0TCCoe9uBYGh2q8MdHd00dBbZGbgxriNwOiknQJ7cIKFR81WDHV5kbX30x4MZ//7wkCnuTlC
        1bcx9D+9h6Dp3AsMrtoBAq3BMQxuVwkFU3+1Ixgp+MDCmQshFspPFSA4f+YyDT0znQzk+ZMg
        /LmCbNkkto5NUGKe+7jombTS4n2bIN658owV85oGWdHqOia6a1aKVY0BLFZ+DDKiy/EnEV0f
        i1kx/0M/Fv0DjUQcf/CAFbtKw/Su2N9lm9SSVmOSDGs2p8rS2sIO5kgfl+l77CA5yMnmoyhO
        4NcL1uuj9CwTPl7w+ULULMfwywS3+Q2Tj2QcxVfNE952tc0VFvA7hXbfjbkQza8Q6v4twLMs
        5zcI9VNW9G10qeCsa57LREX8e3/b5nwFnySc9reQQiSzoh8cKEajN+lUGm1SgjE9LUuvyUw4
        cFjnQpHPsZ+cLmpAn/qSWxDPIWW0PDGuVK1gVCZjlq4FCRyljJEv/GxRK+RqVdYJyXB4n+GY
        VjK2oCUcrVwkT/lNSlXwB1UZUrokHZEM36+Yi1qcg6LLeQXhMyoafzTrtVUjgbK9hTteL+81
        jCUvmfTW52b/OmOMLYl+uS7z6bgJF3elzO/ZuqV0z66bqzQJvO9S+FAgOrtta7fOm/rLxe3b
        4hyWyod/+PfY02LLB2emqhfGhZ5Xx7tfOFtTSrObUtIPDHNHs813GnQ79nc0TT3/md9tUtLG
        NNXalZTBqPofGOA1JDUDAAA=
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
consideration to dma fence wait.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1db4bc0e8adc..a1ede7b467cd 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -783,7 +783,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -887,7 +887,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
-- 
2.17.1

