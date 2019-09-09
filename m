Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA8AD6B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbfIIKX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:23:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50352 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390548AbfIIKXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so13188530wmc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b96u2DZEmN+6gC1egZA7UNHltszHG2vFMnr/ogVBH54=;
        b=DtU4lyMQhHwYVonGt7Yv5uvfdIscs6YoQ3ePua1nQ369s7idHb74TmeY4LLq8tTUoa
         YwqpJtwSXQIRTw9hCyL7LKKcMj7NxFnQzRtg6sBswQQuY1Agwsf7KTIjs2rK3amt8bVQ
         gXghtAAfetLzaL7jJGHR12sst2D9XvDTt0yqS4ubKamuocD8FEP2mGTmygkR466fduA4
         th7EJO+7oL22XpuutN4/zN+JOixNa8VUDIiZGDiN6SshhI+9CUN+rRS44HA459UJCq4V
         VhP4hEb3hLlCXHexrUzbnbfBsUyERMUwQEO1XmzK3VL6+qMiXRcaONnxP9Jj9lma8Psx
         mQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b96u2DZEmN+6gC1egZA7UNHltszHG2vFMnr/ogVBH54=;
        b=g2VrlzJ1eTTaXW7k0YfNbdKAzyQRNbvChBLyzM17ChaAXBXoAJMS+Qm+fwVRZq/JPS
         kjP2aX7QaJSqNaj/eIjtiCT1tIssx8YDJe1LS1u7JW+uzMY8rn38pNH894YkuORKvoWd
         W5UJR98ErcUO9jJ5cG0IKeporFVnTrY4TYqZuboLxu0ZRcNtQy5EJ/urvfqdVZUNv8Gn
         XfjtFUYs1MviJLfi55KvgLdfCc3MJV93c7dDM8kfojFJs0KOF81YGfkV6ofHOOJBmb2r
         8knS8qhquOoa4dafoLzVZxF+YMLvVsV2ZInGCpl2os0UgSvdoEOYc4WxjL5zlw34nrMN
         Zhcw==
X-Gm-Message-State: APjAAAU31Mo5eZfdVthFh0nyiG+kKPtp3duEIHl+yigdj7ej+BCFkOAH
        MlTmxomdzEbCOUng4C9UkOJpFA==
X-Google-Smtp-Source: APXvYqwY+peEV0qNHvT12MvBJHBW1QbIn5NYjERIgrYxQ5I61p7PI7+Sb3g9dDm4YmLNnuuWbNR2gg==
X-Received: by 2002:a1c:cb07:: with SMTP id b7mr19044419wmg.41.1568024630617;
        Mon, 09 Sep 2019 03:23:50 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:50 -0700 (PDT)
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
Subject: [PATCH 5/9] select: Convert select_estimate_accuracy() to take ktime_t
Date:   Mon,  9 Sep 2019 11:23:36 +0100
Message-Id: <20190909102340.8592-6-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of converting the time on the first loop, the same
if (end_time) can be shared. Simplify the loop by taking time
conversion out.

Also prepare the ground for converting poll() restart_block timeout into
ktime_t - that's the only user that leaves it in timespec.
The conversion is needed to introduce an API for ptrace() to get
a timeout from restart_block.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/eventpoll.c       |  4 ++--
 fs/select.c          | 38 ++++++++++++--------------------------
 include/linux/poll.h |  2 +-
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d7f1f5011fac..d5120fc49a39 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1836,9 +1836,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	if (timeout > 0) {
 		struct timespec64 end_time = ep_set_mstimeout(timeout);
 
-		slack = select_estimate_accuracy(&end_time);
+		expires = timespec64_to_ktime(end_time);
 		to = &expires;
-		*to = timespec64_to_ktime(end_time);
+		slack = select_estimate_accuracy(expires);
 	} else if (timeout == 0) {
 		/*
 		 * Avoid the unnecessary trip to the wait queue loop, if the
diff --git a/fs/select.c b/fs/select.c
index 2477c202631e..458f2a944318 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -66,7 +66,7 @@ static long __estimate_accuracy(ktime_t slack)
 	return slack;
 }
 
-u64 select_estimate_accuracy(struct timespec64 *timeout)
+u64 select_estimate_accuracy(ktime_t timeout)
 {
 	ktime_t now, slack;
 
@@ -77,7 +77,7 @@ u64 select_estimate_accuracy(struct timespec64 *timeout)
 		return 0;
 
 	now = ktime_get();
-	slack = now - timespec64_to_ktime(*timeout);
+	slack = now - timeout;
 
 	slack = __estimate_accuracy(slack);
 	if (slack < current->timer_slack_ns)
@@ -490,8 +490,11 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 		timed_out = 1;
 	}
 
-	if (end_time && !timed_out)
-		slack = select_estimate_accuracy(end_time);
+	if (end_time && !timed_out) {
+		expire = timespec64_to_ktime(*end_time);
+		to = &expire;
+		slack = select_estimate_accuracy(expire);
+	}
 
 	retval = 0;
 	for (;;) {
@@ -582,16 +585,6 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 		}
 		busy_flag = 0;
 
-		/*
-		 * If this is the first loop and we have a timeout
-		 * given, then we convert to ktime_t and set the to
-		 * pointer to the expiry value.
-		 */
-		if (end_time && !to) {
-			expire = timespec64_to_ktime(*end_time);
-			to = &expire;
-		}
-
 		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
 					   to, slack))
 			timed_out = 1;
@@ -876,8 +869,11 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 		timed_out = 1;
 	}
 
-	if (end_time && !timed_out)
-		slack = select_estimate_accuracy(end_time);
+	if (end_time && !timed_out) {
+		expire = timespec64_to_ktime(*end_time);
+		to = &expire;
+		slack = select_estimate_accuracy(expire);
+	}
 
 	for (;;) {
 		struct poll_list *walk;
@@ -930,16 +926,6 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 		}
 		busy_flag = 0;
 
-		/*
-		 * If this is the first loop and we have a timeout
-		 * given, then we convert to ktime_t and set the to
-		 * pointer to the expiry value.
-		 */
-		if (end_time && !to) {
-			expire = timespec64_to_ktime(*end_time);
-			to = &expire;
-		}
-
 		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
 			timed_out = 1;
 	}
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 1cdc32b1f1b0..d0f21eb19257 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -112,7 +112,7 @@ struct poll_wqueues {
 
 extern void poll_initwait(struct poll_wqueues *pwq);
 extern void poll_freewait(struct poll_wqueues *pwq);
-extern u64 select_estimate_accuracy(struct timespec64 *tv);
+extern u64 select_estimate_accuracy(ktime_t timeout);
 
 #define MAX_INT64_SECONDS (((s64)(~((u64)0)>>1)/HZ)-1)
 
-- 
2.23.0

