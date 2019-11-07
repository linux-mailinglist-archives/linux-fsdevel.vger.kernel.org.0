Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B8F2F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfKGNfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:35:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32376 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388454AbfKGNfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OMjhGzW+oqRfUvod1CP0LB9hBdvEfkSHhab7TjBDcY=;
        b=dRTjHpkaUM2uMdhsenOT43WeR5LEofJdChHIYiI8AGRZ8WJoTPWIiwxcR7JatngqvqwfOr
        Gpu7VbHVr8VP5JC/fKdxcyI7mzR6jxng6AvTBKhtq1N4BVqV2grQtX7rXhOChCG8lMhLmh
        17Kz2h//XXCCRa1qtc4wSHmdwY0qYp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-8gztBEgTOqirunCmlnhH9A-1; Thu, 07 Nov 2019 08:35:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50CEE8017DD;
        Thu,  7 Nov 2019 13:35:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AAAC608B2;
        Thu,  7 Nov 2019 13:35:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 01/14] uapi: General notification queue definitions [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:35:26 +0000
Message-ID: <157313372658.29677.3710868015853027530.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8gztBEgTOqirunCmlnhH9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

=09- WATCH_INFO_LENGTH.  The size of the entry (entries are variable
          length).

=09- WATCH_INFO_ID.  The watch ID specified when the watchpoint was
          set.

=09- WATCH_INFO_TYPE_INFO.  (Sub)type-specific information.

=09- WATCH_INFO_FLAG_*.  Flag bits overlain on the type-specific
          information.  For use by the type.

     All the information in the header can be used in filtering messages at
     the point of writing into the buffer.

 (*) struct watch_notification_removal

     This is an extended watch-removal notification record that includes an
     'id' field that can indicate the identifier of the object being
     removed if available (for instance, a keyring serial number).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/watch_queue.h |   55 ++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/uapi/linux/watch_queue.h

diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_qu=
eue.h
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
+=09WATCH_TYPE_META=09=09=3D 0,=09/* Special record */
+=09WATCH_TYPE__NR=09=09=3D 1
+};
+
+enum watch_meta_notification_subtype {
+=09WATCH_META_REMOVAL_NOTIFICATION=09=3D 0,=09/* Watched object was remove=
d */
+=09WATCH_META_LOSS_NOTIFICATION=09=3D 1,=09/* Data loss occurred */
+};
+
+/*
+ * Notification record header.  This is aligned to 64-bits so that subclas=
ses
+ * can contain __u64 fields.
+ */
+struct watch_notification {
+=09__u32=09=09=09type:24;=09/* enum watch_notification_type */
+=09__u32=09=09=09subtype:8;=09/* Type-specific subtype (filterable) */
+=09__u32=09=09=09info;
+#define WATCH_INFO_LENGTH=090x0000007f=09/* Length of record */
+#define WATCH_INFO_LENGTH__SHIFT 0
+#define WATCH_INFO_ID=09=090x0000ff00=09/* ID of watchpoint */
+#define WATCH_INFO_ID__SHIFT=098
+#define WATCH_INFO_TYPE_INFO=090xffff0000=09/* Type-specific info */
+#define WATCH_INFO_TYPE_INFO__SHIFT 16
+#define WATCH_INFO_FLAG_0=090x00010000=09/* Type-specific info, flag bit 0=
 */
+#define WATCH_INFO_FLAG_1=090x00020000=09/* ... */
+#define WATCH_INFO_FLAG_2=090x00040000
+#define WATCH_INFO_FLAG_3=090x00080000
+#define WATCH_INFO_FLAG_4=090x00100000
+#define WATCH_INFO_FLAG_5=090x00200000
+#define WATCH_INFO_FLAG_6=090x00400000
+#define WATCH_INFO_FLAG_7=090x00800000
+};
+
+
+/*
+ * Extended watch removal notification.  This is used optionally if the ty=
pe
+ * wants to indicate an identifier for the object being watched, if there =
is
+ * such.  This can be distinguished by the length.
+ *
+ * type -> WATCH_TYPE_META
+ * subtype -> WATCH_META_REMOVAL_NOTIFICATION
+ */
+struct watch_notification_removal {
+=09struct watch_notification watch;
+=09__u64=09id;=09=09/* Type-dependent identifier */
+};
+
+#endif /* _UAPI_LINUX_WATCH_QUEUE_H */

