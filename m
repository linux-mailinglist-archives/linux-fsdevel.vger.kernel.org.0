Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815BD437DC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhJVTJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234329AbhJVTJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FNAZqHV+9loKM6DOr8EgJ4Vdd0ANZRxxJWFLeXiMmw=;
        b=EQLvpWWkkYtO2Ooz4dS2GaWGk5PVYIdDnxV6QzAmqFUQIgcfO8PnJo5obYmT06sgCM/KNV
        f1prMGV5RBGpWygYmX1cpVK3K2Le/S38vxN93fTFdojO6pD/ZlFlqZ3zvJwYawdmdUvVSZ
        g7YpO7JC+7VrhczA9YN0uJRUX4GECJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-RwjIMXKIMcypyHTQiCX8MA-1; Fri, 22 Oct 2021 15:06:51 -0400
X-MC-Unique: RwjIMXKIMcypyHTQiCX8MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7353A801FCE;
        Fri, 22 Oct 2021 19:06:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74DF060C04;
        Fri, 22 Oct 2021 19:06:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 33/53] cachefiles: Add I/O error reporting macros
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:06:42 +0100
Message-ID: <163492960262.1038219.8002050280041934104.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a couple of macros to report I/O errors and to tell fscache that the
cache is in trouble.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/internal.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d615213a2fa1..230a1a2bf01d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -153,6 +153,26 @@ static inline int cachefiles_inject_remove_error(void)
 	return cachefiles_error_injection_state & 2 ? -EIO : 0;
 }
 
+/*
+ * error handling
+ */
+
+#define cachefiles_io_error(___cache, FMT, ...)		\
+do {							\
+	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
+	fscache_io_error((___cache)->cache);		\
+	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
+} while (0)
+
+#define cachefiles_io_error_obj(object, FMT, ...)			\
+do {									\
+	struct cachefiles_cache *___cache;				\
+									\
+	___cache = (object)->volume->cache;				\
+	cachefiles_io_error(___cache, FMT " [o=%08x]", ##__VA_ARGS__,	\
+			    (object)->debug_id);			\
+} while (0)
+
 
 /*
  * debug tracing


