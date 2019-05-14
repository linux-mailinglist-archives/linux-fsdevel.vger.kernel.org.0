Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3F1C20D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 07:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfENFoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 01:44:00 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:35390 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfENFn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 01:43:59 -0400
Received: by mail-vs1-f73.google.com with SMTP id j193so2151554vsd.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 22:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k708XC1RWS6IC03AyjrjR94Dqv6JcvdDzosBHuXfxH8=;
        b=CGqmOOtjpXMd7hIYwGeClpivLkHfr7XcTv05DcSuV5i5ucCnVwyVsPUTqEoEh5oW97
         tPwPVV1l1XpnleG2uwCdzeRqToa567lMD0XmuqbwUD3JTgkkQFFlhi1v3lYN1ZZ+arRG
         Z6NnZSc7HQV1wByxN8sKKFpYvxIRIBFSpJTiYoPGTG2IC2k561igyIOm7Ijc2Hne/cFW
         YXf8Shm8rD+/m3lQMx70Ejdmi/cj3T6wFu6SJ0JyFGgM8XaLLqdnS8o2BRcnQbsUO1UZ
         ro2QdCiRAHeryGkoIZPqHIRXwe5Tv9VmSNxage0JS7qF8CXEWqpHcDZXS9eSqx9xNdhM
         nQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k708XC1RWS6IC03AyjrjR94Dqv6JcvdDzosBHuXfxH8=;
        b=m2Ow4AViaGTevlmoKGLQHSw+0xo9l+daz9YOGF9KrnaincpHIYVI63jfSdsDAfDp6h
         qIQdYUfhYwFJpq7k15r2UyjDY2R4ZFzVmRBJGDENvaAxMtLX8Zr1sKv3X/U6kdvMsSel
         k8ToTZrJaYpS1Snvd8MENkTp5rl3P0nWf+X2U0y8yqa00ZtdrvIzOZki8MzJpKyG07kK
         rH5SLdPR4tA/nsuw0xJdFtGKPZ4K29mxnYTgJaH9EYJlW3KZPtR+760mCe8aCUTwVsux
         fSbc8FlMmFlIm9MdQjkMRxIz6vjKba6fBLBg+kn1RIDs+7m33Wa2rRwCuLsRohOZskBZ
         z7mQ==
X-Gm-Message-State: APjAAAVDmzLK5CohLgCEpObDEMNGiPtWBGXUOf6ELSzrvG3NVmdlEIib
        k2sw1GkeDX03m6wbJhQOpZB4+BauoyUEAL/K3/zJmw==
X-Google-Smtp-Source: APXvYqxWDgyZzslG/g40cGf1tLChgc2SdznyzcZxZBY0pvWzUUl96zwEZMQADm3NMjXyp6ScbdNJTnAxWd5ZV2gZDdBG1A==
X-Received: by 2002:ab0:6193:: with SMTP id h19mr8134030uan.13.1557812637312;
 Mon, 13 May 2019 22:43:57 -0700 (PDT)
Date:   Mon, 13 May 2019 22:42:36 -0700
In-Reply-To: <20190514054251.186196-1-brendanhiggins@google.com>
Message-Id: <20190514054251.186196-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 03/18] kunit: test: add string_stream a std::stream like
 string builder
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

So provide a library for constructing the string as you go similar to
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes Since Last Revision:
 - Renamed struct instance with field of the same name, as per Shuah's
   comments.
---
 include/kunit/string-stream.h |  51 ++++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 143 ++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..567a4629406da
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+	struct kref refcount;
+};
+
+struct string_stream *new_string_stream(void);
+
+void destroy_string_stream(struct string_stream *stream);
+
+void string_stream_get(struct string_stream *stream);
+
+int string_stream_put(struct string_stream *stream);
+
+int string_stream_add(struct string_stream *this, const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *this,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *this);
+
+void string_stream_clear(struct string_stream *this);
+
+bool string_stream_is_empty(struct string_stream *this);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 5efdc4dea2c08..275b565a0e81f 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_KUNIT) +=			test.o
+obj-$(CONFIG_KUNIT) +=			test.o \
+					string-stream.o
diff --git a/kunit/string-stream.c b/kunit/string-stream.c
new file mode 100644
index 0000000000000..d4e4252dc10b8
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <kunit/string-stream.h>
+
+int string_stream_vadd(struct string_stream *this,
+		       const char *fmt,
+		       va_list args)
+{
+	struct string_stream_fragment *frag_container;
+	int len;
+	va_list args_for_counting;
+	unsigned long flags;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	frag_container = kmalloc(sizeof(*frag_container), GFP_KERNEL);
+	if (!frag_container)
+		return -ENOMEM;
+
+	frag_container->fragment = kmalloc(len, GFP_KERNEL);
+	if (!frag_container->fragment) {
+		kfree(frag_container);
+		return -ENOMEM;
+	}
+
+	len = vsnprintf(frag_container->fragment, len, fmt, args);
+	spin_lock_irqsave(&this->lock, flags);
+	this->length += len;
+	list_add_tail(&frag_container->node, &this->fragments);
+	spin_unlock_irqrestore(&this->lock, flags);
+	return 0;
+}
+
+int string_stream_add(struct string_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(this, fmt, args);
+	va_end(args);
+	return result;
+}
+
+void string_stream_clear(struct string_stream *this)
+{
+	struct string_stream_fragment *frag_container, *frag_container_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	list_for_each_entry_safe(frag_container,
+				 frag_container_safe,
+				 &this->fragments,
+				 node) {
+		list_del(&frag_container->node);
+		kfree(frag_container->fragment);
+		kfree(frag_container);
+	}
+	this->length = 0;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+char *string_stream_get_string(struct string_stream *this)
+{
+	struct string_stream_fragment *frag_container;
+	size_t buf_len = this->length + 1; /* +1 for null byte. */
+	char *buf;
+	unsigned long flags;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	spin_lock_irqsave(&this->lock, flags);
+	list_for_each_entry(frag_container, &this->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return buf;
+}
+
+bool string_stream_is_empty(struct string_stream *this)
+{
+	bool is_empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	is_empty = list_empty(&this->fragments);
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return is_empty;
+}
+
+void destroy_string_stream(struct string_stream *stream)
+{
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+static void string_stream_destroy(struct kref *kref)
+{
+	struct string_stream *stream = container_of(kref,
+						    struct string_stream,
+						    refcount);
+	destroy_string_stream(stream);
+}
+
+struct string_stream *new_string_stream(void)
+{
+	struct string_stream *stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+
+	if (!stream)
+		return NULL;
+
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+	kref_init(&stream->refcount);
+	return stream;
+}
+
+void string_stream_get(struct string_stream *stream)
+{
+	kref_get(&stream->refcount);
+}
+
+int string_stream_put(struct string_stream *stream)
+{
+	return kref_put(&stream->refcount, &string_stream_destroy);
+}
-- 
2.21.0.1020.gf2820cf01a-goog

