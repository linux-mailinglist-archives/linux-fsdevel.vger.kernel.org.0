Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB25B46EFC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhLIRFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:05:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242103AbhLIRFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrKXAzbpWHk53feaNBvAPFmb8wcxJDfNE5ctJ3LgpTQ=;
        b=BMqV4pEKTRdCxqV973JUnBSK7GnydEY47W5+UWKpffkOOjcTIoRJY1Ly/nLL14efgU/oHe
        Lu2n/OwP4dpEFCI3Hm8BlOdT4x36dyMvFm/iEpPwvkzheb5ddqgUap1gUzvqCCVRNiHBpe
        +VLZY8s1sr0PAQPWyr48+mh+87mt8Nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-9mEHMT8UMMuJcPyhnG7hMQ-1; Thu, 09 Dec 2021 12:01:28 -0500
X-MC-Unique: 9mEHMT8UMMuJcPyhnG7hMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1005893920;
        Thu,  9 Dec 2021 17:01:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6A25D740;
        Thu,  9 Dec 2021 17:01:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 35/67] cachefiles: Add security derivation
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
Date:   Thu, 09 Dec 2021 17:01:21 +0000
Message-ID: <163906928172.143852.15886637013364286786.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement code to derive a new set of creds for the cachefiles to use when
making VFS or I/O calls and to change the auditing info since the
application interacting with the network filesystem is not accessing the
cache directly.  Cachefiles uses override_creds() to change the effective
creds temporarily.

set_security_override_from_ctx() is called to derive the LSM 'label' that
the cachefiles driver will act with.  set_create_files_as() is called to
determine the LSM 'label' that will be applied to files and directories
created in the cache.  These functions alter the new creds.

Also implement a couple of functions to wrap the calls to begin/end cred
overriding.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819627469.215744.3603633690679962985.stgit@warthog.procyon.org.uk/ # v1
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


