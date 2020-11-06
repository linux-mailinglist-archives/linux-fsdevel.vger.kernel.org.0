Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536E72AA0DC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgKFXSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgKFXRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:52 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC8C0613D2;
        Fri,  6 Nov 2020 15:17:50 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so2005363qtb.8;
        Fri, 06 Nov 2020 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5hM/1XH5XvHZuZiSwPhICBUd5JhPMgu+Z0ZMA4flOI=;
        b=At3nFnTIYsXNwPEkTl3meLeIk581q8AIkEPUc3D8f/LK+btAgbSnTFkVG0BGLMV5Oa
         sLhFJC86XyEopJ9sk0+kIPCgfIljTma6CRrNxg08fhQ1dX1Mv+rgheM2z426MTYmq+fw
         LiLboyqc6V0FYLHe8XbZQdyQ/MOaxwlarqKzmyv+NAB7E8+AzFJu6g5gYdjfY7ZWG3YH
         DPzhl7t0BNaA3P1yyfm9HLYXnpncl/T/70sDqHP92B0BBE59EvnayYKROrYKOpMXpE8I
         nM7BMevq+dGObcQVBwlMxo6WaB75PZwmcPnOIWcKpu6oJR/+GcRJGftFQub2CrRsWiVW
         wy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5hM/1XH5XvHZuZiSwPhICBUd5JhPMgu+Z0ZMA4flOI=;
        b=m/cCLPDOL4cngLIiTIdqzo3FAJ6thzN7kYQ7Pi/drLtaEZjOxTNlV4fp9f6UDSn4E7
         /e4o2J1pf/P7XPSVz8ld/wSq3YmgIEOTxCtrPJzyLY5raaMAZ2hGszHEH58S6lc1xcwD
         WTr0+FEMeut29i8F8crfkkL4Wddt5gMnvdGo2n/ON+BmCwHuF4ODa1YZw3DC9NzoUrVJ
         AtxEkcS4guTyjg1oIrWeNs+FwSEIcWBQn+3P/hTGWAAbZQt1ApKGh6dMcA9i65IPb77E
         KllZziwMGw3SOLO0echVcxzfKSUXJAuWfwOnkg8YmWE4Y8boruBHaT1gJz4BfGi5jt49
         kxXg==
X-Gm-Message-State: AOAM533YdQCUj3A/tYbTxBbbciFKhWaTfg+SO+SioTtOIr4YZrM89mjm
        IMp0eg8eeCg7tN9AZiwOslg=
X-Google-Smtp-Source: ABdhPJxb2W1+iapjcMgS4qk+lBO+LlHf6WeoaT80foR/JXxYT4J+FDsKKkukhUUPCPlU265tgrHRFQ==
X-Received: by 2002:ac8:5191:: with SMTP id c17mr4018077qtn.116.1604704669322;
        Fri, 06 Nov 2020 15:17:49 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:49 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 2/8] epoll: simplify signal handling
Date:   Fri,  6 Nov 2020 18:16:29 -0500
Message-Id: <20201106231635.3528496-3-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

Check signals before locking ep->lock, and immediately return
-EINTR if there is any signal pending.

This saves a few loads, stores, and branches from the hot path
and simplifies the loop structure for follow up patches.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 117b1c395ae4..80c560dad6a3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1818,7 +1818,7 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, long timeout)
 {
-	int res = 0, eavail, timed_out = 0;
+	int res, eavail, timed_out = 0;
 	u64 slack = 0;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
@@ -1865,6 +1865,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	ep_reset_busy_poll_napi_id(ep);
 
 	do {
+		if (signal_pending(current))
+			return -EINTR;
+
 		/*
 		 * Internally init_wait() uses autoremove_wake_function(),
 		 * thus wait entry is removed from the wait queue on each
@@ -1894,15 +1897,12 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * important.
 		 */
 		eavail = ep_events_available(ep);
-		if (!eavail) {
-			if (signal_pending(current))
-				res = -EINTR;
-			else
-				__add_wait_queue_exclusive(&ep->wq, &wait);
-		}
+		if (!eavail)
+			__add_wait_queue_exclusive(&ep->wq, &wait);
+
 		write_unlock_irq(&ep->lock);
 
-		if (!eavail && !res)
+		if (!eavail)
 			timed_out = !schedule_hrtimeout_range(to, slack,
 							      HRTIMER_MODE_ABS);
 
@@ -1938,14 +1938,14 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * finding more events available and fetching
 		 * repeatedly.
 		 */
-		res = -EINTR;
+		return -EINTR;
 	}
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
 	 * there's still timeout left over, we go trying again in search of
 	 * more luck.
 	 */
-	if (!res && eavail &&
+	if (eavail &&
 	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out)
 		goto fetch_events;
 
-- 
2.29.1.341.ge80a0c044ae-goog

