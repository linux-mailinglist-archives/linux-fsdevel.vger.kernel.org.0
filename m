Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C7173DEAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFZMPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFZMOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:14:03 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A0FE79;
        Mon, 26 Jun 2023 05:13:55 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-fc-64997d6b187d
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
Subject: [PATCH v10 07/25] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date:   Mon, 26 Jun 2023 20:56:42 +0900
Message-Id: <20230626115700.13873-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTWRSAvXdm7kwrxXHQdUSDpgaNbBZxRT3xHU10YlyzCf80Zrexk21D
        qaZIAY0JVDSKgA+ClYeKZVMQWMWCikKRRXn5oi4EqanNwpqFCkiCFq3go9X45+RLzne+X4ej
        hCYmktMbD8gmo8agJkpaORpm+8lwuFAb1/FfGJzJiQP/2+M0lFyrJuC6WoWgui4Tg691Gzyb
        GEEw+biLAmuBC8Hl/hcU1LV5ETgrLAS6X4ZDj3+MQGfBSQJHyq4ReDo8hcFz7iyGKscv8PC0
        DUNzYJAGq49AsfUIDo4hDAF7JQv2jGgYqChiYap/OXR6exlwPv8RCi96CDQ6O2loqx/A0H2n
        hIC3+jMDD9s6aHCdyWXgr9c2AsMTdgrs/jEW/mkuxVCTFQy9mnJiOPbmEwPtuc1B+vM6hh53
        A4Km4/9icFT3ErjnH8FQ6yig4EN5K4KBvFEWjuYEWCjOzENw8ug5Gro+tjOQ5VkJk+9LyKa1
        0r2RMUrKqk2VnBOltPTAJkq3i16wUlbTc1YqdaRItRUxUlmjD0uXx/2M5Kg8QSTH+FlWyh7t
        wZKnt5FIr588YaWO85P0r/N3KddpZYPeLJuWbfhdqRt2jrL7785Mu+C6z2aguvBspOBEPl48
        cdfOfOe8Ri8dYsIvEfv6AlSIZ/ELxdrc/4OOkqP4suniYMd9NhtxXASvE9utiSGk+WjRkrco
        pKv4lWKxLx9/Sy4Qq2qav2YU/Cqx4ZENhVgIOhZPCwklRT5fIX6cHKS/HcwV/67oo08jVSma
        VokEvdGcpNEb4mN16UZ9WuzefUkOFPwq++Gp3fVo3JXQgngOqcNUcVHntQKjMSenJ7UgkaPU
        s1Q/vLdqBZVWk35QNu37zZRikJNb0DyOVs9R/TyRqhX4PzQH5ERZ3i+bvm8xp4jMQGnCou1b
        r86OX3qqfNOQ111UcyeyIYJ/xM2u3/vWGLMhqnBj4e7M/pkzfN05CbSQeGvbxZrWl3veWHcM
        da3enhAetTHCycTO2TyQv+TmmiJL30HSv97dZYo0+y7N8+6MXqEIuG+8WydYdqa4dery1MVm
        7SH87PaNrdmWLSuom1c+pavpZJ1meQxlStZ8AYYYLbRRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxzGfd9zpVpzrGQ70+iWGmbCNoRkLP8EYvxgwhsTCS5EE2OinT2x
        DVBNy3ULCxRQVoUIBst1KcVUhDpYSyJKqwSQy0ToBJmTyoS4YVcuCbOEjoq2Gr88+SXPk9+n
        h6cUFmYHr9VlS3qdKlPJymhZalLJVxmFdep493QcVF2Kh8CrchoaO+wseH5pR2DvKsbgu58C
        f6wuIFh/OE6BucaDoHn2GQVdgzMI3K1GFiZebIXJwDILIzUXWShp6WDhd38Ig/dqNYZ2x2F4
        cNmKoTc4T4PZx0KDuQSH4yWGoK2NA1tRDMy11nMQmk2AkZkpBvqbRhhwP/0C6n72suByj9Aw
        2D2HYeJOIwsz9jcMPBgcpsFTVcHAzSUrC/5VGwW2wDIHj3otGDpLw7Z/Q24M5//bYGCoojdM
        137FMPlnD4K75c8xOOxTLPQHFjA4HTUU/H/9PoK5ykUOyi4FOWgorkRwsewqDeOvhxgo9SbC
        +lojeyCZ9C8sU6TUmUfcqxaa/GYVye36ZxwpvfuUIxZHDnG2xpIWlw+T5pUAQxxtP7HEsVLN
        EdPiJCbeKRdLlsbGODJcu06n7TouS1ZLmdpcSb9v/ymZxu9e5M7d25bf5BngilDXVhOK4kXh
        a7HSNUNHmBX2ik+eBKkIRwufic6KfxgTkvGU0LJZnB8e4EyI57cLGnHInBFBWogRjZV7InO5
        kCg2+K7g98pPxfbO3neaKOEbsWfUiiKsCG+M3j72MpJZ0KY2FK3V5WaptJmJcYYMTYFOmx93
        +myWA4V/YysMVXWjVxMpfUjgkXKLPH53rVrBqHINBVl9SOQpZbT8ozWzWiFXqwq+l/RnT+pz
        MiVDH9rJ08qP5YeOSacUwhlVtpQhSeck/YcW81E7ilA2/iTQZFtT5M+lpfr1BX9X9QSNLToy
        O/Gt74Znant62cnj6ZoX1F+PX36Z0J13PqbrwHzzeHaeufqG1TV2dLTZ9FDv3J3y+U2j/8St
        nluHpjeX/Di6b4C6Xu9MXklL2mUvzzmi+a7wynNe+XiobuPC9MYPb5JOHBxrV4T2PvK3xaYr
        aYNGlRBL6Q2qt1umRrEzAwAA
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

