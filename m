Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53C750EE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfFXOmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:42:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfFXOmC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:42:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9EE7AE32;
        Mon, 24 Jun 2019 14:42:00 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/14] epoll: introduce user structures for polling from userspace
Date:   Mon, 24 Jun 2019 16:41:39 +0200
Message-Id: <20190624144151.22688-3-rpenyaev@suse.de>
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

This one introduces structures of user items array:

struct epoll_uheader -
    describes inserted epoll items.

struct epoll_uitem -
    single epoll item visible to userspace.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c                 | 11 +++++++++++
 include/uapi/linux/eventpoll.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 622b6c9ef8c9..6d7a5fe4a831 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2001,...,2009	 Davide Libenzi
  *
  *  Davide Libenzi <davidel@xmailserver.org>
+ *  Polling from userspace support by Roman Penyaev <rpenyaev@suse.de>
  */
 
 #include <linux/init.h>
@@ -104,6 +105,16 @@
 
 #define EP_ITEM_COST (sizeof(struct epitem) + sizeof(struct eppoll_entry))
 
+/*
+ * That is around 1.3mb of allocated memory for one epfd.  What is more
+ * important is ->index_length, which should be ^2, so do not increase
+ * max items number to avoid size doubling of user index.
+ *
+ * Before increasing the value see add_event_to_uring() and especially
+ * cnt_to_advance() functions and change them accordingly.
+ */
+#define EP_USERPOLL_MAX_ITEMS_NR 65536
+
 struct epoll_filefd {
 	struct file *file;
 	int fd;
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 39dfc29f0f52..3317901b19c4 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -79,4 +79,33 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+#define EPOLL_USERPOLL_HEADER_MAGIC 0xeb01eb01
+#define EPOLL_USERPOLL_HEADER_SIZE  128
+
+/*
+ * Item, shared with userspace.  Unfortunately we can't embed epoll_event
+ * structure, because it is badly aligned on all 64-bit archs, except
+ * x86-64 (see EPOLL_PACKED).  sizeof(epoll_uitem) == 16
+ */
+struct epoll_uitem {
+	__poll_t ready_events;
+	__poll_t events;
+	__u64 data;
+};
+
+/*
+ * Header, shared with userspace. sizeof(epoll_uheader) == 128
+ */
+struct epoll_uheader {
+	__u32 magic;          /* epoll user header magic */
+	__u32 header_length;  /* length of the header + items */
+	__u32 index_length;   /* length of the index ring, always pow2 */
+	__u32 max_items_nr;   /* max number of items */
+	__u32 head;           /* updated by userland */
+	__u32 tail;           /* updated by kernel */
+
+	struct epoll_uitem items[]
+		__attribute__((__aligned__(EPOLL_USERPOLL_HEADER_SIZE)));
+};
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.21.0

