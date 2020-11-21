Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B512BC008
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgKUOoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgKUOoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:44:07 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7DC0613CF;
        Sat, 21 Nov 2020 06:44:06 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id m2so876759qka.3;
        Sat, 21 Nov 2020 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNNiFUqbxeL6DGZQwX9ne1SFDsCxAa9b8OtwKgL8gHk=;
        b=ChD2RF8XYVbH6pPk4CMI/Af5kiX06Gz0GaCFreJACDNeeCrzy8dvNveKm2ZlEXuOIQ
         06pYNwIjT9gFDkExpC6QDUMItA6n1tXlolltx+SMc/URFI6MiTm4LWhnu4ksS7YLeXJN
         lVm0VyFNRuOAlMJWcBFIZFSKoRJGIajdzX/kykK3qlR1rk32emTl/e32a5wWMZSmP84m
         Qesvx7t6e/LIx58Zn0xyAkHPNJgzqKoMEQ6yWyJIWXA08nRU9lqtL/ZQCocPslrRz3Fh
         q1wljQXcoWkxhIXOyZTnWjGXU+up8jpZOMpkA73ulp+3P6Xh61sbjfWIwZMW5OZKgNe+
         7H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNNiFUqbxeL6DGZQwX9ne1SFDsCxAa9b8OtwKgL8gHk=;
        b=b2M8RDg/Ro2auuaCIgxQ9x1lOJPiTzch/lngsdHeIILowje+YRB//n74EKgeEicbEc
         NjPrzf3NY++UWA6BLBjTQZxgc6asg/S9yCfQk4//Rn7cfuW8C6Su3H0JCc9glE9kTJNX
         zfRM+r8b3M9oiKp0Zo7gEmyG6GZvjSOj9K8es2TIjPodljCxt38irPyELyjpzjs/LqW8
         CbyQTcl+JMNaUJBlehI8SswQi6hFDek1IEAnFXgn+nOtvtYQ4M4Z9tgWOa44H/SQo/nS
         lNkaYSBYROzWmZiTv2YSllJ+V0wcbucsWFSVRPaUwNGuW3kxMnDBKV8cHJlR4k/qIPUd
         fljg==
X-Gm-Message-State: AOAM530x9MmrAKpUVubv3bzJ4+cXKsfBxGKscgkyJcWCC0s9Nr1FqsyR
        lupvTW6CQDaAFVwJPc2+LtWq9/3XqJU=
X-Google-Smtp-Source: ABdhPJwxGRh8kyXCjjNmov38d4pACRlcWeNhF0BnCEaorb7qq7LokpVGMJEvbZv2HwCMK4f27cudfQ==
X-Received: by 2002:a37:a44e:: with SMTP id n75mr20392908qke.406.1605969844970;
        Sat, 21 Nov 2020 06:44:04 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id q15sm4055137qki.13.2020.11.21.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:44:04 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com,
        willy@infradead.org, arnd@arndb.de, shuochen@google.com,
        linux-man@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v4 1/4] epoll: convert internal api to timespec64
Date:   Sat, 21 Nov 2020 09:43:57 -0500
Message-Id: <20201121144401.3727659-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
References: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Make epoll more consistent with select/poll: pass along the timeout as
timespec64 pointer.

In anticipation of additional changes affecting all three polling
mechanisms:

- add epoll_pwait2 syscall with timespec semantics,
  and share poll_select_set_timeout implementation.
- compute slack before conversion to absolute time,
  to save one ktime_get_ts64 call.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 fs/eventpoll.c | 57 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 297aeb0ee9d1..7082dfbc3166 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1714,15 +1714,25 @@ static int ep_send_events(struct eventpoll *ep,
 	return res;
 }
 
-static inline struct timespec64 ep_set_mstimeout(long ms)
+static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 {
-	struct timespec64 now, ts = {
-		.tv_sec = ms / MSEC_PER_SEC,
-		.tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
-	};
+	struct timespec64 now;
+
+	if (ms < 0)
+		return NULL;
+
+	if (!ms) {
+		to->tv_sec = 0;
+		to->tv_nsec = 0;
+		return to;
+	}
+
+	to->tv_sec = ms / MSEC_PER_SEC;
+	to->tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC);
 
 	ktime_get_ts64(&now);
-	return timespec64_add_safe(now, ts);
+	*to = timespec64_add_safe(now, *to);
+	return to;
 }
 
 /**
@@ -1734,8 +1744,8 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
  *          stored.
  * @maxevents: Size (in terms of number of events) of the caller event buffer.
  * @timeout: Maximum timeout for the ready events fetch operation, in
- *           milliseconds. If the @timeout is zero, the function will not block,
- *           while if the @timeout is less than zero, the function will block
+ *           timespec. If the timeout is zero, the function will not block,
+ *           while if the @timeout ptr is NULL, the function will block
  *           until at least one event has been retrieved (or an error
  *           occurred).
  *
@@ -1743,7 +1753,7 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
  *          error code, in case of error.
  */
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
-		   int maxevents, long timeout)
+		   int maxevents, struct timespec64 *timeout)
 {
 	int res, eavail, timed_out = 0;
 	u64 slack = 0;
@@ -1752,13 +1762,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	lockdep_assert_irqs_enabled();
 
-	if (timeout > 0) {
-		struct timespec64 end_time = ep_set_mstimeout(timeout);
-
-		slack = select_estimate_accuracy(&end_time);
+	if (timeout && (timeout->tv_sec | timeout->tv_nsec)) {
+		slack = select_estimate_accuracy(timeout);
 		to = &expires;
-		*to = timespec64_to_ktime(end_time);
-	} else if (timeout == 0) {
+		*to = timespec64_to_ktime(*timeout);
+	} else if (timeout) {
 		/*
 		 * Avoid the unnecessary trip to the wait queue loop, if the
 		 * caller specified a non blocking operation.
@@ -2177,7 +2185,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
  * part of the user space epoll_wait(2).
  */
 static int do_epoll_wait(int epfd, struct epoll_event __user *events,
-			 int maxevents, int timeout)
+			 int maxevents, struct timespec64 *to)
 {
 	int error;
 	struct fd f;
@@ -2211,7 +2219,7 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	ep = f.file->private_data;
 
 	/* Time to fish for events ... */
-	error = ep_poll(ep, events, maxevents, timeout);
+	error = ep_poll(ep, events, maxevents, to);
 
 error_fput:
 	fdput(f);
@@ -2221,7 +2229,10 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout)
 {
-	return do_epoll_wait(epfd, events, maxevents, timeout);
+	struct timespec64 to;
+
+	return do_epoll_wait(epfd, events, maxevents,
+			     ep_timeout_to_timespec(&to, timeout));
 }
 
 /*
@@ -2232,6 +2243,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
 		size_t, sigsetsize)
 {
+	struct timespec64 to;
 	int error;
 
 	/*
@@ -2242,7 +2254,9 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 	if (error)
 		return error;
 
-	error = do_epoll_wait(epfd, events, maxevents, timeout);
+	error = do_epoll_wait(epfd, events, maxevents,
+			      ep_timeout_to_timespec(&to, timeout));
+
 	restore_saved_sigmask_unless(error == -EINTR);
 
 	return error;
@@ -2255,6 +2269,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 			const compat_sigset_t __user *, sigmask,
 			compat_size_t, sigsetsize)
 {
+	struct timespec64 to;
 	long err;
 
 	/*
@@ -2265,7 +2280,9 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 	if (err)
 		return err;
 
-	err = do_epoll_wait(epfd, events, maxevents, timeout);
+	err = do_epoll_wait(epfd, events, maxevents,
+			    ep_timeout_to_timespec(&to, timeout));
+
 	restore_saved_sigmask_unless(err == -EINTR);
 
 	return err;
-- 
2.29.2.454.gaff20da3a2-goog

