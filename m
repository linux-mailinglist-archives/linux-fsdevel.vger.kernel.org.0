Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E9745959
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGCJu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGCJts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:48 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0A01B6;
        Mon,  3 Jul 2023 02:49:46 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-46-64a299b2c9a4
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
Subject: [PATCH v10 rebased on v6.4 07/25] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date:   Mon,  3 Jul 2023 18:47:34 +0900
Message-Id: <20230703094752.79269-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH9zz33ufedlavlekzNdM1cRqM77CcLWqMX7zZZuJiSLaZTRt7
        I90KmoJINSZVwBcEIkyovCktpuugm3KLEV/KOlQUVKjYICNALBEVoeLQory42WL8cvLL+Z/z
        +/QXGO1lbrZgTE6Vzcl6k46oWXVoin2JUuwwLG+wrob8nOUQfnmEhbKzbgL+P6sRuGsPYOi/
        vgHujwwiGL/TyoCt0I/AHuxmoLaxB4HXdZDAvYdTIRAeItBUeIxARuVZAncHJjB0FRVgqFY2
        wq3jDgy+0ccs2PoJlNoycGQ8wTDqrOLBaV0Ava4SHiaCK6Cpp50Db+diKD7VReCKt4mFxrpe
        DPculRHocf/Pwa3Gmyz483M5+OOZg8DAiJMBZ3iIhzZfBYZzmRHRoRf/cXAj14fh0JkaDIF/
        LiOoP/IAg+JuJ3A1PIjBoxQyMPbbdQS9eSEesnJGeSg9kIfgWFYRC61vbnCQ2RUP46/LyLov
        pauDQ4yU6dkjeUcqWKnZQaWLJd28lFnfyUsVym7J44qVKq/0Y8k+HOYkpeookZThAl7KDgWw
        9KylhZdunhxnpYcBG9405wf1aoNsMqbJ5mVrt6kTB7whftdf09PL/dd4K6qdmo1UAhXjaN/9
        Mfyea2s6uSgTcSHt6Bhlohwjzqee3EeRvVpgxMMfUtfzOyQazBDT6YtX9ZPMigtoccHQpEgj
        xtOJdjf7TjqPVp/zTYpU4ue073UeirI2ctNV3EOiUir+qqI5Sjl59/Ax/dvVwR5Hmgr0QRXS
        GpPTkvRGU9zSREuyMX3p9p1JCopUyrl/YksdGvZvbkCigHRTNB377AYtp09LsSQ1ICowuhhN
        RvC0Qasx6C17ZfPOrebdJjmlAc0RWN0szcqRPQatuEOfKv8iy7tk8/sUC6rZVmR9Vcl+P/fn
        57etv4ebz3xVnv5079MQu/LapzNbVPlt875wtl2ip/9NzRaWzbKM5cZ6dxTkL150wlVzovvr
        LZ8ctGc13/3pRxRIWHP+5bSEb4LTP9qM7Kbz4meOygv2vpIinOCrW9/bGrf9u2kxahpvWXuy
        dOuqi7ctG8psm771dAcLdTo2JVG/IpYxp+jfAl/A82VOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxiG977fkW7Vz1rjt26JpBGNmgkmgk/mMpfsh++WbPGPJ/whjf20
        DQdJqwjqErTonAoTNmRAUUApDVSoX2uCaJHAqBwiVGkQGkAhqGsAWYCCHHZoXfbnyZX7vnP9
        enhKVcZoeGPaCcmUpkvRsgpa8f1Oy2dycaU+ru7XGMi/Ggeh2Us0WOsdLPjqahE43OcwBNt2
        w/O5CQRLT3ooKCr0IagYGaLA7R1G4LGfZ6F3bAX4Q1MsdBReYcFyq56Fp+PLGAavF2Colb+D
        rmuVGJoX3tBQFGShtMiCw+cPDAu2Gg5s2TEwai/hYHlkG3QM9zHQWtbBgCewBYpvDLLw0NNB
        g7dhFENvo5WFYcc/DHR522nw5ecycOdtJQvjczYKbKEpDp41l2Nw5oRtF2f+ZuBxbjOGi7fv
        YvAPPEDQdOklBtnRx0JraAKDSy6kYLG6DcFo3iQHF64ucFB6Lg/BlQvXaej56zEDOYPxsPTO
        yn61k7ROTFEkx3WKeObKadJZKZL7JUMcyWkKcKRcPklc9s3k1sMgJhXTIYbINT+xRJ4u4Mjl
        ST8mb7u7OdL+2xJNxvxFeM+niYov9FKKMUMyxX6ZpDCMeya59EerMst8v3PZyL3iMoriRWG7
        6L4bYCLMChvF/v4FKsJqIVp05b4O5wqeEn78ULT/+YSNFKuFTHFmvuk900KMWFwwhSOsFOLF
        5T4H/Z90nVjrbH4vihISxFfv8lCEVeHNYPEwew0pytEHNUhtTMtI1RlT4reakw1ZacbMrUeO
        p8oo/DS2H5bzG9Bs7+4WJPBI+5Gy/0yFXsXoMsxZqS1I5CmtWmkZualXKfW6rNOS6fhh08kU
        ydyCPuFp7Vrlt/ulJJVwTHdCSpakdMn0f4v5KE02cq7ZV/v1lslOxdL8ITFTLD1brQxqDq0M
        zFbvjf4laZ2BCezN9388dFDj6bSquxMbY7vXnj86Lfvt3wxs2vXadiNhTzTxFgg7fJqzzjV9
        L1421NVbFxuPVZVsiB1wz/fvMqyaWd36uanw3vY2NZ8tl/zsTV6//kB6leW22RVcTHJqabNB
        t20zZTLr/gX+XJbcMAMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by
wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 62b32b19e0a8..32d535abebf3 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/swait.h>
+#include <linux/dept_sdt.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -26,14 +27,33 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
+#define init_completion(x)				\
+do {							\
+	sdt_map_init(&(x)->dmap);			\
+	__init_completion(x);				\
+} while (0)
+
+/*
+ * XXX: No use cases for now. Fill the body when needed.
+ */
 #define init_completion_map(x, m) init_completion(x)
-static inline void complete_acquire(struct completion *x) {}
-static inline void complete_release(struct completion *x) {}
+
+static inline void complete_acquire(struct completion *x)
+{
+	sdt_might_sleep_start(&x->dmap);
+}
+
+static inline void complete_release(struct completion *x)
+{
+	sdt_might_sleep_end();
+}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -75,13 +95,13 @@ static inline void complete_release(struct completion *x) {}
 #endif
 
 /**
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
-- 
2.17.1

