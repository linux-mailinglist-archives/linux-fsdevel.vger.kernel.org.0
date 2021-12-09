Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2B46F137
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhLIROA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242602AbhLIRNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tH5KP5EGLT24ehyOBbmvP9aFavH/kaNLO2VwQkiJL0A=;
        b=e7ECsTSUyokpYfwzirkuZ9Vg/1RYnHUbjmLJlnDdqd4xsqNKk/HNju84/E8rRyjVJfXQB3
        uBNNZqZ3QW07DWwZ0UzR3Hldk25jyESrLexvV6m3E0iJpe3w244fzLw1xSMLc4/ESbfYH4
        Qg1V1nlWFO6+MUfn2WQ5X3o4nBbaegk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-LlXOQgPlN8yRQ5TPd7DrrA-1; Thu, 09 Dec 2021 12:10:10 -0500
X-MC-Unique: LlXOQgPlN8yRQ5TPd7DrrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC4A02F24;
        Thu,  9 Dec 2021 17:10:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBB097095E;
        Thu,  9 Dec 2021 17:09:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 62/67] nfs: Convert to new fscache volume/cookie API
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, dhowells@redhat.com,
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
Date:   Thu, 09 Dec 2021 17:09:50 +0000
Message-ID: <163906979003.143852.2601189243864854724.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

Change the nfs filesystem to support fscache's indexing rewrite and
reenable caching in nfs.

The following changes have been made:

 (1) The fscache_netfs struct is no more, and there's no need to register
     the filesystem as a whole.

 (2) The session cookie is now an fscache_volume cookie, allocated with
     fscache_acquire_volume().  That takes three parameters: a string
     representing the "volume" in the index, a string naming the cache to
     use (or NULL) and a u64 that conveys coherency metadata for the
     volume.

     For nfs, I've made it render the volume name string as:

        "nfs,<ver>,<family>,<address>,<port>,<fsidH>,<fsidL>*<,param>[,<uniq>]"

 (3) The fscache_cookie_def is no more and needed information is passed
     directly to fscache_acquire_cookie().  The cache no longer calls back
     into the filesystem, but rather metadata changes are indicated at
     other times.

     fscache_acquire_cookie() is passed the same keying and coherency
     information as before.

 (4) fscache_enable/disable_cookie() have been removed.

     Call fscache_use_cookie() and fscache_unuse_cookie() when a file is
     opened or closed to prevent a cache file from being culled and to keep
     resources to hand that are needed to do I/O.

     Unuse the cookie when a file is opened for writing.  This is gated by
     the NFS_INO_FSCACHE flag on the nfs_inode.

     A better way might be to invalidate it with FSCACHE_INVAL_DIO_WRITE
     which will keep it unused until all open files are closed.

 (5) fscache_invalidate() now needs to be given uptodate auxiliary data and
     a file size.  It also takes a flag to indicate if this was due to a
     DIO write.

 (6) Call nfs_fscache_invalidate() with FSCACHE_INVAL_DIO_WRITE on a file
     to which a DIO write is made.

 (7) Call fscache_note_page_release() from nfs_release_page().

 (8) Use a killable wait in nfs_vm_page_mkwrite() when waiting for
     PG_fscache to be cleared.

 (9) The functions to read and write data to/from the cache are stubbed out
     pending a conversion to use netfslib.

Changes
=======
ver #2:
 - Use gfpflags_allow_blocking() rather than using flag directly.
 - fscache_acquire_volume() now returns errors.
 - Remove NFS_INO_FSCACHE as it's no longer used.
 - Need to unuse a cookie on file-release, not inode-clear.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: linux-nfs@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819668938.215744.14448852181937731615.stgit@warthog.procyon.org.uk/ # v1
---

 fs/nfs/Kconfig            |    2 
 fs/nfs/Makefile           |    2 
 fs/nfs/client.c           |    4 
 fs/nfs/direct.c           |    2 
 fs/nfs/file.c             |   13 +
 fs/nfs/fscache-index.c    |  140 ---------------
 fs/nfs/fscache.c          |  434 +++++++++++----------------------------------
 fs/nfs/fscache.h          |  126 ++++---------
 fs/nfs/inode.c            |   11 -
 fs/nfs/nfstrace.h         |    1 
 fs/nfs/super.c            |   28 ++-
 fs/nfs/write.c            |    1 
 include/linux/nfs_fs.h    |    1 
 include/linux/nfs_fs_sb.h |    9 -
 14 files changed, 171 insertions(+), 603 deletions(-)
 delete mode 100644 fs/nfs/fscache-index.c

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index bdc11b89eac5..14a72224b657 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -170,7 +170,7 @@ config ROOT_NFS
 
 config NFS_FSCACHE
 	bool "Provide NFS client caching support"
-	depends on NFS_FS=m && FSCACHE_OLD_API || NFS_FS=y && FSCACHE_OLD_API=y
+	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through
 	  the general filesystem cache manager
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 22d11fdc6deb..5f6db37f461e 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -12,7 +12,7 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 			   export.o sysfs.o fs_context.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
-nfs-$(CONFIG_NFS_FSCACHE) += fscache.o fscache-index.o
+nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 1e4dc1ab9312..8d8b85b5a641 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -183,8 +183,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_net = get_net(cl_init->net);
 
 	clp->cl_principal = "*";
-	nfs_fscache_get_client_cookie(clp);
-
 	return clp;
 
 error_cleanup:
@@ -238,8 +236,6 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
-	nfs_fscache_release_client_cookie(clp);
-
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9cff8709c80a..eabfdab543c8 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -59,6 +59,7 @@
 #include "internal.h"
 #include "iostat.h"
 #include "pnfs.h"
+#include "fscache.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -959,6 +960,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	} else {
 		result = requested;
 	}
+	nfs_fscache_invalidate(inode, FSCACHE_INVAL_DIO_WRITE);
 out_release:
 	nfs_direct_req_release(dreq);
 out:
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 24e7dccce355..76d76acbc594 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -84,6 +84,7 @@ nfs_file_release(struct inode *inode, struct file *filp)
 
 	nfs_inc_stats(inode, NFSIOS_VFSRELEASE);
 	nfs_file_clear_open_context(filp);
+	nfs_fscache_release_file(inode, filp);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_file_release);
@@ -415,8 +416,7 @@ static void nfs_invalidate_page(struct page *page, unsigned int offset,
 		return;
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
-
-	nfs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
 }
 
 /*
@@ -475,12 +475,11 @@ static void nfs_check_dirty_writeback(struct page *page,
 static int nfs_launder_page(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_inode *nfsi = NFS_I(inode);
 
 	dfprintk(PAGECACHE, "NFS: launder_page(%ld, %llu)\n",
 		inode->i_ino, (long long)page_offset(page));
 
-	nfs_fscache_wait_on_page_write(nfsi, page);
+	wait_on_page_fscache(page);
 	return nfs_wb_page(inode, page);
 }
 
@@ -555,7 +554,11 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
+	if (PageFsCache(page) &&
+	    wait_on_page_fscache_killable(vmf->page) < 0) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			nfs_wait_bit_killable, TASK_KILLABLE);
diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
deleted file mode 100644
index 573b1da9342c..000000000000
--- a/fs/nfs/fscache-index.c
+++ /dev/null
@@ -1,140 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* NFS FS-Cache index structure definition
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/nfs_fs.h>
-#include <linux/nfs_fs_sb.h>
-#include <linux/in6.h>
-#include <linux/iversion.h>
-
-#include "internal.h"
-#include "fscache.h"
-
-#define NFSDBG_FACILITY		NFSDBG_FSCACHE
-
-/*
- * Define the NFS filesystem for FS-Cache.  Upon registration FS-Cache sticks
- * the cookie for the top-level index object for NFS into here.  The top-level
- * index can than have other cache objects inserted into it.
- */
-struct fscache_netfs nfs_fscache_netfs = {
-	.name		= "nfs",
-	.version	= 0,
-};
-
-/*
- * Register NFS for caching
- */
-int nfs_fscache_register(void)
-{
-	return fscache_register_netfs(&nfs_fscache_netfs);
-}
-
-/*
- * Unregister NFS for caching
- */
-void nfs_fscache_unregister(void)
-{
-	fscache_unregister_netfs(&nfs_fscache_netfs);
-}
-
-/*
- * Define the server object for FS-Cache.  This is used to describe a server
- * object to fscache_acquire_cookie().  It is keyed by the NFS protocol and
- * server address parameters.
- */
-const struct fscache_cookie_def nfs_fscache_server_index_def = {
-	.name		= "NFS.server",
-	.type 		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-/*
- * Define the superblock object for FS-Cache.  This is used to describe a
- * superblock object to fscache_acquire_cookie().  It is keyed by all the NFS
- * parameters that might cause a separate superblock.
- */
-const struct fscache_cookie_def nfs_fscache_super_index_def = {
-	.name		= "NFS.super",
-	.type 		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-/*
- * Consult the netfs about the state of an object
- * - This function can be absent if the index carries no state data
- * - The netfs data from the cookie being used as the target is
- *   presented, as is the auxiliary data
- */
-static
-enum fscache_checkaux nfs_fscache_inode_check_aux(void *cookie_netfs_data,
-						  const void *data,
-						  uint16_t datalen,
-						  loff_t object_size)
-{
-	struct nfs_fscache_inode_auxdata auxdata;
-	struct nfs_inode *nfsi = cookie_netfs_data;
-
-	if (datalen != sizeof(auxdata))
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
-
-	if (memcmp(data, &auxdata, datalen) != 0)
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	return FSCACHE_CHECKAUX_OKAY;
-}
-
-/*
- * Get an extra reference on a read context.
- * - This function can be absent if the completion function doesn't require a
- *   context.
- * - The read context is passed back to NFS in the event that a data read on the
- *   cache fails with EIO - in which case the server must be contacted to
- *   retrieve the data, which requires the read context for security.
- */
-static void nfs_fh_get_context(void *cookie_netfs_data, void *context)
-{
-	get_nfs_open_context(context);
-}
-
-/*
- * Release an extra reference on a read context.
- * - This function can be absent if the completion function doesn't require a
- *   context.
- */
-static void nfs_fh_put_context(void *cookie_netfs_data, void *context)
-{
-	if (context)
-		put_nfs_open_context(context);
-}
-
-/*
- * Define the inode object for FS-Cache.  This is used to describe an inode
- * object to fscache_acquire_cookie().  It is keyed by the NFS file handle for
- * an inode.
- *
- * Coherency is managed by comparing the copies of i_size, i_mtime and i_ctime
- * held in the cache auxiliary data for the data storage object with those in
- * the inode struct in memory.
- */
-const struct fscache_cookie_def nfs_fscache_inode_object_def = {
-	.name		= "NFS.fh",
-	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= nfs_fscache_inode_check_aux,
-	.get_context	= nfs_fh_get_context,
-	.put_context	= nfs_fh_put_context,
-};
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d743629e05e1..d10e50ab0b3d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -22,24 +22,18 @@
 
 #define NFSDBG_FACILITY		NFSDBG_FSCACHE
 
-static struct rb_root nfs_fscache_keys = RB_ROOT;
-static DEFINE_SPINLOCK(nfs_fscache_keys_lock);
+#define NFS_MAX_KEY_LEN 1000
 
-/*
- * Layout of the key for an NFS server cache object.
- */
-struct nfs_server_key {
-	struct {
-		uint16_t	nfsversion;		/* NFS protocol version */
-		uint32_t	minorversion;		/* NFSv4 minor version */
-		uint16_t	family;			/* address family */
-		__be16		port;			/* IP port */
-	} hdr;
-	union {
-		struct in_addr	ipv4_addr;	/* IPv4 address */
-		struct in6_addr ipv6_addr;	/* IPv6 address */
-	};
-} __packed;
+static bool nfs_append_int(char *key, int *_len, unsigned long long x)
+{
+	if (*_len > NFS_MAX_KEY_LEN)
+		return false;
+	if (x == 0)
+		key[(*_len)++] = ',';
+	else
+		*_len += sprintf(key + *_len, ",%llx", x);
+	return true;
+}
 
 /*
  * Get the per-client index cookie for an NFS client if the appropriate mount
@@ -47,160 +41,108 @@ struct nfs_server_key {
  * - We always try and get an index cookie for the client, but get filehandle
  *   cookies on a per-superblock basis, depending on the mount flags
  */
-void nfs_fscache_get_client_cookie(struct nfs_client *clp)
+static bool nfs_fscache_get_client_key(struct nfs_client *clp,
+				       char *key, int *_len)
 {
 	const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *) &clp->cl_addr;
 	const struct sockaddr_in *sin = (struct sockaddr_in *) &clp->cl_addr;
-	struct nfs_server_key key;
-	uint16_t len = sizeof(key.hdr);
 
-	memset(&key, 0, sizeof(key));
-	key.hdr.nfsversion = clp->rpc_ops->version;
-	key.hdr.minorversion = clp->cl_minorversion;
-	key.hdr.family = clp->cl_addr.ss_family;
+	*_len += snprintf(key + *_len, NFS_MAX_KEY_LEN - *_len,
+			  ",%u.%u,%x",
+			  clp->rpc_ops->version,
+			  clp->cl_minorversion,
+			  clp->cl_addr.ss_family);
 
 	switch (clp->cl_addr.ss_family) {
 	case AF_INET:
-		key.hdr.port = sin->sin_port;
-		key.ipv4_addr = sin->sin_addr;
-		len += sizeof(key.ipv4_addr);
-		break;
+		if (!nfs_append_int(key, _len, sin->sin_port) ||
+		    !nfs_append_int(key, _len, sin->sin_addr.s_addr))
+			return false;
+		return true;
 
 	case AF_INET6:
-		key.hdr.port = sin6->sin6_port;
-		key.ipv6_addr = sin6->sin6_addr;
-		len += sizeof(key.ipv6_addr);
-		break;
+		if (!nfs_append_int(key, _len, sin6->sin6_port) ||
+		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[0]) ||
+		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[1]) ||
+		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[2]) ||
+		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[3]))
+			return false;
+		return true;
 
 	default:
 		printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
 		       clp->cl_addr.ss_family);
-		clp->fscache = NULL;
-		return;
+		return false;
 	}
-
-	/* create a cache index for looking up filehandles */
-	clp->fscache = fscache_acquire_cookie(nfs_fscache_netfs.primary_index,
-					      &nfs_fscache_server_index_def,
-					      &key, len,
-					      NULL, 0,
-					      clp, 0, true);
-	dfprintk(FSCACHE, "NFS: get client cookie (0x%p/0x%p)\n",
-		 clp, clp->fscache);
-}
-
-/*
- * Dispose of a per-client cookie
- */
-void nfs_fscache_release_client_cookie(struct nfs_client *clp)
-{
-	dfprintk(FSCACHE, "NFS: releasing client cookie (0x%p/0x%p)\n",
-		 clp, clp->fscache);
-
-	fscache_relinquish_cookie(clp->fscache, NULL, false);
-	clp->fscache = NULL;
 }
 
 /*
- * Get the cache cookie for an NFS superblock.  We have to handle
- * uniquification here because the cache doesn't do it for us.
+ * Get the cache cookie for an NFS superblock.
  *
  * The default uniquifier is just an empty string, but it may be overridden
  * either by the 'fsc=xxx' option to mount, or by inheriting it from the parent
  * superblock across an automount point of some nature.
  */
-void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int ulen)
+int nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int ulen)
 {
-	struct nfs_fscache_key *key, *xkey;
+	struct fscache_volume *vcookie;
 	struct nfs_server *nfss = NFS_SB(sb);
-	struct rb_node **p, *parent;
-	int diff;
+	unsigned int len = 3;
+	char *key;
 
-	nfss->fscache_key = NULL;
-	nfss->fscache = NULL;
-	if (!uniq) {
-		uniq = "";
-		ulen = 1;
+	if (uniq) {
+		nfss->fscache_uniq = kmemdup_nul(uniq, ulen, GFP_KERNEL);
+		if (!nfss->fscache_uniq)
+			return -ENOMEM;
 	}
 
-	key = kzalloc(sizeof(*key) + ulen, GFP_KERNEL);
+	key = kmalloc(NFS_MAX_KEY_LEN + 24, GFP_KERNEL);
 	if (!key)
-		return;
-
-	key->nfs_client = nfss->nfs_client;
-	key->key.super.s_flags = sb->s_flags & NFS_SB_MASK;
-	key->key.nfs_server.flags = nfss->flags;
-	key->key.nfs_server.rsize = nfss->rsize;
-	key->key.nfs_server.wsize = nfss->wsize;
-	key->key.nfs_server.acregmin = nfss->acregmin;
-	key->key.nfs_server.acregmax = nfss->acregmax;
-	key->key.nfs_server.acdirmin = nfss->acdirmin;
-	key->key.nfs_server.acdirmax = nfss->acdirmax;
-	key->key.nfs_server.fsid = nfss->fsid;
-	key->key.rpc_auth.au_flavor = nfss->client->cl_auth->au_flavor;
-
-	key->key.uniq_len = ulen;
-	memcpy(key->key.uniquifier, uniq, ulen);
-
-	spin_lock(&nfs_fscache_keys_lock);
-	p = &nfs_fscache_keys.rb_node;
-	parent = NULL;
-	while (*p) {
-		parent = *p;
-		xkey = rb_entry(parent, struct nfs_fscache_key, node);
-
-		if (key->nfs_client < xkey->nfs_client)
-			goto go_left;
-		if (key->nfs_client > xkey->nfs_client)
-			goto go_right;
-
-		diff = memcmp(&key->key, &xkey->key, sizeof(key->key));
-		if (diff < 0)
-			goto go_left;
-		if (diff > 0)
-			goto go_right;
-
-		if (key->key.uniq_len == 0)
-			goto non_unique;
-		diff = memcmp(key->key.uniquifier,
-			      xkey->key.uniquifier,
-			      key->key.uniq_len);
-		if (diff < 0)
-			goto go_left;
-		if (diff > 0)
-			goto go_right;
-		goto non_unique;
-
-	go_left:
-		p = &(*p)->rb_left;
-		continue;
-	go_right:
-		p = &(*p)->rb_right;
+		return -ENOMEM;
+
+	memcpy(key, "nfs", 3);
+	if (!nfs_fscache_get_client_key(nfss->nfs_client, key, &len) ||
+	    !nfs_append_int(key, &len, nfss->fsid.major) ||
+	    !nfs_append_int(key, &len, nfss->fsid.minor) ||
+	    !nfs_append_int(key, &len, sb->s_flags & NFS_SB_MASK) ||
+	    !nfs_append_int(key, &len, nfss->flags) ||
+	    !nfs_append_int(key, &len, nfss->rsize) ||
+	    !nfs_append_int(key, &len, nfss->wsize) ||
+	    !nfs_append_int(key, &len, nfss->acregmin) ||
+	    !nfs_append_int(key, &len, nfss->acregmax) ||
+	    !nfs_append_int(key, &len, nfss->acdirmin) ||
+	    !nfs_append_int(key, &len, nfss->acdirmax) ||
+	    !nfs_append_int(key, &len, nfss->client->cl_auth->au_flavor))
+		goto out;
+
+	if (ulen > 0) {
+		if (ulen > NFS_MAX_KEY_LEN - len)
+			goto out;
+		key[len++] = ',';
+		memcpy(key + len, uniq, ulen);
+		len += ulen;
 	}
-
-	rb_link_node(&key->node, parent, p);
-	rb_insert_color(&key->node, &nfs_fscache_keys);
-	spin_unlock(&nfs_fscache_keys_lock);
-	nfss->fscache_key = key;
+	key[len] = 0;
 
 	/* create a cache index for looking up filehandles */
-	nfss->fscache = fscache_acquire_cookie(nfss->nfs_client->fscache,
-					       &nfs_fscache_super_index_def,
-					       &key->key,
-					       sizeof(key->key) + ulen,
-					       NULL, 0,
-					       nfss, 0, true);
+	vcookie = fscache_acquire_volume(key,
+					 NULL, /* preferred_cache */
+					 0 /* coherency_data */);
 	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
-		 nfss, nfss->fscache);
-	return;
+		 nfss, vcookie);
+	if (IS_ERR(vcookie)) {
+		if (vcookie != ERR_PTR(-EBUSY)) {
+			kfree(key);
+			return PTR_ERR(vcookie);
+		}
+		pr_err("NFS: Cache volume key already in use (%s)\n", key);
+		vcookie = NULL;
+	}
+	nfss->fscache = vcookie;
 
-non_unique:
-	spin_unlock(&nfs_fscache_keys_lock);
+out:
 	kfree(key);
-	nfss->fscache_key = NULL;
-	nfss->fscache = NULL;
-	printk(KERN_WARNING "NFS:"
-	       " Cache request denied due to non-unique superblock keys\n");
+	return 0;
 }
 
 /*
@@ -213,29 +155,9 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	dfprintk(FSCACHE, "NFS: releasing superblock cookie (0x%p/0x%p)\n",
 		 nfss, nfss->fscache);
 
-	fscache_relinquish_cookie(nfss->fscache, NULL, false);
+	fscache_relinquish_volume(nfss->fscache, 0, false);
 	nfss->fscache = NULL;
-
-	if (nfss->fscache_key) {
-		spin_lock(&nfs_fscache_keys_lock);
-		rb_erase(&nfss->fscache_key->node, &nfs_fscache_keys);
-		spin_unlock(&nfs_fscache_keys_lock);
-		kfree(nfss->fscache_key);
-		nfss->fscache_key = NULL;
-	}
-}
-
-static void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
-				  struct nfs_inode *nfsi)
-{
-	memset(auxdata, 0, sizeof(*auxdata));
-	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
+	kfree(nfss->fscache_uniq);
 }
 
 /*
@@ -254,10 +176,12 @@ void nfs_fscache_init_inode(struct inode *inode)
 	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
-					       &nfs_fscache_inode_object_def,
-					       nfsi->fh.data, nfsi->fh.size,
-					       &auxdata, sizeof(auxdata),
-					       nfsi, nfsi->vfs_inode.i_size, false);
+					       0,
+					       nfsi->fh.data, /* index_key */
+					       nfsi->fh.size,
+					       &auxdata,      /* aux_data */
+					       sizeof(auxdata),
+					       i_size_read(&nfsi->vfs_inode));
 }
 
 /*
@@ -265,24 +189,15 @@ void nfs_fscache_init_inode(struct inode *inode)
  */
 void nfs_fscache_clear_inode(struct inode *inode)
 {
-	struct nfs_fscache_inode_auxdata auxdata;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
-	fscache_relinquish_cookie(cookie, &auxdata, false);
+	fscache_relinquish_cookie(cookie, false);
 	nfsi->fscache = NULL;
 }
 
-static bool nfs_fscache_can_enable(void *data)
-{
-	struct inode *inode = data;
-
-	return !inode_is_open_for_write(inode);
-}
-
 /*
  * Enable or disable caching for a file that is being opened as appropriate.
  * The cookie is allocated when the inode is initialised, but is not enabled at
@@ -307,93 +222,31 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	struct nfs_fscache_inode_auxdata auxdata;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	bool open_for_write = inode_is_open_for_write(inode);
 
 	if (!fscache_cookie_valid(cookie))
 		return;
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
-
-	if (inode_is_open_for_write(inode)) {
+	fscache_use_cookie(cookie, open_for_write);
+	if (open_for_write) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
-		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
-		fscache_disable_cookie(cookie, &auxdata, true);
-		fscache_uncache_all_inode_pages(cookie, inode);
-	} else {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
-		fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
-				      nfs_fscache_can_enable, inode);
-		if (fscache_cookie_enabled(cookie))
-			set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_invalidate(cookie, &auxdata, i_size_read(inode),
+				   FSCACHE_INVAL_DIO_WRITE);
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 
-/*
- * Release the caching state associated with a page, if the page isn't busy
- * interacting with the cache.
- * - Returns true (can release page) or false (page busy).
- */
-int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		struct fscache_cookie *cookie = nfs_i_fscache(page->mapping->host);
-
-		BUG_ON(!cookie);
-		dfprintk(FSCACHE, "NFS: fscache releasepage (0x%p/0x%p/0x%p)\n",
-			 cookie, page, NFS_I(page->mapping->host));
-
-		if (!fscache_maybe_release_page(cookie, page, gfp))
-			return 0;
-
-		nfs_inc_fscache_stats(page->mapping->host,
-				      NFSIOS_FSCACHE_PAGES_UNCACHED);
-	}
-
-	return 1;
-}
-
-/*
- * Release the caching state associated with a page if undergoing complete page
- * invalidation.
- */
-void __nfs_fscache_invalidate_page(struct page *page, struct inode *inode)
+void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 {
+	struct nfs_fscache_inode_auxdata auxdata;
+	struct nfs_inode *nfsi = NFS_I(inode);
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
 
-	BUG_ON(!cookie);
-
-	dfprintk(FSCACHE, "NFS: fscache invalidatepage (0x%p/0x%p/0x%p)\n",
-		 cookie, page, NFS_I(inode));
-
-	fscache_wait_on_page_write(cookie, page);
-
-	BUG_ON(!PageLocked(page));
-	fscache_uncache_page(cookie, page);
-	nfs_inc_fscache_stats(page->mapping->host,
-			      NFSIOS_FSCACHE_PAGES_UNCACHED);
-}
-
-/*
- * Handle completion of a page being read from the cache.
- * - Called in process (keventd) context.
- */
-static void nfs_readpage_from_fscache_complete(struct page *page,
-					       void *context,
-					       int error)
-{
-	dfprintk(FSCACHE,
-		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
-		 page, context, error);
-
-	/*
-	 * If the read completes with an error, mark the page with PG_checked,
-	 * unlock the page, and let the VM reissue the readpage.
-	 */
-	if (!error)
-		SetPageUptodate(page);
-	else
-		SetPageChecked(page);
-	unlock_page(page);
+	if (fscache_cookie_valid(cookie)) {
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_unuse_cookie(cookie, &auxdata, NULL);
+	}
 }
 
 /*
@@ -402,8 +255,6 @@ static void nfs_readpage_from_fscache_complete(struct page *page,
 int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 				struct inode *inode, struct page *page)
 {
-	int ret;
-
 	dfprintk(FSCACHE,
 		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
 		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
@@ -413,31 +264,7 @@ int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 		return 1;
 	}
 
-	ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
-					 page,
-					 nfs_readpage_from_fscache_complete,
-					 ctx,
-					 GFP_KERNEL);
-
-	switch (ret) {
-	case 0: /* read BIO submitted (page in fscache) */
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache: BIO submitted\n");
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
-		return ret;
-
-	case -ENOBUFS: /* inode not in cache */
-	case -ENODATA: /* page not in cache */
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache %d\n", ret);
-		return 1;
-
-	default:
-		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-	}
-	return ret;
+	return -ENOBUFS; // TODO: Use netfslib
 }
 
 /*
@@ -449,45 +276,10 @@ int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 				 struct list_head *pages,
 				 unsigned *nr_pages)
 {
-	unsigned npages = *nr_pages;
-	int ret;
-
 	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
-		 nfs_i_fscache(inode), npages, inode);
-
-	ret = fscache_read_or_alloc_pages(nfs_i_fscache(inode),
-					  mapping, pages, nr_pages,
-					  nfs_readpage_from_fscache_complete,
-					  ctx,
-					  mapping_gfp_mask(mapping));
-	if (*nr_pages < npages)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK,
-				      npages);
-	if (*nr_pages > 0)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL,
-				      *nr_pages);
-
-	switch (ret) {
-	case 0: /* read submitted to the cache for all pages */
-		BUG_ON(!list_empty(pages));
-		BUG_ON(*nr_pages != 0);
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: submitted\n");
-
-		return ret;
-
-	case -ENOBUFS: /* some pages aren't cached and can't be */
-	case -ENODATA: /* some pages aren't cached */
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
-		return 1;
+		 nfs_i_fscache(inode), *nr_pages, inode);
 
-	default:
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
-	}
-
-	return ret;
+	return -ENOBUFS; // TODO: Use netfslib
 }
 
 /*
@@ -496,25 +288,9 @@ int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
  */
 void __nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
 {
-	int ret;
-
 	dfprintk(FSCACHE,
 		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
 		 nfs_i_fscache(inode), page, page->index, page->flags, sync);
 
-	ret = fscache_write_page(nfs_i_fscache(inode), page,
-				 inode->i_size, GFP_KERNEL);
-	dfprintk(FSCACHE,
-		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
-		 page, page->index, page->flags, ret);
-
-	if (ret != 0) {
-		fscache_uncache_page(nfs_i_fscache(inode), page);
-		nfs_inc_fscache_stats(inode,
-				      NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
-	} else {
-		nfs_inc_fscache_stats(inode,
-				      NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
-	}
+	return; // TODO: Use netfslib
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 6754c8607230..26b6fb1cfd58 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -12,46 +12,10 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/fscache.h>
+#include <linux/iversion.h>
 
 #ifdef CONFIG_NFS_FSCACHE
 
-/*
- * set of NFS FS-Cache objects that form a superblock key
- */
-struct nfs_fscache_key {
-	struct rb_node		node;
-	struct nfs_client	*nfs_client;	/* the server */
-
-	/* the elements of the unique key - as used by nfs_compare_super() and
-	 * nfs_compare_mount_options() to distinguish superblocks */
-	struct {
-		struct {
-			unsigned long	s_flags;	/* various flags
-							 * (& NFS_MS_MASK) */
-		} super;
-
-		struct {
-			struct nfs_fsid fsid;
-			int		flags;
-			unsigned int	rsize;		/* read size */
-			unsigned int	wsize;		/* write size */
-			unsigned int	acregmin;	/* attr cache timeouts */
-			unsigned int	acregmax;
-			unsigned int	acdirmin;
-			unsigned int	acdirmax;
-		} nfs_server;
-
-		struct {
-			rpc_authflavor_t au_flavor;
-		} rpc_auth;
-
-		/* uniquifier - can be used if nfs_server.flags includes
-		 * NFS_MOUNT_UNSHARED  */
-		u8 uniq_len;
-		char uniquifier[0];
-	} key;
-};
-
 /*
  * Definition of the auxiliary data attached to NFS inode storage objects
  * within the cache.
@@ -69,32 +33,18 @@ struct nfs_fscache_inode_auxdata {
 	u64	change_attr;
 };
 
-/*
- * fscache-index.c
- */
-extern struct fscache_netfs nfs_fscache_netfs;
-extern const struct fscache_cookie_def nfs_fscache_server_index_def;
-extern const struct fscache_cookie_def nfs_fscache_super_index_def;
-extern const struct fscache_cookie_def nfs_fscache_inode_object_def;
-
-extern int nfs_fscache_register(void);
-extern void nfs_fscache_unregister(void);
-
 /*
  * fscache.c
  */
-extern void nfs_fscache_get_client_cookie(struct nfs_client *);
-extern void nfs_fscache_release_client_cookie(struct nfs_client *);
-
-extern void nfs_fscache_get_super_cookie(struct super_block *, const char *, int);
+extern int nfs_fscache_get_super_cookie(struct super_block *, const char *, int);
 extern void nfs_fscache_release_super_cookie(struct super_block *);
 
 extern void nfs_fscache_init_inode(struct inode *);
 extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
+extern void nfs_fscache_release_file(struct inode *, struct file *);
 
 extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
-extern int nfs_fscache_release_page(struct page *, gfp_t);
 
 extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
 				       struct inode *, struct page *);
@@ -103,25 +53,17 @@ extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
 					struct list_head *, unsigned *);
 extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
 
-/*
- * wait for a page to complete writing to the cache
- */
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page)
-{
-	if (PageFsCache(page))
-		fscache_wait_on_page_write(nfsi->fscache, page);
-}
-
-/*
- * release the caching state associated with a page if undergoing complete page
- * invalidation
- */
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode)
+static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
-	if (PageFsCache(page))
-		__nfs_fscache_invalidate_page(page, inode);
+	if (PageFsCache(page)) {
+		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+		fscache_note_page_release(nfs_i_fscache(page->mapping->host));
+		nfs_inc_fscache_stats(page->mapping->host,
+				      NFSIOS_FSCACHE_PAGES_UNCACHED);
+	}
+	return true;
 }
 
 /*
@@ -163,20 +105,32 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 		__nfs_readpage_to_fscache(inode, page, sync);
 }
 
-/*
- * Invalidate the contents of fscache for this inode.  This will not sleep.
- */
-static inline void nfs_fscache_invalidate(struct inode *inode)
+static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
+					      struct nfs_inode *nfsi)
 {
-	fscache_invalidate(NFS_I(inode)->fscache);
+	memset(auxdata, 0, sizeof(*auxdata));
+	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+
+	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
+		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
 }
 
 /*
- * Wait for an object to finish being invalidated.
+ * Invalidate the contents of fscache for this inode.  This will not sleep.
  */
-static inline void nfs_fscache_wait_on_invalidate(struct inode *inode)
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags)
 {
-	fscache_wait_on_invalidate(NFS_I(inode)->fscache);
+	struct nfs_fscache_inode_auxdata auxdata;
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	if (nfsi->fscache) {
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_invalidate(nfsi->fscache, &auxdata,
+				   i_size_read(&nfsi->vfs_inode), flags);
+	}
 }
 
 /*
@@ -190,12 +144,6 @@ static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 }
 
 #else /* CONFIG_NFS_FSCACHE */
-static inline int nfs_fscache_register(void) { return 0; }
-static inline void nfs_fscache_unregister(void) {}
-
-static inline void nfs_fscache_get_client_cookie(struct nfs_client *clp) {}
-static inline void nfs_fscache_release_client_cookie(struct nfs_client *clp) {}
-
 static inline void nfs_fscache_release_super_cookie(struct super_block *sb) {}
 
 static inline void nfs_fscache_init_inode(struct inode *inode) {}
@@ -207,11 +155,6 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
 	return 1; /* True: may release page */
 }
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode) {}
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page) {}
-
 static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 					    struct inode *inode,
 					    struct page *page)
@@ -230,8 +173,7 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 					   struct page *page, int sync) {}
 
 
-static inline void nfs_fscache_invalidate(struct inode *inode) {}
-static inline void nfs_fscache_wait_on_invalidate(struct inode *inode) {}
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index fda530d5e764..a918c3a834b6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -209,7 +209,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (flags & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
+		nfs_fscache_invalidate(inode, 0);
 	flags &= ~(NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED);
 
 	nfsi->cache_validity |= flags;
@@ -1289,6 +1289,7 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 {
 	int ret;
 
+	nfs_fscache_invalidate(inode, 0);
 	if (mapping->nrpages != 0) {
 		if (S_ISREG(inode->i_mode)) {
 			ret = nfs_sync_mapping(mapping);
@@ -1300,7 +1301,6 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 			return ret;
 	}
 	nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
-	nfs_fscache_wait_on_invalidate(inode);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) data cache invalidated\n",
 			inode->i_sb->s_id,
@@ -2374,10 +2374,6 @@ static int __init init_nfs_fs(void)
 	if (err < 0)
 		goto out9;
 
-	err = nfs_fscache_register();
-	if (err < 0)
-		goto out8;
-
 	err = nfsiod_start();
 	if (err)
 		goto out7;
@@ -2429,8 +2425,6 @@ static int __init init_nfs_fs(void)
 out6:
 	nfsiod_stop();
 out7:
-	nfs_fscache_unregister();
-out8:
 	unregister_pernet_subsys(&nfs_net_ops);
 out9:
 	nfs_sysfs_exit();
@@ -2445,7 +2439,6 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_readpagecache();
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
-	nfs_fscache_unregister();
 	unregister_pernet_subsys(&nfs_net_ops);
 	rpc_proc_unregister(&init_net, "nfs");
 	unregister_nfs_fs();
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index b3aee261801e..317ce27bdc4b 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -42,7 +42,6 @@
 			{ BIT(NFS_INO_ACL_LRU_SET), "ACL_LRU_SET" }, \
 			{ BIT(NFS_INO_INVALIDATING), "INVALIDATING" }, \
 			{ BIT(NFS_INO_FSCACHE), "FSCACHE" }, \
-			{ BIT(NFS_INO_FSCACHE_LOCK), "FSCACHE_LOCK" }, \
 			{ BIT(NFS_INO_LAYOUTCOMMIT), "NEED_LAYOUTCOMMIT" }, \
 			{ BIT(NFS_INO_LAYOUTCOMMITTING), "LAYOUTCOMMIT" }, \
 			{ BIT(NFS_INO_LAYOUTSTATS), "LAYOUTSTATS" }, \
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 3aced401735c..6ab5eeb000dc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1204,42 +1204,42 @@ static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
 }
 
 #ifdef CONFIG_NFS_FSCACHE
-static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_fs_context *ctx)
+static int nfs_get_cache_cookie(struct super_block *sb,
+				struct nfs_fs_context *ctx)
 {
 	struct nfs_server *nfss = NFS_SB(sb);
 	char *uniq = NULL;
 	int ulen = 0;
 
-	nfss->fscache_key = NULL;
 	nfss->fscache = NULL;
 
 	if (!ctx)
-		return;
+		return 0;
 
 	if (ctx->clone_data.sb) {
 		struct nfs_server *mnt_s = NFS_SB(ctx->clone_data.sb);
 		if (!(mnt_s->options & NFS_OPTION_FSCACHE))
-			return;
-		if (mnt_s->fscache_key) {
-			uniq = mnt_s->fscache_key->key.uniquifier;
-			ulen = mnt_s->fscache_key->key.uniq_len;
+			return 0;
+		if (mnt_s->fscache_uniq) {
+			uniq = mnt_s->fscache_uniq;
+			ulen = strlen(uniq);
 		}
 	} else {
 		if (!(ctx->options & NFS_OPTION_FSCACHE))
-			return;
+			return 0;
 		if (ctx->fscache_uniq) {
 			uniq = ctx->fscache_uniq;
 			ulen = strlen(ctx->fscache_uniq);
 		}
 	}
 
-	nfs_fscache_get_super_cookie(sb, uniq, ulen);
+	return nfs_fscache_get_super_cookie(sb, uniq, ulen);
 }
 #else
-static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_fs_context *ctx)
+static int nfs_get_cache_cookie(struct super_block *sb,
+				struct nfs_fs_context *ctx)
 {
+	return 0;
 }
 #endif
 
@@ -1299,7 +1299,9 @@ int nfs_get_tree_common(struct fs_context *fc)
 			s->s_blocksize_bits = bsize;
 			s->s_blocksize = 1U << bsize;
 		}
-		nfs_get_cache_cookie(s, ctx);
+		error = nfs_get_cache_cookie(s, ctx);
+		if (error < 0)
+			goto error_splat_super;
 	}
 
 	error = nfs_get_root(s, fc);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 9b7619ce17a7..2b322170372a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -294,6 +294,7 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
 	spin_unlock(&inode->i_lock);
+	nfs_fscache_invalidate(inode, 0);
 }
 
 /* A writeback failed: mark the page as bad, and invalidate the page cache */
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 05f249f20f55..00835bacd236 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -275,7 +275,6 @@ struct nfs4_copy_state {
 #define NFS_INO_ACL_LRU_SET	(2)		/* Inode is on the LRU list */
 #define NFS_INO_INVALIDATING	(3)		/* inode is being invalidated */
 #define NFS_INO_FSCACHE		(5)		/* inode can be cached by FS-Cache */
-#define NFS_INO_FSCACHE_LOCK	(6)		/* FS-Cache cookie management lock */
 #define NFS_INO_FORCE_READDIR	(7)		/* force readdirplus */
 #define NFS_INO_LAYOUTCOMMIT	(9)		/* layoutcommit required */
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 2a9acbfe00f0..77b2dba27bbb 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -120,11 +120,6 @@ struct nfs_client {
 	 * This is used to generate the mv0 callback address.
 	 */
 	char			cl_ipaddr[48];
-
-#ifdef CONFIG_NFS_FSCACHE
-	struct fscache_cookie	*fscache;	/* client index cache cookie */
-#endif
-
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
 };
@@ -194,8 +189,8 @@ struct nfs_server {
 	struct nfs_auth_info	auth_info;	/* parsed auth flavors */
 
 #ifdef CONFIG_NFS_FSCACHE
-	struct nfs_fscache_key	*fscache_key;	/* unique key for superblock */
-	struct fscache_cookie	*fscache;	/* superblock cookie */
+	struct fscache_volume	*fscache;	/* superblock cookie */
+	char			*fscache_uniq;	/* Uniquifier (or NULL) */
 #endif
 
 	u32			pnfs_blksize;	/* layout_blksize attr */


