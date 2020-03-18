Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD1189E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCRPDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:03:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41604 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgCRPDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i32RwNIexlSTGjPdh8V9cz3m8rKQLmmbJ0m7mElrktI=;
        b=QDzUF0yPBHH1zsuJCBjZe+JxwzeUVypbwwKpymWKC0U7wViq4oQbuFdok8BE19Fd/t1a7H
        qjDSjsvvVv5knUkr5jjvGhZhPfyG2hoM/6U2H2DW1ZKV+HdGHqlwuc5YRggXRzcLibEvnJ
        7A7n8Rm5tNWecP9ywdcwensEcFY+dOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-dNMuW7FkMg-XGeyrWPGnNQ-1; Wed, 18 Mar 2020 11:03:27 -0400
X-MC-Unique: dNMuW7FkMg-XGeyrWPGnNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E7C102C8CE;
        Wed, 18 Mar 2020 15:03:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 956861001B07;
        Wed, 18 Mar 2020 15:03:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/17] uapi: General notification queue definitions [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:03:17 +0000
Message-ID: <158454379781.2863966.14636232398055723657.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add UAPI definitions for the general notification queue, including the
following pieces:

 (*) struct watch_notification.

     This is the metadata header for notification messages.  It includes a
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

 (*) struct watch_notification_removal

     This is an extended watch-removal notification record that includes an
     'id' field that can indicate the identifier of the object being
     removed if available (for instance, a keyring serial number).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |   55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/uapi/linux/watch_queue.h

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
new file mode 100644
index 000000000000..5f3d21e8a34b
--- /dev/null
+++ b/include/uapi/linux/watch_queue.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_WATCH_QUEUE_H
+#define _UAPI_LINUX_WATCH_QUEUE_H
+
+#include <linux/types.h>
+
+enum watch_notification_type {
+	WATCH_TYPE_META		= 0,	/* Special record */
+	WATCH_TYPE__NR		= 1
+};
+
+enum watch_meta_notification_subtype {
+	WATCH_META_REMOVAL_NOTIFICATION	= 0,	/* Watched object was removed */
+	WATCH_META_LOSS_NOTIFICATION	= 1,	/* Data loss occurred */
+};
+
+/*
+ * Notification record header.  This is aligned to 64-bits so that subclasses
+ * can contain __u64 fields.
+ */
+struct watch_notification {
+	__u32			type:24;	/* enum watch_notification_type */
+	__u32			subtype:8;	/* Type-specific subtype (filterable) */
+	__u32			info;
+#define WATCH_INFO_LENGTH	0x0000007f	/* Length of record */
+#define WATCH_INFO_LENGTH__SHIFT 0
+#define WATCH_INFO_ID		0x0000ff00	/* ID of watchpoint */
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
+};
+
+
+/*
+ * Extended watch removal notification.  This is used optionally if the type
+ * wants to indicate an identifier for the object being watched, if there is
+ * such.  This can be distinguished by the length.
+ *
+ * type -> WATCH_TYPE_META
+ * subtype -> WATCH_META_REMOVAL_NOTIFICATION
+ */
+struct watch_notification_removal {
+	struct watch_notification watch;
+	__u64	id;		/* Type-dependent identifier */
+};
+
+#endif /* _UAPI_LINUX_WATCH_QUEUE_H */


