Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0055D354922
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbhDEXKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 19:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238555AbhDEXKq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20343B115;
        Mon,  5 Apr 2021 23:10:38 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, rpenyaev@suse.de, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] fs/epoll: restore waking from ep_done_scan()
Date:   Mon,  5 Apr 2021 16:10:25 -0700
Message-Id: <20210405231025.33829-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210405231025.33829-1-dave@stgolabs.net>
References: <20210405231025.33829-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

339ddb53d373 (fs/epoll: remove unnecessary wakeups of nested epoll) changed
the userspace visible behavior of exclusive waiters blocked on a common
epoll descriptor upon a single event becoming ready. Previously, all tasks
doing epoll_wait would awake, and now only one is awoken, potentially causing
missed wakeups on applications that rely on this behavior, such as Apache Qpid.

While the aforementioned commit aims at having only a wakeup single path in
ep_poll_callback (with the exceptions of epoll_ctl cases), we need to restore
the wakeup in what was the old ep_scan_ready_list() such that the next thread
can be awoken, in a cascading style, after the waker's corresponding ep_send_events().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 73138ea68342..1e596e1d0bba 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -657,6 +657,12 @@ static void ep_done_scan(struct eventpoll *ep,
 	 */
 	list_splice(txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
+
+	if (!list_empty(&ep->rdllist)) {
+		if (waitqueue_active(&ep->wq))
+			wake_up(&ep->wq);
+	}
+
 	write_unlock_irq(&ep->lock);
 }
 
-- 
2.26.2

