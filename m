Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF150AC6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442808AbiDUXvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442782AbiDUXvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269F433B1;
        Thu, 21 Apr 2022 16:48:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n11so4906693qvl.0;
        Thu, 21 Apr 2022 16:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WhyHlyJy4xU6YReftUXEs5LTZutZa3HDofMmOBXTLE=;
        b=AQLPRW36rsBuMa8/xIUdaNbDiyRqcAQz684qwwVv5jdLQnu/zUNtGDUw/B7bFrni4C
         pAWeJ3oN4Pj6oXtZ5lkmXkMrHv+tbMMT1sD7mBY1yESyD9eO2i5x9amEzL1U4/DhFLbO
         ejC1kTWj5x5vdx4D9HqkqzSrRHXcg4r8zcPJLUJI8A+cLrh9EXaLh3Mev/xfVD1zji97
         ANZPDGmBJXJb5dWzh58VEUAaFZxFgnsrJPE5oOlfVAPTmm9emNVVRm7DuIUtBZjQTFHF
         H0YYlZzmDAKDikd3+AF86phqxO3cd9iyh4TejHR60t/GdthAMVRNpHI9zHNQtzy+/VpA
         GkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WhyHlyJy4xU6YReftUXEs5LTZutZa3HDofMmOBXTLE=;
        b=EoPnVRvfNjF9maaenmDs2gfJXobomj5la/equ+uuFqK+cL3MfcTHPppTj7Oii13BVF
         ixEUy/mU1eh4vhRNqxsxPhAyf6SK2c2l6B53r6CeIMKX/v5ffDti9CBHMhTGthzdrg1J
         WOXYa8Nderkt/6OSmeIU0pPXSi9ivJ9LK1PKN61ClqSXKYfhR9NrtScXRurtlB81B595
         wC4mu4baIfH4gBvBiaMv/nPvOG34dwaKbiaCtU5NC2CqE8k9IerN4F6zx/SyKwF7LQSv
         veTaP0ZRjhyYWBavIcEMx5MZPyRXdz0nqwwah6zAGHpGtjYPOlkAabZVFyr9Wct/R+t4
         hqaQ==
X-Gm-Message-State: AOAM530UjxzCBoEcJJc/34VRxNOjljw6LIQLngZes3mRufQGp0o0RJve
        +sOIawHOmJT3Nn9OVAvgCVQPJRfO95br
X-Google-Smtp-Source: ABdhPJzTeuKYtVKzuVMuXWGTjw9xC0J0QgXOrkVmCWcRl3U4YiWy6z27w1kaozh6EXBlAv8VPDLQqQ==
X-Received: by 2002:a05:6214:21a4:b0:446:5514:82b7 with SMTP id t4-20020a05621421a400b00446551482b7mr1507048qvc.54.1650584932740;
        Thu, 21 Apr 2022 16:48:52 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:52 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 1/8] lib/printbuf: New data structure for heap-allocated strings
Date:   Thu, 21 Apr 2022 19:48:30 -0400
Message-Id: <20220421234837.3629927-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds printbufs: simple heap-allocated strings meant for building up
structured messages, for logging/procfs/sysfs and elsewhere. They've
been heavily used in bcachefs for writing .to_text() functions/methods -
pretty printers, which has in turn greatly improved the overall quality
of error messages.

Basic usage is documented in include/linux/printbuf.h.

The next patches in the series are going to be using printbufs to
implement a .to_text() method for shrinkers, and improving OOM
reporting.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/printbuf.h | 164 +++++++++++++++++++++++
 lib/Makefile             |   2 +-
 lib/printbuf.c           | 274 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/printbuf.h
 create mode 100644 lib/printbuf.c

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
new file mode 100644
index 0000000000..276cdecf08
--- /dev/null
+++ b/include/linux/printbuf.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifndef _LINUX_PRINTBUF_H
+#define _LINUX_PRINTBUF_H
+
+/*
+ * Printbufs: Simple heap allocated strings, with some features for structered
+ * formatting.
+ *
+ * This code has provisions for use in userspace, to aid in making other code
+ * portable between kernelspace and userspace.
+ *
+ * Basic example:
+ *
+ *   struct printbuf buf = PRINTBUF;
+ *
+ *   pr_buf(&buf, "foo=");
+ *   foo_to_text(&buf, foo);
+ *   printk("%s", buf.buf);
+ *   printbuf_exit(&buf);
+ *
+ * We can now write pretty printers instead of writing code that dumps
+ * everything to the kernel log buffer, and then those pretty-printers can be
+ * used by other code that outputs to kernel log, sysfs, debugfs, etc.
+ *
+ * Memory allocation: Outputing to a printbuf may allocate memory. This
+ * allocation is done with GFP_KERNEL, by default: use the newer
+ * memalloc_*_(save|restore) functions as needed.
+ *
+ * Since no equivalent yet exists for GFP_ATOMIC/GFP_NOWAIT, memory allocations
+ * will be done with GFP_ATOMIC if printbuf->atomic is nonzero.
+ *
+ * Memory allocation failures: We don't return errors directly, because on
+ * memory allocation failure we usually don't want to bail out and unwind - we
+ * want to print what we've got, on a best-effort basis. But code that does want
+ * to return -ENOMEM may check printbuf.allocation_failure.
+ *
+ * Indenting, tabstops:
+ *
+ * To aid is writing multi-line pretty printers spread across multiple
+ * functions, printbufs track the current indent level.
+ *
+ * pr_indent_push() and pr_indent_pop() increase and decrease the current indent
+ * level, respectively.
+ *
+ * To use tabstops, set printbuf->tabstops[]; they are in units of spaces, from
+ * start of line. Once set, pr_tab() will output spaces up to the next tabstop.
+ * pr_tab_rjust() will also advance the current line of text up to the next
+ * tabstop, but it does so by shifting text since the previous tabstop up to the
+ * next tabstop - right justifying it.
+ *
+ * Make sure you use pr_newline() instead of \n in the format string for indent
+ * level and tabstops to work corretly.
+ *
+ * Output units: printbuf->units exists to tell pretty-printers how to output
+ * numbers: a raw value (e.g. directly from a superblock field), as bytes, or as
+ * human readable bytes. pr_units() and pr_sectors() obey it.
+ *
+ * Other helpful functions:
+ *
+ * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
+ * readable units.
+ *
+ * pr_time(): for printing a time_t with strftime in userspace, prints as an
+ * integer number of seconds in the kernel.
+ *
+ * pr_string_option: Given an enumerated value and a string array with names for
+ * each option, prints out the enum names with the selected one indicated with
+ * square brackets.
+ *
+ * pr_bitflags: Given a bitflag and a string array with names for each bit,
+ * prints out the names of the selected bits.
+ */
+
+#include <linux/slab.h>
+#include <linux/string_helpers.h>
+
+enum printbuf_units {
+	PRINTBUF_UNITS_RAW,
+	PRINTBUF_UNITS_BYTES,
+	PRINTBUF_UNITS_HUMAN_READABLE,
+};
+
+struct printbuf {
+	char			*buf;
+	unsigned		size;
+	unsigned		pos;
+	unsigned		last_newline;
+	unsigned		last_field;
+	unsigned		indent;
+	enum printbuf_units	units:8;
+	/*
+	 * If nonzero, allocations will be done with GFP_ATOMIC:
+	 */
+	u8			atomic;
+	bool			allocation_failure:1;
+	/* SI units (10^3), or 2^10: */
+	enum string_size_units	human_readable_units:1;
+	u8			tabstop;
+	u8			tabstops[4];
+};
+
+#define PRINTBUF ((struct printbuf) { .human_readable_units = STRING_UNITS_2 })
+
+/**
+ * printbuf_exit - exit a printbuf, freeing memory it owns and poisoning it
+ * against accidental use.
+ */
+static inline void printbuf_exit(struct printbuf *buf)
+{
+	kfree(buf->buf);
+	buf->buf = ERR_PTR(-EINTR); /* poison value */
+}
+
+/**
+ * printbuf_reset - re-use a printbuf without freeing and re-initializing it:
+ */
+static inline void printbuf_reset(struct printbuf *buf)
+{
+	buf->pos		= 0;
+	buf->last_newline	= 0;
+	buf->last_field		= 0;
+	buf->indent		= 0;
+	buf->tabstop		= 0;
+	buf->allocation_failure	= 0;
+}
+
+/**
+ * printbuf_atomic_inc - mark as entering an atomic section
+ */
+static inline void printbuf_atomic_inc(struct printbuf *buf)
+{
+	buf->atomic++;
+}
+
+/**
+ * printbuf_atomic_inc - mark as leaving an atomic section
+ */
+static inline void printbuf_atomic_dec(struct printbuf *buf)
+{
+	buf->atomic--;
+}
+
+void pr_buf(struct printbuf *out, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+
+void pr_char(struct printbuf *buf, char c);
+void pr_newline(struct printbuf *);
+void pr_indent_push(struct printbuf *, unsigned);
+void pr_indent_pop(struct printbuf *, unsigned);
+void pr_tab(struct printbuf *);
+void pr_tab_rjust(struct printbuf *);
+void pr_human_readable_u64(struct printbuf *, u64);
+void pr_human_readable_s64(struct printbuf *, s64);
+void pr_units(struct printbuf *, s64, s64);
+void pr_sectors(struct printbuf *, u64);
+void pr_time(struct printbuf *, u64);
+void pr_uuid(struct printbuf *, u8 *);
+void pr_string_option(struct printbuf *, const char * const list[], size_t);
+void pr_bitflags(struct printbuf *, const char * const list[], u64);
+const char *printbuf_str(const struct printbuf *);
+
+#endif /* _LINUX_PRINTBUF_H */
diff --git a/lib/Makefile b/lib/Makefile
index c588a126a3..31a3904eda 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
-	 buildid.o
+	 buildid.o printbuf.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/printbuf.c b/lib/printbuf.c
new file mode 100644
index 0000000000..e0dfa82cda
--- /dev/null
+++ b/lib/printbuf.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifdef __KERNEL__
+#include <linux/export.h>
+#include <linux/kernel.h>
+#else
+#define EXPORT_SYMBOL(x)
+#endif
+
+#include <linux/log2.h>
+#include <linux/printbuf.h>
+#include <linux/string_helpers.h>
+
+static inline size_t printbuf_remaining(struct printbuf *buf)
+{
+	return buf->size - buf->pos;
+}
+
+static inline size_t printbuf_linelen(struct printbuf *buf)
+{
+	return buf->pos - buf->last_newline;
+}
+
+static int printbuf_realloc(struct printbuf *out, unsigned extra)
+{
+	unsigned new_size;
+	char *buf;
+
+	if (out->pos + extra + 1 < out->size)
+		return 0;
+
+	new_size = roundup_pow_of_two(out->size + extra);
+	buf = krealloc(out->buf, new_size, !out->atomic ? GFP_KERNEL : GFP_ATOMIC);
+
+	if (!buf) {
+		out->allocation_failure = true;
+		return -ENOMEM;
+	}
+
+	out->buf	= buf;
+	out->size	= new_size;
+	return 0;
+}
+
+void pr_buf(struct printbuf *out, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	do {
+		va_start(args, fmt);
+		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args);
+		va_end(args);
+	} while (len + 1 >= printbuf_remaining(out) &&
+		 !printbuf_realloc(out, len + 1));
+
+	len = min_t(size_t, len,
+		  printbuf_remaining(out) ? printbuf_remaining(out) - 1 : 0);
+	out->pos += len;
+}
+EXPORT_SYMBOL(pr_buf);
+
+void pr_char(struct printbuf *buf, char c)
+{
+	if (!printbuf_realloc(buf, 1)) {
+		buf->buf[buf->pos++] = c;
+		buf->buf[buf->pos] = 0;
+	}
+}
+EXPORT_SYMBOL(pr_char);
+
+void pr_newline(struct printbuf *buf)
+{
+	unsigned i;
+
+	pr_char(buf, '\n');
+
+	buf->last_newline	= buf->pos;
+
+	for (i = 0; i < buf->indent; i++)
+		pr_char(buf, ' ');
+
+	buf->last_field		= buf->pos;
+	buf->tabstop = 0;
+}
+EXPORT_SYMBOL(pr_newline);
+
+void pr_indent_push(struct printbuf *buf, unsigned spaces)
+{
+	buf->indent += spaces;
+	while (spaces--)
+		pr_char(buf, ' ');
+}
+EXPORT_SYMBOL(pr_indent_push);
+
+void pr_indent_pop(struct printbuf *buf, unsigned spaces)
+{
+	if (buf->last_newline + buf->indent == buf->pos) {
+		buf->pos -= spaces;
+		buf->buf[buf->pos] = 0;
+	}
+	buf->indent -= spaces;
+}
+EXPORT_SYMBOL(pr_indent_pop);
+
+void pr_tab(struct printbuf *buf)
+{
+	BUG_ON(buf->tabstop > ARRAY_SIZE(buf->tabstops));
+
+	while (printbuf_remaining(buf) > 1 &&
+	       printbuf_linelen(buf) < buf->tabstops[buf->tabstop])
+		pr_char(buf, ' ');
+
+	buf->last_field = buf->pos;
+	buf->tabstop++;
+}
+EXPORT_SYMBOL(pr_tab);
+
+void pr_tab_rjust(struct printbuf *buf)
+{
+	BUG_ON(buf->tabstop > ARRAY_SIZE(buf->tabstops));
+
+	if (printbuf_linelen(buf) < buf->tabstops[buf->tabstop]) {
+		unsigned move = buf->pos - buf->last_field;
+		unsigned shift = buf->tabstops[buf->tabstop] -
+			printbuf_linelen(buf);
+
+		printbuf_realloc(buf, shift);
+
+		if (buf->last_field + shift + 1 < buf->size) {
+			move = min(move, buf->size - 1 - buf->last_field - shift);
+
+			memmove(buf->buf + buf->last_field + shift,
+				buf->buf + buf->last_field,
+				move);
+			memset(buf->buf + buf->last_field, ' ', shift);
+			buf->pos += shift;
+			buf->buf[buf->pos] = 0;
+		}
+	}
+
+	buf->last_field = buf->pos;
+	buf->tabstop++;
+}
+EXPORT_SYMBOL(pr_tab_rjust);
+
+void pr_human_readable_u64(struct printbuf *buf, u64 v)
+{
+	printbuf_realloc(buf, 10);
+	string_get_size(v, 1, buf->human_readable_units, buf->buf + buf->pos,
+			printbuf_remaining(buf));
+	buf->pos += strlen(buf->buf + buf->pos);
+}
+EXPORT_SYMBOL(pr_human_readable_u64);
+
+void pr_human_readable_s64(struct printbuf *buf, s64 v)
+{
+	if (v < 0)
+		pr_char(buf, '-');
+	pr_human_readable_u64(buf, abs(v));
+}
+EXPORT_SYMBOL(pr_human_readable_s64);
+
+void pr_units(struct printbuf *out, s64 raw, s64 bytes)
+{
+	switch (out->units) {
+	case PRINTBUF_UNITS_RAW:
+		pr_buf(out, "%llu", raw);
+		break;
+	case PRINTBUF_UNITS_BYTES:
+		pr_buf(out, "%llu", bytes);
+		break;
+	case PRINTBUF_UNITS_HUMAN_READABLE:
+		pr_human_readable_s64(out, bytes);
+		break;
+	}
+}
+EXPORT_SYMBOL(pr_units);
+
+void pr_sectors(struct printbuf *out, u64 v)
+{
+	pr_units(out, v, v << 9);
+}
+EXPORT_SYMBOL(pr_sectors);
+
+#ifdef __KERNEL__
+
+void pr_time(struct printbuf *out, u64 time)
+{
+	pr_buf(out, "%llu", time);
+}
+EXPORT_SYMBOL(pr_time);
+
+void pr_uuid(struct printbuf *out, u8 *uuid)
+{
+	pr_buf(out, "%pUb", uuid);
+}
+EXPORT_SYMBOL(pr_uuid);
+
+#else
+
+#include <time.h>
+#include <uuid.h>
+
+void pr_time(struct printbuf *out, u64 _time)
+{
+	char time_str[64];
+	time_t time = _time;
+	struct tm *tm = localtime(&time);
+	size_t err = strftime(time_str, sizeof(time_str), "%c", tm);
+
+	if (!err)
+		pr_buf(out, "(formatting error)");
+	else
+		pr_buf(out, "%s", time_str);
+}
+
+void pr_uuid(struct printbuf *out, u8 *uuid)
+{
+	char uuid_str[40];
+
+	uuid_unparse_lower(uuid, uuid_str);
+	pr_buf(out, uuid_str);
+}
+
+#endif
+
+void pr_string_option(struct printbuf *out,
+		      const char * const list[],
+		      size_t selected)
+{
+	size_t i;
+
+	for (i = 0; list[i]; i++)
+		pr_buf(out, i == selected ? "[%s] " : "%s ", list[i]);
+}
+EXPORT_SYMBOL(pr_string_option);
+
+void pr_bitflags(struct printbuf *out,
+		 const char * const list[], u64 flags)
+{
+	unsigned bit, nr = 0;
+	bool first = true;
+
+	while (list[nr])
+		nr++;
+
+	while (flags && (bit = __ffs(flags)) < nr) {
+		if (!first)
+			pr_buf(out, ",");
+		first = false;
+		pr_buf(out, "%s", list[bit]);
+		flags ^= 1 << bit;
+	}
+}
+EXPORT_SYMBOL(pr_bitflags);
+
+/**
+ * printbuf_str - returns printbuf's buf as a C string, guaranteed to be null
+ * terminated
+ */
+const char *printbuf_str(const struct printbuf *buf)
+{
+	/*
+	 * If we've written to a printbuf then it's guaranteed to be a null
+	 * terminated string - but if we haven't, then we might not have
+	 * allocated a buffer at all:
+	 */
+	return buf->pos
+		? buf->buf
+		: "";
+}
+EXPORT_SYMBOL(printbuf_str);
-- 
2.35.2

