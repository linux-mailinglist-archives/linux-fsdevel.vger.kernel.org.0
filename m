Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09F699F57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBPVuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjBPVuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B3505D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlR4JcCg1XC8eTF3I+rHcc7NxJf4yOAtTyxChrY5i+Y=;
        b=VT2rfh7p893K3pJAWXnPOkIWNv6LQzhfKaLkFff+/jMS0XTO4x4e+r2S+1zm7rg3gWBnXL
        Z3NcNYAkEVX9djgoJ7T9FDt/EIPV1xZfbVxOWMiBA1e1As4HmFd0jgigyaB22CALrvDg+B
        Wfns/iC2MCWuue0RDdmWhVY9IR5hHVE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-Qs6jji0IPnqiPKBLR7YHAw-1; Thu, 16 Feb 2023 16:48:39 -0500
X-MC-Unique: Qs6jji0IPnqiPKBLR7YHAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C9431C05AF6;
        Thu, 16 Feb 2023 21:48:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E0D751FF;
        Thu, 16 Feb 2023 21:48:36 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>, linux-crypto@vger.kernel.org
Subject: [PATCH 11/17] cifs: Add a function to Hash the contents of an iterator
Date:   Thu, 16 Feb 2023 21:47:39 +0000
Message-Id: <20230216214745.3985496-12-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-crypto@vger.kernel.org

Link: https://lore.kernel.org/r/166697257423.61150.12070648579830206483.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732029577.3186319.17162612653237909961.stgit@warthog.procyon.org.uk/ # rfc
---
 fs/cifs/cifsencrypt.c | 144 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index cbc18b4a9cb2..7be589aeb520 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -24,6 +24,150 @@
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
+	struct folio *folios[16], *folio;
+	unsigned int nr, i, j, npages;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t last, index = start / PAGE_SIZE;
+	ssize_t ret = 0;
+	size_t len, offset, foffset;
+	void *p;
+
+	if (maxsize == 0)
+		return 0;
+
+	last = (start + maxsize - 1) / PAGE_SIZE;
+	do {
+		nr = xa_extract(iter->xarray, (void **)folios, index, last,
+				ARRAY_SIZE(folios), XA_PRESENT);
+		if (nr == 0)
+			return -EIO;
+
+		for (i = 0; i < nr; i++) {
+			folio = folios[i];
+			npages = folio_nr_pages(folio);
+			foffset = start - folio_pos(folio);
+			offset = foffset % PAGE_SIZE;
+			for (j = foffset / PAGE_SIZE; j < npages; j++) {
+				len = min_t(size_t, maxsize, PAGE_SIZE - offset);
+				p = kmap_local_page(folio_page(folio, j));
+				ret = crypto_shash_update(shash, p, len);
+				kunmap_local(p);
+				if (ret < 0)
+					return ret;
+				maxsize -= len;
+				if (maxsize <= 0)
+					return 0;
+				start += len;
+				offset = 0;
+				index++;
+			}
+		}
+	} while (nr == ARRAY_SIZE(folios));
+	return 0;
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

