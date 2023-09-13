Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2537D79EFA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjIMQ6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjIMQ6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFC181FD0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTW4hj6R6SH2WgBE9Xhmo5Z05cFVRaLxhGn+V3gLo/A=;
        b=HyYyDGQ5+crGYtT2e4BA+No/lpFhxIcPzQ57idYmn6PZxoZx3CZBjMaC+nl3vTWz4wXxiz
        4dwxQeN+tVtJvHhBiFplrnh21kWeHat6QoJDIgGQNevcMkrTlwR/NKBznW4RLDyQNM5bus
        JZCH/y3oowQa5deYcKHGtssGnu07wws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-kw6qakgRMmKfBnOo7mji8A-1; Wed, 13 Sep 2023 12:57:27 -0400
X-MC-Unique: kw6qakgRMmKfBnOo7mji8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D8F6855321;
        Wed, 13 Sep 2023 16:57:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C823740C6EA8;
        Wed, 13 Sep 2023 16:57:23 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v4 13/13] iov_iter: Create a fake device to allow iov_iter testing/benchmarking
Date:   Wed, 13 Sep 2023 17:56:48 +0100
Message-ID: <20230913165648.2570623-14-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a fake device to allow testing and benchmarking of UBUF and IOVEC
iterators.  /dev/iov-test is created and can be driven with pwritev() in
which case it copies everything to a sink page and it can be written with
preadv() in which case it copies repeatedly from a patterned page.

The time taken is logged with tracepoints.

This can be driven by something like:

	echo 1 >/sys/kernel/debug/tracing/events/iov_test/enable
	cmd="r -b 1M -V 256 0 256M"; xfs_io -c "open /dev/iov-test" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd"
	cmd="w -b 1M -V 256 0 256M"; xfs_io -c "open /dev/iov-test" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd" \
	    -c "$cmd" -c "$cmd" -c "$cmd" -c "$cmd"

showing something like:

         ...: iov_test_read: size=10000000 done=10000000 ty=1 nr=256 dur=27653
         ...: iov_test_write: size=10000000 done=10000000 ty=1 nr=256 dur=31792

in the trace log.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
cc: netdev@vger.kernel.org
---
 lib/Kconfig.debug         |   8 +++
 lib/Makefile              |   1 +
 lib/test_iov_iter.c       | 134 ++++++++++++++++++++++++++++++++++++++
 lib/test_iov_iter_trace.h |  80 +++++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 lib/test_iov_iter.c
 create mode 100644 lib/test_iov_iter_trace.h

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fa307f93fa2e..cf8392c51344 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2524,6 +2524,14 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config TEST_IOV_ITER
+	tristate "iov_iter test driver"
+	help
+	  This creates a misc device that can be used as a way to test various
+	  I/O iterator functions through the use of readv/writev and ioctl.
+
+	  If unsure, say N.
+
 config BITFIELD_KUNIT
 	tristate "KUnit test bitfield functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..f6419544a749 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -65,6 +65,7 @@ CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
+obj-$(CONFIG_TEST_IOV_ITER) += test_iov_iter.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
diff --git a/lib/test_iov_iter.c b/lib/test_iov_iter.c
new file mode 100644
index 000000000000..afa70647dbde
--- /dev/null
+++ b/lib/test_iov_iter.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* I/O iterator testing device.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/uio.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/miscdevice.h>
+#define CREATE_TRACE_POINTS
+#include "test_iov_iter_trace.h"
+
+MODULE_DESCRIPTION("iov_iter testing");
+MODULE_AUTHOR("David Howells <dhowells@redhat.com>");
+MODULE_LICENSE("GPL");
+
+static ssize_t iov_test_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct folio *folio = iocb->ki_filp->private_data;
+	unsigned int nr_segs = iter->nr_segs;
+	size_t size = iov_iter_count(iter), fsize = folio_size(folio);
+	size_t copied = 0, offset = 0, i;
+	ktime_t a, b;
+	u8 *p;
+
+	/* Pattern the buffer */
+	p = kmap_local_folio(folio, 0);
+	for (i = 0; i < folio_size(folio); i++)
+		p[i] = i & 0xff;
+	kunmap_local(p);
+
+	a = ktime_get_real();
+	while (iov_iter_count(iter)) {
+		size_t done, part = min(iov_iter_count(iter), fsize - offset);
+
+		done = copy_folio_to_iter(folio, offset, part, iter);
+		if (done == 0)
+			break;
+		copied += done;
+		offset = (offset + done) & (fsize - 1);
+	}
+
+	b = ktime_get_real();
+	trace_iov_test_read(size, copied, iov_iter_type(iter), nr_segs,
+			    ktime_to_us(ktime_sub(b, a)));
+	return copied;
+}
+
+static ssize_t iov_test_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct folio *folio = iocb->ki_filp->private_data;
+	unsigned int nr_segs = iter->nr_segs;
+	size_t size = iov_iter_count(iter), fsize = folio_size(folio);
+	size_t copied = 0, offset = 0;
+	ktime_t a = ktime_get_real(), b;
+
+	while (iov_iter_count(iter)) {
+		size_t done, part = min(iov_iter_count(iter), fsize - offset);
+
+		done = copy_page_from_iter(folio_page(folio, 0), offset, part, iter);
+		if (done == 0)
+			break;
+		copied += done;
+		offset = (offset + done) & (fsize - 1);
+	}
+
+	b = ktime_get_real();
+	trace_iov_test_write(size, copied, iov_iter_type(iter), nr_segs,
+			     ktime_to_us(ktime_sub(b, a)));
+	return copied;
+}
+
+static int iov_test_open(struct inode *inode, struct file *file)
+{
+	struct folio *folio;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	folio = folio_alloc(GFP_KERNEL, 0);
+	if (!folio)
+		return -ENOMEM;
+	file->private_data = folio;
+	return 0;
+}
+
+static int iov_test_release(struct inode *inode, struct file *file)
+{
+	struct folio *folio = file->private_data;
+
+	folio_put(folio);
+	return 0;
+}
+
+static const struct file_operations iov_test_fops = {
+	.owner		= THIS_MODULE,
+	.open		= iov_test_open,
+	.release	= iov_test_release,
+	.read_iter	= iov_test_read_iter,
+	.write_iter	= iov_test_write_iter,
+	.splice_read	= copy_splice_read,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice iov_test_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "iov-test",
+	.fops	= &iov_test_fops,
+};
+
+static int __init iov_test_init(void)
+{
+	int ret;
+
+	ret = misc_register(&iov_test_dev);
+	if (ret < 0)
+		return ret;
+	pr_info("Loaded\n");
+	return 0;
+}
+module_init(iov_test_init);
+
+static void __exit iov_test_exit(void)
+{
+	pr_info("Unloading\n");
+
+	misc_deregister(&iov_test_dev);
+}
+module_exit(iov_test_exit);
diff --git a/lib/test_iov_iter_trace.h b/lib/test_iov_iter_trace.h
new file mode 100644
index 000000000000..b99cade5d004
--- /dev/null
+++ b/lib/test_iov_iter_trace.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* I/O iterator testing device.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iov_test
+
+#if !defined(_IOV_TEST_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _IOV_TEST_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(iov_test_read,
+	    TP_PROTO(size_t size, size_t done, enum iter_type type,
+		     unsigned int nr_segs, u64 duration),
+
+	    TP_ARGS(size, done, type, nr_segs, duration),
+
+	    TP_STRUCT__entry(
+		    __field(size_t,		size)
+		    __field(size_t,		done)
+		    __field(enum iter_type,	type)
+		    __field(unsigned int,	nr_segs)
+		    __field(u64,		duration)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->size = size;
+		    __entry->done = done;
+		    __entry->type = type;
+		    __entry->nr_segs = nr_segs;
+		    __entry->duration = duration;
+			   ),
+
+	    TP_printk("size=%zx done=%zx ty=%u nr=%u dur=%llu",
+		      __entry->size,
+		      __entry->done,
+		      __entry->type,
+		      __entry->nr_segs,
+		      __entry->duration)
+	    );
+
+TRACE_EVENT(iov_test_write,
+	    TP_PROTO(size_t size, size_t done, enum iter_type type,
+		     unsigned int nr_segs, u64 duration),
+
+	    TP_ARGS(size, done, type, nr_segs, duration),
+
+	    TP_STRUCT__entry(
+		    __field(size_t,		size)
+		    __field(size_t,		done)
+		    __field(enum iter_type,	type)
+		    __field(unsigned int,	nr_segs)
+		    __field(u64,		duration)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->size = size;
+		    __entry->done = done;
+		    __entry->type = type;
+		    __entry->nr_segs = nr_segs;
+		    __entry->duration = duration;
+			   ),
+
+	    TP_printk("size=%zx done=%zx ty=%u nr=%u dur=%llu",
+		      __entry->size,
+		      __entry->done,
+		      __entry->type,
+		      __entry->nr_segs,
+		      __entry->duration)
+	    );
+
+#endif /* _IOV_TEST_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE test_iov_iter_trace
+#include <trace/define_trace.h>

