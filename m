Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47F2AA8D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 02:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgKHBnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Nov 2020 20:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKHBnp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Nov 2020 20:43:45 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCFA20704;
        Sun,  8 Nov 2020 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604799824;
        bh=H/++Gk4gb5v0dJmLHMsEL+uctYi80pqYE3a8AmZ73lU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NN83rAgVZa6pq/3BgNq3ebjN2tg3NbApLHBDBJCyy50EgK+mg/9eE8O1K1WgoqQZ/
         2950bgoJJOm6FiFGCQC5pm3nK/t4oQUWFeqAJVQdvZnSplujR31DPnqHUw2FZKCbAI
         bw4pkVlRrhYZP0eX5Ifj5UvZlotw9N0T5oZ71K4M=
Date:   Sat, 7 Nov 2020 17:43:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
Message-Id: <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
In-Reply-To: <20201106231635.3528496-1-soheil.kdev@gmail.com>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  6 Nov 2020 18:16:27 -0500 Soheil Hassas Yeganeh <soheil.kdev@gmail.com> wrote:

> From: Soheil Hassas Yeganeh <soheil@google.com>
> 
> This patch series is a follow up based on the suggestions and feedback by Linus:
> https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com

Al Viro has been playing in here as well - see the below, from
linux-next.

I think I'll leave it to you folks to sort this out, please.


commit 57804b1cc4616780c72a2d0930d1bd0d5bd3ed4c
Author:     Al Viro <viro@zeniv.linux.org.uk>
AuthorDate: Mon Aug 31 13:41:30 2020 -0400
Commit:     Al Viro <viro@zeniv.linux.org.uk>
CommitDate: Sun Oct 25 20:02:01 2020 -0400

    lift locking/unlocking ep->mtx out of ep_{start,done}_scan()
    
    get rid of depth/ep_locked arguments there and document
    the kludge in ep_item_poll() that has lead to ep_locked existence in
    the first place
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ac996b959e94..f9c567af1f5f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -554,20 +554,13 @@ static inline void ep_pm_stay_awake_rcu(struct epitem *epi)
 	rcu_read_unlock();
 }
 
-static void ep_start_scan(struct eventpoll *ep,
-			  int depth, bool ep_locked,
-			  struct list_head *txlist)
-{
-	lockdep_assert_irqs_enabled();
-
-	/*
-	 * We need to lock this because we could be hit by
-	 * eventpoll_release_file() and epoll_ctl().
-	 */
-
-	if (!ep_locked)
-		mutex_lock_nested(&ep->mtx, depth);
 
+/*
+ * ep->mutex needs to be held because we could be hit by
+ * eventpoll_release_file() and epoll_ctl().
+ */
+static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
+{
 	/*
 	 * Steal the ready list, and re-init the original one to the
 	 * empty list. Also, set ep->ovflist to NULL so that events
@@ -576,6 +569,7 @@ static void ep_start_scan(struct eventpoll *ep,
 	 * because we want the "sproc" callback to be able to do it
 	 * in a lockless way.
 	 */
+	lockdep_assert_irqs_enabled();
 	write_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
@@ -583,7 +577,6 @@ static void ep_start_scan(struct eventpoll *ep,
 }
 
 static void ep_done_scan(struct eventpoll *ep,
-			 int depth, bool ep_locked,
 			 struct list_head *txlist)
 {
 	struct epitem *epi, *nepi;
@@ -624,9 +617,6 @@ static void ep_done_scan(struct eventpoll *ep,
 	list_splice(txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
 	write_unlock_irq(&ep->lock);
-
-	if (!ep_locked)
-		mutex_unlock(&ep->mtx);
 }
 
 static void epi_rcu_free(struct rcu_head *head)
@@ -763,11 +753,16 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
-	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
 
-	ep_start_scan(ep, depth, locked, &txlist);
+	// kludge: ep_insert() calls us with ep->mtx already locked
+	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
+	if (!locked)
+		mutex_lock_nested(&ep->mtx, depth);
+	ep_start_scan(ep, &txlist);
 	res = ep_read_events_proc(ep, &txlist, depth + 1);
-	ep_done_scan(ep, depth, locked, &txlist);
+	ep_done_scan(ep, &txlist);
+	if (!locked)
+		mutex_unlock(&ep->mtx);
 	return res & epi->event.events;
 }
 
@@ -809,9 +804,11 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 	 * Proceed to find out if wanted events are really available inside
 	 * the ready list.
 	 */
-	ep_start_scan(ep, 0, false, &txlist);
+	mutex_lock(&ep->mtx);
+	ep_start_scan(ep, &txlist);
 	res = ep_read_events_proc(ep, &txlist, 1);
-	ep_done_scan(ep, 0, false, &txlist);
+	ep_done_scan(ep, &txlist);
+	mutex_unlock(&ep->mtx);
 	return res;
 }
 
@@ -1573,15 +1570,13 @@ static int ep_send_events(struct eventpoll *ep,
 
 	init_poll_funcptr(&pt, NULL);
 
-	ep_start_scan(ep, 0, false, &txlist);
+	mutex_lock(&ep->mtx);
+	ep_start_scan(ep, &txlist);
 
 	/*
 	 * We can loop without lock because we are passed a task private list.
-	 * Items cannot vanish during the loop because ep_scan_ready_list() is
-	 * holding "mtx" during this call.
+	 * Items cannot vanish during the loop we are holding ep->mtx.
 	 */
-	lockdep_assert_held(&ep->mtx);
-
 	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
 		struct wakeup_source *ws;
 		__poll_t revents;
@@ -1609,9 +1604,8 @@ static int ep_send_events(struct eventpoll *ep,
 
 		/*
 		 * If the event mask intersect the caller-requested one,
-		 * deliver the event to userspace. Again, ep_scan_ready_list()
-		 * is holding ep->mtx, so no operations coming from userspace
-		 * can change the item.
+		 * deliver the event to userspace. Again, we are holding ep->mtx,
+		 * so no operations coming from userspace can change the item.
 		 */
 		revents = ep_item_poll(epi, &pt, 1);
 		if (!revents)
@@ -1645,7 +1639,8 @@ static int ep_send_events(struct eventpoll *ep,
 			ep_pm_stay_awake(epi);
 		}
 	}
-	ep_done_scan(ep, 0, false, &txlist);
+	ep_done_scan(ep, &txlist);
+	mutex_unlock(&ep->mtx);
 
 	return res;
 }

