Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807542AA0D7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgKFXSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgKFXRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:54 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF70C0617A7;
        Fri,  6 Nov 2020 15:17:53 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j31so2005439qtb.8;
        Fri, 06 Nov 2020 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zMkTSpothskT4xefhKBsGTGEZ2rYTh/ZE5qcHm9T8k=;
        b=kE9eYc8O86zWBxgPy5SobzbDGX5il6e8ZYHqiuzBwPkR+VE8JyYrAohIH/GUAj9/Mg
         Fa7+hMvHDOIWk+br7/JmFHW27RnnBwCjW+9dZmVdsPndUMT7eiPwAr9T6aEl3sjJLFuw
         D6873brIDGvJ0XuWpDMiK4LjFGj/c/BgQ+22FPTLn/pS4kJvHqNTSgN7X7oG9WBHVeGf
         st7B7LFlEZ7lwIPo2ERLOweh06C6vIIIPVuuJkyjGTksz1iTF1L8j0JeWsNDq4pKRdEY
         xZJ22WW4Ql+RtKhslcKGFhBpW3li9m34VA3x1/bu/VLUyReCtc3Ul2ty8p0LgKRuQ/y/
         sGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zMkTSpothskT4xefhKBsGTGEZ2rYTh/ZE5qcHm9T8k=;
        b=AHZ3czv7mOjemDpqISrvy7NeNrZaqI3GCL7WbEhKkBwAip618KfugDjBDsZH8AuDZC
         lrqtAQ1Xo2arqs+fPVEslnxe82xGUkdPjqLo/Q300flQxDrImXbeLqFjaBWYT1aIdjeS
         kv1129mqpcG8ppa3iElcgTxuGTNrUaCaoR8c4MyG+K9gSw1BsA0u95EKl4coI5qQ9Axe
         X6r2xYm1xI7IDXPvGFiGaY2LDS43gLtPlIiebXfkvitLUoTYWPHcYMx1WnaAFOGoL2SJ
         97krR8mSwcPLO6jrk66juh+Wu4aFatpmPI7wIxWlwudRANFuUPH35gooxSTDu40hKQ8P
         bQ5Q==
X-Gm-Message-State: AOAM532N07GEDmGGq+DWe2ewLGHrxRgQS9uPVnQuWh2z3bf/nwhUQRxP
        ZhvbGX2OoHp8KzE/Cg2cemc=
X-Google-Smtp-Source: ABdhPJzMIvL1n5gCX0+jwWGXiX3sFbv6kcvcqQmI+eygJb8IC6vRVrH4oYSHW210phUXbAp/pJ46KA==
X-Received: by 2002:ac8:43ca:: with SMTP id w10mr3145639qtn.154.1604704672495;
        Fri, 06 Nov 2020 15:17:52 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:51 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 6/8] epoll: pull all code between fetch_events and send_event into the loop
Date:   Fri,  6 Nov 2020 18:16:33 -0500
Message-Id: <20201106231635.3528496-7-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

This is a no-op change which simplifies the follow up patches.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 28c1d341d2e6..b29bbebe8ca4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1861,14 +1861,14 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	}
 
 fetch_events:
-	eavail = ep_events_available(ep);
-	if (!eavail)
-		eavail = ep_busy_loop(ep, timed_out);
+	do {
+		eavail = ep_events_available(ep);
+		if (!eavail)
+			eavail = ep_busy_loop(ep, timed_out);
 
-	if (eavail)
-		goto send_events;
+		if (eavail)
+			goto send_events;
 
-	do {
 		if (signal_pending(current))
 			return -EINTR;
 
@@ -1917,21 +1917,22 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * carefully under lock, below.
 		 */
 		eavail = 1;
-	} while (0);
 
-	if (!list_empty_careful(&wait.entry)) {
-		write_lock_irq(&ep->lock);
-		/*
-		 * If the thread timed out and is not on the wait queue, it
-		 * means that the thread was woken up after its timeout expired
-		 * before it could reacquire the lock. Thus, when wait.entry is
-		 * empty, it needs to harvest events.
-		 */
-		if (timed_out)
-			eavail = list_empty(&wait.entry);
-		__remove_wait_queue(&ep->wq, &wait);
-		write_unlock_irq(&ep->lock);
-	}
+		if (!list_empty_careful(&wait.entry)) {
+			write_lock_irq(&ep->lock);
+			/*
+			 * If the thread timed out and is not on the wait queue,
+			 * it means that the thread was woken up after its
+			 * timeout expired before it could reacquire the lock.
+			 * Thus, when wait.entry is empty, it needs to harvest
+			 * events.
+			 */
+			if (timed_out)
+				eavail = list_empty(&wait.entry);
+			__remove_wait_queue(&ep->wq, &wait);
+			write_unlock_irq(&ep->lock);
+		}
+	} while (0);
 
 send_events:
 	/*
-- 
2.29.1.341.ge80a0c044ae-goog

