Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5606F2FB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfKGNgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:36:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389139AbfKGNge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1z889uf5iqfPf2RBBwr9KTe4Lv2y8mZXP1E1XgRLWSE=;
        b=hFnmrxyYpc7B/0g2eB75LYELX8C/zafQKxFCYgs/t2VheDcMJC1CZthjW/AHJEmAeRMG3m
        2cjsNAQQDtv6DtzAm4IwXzoQecNXWzNq2aSaQEVAjjEz1uub5BV7DPLoNsKpfTmsxTlcVK
        YjFfdFU1RqlDR4d4LtqXtYTgz44VSoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-wDIB_NiyOzigshJxDwFdSA-1; Thu, 07 Nov 2019 08:36:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FEC3107ACC3;
        Thu,  7 Nov 2019 13:36:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CAD8600D1;
        Thu,  7 Nov 2019 13:36:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 07/14] Add sample notification program [ver #2]
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
Date:   Thu, 07 Nov 2019 13:36:24 +0000
Message-ID: <157313378451.29677.3803723365602483685.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wDIB_NiyOzigshJxDwFdSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sample program is run like:

=09./samples/watch_queue/watch_test

and watches "/" for mount changes and the current session keyring for key
changes:

=09# keyctl add user a a @s
=091035096409
=09# keyctl unlink 1035096409 @s

producing:

=09# ./watch_test
=09read() =3D 16
=09NOTIFY[000]: ty=3D000001 sy=3D02 i=3D00000110
=09KEY 2ffc2e5d change=3D2[linked] aux=3D1035096409
=09read() =3D 16
=09NOTIFY[000]: ty=3D000001 sy=3D02 i=3D00000110
=09KEY 2ffc2e5d change=3D3[unlinked] aux=3D1035096409

Other events may be produced, such as with a failing disk:

=09read() =3D 22
=09NOTIFY[000]: ty=3D000003 sy=3D02 i=3D00000416
=09USB 3-7.7 dev-reset e=3D0 r=3D0
=09read() =3D 24
=09NOTIFY[000]: ty=3D000002 sy=3D06 i=3D00000418
=09BLOCK 00800050 e=3D6[critical medium] s=3D64000ef8

This corresponds to:

=09blk_update_request: critical medium error, dev sdf, sector 1677725432 op=
 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

in dmesg.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/Kconfig                  |    7 +
 samples/Makefile                 |    1=20
 samples/watch_queue/Makefile     |    7 +
 samples/watch_queue/watch_test.c |  183 ++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 198 insertions(+)
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c8dacb4dda80..d0761f29ccb0 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -169,4 +169,11 @@ config SAMPLE_VFS
 =09  as mount API and statx().  Note that this is restricted to the x86
 =09  arch whilst it accesses system calls that aren't yet in all arches.
=20
+config SAMPLE_WATCH_QUEUE
+=09bool "Build example /dev/watch_queue notification consumer"
+=09depends on HEADERS_INSTALL
+=09help
+=09  Build example userspace program to use the new mount_notify(),
+=09  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 7d6e4ca28d69..a61a39047d02 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SAMPLE_TRACE_PRINTK)=09+=3D trace_printk/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)=09+=3D v4l/
 obj-y=09=09=09=09=09+=3D vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)=09=09+=3D vfs
+subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)=09+=3D watch_queue
diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
new file mode 100644
index 000000000000..eec00dd0a8df
--- /dev/null
+++ b/samples/watch_queue/Makefile
@@ -0,0 +1,7 @@
+# List of programs to build
+hostprogs-y :=3D watch_test
+
+# Tell kbuild to always build the programs
+always :=3D $(hostprogs-y)
+
+HOSTCFLAGS_watch_test.o +=3D -I$(objtree)/usr/include
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_t=
est.c
new file mode 100644
index 000000000000..8925593bdb9b
--- /dev/null
+++ b/samples/watch_queue/watch_test.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Use /dev/watch_queue to watch for notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <limits.h>
+#include <linux/watch_queue.h>
+#include <linux/unistd.h>
+#include <linux/keyctl.h>
+
+#ifndef KEYCTL_WATCH_KEY
+#define KEYCTL_WATCH_KEY -1
+#endif
+#ifndef __NR_watch_devices
+#define __NR_watch_devices -1
+#endif
+
+#define BUF_SIZE 256
+
+static long keyctl_watch_key(int key, int watch_fd, int watch_id)
+{
+=09return syscall(__NR_keyctl, KEYCTL_WATCH_KEY, key, watch_fd, watch_id);
+}
+
+static const char *key_subtypes[256] =3D {
+=09[NOTIFY_KEY_INSTANTIATED]=09=3D "instantiated",
+=09[NOTIFY_KEY_UPDATED]=09=09=3D "updated",
+=09[NOTIFY_KEY_LINKED]=09=09=3D "linked",
+=09[NOTIFY_KEY_UNLINKED]=09=09=3D "unlinked",
+=09[NOTIFY_KEY_CLEARED]=09=09=3D "cleared",
+=09[NOTIFY_KEY_REVOKED]=09=09=3D "revoked",
+=09[NOTIFY_KEY_INVALIDATED]=09=3D "invalidated",
+=09[NOTIFY_KEY_SETATTR]=09=09=3D "setattr",
+};
+
+static void saw_key_change(struct watch_notification *n, size_t len)
+{
+=09struct key_notification *k =3D (struct key_notification *)n;
+
+=09if (len !=3D sizeof(struct key_notification)) {
+=09=09fprintf(stderr, "Incorrect key message length\n");
+=09=09return;
+=09}
+
+=09printf("KEY %08x change=3D%u[%s] aux=3D%u\n",
+=09       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
+}
+
+/*
+ * Consume and display events.
+ */
+static void consumer(int fd)
+{
+=09unsigned char buffer[4096], *p, *end;
+=09union {
+=09=09struct watch_notification n;
+=09=09unsigned char buf1[128];
+=09} n;
+=09ssize_t buf_len;
+
+=09for (;;) {
+=09=09buf_len =3D read(fd, buffer, sizeof(buffer));
+=09=09if (buf_len =3D=3D -1) {
+=09=09=09perror("read");
+=09=09=09exit(1);
+=09=09}
+
+=09=09if (buf_len =3D=3D 0) {
+=09=09=09printf("-- END --\n");
+=09=09=09return;
+=09=09}
+
+=09=09if (buf_len > sizeof(buffer)) {
+=09=09=09fprintf(stderr, "Read buffer overrun: %zd\n", buf_len);
+=09=09=09return;
+=09=09}
+
+=09=09printf("read() =3D %zd\n", buf_len);
+
+=09=09p =3D buffer;
+=09=09end =3D buffer + buf_len;
+=09=09while (p < end) {
+=09=09=09size_t largest, len;
+
+=09=09=09largest =3D end - p;
+=09=09=09if (largest > 128)
+=09=09=09=09largest =3D 128;
+=09=09=09if (largest < sizeof(struct watch_notification)) {
+=09=09=09=09fprintf(stderr, "Short message header: %zu\n", largest);
+=09=09=09=09return;
+=09=09=09}
+=09=09=09memcpy(&n, p, largest);
+
+=09=09=09printf("NOTIFY[%03zx]: ty=3D%06x sy=3D%02x i=3D%08x\n",
+=09=09=09       p - buffer, n.n.type, n.n.subtype, n.n.info);
+
+=09=09=09len =3D n.n.info & WATCH_INFO_LENGTH;
+=09=09=09if (len < sizeof(n.n) || len > largest) {
+=09=09=09=09fprintf(stderr, "Bad message length: %zu/%zu\n", len, largest)=
;
+=09=09=09=09exit(1);
+=09=09=09}
+
+=09=09=09switch (n.n.type) {
+=09=09=09case WATCH_TYPE_META:
+=09=09=09=09switch (n.n.subtype) {
+=09=09=09=09case WATCH_META_REMOVAL_NOTIFICATION:
+=09=09=09=09=09printf("REMOVAL of watchpoint %08x\n",
+=09=09=09=09=09       (n.n.info & WATCH_INFO_ID) >>
+=09=09=09=09=09       WATCH_INFO_ID__SHIFT);
+=09=09=09=09=09break;
+=09=09=09=09default:
+=09=09=09=09=09printf("other meta record\n");
+=09=09=09=09=09break;
+=09=09=09=09}
+=09=09=09=09break;
+=09=09=09case WATCH_TYPE_KEY_NOTIFY:
+=09=09=09=09saw_key_change(&n.n, len);
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09printf("other type\n");
+=09=09=09=09break;
+=09=09=09}
+
+=09=09=09p +=3D len;
+=09=09}
+=09}
+}
+
+static struct watch_notification_filter filter =3D {
+=09.nr_filters=09=3D 1,
+=09.filters =3D {
+=09=09[0]=09=3D {
+=09=09=09.type=09=09=09=3D WATCH_TYPE_KEY_NOTIFY,
+=09=09=09.subtype_filter[0]=09=3D UINT_MAX,
+=09=09},
+=09},
+};
+
+int main(int argc, char **argv)
+{
+=09int pipefd[2], fd;
+
+=09if (pipe2(pipefd, O_NOTIFICATION_PIPE) =3D=3D -1) {
+=09=09perror("pipe2");
+=09=09exit(1);
+=09}
+=09fd =3D pipefd[0];
+
+=09if (ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE) =3D=3D -1) {
+=09=09perror("/dev/watch_queue(size)");
+=09=09exit(1);
+=09}
+
+=09if (ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter) =3D=3D -1) {
+=09=09perror("/dev/watch_queue(filter)");
+=09=09exit(1);
+=09}
+
+=09if (keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01) =3D=3D -1) {
+=09=09perror("keyctl");
+=09=09exit(1);
+=09}
+
+=09if (keyctl_watch_key(KEY_SPEC_USER_KEYRING, fd, 0x02) =3D=3D -1) {
+=09=09perror("keyctl");
+=09=09exit(1);
+=09}
+
+=09consumer(fd);
+=09exit(0);
+}

