Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199EF66872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfGLISF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 04:18:05 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56916 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfGLIR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:17:59 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so5102580pfa.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ef4x4rIYEjXAUsOwLGAl/ehMOJtbGdS1NNHHbtE3RYE=;
        b=Mw+DxFWgn2UniqboD1dRk6XjrDA3CHg3CHvx2mNvLra2gQLu6QxY3y6pCopNHSs+ZI
         Fi6NVxXoyccnGQ2T8yqPe9AiI78R/1PYyk0qSe6/XbpQmCK0bhO0+Ev+r1kvK7vrqk9F
         xSACVEbdZ2rcZiwZrpePWi2Dwevi7UHr6Mz/uERvlmSs31g3bXbv4EQq5QHANa6Xwz/A
         +dv+94sF6y7SjsOqwXqnckQWe6Em5K4eJ05Kficb9BHx8Xw7CE1AMXcEWpJm4MkIqzhW
         Jajh91IUVPDk12yXVZdJEYz4B1YMPRBy84Il1rDvmuJ6w1ypkVLGhWymq7lErBOPWTBW
         3BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ef4x4rIYEjXAUsOwLGAl/ehMOJtbGdS1NNHHbtE3RYE=;
        b=nnUZYFyw0s8uKpmw8VF9Spzl0S0k4o2YYh4Avfeb3WJV+4QJOkALLcn5oBSFj6i+iA
         tnj4LIM5KsDoKvPNzRF+bl66xExXH5y5yhTLxOlPlWwIV9Gdfk8h82NmXBdRdpS3/7vk
         o9ckmWVTuZJraV9PQHqjAdJvcoGQM1ckLdeQbY45A8e13Xd/4Wj/aShJ6aVHn6ZHzLhS
         1ISnogxJ2pvvK2wAYpxGjuxLNj5/1agi+LSp0+4qLpJw1EMD/RBX3Kwb6FKXJMwzOhFc
         Wwfg6MsEfnGekP1VK8oXEtLUqQdN+tooVmeMEDCyTRM3/amAeXBMpGRZbxKZnsZvRgP9
         sGIw==
X-Gm-Message-State: APjAAAV+sQSGu4P4j0AwTSq5vj1vuuVV6PiqGhyFsh0RuNhpQp+K4dTn
        EB3TTLH9+qf8jN1wmWUGmxh3celiyYwO4AaKXHDTdg==
X-Google-Smtp-Source: APXvYqzxaHrKpKSoTWmzAv9z5eUt7sRrrclIdIKIFKt9RhqLLf0Ka/qHg4gpiM5vj/2Rg1hpmUS+vzQFYgio8gyX/AikfQ==
X-Received: by 2002:a65:508c:: with SMTP id r12mr8647535pgp.1.1562919478365;
 Fri, 12 Jul 2019 01:17:58 -0700 (PDT)
Date:   Fri, 12 Jul 2019 01:17:29 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 03/18] kunit: test: add string_stream a std::stream like
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
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/string-stream.h |  49 ++++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 147 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..0552a05781afe
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
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+};
+
+struct kunit;
+
+struct string_stream *alloc_string_stream(struct kunit *test);
+
+void string_stream_get(struct string_stream *stream);
+
+int string_stream_put(struct string_stream *stream);
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *stream);
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
index 0000000000000..0463a92dad74b
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,147 @@
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
+	spin_lock_irqsave(&stream->lock, flags);
+	stream->length += len;
+	list_add_tail(&frag_container->node, &stream->fragments);
+	spin_unlock_irqrestore(&stream->lock, flags);
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	list_for_each_entry_safe(frag_container,
+				 frag_container_safe,
+				 &stream->fragments,
+				 node) {
+		list_del(&frag_container->node);
+		kfree(frag_container->fragment);
+		kfree(frag_container);
+	}
+	stream->length = 0;
+	spin_unlock_irqrestore(&stream->lock, flags);
+}
+
+char *string_stream_get_string(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container;
+	size_t buf_len = stream->length + 1; /* +1 for null byte. */
+	char *buf;
+	unsigned long flags;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	list_for_each_entry(frag_container, &stream->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return buf;
+}
+
+bool string_stream_is_empty(struct string_stream *stream)
+{
+	bool is_empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	is_empty = list_empty(&stream->fragments);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return is_empty;
+}
+
+static int string_stream_init(struct kunit_resource *res, void *context)
+{
+	struct string_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	res->allocation = stream;
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+
+	return 0;
+}
+
+static void string_stream_free(struct kunit_resource *res)
+{
+	struct string_stream *stream = res->allocation;
+
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+struct string_stream *alloc_string_stream(struct kunit *test)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_resource(test,
+				   string_stream_init,
+				   string_stream_free,
+				   NULL);
+
+	if (!res)
+		return NULL;
+
+	return res->allocation;
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

