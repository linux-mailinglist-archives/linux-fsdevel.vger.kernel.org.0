Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956E5137223
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAJQDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgAJQDv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:03:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8B2720842;
        Fri, 10 Jan 2020 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672230;
        bh=p0Cgdke+HGwsbB9tjHNpY/Az6SEeslEnbeggEyNRMHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1t3mqZa3XK69CYxHdXrcZm5+xT+ZG/9GPXGWP27ySWjXEeV0pJMCjMbAY9l6frN1
         XwB/JlG5WgxBifRnIrHVpP4ElLPv8+QtpNYtNqkvAipRUtxwoEZ4P0voAalKCjkQvy
         Gu9mkkl8ARIrxqYVlai8SoauoWP8Dwd2JYSNGmso=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
Subject: [PATCH v6 02/22] bootconfig: Load boot config from the tail of initrd
Date:   Sat, 11 Jan 2020 01:03:44 +0900
Message-Id: <157867222435.17873.9936667353335606867.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
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
 init/Kconfig |    1 +
 init/main.c  |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
index 2cd736059416..59c418a57f92 100644
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
@@ -245,6 +246,58 @@ static int __init loglevel(char *str)
 
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
@@ -595,6 +648,7 @@ asmlinkage __visible void __init start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();

