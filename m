Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707D81C5A2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgEEO4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 10:56:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgEEO4T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 10:56:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A71F4ABCF;
        Tue,  5 May 2020 14:56:20 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] epoll: call final ep_events_available() check under the lock
Date:   Tue,  5 May 2020 16:56:09 +0200
Message-Id: <20200505145609.1865152-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a possible race when ep_scan_ready_list() leaves ->rdllist
and ->obflist empty for a short period of time although some events
are pending. It is quite likely that ep_events_available() observes
empty lists and goes to sleep. Since 339ddb53d373 ("fs/epoll: remove
unnecessary wakeups of nested epoll") we are conservative in wakeups
(there is only one place for wakeup and this is ep_poll_callback()),
thus ep_events_available() must always observe correct state of
two lists. The easiest and correct way is to do the final check
under the lock. This does not impact the performance, since lock
is taken anyway for adding a wait entry to the wait queue.

The discussion of the problem can be found here:
   https://lore.kernel.org/linux-fsdevel/a2f22c3c-c25a-4bda-8339-a7bdaf17849e@akamai.com/

In this patch barrierless __set_current_state() is used. This is
safe since waitqueue_active() is called under the same lock on wakeup
side.

Short-circuit for fatal signals (i.e. fatal_signal_pending() check)
is moved to the line just before actual events harvesting routine.
This is fully compliant to what is said in the comment of the patch
where the actual fatal_signal_pending() check was added:
c257a340ede0 ("fs, epoll: short circuit fetching events if thread
has been killed").

Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")
Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Reported-by: Jason Baron <jbaron@akamai.com>
Reviewed-by: Jason Baron <jbaron@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Khazhismel Kumykov <khazhy@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
v2: minor comments tweaks

 fs/eventpoll.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index aba03ee749f8..12eebcdea9c8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1879,34 +1879,33 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * event delivery.
 		 */
 		init_wait(&wait);
-		write_lock_irq(&ep->lock);
-		__add_wait_queue_exclusive(&ep->wq, &wait);
-		write_unlock_irq(&ep->lock);
 
+		write_lock_irq(&ep->lock);
 		/*
-		 * We don't want to sleep if the ep_poll_callback() sends us
-		 * a wakeup in between. That's why we set the task state
-		 * to TASK_INTERRUPTIBLE before doing the checks.
+		 * Barrierless variant, waitqueue_active() is called under
+		 * the same lock on wakeup ep_poll_callback() side, so it
+		 * is safe to avoid an explicit barrier.
 		 */
-		set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE);
+
 		/*
-		 * Always short-circuit for fatal signals to allow
-		 * threads to make a timely exit without the chance of
-		 * finding more events available and fetching
-		 * repeatedly.
+		 * Do the final check under the lock. ep_scan_ready_list()
+		 * plays with two lists (->rdllist and ->ovflist) and there
+		 * is always a race when both lists are empty for short
+		 * period of time although events are pending, so lock is
+		 * important.
 		 */
-		if (fatal_signal_pending(current)) {
-			res = -EINTR;
-			break;
+		eavail = ep_events_available(ep);
+		if (!eavail) {
+			if (signal_pending(current))
+				res = -EINTR;
+			else
+				__add_wait_queue_exclusive(&ep->wq, &wait);
 		}
+		write_unlock_irq(&ep->lock);
 
-		eavail = ep_events_available(ep);
-		if (eavail)
-			break;
-		if (signal_pending(current)) {
-			res = -EINTR;
+		if (eavail || res)
 			break;
-		}
 
 		if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS)) {
 			timed_out = 1;
@@ -1927,6 +1926,15 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	}
 
 send_events:
+	if (fatal_signal_pending(current)) {
+		/*
+		 * Always short-circuit for fatal signals to allow
+		 * threads to make a timely exit without the chance of
+		 * finding more events available and fetching
+		 * repeatedly.
+		 */
+		res = -EINTR;
+	}
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
 	 * there's still timeout left over, we go trying again in search of
-- 
2.24.1

