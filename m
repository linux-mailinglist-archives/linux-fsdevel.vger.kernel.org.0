Return-Path: <linux-fsdevel+bounces-67651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE243C45AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27A418914C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE6301477;
	Mon, 10 Nov 2025 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N19wyuih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3prbPczX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81EA3009F5;
	Mon, 10 Nov 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767541; cv=none; b=Bz/EZnof1Efeaz/ZReXhSZSS7sLr5Y3ry5q59f8btcPvufJWEe4kQ5qiTqzi9ha01w0XPbCdsXDbD2FFgm7bnlKXGy7Jn5H5MYkn3Q/PHhRpUTI/P4MEj8mZzRGachmuYWb5VP7XSNUEIPU2aTeB58uNmiXQsimksxFRuXhrSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767541; c=relaxed/simple;
	bh=Z7vd8CeGFdm/VB/9K1E3bADy3YcngSckDUMHi3AJFSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtxgdbiHLuj20qQDJSDQjSJEjjI9edIlyY2aB2yDKRY5LucnvihRDkGP5aRTSJMkALPdba3BXncu4ghcJc2wBBDvxlQYpHPVSbx0LieQoBB5NvozKwhuNMds+6d5g0i8u+TfwyMwlWTkHPa/2F4jljzrlWmL28MUUViviNUuIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N19wyuih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3prbPczX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762767538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkRdkj79k9FYq5BLiI92p7/ZGuBv94lRr/Umjv2MFBY=;
	b=N19wyuihCAUoO+bttQewCDnEJSKXBjMjnH2h1k6Fhfttdvltu8XgdV9Qoz/R9h1bg9cnkO
	5dfz1IbSipmStO21U+SAt1c4smNbHJKcAluAHzS6SE/6BRHP8BSL3/4hiURtxReXuCBcep
	pMDd6wnG0U2/le7wr49VeksW9HwnNjveJlSSIkiHqxaKVSz+Y4C5Wr+te6rRkQy1EA4/tA
	ZXfJrkJaSYVGjpNIqH4Scsf/Ock6oZdPqZ7Vf3JH8wfvZv75FTfYPDwGNoPaCGCT/lbWFs
	KwSVdIjSZ13whah+Nc2XMheTt6nEfHmm9bGPUgL4zQLJlflUyOgDMlsZS4vNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762767538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkRdkj79k9FYq5BLiI92p7/ZGuBv94lRr/Umjv2MFBY=;
	b=3prbPczX5kba5ob082own+tQWaOrpxX1jk2JRA1Z7bDRltliJ/fiI3l45OelD8MlLdPl+c
	pknzbxJAt8RvEXBQ==
Date: Mon, 10 Nov 2025 10:38:53 +0100
Subject: [PATCH 3/3] hrtimer: Store time as ktime_t in restart block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-restart-block-expiration-v1-3-5d39cc93df4f@linutronix.de>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
In-Reply-To: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762767533; l=3047;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Z7vd8CeGFdm/VB/9K1E3bADy3YcngSckDUMHi3AJFSs=;
 b=smNlYvv9OtwROE5ka2hUsuluSoCFORhPENKDjqLxzL4ahRKe4roHsoscnPxBNRYDLKVMMlzXV
 fGYbuJONGtFDab6K955aRDrzOqVxji0hUsTj9gTLKrrI3If4aw/Z2vO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The hrtimer core uses ktime_t to represent times, use that also for the
restart block. CPU timers internally use nanoseconds instead of ktime_t
but use the same restart block, so use the correct accessors for those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/restart_block.h  | 2 +-
 kernel/time/hrtimer.c          | 4 ++--
 kernel/time/posix-cpu-timers.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 3c2bd13f609120a8a914f6e738ffea97bf72c32d..9b262109726d25ca1d7871d916280a7bf336355a 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -44,7 +44,7 @@ struct restart_block {
 				struct __kernel_timespec __user *rmtp;
 				struct old_timespec32 __user *compat_rmtp;
 			};
-			u64 expires;
+			ktime_t expires;
 		} nanosleep;
 		/* For poll */
 		struct {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 88aa062b8a556db071dad74d34ba5953c3e57339..f8ea8c8fc89529889ab3a4d0a9acaec872856c85 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2145,7 +2145,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	int ret;
 
 	hrtimer_setup_sleeper_on_stack(&t, restart->nanosleep.clockid, HRTIMER_MODE_ABS);
-	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
+	hrtimer_set_expires(&t.timer, restart->nanosleep.expires);
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
@@ -2172,7 +2172,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 
 	restart = &current->restart_block;
 	restart->nanosleep.clockid = t.timer.base->clockid;
-	restart->nanosleep.expires = hrtimer_get_expires_tv64(&t.timer);
+	restart->nanosleep.expires = hrtimer_get_expires(&t.timer);
 	set_restart_fn(restart, hrtimer_nanosleep_restart);
 out:
 	destroy_hrtimer_on_stack(&t.timer);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2e5b89d7d8660585460490557021dfbf7799740d..0de2bb7cbec01c423fc98e78c5a0aeb5c910381d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1557,7 +1557,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		 * Report back to the user the time still remaining.
 		 */
 		restart = &current->restart_block;
-		restart->nanosleep.expires = expires;
+		restart->nanosleep.expires = ns_to_ktime(expires);
 		if (restart->nanosleep.type != TT_NONE)
 			error = nanosleep_copyout(restart, &it.it_value);
 	}
@@ -1599,7 +1599,7 @@ static long posix_cpu_nsleep_restart(struct restart_block *restart_block)
 	clockid_t which_clock = restart_block->nanosleep.clockid;
 	struct timespec64 t;
 
-	t = ns_to_timespec64(restart_block->nanosleep.expires);
+	t = ktime_to_timespec64(restart_block->nanosleep.expires);
 
 	return do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t);
 }

-- 
2.51.0


