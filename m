Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165D782247
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjHUEHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjHUEG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:06:59 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FC7E9B;
        Sun, 20 Aug 2023 21:06:57 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-5b-64e2ded5f456
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
Subject: [RESEND PATCH v10 07/25] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date:   Mon, 21 Aug 2023 12:46:19 +0900
Message-Id: <20230821034637.34630-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH9zz33udeKiXXTrOrzIlNyBaX4UvUHI0xEkn2fHEhWbZkGsVq
        70Y3KFgExcxRpL6BGGqCdYJLgVkrdAoXljC0roPxNiNWraww7EaHTgaIUIsi+FLY/HLyy/mf
        8/v0FxhNE7dQMBj3yCajLk1LVKxqJLrigzuBoH758Ng7YD2+HMKPj7JQfslFwHuxBoGrIR/D
        YOuH8PvEMIKp6zcYsJV6EVT032WgoS2AwO08SOD2QAz4wqMEOkuLCBRUXSJwc2gaQ9+pkxhq
        lM1wraQSg2fyHxZsgwTKbAU4Mh5gmHRU8+Awx0PQeYaH6f4V0Bno5sDd+z58+10fgSvuThba
        GoMYbjeVEwi4XnJwra2DBa+1mIMfHlYSGJpwMOAIj/Jwy2PHUGuJiA6HXnDQXuzBcPj7Ogy+
        nssIrh79C4Pi6ibQEh7GUK+UMvDsfCuC4IkRHg4dn+ShLP8EgqJDp1i48bydA0vfaph6Wk42
        rqMtw6MMtdTvpe4JO0t/q5ToT2fu8tRytZendiWb1juX0qorg5hWjIc5qlQfI1QZP8nTwhEf
        pg+7unjacXqKpQM+G06O3aJar5fTDDmyadmGHarUIfcIn/nz3H1nvb/yZtQQU4iiBElcJbVe
        /JN5zaF/W/gZJuK7kt8/ObufJ8ZJ9cX3uUKkEhjxyBzJ+eg6mQneFDOknnPmWWbFeOlHqzXC
        gqAWV0vWkv+di6WaWs8sR4lrJOVyE5phTeRkrP9vdsYpiUeipO77Lva/hwXSL04/W4LUdvRG
        NdIYjDnpOkPaqoTUXKNhX8KujHQFRRrlODC9tRGNez9uRqKAtNHqHW8H9RpOl5OVm96MJIHR
        zlPHPunXa9R6Xe5+2ZSRYspOk7OaUazAat9Sr5zYq9eIX+j2yF/JcqZsep1iIWqhGeHEpGN1
        d8Y/s3+SmR3dsT55bE7oc0sDF3fQX/2e3zcYetCYuJvEPdrSHv/1hYSiMlNez72COmtV9pOu
        NYGe4v1LhpTTnjzLRzn3UmIyzYtDO41/2EJJC17Oz6df+gvDLYnfPDe+2N2bcrM9edei2hDJ
        W9ZXUvTpxqRN67Yt2T7Qunalls1K1a1YypiydK8AMADUhk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa1BMcRgGcP//ubYsx2o4IzNYg5FxGzKvcZnGlw4zjBkfXGe0Y49atja7
        iWUiukhsWiZLbUmxVkWclnFb1kbJpZYSkWhdU1tuGymXjfHlnd/M88zz6WUJhZUazmpi40V9
        rEqrpGWkbPHs5EmPmr3qqfsdDJj3TQX/13QSrGWlNHjOlCAodezE0HorAh53tSPouV9LgCXb
        g+BYy3MCHJXNCJz2XTTUvR4I9f5OGqqz99KQXFRGw4O2XgxNhw5gKJEWwd2sQgyu7nckWFpp
        yLUk48B5j6HbVsyALWkseO05DPS2TIPq5gYKKvKqKXA+nQhH8ptouOqsJqHyohdD3WUrDc2l
        vym4W3mbBI/ZRMHpjkIa2rpsBNj8nQw8dBVgOJsSWEv78ouCKpMLQ9rxcxjqG68guJb+EoNU
        2kBDhb8dQ7mUTcCPk7cQeDN9DKTu62Ygd2cmgr2ph0io/VlFQUpTGPR8t9Lhs4WK9k5CSCnf
        LDi7CkjhTiEvXMp5zggp154yQoG0SSi3hwpFV1uxcOyznxKk4j20IH0+wAgZvnosdNTUMMLt
        wz2k8LregpeMWCmboxa1mgRRP2VepCy6zelj4q4P3pLnuckkIcfADBTE8twM/suHCqbPNDee
        f/Kkm+hzMDeKLze9pTKQjCW43f15+8f7dF8whNPxjSeS/prkxvLnzeaAWVbOhfHmLOLf5ki+
        5Kzrr4O4mbx05TLqsyJQ+dTyisxCsgLUrxgFa2ITYlQabdhkw4ZoY6xmy+S1uhgJBX7Glthr
        voi+1kW4Ecci5QB55AivWkGpEgzGGDfiWUIZLA/51qJWyNUq41ZRr1uj36QVDW4UwpLKYfKF
        y8RIBRelihc3iGKcqP+fYjZoeBKaH56o+0B5l6403Sua8OKVlP8i5JRnvex4pnX1Nps7XDYs
        rqN3QXbNiinPojY3rtG7+sdsz5i5pBg7jPPT8XLL0B2+Ew0RiXNTfW+1Z1aV4dwFYzaOvrAi
        9ODckzeiRrfdyNftqXq4blBD4puj0zWzhvCD08YdzslsrXXHm2bZjasmHFWShmjVtFBCb1D9
        AXJoOr8vAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

