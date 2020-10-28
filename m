Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041AE29D55A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgJ1WAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgJ1WAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF194C0613CF;
        Wed, 28 Oct 2020 15:00:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x23so301109plr.6;
        Wed, 28 Oct 2020 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwYcjUQ9n0ZM+r827p0TWJkTogeEds8umhVXpQGywJI=;
        b=BoCFMRz4ffT0VFvro9CSY2MtQzfcrZXLSRRBIMQscg6M/ym8yVi7FIbqr6izdKht+N
         weYRAzuZ+jpLU81fTDpdYa6atx55gTvqvL2cClz+uhHc2D0zcMxLuoUy6nnrJ9YrECXD
         RQCOW8IeTVlrg7oTG3cdtIdNOj9G3kPEs3Okz9Kq3p++qdI+Vjsn6GUoIfjz3uQ2i/v9
         sEFvZFyGXWG0De469unrtLvDUQuol4shhhSH62mAeK2UtrGFekEakmnwiPSeOQAoXXlr
         FPYt92EtK/tQu2Pt2spAcZSeE2Lg3vuVR0G/CTCYYYRCu/erze61WD9pkMtGuEZxy9B3
         uSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwYcjUQ9n0ZM+r827p0TWJkTogeEds8umhVXpQGywJI=;
        b=duVBU3ZzflRyn4N7VssUCSzIqFeFkcnF6K1BOlx8rQp8mE+cYOrts8vM3jfqAWVj/5
         ZXceaYvsNXUAAImhG+npKEsCj2p2s7CPaHyOPYClDUpeLvxdWCCoIkiObiOJoeJhsijI
         pLNvWm5+DvZcfXGQV3SvFc0UeIMA5YL6DY9mUiySW3zF2T3ONhHH8YKFf9SNQ4VjeuMU
         psw5W48FNT8ZLSfT/k4M5HbJNqN8G3V3uQCv6NSRjII3GOsf6cdzkakFhxShlex9ecn6
         SOS4lPTEyrxGuLE72bUxKe7IHHrKGV5NdgYl7JIojwl2Jw9LN5ayqHxmQovxCn2QXSvm
         hghw==
X-Gm-Message-State: AOAM530CPbx84+xDFwwvnpn2QyD6JQpBG4wX2KNjOh66SLYtIym7tsVu
        tfED0iySssfW+IO6GzYWeUVxGHOEIaY=
X-Google-Smtp-Source: ABdhPJxH9u5TCOT2f00qm+z9/5Z98BTojmCESoV9x4IrB6x4AMCfgHtLspS3XeKRF+y+hixfUN7TXg==
X-Received: by 2002:a0c:b65b:: with SMTP id q27mr586836qvf.8.1603908132941;
        Wed, 28 Oct 2020 11:02:12 -0700 (PDT)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id o2sm65054qkk.121.2020.10.28.11.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:02:12 -0700 (PDT)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, Soheil Hassas Yeganeh <soheil@google.com>,
        Guantao Liu <guantaol@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH 1/2] epoll: check ep_events_available() upon timeout
Date:   Wed, 28 Oct 2020 14:02:01 -0400
Message-Id: <20201028180202.952079-1-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

After abc610e01c66, we break out of the ep_poll loop upon timeout,
without checking whether there is any new events available.  Prior to
that patch-series we always called ep_events_available() after
exiting the loop.

This can cause races and missed wakeups. For example, consider
the following scenario reported by Guantao Liu:

Suppose we have an eventfd added using EPOLLET to an epollfd.

Thread 1: Sleeps for just below 5ms and then writes to an eventfd.
Thread 2: Calls epoll_wait with a timeout of 5 ms. If it sees an
          event of the eventfd, it will write back on that fd.
Thread 3: Calls epoll_wait with a negative timeout.

Prior to abc610e01c66, it is guaranteed that Thread 3 will wake up
either by Thread 1 or Thread 2.  After abc610e01c66, Thread 3 can
be blocked indefinitely if Thread 2 sees a timeout right before
the write to the eventfd by Thread 1. Thread 2 will be woken up from
schedule_hrtimeout_range and, with evail 0, it will not call
ep_send_events().

To fix this issue, while holding the lock, try to remove the thread that
timed out the wait queue and check whether it was woken up or not.

Fixes: abc610e01c66 ("fs/epoll: avoid barrier after an epoll_wait(2) timeout")
Reported-by: Guantao Liu <guantaol@google.com>
Tested-by: Guantao Liu <guantaol@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/eventpoll.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4df61129566d..11388436b85a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1907,7 +1907,21 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 		if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS)) {
 			timed_out = 1;
-			break;
+			__set_current_state(TASK_RUNNING);
+			/*
+			 * Acquire the lock and try to remove this thread from
+			 * the wait queue. If this thread is not on the wait
+			 * queue, it has woken up after its timeout ended
+			 * before it could re-acquire the lock. In that case,
+			 * try to harvest some events.
+			 */
+			write_lock_irq(&ep->lock);
+			if (!list_empty(&wait.entry))
+				__remove_wait_queue(&ep->wq, &wait);
+			else
+				eavail = 1;
+			write_unlock_irq(&ep->lock);
+			goto send_events;
 		}
 
 		/* We were woken up, thus go and try to harvest some events */
-- 
2.29.0.rc2.309.g374f81d7ae-goog

