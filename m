Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE89782278
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHUEJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjHUEJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:09:53 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFB81FD;
        Sun, 20 Aug 2023 21:09:17 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-eb-64e2ded695c7
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
Subject: [RESEND PATCH v10 16/25] dept: Apply sdt_might_sleep_{start,end}() to dma fence wait
Date:   Mon, 21 Aug 2023 12:46:28 +0900
Message-Id: <20230821034637.34630-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz3SbUxTZxQH8D3Pvfe5l0rNTTHxatWRJmjE+BrAEzONJibekS0u0xgjErmu
        N6OzFNMqLyZmoKiAQkQCnUKWAqY2gKItvlYcYETQAFUrooHGVnwhgGil3SrVjeK2Lye/nH/O
        /9PhKJWTmcvpDPtko0HSa4iCVoxF1yzt8/i0KwbDC6HsxAoITBTSUN3USMB1oQFBY3M+huE7
        m+BJcBTBZHcvBeYKF4Ia7yAFzR0eBC22QwQeDc0Ed2CcQFfFcQKH65oIPBgJYxioPIWhwf49
        3D9Zi6E19JoG8zCBKvNhPDXeYAhZ61mw5sWBz3aGhbB3JXR5+hhoebYETv8+QOBmSxcNHdd8
        GB7dqCbgafybgfsdnTS4ykoYOP+2lsBI0EqBNTDOwsNWC4aLBVNFRz98ZuBuSSuGo2cvYXA/
        dSK4Vfgcg72xj8DtwCgGh72Cgo/n7iDwlY6xcOREiIWq/FIEx49U0tD76S4DBQOJMPlXNVm/
        Rrw9Ok6JBY5ssSVoocV7tYJ4/cwgKxbcesaKFvt+0WGLF+tuDmOxxh9gRHt9ERHt/lOsWDzm
        xuLbnh5W7PxtkhaH3Gb8g3qH4hutrNdlycbl69IU6eWhHrI3X5ljcZxl89BLRTGK4gQ+QXBU
        HaP+9+ur0yb8IqG/PzTtWXys4Ch5xRQjBUfxx2YItnfdJBLE8KlCeXMXjpjm44Q3/jEmYiWf
        JNR2/vFv6ddCw8XWaUdN7e3OGyhiFZ8ovPe+oCOlAl8eJRR9cpIvB3OENls/fRIpLeireqTS
        GbIyJJ0+YVl6rkGXs+ynzAw7mnop68FwyjXkd21pRzyHNNHKtHk+rYqRsky5Ge1I4CjNLKX6
        T69WpdRKuQdkY+Yu4369bGpHao7WzFauCmZrVfzP0j55jyzvlY3/pZiLmpuH6nbEFyXFzCuN
        29pWXbR1STh5zbcPh37l2mISNi6Y/8QbF7Z8V6HdlvNBvTrZw0Ub9my/krZzyJRKH8p0XU7z
        O7Imrvok2cn3hvI7sn959WN7vXG+O7HMo5+RseW52RDbn2zdTUkzk2r8wxPdsYs3P36hXp6y
        oTJ2JGdbamHw4FqrhjalSyvjKaNJ+gcAEHXBTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0xTZxgGcL/vnPOdQ7fOk0riiZi4NWHLIF5IxLwJzmjC4tlUNDOLycwm
        jT1IuRTTAoMREwr1MhAjKLIpmlpIJYAip6gIRSsItBAQLUFk0I2OCUSQySizghfqsn/e/PI8
        yfPXy1Gqi8wqTqdPlwx6TYqaKGhFXEz+2gGvT7vBO7ccik9uAP/cCRrK62oJ9F2rQVDbYMIw
        2b4dHs9PIVjoeUBBWWkfgsujIxQ0dHgRtFTlEfCMfQT9/hkC7tJCAvkVdQQePlvEMHyuBEON
        vAu6T1sxOAPjNJRNErhQlo+XzgSGgK2aBVtuOPiqzrOwOBoFbu8AA20X3Qy0DEXCr5eGCTha
        3DR0NPoweJrKCXhr3zLQ3eGioa+4iIGrz60Ens3bKLD5Z1h45LRguG5eWjv2zxsGOoucGI5V
        1mPof9KM4M6JPzDItQME2vxTGOxyKQWvrrQj8J2aZuHoyQALF0ynEBQePUfDg9edDJiHo2Hh
        ZTnZGiO2Tc1Qotn+o9gyb6HFLqsg3j4/wormO0OsaJEzRHtVhFjhmMTi5Vk/I8rVPxNRni1h
        xYLpfiw+7+1lRdcvC7Q41l+G96z+TrFZK6XoMiXD+i3xisQzgV5y2KTMstgr2Vz0l6IAhXAC
        v1Gwj9+igib8Z8LgYOC9Q/mPBXvRU6YAKTiKP/6BUPV3DwkWK/jvhTMNbhw0zYcLE7PTTNBK
        fpNgdd2l/htdI9Rcd753yFIuNzehoFV8tPBi9E/6NFJY0LJqFKrTZ6ZqdCnR64zJidl6Xda6
        g2mpMlp6GtuRxeJGNOfZ3op4Dqk/VMav9mlVjCbTmJ3aigSOUocqw/4d1aqUWk32T5Ih7YAh
        I0UytqIwjlavVH69T4pX8Yc06VKyJB2WDP+3mAtZlYsc5jf8b/X7XaYe0knys35/Nf75y6e8
        Z4fekfPNFxN9WwvVy1Pl2Ncu396kWBxn7zqwbQcXl1D9ZVd5XuQ934SGW7Z/c2SEAx2JLFmj
        z4v96lruJ9/WeQZvph9XWROaknaaYG9ojjvjftpZZ/hkRtgNa+buq/ZPu2NGhnbail/8cFtN
        GxM1URGUwah5B5yxqSkwAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index f177c56269bb..ad2d7a94c868 100644
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

