Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5F7A3B91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbjIQUTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjIQUTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:19:41 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3ECF1;
        Sun, 17 Sep 2023 13:19:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 412E360157;
        Sun, 17 Sep 2023 22:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694981960; bh=8v9qPr5HGGnBG/0kpdufIwG1xFEuGlb2Ahrbt5XQf+s=;
        h=Date:To:Cc:From:Subject:From;
        b=m6tdgRiT4sAx2C+AAduPbhNc7VzQRh0FTVKvjjSD3cc6pH7U8TmCt9OUWk2MRX4+f
         Y0BbQFo3STi746nuY6pAzdIzHXmf2s/kFSDkegnqD1HNdLxbdYZ5v9UywfIjiVuX+r
         J6xjM/MChePe9r4eY84B6e1mRjyK8yREeN45NxgVywSeKGr13XKZZJJuIys+/Hg4K+
         8ZAbS99c/mqIPidyure+UWAyOn5C6ESd2QxdEGDnNlXbk+P1bDK67kJxNajhrt5NKb
         MbIYDF89hIC+z/g2A+gB04zrWxlsvu+qywTnH6vTXKc6aYdh1QFdlldZ3Npah16AMT
         CACtr0CwyoKgg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rTEe40IVj_R9; Sun, 17 Sep 2023 22:19:17 +0200 (CEST)
Received: from [192.168.1.6] (78-2-88-58.adsl.net.t-com.hr [78.2.88.58])
        by domac.alu.hr (Postfix) with ESMTPSA id 0BBF160155;
        Sun, 17 Sep 2023 22:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694981957; bh=8v9qPr5HGGnBG/0kpdufIwG1xFEuGlb2Ahrbt5XQf+s=;
        h=Date:To:Cc:From:Subject:From;
        b=fudaO/FrJu8l6O4fOKE6VZ1ywcB4MaxuW0JuXEm6PTPAsmGwIV6xZiO4MwJB1m7rO
         hqF/RUwX02FmuSPc3L23V8ndO22X4NHkZsSGIbPib2I6KzCSz8/eZ+x88PCWePLmYl
         yzzKLSPuYLPbP6nJ8ZmlwrGq8AlRnXFASGTK1akIlQ7IBH4xDY+W9WFGpcTEFunAQV
         xDCx5hOE2K9alBk7yRAUvdXr7yVBCxvbezLvcadgCy2vPRK0llvaSzs230KYHiQIp9
         eaJv6Q2KGyChP+UnA+KMqghf3OhTgwK8I5tLRB1qwgfXw7RiCJY8U5rmuhtuL+KiwJ
         u2w6MWTSQFK8Q==
Message-ID: <1b84f2a0-97d9-3d81-0c7a-e8b5b3dc3a02@alu.unizg.hr>
Date:   Sun, 17 Sep 2023 22:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

The setup is Linux 6.6.0-rc1-kcsan-00269-ge789286468a9-dirty x86_64 ("dirty" is from the applied patch,
but we'll come to that below) on an Ubuntu 22.04 LTS system.

OK, so the KCSAN stacktrace is:

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

The problematic code seems to be:

   185 static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
   186 {
   187         struct poll_wqueues *pwq = wait->private;
   188         DECLARE_WAITQUEUE(dummy_wait, pwq->polling_task);
   189
   190         /*
   191          * Although this function is called under waitqueue lock, LOCK
   192          * doesn't imply write barrier and the users expect write
   193          * barrier semantics on wakeup functions.  The following
   194          * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
   195          * and is paired with smp_store_mb() in poll_schedule_timeout.
   196          */
   197         smp_wmb();
   198         pwq->triggered = 1;
   199
   200         /*
   201          * Perform the default wake up operation using a dummy
   202          * waitqueue.
   203          *
   204          * TODO: This is hacky but there currently is no interface to
   205          * pass in @sync.  @sync is scheduled to be removed and once
   206          * that happens, wake_up_process() can be used directly.
   207          */
→ 208         return default_wake_function(&dummy_wait, mode, sync, key);
   209 }
   210
   211 static int pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
   212 {
   213         struct poll_table_entry *entry;
   214
   215         entry = container_of(wait, struct poll_table_entry, wait);
   216         if (key && !(key_to_poll(key) & entry->key))
   217                 return 0;
→ 218         return __pollwake(wait, mode, sync, key);
   219 }
   220
   .
   .
   .
   236
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

This quick and dirty fix had removed the KCSAN warnings which were about +100 in the test run:

You will probably have the clearer big picture, as this fix only removes the symptom.

I should probably do some homework before submitting a formal patch.

Best regards,
Mirsad Todorovac

-----------------------------------------------------------------------------------
  fs/select.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..38e12084daf1 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -240,7 +240,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
         int rc = -EINTR;
  
         set_current_state(state);
-       if (!pwq->triggered)
+       if (!READ_ONCE(pwq->triggered))
                 rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
         __set_current_state(TASK_RUNNING);
  
