Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324F8461934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhK2OhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345152AbhK2Oe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bE5Gto+7nYyvi5eMJQpt4mYL96rzfV9P3tzaPwOz8zw=;
        b=Fd31ceurswoWClk7Wns0JpNrC7U5lPxDd2yyLQ0kBrsObVfHQaxEDVCClFWXsGF9hAXRPk
        4RELmxB8vuIRzFNMk9h/nvE7a9GGCqIDCt4JDifqDX7/CRrboiGVNnw/LPcb5GN1WSjJbM
        8FeSwcRao5CJNcCRHnjMMONXLk954zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-garRu2PsPAKXcHlylIBMSA-1; Mon, 29 Nov 2021 09:31:36 -0500
X-MC-Unique: garRu2PsPAKXcHlylIBMSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B611937FFC;
        Mon, 29 Nov 2021 14:31:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82AA545D60;
        Mon, 29 Nov 2021 14:31:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 35/64] cachefiles: Add security derivation
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:31:14 +0000
Message-ID: <163819627469.215744.3603633690679962985.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cachefiles/Makefile   |    3 +
 fs/cachefiles/internal.h |   20 ++++++++
 fs/cachefiles/security.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/security.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 183fb5f3b8b1..28bbb0d14868 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -4,7 +4,8 @@
 #
 
 cachefiles-y := \
-	main.o
+	main.o \
+	security.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b2adcb59b4ce..e57ce5ef875c 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -104,6 +104,26 @@ static inline int cachefiles_inject_remove_error(void)
 	return cachefiles_error_injection_state & 2 ? -EIO : 0;
 }
 
+/*
+ * security.c
+ */
+extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
+extern int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
+					       struct dentry *root,
+					       const struct cred **_saved_cred);
+
+static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
+					   const struct cred **_saved_cred)
+{
+	*_saved_cred = override_creds(cache->cache_cred);
+}
+
+static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
+					 const struct cred *saved_cred)
+{
+	revert_creds(saved_cred);
+}
+
 /*
  * Error handling
  */
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
new file mode 100644
index 000000000000..fe777164f1d8
--- /dev/null
+++ b/fs/cachefiles/security.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles security management
+ *
+ * Copyright (C) 2007, 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/cred.h>
+#include "internal.h"
+
+/*
+ * determine the security context within which we access the cache from within
+ * the kernel
+ */
+int cachefiles_get_security_ID(struct cachefiles_cache *cache)
+{
+	struct cred *new;
+	int ret;
+
+	_enter("{%s}", cache->secctx);
+
+	new = prepare_kernel_cred(current);
+	if (!new) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	if (cache->secctx) {
+		ret = set_security_override_from_ctx(new, cache->secctx);
+		if (ret < 0) {
+			put_cred(new);
+			pr_err("Security denies permission to nominate security context: error %d\n",
+			       ret);
+			goto error;
+		}
+	}
+
+	cache->cache_cred = new;
+	ret = 0;
+error:
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * see if mkdir and create can be performed in the root directory
+ */
+static int cachefiles_check_cache_dir(struct cachefiles_cache *cache,
+				      struct dentry *root)
+{
+	int ret;
+
+	ret = security_inode_mkdir(d_backing_inode(root), root, 0);
+	if (ret < 0) {
+		pr_err("Security denies permission to make dirs: error %d",
+		       ret);
+		return ret;
+	}
+
+	ret = security_inode_create(d_backing_inode(root), root, 0);
+	if (ret < 0)
+		pr_err("Security denies permission to create files: error %d",
+		       ret);
+
+	return ret;
+}
+
+/*
+ * check the security details of the on-disk cache
+ * - must be called with security override in force
+ * - must return with a security override in force - even in the case of an
+ *   error
+ */
+int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
+					struct dentry *root,
+					const struct cred **_saved_cred)
+{
+	struct cred *new;
+	int ret;
+
+	_enter("");
+
+	/* duplicate the cache creds for COW (the override is currently in
+	 * force, so we can use prepare_creds() to do this) */
+	new = prepare_creds();
+	if (!new)
+		return -ENOMEM;
+
+	cachefiles_end_secure(cache, *_saved_cred);
+
+	/* use the cache root dir's security context as the basis with
+	 * which create files */
+	ret = set_create_files_as(new, d_backing_inode(root));
+	if (ret < 0) {
+		abort_creds(new);
+		cachefiles_begin_secure(cache, _saved_cred);
+		_leave(" = %d [cfa]", ret);
+		return ret;
+	}
+
+	put_cred(cache->cache_cred);
+	cache->cache_cred = new;
+
+	cachefiles_begin_secure(cache, _saved_cred);
+	ret = cachefiles_check_cache_dir(cache, root);
+
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	_leave(" = %d", ret);
+	return ret;
+}


