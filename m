Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8954F535E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351047AbiE0Ko2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351038AbiE0KoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BE005716A
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653648257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81g6TLubS0BUdbR5ajxUofL0J/LtNw5cIh2f43naGp0=;
        b=OquIflHqUjTIplJmKYex4hW18Qw8Ikh1vcsMSMjlgxn0UMd9WUs+sYpxOV65yQtPh6F5QH
        4yoDSkUHpfCdKUBMdFmCQsr9jq/Vwl916R1kaBqNS3g0rCc0QsB5DIbMZPXDSBRJCHJmMS
        8dNruuC6ot7zED4Kbd5TNcI7RoVsAbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-MHatlRJ0Nv-Sf1xE2-nxKg-1; Fri, 27 May 2022 06:44:12 -0400
X-MC-Unique: MHatlRJ0Nv-Sf1xE2-nxKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DDC0800882;
        Fri, 27 May 2022 10:44:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65707C27E8F;
        Fri, 27 May 2022 10:44:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 2/9] iov_iter: Add a general purpose iteration function
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 May 2022 11:44:09 +0100
Message-ID: <165364824973.3334034.10715738699511650662.stgit@warthog.procyon.org.uk>
In-Reply-To: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
References: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function, iov_iter_scan(), to iterate over the buffers described by
an I/O iterator, kmapping and passing each contiguous chunk the supplied
scanner function in turn, up to the requested amount of data or until the
scanner function returns an error.

This can be used, for example, to hash all the data in an iterator by
having the scanner function call the appropriate crypto update function.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    4 ++++
 lib/iov_iter.c      |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5a3c6f296b96..8d89203064e7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -244,6 +244,10 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
+ssize_t iov_iter_scan(struct iov_iter *i, size_t bytes,
+		      ssize_t (*scanner)(struct iov_iter *i, const void *p,
+					 size_t len, size_t off, void *priv),
+		      void *priv);
 
 static inline size_t iov_iter_count(const struct iov_iter *i)
 {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8db34ddd23be..834e1e268eb6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1789,6 +1789,46 @@ ssize_t extract_iter_to_iter(struct iov_iter *orig,
 }
 EXPORT_SYMBOL(extract_iter_to_iter);
 
+/**
+ * iov_iter_scan - Scan a source iter
+ * @i: The iterator to scan
+ * @bytes: The amount of buffer/data to scan
+ * @scanner: The function to call for each bit
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
+	ssize_t ret = 0, scanned = 0;
+
+	if (!bytes)
+		return 0;
+	if (iter_is_iovec(i))
+		might_fault();
+
+	iterate_and_advance(
+		i, bytes, base, len, off, ({
+				ret = scanner(i, base, len, off, priv);
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


