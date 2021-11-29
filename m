Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A574619DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378558AbhK2OmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379013AbhK2OkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIftjtz3DIElbDVrKTe+Ct1nrU6IVYT9sMvDR/4ZDb4=;
        b=JCrAHr/Jg7qeIgsRZfqWQJRF/8ZCqtj7dZFgyTOcMriIeDEr/t8UpBBixqjf4M1rUKfg0L
        TYohhDDqQD/gNFrXskRI5FLdlKqgIs1Wx7GNRx5Bl1m9O2AFWBjArgMNPF+ulK9pjTCKO1
        HWUhexLDemWYOLySqISp2+vL5T461lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-xRu4k4V6OXi_U9bazv_TGA-1; Mon, 29 Nov 2021 09:37:00 -0500
X-MC-Unique: xRu4k4V6OXi_U9bazv_TGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA5A874980;
        Mon, 29 Nov 2021 14:36:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A203145D60;
        Mon, 29 Nov 2021 14:36:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 57/64] afs: Convert afs to use the new fscache API
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Mon, 29 Nov 2021 14:36:53 +0000
Message-ID: <163819661382.215744.1485608824741611837.stgit@warthog.procyon.org.uk>
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

Change the afs filesystem to support the new afs driver.

The following changes have been made:

 (1) The fscache_netfs struct is no more, and there's no need to register
     the filesystem as a whole.  There's also no longer a cell cookie.

 (2) The volume cookie is now an fscache_volume cookie, allocated with
     fscache_acquire_volume().  This function takes three parameters: a
     string representing the "volume" in the index, a string naming the
     cache to use (or NULL) and a u64 that conveys coherency metadata for
     the volume.

     For afs, I've made it render the volume name string as:

        "afs,<cell>,<volume_id>"

     and the coherency data is currently 0.

 (3) The fscache_cookie_def is no more and needed information is passed
     directly to fscache_acquire_cookie().  The cache no longer calls back
     into the filesystem, but rather metadata changes are indicated at
     other times.

     fscache_acquire_cookie() is passed the same keying and coherency
     information as before, except that these are now stored in big endian
     form instead of cpu endian.  This makes the cache more copyable.

 (4) fscache_use_cookie() and fscache_unuse_cookie() are called when a file
     is opened or closed to prevent a cache file from being culled and to
     keep resources to hand that are needed to do I/O.

     fscache_use_cookie() is given an indication if the cache is likely to
     be modified locally (e.g. the file is open for writing).

     fscache_unuse_cookie() is given a coherency update if we had the file
     open for writing and will update that.

 (5) fscache_invalidate() is now given uptodate auxiliary data and a file
     size.  It can also take a flag to indicate if this was due to a DIO
     write.  This is wrapped into afs_fscache_invalidate() now for
     convenience.

 (6) fscache_resize() now gets called from the finalisation of
     afs_setattr(), and afs_setattr() does use/unuse of the cookie around
     the call to support this.

 (7) fscache_note_page_release() is called from afs_release_page().

 (8) Use a killable wait in nfs_vm_page_mkwrite() when waiting for
     PG_fscache to be cleared.

Render the parts of the cookie key for an afs inode cookie as big endian.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
---

 fs/afs/Kconfig    |    2 +-
 fs/afs/Makefile   |    3 --
 fs/afs/cache.c    |   68 -----------------------------------------------------
 fs/afs/cell.c     |   12 ---------
 fs/afs/file.c     |   23 ++++++++++++++++--
 fs/afs/inode.c    |   50 +++++++++++++++++++--------------------
 fs/afs/internal.h |   30 +++++++++++++----------
 fs/afs/main.c     |   14 -----------
 fs/afs/volume.c   |   15 +++++++-----
 fs/afs/write.c    |    1 -
 10 files changed, 72 insertions(+), 146 deletions(-)
 delete mode 100644 fs/afs/cache.c

diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index c40cdfcc25d1..fc8ba9142f2f 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -25,7 +25,7 @@ config AFS_DEBUG
 
 config AFS_FSCACHE
 	bool "Provide AFS client caching support"
-	depends on AFS_FS=m && FSCACHE_OLD_API || AFS_FS=y && FSCACHE_OLD_API=y
+	depends on AFS_FS=m && FSCACHE || AFS_FS=y && FSCACHE=y
 	help
 	  Say Y here if you want AFS data to be cached locally on disk through
 	  the generic filesystem cache manager
diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 75c4e4043d1d..e8956b65d7ff 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -3,10 +3,7 @@
 # Makefile for Red Hat Linux AFS client.
 #
 
-afs-cache-$(CONFIG_AFS_FSCACHE) := cache.o
-
 kafs-y := \
-	$(afs-cache-y) \
 	addr_list.o \
 	callback.o \
 	cell.o \
diff --git a/fs/afs/cache.c b/fs/afs/cache.c
deleted file mode 100644
index 037af93e3aba..000000000000
--- a/fs/afs/cache.c
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* AFS caching stuff
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/sched.h>
-#include "internal.h"
-
-static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
-						       const void *buffer,
-						       uint16_t buflen,
-						       loff_t object_size);
-
-struct fscache_netfs afs_cache_netfs = {
-	.name			= "afs",
-	.version		= 2,
-};
-
-struct fscache_cookie_def afs_cell_cache_index_def = {
-	.name		= "AFS.cell",
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-struct fscache_cookie_def afs_volume_cache_index_def = {
-	.name		= "AFS.volume",
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-struct fscache_cookie_def afs_vnode_cache_index_def = {
-	.name		= "AFS.vnode",
-	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= afs_vnode_cache_check_aux,
-};
-
-/*
- * check that the auxiliary data indicates that the entry is still valid
- */
-static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
-						       const void *buffer,
-						       uint16_t buflen,
-						       loff_t object_size)
-{
-	struct afs_vnode *vnode = cookie_netfs_data;
-	struct afs_vnode_cache_aux aux;
-
-	_enter("{%llx,%x,%llx},%p,%u",
-	       vnode->fid.vnode, vnode->fid.unique, vnode->status.data_version,
-	       buffer, buflen);
-
-	memcpy(&aux, buffer, sizeof(aux));
-
-	/* check the size of the data is what we're expecting */
-	if (buflen != sizeof(aux)) {
-		_leave(" = OBSOLETE [len %hx != %zx]", buflen, sizeof(aux));
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	if (vnode->status.data_version != aux.data_version) {
-		_leave(" = OBSOLETE [vers %llx != %llx]",
-		       aux.data_version, vnode->status.data_version);
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	_leave(" = SUCCESS");
-	return FSCACHE_CHECKAUX_OKAY;
-}
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index d88407fb9bc0..07ad744eef77 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -680,13 +680,6 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 			return ret;
 	}
 
-#ifdef CONFIG_AFS_FSCACHE
-	cell->cache = fscache_acquire_cookie(afs_cache_netfs.primary_index,
-					     &afs_cell_cache_index_def,
-					     cell->name, strlen(cell->name),
-					     NULL, 0,
-					     cell, 0, true);
-#endif
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
 		return ret;
@@ -723,11 +716,6 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	afs_dynroot_rmdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(cell->cache, NULL, false);
-	cell->cache = NULL;
-#endif
-
 	_leave("");
 }
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 97a51e1de55c..0a6cb1e3c28f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -158,7 +158,9 @@ int afs_open(struct inode *inode, struct file *file)
 
 	if (file->f_flags & O_TRUNC)
 		set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	
+
+	fscache_use_cookie(afs_vnode_cache(vnode), file->f_mode & FMODE_WRITE);
+
 	file->private_data = af;
 	_leave(" = 0");
 	return 0;
@@ -177,8 +179,10 @@ int afs_open(struct inode *inode, struct file *file)
  */
 int afs_release(struct inode *inode, struct file *file)
 {
+	struct afs_vnode_cache_aux aux;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = file->private_data;
+	loff_t i_size;
 	int ret = 0;
 
 	_enter("{%llx:%llu},", vnode->fid.vid, vnode->fid.vnode);
@@ -189,6 +193,15 @@ int afs_release(struct inode *inode, struct file *file)
 	file->private_data = NULL;
 	if (af->wb)
 		afs_put_wb_key(af->wb);
+
+	if ((file->f_mode & FMODE_WRITE)) {
+		i_size = i_size_read(&vnode->vfs_inode);
+		afs_set_cache_aux(vnode, &aux);
+		fscache_unuse_cookie(afs_vnode_cache(vnode), &aux, &i_size);
+	} else {
+		fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
+	}
+
 	key_put(af->key);
 	kfree(af);
 	afs_prune_wb_keys(vnode);
@@ -352,7 +365,9 @@ static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
 
 static bool afs_is_cache_enabled(struct inode *inode)
 {
-	return fscache_cookie_enabled(afs_vnode_cache(AFS_FS_I(inode)));
+	struct fscache_cookie *cookie = afs_vnode_cache(AFS_FS_I(inode));
+
+	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
 }
 
 static int afs_begin_cache_operation(struct netfs_read_request *rreq)
@@ -360,7 +375,8 @@ static int afs_begin_cache_operation(struct netfs_read_request *rreq)
 #ifdef CONFIG_AFS_FSCACHE
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
 
-	return fscache_begin_read_operation(rreq, afs_vnode_cache(vnode));
+	return fscache_begin_read_operation(&rreq->cache_resources,
+					    afs_vnode_cache(vnode));
 #else
 	return -ENOBUFS;
 #endif
@@ -499,6 +515,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 			return false;
 		folio_wait_fscache(folio);
 	}
+	fscache_note_page_release(afs_vnode_cache(vnode));
 #endif
 
 	if (folio_test_private(folio)) {
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 16906eb592d9..509208825907 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -413,9 +413,9 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 {
 #ifdef CONFIG_AFS_FSCACHE
 	struct {
-		u32 vnode_id;
-		u32 unique;
-		u32 vnode_id_ext[2];	/* Allow for a 96-bit key */
+		__be32 vnode_id;
+		__be32 unique;
+		__be32 vnode_id_ext[2];	/* Allow for a 96-bit key */
 	} __packed key;
 	struct afs_vnode_cache_aux aux;
 
@@ -424,17 +424,18 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 		return;
 	}
 
-	key.vnode_id		= vnode->fid.vnode;
-	key.unique		= vnode->fid.unique;
-	key.vnode_id_ext[0]	= vnode->fid.vnode >> 32;
-	key.vnode_id_ext[1]	= vnode->fid.vnode_hi;
-	aux.data_version	= vnode->status.data_version;
-
-	vnode->cache = fscache_acquire_cookie(vnode->volume->cache,
-					      &afs_vnode_cache_index_def,
-					      &key, sizeof(key),
-					      &aux, sizeof(aux),
-					      vnode, vnode->status.size, true);
+	key.vnode_id		= htonl(vnode->fid.vnode);
+	key.unique		= htonl(vnode->fid.unique);
+	key.vnode_id_ext[0]	= htonl(vnode->fid.vnode >> 32);
+	key.vnode_id_ext[1]	= htonl(vnode->fid.vnode_hi);
+	afs_set_cache_aux(vnode, &aux);
+
+	vnode->cache = fscache_acquire_cookie(
+		vnode->volume->cache,
+		vnode->status.type == AFS_FTYPE_FILE ? 0 : FSCACHE_ADV_SINGLE_CHUNK,
+		&key, sizeof(key),
+		&aux, sizeof(aux),
+		vnode->status.size);
 #endif
 }
 
@@ -563,9 +564,7 @@ static void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache);
-#endif
+	afs_invalidate_cache(vnode, 0);
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
 	 * written back in a regular file and completely discard the pages in a
@@ -786,14 +785,9 @@ void afs_evict_inode(struct inode *inode)
 	}
 
 #ifdef CONFIG_AFS_FSCACHE
-	{
-		struct afs_vnode_cache_aux aux;
-
-		aux.data_version = vnode->status.data_version;
-		fscache_relinquish_cookie(vnode->cache, &aux,
-					  test_bit(AFS_VNODE_DELETED, &vnode->flags));
-		vnode->cache = NULL;
-	}
+	fscache_relinquish_cookie(vnode->cache,
+				  test_bit(AFS_VNODE_DELETED, &vnode->flags));
+	vnode->cache = NULL;
 #endif
 
 	afs_prune_wb_keys(vnode);
@@ -833,6 +827,9 @@ static void afs_setattr_edit_file(struct afs_operation *op)
 
 		if (size < i_size)
 			truncate_pagecache(inode, size);
+		if (size != i_size)
+			fscache_resize_cookie(afs_vnode_cache(vp->vnode),
+					      vp->scb.status.size);
 	}
 }
 
@@ -876,6 +873,8 @@ int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
+	fscache_use_cookie(afs_vnode_cache(vnode), true);
+
 	/* flush any dirty data outstanding on a regular file */
 	if (S_ISREG(vnode->vfs_inode.i_mode))
 		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
@@ -907,6 +906,7 @@ int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 out_unlock:
 	up_write(&vnode->validate_lock);
+	fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index aa4c0d6c9780..e46b31c1b6d4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -14,7 +14,6 @@
 #include <linux/key.h>
 #include <linux/workqueue.h>
 #include <linux/sched.h>
-#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
 #include <linux/backing-dev.h>
 #include <linux/uuid.h>
@@ -364,9 +363,6 @@ struct afs_cell {
 	struct key		*anonymous_key;	/* anonymous user key for this cell */
 	struct work_struct	manager;	/* Manager for init/deinit/dns */
 	struct hlist_node	proc_link;	/* /proc cell list link */
-#ifdef CONFIG_AFS_FSCACHE
-	struct fscache_cookie	*cache;		/* caching cookie */
-#endif
 	time64_t		dns_expiry;	/* Time AFSDB/SRV record expires */
 	time64_t		last_inactive;	/* Time of last drop of usage count */
 	atomic_t		ref;		/* Struct refcount */
@@ -590,7 +586,7 @@ struct afs_volume {
 #define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
 #define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
 #ifdef CONFIG_AFS_FSCACHE
-	struct fscache_cookie	*cache;		/* caching cookie */
+	struct fscache_volume	*cache;		/* Caching cookie */
 #endif
 	struct afs_server_list __rcu *servers;	/* List of servers on which volume resides */
 	rwlock_t		servers_lock;	/* Lock for ->servers */
@@ -872,9 +868,24 @@ struct afs_operation {
  * Cache auxiliary data.
  */
 struct afs_vnode_cache_aux {
-	u64			data_version;
+	__be64			data_version;
 } __packed;
 
+static inline void afs_set_cache_aux(struct afs_vnode *vnode,
+				     struct afs_vnode_cache_aux *aux)
+{
+	aux->data_version = cpu_to_be64(vnode->status.data_version);
+}
+
+static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int flags)
+{
+	struct afs_vnode_cache_aux aux;
+
+	afs_set_cache_aux(vnode, &aux);
+	fscache_invalidate(afs_vnode_cache(vnode), &aux,
+			   i_size_read(&vnode->vfs_inode), flags);
+}
+
 /*
  * We use folio->private to hold the amount of the folio that we've written to,
  * splitting the field into two parts.  However, we need to represent a range
@@ -962,13 +973,6 @@ extern void afs_merge_fs_addr6(struct afs_addr_list *, __be32 *, u16);
  */
 #ifdef CONFIG_AFS_FSCACHE
 extern struct fscache_netfs afs_cache_netfs;
-extern struct fscache_cookie_def afs_cell_cache_index_def;
-extern struct fscache_cookie_def afs_volume_cache_index_def;
-extern struct fscache_cookie_def afs_vnode_cache_index_def;
-#else
-#define afs_cell_cache_index_def	(*(struct fscache_cookie_def *) NULL)
-#define afs_volume_cache_index_def	(*(struct fscache_cookie_def *) NULL)
-#define afs_vnode_cache_index_def	(*(struct fscache_cookie_def *) NULL)
 #endif
 
 /*
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 179004b15566..eae288c8d40a 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -186,13 +186,6 @@ static int __init afs_init(void)
 	if (!afs_lock_manager)
 		goto error_lockmgr;
 
-#ifdef CONFIG_AFS_FSCACHE
-	/* we want to be able to cache */
-	ret = fscache_register_netfs(&afs_cache_netfs);
-	if (ret < 0)
-		goto error_cache;
-#endif
-
 	ret = register_pernet_device(&afs_net_ops);
 	if (ret < 0)
 		goto error_net;
@@ -215,10 +208,6 @@ static int __init afs_init(void)
 error_fs:
 	unregister_pernet_device(&afs_net_ops);
 error_net:
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_unregister_netfs(&afs_cache_netfs);
-error_cache:
-#endif
 	destroy_workqueue(afs_lock_manager);
 error_lockmgr:
 	destroy_workqueue(afs_async_calls);
@@ -245,9 +234,6 @@ static void __exit afs_exit(void)
 	proc_remove(afs_proc_symlink);
 	afs_fs_exit();
 	unregister_pernet_device(&afs_net_ops);
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_unregister_netfs(&afs_cache_netfs);
-#endif
 	destroy_workqueue(afs_lock_manager);
 	destroy_workqueue(afs_async_calls);
 	destroy_workqueue(afs_wq);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f84194b791d3..1269ec08170e 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -271,11 +271,14 @@ void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
 void afs_activate_volume(struct afs_volume *volume)
 {
 #ifdef CONFIG_AFS_FSCACHE
-	volume->cache = fscache_acquire_cookie(volume->cell->cache,
-					       &afs_volume_cache_index_def,
-					       &volume->vid, sizeof(volume->vid),
-					       NULL, 0,
-					       volume, 0, true);
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "afs,%s,%llx",
+			 volume->cell->name, volume->vid);
+	if (name) {
+		volume->cache = fscache_acquire_volume(name, NULL, 0);
+		kfree(name);
+	}
 #endif
 }
 
@@ -287,7 +290,7 @@ void afs_deactivate_volume(struct afs_volume *volume)
 	_enter("%s", volume->name);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(volume->cache, NULL,
+	fscache_relinquish_volume(volume->cache, 0,
 				  test_bit(AFS_VOLUME_DELETED, &volume->flags));
 	volume->cache = NULL;
 #endif
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9db3ddb1c45b..ac1341af31e9 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -12,7 +12,6 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/netfs.h>
-#include <linux/fscache.h>
 #include "internal.h"
 
 /*


