Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E846F104
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhLIRNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:13:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238921AbhLIRNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sx81cPvA9NmmzebBgJUBEjpIjxPiC73r2+9ONDWpYFU=;
        b=h2XeghsBAZSV7NGDml7waGf/je8Cmmug9uXoh8qx+Zre6mrpWvT661oUuTEFg6Aj9tA0MQ
        nDaHT3ANCl9lflXum1Yo8JvO2BqiEJJG4o0K+QjBHnvOLd4g3h9ZMjZbdaMW9OwXrr2F/A
        ZkWTu5mibbuiNq+3cr6Wx2nxbOfpaTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-pW1JTvlZPW-NtxDLK_Mhqw-1; Thu, 09 Dec 2021 12:09:37 -0500
X-MC-Unique: pW1JTvlZPW-NtxDLK_Mhqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5E491006AA0;
        Thu,  9 Dec 2021 17:09:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19B31100164A;
        Thu,  9 Dec 2021 17:09:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 60/67] 9p: Use fscache indexing rewrite and reenable
 caching
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Thu, 09 Dec 2021 17:09:10 +0000
Message-ID: <163906975017.143852.3459573173204394039.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the 9p filesystem to take account of the changes to fscache's
indexing rewrite and reenable caching in 9p.

The following changes have been made:

 (1) The fscache_netfs struct is no more, and there's no need to register
     the filesystem as a whole.

 (2) The session cookie is now an fscache_volume cookie, allocated with
     fscache_acquire_volume().  That takes three parameters: a string
     representing the "volume" in the index, a string naming the cache to
     use (or NULL) and a u64 that conveys coherency metadata for the
     volume.

     For 9p, I've made it render the volume name string as:

	"9p,<devname>,<cachetag>"

     where the cachetag is replaced by the aname if it wasn't supplied.

     This probably needs rethinking a bit as the aname can have slashes in
     it.  It might be better to hash the cachetag and use the hash or I
     could substitute commas for the slashes or something.

 (3) The fscache_cookie_def is no more and needed information is passed
     directly to fscache_acquire_cookie().  The cache no longer calls back
     into the filesystem, but rather metadata changes are indicated at
     other times.

     fscache_acquire_cookie() is passed the same keying and coherency
     information as before.

 (4) The functions to set/reset/flush cookies are removed and
     fscache_use_cookie() and fscache_unuse_cookie() are used instead.

     fscache_use_cookie() is passed a flag to indicate if the cookie is
     opened for writing.  fscache_unuse_cookie() is passed updates for the
     metadata if we changed it (ie. if the file was opened for writing).

     These are called when the file is opened or closed.

 (5) wait_on_page_bit[_killable]() is replaced with the specific wait
     functions for the bits waited upon.

 (6) I've got rid of some of the 9p-specific cache helper functions and
     called things like fscache_relinquish_cookie() directly as they'll
     optimise away if v9fs_inode_cookie() returns an unconditional NULL
     (which will be the case if CONFIG_9P_FSCACHE=n).

 (7) v9fs_vfs_setattr() is made to call fscache_resize() to change the size
     of the cache object.

Notes:

 (A) We should call fscache_invalidate() if we detect that the server's
     copy of a file got changed by a third party, but I don't know where to
     do that.  We don't need to do that when allocating the cookie as we
     get a check-and-invalidate when we initially bind to the cache object.

 (B) The copy-to-cache-on-writeback side of things will be handled in
     separate patch.

Changes
=======
ver #2:
 - Use gfpflags_allow_blocking() rather than using flag directly.
 - fscache_acquire_volume() now returns errors.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@gmail.com>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: v9fs-developer@lists.sourceforge.net
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819664645.215744.1555314582005286846.stgit@warthog.procyon.org.uk/ # v1
---

 fs/9p/Kconfig          |    2 
 fs/9p/cache.c          |  193 ++++++++----------------------------------------
 fs/9p/cache.h          |   25 +-----
 fs/9p/v9fs.c           |   17 +---
 fs/9p/v9fs.h           |   13 +++
 fs/9p/vfs_addr.c       |    8 +-
 fs/9p/vfs_dir.c        |   11 +++
 fs/9p/vfs_file.c       |    3 -
 fs/9p/vfs_inode.c      |   22 +++--
 fs/9p/vfs_inode_dotl.c |    3 -
 10 files changed, 87 insertions(+), 210 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index b3d33b3ddb98..d7bc93447c85 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -14,7 +14,7 @@ config 9P_FS
 if 9P_FS
 config 9P_FSCACHE
 	bool "Enable 9P client caching support"
-	depends on 9P_FS=m && FSCACHE_OLD_API || 9P_FS=y && FSCACHE_OLD_API=y
+	depends on 9P_FS=m && FSCACHE || 9P_FS=y && FSCACHE=y
 	help
 	  Choose Y here to enable persistent, read-only local
 	  caching support for 9p clients using FS-Cache
diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index f2ba131cede1..dc51779fd9eb 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -16,89 +16,37 @@
 #include "v9fs.h"
 #include "cache.h"
 
-#define CACHETAG_LEN  11
-
-struct fscache_netfs v9fs_cache_netfs = {
-	.name		= "9p",
-	.version	= 0,
-};
-
-/*
- * v9fs_random_cachetag - Generate a random tag to be associated
- *			  with a new cache session.
- *
- * The value of jiffies is used for a fairly randomly cache tag.
- */
-
-static
-int v9fs_random_cachetag(struct v9fs_session_info *v9ses)
+int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
+				  const char *dev_name)
 {
-	v9ses->cachetag = kmalloc(CACHETAG_LEN, GFP_KERNEL);
-	if (!v9ses->cachetag)
-		return -ENOMEM;
+	struct fscache_volume *vcookie;
+	char *name, *p;
 
-	return scnprintf(v9ses->cachetag, CACHETAG_LEN, "%lu", jiffies);
-}
-
-const struct fscache_cookie_def v9fs_cache_session_index_def = {
-	.name		= "9P.session",
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
+	name = kasprintf(GFP_KERNEL, "9p,%s,%s",
+			 dev_name, v9ses->cachetag ?: v9ses->aname);
+	if (!name)
+		return -ENOMEM;
 
-void v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses)
-{
-	/* If no cache session tag was specified, we generate a random one. */
-	if (!v9ses->cachetag) {
-		if (v9fs_random_cachetag(v9ses) < 0) {
-			v9ses->fscache = NULL;
-			kfree(v9ses->cachetag);
-			v9ses->cachetag = NULL;
-			return;
+	for (p = name; *p; p++)
+		if (*p == '/')
+			*p = ';';
+
+	vcookie = fscache_acquire_volume(name, NULL, 0);
+	p9_debug(P9_DEBUG_FSC, "session %p get volume %p (%s)\n",
+		 v9ses, vcookie, name);
+	if (IS_ERR(vcookie)) {
+		if (vcookie != ERR_PTR(-EBUSY)) {
+			kfree(name);
+			return PTR_ERR(vcookie);
 		}
+		pr_err("Cache volume key already in use (%s)\n", name);
+		vcookie = NULL;
 	}
-
-	v9ses->fscache = fscache_acquire_cookie(v9fs_cache_netfs.primary_index,
-						&v9fs_cache_session_index_def,
-						v9ses->cachetag,
-						strlen(v9ses->cachetag),
-						NULL, 0,
-						v9ses, 0, true);
-	p9_debug(P9_DEBUG_FSC, "session %p get cookie %p\n",
-		 v9ses, v9ses->fscache);
-}
-
-void v9fs_cache_session_put_cookie(struct v9fs_session_info *v9ses)
-{
-	p9_debug(P9_DEBUG_FSC, "session %p put cookie %p\n",
-		 v9ses, v9ses->fscache);
-	fscache_relinquish_cookie(v9ses->fscache, NULL, false);
-	v9ses->fscache = NULL;
-}
-
-static enum
-fscache_checkaux v9fs_cache_inode_check_aux(void *cookie_netfs_data,
-					    const void *buffer,
-					    uint16_t buflen,
-					    loff_t object_size)
-{
-	const struct v9fs_inode *v9inode = cookie_netfs_data;
-
-	if (buflen != sizeof(v9inode->qid.version))
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	if (memcmp(buffer, &v9inode->qid.version,
-		   sizeof(v9inode->qid.version)))
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	return FSCACHE_CHECKAUX_OKAY;
+	v9ses->fscache = vcookie;
+	kfree(name);
+	return 0;
 }
 
-const struct fscache_cookie_def v9fs_cache_inode_index_def = {
-	.name		= "9p.inode",
-	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= v9fs_cache_inode_check_aux,
-};
-
 void v9fs_cache_inode_get_cookie(struct inode *inode)
 {
 	struct v9fs_inode *v9inode;
@@ -108,94 +56,19 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
 		return;
 
 	v9inode = V9FS_I(inode);
-	if (v9inode->fscache)
+	if (WARN_ON(v9inode->fscache))
 		return;
 
 	v9ses = v9fs_inode2v9ses(inode);
-	v9inode->fscache = fscache_acquire_cookie(v9ses->fscache,
-						  &v9fs_cache_inode_index_def,
-						  &v9inode->qid.path,
-						  sizeof(v9inode->qid.path),
-						  &v9inode->qid.version,
-						  sizeof(v9inode->qid.version),
-						  v9inode,
-						  i_size_read(&v9inode->vfs_inode),
-						  true);
+	v9inode->fscache =
+		fscache_acquire_cookie(v9fs_session_cache(v9ses),
+				       0,
+				       &v9inode->qid.path,
+				       sizeof(v9inode->qid.path),
+				       &v9inode->qid.version,
+				       sizeof(v9inode->qid.version),
+				       i_size_read(&v9inode->vfs_inode));
 
 	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
 		 inode, v9inode->fscache);
 }
-
-void v9fs_cache_inode_put_cookie(struct inode *inode)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-
-	if (!v9inode->fscache)
-		return;
-	p9_debug(P9_DEBUG_FSC, "inode %p put cookie %p\n",
-		 inode, v9inode->fscache);
-
-	fscache_relinquish_cookie(v9inode->fscache, &v9inode->qid.version,
-				  false);
-	v9inode->fscache = NULL;
-}
-
-void v9fs_cache_inode_flush_cookie(struct inode *inode)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-
-	if (!v9inode->fscache)
-		return;
-	p9_debug(P9_DEBUG_FSC, "inode %p flush cookie %p\n",
-		 inode, v9inode->fscache);
-
-	fscache_relinquish_cookie(v9inode->fscache, NULL, true);
-	v9inode->fscache = NULL;
-}
-
-void v9fs_cache_inode_set_cookie(struct inode *inode, struct file *filp)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-
-	if (!v9inode->fscache)
-		return;
-
-	mutex_lock(&v9inode->fscache_lock);
-
-	if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
-		v9fs_cache_inode_flush_cookie(inode);
-	else
-		v9fs_cache_inode_get_cookie(inode);
-
-	mutex_unlock(&v9inode->fscache_lock);
-}
-
-void v9fs_cache_inode_reset_cookie(struct inode *inode)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct v9fs_session_info *v9ses;
-	struct fscache_cookie *old;
-
-	if (!v9inode->fscache)
-		return;
-
-	old = v9inode->fscache;
-
-	mutex_lock(&v9inode->fscache_lock);
-	fscache_relinquish_cookie(v9inode->fscache, NULL, true);
-
-	v9ses = v9fs_inode2v9ses(inode);
-	v9inode->fscache = fscache_acquire_cookie(v9ses->fscache,
-						  &v9fs_cache_inode_index_def,
-						  &v9inode->qid.path,
-						  sizeof(v9inode->qid.path),
-						  &v9inode->qid.version,
-						  sizeof(v9inode->qid.version),
-						  v9inode,
-						  i_size_read(&v9inode->vfs_inode),
-						  true);
-	p9_debug(P9_DEBUG_FSC, "inode %p revalidating cookie old %p new %p\n",
-		 inode, old, v9inode->fscache);
-
-	mutex_unlock(&v9inode->fscache_lock);
-}
diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index 7480b4b49fea..1923affcdc62 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -7,26 +7,15 @@
 
 #ifndef _9P_CACHE_H
 #define _9P_CACHE_H
-#define FSCACHE_USE_NEW_IO_API
+
 #include <linux/fscache.h>
 
 #ifdef CONFIG_9P_FSCACHE
 
-extern struct fscache_netfs v9fs_cache_netfs;
-extern const struct fscache_cookie_def v9fs_cache_session_index_def;
-extern const struct fscache_cookie_def v9fs_cache_inode_index_def;
-
-extern void v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses);
-extern void v9fs_cache_session_put_cookie(struct v9fs_session_info *v9ses);
+extern int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
+					  const char *dev_name);
 
 extern void v9fs_cache_inode_get_cookie(struct inode *inode);
-extern void v9fs_cache_inode_put_cookie(struct inode *inode);
-extern void v9fs_cache_inode_flush_cookie(struct inode *inode);
-extern void v9fs_cache_inode_set_cookie(struct inode *inode, struct file *filp);
-extern void v9fs_cache_inode_reset_cookie(struct inode *inode);
-
-extern int __v9fs_cache_register(void);
-extern void __v9fs_cache_unregister(void);
 
 #else /* CONFIG_9P_FSCACHE */
 
@@ -34,13 +23,5 @@ static inline void v9fs_cache_inode_get_cookie(struct inode *inode)
 {
 }
 
-static inline void v9fs_cache_inode_put_cookie(struct inode *inode)
-{
-}
-
-static inline void v9fs_cache_inode_set_cookie(struct inode *inode, struct file *file)
-{
-}
-
 #endif /* CONFIG_9P_FSCACHE */
 #endif /* _9P_CACHE_H */
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e32dd5f7721b..5ea91ab3cfe2 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -469,7 +469,11 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 
 #ifdef CONFIG_9P_FSCACHE
 	/* register the session for caching */
-	v9fs_cache_session_get_cookie(v9ses);
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+		rc = v9fs_cache_session_get_cookie(v9ses, dev_name);
+		if (rc < 0)
+			goto err_clnt;
+	}
 #endif
 	spin_lock(&v9fs_sessionlist_lock);
 	list_add(&v9ses->slist, &v9fs_sessionlist);
@@ -502,8 +506,7 @@ void v9fs_session_close(struct v9fs_session_info *v9ses)
 	}
 
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->fscache)
-		v9fs_cache_session_put_cookie(v9ses);
+	fscache_relinquish_volume(v9fs_session_cache(v9ses), 0, false);
 	kfree(v9ses->cachetag);
 #endif
 	kfree(v9ses->uname);
@@ -665,20 +668,12 @@ static int v9fs_cache_register(void)
 	ret = v9fs_init_inode_cache();
 	if (ret < 0)
 		return ret;
-#ifdef CONFIG_9P_FSCACHE
-	ret = fscache_register_netfs(&v9fs_cache_netfs);
-	if (ret < 0)
-		v9fs_destroy_inode_cache();
-#endif
 	return ret;
 }
 
 static void v9fs_cache_unregister(void)
 {
 	v9fs_destroy_inode_cache();
-#ifdef CONFIG_9P_FSCACHE
-	fscache_unregister_netfs(&v9fs_cache_netfs);
-#endif
 }
 
 /**
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 1647a8e63671..bc8b30205d36 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -89,7 +89,7 @@ struct v9fs_session_info {
 	unsigned int cache;
 #ifdef CONFIG_9P_FSCACHE
 	char *cachetag;
-	struct fscache_cookie *fscache;
+	struct fscache_volume *fscache;
 #endif
 
 	char *uname;		/* user name to mount as */
@@ -109,7 +109,6 @@ struct v9fs_session_info {
 
 struct v9fs_inode {
 #ifdef CONFIG_9P_FSCACHE
-	struct mutex fscache_lock;
 	struct fscache_cookie *fscache;
 #endif
 	struct p9_qid qid;
@@ -133,6 +132,16 @@ static inline struct fscache_cookie *v9fs_inode_cookie(struct v9fs_inode *v9inod
 #endif
 }
 
+static inline struct fscache_volume *v9fs_session_cache(struct v9fs_session_info *v9ses)
+{
+#ifdef CONFIG_9P_FSCACHE
+	return v9ses->fscache;
+#else
+	return NULL;
+#endif
+}
+
+
 extern int v9fs_show_options(struct seq_file *m, struct dentry *root);
 
 struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 4ea8f862b9e4..4f5ce4aca317 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -76,7 +76,9 @@ static void v9fs_req_cleanup(struct address_space *mapping, void *priv)
  */
 static bool v9fs_is_cache_enabled(struct inode *inode)
 {
-	return fscache_cookie_enabled(v9fs_inode_cookie(V9FS_I(inode)));
+	struct fscache_cookie *cookie = v9fs_inode_cookie(V9FS_I(inode));
+
+	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
 }
 
 /**
@@ -88,7 +90,7 @@ static int v9fs_begin_cache_operation(struct netfs_read_request *rreq)
 #ifdef CONFIG_9P_FSCACHE
 	struct fscache_cookie *cookie = v9fs_inode_cookie(V9FS_I(rreq->inode));
 
-	return fscache_begin_read_operation(rreq, cookie);
+	return fscache_begin_read_operation(&rreq->cache_resources, cookie);
 #else
 	return -ENOBUFS;
 #endif
@@ -140,7 +142,7 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
 		return 0;
 #ifdef CONFIG_9P_FSCACHE
 	if (folio_test_fscache(folio)) {
-		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
 			return 0;
 		folio_wait_fscache(folio);
 	}
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 8c854d8cb0cd..48e7008fe0f6 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -17,6 +17,7 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
+#include <linux/fscache.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
@@ -205,7 +206,9 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 int v9fs_dir_release(struct inode *inode, struct file *filp)
 {
+	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct p9_fid *fid;
+	loff_t i_size;
 
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
@@ -216,6 +219,14 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		spin_unlock(&inode->i_lock);
 		p9_client_clunk(fid);
 	}
+
+	if ((filp->f_mode & FMODE_WRITE)) {
+		i_size = i_size_read(inode);
+		fscache_unuse_cookie(v9fs_inode_cookie(v9inode),
+				     &v9inode->qid.version, &i_size);
+	} else {
+		fscache_unuse_cookie(v9fs_inode_cookie(v9inode), NULL, NULL);
+	}
 	return 0;
 }
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 612e297f3763..be72ad9edb3e 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -93,7 +93,8 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	}
 	mutex_unlock(&v9inode->v_mutex);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
-		v9fs_cache_inode_set_cookie(inode, file);
+		fscache_use_cookie(v9fs_inode_cookie(v9inode),
+				   file->f_mode & FMODE_WRITE);
 	v9fs_open_fid_add(inode, fid);
 	return 0;
 out_error:
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 328c338ff304..00366bf1ac2c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -233,7 +233,6 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 		return NULL;
 #ifdef CONFIG_9P_FSCACHE
 	v9inode->fscache = NULL;
-	mutex_init(&v9inode->fscache_lock);
 #endif
 	v9inode->writeback_fid = NULL;
 	v9inode->cache_validity = 0;
@@ -386,7 +385,7 @@ void v9fs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 	filemap_fdatawrite(&inode->i_data);
 
-	v9fs_cache_inode_put_cookie(inode);
+	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 	/* clunk the fid stashed in writeback_fid */
 	if (v9inode->writeback_fid) {
 		p9_client_clunk(v9inode->writeback_fid);
@@ -869,7 +868,8 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 
 	file->private_data = fid;
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
-		v9fs_cache_inode_set_cookie(d_inode(dentry), file);
+		fscache_use_cookie(v9fs_inode_cookie(v9inode),
+				   file->f_mode & FMODE_WRITE);
 	v9fs_open_fid_add(inode, fid);
 
 	file->f_mode |= FMODE_CREATED;
@@ -1072,6 +1072,8 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct iattr *iattr)
 {
 	int retval, use_dentry = 0;
+	struct inode *inode = d_inode(dentry);
+	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL;
 	struct p9_wstat wstat;
@@ -1117,7 +1119,7 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
 
 	/* Write all dirty data */
 	if (d_is_reg(dentry))
-		filemap_write_and_wait(d_inode(dentry)->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 
 	retval = p9_client_wstat(fid, &wstat);
 
@@ -1128,13 +1130,15 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
 		return retval;
 
 	if ((iattr->ia_valid & ATTR_SIZE) &&
-	    iattr->ia_size != i_size_read(d_inode(dentry)))
-		truncate_setsize(d_inode(dentry), iattr->ia_size);
+	    iattr->ia_size != i_size_read(inode)) {
+		truncate_setsize(inode, iattr->ia_size);
+		fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
+	}
 
-	v9fs_invalidate_inode_attr(d_inode(dentry));
+	v9fs_invalidate_inode_attr(inode);
 
-	setattr_copy(&init_user_ns, d_inode(dentry), iattr);
-	mark_inode_dirty(d_inode(dentry));
+	setattr_copy(&init_user_ns, inode, iattr);
+	mark_inode_dirty(inode);
 	return 0;
 }
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 7dee89ba32e7..cae301d09cd3 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -344,7 +344,8 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		goto err_clunk_old_fid;
 	file->private_data = ofid;
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
-		v9fs_cache_inode_set_cookie(inode, file);
+		fscache_use_cookie(v9fs_inode_cookie(v9inode),
+				   file->f_mode & FMODE_WRITE);
 	v9fs_open_fid_add(inode, ofid);
 	file->f_mode |= FMODE_CREATED;
 out:


