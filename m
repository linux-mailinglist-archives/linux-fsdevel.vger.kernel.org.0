Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27A123820
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 21:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLQU71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 15:59:27 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:46576 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfLQU71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:59:27 -0500
Received: by mail-wr1-f74.google.com with SMTP id l20so5885519wrc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=drhjbWi362ZPL2jymMGntSOHybVCzJNeZtCFMfpFyxs=;
        b=Y+ELDO3KGSRorAJkeLAJTZ67TdFDt0M7KESM+sDUkGVOvXjYps0m8RDflG80Bcr7Na
         RKEdq4eYe0D5oOxOWUDkglm1J2jQg9WJ6d8b9XDvWYUnIyV1CV33SQdSEzoPfXczO8CD
         2Y2z3FHXQi6+zujtoiUPjny9jLMztYcy3ERpVibPWzrIImov2AJ0WA9fWF6h3+MkuvmQ
         /4mhNvIEJ5/sA80AsqoOvvcwYFb1XtiwOcS45OMRIu237pWElOXb3q6p/y0xRfPAaVx/
         kPqWj+V5EkvaX5GCtPYAunVGFOoB85M4hoJkNTl26knt6FZsjSjFr/FfNLlc4iL44cMZ
         Bdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=drhjbWi362ZPL2jymMGntSOHybVCzJNeZtCFMfpFyxs=;
        b=uRUV1S4RGdEQpFFvANjp2bP9nQ+tXAG3acEc46zzQvIatC1sreZhrjabDi27pqI8Er
         44KlYMfJZn423VDS9ZfRmY4v4KwitWHo4ZtaoLNDa216KSKvUTvBZc6rSS1i7QOj708f
         4450mgM7ry0/7ixtIFZ4woYllyvhhfi7juzkCHU3vWs7TJqYDT0ty8CUev4UnKv/RHDQ
         TOl1Lrqr7DH44gzlLo8caroA78ACpY3vIMdRcU/yyJOhn9VIb7xhqPV1esjyKBQExpDE
         qunU2KqfXrJw3WvnSdfKgFraH53J8O/r6YAnE02hb01jgtVgLe1W9nkXg29weORTFHd9
         aYmg==
X-Gm-Message-State: APjAAAUT6vDnIADppAYqmKRrpJVcpNWl2Z+xmCtGg+tMDK1h4mPz7uOd
        1DNzVr9aqB0q7woCzBVpfIssP2rXJw==
X-Google-Smtp-Source: APXvYqxdIyn5yj4Gg5oz56LVq9Ope/jAFLIew4nktYBg5gdxWTy6T6csKnnBLxDG/s3suhkMZuO9qd4Q6g==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr38303761wra.124.1576616364426;
 Tue, 17 Dec 2019 12:59:24 -0800 (PST)
Date:   Tue, 17 Dec 2019 21:59:05 +0100
In-Reply-To: <00000000000031cefb0599ec600b@google.com>
Message-Id: <20191217205905.205682-1-elver@google.com>
Mime-Version: 1.0
References: <00000000000031cefb0599ec600b@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] fs/select: Fix data races to pwq->triggered
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        syzbot+bd0076c6e839503096b5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix data races to pwq->triggered by using READ_ONCE. These accesses are
expected to race per comment and already provided memory barriers
surrounding the accesses.

Original KCSAN report:

write to 0xffffc90001043c30 of 4 bytes by task 17695 on cpu 0:
 __pollwake fs/select.c:197 [inline]
 pollwake+0xe3/0x140 fs/select.c:217
 __wake_up_common+0x7b/0x180 kernel/sched/wait.c:93
 __wake_up_common_lock+0x77/0xb0 kernel/sched/wait.c:123
 __wake_up+0xe/0x10 kernel/sched/wait.c:142
 signalfd_notify include/linux/signalfd.h:22 [inline]
 signalfd_notify include/linux/signalfd.h:19 [inline]
 __send_signal+0x70e/0x870 kernel/signal.c:1158
 send_signal+0x224/0x2b0 kernel/signal.c:1236
 __group_send_sig_info kernel/signal.c:1275 [inline]
 do_notify_parent+0x55b/0x5e0 kernel/signal.c:1992
 exit_notify kernel/exit.c:670 [inline]
 do_exit+0x16ef/0x18c0 kernel/exit.c:818
 do_group_exit+0xb4/0x1c0 kernel/exit.c:895
 __do_sys_exit_group kernel/exit.c:906 [inline]
 __se_sys_exit_group kernel/exit.c:904 [inline]
 __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:904
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffc90001043c30 of 4 bytes by task 15995 on cpu 1:
 poll_schedule_timeout.constprop.0+0x50/0xc0 fs/select.c:242
 do_poll fs/select.c:951 [inline]
 do_sys_poll+0x66d/0x990 fs/select.c:1001
 __do_sys_poll fs/select.c:1059 [inline]
 __se_sys_poll fs/select.c:1047 [inline]
 __x64_sys_poll+0x10f/0x250 fs/select.c:1047
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported-by: syzbot+bd0076c6e839503096b5@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 11d0285d46b7..152987ddf40e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -194,7 +194,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 	 * and is paired with smp_store_mb() in poll_schedule_timeout.
 	 */
 	smp_wmb();
-	pwq->triggered = 1;
+	WRITE_ONCE(pwq->triggered, 1);
 
 	/*
 	 * Perform the default wake up operation using a dummy
@@ -239,7 +239,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 	int rc = -EINTR;
 
 	set_current_state(state);
-	if (!pwq->triggered)
+	if (!READ_ONCE(pwq->triggered))
 		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.24.1.735.g03f4e72817-goog

