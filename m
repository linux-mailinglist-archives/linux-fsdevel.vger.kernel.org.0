Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A863CFD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391618AbfFKOzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:55:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391599AbfFKOzL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:55:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BBFBAF1F;
        Tue, 11 Jun 2019 14:55:09 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/14] epoll: some sanity flags checks for epoll syscalls for polling from userspace
Date:   Tue, 11 Jun 2019 16:54:48 +0200
Message-Id: <20190611145458.9540-5-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611145458.9540-1-rpenyaev@suse.de>
References: <20190611145458.9540-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are various of limitations if epfd is polled by user:

 1. Expect always EPOLLET flag (Edge Triggered behavior)

 2. No support for EPOLLWAKEUP
       events are consumed from userspace, thus no way to call __pm_relax()

 3. No support for EPOLLEXCLUSIVE
       If device does not pass pollflags to wake_up() there is no way to
       call poll() from the context under spinlock, thus special work is
       scheduled to offload polling.  In this specific case we can't
       support exclusive wakeups, because we do not know actual result
       of scheduled work.

4. epoll_wait() for epfd, created with EPOLL_USERPOLL flag, accepts events
   as NULL and maxevents as 0.  No other values are accepted.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 68 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3a5c4d641ff0..529573266ff5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -425,6 +425,11 @@ static inline unsigned int ep_to_items_bm_length(unsigned int nr)
 	return PAGE_ALIGN(ALIGN(nr, 8) >> 3);
 }
 
+static inline bool ep_polled_by_user(struct eventpoll *ep)
+{
+	return !!ep->user_header;
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -520,13 +525,17 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 #ifdef CONFIG_PM_SLEEP
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+static inline void ep_take_care_of_epollwakeup(struct eventpoll *ep,
+					       struct epoll_event *epev)
 {
-	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
-		epev->events &= ~EPOLLWAKEUP;
+	if (epev->events & EPOLLWAKEUP) {
+		if (!capable(CAP_BLOCK_SUSPEND) || ep_polled_by_user(ep))
+			epev->events &= ~EPOLLWAKEUP;
+	}
 }
 #else
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+static inline void ep_take_care_of_epollwakeup(struct eventpoll *ep,
+					       struct epoll_event *epev)
 {
 	epev->events &= ~EPOLLWAKEUP;
 }
@@ -2278,10 +2287,6 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	if (!file_can_poll(tf.file))
 		goto error_tgt_fput;
 
-	/* Check if EPOLLWAKEUP is allowed */
-	if (ep_op_has_event(op))
-		ep_take_care_of_epollwakeup(&epds);
-
 	/*
 	 * We have to check that the file structure underneath the file descriptor
 	 * the user passed to us _is_ an eventpoll file. And also we do not permit
@@ -2291,10 +2296,18 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	if (f.file == tf.file || !is_file_epoll(f.file))
 		goto error_tgt_fput;
 
+	/*
+	 * At this point it is safe to assume that the "private_data" contains
+	 * our own data structure.
+	 */
+	ep = f.file->private_data;
+
 	/*
 	 * epoll adds to the wakeup queue at EPOLL_CTL_ADD time only,
 	 * so EPOLLEXCLUSIVE is not allowed for a EPOLL_CTL_MOD operation.
-	 * Also, we do not currently supported nested exclusive wakeups.
+	 * Also, we do not currently supported nested exclusive wakeups
+	 * and EPOLLEXCLUSIVE is not supported for epoll which is polled
+	 * from userspace.
 	 */
 	if (ep_op_has_event(op) && (epds.events & EPOLLEXCLUSIVE)) {
 		if (op == EPOLL_CTL_MOD)
@@ -2302,13 +2315,18 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 		if (op == EPOLL_CTL_ADD && (is_file_epoll(tf.file) ||
 				(epds.events & ~EPOLLEXCLUSIVE_OK_BITS)))
 			goto error_tgt_fput;
+		if (ep_polled_by_user(ep))
+			goto error_tgt_fput;
 	}
 
-	/*
-	 * At this point it is safe to assume that the "private_data" contains
-	 * our own data structure.
-	 */
-	ep = f.file->private_data;
+	if (ep_op_has_event(op)) {
+		if (ep_polled_by_user(ep) && !(epds.events & EPOLLET))
+			/* Polled by user has only edge triggered behaviour */
+			goto error_tgt_fput;
+
+		/* Check if EPOLLWAKEUP is allowed */
+		ep_take_care_of_epollwakeup(ep, &epds);
+	}
 
 	/*
 	 * When we insert an epoll file descriptor, inside another epoll file
@@ -2410,14 +2428,6 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	struct fd f;
 	struct eventpoll *ep;
 
-	/* The maximum number of event must be greater than zero */
-	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
-		return -EINVAL;
-
-	/* Verify that the area passed by the user is writeable */
-	if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
-		return -EFAULT;
-
 	/* Get the "struct file *" for the eventpoll file */
 	f = fdget(epfd);
 	if (!f.file)
@@ -2436,6 +2446,20 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	 * our own data structure.
 	 */
 	ep = f.file->private_data;
+	if (!ep_polled_by_user(ep)) {
+		/* The maximum number of event must be greater than zero */
+		if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
+			goto error_fput;
+
+		/* Verify that the area passed by the user is writeable */
+		error = -EFAULT;
+		if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
+			goto error_fput;
+	} else {
+		/* Use ring instead */
+		if (maxevents != 0 || events != NULL)
+			goto error_fput;
+	}
 
 	/* Time to fish for events ... */
 	error = ep_poll(ep, events, maxevents, timeout);
-- 
2.21.0

