Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4354D39C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbiFOVYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbiFOVY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:24:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82A554B8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 14:24:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i15so11479598plr.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=TeO0t0DJhH40WIl7Vbgx7DQrmpnWJwpLVnwQgvva4x4=;
        b=rBu1FtRQTEZQUNIgcpXPBVuLI3SY0y6CqfB3zHhUYwKTvw4xR2t+OcGeh1VLHgsxEO
         MWIggtMEqvr1L15IKXPmTiOdX8DlvonktIcIQ6cDsHCxB9K61ZXwMj+MRVHlAxmMl1YL
         j2KvZ5OWD0MDZ4zQJupT9DfEXDcw5lPVp2TSsWHXQ3rZK7QjyftYzqWwGNaMvdClPRJr
         X7ISXc2MlKNUEfLv2VaxwA6TMLt9mjJnBQD99doJ0Q8AhfY6LGG7M/P/qfySH3x7j9ai
         VMzqeiv6FSqvLtJfh1/GjyzveZq0kbKvo2z0iOLxTpFw7PlNIR0f1aL2k/mCmCyLW7u6
         IuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=TeO0t0DJhH40WIl7Vbgx7DQrmpnWJwpLVnwQgvva4x4=;
        b=dIdj4no1Hqi17XHLk3yaYArGeK2Gkdq8fqIJiNdx+6PIiPwkGz4ebwsu6cRwYprtce
         4qinFmy/Vjxsu/LEndLtLmkfHBgA1a5Rbb+qdWnH7E0Bu0qp0DnlJDXdaVLFy0LgdrCs
         T+2teL0jzbG7ocn8nRkiN0wfd/adi+OKlcTBqKxWKTlUefiZDe6fFmd9y7n6W/Ncip/p
         +Z8AF1PC9UrWkVGl76XS7NhwhndqkvqajW8t/hGTu26j+YMcyIxI0/Kztk4Ij6BfWJSq
         A3QWBOYkkSQI5a1iKFkF3ObQUgFKpWNPNVDjGfp6BJfdbKN8MXClZq7mx3fI7pVB4Z7X
         IPQA==
X-Gm-Message-State: AJIora+jmbOFHKPVi6qG/6UCVy6qhdN5D6Me6eXbvaT6EVnRQNVAi+LR
        3f6JcgsWNjZlMpcJDcopZ7YfOrlT8yA+rg==
X-Google-Smtp-Source: AGRyM1sNGPf07ULqZrM5SwuGWCXQmHDsE9gSwLpND+kDkzt2keMd7H9OuWgAXQYw3ogbvzvEikbJnQ==
X-Received: by 2002:a17:90b:4c4c:b0:1e8:6f9a:b642 with SMTP id np12-20020a17090b4c4c00b001e86f9ab642mr12358376pjb.21.1655328267113;
        Wed, 15 Jun 2022 14:24:27 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id n23-20020a056a00213700b0051e7b6e8b12sm117984pfj.11.2022.06.15.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:24:25 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] epoll: autoremove wakers even more aggressively
Date:   Wed, 15 Jun 2022 14:24:23 -0700
Message-ID: <xm26k09htybc.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a process is killed or otherwise exits while having active network
connections and many threads waiting on epoll_wait, the threads will all
be woken immediately, but not removed from ep->wq. Then when network
traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
will not remove the entries from the list.

This means that the cost of the wakeup attempt is far higher than usual,
does not decrease, and this also competes with the dying threads trying
to actually make progress and remove themselves from the wq.

Handle this by removing visited epoll wq entries unconditionally, rather
than only when the wakeup succeeds - the structure of ep_poll means that
the only potential loss is the timed_out->eavail heuristic, which now
can race and result in a redundant ep_send_events attempt. (But only
when incoming data and a timeout actually race, not on every timeout)

Signed-off-by: Ben Segall <bsegall@google.com>
---
 fs/eventpoll.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e2daa940ebce..8b56b94e2f56 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1745,10 +1745,25 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 	ktime_get_ts64(&now);
 	*to = timespec64_add_safe(now, *to);
 	return to;
 }
 
+/*
+ * autoremove_wake_function, but remove even on failure to wake up, because we
+ * know that default_wake_function/ttwu will only fail if the thread is already
+ * woken, and in that case the ep_poll loop will remove the entry anyways, not
+ * try to reuse it.
+ */
+static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
+				       unsigned int mode, int sync, void *key)
+{
+	int ret = default_wake_function(wq_entry, mode, sync, key);
+
+	list_del_init(&wq_entry->entry);
+	return ret;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
  *
  * @ep: Pointer to the eventpoll context.
@@ -1826,12 +1841,19 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * chance to harvest new event. Otherwise wakeup can be
 		 * lost. This is also good performance-wise, because on
 		 * normal wakeup path no need to call __remove_wait_queue()
 		 * explicitly, thus ep->lock is not taken, which halts the
 		 * event delivery.
+		 *
+		 * In fact, we now use an even more aggressive function that
+		 * unconditionally removes, because we don't reuse the wait
+		 * entry between loop iterations. This lets us also avoid the
+		 * performance issue if a process is killed, causing all of its
+		 * threads to wake up without being removed normally.
 		 */
 		init_wait(&wait);
+		wait.func = ep_autoremove_wake_function;
 
 		write_lock_irq(&ep->lock);
 		/*
 		 * Barrierless variant, waitqueue_active() is called under
 		 * the same lock on wakeup ep_poll_callback() side, so it
-- 
2.36.1.476.g0c4daa206d-goog

