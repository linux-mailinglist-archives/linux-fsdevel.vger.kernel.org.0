Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E122AA0D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgKFXR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgKFXRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:55 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83AC061A4A;
        Fri,  6 Nov 2020 15:17:53 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so2025844qtp.2;
        Fri, 06 Nov 2020 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOTmvxvmpQbjOs7fCzqpFaGlP1cxXiVyhe60vEcddRs=;
        b=U9PzMtZ8qMgubA4tawTN8osLPaaIBfSTcJDcjCPe8/AHrxeYUHRtvP913xVhr/mdkh
         u3O1C4f/y8ITPpCzkydmH27VkcudGTY9dgf/38QskeIt/Oq69/Z4iXZpEUTJHIBGZqEa
         NrXXsRAoVHNEp5mZAQkiNMpSuIDp7aeR2TapMI46qff9UKJpeeHUb/l5eQ66cP3HvBpl
         YIG1Sfn8xJ5Pbs7cCY+uZEaBYTdFBrYp0WbSNWUTa0xNXmRq8GGofOXG+T7tHgcHCFqC
         mwNL5rAMWTG8MfJ2EE1SBYLQnE5igXqtPJeRrALmeAYX+DnBD7h0qOvcxdXnybQbsZ0R
         VcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOTmvxvmpQbjOs7fCzqpFaGlP1cxXiVyhe60vEcddRs=;
        b=YynKWg4be3aYUiAYtXx/47mPzqK6J+4miBcSLsRBEA3ZlwOzi/DNSU5RC852zD1eyf
         3wJKbTQdnpX/MC+HWNA9OJAWndRh9Z1UTwuxIGBQQp7Ar2jJcwmglKBwJjgLRh3aB43P
         MuWdCLDQ/CHjR3TDmrWR5VDYnOIJX2mLqlclF/CMm55LhmPrj3ZJwrB9/U8qeCh+Br4v
         RCI7Oa7mhUN7Eo2UyBd8Lezktp78aAXr67h2I/15wOnfBMr48Iu7/EZ3ZOaj36J9Fj94
         ebhhK6UbOFjsWXkv/S3nzrd9OTB3W9u7SwNn39xT1g2RZj4dg4B4/ZdOax7Nr8jHYW7G
         yoPQ==
X-Gm-Message-State: AOAM532NmE2CF0HDP8LHcWIH7da/+FKp0rdLCfKpZ7N3l2PGk7xxF+l0
        AO0FPG8xJGHxDURG8V1+wHk=
X-Google-Smtp-Source: ABdhPJzEbkgRrEBgDJJc5LVTbXoKCH1aZnuw6tZva49R1/sbWsaowtlXwCjo5oIM0OO0AuW9Vum1uw==
X-Received: by 2002:ac8:4897:: with SMTP id i23mr3687277qtq.211.1604704673124;
        Fri, 06 Nov 2020 15:17:53 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:52 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 7/8] epoll: replace gotos with a proper loop
Date:   Fri,  6 Nov 2020 18:16:34 -0500
Message-Id: <20201106231635.3528496-8-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

The existing loop is pointless, and the labels make it really
hard to follow the structure.

Replace that control structure with a simple loop that returns
when there are new events, there is a signal, or the thread has
timed out.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b29bbebe8ca4..f4e1be7ada26 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1830,7 +1830,7 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, long timeout)
 {
-	int res, eavail, timed_out = 0;
+	int res, eavail = 0, timed_out = 0;
 	u64 slack = 0;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
@@ -1856,18 +1856,30 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		write_lock_irq(&ep->lock);
 		eavail = ep_events_available(ep);
 		write_unlock_irq(&ep->lock);
-
-		goto send_events;
 	}
 
-fetch_events:
-	do {
+	while (1) {
+		if (eavail) {
+			/*
+			 * Try to transfer events to user space. In case we get
+			 * 0 events and there's still timeout left over, we go
+			 * trying again in search of more luck.
+			 */
+			res = ep_send_events(ep, events, maxevents);
+			if (res)
+				return res;
+		}
+
+		if (timed_out)
+			return 0;
+
 		eavail = ep_events_available(ep);
-		if (!eavail)
-			eavail = ep_busy_loop(ep, timed_out);
+		if (eavail)
+			continue;
 
+		eavail = ep_busy_loop(ep, timed_out);
 		if (eavail)
-			goto send_events;
+			continue;
 
 		if (signal_pending(current))
 			return -EINTR;
@@ -1932,19 +1944,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			__remove_wait_queue(&ep->wq, &wait);
 			write_unlock_irq(&ep->lock);
 		}
-	} while (0);
-
-send_events:
-	/*
-	 * Try to transfer events to user space. In case we get 0 events and
-	 * there's still timeout left over, we go trying again in search of
-	 * more luck.
-	 */
-	if (eavail &&
-	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out)
-		goto fetch_events;
-
-	return res;
+	}
 }
 
 /**
-- 
2.29.1.341.ge80a0c044ae-goog

