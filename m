Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A28661DA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 05:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjAIEGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 23:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjAIEEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:04:30 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 561C411835
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 20:03:54 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 9 Jan 2023 12:33:54 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 9 Jan 2023 12:33:54 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Subject: [PATCH RFC v7 18/23] dept: Apply timeout consideration to wait_for_completion()/complete()
Date:   Mon,  9 Jan 2023 12:33:46 +0900
Message-Id: <1673235231-30302-19-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 0408f6d..57a715f 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -11,6 +11,7 @@
 
 #include <linux/swait.h>
 #include <linux/dept_sdt.h>
+#include <linux/sched.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -153,7 +154,10 @@ extern long raw_wait_for_completion_killable_timeout(
 #define wait_for_completion_timeout(x, t)			\
 ({								\
 	unsigned long __ret;					\
-	sdt_might_sleep_strong(NULL);				\
+	if ((t) == MAX_SCHEDULE_TIMEOUT)			\
+		sdt_might_sleep_strong(NULL);			\
+	else							\
+		sdt_might_sleep_strong_timeout(NULL);		\
 	__ret = raw_wait_for_completion_timeout(x, t);		\
 	sdt_might_sleep_finish();				\
 	__ret;							\
@@ -161,7 +165,10 @@ extern long raw_wait_for_completion_killable_timeout(
 #define wait_for_completion_io_timeout(x, t)			\
 ({								\
 	unsigned long __ret;					\
-	sdt_might_sleep_strong(NULL);				\
+	if ((t) == MAX_SCHEDULE_TIMEOUT)			\
+		sdt_might_sleep_strong(NULL);			\
+	else							\
+		sdt_might_sleep_strong_timeout(NULL);		\
 	__ret = raw_wait_for_completion_io_timeout(x, t);	\
 	sdt_might_sleep_finish();				\
 	__ret;							\
@@ -169,7 +176,10 @@ extern long raw_wait_for_completion_killable_timeout(
 #define wait_for_completion_interruptible_timeout(x, t)		\
 ({								\
 	long __ret;						\
-	sdt_might_sleep_strong(NULL);				\
+	if ((t) == MAX_SCHEDULE_TIMEOUT)			\
+		sdt_might_sleep_strong(NULL);			\
+	else							\
+		sdt_might_sleep_strong_timeout(NULL);		\
 	__ret = raw_wait_for_completion_interruptible_timeout(x, t);\
 	sdt_might_sleep_finish();				\
 	__ret;							\
@@ -177,7 +187,10 @@ extern long raw_wait_for_completion_killable_timeout(
 #define wait_for_completion_killable_timeout(x, t)		\
 ({								\
 	long __ret;						\
-	sdt_might_sleep_strong(NULL);				\
+	if ((t) == MAX_SCHEDULE_TIMEOUT)			\
+		sdt_might_sleep_strong(NULL);			\
+	else							\
+		sdt_might_sleep_strong_timeout(NULL);		\
 	__ret = raw_wait_for_completion_killable_timeout(x, t);	\
 	sdt_might_sleep_finish();				\
 	__ret;							\
-- 
1.9.1

