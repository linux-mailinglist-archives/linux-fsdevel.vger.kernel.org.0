Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE3477778
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhLPQNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:13:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235618AbhLPQNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfEZtmmaw5JJQ7ii0AT2OTgmkRTAYnO5kVj9P9Pm5RY=;
        b=g/IzewW4AVKJ1sEjDUvxu0IpAFfKz19lbGmkRlFOJMijnEiTFTEstSIw6hi/CNwl7p7NvX
        UH9TBtoxfhJ4rFY4aR/rAywuPZPnWJpzv+zPS5RyXsK4d8aJrSu/cTy21cxdTfGVMcoBIe
        zy3g/fneiuThFl5YYRKUiVJv30LJc5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-0JGJZMYWMEC-3sZXSwfZgQ-1; Thu, 16 Dec 2021 11:13:18 -0500
X-MC-Unique: 0JGJZMYWMEC-3sZXSwfZgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03237802C96;
        Thu, 16 Dec 2021 16:13:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D52E77A227;
        Thu, 16 Dec 2021 16:12:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 23/68] fscache: Provide a function to let the netfs update
 its coherency data
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 16:12:57 +0000
Message-ID: <163967117795.1823006.7493373142653442595.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function to let the netfs update its coherency data:

	void fscache_update_cookie(struct fscache_cookie *cookie,
				   const void *aux_data,
				   const loff_t *object_size);

This will update the auxiliary data and/or the size of the object attached
to a cookie if either pointer is not-NULL and flag that the disk needs to
be updated.

Note that fscache_unuse_cookie() also allows this to be done.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819610438.215744.4223265964131424954.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906913530.143852.18150303220217653820.stgit@warthog.procyon.org.uk/ # v2
---

 include/linux/fscache.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index c4bb58eff7a3..9392812f10b7 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -339,6 +339,28 @@ void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data
 	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
 }
 
+/**
+ * fscache_update_cookie - Request that a cache object be updated
+ * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ * @object_size: The current size of the object (may be NULL)
+ *
+ * Request an update of the index data for the cache object associated with the
+ * cookie.  The auxiliary data on the cookie will be updated first if @aux_data
+ * is set and the object size will be updated and the object possibly trimmed
+ * if @object_size is set.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
+			   const loff_t *object_size)
+{
+	if (fscache_cookie_enabled(cookie))
+		__fscache_update_cookie(cookie, aux_data, object_size);
+}
+
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object


