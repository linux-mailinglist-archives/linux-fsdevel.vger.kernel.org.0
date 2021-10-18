Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32F6432211
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhJRPK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232094AbhJRPKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t73E6Idu4u1vCUOOGXXOi3HSd+pcMMvFk0UXb/xsBn0=;
        b=c0rq659yPOr6LITX9EECuzTZg2WX1SrJyBD+14Jbho2NxYscnJ6xRYdRmOgswDGbiAQ7Sy
        9tdyhhFsRxguF+2uJ51ZKOlp8I5ecvqSckL/Z/wYKFsDvNmTGnVQem5RuW2IBCbybqN27w
        QoqxAR/UIVkDK5aHZUYeuSywgFznGRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-yPMScjPbPVuSvx7bNndAeQ-1; Mon, 18 Oct 2021 11:08:02 -0400
X-MC-Unique: yPMScjPbPVuSvx7bNndAeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FCEB1926DA2;
        Mon, 18 Oct 2021 15:08:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8768478B20;
        Mon, 18 Oct 2021 15:07:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 60/67] NFS: Convert fscache invalidation and update aux_data
 and i_size
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
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 16:07:55 +0100
Message-ID: <163456967575.2614702.17908978920093430374.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

Convert nfs_fscache_invalidate to the new FS-Cache API.  Also,
now when invalidating an fscache cookie, be sure to pass the latest
i_size as well as aux_data to fscache.

A few APIs no longer exist so remove them.  We can call directly to
wait_on_page_fscache() because it checks whether a page is an fscache
page before waiting on it.

Since the current NFS fscache implementation is only enabled when a
file is open for read, handle writes with invalidation.  If a write
extends the size of the file and fscache is enabled, we must invalidate
the object with the new size.

We must also invalidate fscache when doing a direct write to avoid
issues seen specifically with NFSv4.x when direct writes are followed
by non-direct (buffered) reads.  Note that we cannot call
fscache_invalidate() while holding inode->i_lock.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: linux-nfs@vger.kernel.org
---

 fs/nfs/direct.c  |    2 ++
 fs/nfs/file.c    |    7 ++++++-
 fs/nfs/fscache.c |   20 --------------------
 fs/nfs/fscache.h |   32 ++++++++++++++++++++++----------
 fs/nfs/inode.c   |    4 ++--
 fs/nfs/write.c   |    1 +
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..8b4839ef4b0c 100644
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
index 209dac208477..0a7f1e9f1203 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -436,6 +436,7 @@ static int nfs_release_page(struct page *page, gfp_t gfp)
 		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
 			return false;
 		wait_on_page_fscache(page);
+		fscache_note_page_release(nfs_i_fscache(page->mapping->host));
 	}
 	return true;
 }
@@ -559,7 +560,11 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	wait_on_page_fscache(page);
+	if (PageFsCache(page) &&
+	    wait_on_page_fscache_killable(vmf->page) < 0) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			nfs_wait_bit_killable, TASK_KILLABLE);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 5e584f2e84a9..8250a029759e 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -234,19 +234,6 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	}
 }
 
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
-}
-
 /*
  * Initialise the per-inode cache cookie pointer for an NFS inode.
  */
@@ -293,13 +280,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
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
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 1e30fcb45665..cc94b257059b 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -13,6 +13,7 @@
 #include <linux/nfs4_mount.h>
 #define FSCACHE_USE_FALLBACK_IO_API
 #include <linux/fscache.h>
+#include <linux/iversion.h>
 
 #ifdef CONFIG_NFS_FSCACHE
 
@@ -118,20 +119,32 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 		__nfs_readpage_to_fscache(inode, page);
 }
 
-/*
- * Invalidate the contents of fscache for this inode.  This will not sleep.
- */
-static inline void nfs_fscache_invalidate(struct inode *inode)
+static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
+				  struct nfs_inode *nfsi)
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
@@ -167,8 +180,7 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 					   struct page *page) {}
 
 
-static inline void nfs_fscache_invalidate(struct inode *inode) {}
-static inline void nfs_fscache_wait_on_invalidate(struct inode *inode) {}
+static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
 {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 853213b3a209..370c49b98646 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -209,7 +209,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (flags & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
+		nfs_fscache_invalidate(inode, 0);
 	if (inode->i_mapping->nrpages == 0)
 		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	flags &= ~(NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED);
@@ -1281,6 +1281,7 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 {
 	int ret;
 
+	nfs_fscache_invalidate(inode, 0);
 	if (mapping->nrpages != 0) {
 		if (S_ISREG(inode->i_mode)) {
 			ret = nfs_sync_mapping(mapping);
@@ -1292,7 +1293,6 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 			return ret;
 	}
 	nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
-	nfs_fscache_wait_on_invalidate(inode);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) data cache invalidated\n",
 			inode->i_sb->s_id,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 466266a96b2a..cbbf400db126 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -293,6 +293,7 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
 	spin_unlock(&inode->i_lock);
+	nfs_fscache_invalidate(inode, 0);
 }
 
 /* A writeback failed: mark the page as bad, and invalidate the page cache */


