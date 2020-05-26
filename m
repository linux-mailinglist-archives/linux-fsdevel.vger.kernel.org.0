Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164101C41B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgEDRNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:13:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730169AbgEDRNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oFa1vS6VuksoCBz6Y5xSemRXF9UQeInxvJtlN1GiHg=;
        b=ddLXsfOOEoneNhB658GINzpcpCrlHObhioA4l3xDb5njcaJH4qF9hk04+nKJom/bSwrs/S
        6nVUXx244yT8CrDplOJH84eZazUoydwAkqSw/7DWX8Sur7hNvv+/xyj3aAhZqHDKKG1xa9
        jxVtZB96w4Y2AaW+HSEqyiIr5L/510c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-wDCP42rZP_OGbGzlKUVJ9A-1; Mon, 04 May 2020 13:13:29 -0400
X-MC-Unique: wDCP42rZP_OGbGzlKUVJ9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8652F107ACCA;
        Mon,  4 May 2020 17:13:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D365B9CB9;
        Mon,  4 May 2020 17:13:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 39/61] fscache: Display cache-specific data in
 /proc/fs/fscache/objects
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
Date:   Mon, 04 May 2020 18:13:24 +0100
Message-ID: <158861240398.340223.11820866022324019865.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the cache to add information in /proc/fs/fscache/objects instead of
displaying cookie key and aux data - which can be seen in the cookies file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c   |   41 +++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c     |    1 +
 fs/cachefiles/internal.h      |    1 +
 fs/fscache/object-list.c      |   33 +++------------------------------
 include/linux/fscache-cache.h |    4 ++++
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index dea28948f006..02236b24f914 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -408,3 +408,44 @@ void cachefiles_save_content_map(struct cachefiles_object *object)
 
 	_leave(" = %zd", ret);
 }
+
+/*
+ * Display object information in proc.
+ */
+int cachefiles_display_object(struct seq_file *m, struct fscache_object *_object)
+{
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+
+	if (object->fscache.cookie->type == FSCACHE_COOKIE_TYPE_INDEX) {
+		if (object->content_info != CACHEFILES_CONTENT_NO_DATA)
+			seq_printf(m, " ???%u???", object->content_info);
+	} else {
+		switch (object->content_info) {
+		case CACHEFILES_CONTENT_NO_DATA:
+			seq_puts(m, " <n>");
+			break;
+		case CACHEFILES_CONTENT_SINGLE:
+			seq_puts(m, " <s>");
+			break;
+		case CACHEFILES_CONTENT_ALL:
+			seq_puts(m, " <a>");
+			break;
+		case CACHEFILES_CONTENT_MAP:
+			read_lock_bh(&object->content_map_lock);
+			if (object->content_map) {
+				seq_printf(m, " %*phN",
+					   object->content_map_size,
+					   object->content_map);
+			}
+			read_unlock_bh(&object->content_map_lock);
+			break;
+		default:
+			seq_printf(m, " <%u>", object->content_info);
+			break;
+		}
+	}
+
+	seq_putc(m, '\n');
+	return 0;
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index feff39dff0f5..4fcbd788d3b2 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -495,4 +495,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.shape_extent		= cachefiles_shape_extent,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.display_object		= cachefiles_display_object,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 43f8e71136dd..32cb55319a7d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -133,6 +133,7 @@ extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
 extern bool cachefiles_load_content_map(struct cachefiles_object *object);
 extern void cachefiles_save_content_map(struct cachefiles_object *object);
+extern int cachefiles_display_object(struct seq_file *m, struct fscache_object *object);
 
 /*
  * daemon.c
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index 5777f909d31a..361610e124bd 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -155,7 +155,6 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	struct fscache_cookie *cookie;
 	unsigned long config = data->config;
 	char _type[3], *type;
-	u8 *p;
 
 	if ((unsigned long) v == 1) {
 		seq_puts(m, "OBJECT   PARENT   USE CHLDN OPS FL  S"
@@ -201,8 +200,6 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 		   obj->stage);
 
 	if (obj->cookie) {
-		uint16_t keylen = 0, auxlen = 0;
-
 		switch (cookie->type) {
 		case 0:
 			type = "IX";
@@ -211,8 +208,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			type = "DT";
 			break;
 		default:
-			snprintf(_type, sizeof(_type), "%02u",
-				 cookie->type);
+			snprintf(_type, sizeof(_type), "%02x", cookie->type);
 			type = _type;
 			break;
 		}
@@ -223,34 +219,11 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			   type,
 			   cookie->stage,
 			   cookie->flags);
-
-		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-			keylen = cookie->key_len;
-
-		if (config & FSCACHE_OBJLIST_CONFIG_AUX)
-			auxlen = cookie->aux_len;
-
-		if (keylen > 0 || auxlen > 0) {
-			seq_puts(m, " ");
-			p = keylen <= sizeof(cookie->inline_key) ?
-				cookie->inline_key : cookie->key;
-			for (; keylen > 0; keylen--)
-				seq_printf(m, "%02x", *p++);
-			if (auxlen > 0) {
-				if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-					seq_puts(m, ", ");
-				p = auxlen <= sizeof(cookie->inline_aux) ?
-					cookie->inline_aux : cookie->aux;
-				for (; auxlen > 0; auxlen--)
-					seq_printf(m, "%02x", *p++);
-			}
-		}
-
-		seq_puts(m, "\n");
 	} else {
 		seq_puts(m, "<no_netfs>\n");
 	}
-	return 0;
+
+	return obj->cache->ops->display_object(m, obj);
 }
 
 static const struct seq_operations fscache_objlist_ops = {
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 1d235072239d..f82c998917e0 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -19,6 +19,7 @@
 
 #define NR_MAXCACHES BITS_PER_LONG
 
+struct seq_file;
 struct fscache_cache;
 struct fscache_cache_ops;
 struct fscache_object;
@@ -152,6 +153,9 @@ struct fscache_cache_ops {
 	int (*write)(struct fscache_object *object,
 		     struct fscache_io_request *req,
 		     struct iov_iter *iter);
+
+	/* Display object info in /proc/fs/fscache/objects */
+	int (*display_object)(struct seq_file *m, struct fscache_object *object);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;


