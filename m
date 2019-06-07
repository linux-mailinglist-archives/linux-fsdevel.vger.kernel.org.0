Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18C38C81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfFGORo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbfFGORo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4130A30C31BA;
        Fri,  7 Jun 2019 14:17:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 872D978566;
        Fri,  7 Jun 2019 14:17:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/13] uapi: General notification ring definitions [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Jun 2019 15:17:40 +0100
Message-ID: <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 14:17:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add UAPI definitions for the general notification ring, including the
following pieces:

 (1) struct watch_notification.

     This is the metadata header for each entry in the ring.  It includes a
     type and subtype that indicate the source of the message
     (eg. WATCH_TYPE_MOUNT_NOTIFY) and the kind of the message
     (eg. NOTIFY_MOUNT_NEW_MOUNT).

     The header also contains an information field that conveys the
     following information:

	- WATCH_INFO_LENGTH.  The size of the entry (entries are variable
          length).

	- WATCH_INFO_OVERRUN.  If preceding messages were lost due to ring
	  overrun or lack of memory.

	- WATCH_INFO_ENOMEM.  If preceding messages were lost due to lack
          of memory.

	- WATCH_INFO_RECURSIVE.  If the event detected was applied to
          multiple objects (eg. a recursive change to mount attributes).

	- WATCH_INFO_IN_SUBTREE.  If the event didn't happen at the watched
          object, but rather to some related object (eg. a subtree mount
          watch saw a mount happen somewhere within the subtree).

	- WATCH_INFO_TYPE_FLAGS.  Eight flags whose meanings depend on the
          message type.

	- WATCH_INFO_ID.  The watch ID specified when the watchpoint was
          set.

     All the information in the header can be used in filtering messages at
     the point of writing into the buffer.

 (2) struct watch_queue_buffer.

     This describes the layout of the ring.  Note that the first slots in
     the ring contain a special metadata entry that contains the ring
     pointers.  The producer in the kernel knows to skip this and it has a
     proper header (WATCH_TYPE_META, WATCH_META_SKIP_NOTIFICATION) that
     indicates the size so that the ring consumer can handle it the same as
     any other record and just skip it.

     Note that this means that ring entries can never be split over the end
     of the ring, so if an entry would need to be split, a skip record is
     inserted to wrap the ring first; this is also WATCH_TYPE_META,
     WATCH_META_SKIP_NOTIFICATION.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |   63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 include/uapi/linux/watch_queue.h

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
new file mode 100644
index 000000000000..c3a88fa5f62a
--- /dev/null
+++ b/include/uapi/linux/watch_queue.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_WATCH_QUEUE_H
+#define _UAPI_LINUX_WATCH_QUEUE_H
+
+#include <linux/types.h>
+
+enum watch_notification_type {
+	WATCH_TYPE_META		= 0,	/* Special record */
+	WATCH_TYPE_MOUNT_NOTIFY	= 1,	/* Mount notification record */
+	WATCH_TYPE_SB_NOTIFY	= 2,	/* Superblock notification */
+	WATCH_TYPE_KEY_NOTIFY	= 3,	/* Key/keyring change notification */
+	WATCH_TYPE_BLOCK_NOTIFY	= 4,	/* Block layer notifications */
+#define WATCH_TYPE___NR 5
+};
+
+enum watch_meta_notification_subtype {
+	WATCH_META_SKIP_NOTIFICATION	= 0,	/* Just skip this record */
+	WATCH_META_REMOVAL_NOTIFICATION	= 1,	/* Watched object was removed */
+};
+
+/*
+ * Notification record
+ */
+struct watch_notification {
+	__u32			type:24;	/* enum watch_notification_type */
+	__u32			subtype:8;	/* Type-specific subtype (filterable) */
+	__u32			info;
+#define WATCH_INFO_OVERRUN	0x00000001	/* Event(s) lost due to overrun */
+#define WATCH_INFO_ENOMEM	0x00000002	/* Event(s) lost due to ENOMEM */
+#define WATCH_INFO_RECURSIVE	0x00000004	/* Change was recursive */
+#define WATCH_INFO_LENGTH	0x000001f8	/* Length of record / sizeof(watch_notification) */
+#define WATCH_INFO_IN_SUBTREE	0x00000200	/* Change was not at watched root */
+#define WATCH_INFO_TYPE_FLAGS	0x00ff0000	/* Type-specific flags */
+#define WATCH_INFO_FLAG_0	0x00010000
+#define WATCH_INFO_FLAG_1	0x00020000
+#define WATCH_INFO_FLAG_2	0x00040000
+#define WATCH_INFO_FLAG_3	0x00080000
+#define WATCH_INFO_FLAG_4	0x00100000
+#define WATCH_INFO_FLAG_5	0x00200000
+#define WATCH_INFO_FLAG_6	0x00400000
+#define WATCH_INFO_FLAG_7	0x00800000
+#define WATCH_INFO_ID		0xff000000	/* ID of watchpoint */
+#define WATCH_INFO_ID__SHIFT	24
+};
+
+#define WATCH_LENGTH_SHIFT	3
+
+struct watch_queue_buffer {
+	union {
+		/* The first few entries are special, containing the
+		 * ring management variables.
+		 */
+		struct {
+			struct watch_notification watch; /* WATCH_TYPE_META */
+			__u32		head;		/* Ring head index */
+			__u32		tail;		/* Ring tail index */
+			__u32		mask;		/* Ring index mask */
+		} meta;
+		struct watch_notification slots[0];
+	};
+};
+
+#endif /* _UAPI_LINUX_WATCH_QUEUE_H */

