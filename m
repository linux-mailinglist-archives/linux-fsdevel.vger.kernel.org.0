Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5EC2AA0D3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgKFXR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgKFXR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:56 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F4C0613CF;
        Fri,  6 Nov 2020 15:17:54 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so1632933qtq.12;
        Fri, 06 Nov 2020 15:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ngXMQxuAhgumkyikvz2rZCM+zAxLKnIx7tkSsw/SgKA=;
        b=UexX2EnJhZuRHIEeAiADPldZoeSIkLaPZt8mWzfAPQj7JXwBp2wEWAiu6pYnGwmXSA
         2It5A3R22Pv1efGCvdKGau3qVG3DCG4jBGZkjiHTDZ9xF1cweozIRmgtLi25jLMMaeRI
         2MsH+lFcUWp6gCyOEnDfEwgISddFVfUdNLbjGQg0ByXrZSCdyyQjG1lszNXzAg3PZx8u
         +PIJgJ1Um0QOApSP4VxN4Yt4moCJ4uV/gv1kbsegVTEJS2yrEjq9ynaxiVmRE9Hc9Yhd
         TRcCk0k2hMe7hebGjd9VbZ0x5RkN9OnMm6cthhoXEsaUyrLZ/Fbu45wMUTndeVZPPXyl
         kaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngXMQxuAhgumkyikvz2rZCM+zAxLKnIx7tkSsw/SgKA=;
        b=RLzuBhuMVgvcRj7zjiQsZnohp+eoHURT5lFW+F/y0Lm4T0sSNrd0GpiCy8S5FdElcl
         G+Gl6ljv2scdu2NDCLJFYI5lccSryuKvfI2sxkVsx4ahzPZULe0/lI4+NGFv+EwO5dkv
         yAvuOBQqiVt6HyP7/ZkXlhRFLfgYVgH99U5vSb7p+3nOdo7+wA7bUzqkHCcBPVIXO/3W
         GmgznhTwU5mzBe4OZf4c2kyW78k3oW1AeyEN6lmFRrfMaxryFeU6Wub+L0r5nVe1yxJa
         E0Eaxot4mCJ5JAlC7vqHUSv7p2Q7HinaE51sXt4Q/oW2VZ5YdsHPBQ6LhNMUQk0WA3i3
         up6g==
X-Gm-Message-State: AOAM531c+LSo8X5sWmcZXoQNoJZDbOgyBy3+oAEd1rp9mUpWTBYbZKV6
        NMPkntCBtJ66qpPwKkGFF7KRW1iSK9E=
X-Google-Smtp-Source: ABdhPJws5NozzSrlgNetDzJAnOcgLr4wFEq258CTkeG0QZ7xV3qoQSbh9IH+v109SBJ23U66BYJOpg==
X-Received: by 2002:aed:3ba6:: with SMTP id r35mr3907750qte.269.1604704674064;
        Fri, 06 Nov 2020 15:17:54 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:53 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 8/8] epoll: eliminate unnecessary lock for zero timeout
Date:   Fri,  6 Nov 2020 18:16:35 -0500
Message-Id: <20201106231635.3528496-9-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

We call ep_events_available() under lock when timeout is 0,
and then call it without locks in the loop for the other cases.

Instead, call ep_events_available() without lock for all cases.
For non-zero timeouts, we will recheck after adding the thread to
the wait queue. For zero timeout cases, by definition, user is
opportunistically polling and will have to call epoll_wait again
in the future.

Note that this lock was kept in c5a282e9635e9 because the whole
loop was historically under lock.

This patch results in a 1% CPU/RPC reduction in RPC benchmarks.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f4e1be7ada26..1aa23b0be72b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1830,7 +1830,7 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, long timeout)
 {
-	int res, eavail = 0, timed_out = 0;
+	int res, eavail, timed_out = 0;
 	u64 slack = 0;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
@@ -1846,18 +1846,21 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	} else if (timeout == 0) {
 		/*
 		 * Avoid the unnecessary trip to the wait queue loop, if the
-		 * caller specified a non blocking operation. We still need
-		 * lock because we could race and not see an epi being added
-		 * to the ready list while in irq callback. Thus incorrectly
-		 * returning 0 back to userspace.
+		 * caller specified a non blocking operation.
 		 */
 		timed_out = 1;
-
-		write_lock_irq(&ep->lock);
-		eavail = ep_events_available(ep);
-		write_unlock_irq(&ep->lock);
 	}
 
+	/*
+	 * This call is racy: We may or may not see events that are being added
+	 * to the ready list under the lock (e.g., in IRQ callbacks). For, cases
+	 * with a non-zero timeout, this thread will check the ready list under
+	 * lock and will added to the wait queue.  For, cases with a zero
+	 * timeout, the user by definition should not care and will have to
+	 * recheck again.
+	 */
+	eavail = ep_events_available(ep);
+
 	while (1) {
 		if (eavail) {
 			/*
@@ -1873,10 +1876,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		if (timed_out)
 			return 0;
 
-		eavail = ep_events_available(ep);
-		if (eavail)
-			continue;
-
 		eavail = ep_busy_loop(ep, timed_out);
 		if (eavail)
 			continue;
-- 
2.29.1.341.ge80a0c044ae-goog

