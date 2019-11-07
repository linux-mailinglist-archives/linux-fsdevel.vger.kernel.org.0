Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F61F2FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbfKGNhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:37:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389241AbfKGNhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/51VGw2GKeHPn4cWg2v3V0SyyPYDlb+JKaMyrGHfhFc=;
        b=GMHXdQycpf32hntvO/QLt3suGHTFdTmNTqdlxxMHAIqpPw/iz/s9DXeeCgnU0h5IcHetGH
        V8tFQcg67gLBP7AUdnMQCXw2jCZZ9xIwoqE+ZAQfs/p8itm2F1KwinQJbCZN+84Izddl4A
        GhFMrbfS8QNvjJeX5CViyW3gZEsO0jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-VQleoJrRORuRgKYw-DZaNg-1; Thu, 07 Nov 2019 08:37:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAE91005500;
        Thu,  7 Nov 2019 13:37:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEBD41001B09;
        Thu,  7 Nov 2019 13:37:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 11/14] block: Add block layer notifications [ver #2]
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
Date:   Thu, 07 Nov 2019 13:37:00 +0000
Message-ID: <157313382004.29677.14535762370731716841.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VQleoJrRORuRgKYw-DZaNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a block layer notification mechanism whereby notifications about
block-layer events such as I/O errors, can be reported to a monitoring
process asynchronously.

Firstly, an event queue needs to be created:

=09pipe2(fds, O_NOTIFICATION_PIPE);
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

then a notification can be set up to report block notifications via that
queue:

=09struct watch_notification_filter filter =3D {
=09=09.nr_filters =3D 1,
=09=09.filters =3D {
=09=09=09[0] =3D {
=09=09=09=09.type =3D WATCH_TYPE_BLOCK_NOTIFY,
=09=09=09=09.subtype_filter[0] =3D UINT_MAX;
=09=09=09},
=09=09},
=09};
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
=09watch_devices(fds[1], 12);

After that, records will be placed into the queue when, for example, errors
occur on a block device.  Records are of the following format:

=09struct block_notification {
=09=09struct watch_notification watch;
=09=09__u64=09dev;
=09=09__u64=09sector;
=09} *n;

Where:

=09n->watch.type will be WATCH_TYPE_BLOCK_NOTIFY

=09n->watch.subtype will be the type of notification, such as
=09NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM.

=09n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
=09record.

=09n->watch.info & WATCH_INFO_ID will be the second argument to
=09watch_devices(), shifted.

=09n->dev will be the device numbers munged together.

=09n->sector will indicate the affected sector (if appropriate for the
=09event).

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst    |    4 +++-
 block/Kconfig                    |    9 +++++++++
 block/blk-core.c                 |   29 ++++++++++++++++++++++++++++
 include/linux/blkdev.h           |   15 ++++++++++++++
 include/uapi/linux/watch_queue.h |   30 ++++++++++++++++++++++++++++-
 samples/watch_queue/watch_test.c |   40 ++++++++++++++++++++++++++++++++++=
+++-
 6 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index ed592700be0e..f2299f631ae8 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -8,7 +8,9 @@ opened by userspace.  This can be used in conjunction with:=
:
=20
   * Key/keyring notifications
=20
-  * General device event notifications
+  * General device event notifications, including::
+
+    * Block layer event notifications
=20
=20
 The notifications buffers can be enabled by:
diff --git a/block/Kconfig b/block/Kconfig
index 41c0917ce622..0906227a9431 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -177,6 +177,15 @@ config BLK_SED_OPAL
 =09Enabling this option enables users to setup/unlock/lock
 =09Locking ranges for SED devices using the Opal protocol.
=20
+config BLK_NOTIFICATIONS
+=09bool "Block layer event notifications"
+=09depends on DEVICE_NOTIFICATIONS
+=09help
+=09  This option provides support for getting block layer event
+=09  notifications.  This makes use of the /dev/watch_queue misc device to
+=09  handle the notification buffer and provides the device_notify() syste=
m
+=09  call to enable/disable watches.
+
 menu "Partition Types"
=20
 source "block/partitions/Kconfig"
diff --git a/block/blk-core.c b/block/blk-core.c
index d5e668ec751b..08e9b12ff5a5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -184,6 +184,22 @@ static const struct {
 =09[BLK_STS_IOERR]=09=09=3D { -EIO,=09"I/O" },
 };
=20
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static const
+enum block_notification_type blk_notifications[ARRAY_SIZE(blk_errors)] =3D=
 {
+=09[BLK_STS_TIMEOUT]=09=3D NOTIFY_BLOCK_ERROR_TIMEOUT,
+=09[BLK_STS_NOSPC]=09=09=3D NOTIFY_BLOCK_ERROR_NO_SPACE,
+=09[BLK_STS_TRANSPORT]=09=3D NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT,
+=09[BLK_STS_TARGET]=09=3D NOTIFY_BLOCK_ERROR_CRITICAL_TARGET,
+=09[BLK_STS_NEXUS]=09=09=3D NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS,
+=09[BLK_STS_MEDIUM]=09=3D NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM,
+=09[BLK_STS_PROTECTION]=09=3D NOTIFY_BLOCK_ERROR_PROTECTION,
+=09[BLK_STS_RESOURCE]=09=3D NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE,
+=09[BLK_STS_DEV_RESOURCE]=09=3D NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE,
+=09[BLK_STS_IOERR]=09=09=3D NOTIFY_BLOCK_ERROR_IO,
+};
+#endif
+
 blk_status_t errno_to_blk_status(int errno)
 {
 =09int i;
@@ -224,6 +240,19 @@ static void print_req_error(struct request *req, blk_s=
tatus_t status,
 =09=09req->cmd_flags & ~REQ_OP_MASK,
 =09=09req->nr_phys_segments,
 =09=09IOPRIO_PRIO_CLASS(req->ioprio));
+
+#ifdef CONFIG_BLK_NOTIFICATIONS
+=09if (blk_notifications[idx]) {
+=09=09struct block_notification n =3D {
+=09=09=09.watch.type=09=3D WATCH_TYPE_BLOCK_NOTIFY,
+=09=09=09.watch.subtype=09=3D blk_notifications[idx],
+=09=09=09.watch.info=09=3D watch_sizeof(n),
+=09=09=09.dev=09=09=3D req->rq_disk ? disk_devt(req->rq_disk) : 0,
+=09=09=09.sector=09=09=3D blk_rq_pos(req),
+=09=09};
+=09=09post_block_notification(&n);
+=09}
+#endif
 }
=20
 static void req_bio_endio(struct request *rq, struct bio *bio,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3ea78b0c91c..477472c11815 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,6 +27,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
+#include <linux/watch_queue.h>
=20
 struct module;
 struct scsi_ioctl_command;
@@ -1773,6 +1774,20 @@ static inline bool blk_req_can_dispatch_to_zone(stru=
ct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
=20
+#ifdef CONFIG_BLK_NOTIFICATIONS
+static inline void post_block_notification(struct block_notification *n)
+{
+=09u64 id =3D 0; /* Might want to allow dev# here. */
+
+=09post_device_notification(&n->watch, id);
+}
+#else
+static inline void post_block_notification(struct block_notification *n)
+{
+}
+#endif
+
+
 #else /* CONFIG_BLOCK */
=20
 struct block_device;
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_qu=
eue.h
index c3d8320b5d3a..557771413242 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@
 enum watch_notification_type {
 =09WATCH_TYPE_META=09=09=3D 0,=09/* Special record */
 =09WATCH_TYPE_KEY_NOTIFY=09=3D 1,=09/* Key change event notification */
-=09WATCH_TYPE__NR=09=09=3D 2
+=09WATCH_TYPE_BLOCK_NOTIFY=09=3D 2,=09/* Block layer event notification */
+=09WATCH_TYPE__NR=09=09=3D 3
 };
=20
 enum watch_meta_notification_subtype {
@@ -101,4 +102,31 @@ struct key_notification {
 =09__u32=09aux;=09=09/* Per-type auxiliary data */
 };
=20
+/*
+ * Type of block layer notification.
+ */
+enum block_notification_type {
+=09NOTIFY_BLOCK_ERROR_TIMEOUT=09=09=3D 1, /* Timeout error */
+=09NOTIFY_BLOCK_ERROR_NO_SPACE=09=09=3D 2, /* Critical space allocation er=
ror */
+=09NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT =3D 3, /* Recoverable transpor=
t error */
+=09NOTIFY_BLOCK_ERROR_CRITICAL_TARGET=09=3D 4, /* Critical target error */
+=09NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS=09=3D 5, /* Critical nexus error */
+=09NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM=09=3D 6, /* Critical medium error */
+=09NOTIFY_BLOCK_ERROR_PROTECTION=09=09=3D 7, /* Protection error */
+=09NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE=09=3D 8, /* Kernel resource error */
+=09NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE=09=3D 9, /* Device resource error */
+=09NOTIFY_BLOCK_ERROR_IO=09=09=09=3D 10, /* Other I/O error */
+};
+
+/*
+ * Block layer notification record.
+ * - watch.type =3D WATCH_TYPE_BLOCK_NOTIFY
+ * - watch.subtype =3D enum block_notification_type
+ */
+struct block_notification {
+=09struct watch_notification watch; /* WATCH_TYPE_BLOCK_NOTIFY */
+=09__u64=09dev;=09=09=09/* Device number */
+=09__u64=09sector;=09=09=09/* Affected sector */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_t=
est.c
index 58e826109ecc..55879531a7d5 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -58,6 +58,32 @@ static void saw_key_change(struct watch_notification *n,=
 size_t len)
 =09       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
 }
=20
+static const char *block_subtypes[256] =3D {
+=09[NOTIFY_BLOCK_ERROR_TIMEOUT]=09=09=09=3D "timeout",
+=09[NOTIFY_BLOCK_ERROR_NO_SPACE]=09=09=09=3D "critical space allocation",
+=09[NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT]=09=3D "recoverable transport=
",
+=09[NOTIFY_BLOCK_ERROR_CRITICAL_TARGET]=09=09=3D "critical target",
+=09[NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS]=09=09=3D "critical nexus",
+=09[NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM]=09=09=3D "critical medium",
+=09[NOTIFY_BLOCK_ERROR_PROTECTION]=09=09=09=3D "protection",
+=09[NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE]=09=09=3D "kernel resource",
+=09[NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE]=09=09=3D "device resource",
+=09[NOTIFY_BLOCK_ERROR_IO]=09=09=09=09=3D "I/O",
+};
+
+static void saw_block_change(struct watch_notification *n, size_t len)
+{
+=09struct block_notification *b =3D (struct block_notification *)n;
+
+=09if (len < sizeof(struct block_notification))
+=09=09return;
+
+=09printf("BLOCK %08llx e=3D%u[%s] s=3D%llx\n",
+=09       (unsigned long long)b->dev,
+=09       n->subtype, block_subtypes[n->subtype],
+=09       (unsigned long long)b->sector);
+}
+
 /*
  * Consume and display events.
  */
@@ -131,6 +157,9 @@ static void consumer(int fd)
 =09=09=09case WATCH_TYPE_KEY_NOTIFY:
 =09=09=09=09saw_key_change(&n.n, len);
 =09=09=09=09break;
+=09=09=09case WATCH_TYPE_BLOCK_NOTIFY:
+=09=09=09=09saw_block_change(&n.n, len);
+=09=09=09=09break;
 =09=09=09default:
 =09=09=09=09printf("other type\n");
 =09=09=09=09break;
@@ -142,12 +171,16 @@ static void consumer(int fd)
 }
=20
 static struct watch_notification_filter filter =3D {
-=09.nr_filters=09=3D 1,
+=09.nr_filters=09=3D 2,
 =09.filters =3D {
 =09=09[0]=09=3D {
 =09=09=09.type=09=09=09=3D WATCH_TYPE_KEY_NOTIFY,
 =09=09=09.subtype_filter[0]=09=3D UINT_MAX,
 =09=09},
+=09=09[1]=09=3D {
+=09=09=09.type=09=09=09=3D WATCH_TYPE_BLOCK_NOTIFY,
+=09=09=09.subtype_filter[0]=09=3D UINT_MAX,
+=09=09},
 =09},
 };
=20
@@ -181,6 +214,11 @@ int main(int argc, char **argv)
 =09=09exit(1);
 =09}
=20
+=09if (syscall(__NR_watch_devices, fd, 0x04, 0) =3D=3D -1) {
+=09=09perror("watch_devices");
+=09=09exit(1);
+=09}
+
 =09consumer(fd);
 =09exit(0);
 }

