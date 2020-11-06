Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2712AA0CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgKFXRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgKFXRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:51 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7BC0613D3;
        Fri,  6 Nov 2020 15:17:51 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id r8so2007875qtp.13;
        Fri, 06 Nov 2020 15:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1ilj57B28AycSlcMqSc+BHzcumL+p/zmD4cBPaCkao=;
        b=AznM+dy4BJNFfqz+PAlzqHHpO6Wuq5mCEvnk6y2QNqYhv6KZtW5ux61uaJcKbJ64lH
         P0M43uFsyircu/AZa+NWDZk6GVSDnKhqYlq1wi6ok+khhMV5aHKuU3ksu3iA/cNZLUep
         hY0EilBGBgNOxWJaiYCiLa6kYCEXSFCY2HnA6SUkn0ZSF0+BYTxNJ85EuCqZLh4godo6
         1zFjgSQV++PsS1WjdZnxGSmQEhhPE+L4tOApAJKGl3FkckIOPDNwUFdGsjkBibScFLkh
         NwoOTGei4+5dJc/qyAcGtfMVx0lqwPjX8LJAwoVKeJVWmAmD+VESzRMqi1p8/zOxhc5U
         lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1ilj57B28AycSlcMqSc+BHzcumL+p/zmD4cBPaCkao=;
        b=H2m8ZbnRuLctiAXYojP1MfzCFPL+ojjZ0cPlvi5qIxMWDpW4P+uMQOjeywQTewFJLV
         cYMrDhCxhzb9Y0E4sf0+/FV8+T4RPCsWp9/ZS2M2tjW0/Nl0OGDaKJbs4CXktzgz0unc
         YniYxFDLCnyVTdl2I83RRL+7fwConx+WhsZC/Ohy2699jPL4ObSyF/sXx7R5zTcggVfR
         QBN+JWZYAcqSNzgHy5KNixR1kkjjGfGxsc4ADsqS+q0r00a2KQRepKiz7Ew7+MecOk3l
         P6FrXrY59QBWkW1DwWDLDfpKx+uFBEZVdDf7h+lO4MyAkyegOtE7qsq2I1K8djzAcHRS
         2/3Q==
X-Gm-Message-State: AOAM531/mQE9/T86LpofCToJn1sEb+z3ZWI8dzu2K94dgU+0gALmsiWO
        hQ6dyvt28z6Nxb2hnobe2ec=
X-Google-Smtp-Source: ABdhPJyapMMEKClAaA5UuC0rq9zDRf3BtSz4Q0EAxoAXnPc29hofhm48hNyFBKAp6jr2cxHwglPDeA==
X-Received: by 2002:ac8:5816:: with SMTP id g22mr3697520qtg.316.1604704670377;
        Fri, 06 Nov 2020 15:17:50 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:49 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 3/8] epoll: pull fatal signal checks into ep_send_events()
Date:   Fri,  6 Nov 2020 18:16:30 -0500
Message-Id: <20201106231635.3528496-4-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

To simplify the code, pull in checking the fatal signals into
ep_send_events().  ep_send_events() is called only from ep_poll().

Note that, previously, we were always checking fatal events, but
it is checked only if eavail is true.  This should be fine because
the goal of that check is to quickly return from epoll_wait() when
there is a pending fatal signal.

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/eventpoll.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 80c560dad6a3..ed9deeab2488 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1780,6 +1780,14 @@ static int ep_send_events(struct eventpoll *ep,
 {
 	struct ep_send_events_data esed;
 
+	/*
+	 * Always short-circuit for fatal signals to allow threads to make a
+	 * timely exit without the chance of finding more events available and
+	 * fetching repeatedly.
+	 */
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
 	esed.maxevents = maxevents;
 	esed.events = events;
 
@@ -1931,15 +1939,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	}
 
 send_events:
-	if (fatal_signal_pending(current)) {
-		/*
-		 * Always short-circuit for fatal signals to allow
-		 * threads to make a timely exit without the chance of
-		 * finding more events available and fetching
-		 * repeatedly.
-		 */
-		return -EINTR;
-	}
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
 	 * there's still timeout left over, we go trying again in search of
-- 
2.29.1.341.ge80a0c044ae-goog

