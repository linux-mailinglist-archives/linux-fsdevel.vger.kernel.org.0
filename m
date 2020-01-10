Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39C137226
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgAJQED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:04:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgAJQED (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:04:03 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391D22082E;
        Fri, 10 Jan 2020 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672241;
        bh=w8GbH37Ww6sYd/fGJ0byaorqotY6yBpQx1Hc6H9EMXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqNPMZOZtOHV+vQ4PzpjcYUXiWJTJ6ypNYcGuid9b9I8Gh3LO53HcRNOdrvMFbhIZ
         9J/rq4FQyXrGS2ZdkBvyreumOE1/cOavy5ye5SlmUu7zWu1yzLGMiTAWG6zOfOSrvX
         xW/nLNCllCsnOg0VIggEbai0EUI4TTthUSXUq/Qk=
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
Subject: [PATCH v6 03/22] tools: bootconfig: Add bootconfig command
Date:   Sat, 11 Jan 2020 01:03:56 +0900
Message-Id: <157867223582.17873.14342161849213219982.stgit@devnote2>
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

Add "bootconfig" command which operates the bootconfig
config-data on initrd image.

User can add/delete/verify the boot config on initrd
image using this command.

e.g.
Add a boot config to initrd image
 # bootconfig -a myboot.conf /boot/initrd.img

Remove it.
 # bootconfig -d /boot/initrd.img

Or verify (and show) it.
 # bootconfig /boot/initrd.img

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Fix memory leaks.
  - Fix to cleanup old bootconfig on memory before load new one.
  - Show applying message.
  - Suppress parse error with wrong data in initrd for delete_xbc().
 Changes in v5:
  - Fix Makefile to compile all C files always.
  - Remove unused pattern from Makefile.
---
 MAINTAINERS                                 |    1 
 tools/Makefile                              |   11 -
 tools/bootconfig/.gitignore                 |    1 
 tools/bootconfig/Makefile                   |   20 ++
 tools/bootconfig/include/linux/bootconfig.h |    7 +
 tools/bootconfig/include/linux/bug.h        |   12 +
 tools/bootconfig/include/linux/ctype.h      |    7 +
 tools/bootconfig/include/linux/errno.h      |    7 +
 tools/bootconfig/include/linux/kernel.h     |   18 +
 tools/bootconfig/include/linux/printk.h     |   17 +
 tools/bootconfig/include/linux/string.h     |   32 ++
 tools/bootconfig/main.c                     |  354 +++++++++++++++++++++++++++
 12 files changed, 482 insertions(+), 5 deletions(-)
 create mode 100644 tools/bootconfig/.gitignore
 create mode 100644 tools/bootconfig/Makefile
 create mode 100644 tools/bootconfig/include/linux/bootconfig.h
 create mode 100644 tools/bootconfig/include/linux/bug.h
 create mode 100644 tools/bootconfig/include/linux/ctype.h
 create mode 100644 tools/bootconfig/include/linux/errno.h
 create mode 100644 tools/bootconfig/include/linux/kernel.h
 create mode 100644 tools/bootconfig/include/linux/printk.h
 create mode 100644 tools/bootconfig/include/linux/string.h
 create mode 100644 tools/bootconfig/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ef065234cff..836209be1faa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15778,6 +15778,7 @@ M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
 F:	lib/bootconfig.c
 F:	include/linux/bootconfig.h
+F:	tools/bootconfig/*
 
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>
diff --git a/tools/Makefile b/tools/Makefile
index 7e42f7b8bfa7..bd778812e915 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -28,6 +28,7 @@ help:
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
+	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
@@ -63,7 +64,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging: FORCE
+cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -96,7 +97,7 @@ kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
 all: acpi cgroup cpupower gpio hv firewire liblockdep \
-		perf selftests spi turbostat usb \
+		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
 		pci debugging
@@ -107,7 +108,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
+cgroup_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -141,7 +142,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean:
+cgroup_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -176,7 +177,7 @@ build_clean:
 	$(call descend,build,clean)
 
 clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
-		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
+		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
diff --git a/tools/bootconfig/.gitignore b/tools/bootconfig/.gitignore
new file mode 100644
index 000000000000..e7644dfaa4a7
--- /dev/null
+++ b/tools/bootconfig/.gitignore
@@ -0,0 +1 @@
+bootconfig
diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
new file mode 100644
index 000000000000..681b7aef3e44
--- /dev/null
+++ b/tools/bootconfig/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for bootconfig command
+
+bindir ?= /usr/bin
+
+HEADER = include/linux/bootconfig.h
+CFLAGS = -Wall -g -I./include
+
+PROGS = bootconfig
+
+all: $(PROGS)
+
+bootconfig: ../../lib/bootconfig.c main.c $(HEADER)
+	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
+
+install: $(PROGS)
+	install bootconfig $(DESTDIR)$(bindir)
+
+clean:
+	$(RM) -f *.o bootconfig
diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
new file mode 100644
index 000000000000..078cbd2ba651
--- /dev/null
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BOOTCONFIG_LINUX_BOOTCONFIG_H
+#define _BOOTCONFIG_LINUX_BOOTCONFIG_H
+
+#include "../../../../include/linux/bootconfig.h"
+
+#endif
diff --git a/tools/bootconfig/include/linux/bug.h b/tools/bootconfig/include/linux/bug.h
new file mode 100644
index 000000000000..7b65a389c0dd
--- /dev/null
+++ b/tools/bootconfig/include/linux/bug.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_BUG_H
+#define _SKC_LINUX_BUG_H
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#define WARN_ON(cond)	\
+	((cond) ? printf("Internal warning(%s:%d, %s): %s\n",	\
+			__FILE__, __LINE__, __func__, #cond) : 0)
+
+#endif
diff --git a/tools/bootconfig/include/linux/ctype.h b/tools/bootconfig/include/linux/ctype.h
new file mode 100644
index 000000000000..c56ecc136448
--- /dev/null
+++ b/tools/bootconfig/include/linux/ctype.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_CTYPE_H
+#define _SKC_LINUX_CTYPE_H
+
+#include <ctype.h>
+
+#endif
diff --git a/tools/bootconfig/include/linux/errno.h b/tools/bootconfig/include/linux/errno.h
new file mode 100644
index 000000000000..5d9f91ec2fda
--- /dev/null
+++ b/tools/bootconfig/include/linux/errno.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_ERRNO_H
+#define _SKC_LINUX_ERRNO_H
+
+#include <asm/errno.h>
+
+#endif
diff --git a/tools/bootconfig/include/linux/kernel.h b/tools/bootconfig/include/linux/kernel.h
new file mode 100644
index 000000000000..2d93320aa374
--- /dev/null
+++ b/tools/bootconfig/include/linux/kernel.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_KERNEL_H
+#define _SKC_LINUX_KERNEL_H
+
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include <linux/printk.h>
+
+typedef unsigned short u16;
+typedef unsigned int   u32;
+
+#define unlikely(cond)	(cond)
+
+#define __init
+#define __initdata
+
+#endif
diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
new file mode 100644
index 000000000000..017bcd6912a5
--- /dev/null
+++ b/tools/bootconfig/include/linux/printk.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_PRINTK_H
+#define _SKC_LINUX_PRINTK_H
+
+#include <stdio.h>
+
+/* controllable printf */
+extern int pr_output;
+#define printk(fmt, ...)	\
+	(pr_output ? printf(fmt, __VA_ARGS__) : 0)
+
+#define pr_err printk
+#define pr_warn	printk
+#define pr_info	printk
+#define pr_debug printk
+
+#endif
diff --git a/tools/bootconfig/include/linux/string.h b/tools/bootconfig/include/linux/string.h
new file mode 100644
index 000000000000..8267af75153a
--- /dev/null
+++ b/tools/bootconfig/include/linux/string.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SKC_LINUX_STRING_H
+#define _SKC_LINUX_STRING_H
+
+#include <string.h>
+
+/* Copied from lib/string.c */
+static inline char *skip_spaces(const char *str)
+{
+	while (isspace(*str))
+		++str;
+	return (char *)str;
+}
+
+static inline char *strim(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end >= s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	return skip_spaces(s);
+}
+
+#endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
new file mode 100644
index 000000000000..66c8d47ceeea
--- /dev/null
+++ b/tools/bootconfig/main.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Boot config tool for initrd image
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include <linux/kernel.h>
+#include <linux/bootconfig.h>
+
+int pr_output = 1;
+
+static int xbc_show_array(struct xbc_node *node)
+{
+	const char *val;
+	int i = 0;
+
+	xbc_array_for_each_value(node, val) {
+		printf("\"%s\"%s", val, node->next ? ", " : ";\n");
+		i++;
+	}
+	return i;
+}
+
+static void xbc_show_compact_tree(void)
+{
+	struct xbc_node *node, *cnode;
+	int depth = 0, i;
+
+	node = xbc_root_node();
+	while (node && xbc_node_is_key(node)) {
+		for (i = 0; i < depth; i++)
+			printf("\t");
+		cnode = xbc_node_get_child(node);
+		while (cnode && xbc_node_is_key(cnode) && !cnode->next) {
+			printf("%s.", xbc_node_get_data(node));
+			node = cnode;
+			cnode = xbc_node_get_child(node);
+		}
+		if (cnode && xbc_node_is_key(cnode)) {
+			printf("%s {\n", xbc_node_get_data(node));
+			depth++;
+			node = cnode;
+			continue;
+		} else if (cnode && xbc_node_is_value(cnode)) {
+			printf("%s = ", xbc_node_get_data(node));
+			if (cnode->next)
+				xbc_show_array(cnode);
+			else
+				printf("\"%s\";\n", xbc_node_get_data(cnode));
+		} else {
+			printf("%s;\n", xbc_node_get_data(node));
+		}
+
+		if (node->next) {
+			node = xbc_node_get_next(node);
+			continue;
+		}
+		while (!node->next) {
+			node = xbc_node_get_parent(node);
+			if (!node)
+				return;
+			if (!xbc_node_get_child(node)->next)
+				continue;
+			depth--;
+			for (i = 0; i < depth; i++)
+				printf("\t");
+			printf("}\n");
+		}
+		node = xbc_node_get_next(node);
+	}
+}
+
+/* Simple real checksum */
+int checksum(unsigned char *buf, int len)
+{
+	int i, sum = 0;
+
+	for (i = 0; i < len; i++)
+		sum += buf[i];
+
+	return sum;
+}
+
+#define PAGE_SIZE	4096
+
+int load_xbc_fd(int fd, char **buf, int size)
+{
+	int ret;
+
+	*buf = malloc(size + 1);
+	if (!*buf)
+		return -ENOMEM;
+
+	ret = read(fd, *buf, size);
+	if (ret < 0)
+		return -errno;
+	(*buf)[size] = '\0';
+
+	return ret;
+}
+
+/* Return the read size or -errno */
+int load_xbc_file(const char *path, char **buf)
+{
+	struct stat stat;
+	int fd, ret;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	ret = fstat(fd, &stat);
+	if (ret < 0)
+		return -errno;
+
+	ret = load_xbc_fd(fd, buf, stat.st_size);
+
+	close(fd);
+
+	return ret;
+}
+
+int load_xbc_from_initrd(int fd, char **buf)
+{
+	struct stat stat;
+	int ret;
+	u32 size = 0, csum = 0, rcsum;
+
+	ret = fstat(fd, &stat);
+	if (ret < 0)
+		return -errno;
+
+	if (stat.st_size < 8)
+		return 0;
+
+	if (lseek(fd, -8, SEEK_END) < 0) {
+		printf("Faile to lseek: %d\n", -errno);
+		return -errno;
+	}
+
+	if (read(fd, &size, sizeof(u32)) < 0)
+		return -errno;
+
+	if (read(fd, &csum, sizeof(u32)) < 0)
+		return -errno;
+
+	/* Wrong size, maybe no boot config here */
+	if (stat.st_size < size + 8)
+		return 0;
+
+	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
+		printf("Faile to lseek: %d\n", -errno);
+		return -errno;
+	}
+
+	ret = load_xbc_fd(fd, buf, size);
+	if (ret < 0)
+		return ret;
+
+	/* Wrong Checksum, maybe no boot config here */
+	rcsum = checksum((unsigned char *)*buf, size);
+	if (csum != rcsum) {
+		printf("checksum error: %d != %d\n", csum, rcsum);
+		return 0;
+	}
+
+	ret = xbc_init(*buf);
+	/* Wrong data, maybe no boot config here */
+	if (ret < 0)
+		return 0;
+
+	return size;
+}
+
+int show_xbc(const char *path)
+{
+	int ret, fd;
+	char *buf = NULL;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		printf("Failed to open initrd %s: %d\n", path, fd);
+		return -errno;
+	}
+
+	ret = load_xbc_from_initrd(fd, &buf);
+	if (ret < 0)
+		printf("Failed to load a boot config from initrd: %d\n", ret);
+	else
+		xbc_show_compact_tree();
+
+	close(fd);
+	free(buf);
+
+	return ret;
+}
+
+int delete_xbc(const char *path)
+{
+	struct stat stat;
+	int ret = 0, fd, size;
+	char *buf = NULL;
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		printf("Failed to open initrd %s: %d\n", path, fd);
+		return -errno;
+	}
+
+	/*
+	 * Suppress error messages in xbc_init() because it can be just a
+	 * data which concidentally matches the size and checksum footer.
+	 */
+	pr_output = 0;
+	size = load_xbc_from_initrd(fd, &buf);
+	pr_output = 1;
+	if (size < 0) {
+		ret = size;
+		printf("Failed to load a boot config from initrd: %d\n", ret);
+	} else if (size > 0) {
+		ret = fstat(fd, &stat);
+		if (!ret)
+			ret = ftruncate(fd, stat.st_size - size - 8);
+		if (ret)
+			ret = -errno;
+	} /* Ignore if there is no boot config in initrd */
+
+	close(fd);
+	free(buf);
+
+	return ret;
+}
+
+int apply_xbc(const char *path, const char *xbc_path)
+{
+	u32 size, csum;
+	char *buf, *data;
+	int ret, fd;
+
+	ret = load_xbc_file(xbc_path, &buf);
+	if (ret < 0) {
+		printf("Failed to load %s : %d\n", xbc_path, ret);
+		return ret;
+	}
+	size = strlen(buf) + 1;
+	csum = checksum((unsigned char *)buf, size);
+
+	/* Prepare xbc_path data */
+	data = malloc(size + 8);
+	if (!data)
+		return -ENOMEM;
+	strcpy(data, buf);
+	*(u32 *)(data + size) = size;
+	*(u32 *)(data + size + 4) = csum;
+
+	/* Check the data format */
+	ret = xbc_init(buf);
+	if (ret < 0) {
+		printf("Failed to parse %s: %d\n", xbc_path, ret);
+		free(data);
+		free(buf);
+		return ret;
+	}
+	printf("Apply %s to %s\n", xbc_path, path);
+	printf("\tSize: %u bytes\n", (unsigned int)size);
+	printf("\tChecksum: %d\n", (unsigned int)csum);
+
+	/* TODO: Check the options by schema */
+	xbc_destroy_all();
+	free(buf);
+
+	/* Remove old boot config if exists */
+	ret = delete_xbc(path);
+	if (ret < 0) {
+		printf("Failed to delete previous boot config: %d\n", ret);
+		return ret;
+	}
+
+	/* Apply new one */
+	fd = open(path, O_RDWR | O_APPEND);
+	if (fd < 0) {
+		printf("Failed to open %s: %d\n", path, fd);
+		return fd;
+	}
+	/* TODO: Ensure the @path is initramfs/initrd image */
+	ret = write(fd, data, size + 8);
+	if (ret < 0) {
+		printf("Failed to apply a boot config: %d\n", ret);
+		return ret;
+	}
+	close(fd);
+	free(data);
+
+	return 0;
+}
+
+int usage(void)
+{
+	printf("Usage: bootconfig [OPTIONS] <INITRD>\n"
+		" Apply, delete or show boot config to initrd.\n"
+		" Options:\n"
+		"		-a <config>: Apply boot config to initrd\n"
+		"		-d : Delete boot config file from initrd\n\n"
+		" If no option is given, show current applied boot config.\n");
+	return -1;
+}
+
+int main(int argc, char **argv)
+{
+	char *path = NULL;
+	char *apply = NULL;
+	bool delete = false;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hda:")) != -1) {
+		switch (opt) {
+		case 'd':
+			delete = true;
+			break;
+		case 'a':
+			apply = optarg;
+			break;
+		case 'h':
+		default:
+			return usage();
+		}
+	}
+
+	if (apply && delete) {
+		printf("Error: You can not specify both -a and -d at once.\n");
+		return usage();
+	}
+
+	if (optind >= argc) {
+		printf("Error: No initrd is specified.\n");
+		return usage();
+	}
+
+	path = argv[optind];
+
+	if (apply)
+		return apply_xbc(path, apply);
+	else if (delete)
+		return delete_xbc(path);
+
+	return show_xbc(path);
+}
+

