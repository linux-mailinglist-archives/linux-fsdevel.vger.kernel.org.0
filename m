Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6659E85E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbiHWRBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbiHWRA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35554AB061
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaH2AXIr8IkrERhakovdF8HxFgyqS7bc+HlbREkYcpI=;
        b=eG1XzCp5taXY4AnriMJ7Qrw5hQogagESwt8/C6raSMc8cJ5Cb09mV3q9/K7lip+qXAWvFS
        PcjV1gM26jDU/DRgLLi590xeGB8iPXfUIhlh0+6Gr6XZ3PXoWfi7yHzndQmbnxR+GIgmbx
        PoaTgFATDgUU0HQqd+wb0rZmzVi731A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669--V0VPTa5NiCd2lXJ_2ye9g-1; Tue, 23 Aug 2022 10:12:23 -0400
X-MC-Unique: -V0VPTa5NiCd2lXJ_2ye9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE46894B8E0;
        Tue, 23 Aug 2022 14:12:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94815C15BB3;
        Tue, 23 Aug 2022 14:12:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/7] iov_iter: Add a general purpose iteration function
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Aug 2022 15:12:21 +0100
Message-ID: <166126394098.708021.10931745751914856461.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function, iov_iter_scan(), to iterate over the buffers described by
an I/O iterator, kmapping and passing each contiguous chunk the the
supplied scanner function in turn, up to the requested amount of data or
until the scanner function returns an error.

This can be used, for example, to hash all the data in an iterator by
having the scanner function call the appropriate crypto update function.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    4 +++
 lib/iov_iter.c      |   66 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 88fd93508710..76a3aeca8703 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -259,6 +259,10 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
+ssize_t iov_iter_scan(struct iov_iter *i, size_t bytes,
+		      ssize_t (*scanner)(struct iov_iter *i, const void *p,
+					 size_t len, size_t off, void *priv),
+		      void *priv);
 
 static inline size_t iov_iter_count(const struct iov_iter *i)
 {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c07bf978b935..3f22822a946c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -21,9 +21,11 @@
 	size_t __maybe_unused off = 0;				\
 	len = n;						\
 	base = __p + i->iov_offset;				\
-	len -= (STEP);						\
-	i->iov_offset += len;					\
-	n = len;						\
+	do {							\
+		len -= (STEP);					\
+		i->iov_offset += len;				\
+		n = len;					\
+	} while (0);						\
 }
 
 /* covers iovec and kvec alike */
@@ -1611,6 +1613,64 @@ ssize_t extract_iter_to_iter(struct iov_iter *orig,
 }
 EXPORT_SYMBOL(extract_iter_to_iter);
 
+/**
+ * iov_iter_scan - Scan a source iter
+ * @i: The iterator to scan
+ * @bytes: The amount of buffer/data to scan
+ * @scanner: The function to call to process each segment
+ * @priv: Private data to pass to the scanner function
+ *
+ * Scan an iterator, passing each segment to the scanner function.  If the
+ * scanner returns an error at any time, scanning stops and the error is
+ * returned, otherwise the sum of the scanner results is returned.
+ */
+ssize_t iov_iter_scan(struct iov_iter *i, size_t bytes,
+		      ssize_t (*scanner)(struct iov_iter *i, const void *p,
+					 size_t len, size_t off, void *priv),
+		      void *priv)
+{
+	unsigned int gup_flags = 0;
+	ssize_t ret = 0, scanned = 0;
+
+	if (!bytes)
+		return 0;
+	if (WARN_ON(iov_iter_is_discard(i)))
+		return 0;
+	if (iter_is_iovec(i))
+		might_fault();
+
+	if (iov_iter_rw(i) != WRITE)
+		gup_flags |= FOLL_WRITE;
+	if (i->nofault)
+		gup_flags |= FOLL_NOFAULT;
+
+	iterate_and_advance(
+		i, bytes, base, len, off, ({
+				struct page *page;
+				void *q;
+
+				ret = get_user_pages_fast((unsigned long)base, 1,
+							  gup_flags, &page);
+				if (ret < 0)
+					break;
+				q = kmap_local_page(page);
+				ret = scanner(i, q, len, off, priv);
+				kunmap_local(q);
+				put_page(page);
+				if (ret < 0)
+					break;
+				scanned += ret;
+			}), ({
+				ret = scanner(i, base, len, off, priv);
+				if (ret < 0)
+					break;
+				scanned += ret;
+			})
+	);
+	return ret < 0 ? ret : scanned;
+}
+EXPORT_SYMBOL(iov_iter_scan);
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {


