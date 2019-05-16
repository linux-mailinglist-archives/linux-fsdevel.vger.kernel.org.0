Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7585201E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfEPI7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbfEPI61 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DE4DAF7C;
        Thu, 16 May 2019 08:58:26 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] epoll: call ep_add_event_to_uring() from ep_poll_callback()
Date:   Thu, 16 May 2019 10:58:04 +0200
Message-Id: <20190516085810.31077-8-rpenyaev@suse.de>
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

Each ep_poll_callback() is called when fd calls wakeup() on epfd.
So account new event in user ring.

The tricky part here is EPOLLONESHOT.  Since we are lockless we
have to be deal with ep_poll_callbacks() called in paralle, thus
use cmpxchg to clear public event bits and filter out concurrent
call from another cpu.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2f551c005640..55612da9651e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1407,6 +1407,29 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 }
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 
+/**
+ * Atomically clear public event bits and return %true if the old value has
+ * public event bits set.
+ */
+static inline bool ep_clear_public_event_bits(struct epitem *epi)
+{
+	__poll_t old, flags;
+
+	/*
+	 * Here we race with ourselves and with ep_modify(), which can
+	 * change the event bits.  In order not to override events updated
+	 * by ep_modify() we have to do cmpxchg.
+	 */
+
+	old = epi->event.events;
+	do {
+		flags = old;
+	} while ((old = cmpxchg(&epi->event.events, flags,
+				flags & EP_PRIVATE_BITS)) != flags);
+
+	return flags & ~EP_PRIVATE_BITS;
+}
+
 /**
  * Adds a new entry to the tail of the list in a lockless way, i.e.
  * multiple CPUs are allowed to call this function concurrently.
@@ -1526,6 +1549,20 @@ static int ep_poll_callback(struct epitem *epi, __poll_t pollflags)
 	if (pollflags && !(pollflags & epi->event.events))
 		goto out_unlock;
 
+	if (ep_polled_by_user(ep)) {
+		/*
+		 * For polled descriptor from user we have to disable events on
+		 * callback path in case of one-shot.
+		 */
+		if ((epi->event.events & EPOLLONESHOT) &&
+		    !ep_clear_public_event_bits(epi))
+			/* Race is lost, another callback has cleared events */
+			goto out_unlock;
+
+		ep_add_event_to_uring(epi, pollflags);
+		goto wakeup;
+	}
+
 	/*
 	 * If we are transferring events to userspace, we can hold no locks
 	 * (because we're accessing user memory, and because of linux f_op->poll()
@@ -1545,6 +1582,7 @@ static int ep_poll_callback(struct epitem *epi, __poll_t pollflags)
 		ep_pm_stay_awake_rcu(epi);
 	}
 
+wakeup:
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
 	 * wait list.
-- 
2.21.0

