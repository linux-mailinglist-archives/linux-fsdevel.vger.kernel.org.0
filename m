Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415631571EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJJmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 04:42:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJJmS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:42:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F822ADEE;
        Mon, 10 Feb 2020 09:42:16 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Max Neunhoeffer <max@arangodb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] epoll: ep->wq can be woken up unlocked in certain cases
Date:   Mon, 10 Feb 2020 10:41:22 +0100
Message-Id: <20200210094123.389854-2-rpenyaev@suse.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210094123.389854-1-rpenyaev@suse.de>
References: <20200210094123.389854-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now ep->lock is responsible for wqueue serialization, thus if ep->lock
is taken on write path, wake_up_locked() can be invoked.

Though, read path is different.  Since concurrent cpus can enter the
wake up function it needs to be internally serialized, thus wake_up()
variant is used which implies internal spin lock.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Max Neunhoeffer <max@arangodb.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christopher Kohlhoff <chris.kohlhoff@clearpool.io>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Nothing interesting in v2:
     changed the comment a bit

 fs/eventpoll.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eee3c92a9ebf..6e218234bd4a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1173,7 +1173,7 @@ static inline bool chain_epi_lockless(struct epitem *epi)
  * Another thing worth to mention is that ep_poll_callback() can be called
  * concurrently for the same @epi from different CPUs if poll table was inited
  * with several wait queues entries.  Plural wakeup from different CPUs of a
- * single wait queue is serialized by wq.lock, but the case when multiple wait
+ * single wait queue is serialized by ep->lock, but the case when multiple wait
  * queues are used should be detected accordingly.  This is detected using
  * cmpxchg() operation.
  */
@@ -1248,6 +1248,12 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
+		/*
+		 * Since here we have the read lock (ep->lock) taken, plural
+		 * wakeup from different CPUs can occur, thus we call wake_up()
+		 * variant which implies its own lock on wqueue. All other paths
+		 * take write lock.
+		 */
 		wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
@@ -1551,7 +1557,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 		/* Notify waiting tasks that events are available */
 		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
+			wake_up_locked(&ep->wq);
 		if (waitqueue_active(&ep->poll_wait))
 			pwake++;
 	}
@@ -1657,7 +1663,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 
 			/* Notify waiting tasks that events are available */
 			if (waitqueue_active(&ep->wq))
-				wake_up(&ep->wq);
+				wake_up_locked(&ep->wq);
 			if (waitqueue_active(&ep->poll_wait))
 				pwake++;
 		}
-- 
2.24.1

