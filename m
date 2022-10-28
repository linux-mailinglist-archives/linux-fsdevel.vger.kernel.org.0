Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45643611682
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJ1P5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJ1P5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FA1FAE53
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hD4C4nQ7xRmcZp5qL9JclgpJNpRpFxW4D4G1k8aIIk=;
        b=Xrb5BvbDY5U0curHlTQenFVUwWugnITpQ94Cpqw+eeacKRwvOpuL9PJiqFUcT0kgcKd/o7
        BVWF5RKnxMmBgj5ReAMSmniS4UnYjfXN9PTTvrs4TS0i5DwMlbHqIgQM4X/40bo/Fd1UzQ
        m9AWDoN0jEHIuMx///YpyyRZhVaUl14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-_9aY2-ObNCy1-v1RJdf4cw-1; Fri, 28 Oct 2022 11:56:17 -0400
X-MC-Unique: _9aY2-ObNCy1-v1RJdf4cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EF42800B23;
        Fri, 28 Oct 2022 15:56:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D84061410F36;
        Fri, 28 Oct 2022 15:56:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 4/9] cifs: Add a function to Hash the contents of an
 iterator
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Oct 2022 16:56:14 +0100
Message-ID: <166697257423.61150.12070648579830206483.stgit@warthog.procyon.org.uk>
In-Reply-To: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
References: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to push the contents of a BVEC-, KVEC- or XARRAY-type
iterator into a symmetric hash algorithm.

UBUF- and IOBUF-type iterators are not supported on the assumption that
either we're doing buffered I/O, in which case we won't see them, or we're
doing direct I/O, in which case the iterator will have been extracted into
a BVEC-type iterator higher up.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cifs/cifsencrypt.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 5db73c0f792a..f7d1843b4671 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -24,6 +24,145 @@
 #include "../smbfs_common/arc4.h"
 #include <crypto/aead.h>
 
+/*
+ * Hash data from a BVEC-type iterator.
+ */
+static int cifs_shash_bvec(const struct iov_iter *iter, ssize_t maxsize,
+			   struct shash_desc *shash)
+{
+	const struct bio_vec *bv = iter->bvec;
+	unsigned long start = iter->iov_offset;
+	unsigned int i;
+	void *p;
+	int ret;
+
+	for (i = 0; i < iter->nr_segs; i++) {
+		size_t off, len;
+
+		len = bv[i].bv_len;
+		if (start >= len) {
+			start -= len;
+			continue;
+		}
+
+		len = min_t(size_t, maxsize, len - start);
+		off = bv[i].bv_offset + start;
+
+		p = kmap_local_page(bv[i].bv_page);
+		ret = crypto_shash_update(shash, p + off, len);
+		kunmap_local(p);
+		if (ret < 0)
+			return ret;
+
+		maxsize -= len;
+		if (maxsize <= 0)
+			break;
+		start = 0;
+	}
+
+	return 0;
+}
+
+/*
+ * Hash data from a KVEC-type iterator.
+ */
+static int cifs_shash_kvec(const struct iov_iter *iter, ssize_t maxsize,
+			   struct shash_desc *shash)
+{
+	const struct kvec *kv = iter->kvec;
+	unsigned long start = iter->iov_offset;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < iter->nr_segs; i++) {
+		size_t len;
+
+		len = kv[i].iov_len;
+		if (start >= len) {
+			start -= len;
+			continue;
+		}
+
+		len = min_t(size_t, maxsize, len - start);
+		ret = crypto_shash_update(shash, kv[i].iov_base + start, len);
+		if (ret < 0)
+			return ret;
+		maxsize -= len;
+
+		if (maxsize <= 0)
+			break;
+		start = 0;
+	}
+
+	return 0;
+}
+
+/*
+ * Hash data from an XARRAY-type iterator.
+ */
+static ssize_t cifs_shash_xarray(const struct iov_iter *iter, ssize_t maxsize,
+				 struct shash_desc *shash)
+{
+	struct xarray *xa = iter->xarray;
+	struct folio *folio;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	ssize_t ret = 0;
+	size_t offset, len;
+	void *p;
+	XA_STATE(xas, xa, index);
+
+	rcu_read_lock();
+
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		offset = offset_in_folio(folio, start);
+		len = min_t(size_t, maxsize, folio_size(folio) - offset);
+
+		p = kmap_local_folio(folio, offset);
+		ret = crypto_shash_update(shash, p, len);
+		kunmap_local(p);
+		if (ret < 0)
+			break;
+
+		maxsize -= len;
+		if (maxsize <= 0)
+			break;
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
+ * Pass the data from an iterator into a hash.
+ */
+static int cifs_shash_iter(const struct iov_iter *iter, size_t maxsize,
+			   struct shash_desc *shash)
+{
+	if (maxsize == 0)
+		return 0;
+
+	switch (iov_iter_type(iter)) {
+	case ITER_BVEC:
+		return cifs_shash_bvec(iter, maxsize, shash);
+	case ITER_KVEC:
+		return cifs_shash_kvec(iter, maxsize, shash);
+	case ITER_XARRAY:
+		return cifs_shash_xarray(iter, maxsize, shash);
+	default:
+		pr_err("cifs_shash_iter(%u) unsupported\n", iov_iter_type(iter));
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+}
+
 int __cifs_calc_signature(struct smb_rqst *rqst,
 			struct TCP_Server_Info *server, char *signature,
 			struct shash_desc *shash)


