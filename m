Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A64DA833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351419AbiCPC3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353162AbiCPC2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:28:36 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EACB5EBFE
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:27:15 -0700 (PDT)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 16 Mar 2022 11:27:12 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 16 Mar 2022 11:27:12 +0900
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
Subject: [PATCH RFC v5 21/21] dept: Don't create dependencies between different depths in any case
Date:   Wed, 16 Mar 2022 11:26:33 +0900
Message-Id: <1647397593-16747-22-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
References: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dept already prevents creating dependencies between different depths of
the class indicated by *_lock_nested() when the lock acquisitions happen
consecutively. For example:

   lock A0 with depth
   lock_nested A1 with depth + 1

   ...

   unlock A1
   unlock A0

Dept does not create A0 -> A1 dependency in this case. However, once
another class cut in, the code becomes problematic. When Dept tries to
create real dependencies, it does not only create real ones but also
wrong ones between different depths of the class. For example:

   lock A0 with depth
   lock B
   lock_nested A1 with depth + 1

   ...

   unlock A1
   unlock B
   unlock A0

Even in this case, Dept should not create A0 -> A1 dependency but it
does. Let Dept not create wrong dependencies between different depths
of the class in any case.

Reported-by: 42.hyeyoo@gmail.com
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/dependency/dept.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 10801783..a2088685 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1458,14 +1458,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 
 		eh = dt->ecxt_held + i;
 		if (eh->ecxt->class != c || eh->nest == ne)
-			break;
-	}
-
-	for (; i >= 0; i--) {
-		struct dept_ecxt_held *eh;
-
-		eh = dt->ecxt_held + i;
-		add_dep(eh->ecxt, w);
+			add_dep(eh->ecxt, w);
 	}
 
 	if (!wait_consumed(w) && !rich_stack) {
-- 
1.9.1

