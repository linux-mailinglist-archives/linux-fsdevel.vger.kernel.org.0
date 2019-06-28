Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4259F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfF1Pso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfF1Psn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:48:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62BCB83F3D;
        Fri, 28 Jun 2019 15:48:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24BE9608CA;
        Fri, 28 Jun 2019 15:48:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/9] uapi: General notification ring definitions [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:48:34 +0100
Message-ID: <156173691411.15137.2073887155273175167.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 15:48:42 +0000 (UTC)
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

	- WATCH_INFO_ID.  The watch ID specified when the watchpoint was
          set.

	- WATCH_INFO_TYPE_INFO.  (Sub)type-specific information.

	- WATCH_INFO_FLAG_*.  Flag bits overlain on the type-specific
          information.  For use by the type.

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

 (3) WATCH_INFO_NOTIFICATIONS_LOST.

     This is a flag that can be set in the metadata header by the kernel to
     indicate that at least one message was lost since it was last cleared
     by userspace.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |   67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 include/uapi/linux/watch_queue.h

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
new file mode 100644
index 000000000000..70f575099968
--- /dev/null
+++ b/include/uapi/linux/watch_queue.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_WATCH_QUEUE_H
+#define _UAPI_LINUX_WATCH_QUEUE_H
+
+#include <linux/types.h>
+
+enum watch_notification_type {
+	WATCH_TYPE_META		= 0,	/* Special record */
+	WATCH_TYPE___NR		= 1
+};
+
+enum watch_meta_notification_subtype {
+	WATCH_META_SKIP_NOTIFICATION	= 0,	/* Just skip this record */
+	WATCH_META_REMOVAL_NOTIFICATION	= 1,	/* Watched object was removed */
+};
+
+#define WATCH_LENGTH_GRANULARITY sizeof(__u64)
+
+/*
+ * Notification record header.  This is aligned to 64-bits so that subclasses
+ * can contain __u64 fields.
+ */
+struct watch_notification {
+	__u32			type:24;	/* enum watch_notification_type */
+	__u32			subtype:8;	/* Type-specific subtype (filterable) */
+	__u32			info;
+#define WATCH_INFO_LENGTH	0x0000003f	/* Length of record / sizeof(watch_notification) */
+#define WATCH_INFO_LENGTH__SHIFT 0
+#define WATCH_INFO_ID		0x0000ff00	/* ID of watchpoint, if type-appropriate */
+#define WATCH_INFO_ID__SHIFT	8
+#define WATCH_INFO_TYPE_INFO	0xffff0000	/* Type-specific info */
+#define WATCH_INFO_TYPE_INFO__SHIFT 16
+#define WATCH_INFO_FLAG_0	0x00010000	/* Type-specific info, flag bit 0 */
+#define WATCH_INFO_FLAG_1	0x00020000	/* ... */
+#define WATCH_INFO_FLAG_2	0x00040000
+#define WATCH_INFO_FLAG_3	0x00080000
+#define WATCH_INFO_FLAG_4	0x00100000
+#define WATCH_INFO_FLAG_5	0x00200000
+#define WATCH_INFO_FLAG_6	0x00400000
+#define WATCH_INFO_FLAG_7	0x00800000
+} __attribute__((aligned(WATCH_LENGTH_GRANULARITY)));
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
+			__u32		__reserved;
+		} meta;
+		struct watch_notification slots[0];
+	};
+};
+
+/*
+ * The Metadata pseudo-notification message uses a flag bits in the information
+ * field to convey the fact that messages have been lost.  We can only use a
+ * single bit in this manner per word as some arches that support SMP
+ * (eg. parisc) have no kernel<->user atomic bit ops.
+ */
+#define WATCH_INFO_NOTIFICATIONS_LOST WATCH_INFO_FLAG_0
+
+#endif /* _UAPI_LINUX_WATCH_QUEUE_H */

