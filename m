Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61704BC7FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 12:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiBSK7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:59:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242034AbiBSK7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:59:04 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E183D69298
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:58:42 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 19 Feb 2022 19:58:41 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 19:58:41 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
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
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH v2 04/18] dept: Add a API for skipping dependency check temporarily
Date:   Sat, 19 Feb 2022 19:58:17 +0900
Message-Id: <1645268311-24222-5-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
References: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dept would skip check for dmaps marked by dept_map_nocheck() permanently.
However, sometimes it needs to skip check for some dmaps temporarily and
back to normal, for instance, lock acquisition with a nest lock.

Lock usage check with regard to nest lock could be performed by Lockdep,
however, dependency check is not necessary for that case. So prepared
for it by adding two new APIs, dept_skip() and dept_unskip_if_skipped().

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h     |  9 +++++++++
 include/linux/dept_sdt.h |  2 +-
 include/linux/lockdep.h  |  4 +++-
 kernel/dependency/dept.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index c3fb3cf..c0bbb8e 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -352,6 +352,11 @@ struct dept_map {
 	unsigned int			wgen;
 
 	/*
+	 * for skipping dependency check temporarily
+	 */
+	atomic_t			skip_cnt;
+
+	/*
 	 * whether this map should be going to be checked or not
 	 */
 	bool				nocheck;
@@ -444,6 +449,8 @@ struct dept_task {
 extern void dept_ask_event(struct dept_map *m);
 extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long ip);
+extern void dept_skip(struct dept_map *m);
+extern bool dept_unskip_if_skipped(struct dept_map *m);
 
 /*
  * for users who want to manage external keys
@@ -475,6 +482,8 @@ struct dept_task {
 #define dept_ask_event(m)			do { } while (0)
 #define dept_event(m, e_f, ip, e_fn)		do { (void)(e_fn); } while (0)
 #define dept_ecxt_exit(m, ip)			do { } while (0)
+#define dept_skip(m)				do { } while (0)
+#define dept_unskip_if_skipped(m)		(false)
 #define dept_key_init(k)			do { (void)(k); } while (0)
 #define dept_key_destroy(k)			do { (void)(k); } while (0)
 #endif
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 375c4c3..e9d558d 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -13,7 +13,7 @@
 #include <linux/dept.h>
 
 #ifdef CONFIG_DEPT
-#define DEPT_SDT_MAP_INIT(dname)	{ .name = #dname }
+#define DEPT_SDT_MAP_INIT(dname)	{ .name = #dname, .skip_cnt = ATOMIC_INIT(0) }
 
 /*
  * SDT(Single-event Dependency Tracker) APIs
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c56f6b6..c1a56fe 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -488,7 +488,9 @@ enum xhlock_context_t {
  */
 #define STATIC_DEPT_MAP_INIT(_name, _key) .dmap = {		\
 	.name = (_name),					\
-	.keys = NULL },
+	.keys = NULL,						\
+	.skip_cnt = ATOMIC_INIT(0),				\
+	},
 #else
 #define STATIC_DEPT_MAP_INIT(_name, _key)
 #endif
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 8e0effd..69d91ca 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1943,6 +1943,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub,
 	m->name = n;
 	m->wgen = 0U;
 	m->nocheck = false;
+	atomic_set(&m->skip_cnt, 0);
 exit:
 	dept_exit(flags);
 }
@@ -1961,6 +1962,7 @@ void dept_map_reinit(struct dept_map *m)
 	clean_classes_cache(&m->keys_local);
 	m->wgen = 0U;
 	m->nocheck = false;
+	atomic_set(&m->skip_cnt, 0);
 
 	dept_exit(flags);
 }
@@ -2344,6 +2346,53 @@ void dept_ecxt_exit(struct dept_map *m, unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(dept_ecxt_exit);
 
+void dept_skip(struct dept_map *m)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (m->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	atomic_inc(&m->skip_cnt);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_skip);
+
+/*
+ * Return true if successfully unskip, otherwise false.
+ */
+bool dept_unskip_if_skipped(struct dept_map *m)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	bool ret = false;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return false;
+
+	if (m->nocheck)
+		return false;
+
+	flags = dept_enter();
+
+	if (!atomic_read(&m->skip_cnt))
+		goto exit;
+
+	atomic_dec(&m->skip_cnt);
+	ret = true;
+exit:
+	dept_exit(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dept_unskip_if_skipped);
+
 void dept_task_exit(struct task_struct *t)
 {
 	struct dept_task *dt = &t->dept_task;
-- 
1.9.1

