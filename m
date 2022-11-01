Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D8614B52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKANEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 09:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKANEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:04:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82712D16;
        Tue,  1 Nov 2022 06:04:32 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667307870;
        bh=WKsfKfXzkJWoJQvD09hXFWT3kjqAmgF8ogC0a2yCnWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eFp+gYnvUzd555IsQfvG45RQND3MuvtWYUdXrThDC7n0XGhkngGCdL3imHyi+so6p
         EEUk9n8nYaH+kaGjALVrj02IJzSbz+pqN3jGnqpn+QmZAZImHdsgNrUcmppmfWi8/g
         uMSVFkN+F1YIQ3kmsisp3d9PqkaFsJgLgyXCI2wg=
To:     linux-fsdevel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] proc: add byteorder file
Date:   Tue,  1 Nov 2022 14:04:01 +0100
Message-Id: <20221101130401.1841-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667307838; l=2910; s=20211113; h=from:subject; bh=WKsfKfXzkJWoJQvD09hXFWT3kjqAmgF8ogC0a2yCnWQ=; b=uDOy06fc7qHj8VYikcsRGtc3ggGiSSQhV5XQOrXFXXlgF8OEaJAZgZmGxu3CNyT2U5oPwJvfhNRX FG8dV0gcCgTQyakBKLbyUCJkDZVHqB+XmBPb+OPLhNp7s+GakK1N
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

Certain files in procfs are formatted in byteorder dependent ways. For
example the IP addresses in /proc/net/udp.

Assuming the byteorder of the userspace program is not guaranteed to be
correct in the face of emulation as for example with qemu-user.

Also this makes it easier for non-compiled applications like
shellscripts to discover the byteorder.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Development of userspace part: https://github.com/util-linux/util-linux/pull/1872

v1: https://lore.kernel.org/lkml/20221101005043.1791-1-linux@weissschuh.net/
v1->v2:
  * Move file to /sys/kernel/byteorder
---
 .../ABI/testing/sysfs-kernel-byteorder         | 12 ++++++++++++
 kernel/ksysfs.c                                | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-byteorder

diff --git a/Documentation/ABI/testing/sysfs-kernel-byteorder b/Documentation/ABI/testing/sysfs-kernel-byteorder
new file mode 100644
index 000000000000..4c45016d78ae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-byteorder
@@ -0,0 +1,12 @@
+What:		/sys/kernel/byteorder
+Date:		February 2023
+KernelVersion:	6.2
+Contact:	linux-fsdevel@vger.kernel.org
+Description:
+		The current endianness of the running kernel.
+
+		Access: Read
+
+		Valid values:
+			"little", "big"
+Users:		util-linux
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 65dba9076f31..7c7cb2c96ac0 100644
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
+#define BYTEORDER_STRING	"little"
+#elif defined(__BIG_ENDIAN)
+#define BYTEORDER_STRING	"big"
+#else
+#error Unknown byteorder
+#endif
+
 #define KERNEL_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
@@ -34,6 +43,14 @@ static ssize_t uevent_seqnum_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
+/* kernel byteorder */
+static ssize_t byteorder_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", BYTEORDER_STRING);
+}
+KERNEL_ATTR_RO(byteorder);
+
 #ifdef CONFIG_UEVENT_HELPER
 /* uevent helper program, used during early boot */
 static ssize_t uevent_helper_show(struct kobject *kobj,
@@ -215,6 +232,7 @@ EXPORT_SYMBOL_GPL(kernel_kobj);
 static struct attribute * kernel_attrs[] = {
 	&fscaps_attr.attr,
 	&uevent_seqnum_attr.attr,
+	&byteorder_attr.attr,
 #ifdef CONFIG_UEVENT_HELPER
 	&uevent_helper_attr.attr,
 #endif

base-commit: 5aaef24b5c6d4246b2cac1be949869fa36577737
-- 
2.38.1

