Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B96660AE9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 01:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbjAGAfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 19:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjAGAfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4870287287
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673051654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5FqX6wgeTJdF7BCkVTnz37qBgc2kKUyMX+o8KfLQEw=;
        b=MSnY6Rdfp/4lxnVy+uJznPcUK6Am7Fdt29CN6ZMulC6E7BgwIlPBK/FAWMAATe0NbkEzd0
        kHXymXi1CVu8JviKyZj8NlAA5VrATQpj7k6UlGlD1nlhJd4nX9uvMoWGKK5BjQ5YtSfq5W
        BAz1iwS2p3kGWlbK8AtFzYcy7vpplEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-i1vVWkQjNnuSPL2FXwyBrA-1; Fri, 06 Jan 2023 19:34:09 -0500
X-MC-Unique: i1vVWkQjNnuSPL2FXwyBrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF31A1871CD5;
        Sat,  7 Jan 2023 00:34:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A1FF40C2064;
        Sat,  7 Jan 2023 00:34:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 5/7] netfs: Add a function to extract a UBUF or IOVEC into
 a BVEC iterator
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Jan 2023 00:34:06 +0000
Message-ID: <167305164634.1521586.12199658904363317567.stgit@warthog.procyon.org.uk>
In-Reply-To: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
References: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to extract the pages from a user-space supplied iterator
(UBUF- or IOVEC-type) into a BVEC-type iterator, retaining the pages by
getting a ref on them (ITER_SOURCE, ie. WRITE) or pinning them (ITER_DEST,
ie. READ) as we go.

This is useful in three situations:

 (1) A userspace thread may have a sibling that unmaps or remaps the
     process's VM during the operation, changing the assignment of the
     pages and potentially causing an error.  Retaining the pages keeps
     some pages around, even if this occurs; futher, we find out at the
     point of extraction if EFAULT is going to be incurred.

 (2) Pages might get swapped out/discarded if not retained, so we want to
     retain them to avoid the reload causing a deadlock due to a DIO
     from/to an mmapped region on the same file.

 (3) The iterator may get passed to sendmsg() by the filesystem.  If a
     fault occurs, we may get a short write to a TCP stream that's then
     tricky to recover from.

We don't deal with other types of iterator here, leaving it to other
mechanisms to retain the pages (eg. PG_locked, PG_writeback and the pipe
lock).

Changes:
========
ver #3)
 - Switch to using EXPORT_SYMBOL_GPL to prevent indirect 3rd-party access
   to get/pin_user_pages_fast()[1].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cachefs@redhat.com
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org

Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [1]
Link: https://lore.kernel.org/r/166697255265.61150.6289490555867717077.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732026503.3186319.12020462741051772825.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166869690376.3723671.8813331570219190705.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166920904810.1461876.11603559311247187100.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166997422579.9475.12101700945635692496.stgit@warthog.procyon.org.uk/ # v3
---

 fs/netfs/Makefile     |    1 
 fs/netfs/iterator.c   |   99 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |    3 +
 3 files changed, 103 insertions(+)
 create mode 100644 fs/netfs/iterator.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index f684c0cd1ec5..386d6fb92793 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -3,6 +3,7 @@
 netfs-y := \
 	buffered_read.o \
 	io.o \
+	iterator.o \
 	main.o \
 	objects.o
 
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
new file mode 100644
index 000000000000..7d802d21b9c5
--- /dev/null
+++ b/fs/netfs/iterator.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Iterator helpers.
+ *
+ * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+/**
+ * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
+ * @orig: The original iterator
+ * @orig_len: The amount of iterator to copy
+ * @new: The iterator to be set up
+ * @cleanup_mode: Where to indicate the cleanup mode
+ *
+ * Extract the page fragments from the given amount of the source iterator and
+ * build up a second iterator that refers to all of those bits.  This allows
+ * the original iterator to disposed of.
+ *
+ * On success, the number of elements in the bvec is returned, the original
+ * iterator will have been advanced by the amount extracted and @*cleanup_mode
+ * will have been set to FOLL_GET, FOLL_PIN or 0.
+ */
+ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
+				struct iov_iter *new, unsigned int *cleanup_mode)
+{
+	struct bio_vec *bv = NULL;
+	struct page **pages;
+	unsigned int cur_npages;
+	unsigned int max_pages;
+	unsigned int npages = 0;
+	unsigned int i;
+	ssize_t ret;
+	size_t count = orig_len, offset, len;
+	size_t bv_size, pg_size;
+
+	if (WARN_ON_ONCE(!iter_is_ubuf(orig) && !iter_is_iovec(orig)))
+		return -EIO;
+
+	max_pages = iov_iter_npages(orig, INT_MAX);
+	bv_size = array_size(max_pages, sizeof(*bv));
+	bv = kvmalloc(bv_size, GFP_KERNEL);
+	if (!bv)
+		return -ENOMEM;
+
+	*cleanup_mode = 0;
+
+	/* Put the page list at the end of the bvec list storage.  bvec
+	 * elements are larger than page pointers, so as long as we work
+	 * 0->last, we should be fine.
+	 */
+	pg_size = array_size(max_pages, sizeof(*pages));
+	pages = (void *)bv + bv_size - pg_size;
+
+	while (count && npages < max_pages) {
+		ret = iov_iter_extract_pages(orig, &pages, count,
+					     max_pages - npages, 0,
+					     &offset, cleanup_mode);
+		if (ret < 0) {
+			pr_err("Couldn't get user pages (rc=%zd)\n", ret);
+			break;
+		}
+
+		if (ret > count) {
+			pr_err("get_pages rc=%zd more than %zu\n", ret, count);
+			break;
+		}
+
+		count -= ret;
+		ret += offset;
+		cur_npages = DIV_ROUND_UP(ret, PAGE_SIZE);
+
+		if (npages + cur_npages > max_pages) {
+			pr_err("Out of bvec array capacity (%u vs %u)\n",
+			       npages + cur_npages, max_pages);
+			break;
+		}
+
+		for (i = 0; i < cur_npages; i++) {
+			len = ret > PAGE_SIZE ? PAGE_SIZE : ret;
+			bv[npages + i].bv_page	 = *pages++;
+			bv[npages + i].bv_offset = offset;
+			bv[npages + i].bv_len	 = len - offset;
+			ret -= len;
+			offset = 0;
+		}
+
+		npages += cur_npages;
+	}
+
+	iov_iter_bvec(new, iov_iter_rw(orig), bv, npages, orig_len - count);
+	return npages;
+}
+EXPORT_SYMBOL_GPL(netfs_extract_user_iter);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4c76ddfb6a67..26fe3e6bafa1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -296,6 +296,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  bool was_async, enum netfs_sreq_ref_trace what);
 void netfs_stats_show(struct seq_file *);
+ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
+				struct iov_iter *new,
+				unsigned int *cleanup_mode);
 
 /**
  * netfs_inode - Get the netfs inode context from the inode


