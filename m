Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F107A1C417C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgEDRMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:12:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730328AbgEDRMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIrjlq2VnpmK/3Hp0Ssw1MB4Ua57/058b88LSE0s9AA=;
        b=e7hOYZV849P1/OIAwbDJ3GZOm63wvWIw7HIAfGOdtJ5VeggCOILzqnID43/naMORyL0rLE
        O3p6oBmH6ZKZdmJs0HtZKmjp4LeSarMMq2Cin6JmIqP0YblfjOFgLp1jcJ81sWOH0QY9Gu
        tifch57ph+ONIlaDcJ5gbpQpLCmEZDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-NVnMB4uBNJWy30i3867d-w-1; Mon, 04 May 2020 13:12:06 -0400
X-MC-Unique: NVnMB4uBNJWy30i3867d-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4777E107ACF2;
        Mon,  4 May 2020 17:12:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DB262DE74;
        Mon,  4 May 2020 17:12:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 30/61] cachefiles: Split cachefiles_drop_object() up a bit
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:12:00 +0100
Message-ID: <158861232027.340223.4423626519002421674.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
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
index daa4f316d104..47596b58c2da 100644
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


