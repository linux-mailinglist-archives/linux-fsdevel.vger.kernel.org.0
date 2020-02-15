Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6E15FEFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgBOPg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:36:56 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52996 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgBOPg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:36:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 965FE8EE302;
        Sat, 15 Feb 2020 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781015;
        bh=QERCmtKjnFN0QPNnxzT6PGdGlU79vFWKJXDvMy/XddQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhFcQ6kZ7Byzcy0EqiPrfaud839k7K0zMNXxRN+ZBTZ1opmOhvioWl2uPIMbfHuyv
         5IXhQhU5ajzUlI2IHKeeA1IY+1x53trv+Gcnvv/1OyIxY7fGYkXNPOL/0eG/v6EzAs
         iz+PAZ01PX976M8NB2goScWS5WRtx9feJKkdtCcA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lJbXDZ6oKHIZ; Sat, 15 Feb 2020 07:36:55 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C0DA98EE121;
        Sat, 15 Feb 2020 07:36:54 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 1/6] logger: add a limited buffer logging facility
Date:   Sat, 15 Feb 2020 10:36:04 -0500
Message-Id: <20200215153609.23797-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can be used by anything that wants to add to a list of messages and
then spit them back at a particular time.  The current use case for
this is the filesystem configuration descriptor, which can accumulate
messages about config options which can then be read from the file
descriptor later via a .read operation.

This code was based on fc_log originally written by David Howells in
commit e7582e16a170 "vfs: Implement logging through fs_context" and
subsequently extended to include a prefix logger by Al Viro in commit
cc3c0b533ab9 "add prefix to fs_context->log".

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: add prefix logger
---
 include/linux/logger.h |  45 ++++++++++++
 lib/Makefile           |   3 +-
 lib/logger.c           | 190 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/logger.h
 create mode 100644 lib/logger.c

diff --git a/include/linux/logger.h b/include/linux/logger.h
new file mode 100644
index 000000000000..27c2650a72da
--- /dev/null
+++ b/include/linux/logger.h
@@ -0,0 +1,45 @@
+#ifndef _LINUX_LOGGER_H
+#define _LINUX_LOGGER_H
+
+#include <stdarg.h>
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+
+struct logger {
+	const char	*prefix;
+	refcount_t	usage;
+	struct mutex	mutex;
+	u8		head;		/* Insertion index in buffer[] */
+	u8		tail;		/* Removal index in buffer[] */
+	u8		need_free;	/* Mask of kfree'able items in buffer[] */
+	struct module	*owner;		/* Owner module for strings that don't then need freeing */
+	const char	*buffer[8];
+};
+
+struct plogger {
+	const char	*prefix;
+	struct logger	*log;
+};
+
+extern __printf(4, 5)
+void logger_log(struct logger *, const char *prefix, char level,
+		const char *fmt, ...);
+extern __printf(4, 0)
+void logger_valog(struct logger *, const char *prefix, char level,
+		  const char *fmt, va_list va);
+ssize_t logger_read(struct logger *log, char __user *_buf,  size_t len);
+struct logger *logger_alloc(struct module *owner);
+void logger_put(struct logger **logp);
+void logger_get(struct logger *log);
+
+#define logger_err(log, fmt, ...) ({ logger_log(log, NULL, 'e', fmt, ## __VA_ARGS__); })
+#define logger_warn(log, fmt, ...) ({ logger_log(log, NULL, 'w', fmt, ## __VA_ARGS__); })
+#define logger_info(log, fmt, ...) ({ logger_log(log, NULL, 'i', fmt, ## __VA_ARGS__); })
+#define plogger_err(plog, fmt, ...) ({ logger_log((plog)->log, (plog)->prefix, 'e', fmt, ## __VA_ARGS__); })
+#define plogger_warn(log, fmt, ...) ({ logger_log((plog)->log, (plog)->prefix, 'w', fmt, ## __VA_ARGS__); })
+#define plogger_info(log, fmt, ...) ({ logger_log((plog)->log, (plog)->prefix, 'i', fmt, ## __VA_ARGS__); })
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index 5d64890d6b6a..3c9b9db35e1a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -31,7 +31,8 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
-	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o
+	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
+	 logger.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
diff --git a/lib/logger.c b/lib/logger.c
new file mode 100644
index 000000000000..4442cfd2cdaf
--- /dev/null
+++ b/lib/logger.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Provide a logging function
+ *
+ * code is originally based on fc_log by David Howells and rewritten
+ * by James Bottomley.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/logger.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/sections.h>
+
+/**
+ * logger_valog - Log a message to a logger context
+ * @log: The logger context
+ * @fmt: The format of the log entry.
+ * @va: the variable arguments pointer
+ *
+ * Currently @fmt is expected to have a letter prefix of w or e
+ * followed by a space to signal warning or error.  If @log is NULL
+ * then the message will be logged to the kernel via printk.
+ *
+ */
+void logger_valog(struct logger *log, const char *prefix, char level,
+		  const char *fmt, va_list va)
+{
+	struct va_format vaf = {.fmt = fmt, .va = (va_list *)&va};
+
+	if (!log) {
+		switch (level) {
+		case 'w':
+			printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
+						prefix ? ": " : "", &vaf);
+			break;
+		case 'e':
+			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
+						prefix ? ": " : "", &vaf);
+			break;
+		default:
+			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
+						prefix ? ": " : "", &vaf);
+			break;
+		}
+	} else {
+		unsigned int logsize = ARRAY_SIZE(log->buffer);
+		u8 index;
+		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n", level,
+						prefix ? prefix : "",
+						prefix ? ": " : "", &vaf);
+
+		index = log->head & (logsize - 1);
+		BUILD_BUG_ON(sizeof(log->head) != sizeof(u8) ||
+			     sizeof(log->tail) != sizeof(u8));
+		if ((u8)(log->head - log->tail) == logsize) {
+			/* The buffer is full, discard the oldest message */
+			if (log->need_free & (1 << index))
+				kfree(log->buffer[index]);
+			log->tail++;
+		}
+
+		log->buffer[index] = q ? q : "OOM: Can't store error string";
+		if (q)
+			log->need_free |= 1 << index;
+		else
+			log->need_free &= ~(1 << index);
+		log->head++;
+	}
+}
+EXPORT_SYMBOL(logger_valog);
+
+/**
+ * logger_log - Log a message to a logger context
+ * @log: The logger context
+ * @fmt: The format of the log entry.
+ */
+void logger_log(struct logger *log, const char *prefix, char level,
+		const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	logger_valog(log, prefix, level, fmt, va);
+	va_end(va);
+}
+EXPORT_SYMBOL(logger_log);
+
+/**
+ * logger_read - read back a log at an arbitrary position
+ * @logger: the logger context
+ * @buf: the buffer to read to (may be user space pointer)
+ * @len: the length of data to read
+ *
+ * Allow the user to read back any error, warning or informational
+ * messages. This is designed to be wrapped for a file descriptor read.
+ */
+ssize_t logger_read(struct logger *log, char __user *_buf,  size_t len)
+{
+	unsigned int logsize = ARRAY_SIZE(log->buffer);
+	ssize_t ret;
+	const char *p;
+	bool need_free;
+	int index, n;
+
+	ret = mutex_lock_interruptible(&log->mutex);
+	if (ret < 0)
+		return ret;
+
+	if (log->head == log->tail) {
+		mutex_unlock(&log->mutex);
+		return -ENODATA;
+	}
+
+	index = log->tail & (logsize - 1);
+	p = log->buffer[index];
+	need_free = log->need_free & (1 << index);
+	log->buffer[index] = NULL;
+	log->need_free &= ~(1 << index);
+	log->tail++;
+	mutex_unlock(&log->mutex);
+
+	ret = -EMSGSIZE;
+	n = strlen(p);
+	if (n > len)
+		goto err_free;
+	ret = -EFAULT;
+	if (copy_to_user(_buf, p, n) != 0)
+		goto err_free;
+	ret = n;
+
+err_free:
+	if (need_free)
+		kfree(p);
+	return ret;
+}
+EXPORT_SYMBOL(logger_read);
+
+struct logger *logger_alloc(struct module *owner)
+{
+	struct logger *log = kzalloc(sizeof(*log), GFP_KERNEL);
+
+	if (!log)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&log->usage, 1);
+	mutex_init(&log->mutex);
+	log->owner = owner;
+
+	return log;
+}
+EXPORT_SYMBOL(logger_alloc);
+
+/**
+ * logger_put - decrement refcount and free log if zero
+ * @logp: pointer to logger context to be freed
+ *
+ * if the logger is actually freed, then the @logp will be NULLed.
+ */
+void logger_put(struct logger **logp)
+{
+	int i;
+	struct logger *log;
+
+	if (!logp || !*logp)
+		return;
+
+	log = *logp;
+	if (refcount_dec_and_test(&log->usage)) {
+		*logp = NULL;
+		for (i = 0; i <= 7; i++)
+			if (log->need_free & (1 << i))
+				kfree(log->buffer[i]);
+		kfree(log);
+	}
+}
+EXPORT_SYMBOL(logger_put);
+
+/**
+ * logger_get - get a reference to a logger context
+ * @log: the logger context
+ */
+void logger_get(struct logger *log)
+{
+	if (!log)
+		return;
+	refcount_inc(&log->usage);
+}
-- 
2.16.4

