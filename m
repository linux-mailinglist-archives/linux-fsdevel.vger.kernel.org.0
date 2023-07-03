Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E3745935
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGCJt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGCJtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:49 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4E918D;
        Mon,  3 Jul 2023 02:49:47 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-66-64a299b232c5
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
Subject: [PATCH v10 rebased on v6.4 09/25] dept: Apply sdt_might_sleep_{start,end}() to swait
Date:   Mon,  3 Jul 2023 18:47:36 +0900
Message-Id: <20230703094752.79269-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH9zz33udeOrvdFBMfX5KxRrNMFFHRnZhlMWbGuyxmxA0/aJat
        896MZryYVqp1L0FeHCsvqTrsUKK0klqhTLg1EV/qGMwqI0DRqkiwCFGxArKwtRNhutbNLye/
        /M85v5wPR2B057kFgjFvl2LKM+ToiYbVTMxxLvfVuOT09q7X4UBFOkT/KmOh9rSXQPDnRgTe
        M/swRC5vgluxcQQz3b0MOKqDCJzDdxg4Ewgj8HuKCFy/9xqEopMEOqvLCRSfOE2gb2wWw+Dh
        gxga1c3QZXdhaJseZcERIXDUUYzj5SGGaXcDD+7CJTDiOcLD7PBK6Azf5MA/kAo1xwYJXPR3
        shBoHcFw/XwtgbD3OQddgassBA9UctD02EVgLOZmwB2d5OFaWx2G5pK4aP+fzzi4UtmGYX99
        C4bQ7QsILpXdxaB6bxLoiI5j8KnVDDw9eRnBSNUED6UV0zwc3VeFoLz0MAu9/1zhoGRwDcw8
        qSXr10kd45OMVOLbLfljdaz0u4tK547c4aWSSwO8VKcWSD7PUunExQiWnFNRTlIbfiCSOnWQ
        l2wTISw97unhpas/zbDSvZADZy7cpnlXVnKMFsW04r3PNdk9FUF+Z0DYc9Y/wBWiXmJDSQIV
        M6i91cu85AZbB5tgIr5F+/unX+RzxRTqq3zA2ZBGYMTvX6WeP7rjy4KQLH5KH45sTcyw4hL6
        KHwXJ1grrqUD9nr2P+cbtLG57YUnKZ7ff1KFEqwT19DBmjBJOKl4KIkW20P/HzSf/urpZ+1I
        W4deaUA6Y54l12DMyUjLtuYZ96TtyM9VUfyj3N/Obm9FU8GP25EoIP0cbf/XTlnHGSxma247
        ogKjn6stHj4u67SywbpXMeV/ZirIUcztaKHA6udpV8V2yzrxS8Mu5StF2amYXnaxkLSgEH3U
        /M7JrExt5EP/aDTVsb1oRYu/QM5IWVSkdm+0Wk6lfVeWu3bLN11ZT1c3oRa6LnmZ5f3I0NbM
        t/veTP0ReT5omb1hTNm8+G9YNFTfTYOPbJs+canPanqUZcSeXx74pQ/ONqY3LY7Jkd/GXFmZ
        G7Kc1lHiNJd+sX4o+TbodbKeNWcbVi5lTGbDv3+aBwVNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ5773Mv1bqbjsiNGueaGRPcnCSwnKgxxky5LG76wYExMdqs
        N9AJhbTIRMMCFhny0hQT7JCqpWW1od3Q1mXqrCBMtBgpGy9Cg400voCALGiJCFpbl305+eV/
        zv/36XCUwsIs5zTaQkmnVeUqiYyWfbPJ8JmnwabecD+QCnU1GyDyspIGS6ubQO9vLgTuy2UY
        xm+lw/3ZSQTz9wIUmOt7ETSNPqDgclcIgc95nEDfo6XQH5km4K+vJmCwtxL4e2IBw8jpUxhc
        nq/hrsmGoX3uKQ3mcQKNZgOOjTEMc44WFhylayDsPMPCwmgK+EODDHSe9TPgC66DhnMjBK77
        /DR0XQlj6LtmIRByRxm423WHht66WgZ+fW4jMDHroMARmWbhn3YrhovlMVvFi7cM3K5tx1DR
        fAlD//CfCG5UPsTgcQ8S6IxMYvB66il4feEWgrBxioUTNXMsNJYZEVSfOE1D4M1tBspH0mD+
        lYVs3SR2Tk5TYrn3B9E3a6XFbpsgXj3zgBXLbwRZ0eo5LHqdyaL9+jgWm2YijOhpOUlEz8wp
        Vqya6sfi854eVrzz8zwtPuo3490r98k2q6VcTZGk+3zLQVlOT00vW9DFHfnDF2RKUYBUoQRO
        4FOFlqpOOs6EXysMDc1RcU7kVwve2idMFZJxFP/TYsH5771YgeM+5PcLY+HM+A3NrxGehR7i
        OMv5L4SgqZn+z/mR4LrY/t6TEMsfvzKiOCv4NGGkIURMSGZFi1pQokZblKfS5Kat1x/KKdZq
        jqz/Lj/Pg2I/4yhZqLuCXvaldyCeQ8ol8qFjTWoFoyrSF+d1IIGjlIlyw+h5tUKuVhUflXT5
        B3SHcyV9B1rB0cok+VdZ0kEFn60qlA5JUoGk+3+LuYTlpQimo5+69mW9iJa0qV8vk4dMO/dy
        F56SHSklA9lfRjO+7zak+5K6Vw/8ldmYOqXcvuPmMu8H1ZWM10DP7zk7GG0umPlk47Nw6Nsh
        i32sOMuabyr7fSK4WftLZtJOPzTBHlcgI4M3Ok2uHz9uk++yG23D9ifGmwMVeqt5caV71TYl
        rc9RpSRTOr3qHWmXBMkvAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by swaits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..02848211cef5 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -6,6 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 #include <asm/current.h>
 
 /*
@@ -161,6 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
+	sdt_might_sleep_start(NULL);					\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
@@ -176,6 +178,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 		cmd;							\
 	}								\
 	finish_swait(&wq, &__wait);					\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1

