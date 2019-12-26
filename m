Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1592712ACAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfLZOEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLZOET (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:04:19 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31AE12173E;
        Thu, 26 Dec 2019 14:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369059;
        bh=yDtyn0wt8SdQnMH8znPBvyxJVlZeo1IJYhgANzqwAO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyOPSm+8OPjagh45NG2uk2ralk8kzCAOmMwlk6K6sqilgq5u8lqQmW5hcI7nk6XKm
         Rpagf0GlnUyl8OxNr2HRtkoieW4Wi4lyZpr06Zurdso6ocHo01SLte9aqudXXBTC7u
         j3sF471sHcmuwlkCZ/tVMH27jYiwBysvAq/1aOeo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/22] bootconfig: Load boot config from the tail of initrd
Date:   Thu, 26 Dec 2019 23:04:13 +0900
Message-Id: <157736905283.11126.16391120901514076133.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157736902773.11126.2531161235817081873.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Load the extended boot config data from the tail of initrd
image. If there is an SKC data there, it has
[(u32)size][(u32)checksum] header (in really, this is a
footer) at the end of initrd. If the checksum (simple sum
of bytes) is match, this starts parsing it from there.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Rename skc to bootconfig.
---
 0 files changed

diff --git a/init/Kconfig b/init/Kconfig
index 63450d3bbf12..ffd240fb88c3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1217,6 +1217,7 @@ endif
 
 config BOOT_CONFIG
 	bool "Boot config support"
+	depends on BLK_DEV_INITRD
 	select LIBXBC
 	default y
 	help
diff --git a/init/main.c b/init/main.c
index 1ecfd43ed464..a47a95076405 100644
--- a/init/main.c
+++ b/init/main.c
@@ -28,6 +28,7 @@
 #include <linux/initrd.h>
 #include <linux/memblock.h>
 #include <linux/acpi.h>
+#include <linux/bootconfig.h>
 #include <linux/console.h>
 #include <linux/nmi.h>
 #include <linux/percpu.h>
@@ -246,6 +247,58 @@ static int __init loglevel(char *str)
 
 early_param("loglevel", loglevel);
 
+#ifdef CONFIG_BOOT_CONFIG
+u32 boot_config_checksum(unsigned char *p, u32 size)
+{
+	u32 ret = 0;
+
+	while (size--)
+		ret += *p++;
+
+	return ret;
+}
+
+static void __init setup_boot_config(void)
+{
+	u32 size, csum;
+	char *data, *copy;
+	u32 *hdr;
+
+	if (!initrd_end)
+		return;
+
+	hdr = (u32 *)(initrd_end - 8);
+	size = hdr[0];
+	csum = hdr[1];
+
+	if (size >= XBC_DATA_MAX)
+		return;
+
+	data = ((void *)hdr) - size;
+	if ((unsigned long)data < initrd_start)
+		return;
+
+	if (boot_config_checksum((unsigned char *)data, size) != csum)
+		return;
+
+	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
+	if (!copy) {
+		pr_err("Failed to allocate memory for boot config\n");
+		return;
+	}
+
+	memcpy(copy, data, size);
+	copy[size] = '\0';
+
+	if (xbc_init(copy) < 0)
+		pr_err("Failed to parse boot config\n");
+	else
+		pr_info("Load boot config: %d bytes\n", size);
+}
+#else
+#define setup_boot_config()	do { } while (0)
+#endif
+
 /* Change NUL term back to "=", to make "param" the whole string. */
 static int __init repair_env_string(char *param, char *val,
 				    const char *unused, void *arg)
@@ -596,6 +649,7 @@ asmlinkage __visible void __init start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();

