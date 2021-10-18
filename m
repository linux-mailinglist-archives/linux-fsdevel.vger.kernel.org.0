Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E64320C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhJRO6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232912AbhJRO5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWJr+o5XEJdul/wxaFN3vlOPvUxwAzrbc+cKwab9/Mo=;
        b=hP/Sy2ly7sANAMeH0NBpVD55+EXzw4RS9uBraZu1lDdP7WfTGogLzARiBXH0aogyR0s3Gw
        QG3DuO3agj7AkXYz+A2Ds1Pt28NpNPA4f0refctCJhnp9w07fatwqrnEngNrq4kuW7d398
        x47UNz3dyb3UesgJuKftvYc+h8wMU8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Fg7w_fGOOiS33-k-QeKtrg-1; Mon, 18 Oct 2021 10:55:42 -0400
X-MC-Unique: Fg7w_fGOOiS33-k-QeKtrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7541E806668;
        Mon, 18 Oct 2021 14:55:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97EE85D6D7;
        Mon, 18 Oct 2021 14:55:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/67] cachefiles: Don't set an xattr on the root of the cache
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
Date:   Mon, 18 Oct 2021 15:55:33 +0100
Message-ID: <163456893374.2614702.11747731163000539462.stgit@warthog.procyon.org.uk>
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

cachefiles_check_object_type() sets an xattr on the root of the cache, but
it's pointless because it never conveys any useful information, so don't do
that.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c     |    4 --
 fs/cachefiles/internal.h |    1 -
 fs/cachefiles/xattr.c    |   76 ----------------------------------------------
 3 files changed, 81 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index d463d89f5db8..6720c07f3d85 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -199,10 +199,6 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	fsdef->dentry = cachedir;
 	fsdef->fscache.cookie = NULL;
 
-	ret = cachefiles_check_object_type(fsdef);
-	if (ret < 0)
-		goto error_unsupported;
-
 	/* get the graveyard directory */
 	graveyard = cachefiles_get_directory(cache, root, "graveyard");
 	if (IS_ERR(graveyard)) {
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 0515add2b7e8..6464a6821bfb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -169,7 +169,6 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 /*
  * xattr.c
  */
-extern int cachefiles_check_object_type(struct cachefiles_object *object);
 extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
 				       unsigned int xattr_flags);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object);
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcc4a2dfe1e8..8b9f30f9ce21 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -23,82 +23,6 @@ struct cachefiles_xattr {
 static const char cachefiles_xattr_cache[] =
 	XATTR_USER_PREFIX "CacheFiles.cache";
 
-/*
- * check the type label on an object
- * - done using xattrs
- */
-int cachefiles_check_object_type(struct cachefiles_object *object)
-{
-	struct dentry *dentry = object->dentry;
-	char type[3], xtype[3];
-	int ret;
-
-	ASSERT(dentry);
-	ASSERT(d_backing_inode(dentry));
-
-	if (!object->fscache.cookie)
-		strcpy(type, "C3");
-	else
-		snprintf(type, 3, "%02x", object->fscache.cookie->type);
-
-	_enter("%x{%s}", object->fscache.debug_id, type);
-
-	/* attempt to install a type label directly */
-	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, type,
-			   2, XATTR_CREATE);
-	if (ret == 0) {
-		_debug("SET"); /* we succeeded */
-		goto error;
-	}
-
-	if (ret != -EEXIST) {
-		pr_err("Can't set xattr on %pd [%lu] (err %d)\n",
-		       dentry, d_backing_inode(dentry)->i_ino,
-		       -ret);
-		goto error;
-	}
-
-	/* read the current type label */
-	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, xtype,
-			   3);
-	if (ret < 0) {
-		if (ret == -ERANGE)
-			goto bad_type_length;
-
-		pr_err("Can't read xattr on %pd [%lu] (err %d)\n",
-		       dentry, d_backing_inode(dentry)->i_ino,
-		       -ret);
-		goto error;
-	}
-
-	/* check the type is what we're expecting */
-	if (ret != 2)
-		goto bad_type_length;
-
-	if (xtype[0] != type[0] || xtype[1] != type[1])
-		goto bad_type;
-
-	ret = 0;
-
-error:
-	_leave(" = %d", ret);
-	return ret;
-
-bad_type_length:
-	pr_err("Cache object %lu type xattr length incorrect\n",
-	       d_backing_inode(dentry)->i_ino);
-	ret = -EIO;
-	goto error;
-
-bad_type:
-	xtype[2] = 0;
-	pr_err("Cache object %pd [%lu] type %s not %s\n",
-	       dentry, d_backing_inode(dentry)->i_ino,
-	       xtype, type);
-	ret = -EIO;
-	goto error;
-}
-
 /*
  * set the state xattr on a cache file
  */


