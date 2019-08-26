Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF63B9C79B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfHZDQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDQV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:16:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73AF217F4;
        Mon, 26 Aug 2019 03:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789380;
        bh=D2J2yFbNfuX9EmYpsOlxL/yhHWHvzg/hw54VGoYgnN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pl6imcvKxaV3bep6DFK/+9RlMhgAZn6LLoDPEBksO06VfD6S8PaeLdwFkGJzLPob/
         KdcZS1riYtxTSx3BR4doPcddoz2Aw5kKTwG9AvseKeJ6wAJwZTNtW10XAxVmrftRAr
         KWPGkaLR1QL2zgW8MkUeonANezK7Swu703yRVv6g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
Subject: [RFC PATCH v3 03/19] skc: Add a boot setup routine from cmdline
Date:   Mon, 26 Aug 2019 12:16:13 +0900
Message-Id: <156678937345.21459.4178076251522180375.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a boot setup routine from cmdline option "skc=ADDR,SIZE".
Bootloader has to setup this cmdline option when it loads
the skc file on memory. The ADDR must be a physical address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    5 ++
 init/main.c                                     |   54 +++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 47d981a86e2f..9a955b1bd1bf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4273,6 +4273,11 @@
 	simeth=		[IA-64]
 	simscsi=
 
+	skc=paddr,size	[SKC]
+			Pass the physical memory address and size of loaded
+			supplemental kernel cmdline (SKC) text. This will
+			be treated by bootloader which loads the SKC file.
+
 	slram=		[HW,MTD]
 
 	slab_nomerge	[MM]
diff --git a/init/main.c b/init/main.c
index 96f8d5af52d6..d06eb3d63b77 100644
--- a/init/main.c
+++ b/init/main.c
@@ -36,6 +36,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/start_kernel.h>
 #include <linux/security.h>
+#include <linux/skc.h>
 #include <linux/smp.h>
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
@@ -245,6 +246,58 @@ static int __init loglevel(char *str)
 
 early_param("loglevel", loglevel);
 
+#ifdef CONFIG_SKC
+__initdata unsigned long initial_skc;
+__initdata unsigned long initial_skc_len;
+
+static int __init save_skc_address(char *str)
+{
+	char *p;
+
+	p = strchr(str, ',');
+	if (!p)
+		return -EINVAL;
+	*p++ = '\0';
+	/* First options should be physical address - int is not enough */
+	if (kstrtoul(str, 0, &initial_skc) < 0)
+		return -EINVAL;
+	if (kstrtoul(p, 0, &initial_skc_len) < 0)
+		return -EINVAL;
+	if (initial_skc_len > SKC_DATA_MAX)
+		return -E2BIG;
+	/* Reserve it for protection */
+	memblock_reserve(initial_skc, initial_skc_len);
+
+	return 0;
+}
+early_param("skc", save_skc_address);
+
+static void __init setup_skc(void)
+{
+	u32 size;
+	char *data, *copy;
+
+	if (!initial_skc)
+		return;
+
+	data = early_memremap(initial_skc, initial_skc_len);
+	size = initial_skc_len + 1;
+
+	copy = memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!copy) {
+		pr_err("Failed to allocate memory for structured kernel cmdline\n");
+		goto end;
+	}
+	memcpy(copy, data, initial_skc_len);
+	copy[size - 1] = '\0';
+
+	skc_init(copy);
+end:
+	early_memunmap(data, initial_skc_len);
+}
+#else
+#define setup_skc()	do { } while (0)
+#endif
 /* Change NUL term back to "=", to make "param" the whole string. */
 static int __init repair_env_string(char *param, char *val,
 				    const char *unused, void *arg)
@@ -596,6 +649,7 @@ asmlinkage __visible void __init start_kernel(void)
 	setup_arch(&command_line);
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
+	setup_skc();
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */

