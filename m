Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB84310B774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 21:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfK0UeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 15:34:01 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57156 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbfK0UeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:34:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C44E48EE133;
        Wed, 27 Nov 2019 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574886840;
        bh=3hZMsfjjKT9qhxtyScx8mNM+p5p85vzy4M7ameRsuKU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jBwiVqsALoCznro6uqaV6eKaim2jA9DB60I5iNLFOZOYnE/jI5mrQOSaHkx/JUw0q
         n6KbeWM6aVl1XvaAJwfjJIV66VM11K/O2m2jPzcpDinH4BLd/mdotToKe5RTKcdtqr
         1cdG2/sgCT694sRXdq4wQM3THaElw/u7v9ZUhukY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wLFVZv38DuiB; Wed, 27 Nov 2019 12:34:00 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E4DC88EE130;
        Wed, 27 Nov 2019 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574886840;
        bh=3hZMsfjjKT9qhxtyScx8mNM+p5p85vzy4M7ameRsuKU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jBwiVqsALoCznro6uqaV6eKaim2jA9DB60I5iNLFOZOYnE/jI5mrQOSaHkx/JUw0q
         n6KbeWM6aVl1XvaAJwfjJIV66VM11K/O2m2jPzcpDinH4BLd/mdotToKe5RTKcdtqr
         1cdG2/sgCT694sRXdq4wQM3THaElw/u7v9ZUhukY=
Message-ID: <1574886838.21593.8.camel@HansenPartnership.com>
Subject: [RFC 1/6] logger: add a limited buffer logging facility
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Nov 2019 12:33:58 -0800
In-Reply-To: <1574886778.21593.7.camel@HansenPartnership.com>
References: <1574295100.17153.25.camel@HansenPartnership.com>
         <17268.1574323839@warthog.procyon.org.uk>
         <1574352920.3277.18.camel@HansenPartnership.com>
         <1574886778.21593.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
commit e7582e16a170db4c85995c1c03d194ea1ea621fc "vfs: Implement
logging through fs_context".

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/logger.h |  34 ++++++++
 lib/Makefile           |   3 +-
 lib/logger.c           | 211 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/logger.h
 create mode 100644 lib/logger.c

diff --git a/include/linux/logger.h b/include/linux/logger.h
new file mode 100644
index 000000000000..cf7a87f1d8d2
--- /dev/null
+++ b/include/linux/logger.h
@@ -0,0 +1,34 @@
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
+	refcount_t	usage;
+	struct mutex	mutex;
+	u8		head;		/* Insertion index in buffer[] */
+	u8		tail;		/* Removal index in buffer[] */
+	u8		need_free;	/* Mask of kfree'able items in buffer[] */
+	struct module	*owner;		/* Owner module for strings that don't then need freeing */
+	const char	*buffer[8];
+};
+
+extern __printf(2, 3)
+void logger_log(struct logger *, const char *fmt, ...);
+extern __printf(2, 0)
+void logger_valog(struct logger *, const char *fmt, va_list va);
+ssize_t logger_read(struct logger *log, char __user *_buf,  size_t len);
+struct logger *logger_alloc(struct module *owner);
+void logger_put(struct logger **logp);
+void logger_get(struct logger *log);
+
+#define logger_err(log, fmt, ...) ({ logger_log(log, "e "fmt, ## __VA_ARGS__); })
+#define logger_warn(log, fmt, ...) ({ logger_log(log, "w "fmt, ## __VA_ARGS__); })
+#define logger_info(log, fmt, ...) ({ logger_log(log, "i "fmt, ## __VA_ARGS__); })
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..57a90d1eed29 100644
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
index 000000000000..5b8655959c77
--- /dev/null
+++ b/lib/logger.c
@@ -0,0 +1,211 @@
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
+void logger_valog(struct logger *log, const char *fmt, va_list va)
+{
+	static const char store_failure[] = "OOM: Can't store error string";
+	const char *p;
+	const char *q;
+	u8 freeable = 1;
+
+	if (!strchr(fmt, '%')) {
+		p = fmt;
+		goto unformatted_string;
+	}
+	if (strcmp(fmt, "%s") == 0) {
+		p = va_arg(va, const char *);
+
+	unformatted_string:
+		if (((unsigned long)p >= (unsigned long)__start_rodata &&
+		     (unsigned long)p <  (unsigned long)__end_rodata) ||
+		    (log && within_module_core((unsigned long)p, log->owner))) {
+			q = (char *)p;
+			freeable = 0;
+		} else {
+			q = kstrdup(p, GFP_KERNEL);
+		}
+	} else {
+		q = kvasprintf(GFP_KERNEL, fmt, va);
+	}
+
+	if (!q) {
+		/* this won't be the right format, but better than losing it */
+		vprintk(fmt, va);
+		q = store_failure;
+	}
+
+	if (!log) {
+		switch (fmt[0]) {
+		case 'w':
+			printk(KERN_WARNING "%s\n", q + 2);
+			break;
+		case 'e':
+			printk(KERN_ERR "%s\n", q + 2);
+			break;
+		default:
+			printk(KERN_NOTICE "%s\n", q + 2);
+			break;
+		}
+		if (freeable)
+			kfree(q);
+	} else {
+		unsigned int logsize = ARRAY_SIZE(log->buffer);
+		u8 index;
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
+		log->buffer[index] = q;
+		log->need_free &= ~(1 << index);
+		log->need_free |= freeable << index;
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
+void logger_log(struct logger *log, const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	logger_valog(log, fmt, va);
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

