Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098062AA0D6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgKFXSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgKFXRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD1C0613D6;
        Fri,  6 Nov 2020 15:17:52 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id j31so2005413qtb.8;
        Fri, 06 Nov 2020 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOSFREc0POUXsBcyqAN5If5e3Op5s8v2XbVHIhjOP4Y=;
        b=JgqfE4j2JpxJLmj0zMJ1yzwbdykmApIOch3Xx3jw4p1oJ8+MyRvrmm4GuDvkqsO7lt
         7VmVyRlv8D/K/cIE1E4+sU3RTK3pYrLv7dc9IKSine5WpCXlLLVQL6LXxRSyFGk9kQxP
         SqfXzNUUuYJlPcF5qHqiUv48rq5vE2xph+EJN721IEfZj3jyYdiw3LX1qHu7z3FyaMAP
         FMcll8IZnZiIbYnj3nedzbXPY8K79d8nfWwntOgG9yFOTl1lejMS2B6uOSvaksCCUR/c
         cURrpjB8Pps0U3WCwAcB7BoVbU/qND6Qy6PL5fNrMpNRlGtPGfzSGBjRaHzb1TlK331b
         NPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOSFREc0POUXsBcyqAN5If5e3Op5s8v2XbVHIhjOP4Y=;
        b=J+gRGpghva7rHW2iGZY5M+wnL1EkujbG+073yHLLvBkpRi1D60OCZcRd66pQdt6LqG
         xi5bKPLlKnf6S7n5tjk3p0ikqkeTMhaIjui7Rm3vDU1XqrMxxEE/tGuqGHgoG/DfQdAx
         KVDBSMeoZFzgr7uyKX0q90TPz4g9x3iUf38co2tTCY22NFzTGj/2pDAOpH/cU7SW7MnP
         6vmvBnzmzm450/vv1A9kdNsYazzRMp+ulzGM5eZsf4P0wW6WGTMeUbgxR+nGDLPBRUyu
         dlU/4CLcTOWWyqLvakgSxEFP0BcfoOeptjTJvsJfjQHgucBmEhVMRnMntMn/fEhrdnxV
         PnVQ==
X-Gm-Message-State: AOAM532V+o0U3pjtoAvZqThj88onuWOqprk1U4tfwyp9VlWYVGEu1BSY
        RZ7mPdnHvQJNhvvS6HpScN0=
X-Google-Smtp-Source: ABdhPJzxGx8FL5Mjc33i9OrWQxJ0rNlUEGUzIEfMSVyZooARvf49FSMcVCJsrDzETAN5A7A+JM4oYg==
X-Received: by 2002:aed:31c5:: with SMTP id 63mr3768102qth.84.1604704671575;
        Fri, 06 Nov 2020 15:17:51 -0800 (PST)
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
Subject: [PATCH 5/8] epoll: simplify and optimize busy loop logic
Date:   Fri,  6 Nov 2020 18:16:32 -0500
Message-Id: <20201106231635.3528496-6-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

ep_events_available() is called multiple times around the busy loop
logic, even though the logic is generally not used.
ep_reset_busy_poll_napi_id() is similarly always called, even when
busy loop is not used.

Eliminate ep_reset_busy_poll_napi_id() and inline it inside
ep_busy_loop(). Make ep_busy_loop() return whether there are any
events available after the busy loop.  This will eliminate unnecessary
loads and branches, and simplifies the loop.

Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5226b0cb1098..28c1d341d2e6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -391,19 +391,26 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
  * busy loop will return if need_resched or ep_events_available.
  *
  * we must do our busy polling with irqs enabled
+ *
+ * Returns whether new events are available after a successful busy loop.
  */
-static void ep_busy_loop(struct eventpoll *ep, int nonblock)
+static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
-	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on())
+	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep);
-}
-
-static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
-{
-	if (ep->napi_id)
+		if (ep_events_available(ep))
+			return true;
+		/*
+		 * Busy poll timed out.  Drop NAPI ID for now, we can add
+		 * it back in when we have moved a socket with a valid NAPI
+		 * ID onto the ready list.
+		 */
 		ep->napi_id = 0;
+		return false;
+	}
+	return false;
 }
 
 /*
@@ -444,12 +451,9 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 
 #else
 
-static inline void ep_busy_loop(struct eventpoll *ep, int nonblock)
-{
-}
-
-static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
+static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
+	return false;
 }
 
 static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
@@ -1857,21 +1861,13 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	}
 
 fetch_events:
-
-	if (!ep_events_available(ep))
-		ep_busy_loop(ep, timed_out);
-
 	eavail = ep_events_available(ep);
+	if (!eavail)
+		eavail = ep_busy_loop(ep, timed_out);
+
 	if (eavail)
 		goto send_events;
 
-	/*
-	 * Busy poll timed out.  Drop NAPI ID for now, we can add
-	 * it back in when we have moved a socket with a valid NAPI
-	 * ID onto the ready list.
-	 */
-	ep_reset_busy_poll_napi_id(ep);
-
 	do {
 		if (signal_pending(current))
 			return -EINTR;
-- 
2.29.1.341.ge80a0c044ae-goog

