Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB57CAD6AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390636AbfIIKXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:23:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54305 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390548AbfIIKXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so1582559wmp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IA0pHM62rBt/shfTkMZDw95CUns+TQYkKXXhJayt/9U=;
        b=U0XMlxSQHq3X/3eDTFp9gMAg0RdWOTmIkI/8SejEwVjgRQkVN+mKfrmUO+6NK/B19i
         J69SZuDgx6wSWiNJhyc+jxxJEjQODQtB3ii8qA590akliD2WOFuq8riSf4PUfQ1u9Wf7
         HS8bUT+5T+5sgYfQjU/Nu0NUXkiPluWQZmVPxBfmlLGgEQGKoDx+XP8/rpRjdOoUQAXx
         RUAUlmzy+KiDwBC3+RmSfExy8zDPCh320PC2BcR3iO0d+DSrkCR+Oc9s8IjP0SRHFW/b
         Ivu2JW+UQMoQ2lhqXigxazO1duoF/4UIYCn4Oz8AuedOqrEd4r2+vw/AQajRaKAGjjrM
         KOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IA0pHM62rBt/shfTkMZDw95CUns+TQYkKXXhJayt/9U=;
        b=l7UAQXbHKmWCRNMfYw5C5awh1QjX4z5t7gkGJiu8f+zkYNBjqxvZNzk7Vyq+XFX35k
         W4JhleAupghxzWVIqPgrznTHq4+d6vJsciBAApHAjU8NDsKh7JwGygXSWeeVcyU/fuHM
         hZuZ0cqqn6D8iS9mYqhM0/wZyOvYbiq0J+461fh1K75CFu2ydFd36eAIB0NCnclf6Rdi
         DXFxG7JVMxWLf/i35UWyrLZms/aSVnMJ3UQSw2OCIpeUsa5yRbnIpvEh1zQzdsuFvABr
         NWndhY/rWBFMRNmPFNwpu5WK/P4UvhTUcuzrtKaCkGXnybX+2ZBp6Ak4sSPfF6Setku0
         Zp1A==
X-Gm-Message-State: APjAAAWCX5pAuo3t8D5cXti4wxpmMu3ls1QO7kDYRcRlCeqZcmGLZhtf
        qYAPn/w8jRZhqrTVsQoVlhTIcA==
X-Google-Smtp-Source: APXvYqxO92spFZfDerxwHiQLtm1hbtX83culFxinsCcT06VZq/PB8u2x8luUXD3yumaETBFthgzPsg==
X-Received: by 2002:a1c:a558:: with SMTP id o85mr18092823wme.30.1568024626269;
        Mon, 09 Sep 2019 03:23:46 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:45 -0700 (PDT)
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
Subject: [PATCH 2/9] restart_block: Prevent userspace set part of the block
Date:   Mon,  9 Sep 2019 11:23:33 +0100
Message-Id: <20190909102340.8592-3-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parameters for nanosleep() could be chosen the way to make
hrtimer_nanosleep() fail. In that case changes to restarter_block bring
it into inconsistent state. Luckily, it won't corrupt anything critical
for poll() or futex(). But as it's not evident that userspace may do
tricks in the union changing restart_block for other @fs(s) - than
further changes in the code may create a potential local vulnerability.

I.e., if userspace could do tricks with poll() or futex() than
corruption to @clockid or @type would trigger BUG() in timer code.

Set @fn every time restart_block is changed, preventing surprises.
Also, add a comment for any new restart_block user.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/restart_block.h  | 4 ++++
 kernel/time/hrtimer.c          | 8 +++++---
 kernel/time/posix-cpu-timers.c | 6 +++---
 kernel/time/posix-stubs.c      | 8 +++++---
 kernel/time/posix-timers.c     | 8 +++++---
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index e5078cae5567..e66e982105f4 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -21,6 +21,10 @@ enum timespec_type {
 
 /*
  * System call restart block.
+ *
+ * Safety rule: if you change anything inside @restart_block,
+ * set @fn to keep the structure in consistent state and prevent
+ * userspace tricks in the union.
  */
 struct restart_block {
 	long (*fn)(struct restart_block *);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5ee77f1a8a92..4ba2b50d068f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1762,8 +1762,9 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 	if (!timespec64_valid(&tu))
 		return -EINVAL;
 
-	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
-	current->restart_block.nanosleep.rmtp = rmtp;
+	current->restart_block.fn		= do_no_restart_syscall;
+	current->restart_block.nanosleep.type	= rmtp ? TT_NATIVE : TT_NONE;
+	current->restart_block.nanosleep.rmtp	= rmtp;
 	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
@@ -1782,7 +1783,8 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 	if (!timespec64_valid(&tu))
 		return -EINVAL;
 
-	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
+	current->restart_block.fn		= do_no_restart_syscall;
+	current->restart_block.nanosleep.type	= rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
 	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a426f4e3125..b4dddf74dd15 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1243,6 +1243,8 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
 
+static long posix_cpu_nsleep_restart(struct restart_block *restart_block);
+
 static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 			    const struct timespec64 *rqtp)
 {
@@ -1330,6 +1332,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		 * Report back to the user the time still remaining.
 		 */
 		restart = &current->restart_block;
+		restart->fn = posix_cpu_nsleep_restart;
 		restart->nanosleep.expires = expires;
 		if (restart->nanosleep.type != TT_NONE)
 			error = nanosleep_copyout(restart, &it.it_value);
@@ -1338,8 +1341,6 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 	return error;
 }
 
-static long posix_cpu_nsleep_restart(struct restart_block *restart_block);
-
 static int posix_cpu_nsleep(const clockid_t which_clock, int flags,
 			    const struct timespec64 *rqtp)
 {
@@ -1361,7 +1362,6 @@ static int posix_cpu_nsleep(const clockid_t which_clock, int flags,
 		if (flags & TIMER_ABSTIME)
 			return -ERESTARTNOHAND;
 
-		restart_block->fn = posix_cpu_nsleep_restart;
 		restart_block->nanosleep.clockid = which_clock;
 	}
 	return error;
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..d73039a9ca8f 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -142,8 +142,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
-	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
-	current->restart_block.nanosleep.rmtp = rmtp;
+	current->restart_block.fn		= do_no_restart_syscall;
+	current->restart_block.nanosleep.type	= rmtp ? TT_NATIVE : TT_NONE;
+	current->restart_block.nanosleep.rmtp	= rmtp;
 	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
@@ -228,7 +229,8 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
-	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
+	current->restart_block.fn		= do_no_restart_syscall;
+	current->restart_block.nanosleep.type	= rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
 	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d7f2d91acdac..0ca0bfc20aff 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1189,8 +1189,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
-	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
-	current->restart_block.nanosleep.rmtp = rmtp;
+	current->restart_block.fn		= do_no_restart_syscall;
+	current->restart_block.nanosleep.type	= rmtp ? TT_NATIVE : TT_NONE;
+	current->restart_block.nanosleep.rmtp	= rmtp;
 
 	return kc->nsleep(which_clock, flags, &t);
 }
@@ -1216,7 +1217,8 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
-	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
+	current->restart_block.fn		= do_no_restart_syscall;
+	current->restart_block.nanosleep.type	= rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
 
 	return kc->nsleep(which_clock, flags, &t);
-- 
2.23.0

