Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2843211D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhJRPBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232996AbhJRPBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpmC6KV6XlN7tGrzNmQxvfZVaWj4hw0BElRSYjH98xU=;
        b=fTLKzGAT4CDB0pcGljBFPZrxTSL1ayNf9dbRPEcjTE43E2yjyK8TlEVwWPahtbjHte/ULT
        BHPgGdZ87BotgUB+3N+XO/UX5zaa4XjoUBk1CHwjexuBjnQpP0EFQSCgtTVyDRZywzNKf0
        jbDU5V0I+qUc+RkI0H9dz8QaDWAXbaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-ncCaC32SNx61rESZ2ISbmQ-1; Mon, 18 Oct 2021 10:59:00 -0400
X-MC-Unique: ncCaC32SNx61rESZ2ISbmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CD1B802682;
        Mon, 18 Oct 2021 14:58:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84A8B5F4EE;
        Mon, 18 Oct 2021 14:58:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/67] cachefiles: Don't use XATTR_ flags with vfs_setxattr()
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:58:51 +0100
Message-ID: <163456913173.2614702.12279776553978969628.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't pass XATTR_CREATE/XATTR_REPLACE to vfs_setxattr(); just pass 0 as we
don't want to have to deal with the error or try to guess which we want to
use.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c |    2 +-
 fs/cachefiles/internal.h  |    3 +--
 fs/cachefiles/namei.c     |    2 +-
 fs/cachefiles/xattr.c     |    6 ++----
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 3e678ab14c85..674d3d75fa70 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -132,7 +132,7 @@ static void cachefiles_update_object(struct cachefiles_object *object)
 	cache = container_of(object->cache, struct cachefiles_cache, cache);
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	cachefiles_set_object_xattr(object, XATTR_REPLACE);
+	cachefiles_set_object_xattr(object);
 	cachefiles_end_secure(cache, saved_cred);
 	_leave("");
 }
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index ff00c5249f4f..92f90a5a4e93 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -162,8 +162,7 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 /*
  * xattr.c
  */
-extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				       unsigned int xattr_flags);
+extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index a60ef6f1cf1e..cb08be5fb28e 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -291,7 +291,7 @@ static int cachefiles_check_open_object(struct cachefiles_cache *cache,
 
 	if (object->new) {
 		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
+		ret = cachefiles_set_object_xattr(object);
 		if (ret < 0)
 			goto error_unmark;
 	} else {
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bfb2f4d605af..82c822bb71af 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -26,8 +26,7 @@ static const char cachefiles_xattr_cache[] =
 /*
  * set the state xattr on a cache file
  */
-int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				unsigned int xattr_flags)
+int cachefiles_set_object_xattr(struct cachefiles_object *object)
 {
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry;
@@ -51,8 +50,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 
 	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->cookie->flags);
 	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-			   buf, sizeof(struct cachefiles_xattr) + len,
-			   xattr_flags);
+			   buf, sizeof(struct cachefiles_xattr) + len, 0);
 	if (ret < 0) {
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
 					   0,


