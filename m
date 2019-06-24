Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663D950EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfFXOmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:42:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfFXOmB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7811AD72;
        Mon, 24 Jun 2019 14:42:00 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/14] epoll: move private helpers from a header to the source
Date:   Mon, 24 Jun 2019 16:41:38 +0200
Message-Id: <20190624144151.22688-2-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
References: <20190624144151.22688-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Those helpers will access private eventpoll structure in future patches,
so keep those helpers close to callers.

Nothing important here.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c                 | 13 +++++++++++++
 include/uapi/linux/eventpoll.h | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8bc064630be0..622b6c9ef8c9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -460,6 +460,19 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
+#ifdef CONFIG_PM_SLEEP
+static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+{
+	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
+		epev->events &= ~EPOLLWAKEUP;
+}
+#else
+static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+{
+	epev->events &= ~EPOLLWAKEUP;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 /**
  * ep_call_nested - Perform a bound (possibly) nested call, by checking
  *                  that the recursion limit is not exceeded, and that
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 8a3432d0f0dc..39dfc29f0f52 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -79,16 +79,4 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
-#ifdef CONFIG_PM_SLEEP
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
-{
-	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
-		epev->events &= ~EPOLLWAKEUP;
-}
-#else
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
-{
-	epev->events &= ~EPOLLWAKEUP;
-}
-#endif
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.21.0

