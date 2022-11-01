Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3C6614278
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 02:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiKABAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 21:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKABAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:00:20 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 18:00:19 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413815A08;
        Mon, 31 Oct 2022 18:00:19 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667263848;
        bh=Ih90hSMCFhO4YPLOJxjstP2DevM5oYaVVK0RDWXWhYg=;
        h=From:To:Cc:Subject:Date:From;
        b=O/4Tj3Ph8aPMokTeCF6TyJh/9doYb5U8tHjzpNMIHVlpYQExOYj+O/4hF24zl4Xwi
         j+FLb5XWcQzj3Tot8qjkhc8xXFMzEoSkKoEsuIQWUm+Lf5J50GP9ml7N+QSf5GgQdg
         VLIFxOVDWEU4AE19Y5zvszGqq9TGgZca5S/vp6FA=
To:     linux-fsdevel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org
Subject: [PATCH] proc: add byteorder file
Date:   Tue,  1 Nov 2022 01:50:43 +0100
Message-Id: <20221101005043.1791-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667263841; l=2700; s=20211113; h=from:subject; bh=Ih90hSMCFhO4YPLOJxjstP2DevM5oYaVVK0RDWXWhYg=; b=Ta7OQLIgmKOBb7EZY2QPbltIZD7sna9NOI3okgEls+PXyJZ0SW4d/Fqo9VrpHPnvcVZo01r0UfIT C3PCBmz9BZbSEDfzLd6HWYdcD+gaAijlsR47TNuB2GCTo27UDfTb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 Documentation/ABI/testing/procfs-byteorder | 12 +++++++++
 fs/proc/Makefile                           |  1 +
 fs/proc/byteorder.c                        | 31 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/procfs-byteorder
 create mode 100644 fs/proc/byteorder.c

diff --git a/Documentation/ABI/testing/procfs-byteorder b/Documentation/ABI/testing/procfs-byteorder
new file mode 100644
index 000000000000..bb80aae889be
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-byteorder
@@ -0,0 +1,12 @@
+What:		/proc/byteorder
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
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..c790d3665358 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -12,6 +12,7 @@ proc-$(CONFIG_MMU)	:= task_mmu.o
 proc-y       += inode.o root.o base.o generic.o array.o \
 		fd.o
 proc-$(CONFIG_TTY)      += proc_tty.o
+proc-y	+= byteorder.o
 proc-y	+= cmdline.o
 proc-y	+= consoles.o
 proc-y	+= cpuinfo.o
diff --git a/fs/proc/byteorder.c b/fs/proc/byteorder.c
new file mode 100644
index 000000000000..39644b281da9
--- /dev/null
+++ b/fs/proc/byteorder.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/byteorder.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+#if defined(__LITTLE_ENDIAN)
+#define BYTEORDER_STRING	"little"
+#elif defined(__BIG_ENDIAN)
+#define BYTEORDER_STRING	"big"
+#else
+#error Unknown byteorder
+#endif
+
+static int byteorder_seq_show(struct seq_file *seq, void *)
+{
+	seq_puts(seq, BYTEORDER_STRING "\n");
+	return 0;
+}
+
+static int __init proc_byteorder_init(void)
+{
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("byteorder", 0444, NULL, byteorder_seq_show);
+	pde_make_permanent(pde);
+	return 0;
+}
+fs_initcall(proc_byteorder_init);

base-commit: 5aaef24b5c6d4246b2cac1be949869fa36577737
-- 
2.38.1

