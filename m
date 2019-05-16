Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD76201DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfEPI7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:59:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbfEPI62 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2367DAF86;
        Thu, 16 May 2019 08:58:27 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] epoll: support polling from userspace for ep_modify()
Date:   Thu, 16 May 2019 10:58:07 +0200
Message-Id: <20190516085810.31077-11-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516085810.31077-1-rpenyaev@suse.de>
References: <20190516085810.31077-1-rpenyaev@suse.de>
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

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 630f473973da..1b7097e58fb2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2060,6 +2060,8 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		     const struct epoll_event *event)
 {
+	struct epoll_uitem *uitem;
+	__poll_t revents;
 	int pwake = 0;
 	poll_table pt;
 
@@ -2074,6 +2076,14 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 */
 	epi->event.events = event->events; /* need barrier below */
 	epi->event.data = event->data; /* protected by mtx */
+
+	/* Update user item, barrier is below */
+	if (ep_polled_by_user(ep)) {
+		uitem = &ep->user_header->items[epi->bit];
+		uitem->events = event->events;
+		uitem->data = event->data;
+	}
+
 	if (epi->event.events & EPOLLWAKEUP) {
 		if (!ep_has_wakeup_source(epi))
 			ep_create_wakeup_source(epi);
@@ -2107,12 +2117,19 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
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

