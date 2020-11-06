Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8935F2AA0CF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKFXRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgKFXRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:50 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF0C0613CF;
        Fri,  6 Nov 2020 15:17:49 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so1258425qvb.4;
        Fri, 06 Nov 2020 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NtkPSt3HryQm3XghUScn8RP5ZLrHE5f6ni874ipj/g=;
        b=ER8g397GJJr4epHAMeA12ADqf3nTgy9rwlRAE/caCZKTw0SBDh1Eqrt6wYXi4JFPDU
         /8tpn5V0aGV9spZIvXMrqofeNCsIk0RcpfTrfrDXZybqVM36rDhmczRO69Z7BLxbYtXu
         6SbFq8Dm3fE8ozpb291a6Y0M66/N3srAvUdt+uEGtCkWsq4cXveZ5z6DzvP+IrxvRMDf
         Ax1BfWqG9sW1fsnZ9hKGzzIUzD3d+mhvUR6tiQTLWsez5rHpfm4w30tCWtqc2ypQHgf8
         qY/6YILP/BdjzOp/XZ1KP/Vzym0IadykOMhHfm9IkO3gV6GXDuX85lt5v8ZcqsrNtI3U
         Xl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NtkPSt3HryQm3XghUScn8RP5ZLrHE5f6ni874ipj/g=;
        b=b5DEoHayoQW5iAD9KkPMaFweThVq7Y0886LrhCAg1vjztyBCbAI/7KjxWc8Gnx6v7f
         5Kmjbh6diXhIpbnOwFk05d64ht+pYwcMgprh8kpRiWt1yqeKfc7fUDoGUHm3//5sbb/G
         uHzzH963GUsf05IG/RAQ0s7ajp5H5c6eQmPTu8o4e5zdgLC1ZB28BWFqzRztxADzVyyy
         yTlY+zeQDuPFkmVAZ6oszfd+2RekZxiPRyD+DGhcTZY2K0FyltcwWKJMRnasxaRB7sjs
         435+7uzRvqVrSKsE1eBiEIJauqGOO+9umF11Yz2VAYSHcjPQzlpQID+FBNv94JTSb1I6
         zlpQ==
X-Gm-Message-State: AOAM533Fcb4DUTPmF79DVyH08al/i27BWaE4a9RynVpkwSboPjQB75sv
        7wUOM7nVqzo9BS1O4UfG1xk=
X-Google-Smtp-Source: ABdhPJy0F9moY1w/bwCG/g2cZkfdbYV9+C38Y70i8gwnBDiWqROQAC3r9xRoW89JsIFh+V2aAZ9Y8g==
X-Received: by 2002:a0c:ecc8:: with SMTP id o8mr3847589qvq.19.1604704668610;
        Fri, 06 Nov 2020 15:17:48 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:48 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 1/8] epoll: check for events when removing a timed out thread from the wait queue
Date:   Fri,  6 Nov 2020 18:16:28 -0500
Message-Id: <20201106231635.3528496-2-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

After abc610e01c66 ("fs/epoll: avoid barrier after an epoll_wait(2)
timeout"), we break out of the ep_poll loop upon timeout, without checking
whether there is any new events available.  Prior to that patch-series we
always called ep_events_available() after exiting the loop.

This can cause races and missed wakeups.  For example, consider the
following scenario reported by Guantao Liu:

Suppose we have an eventfd added using EPOLLET to an epollfd.

Thread 1: Sleeps for just below 5ms and then writes to an eventfd.
Thread 2: Calls epoll_wait with a timeout of 5 ms. If it sees an
          event of the eventfd, it will write back on that fd.
Thread 3: Calls epoll_wait with a negative timeout.

Prior to abc610e01c66, it is guaranteed that Thread 3 will wake up either
by Thread 1 or Thread 2.  After abc610e01c66, Thread 3 can be blocked
indefinitely if Thread 2 sees a timeout right before the write to the
eventfd by Thread 1.  Thread 2 will be woken up from
schedule_hrtimeout_range and, with evail 0, it will not call
ep_send_events().

To fix this issue:
1) Simplify the timed_out case as suggested by Linus.
2) while holding the lock, recheck whether the thread was woken up
   after its time out has reached.

Note that (2) is different from Linus' original suggestion: It do not
set "eavail = ep_events_available(ep)" to avoid unnecessary contention
(when there are too many timed-out threads and a small number of events),
as well as races mentioned in the discussion thread.

This is the first patch in the series so that the backport to stable
releases is straightforward.

Link: https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com
Fixes: abc610e01c66 ("fs/epoll: avoid barrier after an epoll_wait(2) timeout")
Tested-by: Guantao Liu <guantaol@google.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reported-by: Guantao Liu <guantaol@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4df61129566d..117b1c395ae4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1902,23 +1902,30 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		}
 		write_unlock_irq(&ep->lock);
 
-		if (eavail || res)
-			break;
+		if (!eavail && !res)
+			timed_out = !schedule_hrtimeout_range(to, slack,
+							      HRTIMER_MODE_ABS);
 
-		if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS)) {
-			timed_out = 1;
-			break;
-		}
-
-		/* We were woken up, thus go and try to harvest some events */
+		/*
+		 * We were woken up, thus go and try to harvest some events.
+		 * If timed out and still on the wait queue, recheck eavail
+		 * carefully under lock, below.
+		 */
 		eavail = 1;
-
 	} while (0);
 
 	__set_current_state(TASK_RUNNING);
 
 	if (!list_empty_careful(&wait.entry)) {
 		write_lock_irq(&ep->lock);
+		/*
+		 * If the thread timed out and is not on the wait queue, it
+		 * means that the thread was woken up after its timeout expired
+		 * before it could reacquire the lock. Thus, when wait.entry is
+		 * empty, it needs to harvest events.
+		 */
+		if (timed_out)
+			eavail = list_empty(&wait.entry);
 		__remove_wait_queue(&ep->wq, &wait);
 		write_unlock_irq(&ep->lock);
 	}
-- 
2.29.1.341.ge80a0c044ae-goog

