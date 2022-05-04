Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDF519AAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiEDIy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346854AbiEDIxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:51 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B931025E82
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:49:26 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 4 May 2022 17:19:22 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 4 May 2022 17:19:22 +0900
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
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: [PATCH RFC v6 21/21] dept: Unstage wait when tagging a normal sleep wait
Date:   Wed,  4 May 2022 17:17:49 +0900
Message-Id: <1651652269-15342-22-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Staging a wait and commit have been introduced to handle conditional
sleeps that can be determined in __schedule() whether it actually goes
to sleep or not. With this feature, actual wait tagging is delayed
until __schedule().

Unfortunately, an ambiguity arises when a normal sleep wait that doesn't
require staging and commit, is involved in the middle of handling a
conditional sleep e.g. between prepare_to_wait_*() and __schedule(),
which is a very rare case tho.

So let it give up handling the conditional sleep by unstaging it
unconditionally when a normal sleep wait gets involved, to avoid the
ambiguity.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/dependency/dept.c | 55 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 14dc33b..ce6d5b3 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2166,6 +2166,21 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 	}
 }
 
+static inline void stage_map(struct dept_task *dt, struct dept_map *m)
+{
+	dt->stage_m = m;
+}
+
+static inline void unstage_map(struct dept_task *dt)
+{
+	dt->stage_m = NULL;
+}
+
+static inline struct dept_map *staged_map(struct dept_task *dt)
+{
+	return dt->stage_m;
+}
+
 void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
 	       const char *w_fn, int ne, bool sleep)
 {
@@ -2183,27 +2198,24 @@ void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
 
 	flags = dept_enter();
 
+	/*
+	 * There's no way to distinguish between a staged wait and this
+	 * one, in the middle of handling a wait that requires staging
+	 * and commit in __schedule().
+	 *
+	 * The wait that has been tagged dept_wait() with sleep == true
+	 * should ignore the staged wait in __schedule() if it exists,
+	 * to avoid the ambiguity. It can be done by unstaging it.
+	 */
+	if (sleep)
+		unstage_map(dt);
+
 	__dept_wait(m, w_f, ip, w_fn, ne, sleep);
 
 	dept_exit(flags);
 }
 EXPORT_SYMBOL_GPL(dept_wait);
 
-static inline void stage_map(struct dept_task *dt, struct dept_map *m)
-{
-	dt->stage_m = m;
-}
-
-static inline void unstage_map(struct dept_task *dt)
-{
-	dt->stage_m = NULL;
-}
-
-static inline struct dept_map *staged_map(struct dept_task *dt)
-{
-	return dt->stage_m;
-}
-
 void dept_stage_wait(struct dept_map *m, unsigned long w_f,
 		     const char *w_fn, int ne)
 {
@@ -2565,6 +2577,19 @@ void dept_wait_split_map(struct dept_map_each *me,
 
 	flags = dept_enter();
 
+	/*
+	 * There's no way to distinguish between a staged wait and this
+	 * one, in the middle of handling a wait that requires staging
+	 * and commit in __schedule().
+	 *
+	 * The wait that has been tagged dept_wait_split_map() with
+	 * sleep == true should ignore the staged wait in __schedule()
+	 * if it exists, to avoid the ambiguity. It can be done by
+	 * unstaging it.
+	 */
+	if (sleep)
+		unstage_map(dt);
+
 	k = mc->keys ?: &mc->keys_local;
 	c = check_new_class(&mc->keys_local, k, 0, 0UL, mc->name);
 	if (c)
-- 
1.9.1

