Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D61A477865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhLPQU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239506AbhLPQUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+iGRLDbEa+SF2KgOzldUhFU8lIJiDS/NtFbSdv7JK0=;
        b=F6/4OHGcRyRHZk2x2QWlXzoLze/8hLw4Pxb69srZIUaY7UkRCGqyr6KmTfJr2t/nSIxtl1
        VacdFoEibyFIC79PWwGRQOGk9EVcOGbIx0yF2drOtXa/waxBYGl4d6L+IhaEnUk9KZMUID
        5m4tQ985WvXZPhemHkYNvmtIgLPZlYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-52tVd8dbNT-l04EaDIbUzQ-1; Thu, 16 Dec 2021 11:20:50 -0500
X-MC-Unique: 52tVd8dbNT-l04EaDIbUzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DA6F801B31;
        Thu, 16 Dec 2021 16:20:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCBB4795AE;
        Thu, 16 Dec 2021 16:20:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 52/68] fscache, cachefiles: Store the volume coherency data
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
Date:   Thu, 16 Dec 2021 16:20:43 +0000
Message-ID: <163967164397.1823006.2950539849831291830.stgit@warthog.procyon.org.uk>
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

Store the volume coherency data in an xattr and check it when we rebind the
volume.  If it doesn't match the cache volume is moved to the graveyard and
rebuilt anew.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/internal.h          |    2 +
 fs/cachefiles/volume.c            |   25 ++++++++++-
 fs/cachefiles/xattr.c             |   82 +++++++++++++++++++++++++++++++++++++
 fs/fscache/volume.c               |   14 +++++-
 include/linux/fscache.h           |    2 +
 include/trace/events/cachefiles.h |   42 ++++++++++++++++++-
 6 files changed, 161 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d5868f5514d3..abdd1b66f6b9 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -270,6 +270,8 @@ extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct cachefiles_object *object,
 					  struct dentry *dentry);
 extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
+extern bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume);
+extern int cachefiles_check_volume_xattr(struct cachefiles_volume *volume);
 
 /*
  * Error handling
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 4a14f5e72764..89df0ba8ba5e 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -22,7 +22,8 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 	struct dentry *vdentry, *fan;
 	size_t len;
 	char *name;
-	int n_accesses, i;
+	bool is_new = false;
+	int ret, n_accesses, i;
 
 	_enter("");
 
@@ -43,11 +44,29 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 	memcpy(name + 1, vcookie->key + 1, len);
 	name[len + 1] = 0;
 
-	vdentry = cachefiles_get_directory(cache, cache->store, name, NULL);
+retry:
+	vdentry = cachefiles_get_directory(cache, cache->store, name, &is_new);
 	if (IS_ERR(vdentry))
 		goto error_name;
 	volume->dentry = vdentry;
 
+	if (is_new) {
+		if (!cachefiles_set_volume_xattr(volume))
+			goto error_dir;
+	} else {
+		ret = cachefiles_check_volume_xattr(volume);
+		if (ret < 0) {
+			if (ret != -ESTALE)
+				goto error_dir;
+			inode_lock_nested(d_inode(cache->store), I_MUTEX_PARENT);
+			cachefiles_bury_object(cache, NULL, cache->store, vdentry,
+					       FSCACHE_VOLUME_IS_WEIRD);
+			cachefiles_put_directory(volume->dentry);
+			cond_resched();
+			goto retry;
+		}
+	}
+	
 	for (i = 0; i < 256; i++) {
 		sprintf(name, "@%02x", i);
 		fan = cachefiles_get_directory(cache, vdentry, name, NULL);
@@ -74,6 +93,7 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 error_fan:
 	for (i = 0; i < 256; i++)
 		cachefiles_put_directory(volume->fanout[i]);
+error_dir:
 	cachefiles_put_directory(volume->dentry);
 error_name:
 	kfree(name);
@@ -114,5 +134,6 @@ void cachefiles_free_volume(struct fscache_volume *vcookie)
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
 {
 	fscache_withdraw_volume(volume->vcookie);
+	cachefiles_set_volume_xattr(volume);
 	__cachefiles_free_volume(volume);
 }
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 0601c46a22ef..4881da2c189a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -179,3 +179,85 @@ void cachefiles_prepare_to_write(struct fscache_cookie *cookie)
 		cachefiles_end_secure(cache, saved_cred);
 	}
 }
+
+/*
+ * Set the state xattr on a volume directory.
+ */
+bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
+{
+	unsigned int len = volume->vcookie->coherency_len;
+	const void *p = volume->vcookie->coherency;
+	struct dentry *dentry = volume->dentry;
+	int ret;
+
+	_enter("%x,#%d", volume->vcookie->debug_id, len);
+
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+				   p, len, 0);
+	if (ret < 0) {
+		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
+					   cachefiles_trace_setxattr_error);
+		trace_cachefiles_vol_coherency(volume, d_inode(dentry)->i_ino,
+					       cachefiles_coherency_vol_set_fail);
+		if (ret != -ENOMEM)
+			cachefiles_io_error(
+				volume->cache, "Failed to set xattr with error %d", ret);
+	} else {
+		trace_cachefiles_vol_coherency(volume, d_inode(dentry)->i_ino,
+					       cachefiles_coherency_vol_set_ok);
+	}
+
+	_leave(" = %d", ret);
+	return ret == 0;
+}
+
+/*
+ * Check the consistency between the backing cache and the volume cookie.
+ */
+int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
+{
+	struct cachefiles_xattr *buf;
+	struct dentry *dentry = volume->dentry;
+	unsigned int len = volume->vcookie->coherency_len;
+	const void *p = volume->vcookie->coherency;
+	enum cachefiles_coherency_trace why;
+	ssize_t xlen;
+	int ret = -ESTALE;
+
+	_enter("");
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	kdebug("COOK %*phN", (int)len, p);
+
+	xlen = cachefiles_inject_read_error();
+	if (xlen == 0)
+		xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, len);
+	if (xlen >= 0)
+		kdebug("DISK %*phN", (int)xlen, buf);
+	if (xlen != len) {
+		if (xlen < 0) {
+			trace_cachefiles_vfs_error(NULL, d_inode(dentry), xlen,
+						   cachefiles_trace_getxattr_error);
+			if (xlen == -EIO)
+				cachefiles_io_error(
+					volume->cache,
+					"Failed to read xattr with error %zd", xlen);
+		}
+		why = cachefiles_coherency_vol_check_xattr;
+	} else if (memcmp(buf->data, p, len) != 0) {
+		why = cachefiles_coherency_vol_check_cmp;
+	} else {
+		why = cachefiles_coherency_vol_check_ok;
+		ret = 0;
+	}
+
+	trace_cachefiles_vol_coherency(volume, d_inode(dentry)->i_ino, why);
+	kfree(buf);
+	_leave(" = %d", ret);
+	return ret;
+}
diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index e1a8e92a6adb..a57c6cbee858 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -205,15 +205,22 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
 	size_t klen, hlen;
 	char *key;
 
+	if (!coherency_data)
+		coherency_len = 0;
+
 	cache = fscache_lookup_cache(cache_name, false);
 	if (IS_ERR(cache))
 		return NULL;
 
-	volume = kzalloc(sizeof(*volume), GFP_KERNEL);
+	volume = kzalloc(struct_size(volume, coherency, coherency_len),
+			 GFP_KERNEL);
 	if (!volume)
 		goto err_cache;
 
 	volume->cache = cache;
+	volume->coherency_len = coherency_len;
+	if (coherency_data)
+		memcpy(volume->coherency, coherency_data, coherency_len);
 	INIT_LIST_HEAD(&volume->proc_link);
 	INIT_WORK(&volume->work, fscache_create_volume_work);
 	refcount_set(&volume->ref, 1);
@@ -421,8 +428,11 @@ void __fscache_relinquish_volume(struct fscache_volume *volume,
 	if (WARN_ON(test_and_set_bit(FSCACHE_VOLUME_RELINQUISHED, &volume->flags)))
 		return;
 
-	if (invalidate)
+	if (invalidate) {
 		set_bit(FSCACHE_VOLUME_INVALIDATE, &volume->flags);
+	} else if (coherency_data) {
+		memcpy(volume->coherency, coherency_data, volume->coherency_len);
+	}
 
 	fscache_put_volume(volume, fscache_volume_put_relinquish);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 0bdd5166d20b..9ad3e44418d2 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -87,6 +87,8 @@ struct fscache_volume {
 #define FSCACHE_VOLUME_COLLIDED_WITH	2	/* Volume was collided with */
 #define FSCACHE_VOLUME_ACQUIRE_PENDING	3	/* Volume is waiting to complete acquisition */
 #define FSCACHE_VOLUME_CREATING		4	/* Volume is being created on disk */
+	u8				coherency_len;	/* Length of the coherency data */
+	u8				coherency[];	/* Coherency data */
 };
 
 /*
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index ab1376ebc3ab..1172529b5b49 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -40,6 +40,7 @@ enum fscache_why_object_killed {
 	FSCACHE_OBJECT_NO_SPACE,
 	FSCACHE_OBJECT_WAS_RETIRED,
 	FSCACHE_OBJECT_WAS_CULLED,
+	FSCACHE_VOLUME_IS_WEIRD,
 };
 
 enum cachefiles_coherency_trace {
@@ -53,6 +54,11 @@ enum cachefiles_coherency_trace {
 	cachefiles_coherency_check_xattr,
 	cachefiles_coherency_set_fail,
 	cachefiles_coherency_set_ok,
+	cachefiles_coherency_vol_check_cmp,
+	cachefiles_coherency_vol_check_ok,
+	cachefiles_coherency_vol_check_xattr,
+	cachefiles_coherency_vol_set_fail,
+	cachefiles_coherency_vol_set_ok,
 };
 
 enum cachefiles_trunc_trace {
@@ -103,7 +109,8 @@ enum cachefiles_error_trace {
 	EM(FSCACHE_OBJECT_INVALIDATED,	"inval")		\
 	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
 	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
-	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
+	EM(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")		\
+	E_(FSCACHE_VOLUME_IS_WEIRD,	"volume_weird")
 
 #define cachefiles_obj_ref_traces					\
 	EM(cachefiles_obj_get_ioreq,		"GET ioreq")		\
@@ -129,7 +136,12 @@ enum cachefiles_error_trace {
 	EM(cachefiles_coherency_check_type,	"BAD type")		\
 	EM(cachefiles_coherency_check_xattr,	"BAD xatt")		\
 	EM(cachefiles_coherency_set_fail,	"SET fail")		\
-	E_(cachefiles_coherency_set_ok,		"SET ok  ")
+	EM(cachefiles_coherency_set_ok,		"SET ok  ")		\
+	EM(cachefiles_coherency_vol_check_cmp,	"VOL BAD cmp ")		\
+	EM(cachefiles_coherency_vol_check_ok,	"VOL OK      ")		\
+	EM(cachefiles_coherency_vol_check_xattr,"VOL BAD xatt")		\
+	EM(cachefiles_coherency_vol_set_fail,	"VOL SET fail")		\
+	E_(cachefiles_coherency_vol_set_ok,	"VOL SET ok  ")
 
 #define cachefiles_trunc_traces						\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
@@ -365,6 +377,32 @@ TRACE_EVENT(cachefiles_coherency,
 		      __entry->content)
 	    );
 
+TRACE_EVENT(cachefiles_vol_coherency,
+	    TP_PROTO(struct cachefiles_volume *volume,
+		     ino_t ino,
+		     enum cachefiles_coherency_trace why),
+
+	    TP_ARGS(volume, ino, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			vol	)
+		    __field(enum cachefiles_coherency_trace,	why	)
+		    __field(u64,				ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vol	= volume->vcookie->debug_id;
+		    __entry->why	= why;
+		    __entry->ino	= ino;
+			   ),
+
+	    TP_printk("V=%08x %s i=%llx",
+		      __entry->vol,
+		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
+		      __entry->ino)
+	    );
+
 TRACE_EVENT(cachefiles_prep_read,
 	    TP_PROTO(struct netfs_read_subrequest *sreq,
 		     enum netfs_read_source source,


