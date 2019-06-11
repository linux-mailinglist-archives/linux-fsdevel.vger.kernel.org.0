Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52B13CFCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbfFKOzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:55:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:52630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404076AbfFKOzU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:55:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7226AAF1F;
        Tue, 11 Jun 2019 14:55:19 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/14] epoll: support polling from userspace for ep_modify()
Date:   Tue, 11 Jun 2019 16:54:54 +0200
Message-Id: <20190611145458.9540-11-rpenyaev@suse.de>
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

When epfd is polled from userspace and item is being modified:

1. Update user item with new pointer or poll flags.
2. Add event to user ring if needed.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index edf7ba28bce0..9f0d48eb360e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2239,6 +2239,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		     const struct epoll_event *event)
 {
+	__poll_t revents;
 	int pwake = 0;
 	poll_table pt;
 
@@ -2250,10 +2251,24 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * Set the new event interest mask before calling f_op->poll();
 	 * otherwise we might miss an event that happens between the
 	 * f_op->poll() call and the new event set registering.
+	 *
+	 * Use xchg() here because we can race with ep_clear_public_event_bits()
+	 * for the case when events are polled from userspace.  Internally
+	 * ep_clear_public_event_bits() uses cmpxchg(), thus on some archs
+	 * we can't mix normal writes and cmpxchg().
 	 */
-	epi->event.events = event->events; /* need barrier below */
+	xchg(&epi->event.events, event->events);
 	epi->event.data = event->data; /* protected by mtx */
-	if (epi->event.events & EPOLLWAKEUP) {
+
+	/* Update user item, barrier is below */
+	if (ep_polled_by_user(ep)) {
+		struct uepitem *uepi = uep_item_from_epi(epi);
+		struct epoll_uitem *uitem;
+
+		uitem = &ep->user_header->items[uepi->bit];
+		WRITE_ONCE(uitem->events, event->events);
+		WRITE_ONCE(uitem->data, event->data);
+	} else if (epi->event.events & EPOLLWAKEUP) {
 		if (!ep_has_wakeup_source(epi))
 			ep_create_wakeup_source(epi);
 	} else if (ep_has_wakeup_source(epi)) {
@@ -2286,12 +2301,19 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * If the item is "hot" and it is not registered inside the ready
 	 * list, push it inside.
 	 */
-	if (ep_item_poll(epi, &pt, 1)) {
+	revents = ep_item_poll(epi, &pt, 1);
+	if (revents) {
+		bool added = false;
+
 		write_lock_irq(&ep->lock);
-		if (!ep_is_linked(epi)) {
+		if (ep_polled_by_user(ep))
+			added = ep_add_event_to_uring(epi, revents);
+		else if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
-
+			added = true;
+		}
+		if (added) {
 			/* Notify waiting tasks that events are available */
 			if (waitqueue_active(&ep->wq))
 				wake_up(&ep->wq);
-- 
2.21.0

