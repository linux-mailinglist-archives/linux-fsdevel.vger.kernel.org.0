Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347CC8A63E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfHLSYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:24:49 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54267 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfHLSYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:24:48 -0400
Received: by mail-pg1-f202.google.com with SMTP id j9so11112892pgk.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pJv5HABph5FUlcwnI++MYtn3UsN0gFtrxBAJYf9YQW0=;
        b=QEpE3GjsD9zFKs71nGTBAfMyLainCV5U3pvyn3IyTeO9b70dASmJQOSw/n5m7axwBT
         2jDnpN75NrkG/5zQZSVNXgHcEfW1LTtf0/wA4UuLHuBdvWaSOicAx2Qb/uyPkYiCCW0J
         9jB3FNeAlkTkONPoAgF/FLWAgm2LDH9m12q5u8laOFDLP7h80vn4IpQvFwA+3W2Em6Gy
         6AyR3fRxLR/3JtnuiDf2V6xnihPgw1v1l0RAWfSACs5EhSLkIMket85QzpcLinHsAXEq
         JnTwG9iSbnHi8TqgQV0yVQshi9oWq/d1ma54ECb8Ovyk4eA3PFn3kk6XZMKKjBacrcWM
         CSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pJv5HABph5FUlcwnI++MYtn3UsN0gFtrxBAJYf9YQW0=;
        b=VKFrg2LjnUSu2G/hCNjLRBWpdUUsY6g6JqBrPnboJWWmyB/ke2JllW0vg/bzBlespr
         gdpBaxOQhjCSNp9OOfhocRUKYCzJ8KBKIJTbGpT1s79zz3zNBlPP4thJOjW39o6rE9UA
         v1m26t3joNo368IqT7tDyJftql0XZuZDiX8DgvR61vcGqdMWNs6TBtgv9B5H/1Bx/mgp
         B0IW+IuRZxx0w32WYUyFYSDX/cP9P7XnwRdtpMBIDCh13ujYWeMJWQMccuq9P6WaRrBZ
         YbpJGC0UVUy1Sfx+/fpbpxdIMrIgC/afWg28yKdJFzQUCr78znQifPbGPaf5Auec2Tv/
         BmIA==
X-Gm-Message-State: APjAAAXnQtc+CYDPEtyaDBtw/N2PIXaBGbl5MgB1ZMSznb5zUJzXL+VD
        IOA1l+TpviaXatio8C85eBdSqkLp5e5F3AsYpH+lzA==
X-Google-Smtp-Source: APXvYqw4sOn9Y9TlUOBo/vo3Nnszkv9bDrP6M0fzpcRJtFWD0bGjJRxxqAdM5K0WV6WkEV1R6TncbxAp4kQa3YgEhxHreQ==
X-Received: by 2002:a63:c008:: with SMTP id h8mr32244105pgg.427.1565634286919;
 Mon, 12 Aug 2019 11:24:46 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:06 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 03/18] kunit: test: add string_stream a std::stream like
 string builder
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

So provide a library for constructing the string as you go similar to
C++'s std::string. string_stream is really just a string builder,
nothing more.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/string-stream.h |  49 +++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 152 ++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..4fa107e38deb5
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,49 @@
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
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+	struct kunit *test;
+	gfp_t gfp;
+};
+
+struct kunit;
+
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *stream);
+
+int string_stream_append(struct string_stream *stream,
+			 struct string_stream *other);
+
+void string_stream_clear(struct string_stream *stream);
+
+bool string_stream_is_empty(struct string_stream *stream);
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
index 0000000000000..bcd56d6755544
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,152 @@
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
+#include <kunit/test.h>
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args)
+{
+	struct string_stream_fragment *frag_container;
+	int len;
+	va_list args_for_counting;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	frag_container = kunit_kmalloc(stream->test, sizeof(*frag_container),
+				       stream->gfp);
+	if (!frag_container)
+		return -ENOMEM;
+
+	frag_container->fragment = kunit_kmalloc(stream->test, len,
+						 stream->gfp);
+	if (!frag_container->fragment)
+		return -ENOMEM;
+
+	len = vsnprintf(frag_container->fragment, len, fmt, args);
+	spin_lock(&stream->lock);
+	stream->length += len;
+	list_add_tail(&frag_container->node, &stream->fragments);
+	spin_unlock(&stream->lock);
+
+	return 0;
+}
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(stream, fmt, args);
+	va_end(args);
+
+	return result;
+}
+
+void string_stream_clear(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container, *frag_container_safe;
+
+	spin_lock(&stream->lock);
+	list_for_each_entry_safe(frag_container,
+				 frag_container_safe,
+				 &stream->fragments,
+				 node) {
+		list_del(&frag_container->node);
+	}
+	stream->length = 0;
+	spin_unlock(&stream->lock);
+}
+
+char *string_stream_get_string(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container;
+	size_t buf_len = stream->length + 1; /* +1 for null byte. */
+	char *buf;
+
+	buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
+	if (!buf)
+		return NULL;
+
+	spin_lock(&stream->lock);
+	list_for_each_entry(frag_container, &stream->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock(&stream->lock);
+
+	return buf;
+}
+
+int string_stream_append(struct string_stream *stream,
+			 struct string_stream *other)
+{
+	const char *other_content;
+
+	other_content = string_stream_get_string(other);
+
+	if (!other_content)
+		return -ENOMEM;
+
+	return string_stream_add(stream, other_content);
+}
+
+bool string_stream_is_empty(struct string_stream *stream)
+{
+	return list_empty(&stream->fragments);
+}
+
+struct string_stream_alloc_context {
+	struct kunit *test;
+	gfp_t gfp;
+};
+
+static int string_stream_init(struct kunit_resource *res, void *context)
+{
+	struct string_stream *stream;
+	struct string_stream_alloc_context *ctx = context;
+
+	stream = kunit_kzalloc(ctx->test, sizeof(*stream), ctx->gfp);
+	if (!stream)
+		return -ENOMEM;
+
+	res->allocation = stream;
+	stream->gfp = ctx->gfp;
+	stream->test = ctx->test;
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+
+	return 0;
+}
+
+static void string_stream_free(struct kunit_resource *res)
+{
+	/* Nothing to do since everything is already a KUnit managed resource */
+}
+
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
+{
+	struct string_stream_alloc_context context = {
+		.test = test,
+		.gfp = gfp
+	};
+
+	return kunit_alloc_resource(test,
+				    string_stream_init,
+				    string_stream_free,
+				    gfp,
+				    &context);
+}
-- 
2.23.0.rc1.153.gdeed80330f-goog

