Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB36182D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiKCPaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiKCP3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:29:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97052167C4;
        Thu,  3 Nov 2022 08:29:14 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667489352;
        bh=PZByBmsOolWMq3HddyC3qa9xFMg1ubeZTofhZPwh6dU=;
        h=From:To:Cc:Subject:Date:From;
        b=UpfoN0634Tdc0FuIrNGCbUamoyuSTtDZbAwWz8a4BCoRn7haOurZLRe2Tdyf9QjHn
         UY5Bb+FCaVDRXVuQIDXIzGNlwYVV+aCniBlt6JUuMaAPUnVCl8TPiGZaGF94ScseXJ
         +txdOwwgFAPoNDH/ngArRZvvG+MJm/b4ZPp+zTDo=
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org
Subject: [PATCH v3] kernel/ksysfs.c: export kernel cpu byteorder
Date:   Thu,  3 Nov 2022 16:24:07 +0100
Message-Id: <20221103152407.3348-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667489045; l=3398; s=20211113; h=from:subject; bh=PZByBmsOolWMq3HddyC3qa9xFMg1ubeZTofhZPwh6dU=; b=v15hMi/ivTX5CWvpzMcrySqQJkPXO7/fXMBiavSMAxGqtvwsL8eF+Mp4fP0ecL1SX2Iwzmu4fohL FraMLAZ9DpcuMeJIWm+xwp7YEopLU1TeDLC3VXEdM/sZGLXRwIdj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Certain files in procfs are formatted in byteorder-dependent formats.
For example the IP addresses in /proc/net/udp.

When using emulation like qemu-user, applications are not guaranteed to
be using the same byteorder as the kernel.
Therefore the kernel needs to provide a way for applications to discover
the byteorder used in API-filesystems.
Using systemcalls is not enough because these are intercepted and
translated by the emulation.

Also this makes it easier for non-compiled applications like
shellscripts to discover the byteorder.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Development of userspace part: https://github.com/util-linux/util-linux/pull/1872

Changelog:

v1: https://lore.kernel.org/lkml/20221101005043.1791-1-linux@weissschuh.net/
v1->v2:
  * Move file to /sys/kernel/byteorder
v2: https://lore.kernel.org/lkml/20221101130401.1841-1-linux@weissschuh.net/
v2->v3:
  * Fix commit title to mention sysfs
  * Use explicit cpu_byteorder name
  * Use sysfs_emit
  * Use myself as Contact
  * Reword commit message
---
 .../ABI/testing/sysfs-kernel-cpu_byteorder     | 12 ++++++++++++
 kernel/ksysfs.c                                | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-cpu_byteorder

diff --git a/Documentation/ABI/testing/sysfs-kernel-cpu_byteorder b/Documentation/ABI/testing/sysfs-kernel-cpu_byteorder
new file mode 100644
index 000000000000..f0e6ac1b5356
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-cpu_byteorder
@@ -0,0 +1,12 @@
+What:		/sys/kernel/cpu_byteorder
+Date:		February 2023
+KernelVersion:	6.2
+Contact:	Thomas Weißschuh <linux@weissschuh.net>
+Description:
+		The endianness of the running kernel.
+
+		Access: Read
+
+		Valid values:
+			"little", "big"
+Users:		util-linux
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 65dba9076f31..2df00b789b90 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2004 Kay Sievers <kay.sievers@vrfy.org>
  */
 
+#include <asm/byteorder.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
@@ -20,6 +21,14 @@
 
 #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
 
+#if defined(__LITTLE_ENDIAN)
+#define CPU_BYTEORDER_STRING	"little"
+#elif defined(__BIG_ENDIAN)
+#define CPU_BYTEORDER_STRING	"big"
+#else
+#error Unknown byteorder
+#endif
+
 #define KERNEL_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
@@ -34,6 +43,14 @@ static ssize_t uevent_seqnum_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
+/* cpu byteorder */
+static ssize_t cpu_byteorder_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", CPU_BYTEORDER_STRING);
+}
+KERNEL_ATTR_RO(cpu_byteorder);
+
 #ifdef CONFIG_UEVENT_HELPER
 /* uevent helper program, used during early boot */
 static ssize_t uevent_helper_show(struct kobject *kobj,
@@ -215,6 +232,7 @@ EXPORT_SYMBOL_GPL(kernel_kobj);
 static struct attribute * kernel_attrs[] = {
 	&fscaps_attr.attr,
 	&uevent_seqnum_attr.attr,
+	&cpu_byteorder_attr.attr,
 #ifdef CONFIG_UEVENT_HELPER
 	&uevent_helper_attr.attr,
 #endif

base-commit: 8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a
-- 
2.38.1

