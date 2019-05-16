Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381BC201E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfEPI73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:59:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbfEPI6Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACB83AF50;
        Thu, 16 May 2019 08:58:24 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] epoll: introduce user structures for polling from userspace
Date:   Thu, 16 May 2019 10:57:59 +0200
Message-Id: <20190516085810.31077-3-rpenyaev@suse.de>
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

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2cc183e86a29..f598442512f3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -9,6 +9,8 @@
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
+ *  Polling from userspace support by Roman Penyaev <rpenyaev@suse.de>
+ *  (C) Copyright 2019 SUSE, All Rights Reserved
  */
 
 #include <linux/init.h>
@@ -109,6 +111,13 @@
 
 #define EP_ITEM_COST (sizeof(struct epitem) + sizeof(struct eppoll_entry))
 
+/*
+ * That is around 1.3mb of allocated memory for one epfd.  What is more
+ * important is ->index_length, which should be ^2, so do not increase
+ * max items number to avoid size doubling of user index.
+ */
+#define EP_USERPOLL_MAX_ITEMS_NR 65536
+
 struct epoll_filefd {
 	struct file *file;
 	int fd;
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 39dfc29f0f52..161dfcbcf3b5 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -79,4 +79,32 @@ struct epoll_event {
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
+	u32 magic;          /* epoll user header magic */
+	u32 header_length;  /* length of the header + items */
+	u32 index_length;   /* length of the index ring, always pow2 */
+	u32 max_items_nr;   /* max number of items */
+	u32 head;           /* updated by userland */
+	u32 tail;           /* updated by kernel */
+
+	struct epoll_uitem items[] __aligned(EPOLL_USERPOLL_HEADER_SIZE);
+};
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.21.0

