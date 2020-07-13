Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8F21DCAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgGMQdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:33:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730458AbgGMQdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOWYXigZvYWiY8apzgv2t9nu9RfiJe//8dPmvbLaW1M=;
        b=fLiQLz8Xhksjwl5ltcXGa/5ZADX/rUK2HjhbtbW1mK+OPfo7O65P6FvJKaF2AHfVPwleis
        0rbGr//LXEWzsn4+mhQqAxfQFWVA3Uwxe4uRBi3gy8bYkxOwqzIOdL4KUgx9lnotWUx/gT
        mRY6FS4NeqW23PXLh6PttWmNr4UkUR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-RoEP98VlPS-IryIyEwbRWA-1; Mon, 13 Jul 2020 12:33:46 -0400
X-MC-Unique: RoEP98VlPS-IryIyEwbRWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DB6D1800D42;
        Mon, 13 Jul 2020 16:33:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A24E19D61;
        Mon, 13 Jul 2020 16:33:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/32] cachefiles: Split cachefiles_drop_object() up a bit
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:33:38 +0100
Message-ID: <159465801837.1376674.800536726710094793.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split cachefiles_drop_object() up a bit to make it easier to modify later.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c |   58 ++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index e4d1a82b9f33..56ed6f203e1c 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -192,6 +192,42 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	_leave("");
 }
 
+/*
+ * Commit changes to the object as we drop it.
+ */
+static void cachefiles_commit_object(struct cachefiles_object *object,
+				     struct cachefiles_cache *cache)
+{
+}
+
+/*
+ * Finalise and object and close the VFS structs that we have.
+ */
+static void cachefiles_clean_up_object(struct cachefiles_object *object,
+				       struct cachefiles_cache *cache,
+				       bool invalidate)
+{
+	if (invalidate && &object->fscache != cache->cache.fsdef) {
+		_debug("- inval object OBJ%x", object->fscache.debug_id);
+		cachefiles_delete_object(cache, object);
+	} else {
+		cachefiles_commit_object(object, cache);
+ 	}
+
+	/* close the filesystem stuff attached to the object */
+	if (object->backing_file)
+		fput(object->backing_file);
+	object->backing_file = NULL;
+
+	if (object->backer != object->dentry)
+		dput(object->backer);
+	object->backer = NULL;
+
+	cachefiles_unmark_inode_in_use(object, object->dentry);
+	dput(object->dentry);
+	object->dentry = NULL;
+}
+
 /*
  * discard the resources pinned by an object and effect retirement if
  * requested
@@ -223,25 +259,9 @@ static void cachefiles_drop_object(struct fscache_object *_object,
 	 * before we set it up.
 	 */
 	if (object->dentry) {
-		if (invalidate && _object != cache->cache.fsdef) {
-			_debug("- inval object OBJ%x", object->fscache.debug_id);
-			cachefiles_begin_secure(cache, &saved_cred);
-			cachefiles_delete_object(cache, object);
-			cachefiles_end_secure(cache, saved_cred);
-		}
-
-		/* close the filesystem stuff attached to the object */
-		if (object->backing_file)
-			fput(object->backing_file);
-		object->backing_file = NULL;
-
-		if (object->backer != object->dentry)
-			dput(object->backer);
-		object->backer = NULL;
-
-		cachefiles_unmark_inode_in_use(object, object->dentry);
-		dput(object->dentry);
-		object->dentry = NULL;
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_clean_up_object(object, cache, invalidate);
+		cachefiles_end_secure(cache, saved_cred);
 	}
 
 	_leave("");


