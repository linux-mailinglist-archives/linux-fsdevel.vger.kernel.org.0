Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3B4C6675
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiB1J6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 04:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiB1J6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:58:24 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 926C72A73D
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 01:57:26 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 28 Feb 2022 18:57:21 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 28 Feb 2022 18:57:21 +0900
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
        hamohammed.sa@gmail.com
Subject: [PATCH v3 20/21] dept: Add nocheck version of init_completion()
Date:   Mon, 28 Feb 2022 18:56:59 +0900
Message-Id: <1646042220-28952-21-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
References: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For completions who don't want to get tracked by Dept, added
init_completion_nocheck() to disable Dept on it.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index a1ad5a8..9bd3bc9 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -30,6 +30,7 @@ struct completion {
 };
 
 #ifdef CONFIG_DEPT
+#define dept_wfc_nocheck(m)			dept_map_nocheck(m)
 #define dept_wfc_init(m, k, s, n)		dept_map_init(m, k, s, n)
 #define dept_wfc_reinit(m)			dept_map_reinit(m)
 #define dept_wfc_wait(m, ip)						\
@@ -41,6 +42,7 @@ struct completion {
 #define dept_wfc_enter(m, ip)			dept_ecxt_enter(m, 1UL, ip, "completion_context_enter", "complete", 0)
 #define dept_wfc_exit(m, ip)			dept_ecxt_exit(m, ip)
 #else
+#define dept_wfc_nocheck(m)			do { } while (0)
 #define dept_wfc_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
 #define dept_wfc_reinit(m)			do { } while (0)
 #define dept_wfc_wait(m, ip)			do { } while (0)
@@ -55,10 +57,11 @@ struct completion {
 #define WFC_DEPT_MAP_INIT(work)
 #endif
 
+#define init_completion_nocheck(x) __init_completion(x, NULL, #x, false)
 #define init_completion(x)					\
 	do {							\
 		static struct dept_key __dkey;			\
-		__init_completion(x, &__dkey, #x);		\
+		__init_completion(x, &__dkey, #x, true);	\
 	} while (0)
 
 #define init_completion_map(x, m) init_completion(x)
@@ -117,10 +120,15 @@ static inline void complete_release(struct completion *x) {}
  */
 static inline void __init_completion(struct completion *x,
 				     struct dept_key *dkey,
-				     const char *name)
+				     const char *name, bool check)
 {
 	x->done = 0;
-	dept_wfc_init(&x->dmap, dkey, 0, name);
+
+	if (check)
+		dept_wfc_init(&x->dmap, dkey, 0, name);
+	else
+		dept_wfc_nocheck(&x->dmap);
+
 	init_swait_queue_head(&x->wait);
 }
 
-- 
1.9.1

