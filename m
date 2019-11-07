Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0705FF2FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfKGNhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:37:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33352 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389214AbfKGNhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yk4Fme2qR40u01dzh8IXV2LRQ/vIde0BP8nVfbXES28=;
        b=Z2KBnuGd5ttWmyG2AoarmTopvJhlGxkTygfA2s2O28aWokNpf86WzZab4LoTnWiQcS/lON
        AYbRzlh7Qtp1979ROAoTFt6GRxPIN8svVIWNFXagvnfnkTdD3ZAfDIuHZQK5bZ6LxQW0e3
        +LTaWPf4XGVF674SeU0Dmtgn5sd7a7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-2lq6y3BHPFau8-4xuvlxEA-1; Thu, 07 Nov 2019 08:36:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C869E477;
        Thu,  7 Nov 2019 13:36:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC7D71001B09;
        Thu,  7 Nov 2019 13:36:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 10/14] Add a general,
 global device notification watch list [ver #2]
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
Date:   Thu, 07 Nov 2019 13:36:50 +0000
Message-ID: <157313381086.29677.359785772127517290.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2lq6y3BHPFau8-4xuvlxEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a general, global watch list that can be used for the posting of
device notification events, for such things as device attachment,
detachment and errors on sources such as block devices and USB devices.
This can be enabled with:

=09CONFIG_DEVICE_NOTIFICATIONS

To add a watch on this list, an event queue must be created and configured:

        pipe2(fds, O_NOTIFICATION_PIPE);
        ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

and then a watch can be placed upon it using a system call:

        watch_devices(fds[1], 12, 0);

Unless the application wants to receive all events, it should employ
appropriate filters.  For example, to receive just USB notifications, it
could do:

=09struct watch_notification_filter filter =3D {
=09=09.nr_filters =3D 1,
=09=09.filters =3D {
=09=09=09[0] =3D {
=09=09=09=09.type =3D WATCH_TYPE_USB_NOTIFY,
=09=09=09=09.subtype_filter[0] =3D UINT_MAX;
=09=09=09},
=09=09},
=09};
=09ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/watch_queue.rst               |   22 ++++++-
 arch/alpha/kernel/syscalls/syscall.tbl      |    1=20
 arch/arm/tools/syscall.tbl                  |    1=20
 arch/arm64/include/asm/unistd.h             |    2 -
 arch/arm64/include/asm/unistd32.h           |    2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |    1=20
 arch/m68k/kernel/syscalls/syscall.tbl       |    1=20
 arch/microblaze/kernel/syscalls/syscall.tbl |    1=20
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1=20
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1=20
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1=20
 arch/parisc/kernel/syscalls/syscall.tbl     |    1=20
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1=20
 arch/s390/kernel/syscalls/syscall.tbl       |    1=20
 arch/sh/kernel/syscalls/syscall.tbl         |    1=20
 arch/sparc/kernel/syscalls/syscall.tbl      |    1=20
 arch/x86/entry/syscalls/syscall_32.tbl      |    1=20
 arch/x86/entry/syscalls/syscall_64.tbl      |    1=20
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1=20
 drivers/base/Kconfig                        |    9 +++
 drivers/base/Makefile                       |    1=20
 drivers/base/watch.c                        |   90 +++++++++++++++++++++++=
++++
 include/linux/device.h                      |    7 ++
 include/linux/syscalls.h                    |    1=20
 include/uapi/asm-generic/unistd.h           |    4 +
 kernel/sys_ni.c                             |    1=20
 26 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100644 drivers/base/watch.c

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index d8f70282d247..ed592700be0e 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -223,6 +223,25 @@ The ``id`` is the ID of the source object (such as the=
 serial number on a key).
 Only watches that have the same ID set in them will see this notification.
=20
=20
+Global Device Watch List
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+There is a global watch list that hardware generated events, such as devic=
e
+connection, disconnection, failure and error can be posted upon.  It must =
be
+enabled using::
+
+=09CONFIG_DEVICE_NOTIFICATIONS
+
+Watchpoints are set in userspace using the device_notify(2) system call.
+Within the kernel events are posted upon it using::
+
+=09void post_device_notification(struct watch_notification *n, u64 id);
+
+where ``n`` is the formatted notification record to post.  ``id`` is an
+identifier that can be used to direct to specific watches, but it should b=
e 0
+for general use on this queue.
+
+
 Watch Sources
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -238,7 +257,8 @@ Any particular buffer can be fed from multiple sources.=
  Sources include:
   * WATCH_TYPE_BLOCK_NOTIFY
=20
     Notifications of this type indicate block layer events, such as I/O er=
rors
-    or temporary link loss.  Watches of this type are set on a global queu=
e.
+    or temporary link loss.  Watches of this type are set on the global de=
vice
+    watch list.
=20
=20
 Event Filtering
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/sys=
calls/syscall.tbl
index 728fe028c02c..8e841d8e4c22 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 543=09common=09fspick=09=09=09=09sys_fspick
 544=09common=09pidfd_open=09=09=09sys_pidfd_open
 # 545 reserved for clone3
+546=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 6da7dc4d79cc..0f080cf44cc9 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -449,3 +449,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 435=09common=09clone3=09=09=09=09sys_clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unist=
d.h
index 2629a68b8724..368761302768 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls=09=09(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END=09=09(__ARM_NR_COMPAT_BASE + 0x800)
=20
-#define __NR_compat_syscalls=09=09436
+#define __NR_compat_syscalls=09=09437
 #endif
=20
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/uni=
std32.h
index 94ab29cf4f00..b5310789ce7a 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -879,6 +879,8 @@ __SYSCALL(__NR_fspick, sys_fspick)
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
+#define __NR_watch_devices 436
+__SYSCALL(__NR_watch_devices, sys_watch_devices)
=20
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/sysca=
lls/syscall.tbl
index 36d5faf4c86c..2f33f5db2fed 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -356,3 +356,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 # 435 reserved for clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/sysca=
lls/syscall.tbl
index a88a285a0e5f..83e4e8784b88 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -435,3 +435,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 # 435 reserved for clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/=
kernel/syscalls/syscall.tbl
index 09b0cd7dab0a..9a70a3be3b7b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 435=09common=09clone3=09=09=09=09sys_clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/s=
yscalls/syscall_n32.tbl
index e7c5ab38e403..b39527fc32c9 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -374,3 +374,4 @@
 433=09n32=09fspick=09=09=09=09sys_fspick
 434=09n32=09pidfd_open=09=09=09sys_pidfd_open
 435=09n32=09clone3=09=09=09=09__sys_clone3
+436=09n32=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/s=
yscalls/syscall_n64.tbl
index 13cd66581f3b..a7f0c5e71768 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -350,3 +350,4 @@
 433=09n64=09fspick=09=09=09=09sys_fspick
 434=09n64=09pidfd_open=09=09=09sys_pidfd_open
 435=09n64=09clone3=09=09=09=09__sys_clone3
+436=09n64=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/s=
yscalls/syscall_o32.tbl
index 353539ea4140..6f378288598c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -423,3 +423,4 @@
 433=09o32=09fspick=09=09=09=09sys_fspick
 434=09o32=09pidfd_open=09=09=09sys_pidfd_open
 435=09o32=09clone3=09=09=09=09__sys_clone3
+436=09o32=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/s=
yscalls/syscall.tbl
index 285ff516150c..b64bbafa5919 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 435=09common=09clone3=09=09=09=09sys_clone3_wrapper
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel=
/syscalls/syscall.tbl
index 43f736ed47f2..0a503239ab5c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 435=09nospu=09clone3=09=09=09=09ppc_clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sysca=
lls/syscall.tbl
index 3054e9c035a3..19b43c0d928a 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433  common=09fspick=09=09=09sys_fspick=09=09=09sys_fspick
 434  common=09pidfd_open=09=09sys_pidfd_open=09=09=09sys_pidfd_open
 435  common=09clone3=09=09=09sys_clone3=09=09=09sys_clone3
+436  common=09watch_devices=09=09sys_watch_devices=09=09sys_watch_devices
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/=
syscall.tbl
index b5ed26c4c005..b454e07c9372 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 # 435 reserved for clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/sys=
calls/syscall.tbl
index 8c8cc7537fb2..8ef43c27457e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 # 435 reserved for clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscal=
ls/syscall_32.tbl
index 3fe02546aed3..9b225c0d5240 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -440,3 +440,4 @@
 433=09i386=09fspick=09=09=09sys_fspick=09=09=09__ia32_sys_fspick
 434=09i386=09pidfd_open=09=09sys_pidfd_open=09=09=09__ia32_sys_pidfd_open
 435=09i386=09clone3=09=09=09sys_clone3=09=09=09__ia32_sys_clone3
+436=09i386=09watch_devices=09=09sys_watch_devices=09=09__ia32_sys_watch_de=
vices
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscal=
ls/syscall_64.tbl
index c29976eca4a8..29293d103829 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,7 @@
 433=09common=09fspick=09=09=09__x64_sys_fspick
 434=09common=09pidfd_open=09=09__x64_sys_pidfd_open
 435=09common=09clone3=09=09=09__x64_sys_clone3/ptregs
+436=09common=09watch_devices=09=09__x64_sys_watch_devices
=20
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/s=
yscalls/syscall.tbl
index 25f4de729a6d..243fa18b8d1e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -406,3 +406,4 @@
 433=09common=09fspick=09=09=09=09sys_fspick
 434=09common=09pidfd_open=09=09=09sys_pidfd_open
 435=09common=09clone3=09=09=09=09sys_clone3
+436=09common=09watch_devices=09=09=09sys_watch_devices
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 28b92e3cc570..e37d37684132 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "Generic Driver Options"
=20
+config DEVICE_NOTIFICATIONS
+=09bool "Provide device event notifications"
+=09depends on WATCH_QUEUE
+=09help
+=09  This option provides support for getting hardware event notifications
+=09  on devices, buses and interfaces.  This makes use of the
+=09  /dev/watch_queue misc device to handle the notification buffer.
+=09  device_notify(2) is used to set/remove watches.
+
 config UEVENT_HELPER
 =09bool "Support for uevent helper"
 =09help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 157452080f3d..4db2e8f1a1f4 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -7,6 +7,7 @@ obj-y=09=09=09:=3D component.o core.o bus.o dd.o syscore.o =
\
 =09=09=09   attribute_container.o transport_class.o \
 =09=09=09   topology.o container.o property.o cacheinfo.o \
 =09=09=09   devcon.o swnode.o
+obj-$(CONFIG_DEVICE_NOTIFICATIONS) +=3D watch.o
 obj-$(CONFIG_DEVTMPFS)=09+=3D devtmpfs.o
 obj-y=09=09=09+=3D power/
 obj-$(CONFIG_ISA_BUS_API)=09+=3D isa.o
diff --git a/drivers/base/watch.c b/drivers/base/watch.c
new file mode 100644
index 000000000000..725aaa24275b
--- /dev/null
+++ b/drivers/base/watch.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Event notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/device.h>
+#include <linux/watch_queue.h>
+#include <linux/syscalls.h>
+#include <linux/init_task.h>
+#include <linux/security.h>
+
+/*
+ * Global queue for watching for device layer events.
+ */
+static struct watch_list device_watchers =3D {
+=09.watchers=09=3D HLIST_HEAD_INIT,
+=09.lock=09=09=3D __SPIN_LOCK_UNLOCKED(&device_watchers.lock),
+};
+
+static DEFINE_SPINLOCK(device_watchers_lock);
+
+/**
+ * post_device_notification - Post notification of a device event
+ * @n - The notification to post
+ * @id - The device ID
+ *
+ * Note that there's only a global queue to which all events are posted.  =
Might
+ * want to provide per-dev queues also.
+ */
+void post_device_notification(struct watch_notification *n, u64 id)
+{
+=09post_watch_notification(&device_watchers, n, &init_cred, id);
+}
+EXPORT_SYMBOL(post_device_notification);
+
+/**
+ * sys_watch_devices - Watch for device events.
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove =
watch)
+ * @flags: Flags (reserved for future)
+ */
+SYSCALL_DEFINE3(watch_devices, int, watch_fd, int, watch_id, unsigned int,=
 flags)
+{
+=09struct watch_queue *wqueue;
+=09struct watch *watch =3D NULL;
+=09long ret =3D -ENOMEM;
+
+=09if (watch_id < -1 || watch_id > 0xff || flags)
+=09=09return -EINVAL;
+
+=09wqueue =3D get_watch_queue(watch_fd);
+=09if (IS_ERR(wqueue)) {
+=09=09ret =3D PTR_ERR(wqueue);
+=09=09goto err;
+=09}
+
+=09if (watch_id >=3D 0) {
+=09=09watch =3D kzalloc(sizeof(*watch), GFP_KERNEL);
+=09=09if (!watch)
+=09=09=09goto err_wqueue;
+
+=09=09init_watch(watch, wqueue);
+=09=09watch->info_id =3D (u32)watch_id << WATCH_INFO_ID__SHIFT;
+
+=09=09ret =3D security_watch_devices();
+=09=09if (ret < 0)
+=09=09=09goto err_watch;
+
+=09=09spin_lock(&device_watchers_lock);
+=09=09ret =3D add_watch_to_object(watch, &device_watchers);
+=09=09spin_unlock(&device_watchers_lock);
+=09=09if (ret =3D=3D 0)
+=09=09=09watch =3D NULL;
+=09} else {
+=09=09spin_lock(&device_watchers_lock);
+=09=09ret =3D remove_watch_from_object(&device_watchers, wqueue, 0,
+=09=09=09=09=09       false);
+=09=09spin_unlock(&device_watchers_lock);
+=09}
+
+err_watch:
+=09kfree(watch);
+err_wqueue:
+=09put_watch_queue(wqueue);
+err:
+=09return ret;
+}
diff --git a/include/linux/device.h b/include/linux/device.h
index 297239a08bb7..f30e80185825 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -43,6 +43,7 @@ struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
 struct iommu_param;
+struct watch_notification;
=20
 struct bus_attribute {
 =09struct attribute=09attr;
@@ -1654,6 +1655,12 @@ struct device_link *device_link_add(struct device *c=
onsumer,
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
=20
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+extern void post_device_notification(struct watch_notification *n, u64 id)=
;
+#else
+static inline void post_device_notification(struct watch_notification *n, =
u64 id) {}
+#endif
+
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f7c561c4dcdd..565f033a61bc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1000,6 +1000,7 @@ asmlinkage long sys_fspick(int dfd, const char __user=
 *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 =09=09=09=09       siginfo_t __user *info,
 =09=09=09=09       unsigned int flags);
+asmlinkage long sys_watch_devices(int watch_fd, int watch_id, unsigned int=
 flags);
=20
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/u=
nistd.h
index 1fc8faa6e973..4794d3c2afd7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,9 +850,11 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
+#define __NR_watch_devices 436
+__SYSCALL(__NR_watch_devices, sys_watch_devices)
=20
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 437
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 34b76895b81e..184ad68c087f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
+COND_SYSCALL(watch_devices);
=20
 /* fs/xattr.c */
=20

