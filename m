Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D9782293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjHUEMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjHUEMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:12:03 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEDA79D;
        Sun, 20 Aug 2023 21:11:33 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-4b-64e2ded7e715
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
Subject: [RESEND PATCH v10 22/25] dept: Apply timeout consideration to dma fence wait
Date:   Mon, 21 Aug 2023 12:46:34 +0900
Message-Id: <20230821034637.34630-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+35/j3ec/bps/ZSNnRnzWCb7uJnxl68/jA2bp03H/aabq+wu
        kc0cnZCKbBVp9KBz60q6y0ZPS3RJylESq3QnlEocl1Ie7ph/Pnvt/Xm/33+9eUpZxYTxurgE
        yRCn0atYOS0fmV6w9GWvRxtxJz0UMtMiwPftLA155aUsuG7ZEJRWnsQw2LgBXo4NI5hsfUpB
        TpYLQYG7h4JKZy+CWuspFtr7Z0CHb5SF5qzzLCQXlbPwbGgKQ3f2JQw2+yZouViIoX7iAw05
        gyxczUnG/jOAYcJSwoHFNB881lwOptyR0NzbyUDt68Vw5Vo3CzW1zTQ473owtFflsdBb+puB
        FucjGlyZ6QyUfSpkYWjMQoHFN8rB8/p8DLfN/qKUr78YaEqvx5ByowJDx6tqBHVn+zDYSztZ
        eOAbxuCwZ1Hw42YjAk/GCAen0yY4uHoyA8H509k0PP3ZxIC5Owomx/PYdWryYHiUImbHEVI7
        lk+Tx4UiuZfbwxFz3WuO5NsPE4d1ESmqGcSkwOtjiL3kHEvs3kscSR3pwORTWxtHHl2epEl/
        Rw7eEr5LvkYr6XWJkmH52mh5jNf1EB1q5492TQ7QJmTjUpGMF4WVYm52Bfufh8d/0QFmhQVi
        V9cEFeCZwlzRkf6eSUVynhLOTBOtn1v9AZ4PEbaLTa2JAQ8tzBdTPO//+hXCKvFCaj/zr3OO
        aLtd/1eX+XV7dRUKsFKIEr+439KBTlFIlolPyl5Q/wKzxPvWLvoiUuSjoBKk1MUlxmp0+pXL
        YpLidEeX7Y+PtSP/oizHp3bfRV7X1gYk8Eg1XRE926NVMppEY1JsAxJ5SjVTEf7drVUqtJqk
        Y5Ihfq/hsF4yNqBwnlaFKlaMHdEqhQOaBOmgJB2SDP+/mJeFmdD11TsHFjpHfj4v64m58Wy2
        2lGu//2uu3LXuLdGrebrQGlyFDWmtYSEzvW1hUV22va1qBVy1UdzXXjbeqmy+ERmyHJcdm/a
        mye5OOj7jJ4+t7NItzl49auhtzfp4o26iIipkBRjYfS8HcF79M74ajK0LWO7KWqJEJTQt2mb
        jBxQ0cYYTeQiymDU/AGjhYT/TQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRzFe967q9XLsnwxoVhZoGUZGX8oog9RD2WXL9GFLq72ksOptenS
        ILBcVksrJV3pCi+1xK3UKeUd8zK10FaKWajolFKcWea8pFla9OXw45zD+XQ4UmaivTlVRJSo
        iVCo5YyEkhzYFr+hvdup3FTwajskJ24C99gNCkz5VgYczy0IrMVXCBis3wMfxl0IppvfkmBM
        dSDI6u0iodjejaAy9yoDrf2Loc09wkBT6i0G4nPyGXg3NENAZ1oKARbbfnhzN5uA6qkvFBgH
        GcgwxhNzMkDAlDmPBXOcLzhz01mY6Q2Epu52GmofNtFQ+ckfHjzqZKCisokCe4mTgNYyEwPd
        1t80vLE3UuBITqLh2ddsBobGzSSY3SMsvK/OJKBAP7eW8GOWhoakagISHhcS0PaxHEHVjR4C
        bNZ2BmrdLgKKbKkk/Hxaj8B5e5iFa4lTLGRcuY3g1rU0Ct7+aqBB3xkE05MmZuc2XOsaIbG+
        6CKuHM+k8OtsAZemd7FYX/WJxZm2aFyU64dzKgYJnDXqprEt7yaDbaMpLDYMtxH4a0sLixvv
        T1O4v81IHPI5LtmuFNUqnajZuCNEEjrqqEPnW7mYjukBKg5ZWAPy4AR+i+CanKXmmeHXCR0d
        U+Q8e/KrhKKkz7QBSTiSv75QyP3WzBgQxy3lDwsNzbr5DsX7CgnOz3/7Un6rcMfQT//bXClY
        Cqr/+h5zvq28DM2zjA8Svvf2UXeRJBMtyEOeqghduEKlDgrQhoXGRqhiAs5GhtvQ3GfMl2eS
        S9BY654axHNIvkga4uNUymiFThsbXoMEjpR7SldM9CplUqUi9pKoiTytiVaL2hq0gqPkXtK9
        R8QQGX9OESWGieJ5UfM/JTgP7zgUXEy+DKlfnxj2sLCr6lvcJW+vfUt+h6dGzVJHJwKX+YHx
        zNofi+0XNI4c8VdaSt1qemHOfS54eY8+YPcahevEk80TWfvqU4IPemlKs0NLlhXGqDf0+VIX
        n/pPlmnx0M9j9IuTBTM+6FWiyevUjtd9Y5cHrIFjlsgK/T37ro8tEzo5pQ1VBPqRGq3iD+kT
        KhIvAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index ad2d7a94c868..ab10b228a147 100644
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

