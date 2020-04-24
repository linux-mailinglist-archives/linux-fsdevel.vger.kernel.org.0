Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD641B7E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDXTAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXTAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:00:51 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E5C09B048
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 12:00:51 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w6so11997761qtt.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G5gPJ9yzlWKnM8iA0E9T+TLkHEBMwugO5CBNEaixrzU=;
        b=mjl5HAyvNO7Wn0qqjC+GtLPePoAukPVxtQ8Y0wikd5FVl0pThxlj9lQQwp+QV6c8ID
         RYkoKV1vafanR7IC7NvcZBxYKkjJPFLETBoD2rwuI16FgRI6WOBAC/mV1xRJKg/PWCn/
         Mb7FabohqsxgHrYQGHEVI4K9tdrOLEznJR/rCvudmDQcqD9teOxGJL/D+vj+Tv0Urcot
         eLTtyAQq+bU2/jhEvpgzNQqPBc0J6egIfEq1Mywpk/aadY1VyHaORWO1gU92bWMlBJY1
         Oj6DF/Fwtnj/08B6FM9tS80SiRIX8W9PPwTDhO3ywgIt18LJrj4NWbLJNrUaSE+mlTBt
         zhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G5gPJ9yzlWKnM8iA0E9T+TLkHEBMwugO5CBNEaixrzU=;
        b=AZInLzoiW/jS4WCQUVyEk/wFayMvAY69V+4bbtYdVtWEVIIPdk35tmRSnrqLc3FLXC
         nyaTYVZFCpLw4zRjVGO+FLGQxFBGaYJ++zkM2BXa9jES4sQyaFGI+2XPOEk1WsIOMKGA
         DkKqgYR7TZj7WKH2/2So7lAz2nx5AlO5HOS1C5cpuJ4ocFWIXbQ1NUE3bSPZw56A49Yh
         lOAZ6hGyviTbbY4gaOQl7lNZDObkY8tlnFA+Zbr4Ytw88JGVlJw7lvs5vu5hCp9pDT8J
         gmAsBTXvGjGfN4peIiUCIyotgUp7sUHkGoQO8wgkrjUuFpvM62tUbjtR0RagKyP8jzEf
         sblA==
X-Gm-Message-State: AGi0PuaDU1CNnc5qebT9l+8q0OHDnh2kTzv7f6l3DF7S8I/FOMuenfW9
        ZN8pNm3vm6DFil+NwwT+oG1OM0WHJYo=
X-Google-Smtp-Source: APiQypISmjPPrqoXpfOTy9ohMBh/vkV4Xt0WhQbaenyLWnvBV083PTzVPMZxeqoQEa2mFbQh1g3aOoeHP9o=
X-Received: by 2002:ad4:450d:: with SMTP id k13mr10999805qvu.138.1587754850975;
 Fri, 24 Apr 2020 12:00:50 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:00:39 -0700
In-Reply-To: <20200424025057.118641-1-khazhy@google.com>
Message-Id: <20200424190039.192373-1-khazhy@google.com>
Mime-Version: 1.0
References: <20200424025057.118641-1-khazhy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2] eventpoll: fix missing wakeup for ovflist in ep_poll_callback
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Heiher <r@hev.cc>,
        Jason Baron <jbaron@akamai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the event that we add to ovflist, before 339ddb53d373 we would be
woken up by ep_scan_ready_list, and did no wakeup in ep_poll_callback.
With that wakeup removed, if we add to ovflist here, we may never wake
up. Rather than adding back the ep_scan_ready_list wakeup - which was
resulting in unnecessary wakeups, trigger a wake-up in ep_poll_callback.

We noticed that one of our workloads was missing wakeups starting with
339ddb53d373 and upon manual inspection, this wakeup seemed missing to
me. With this patch added, we no longer see missing wakeups. I haven't
yet tried to make a small reproducer, but the existing kselftests in
filesystem/epoll passed for me with this patch.

Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Heiher <r@hev.cc>
Cc: Jason Baron <jbaron@akamai.com>
Cc: <stable@vger.kernel.org>
---
v2: use if/elif instead of goto + cleanup suggested by Roman
 fs/eventpoll.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c596641a72b..d6ba0e52439b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1171,6 +1171,10 @@ static inline bool chain_epi_lockless(struct epitem *epi)
 {
 	struct eventpoll *ep = epi->ep;
 
+	/* Fast preliminary check */
+	if (epi->next != EP_UNACTIVE_PTR)
+		return false;
+
 	/* Check that the same epi has not been just chained from another CPU */
 	if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != EP_UNACTIVE_PTR)
 		return false;
@@ -1237,16 +1241,12 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * chained in ep->ovflist and requeued later on.
 	 */
 	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
-		if (epi->next == EP_UNACTIVE_PTR &&
-		    chain_epi_lockless(epi))
+		if (chain_epi_lockless(epi))
+			ep_pm_stay_awake_rcu(epi);
+	} else if (!ep_is_linked(epi)) {
+		/* In the usual case, add event to ready list. */
+		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
 			ep_pm_stay_awake_rcu(epi);
-		goto out_unlock;
-	}
-
-	/* If this file is already in the ready list we exit soon */
-	if (!ep_is_linked(epi) &&
-	    list_add_tail_lockless(&epi->rdllink, &ep->rdllist)) {
-		ep_pm_stay_awake_rcu(epi);
 	}
 
 	/*
-- 
2.26.2.303.gf8c07b1a785-goog

