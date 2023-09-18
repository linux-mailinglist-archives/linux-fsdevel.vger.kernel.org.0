Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6257A4028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 06:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbjIREtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 00:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbjIREtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:49:35 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443D12D;
        Sun, 17 Sep 2023 21:49:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 939606015E;
        Mon, 18 Sep 2023 06:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695012560; bh=F/BMLDEayJFvrEb777veIWDYiWEXyubU7F/o8rvVZSY=;
        h=From:To:Cc:Subject:Date:From;
        b=BAvG8HHE/HngnzOfSv0X/KlenJbgZgM9QkXUAwZH5gNNkQflJokqlAw0fSP7jRoSw
         rgCjNSiaF1klJ6Eia+0MMti/OU5td+7DRYSK3bZiWOtBdqZY6oLo6kCuBUYMuF8Qsc
         q1s6Qqlz8F9dYSHbzaRe+MGwUA7LNN16WqhUfRMUKMARGWT4xIjSSov1JFaBC6qO0o
         GKi566ys9I/yrZSTwFAtSiKfpYu2Syl61GJ1JceXtFCIkAWdIVTq9eqkUpFXndmxPC
         fcsPaL634cYkXSjoXL2NVuDA+1TnaYbbnG8dNLsf5FDxLygowJ7OpRplpoAbQ0Pj9W
         NgMAGk8iat9OQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SaN-Jvvn3b1b; Mon, 18 Sep 2023 06:49:18 +0200 (CEST)
Received: from defiant.home (78-1-184-14.adsl.net.t-com.hr [78.1.184.14])
        by domac.alu.hr (Postfix) with ESMTPSA id D268860155;
        Mon, 18 Sep 2023 06:49:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695012558; bh=F/BMLDEayJFvrEb777veIWDYiWEXyubU7F/o8rvVZSY=;
        h=From:To:Cc:Subject:Date:From;
        b=2KlRj1nHXInXy8QCrSD6Gvru6VkMgNubtMI3yoySr0nVvYsho/HqZS+c9J2yGsKYh
         rOSfG6qbSfKwkAFUzX5EXJXQ2qUph4W8jBZCFsbD0XnpB7TW1V1NbWCSOmVQ5hwb4M
         lsRxLLrFC3d6sn1dKk0UWoNAR991lWZPWV0b/l2Op4fQ2O/KXg2y1nVjtpY22J2G3v
         2BvlgObK3iHvzFaAlqqZrkQkKuO+LvRbvqp23KXKJypvUpxvXE69xZ/zT79yWT9e3I
         dN/BWh+89q6a2xHGch8Ol6EF60ouz9rmlZoZV03YftHJmkTnpNv0R4i2josqtGExQc
         4EwBfp+TP/VGQ==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <htejun@gmail.com>
Subject: [PATCH v1 1/1] poll: fix the data race in the use of pwq->triggered in poll_schedule_timeout()
Date:   Mon, 18 Sep 2023 06:48:38 +0200
Message-Id: <20230918044837.29859-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KCSAN had discovered the following data-race:

[  139.315774] ==================================================================
[  139.315798] BUG: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake

[  139.315830] write to 0xffffc90003f3fb60 of 4 bytes by task 1848 on cpu 6:
[  139.315843]  pollwake+0xc0/0x110
[  139.315860]  __wake_up_common+0x7a/0x150
[  139.315877]  __wake_up_common_lock+0x7f/0xd0
[  139.315893]  __wake_up_sync_key+0x20/0x50
[  139.315905]  sock_def_readable+0x67/0x160
[  139.315917]  unix_stream_sendmsg+0x35f/0x990
[  139.315932]  sock_sendmsg+0x15d/0x170
[  139.315947]  ____sys_sendmsg+0x3d5/0x500
[  139.315962]  ___sys_sendmsg+0x9e/0x100
[  139.315976]  __sys_sendmsg+0x6f/0x100
[  139.315990]  __x64_sys_sendmsg+0x47/0x60
[  139.316005]  do_syscall_64+0x5d/0xa0
[  139.316022]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

[  139.316043] read to 0xffffc90003f3fb60 of 4 bytes by task 1877 on cpu 18:
[  139.316055]  poll_schedule_timeout.constprop.0+0x4e/0xc0
[  139.316071]  do_sys_poll+0x50d/0x760
[  139.316081]  __x64_sys_poll+0x5f/0x210
[  139.316091]  do_syscall_64+0x5d/0xa0
[  139.316105]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

[  139.316125] value changed: 0x00000000 -> 0x00000001

[  139.316143] Reported by Kernel Concurrency Sanitizer on:
[  139.316153] CPU: 18 PID: 1877 Comm: gdbus Tainted: G             L     6.6.0-rc1-kcsan-00269-ge789286468a9-dirty #3
[  139.316167] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  139.316177] ==================================================================

The data race appears to be here in poll_schedule_timeout():

fs/select.c:
  237 static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
  238                           ktime_t *expires, unsigned long slack)
  239 {
  240         int rc = -EINTR;
  241
  242         set_current_state(state);
→ 243         if (!pwq->triggered)
  244                 rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
  245         __set_current_state(TASK_RUNNING);
  246
  247         /*
  248          * Prepare for the next iteration.
  249          *
  250          * The following smp_store_mb() serves two purposes.  First, it's
  251          * the counterpart rmb of the wmb in pollwake() such that data
  252          * written before wake up is always visible after wake up.
  253          * Second, the full barrier guarantees that triggered clearing
  254          * doesn't pass event check of the next iteration.  Note that
  255          * this problem doesn't exist for the first iteration as
  256          * add_wait_queue() has full barrier semantics.
  257          */
  258         smp_store_mb(pwq->triggered, 0);
  259
  260         return rc;
  261 }

The problem seems to be fixed by using READ_ONCE() around pwq->triggered, which
silences the KCSAN warning:

→       if (!READ_ONCE(pwq->triggered))
                rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);

This is a quick fix that removes the symptom, but probably more isses need to be
observed around the use of pwq->triggered.

Having the value of pwq->triggered changed under one's fingers obviously has the
effect of the wrong branch in the "if" statement and wrong schedule_hrtimeout_range()
invocation.

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Fixes: 5f820f648c92a ("poll: allow f_op->poll to sleep")
Cc: Tejun Heo <htejun@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v1:
 the proposed fix (RFC)

 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..38e12084daf1 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -240,7 +240,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 	int rc = -EINTR;
 
 	set_current_state(state);
-	if (!pwq->triggered)
+	if (!READ_ONCE(pwq->triggered))
 		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.34.1

