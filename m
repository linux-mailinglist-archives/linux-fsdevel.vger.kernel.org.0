Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECF5AD6B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbfIIKYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:24:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55852 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390692AbfIIKX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so13145029wmg.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3oTy+lkWbkFFfNbPOS2AOFsjB8RXGgtp9fv0BAsW7sw=;
        b=KWVXJKkgFOQhTfLznVaJozh5R/o/MAC5kqv+Qml3IcuGyQxjB7qRq685l5cBV05Ipo
         sgDx5/qcqGjKuGr9VE0lmZRjo/HjTZbkkbXFm/HX027RXGgT8qgkUTjbTsrWFaU78863
         wzESbRXN+09ou7ZrrCkHTB5+c4ETLx6aCyp21N8Pjc66pFQFBWAMgaiwDL3tp77qaRTC
         LYyBTNH8KtaVoQ83sVMzOlD8AG50aQKGghkExi80zGT8ETXPvABPF/W2N78ihbUogsQy
         WLTY1RGj/p6SaQ17it8EMedrfkaaf3HfqKRE7kznmLO5rNb9bMj7AYrYWpRKlNzPSiQM
         +LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3oTy+lkWbkFFfNbPOS2AOFsjB8RXGgtp9fv0BAsW7sw=;
        b=VqSalPB0k2rtHnp7vgstI36Ui0WZZ7GBcWidC/sdLETKT4U8MDkeUccm1ztLUfC1ss
         W3iEVKnGYq6gEuB4Rt7JPA4A4i9NRQZncvcAzUrgLeMglqOyLDblEVXxL+a73MRouQ8c
         /LaJtGZ1DknV17edhOQAVCVO/AOHMIIjk9/KSfW6B+FJTIdNIBndAGB04lbQeJG5TCsv
         ea28Tz5dOVsA2XyhkrnZnIEllTIIwhD6j5we5RYq2lEsVrxgMWbMisbeeQ/3z0CdVAHF
         rBTLpSCoufXVQEDgbWJLbMsI1A37528lXSWUxRdnWvG6Izg6IASQ2SjFjMoSyIOkBTzS
         lmgQ==
X-Gm-Message-State: APjAAAU9tvdv1Bvh2WlS/qbWkk3OQ2t5TE88VJsWeXdYhz6r/rFUmics
        zhVvVClLW1EcbdZzdKwo4JM1EQ==
X-Google-Smtp-Source: APXvYqwkEm9NakHd5yjJLZAfHiHfqUsqd4ZN6ARrN70g1pNUadQK+lUNEg6XugNBQoIbW5DPuRGGdw==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr19207427wma.120.1568024636323;
        Mon, 09 Sep 2019 03:23:56 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] restart_block: Make common timeout
Date:   Mon,  9 Sep 2019 11:23:40 +0100
Message-Id: <20190909102340.8592-10-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to provide a unified API to get the leftover of timeout,
the timeout for different users of restart_block can be joined.
All preparations done, so move timeout out of union and convert
the users.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c                    | 10 +++++-----
 include/linux/restart_block.h  |  4 +---
 kernel/futex.c                 | 14 +++++++-------
 kernel/time/alarmtimer.c       |  6 +++---
 kernel/time/hrtimer.c          |  6 +++---
 kernel/time/posix-cpu-timers.c |  6 +++---
 6 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index ff2b9c4865cd..9ab6fc6fb7c5 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1001,7 +1001,7 @@ static long do_restart_poll(struct restart_block *restart_block)
 {
 	struct pollfd __user *ufds = restart_block->poll.ufds;
 	int nfds = restart_block->poll.nfds;
-	ktime_t timeout = restart_block->poll.timeout;
+	ktime_t timeout = restart_block->timeout;
 	int ret;
 
 	ret = do_sys_poll(ufds, nfds, timeout);
@@ -1030,10 +1030,10 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		struct restart_block *restart_block;
 
 		restart_block = &current->restart_block;
-		restart_block->fn		= do_restart_poll;
-		restart_block->poll.ufds	= ufds;
-		restart_block->poll.nfds	= nfds;
-		restart_block->poll.timeout	= timeout;
+		restart_block->fn	 = do_restart_poll;
+		restart_block->poll.ufds = ufds;
+		restart_block->poll.nfds = nfds;
+		restart_block->timeout	 = timeout;
 
 		ret = -ERESTART_RESTARTBLOCK;
 	}
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 63d647b65395..02f90ab00a2d 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -27,6 +27,7 @@ enum timespec_type {
  * userspace tricks in the union.
  */
 struct restart_block {
+	s64 timeout;
 	long (*fn)(struct restart_block *);
 	union {
 		/* For futex_wait and futex_wait_requeue_pi */
@@ -35,7 +36,6 @@ struct restart_block {
 			u32 val;
 			u32 flags;
 			u32 bitset;
-			u64 time;
 		} futex;
 		/* For nanosleep */
 		struct {
@@ -45,11 +45,9 @@ struct restart_block {
 				struct __kernel_timespec __user *rmtp;
 				struct old_timespec32 __user *compat_rmtp;
 			};
-			u64 expires;
 		} nanosleep;
 		/* For poll */
 		struct {
-			u64 timeout;
 			struct pollfd __user *ufds;
 			int nfds;
 		} poll;
diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..0738167e4911 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2755,12 +2755,12 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		goto out;
 
 	restart = &current->restart_block;
-	restart->fn = futex_wait_restart;
-	restart->futex.uaddr = uaddr;
-	restart->futex.val = val;
-	restart->futex.time = *abs_time;
-	restart->futex.bitset = bitset;
-	restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
+	restart->fn		= futex_wait_restart;
+	restart->futex.uaddr	= uaddr;
+	restart->futex.val	= val;
+	restart->timeout	= *abs_time;
+	restart->futex.bitset	= bitset;
+	restart->futex.flags	= flags | FLAGS_HAS_TIMEOUT;
 
 	ret = -ERESTART_RESTARTBLOCK;
 
@@ -2779,7 +2779,7 @@ static long futex_wait_restart(struct restart_block *restart)
 	ktime_t t, *tp = NULL;
 
 	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
-		t = restart->futex.time;
+		t = restart->timeout;
 		tp = &t;
 	}
 	restart->fn = do_no_restart_syscall;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 57518efc3810..148b187c371e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -763,7 +763,7 @@ alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
 static long __sched alarm_timer_nsleep_restart(struct restart_block *restart)
 {
 	enum  alarmtimer_type type = restart->nanosleep.clockid;
-	ktime_t exp = restart->nanosleep.expires;
+	ktime_t exp = restart->timeout;
 	struct alarm alarm;
 
 	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
@@ -816,9 +816,9 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	if (flags == TIMER_ABSTIME)
 		return -ERESTARTNOHAND;
 
-	restart->fn = alarm_timer_nsleep_restart;
+	restart->fn		   = alarm_timer_nsleep_restart;
 	restart->nanosleep.clockid = type;
-	restart->nanosleep.expires = exp;
+	restart->timeout	   = exp;
 	return ret;
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4ba2b50d068f..18d4b0cc919c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1709,7 +1709,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 
 	hrtimer_init_on_stack(&t.timer, restart->nanosleep.clockid,
 				HRTIMER_MODE_ABS);
-	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
+	hrtimer_set_expires_tv64(&t.timer, restart->timeout);
 
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
@@ -1741,9 +1741,9 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	}
 
 	restart = &current->restart_block;
-	restart->fn = hrtimer_nanosleep_restart;
+	restart->fn		   = hrtimer_nanosleep_restart;
 	restart->nanosleep.clockid = t.timer.base->clockid;
-	restart->nanosleep.expires = hrtimer_get_expires_tv64(&t.timer);
+	restart->timeout	   = hrtimer_get_expires_tv64(&t.timer);
 out:
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b4dddf74dd15..691de00107c2 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1332,8 +1332,8 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		 * Report back to the user the time still remaining.
 		 */
 		restart = &current->restart_block;
-		restart->fn = posix_cpu_nsleep_restart;
-		restart->nanosleep.expires = expires;
+		restart->fn	 = posix_cpu_nsleep_restart;
+		restart->timeout = expires;
 		if (restart->nanosleep.type != TT_NONE)
 			error = nanosleep_copyout(restart, &it.it_value);
 	}
@@ -1372,7 +1372,7 @@ static long posix_cpu_nsleep_restart(struct restart_block *restart_block)
 	clockid_t which_clock = restart_block->nanosleep.clockid;
 	struct timespec64 t;
 
-	t = ns_to_timespec64(restart_block->nanosleep.expires);
+	t = ns_to_timespec64(restart_block->timeout);
 
 	return do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t);
 }
-- 
2.23.0

