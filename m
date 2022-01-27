Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0649D74F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 02:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiA0BMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 20:12:06 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:46204 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234426AbiA0BL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:11:26 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 27 Jan 2022 10:11:20 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 27 Jan 2022 10:11:20 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH on v5.17-rc1 13/14] dept: Separate out SDT(Single-event Dependency Tracker) header
Date:   Thu, 27 Jan 2022 10:11:11 +0900
Message-Id: <1643245873-15542-13-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
References: <1643245733-14513-1-git-send-email-byungchul.park@lge.com>
 <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that Dept has already been applied to major synchronization
machanisms e.g. spinlock, wait_for_completion and the like, we can take
advantage of Dept by default if CONFIG_DEPT is on.

However, sometimes we need to manually tag wait/event on places where
Dept hasn't been applied. SDT(Single-event Dependency Tracker) would be
useful in that case to tag those. The usage is like:

1. Initialize dmap in the instance associated to the wait/event.

	sdt_map_init(dmap);

2. Add the following just before the wait.

	sdt_wait(dmap);

3. Add the following just before the event.

	sdt_event(dmap);

For better reference of SDT APIs, separated the APIs from dept.h.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h     | 36 --------------------------------
 include/linux/dept_sdt.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 5a726bf..10ef7fc 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -504,32 +504,6 @@ struct dept_map_common {
  */
 extern void dept_key_init(struct dept_key *k);
 extern void dept_key_destroy(struct dept_key *k);
-
-#define DEPT_SDT_MAP_INIT(dname)	{ .name = #dname }
-#define DEFINE_DEPT_SDT(x)		\
-	struct dept_map x = DEPT_SDT_MAP_INIT(x)
-
-/*
- * SDT(Single-event Dependency Tracker) APIs
- *
- * In case that one dept_map instance maps to a single event, SDT APIs
- * can be used.
- */
-#define sdt_map_init(m)							\
-	do {								\
-		static struct dept_key __key;				\
-		dept_map_init(m, &__key, 0, #m);			\
-	} while (0)
-#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
-
-#define sdt_wait(m)							\
-	do {								\
-		dept_asked_event(m);					\
-		dept_wait(m, 1UL, _THIS_IP_, "wait", 0);		\
-	} while (0)
-#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
-#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, "event")
-#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, _THIS_IP_)
 #else /* !CONFIG_DEPT */
 struct dept_task { };
 struct dept_key  { };
@@ -563,15 +537,5 @@ struct dept_map_common {
 #define dept_asked_event_split_map(me, mc)		do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
-
-#define DEPT_SDT_MAP_INIT(dname)
-#define DEFINE_DEPT_SDT(x)
-
-#define sdt_map_init(m)					do { } while (0)
-#define sdt_map_init_key(m, k)				do { (void)(k); } while (0)
-#define sdt_wait(m)					do { } while (0)
-#define sdt_ecxt_enter(m)				do { } while (0)
-#define sdt_event(m)					do { } while (0)
-#define sdt_ecxt_exit(m)				do { } while (0)
 #endif
 #endif /* __LINUX_DEPT_H */
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 0000000..32a4a9e
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Dept Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#ifdef CONFIG_DEPT
+
+#include <linux/dept.h>
+
+#define DEPT_SDT_MAP_INIT(dname)	{ .name = #dname }
+#define DEFINE_DEPT_SDT(x)		\
+	struct dept_map x = DEPT_SDT_MAP_INIT(x)
+
+/*
+ * SDT(Single-event Dependency Tracker) APIs
+ *
+ * In case that one dept_map instance maps to a single event, SDT APIs
+ * can be used.
+ */
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_asked_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, "wait", 0);		\
+	} while (0)
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, "event")
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, _THIS_IP_)
+#else /* !CONFIG_DEPT */
+#define DEPT_SDT_MAP_INIT(dname)
+#define DEFINE_DEPT_SDT(x)
+
+#define sdt_map_init(m)					do { } while (0)
+#define sdt_map_init_key(m, k)				do { (void)(k); } while (0)
+#define sdt_wait(m)					do { } while (0)
+#define sdt_ecxt_enter(m)				do { } while (0)
+#define sdt_event(m)					do { } while (0)
+#define sdt_ecxt_exit(m)				do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
1.9.1

