Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6C4321F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhJRPJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232495AbhJRPJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SpDU7Yd4WeGgEtFtDrVHZCDDE0kPzrjNK8Y5Mkoa7iA=;
        b=FqAyQCFL1wCvwGCNANLwpnYUFBoNRt/BcHxswZ6Bz6kZ3Rb8dbPyQ2RvhxqZn6shV+A3KS
        eEuwd53QUlqZdoWbzmWtCuSWpsQ9wSsOcB53mEpYTulRwK9xzc8yfMrIchCAUNxjwdSBOQ
        PdKvFnqiGjCfZOs3b4uqyOIEqoVGbQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-CrAbGunJNI-ur0pcdh5kmA-1; Mon, 18 Oct 2021 11:06:56 -0400
X-MC-Unique: CrAbGunJNI-ur0pcdh5kmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2CD10151E0;
        Mon, 18 Oct 2021 15:06:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F64A60D30;
        Mon, 18 Oct 2021 15:06:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 58/67] NFS: Convert fscache_acquire_cookie and
 fscache_relinquish_cookie
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
Date:   Mon, 18 Oct 2021 16:06:24 +0100
Message-ID: <163456958468.2614702.7692988896929155656.stgit@warthog.procyon.org.uk>
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

The new FS-Cache netfs API changes the cookie API slightly.

The changes to fscache_acquire_cookie are:
* remove struct fscache_cookie_def
* add 'type' of cookie (was member of fscache_cookie_def)
* add 'name' of cookie (was member of fscache_cookie_def)
* add 'advice' flags (tells cache how to handle object); set to 0
* add 'preferred_cache' tag (if NULL, derive from parent)
* remove 'netfs_data'
* remove 'enable' (See fscache_use_cookie())

The changes to fscache_relinquish_cookie are:
* remove 'aux_data'

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: linux-nfs@vger.kernel.org
---

 fs/nfs/fscache-index.c |   68 ------------------------------------------------
 fs/nfs/fscache.c       |   44 ++++++++++++++++++++-----------
 fs/nfs/fscache.h       |    3 --
 3 files changed, 29 insertions(+), 86 deletions(-)

diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 4bd5ce736193..b4fdacd955f3 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -44,71 +44,3 @@ void nfs_fscache_unregister(void)
 {
 	fscache_unregister_netfs(&nfs_fscache_netfs);
 }
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
-};
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 68e266a37675..514d50d079a2 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -81,10 +81,15 @@ void nfs_fscache_get_client_cookie(struct nfs_client *clp)
 
 	/* create a cache index for looking up filehandles */
 	clp->fscache = fscache_acquire_cookie(nfs_fscache_netfs.primary_index,
-					      &nfs_fscache_server_index_def,
-					      &key, len,
-					      NULL, 0,
-					      clp, 0, true);
+					      FSCACHE_COOKIE_TYPE_INDEX,
+					      "NFS.server",
+					      0,    /* advice */
+					      NULL, /* preferred_cache */
+					      &key, /* index_key */
+					      len,
+					      NULL, /* aux_data */
+					      0,
+					      0);
 	dfprintk(FSCACHE, "NFS: get client cookie (0x%p/0x%p)\n",
 		 clp, clp->fscache);
 }
@@ -97,7 +102,7 @@ void nfs_fscache_release_client_cookie(struct nfs_client *clp)
 	dfprintk(FSCACHE, "NFS: releasing client cookie (0x%p/0x%p)\n",
 		 clp, clp->fscache);
 
-	fscache_relinquish_cookie(clp->fscache, NULL, false);
+	fscache_relinquish_cookie(clp->fscache, false);
 	clp->fscache = NULL;
 }
 
@@ -185,11 +190,15 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 
 	/* create a cache index for looking up filehandles */
 	nfss->fscache = fscache_acquire_cookie(nfss->nfs_client->fscache,
-					       &nfs_fscache_super_index_def,
-					       &key->key,
+					       FSCACHE_COOKIE_TYPE_INDEX,
+					       "NFS.super",
+					       0,    /* advice */
+					       NULL, /* preferred_cache */
+					       &key->key,  /* index_key */
 					       sizeof(key->key) + ulen,
-					       NULL, 0,
-					       nfss, 0, true);
+					       NULL, /* aux_data */
+					       0,
+					       0);
 	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
 		 nfss, nfss->fscache);
 	return;
@@ -213,7 +222,7 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	dfprintk(FSCACHE, "NFS: releasing superblock cookie (0x%p/0x%p)\n",
 		 nfss, nfss->fscache);
 
-	fscache_relinquish_cookie(nfss->fscache, NULL, false);
+	fscache_relinquish_cookie(nfss->fscache, false);
 	nfss->fscache = NULL;
 
 	if (nfss->fscache_key) {
@@ -254,10 +263,15 @@ void nfs_fscache_init_inode(struct inode *inode)
 	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
-					       &nfs_fscache_inode_object_def,
-					       nfsi->fh.data, nfsi->fh.size,
-					       &auxdata, sizeof(auxdata),
-					       nfsi, nfsi->vfs_inode.i_size, false);
+					       FSCACHE_COOKIE_TYPE_DATAFILE,
+					       "NFS.fh",
+					       0,             /* advice */
+					       NULL, /* preferred_cache */
+					       nfsi->fh.data, /* index_key */
+					       nfsi->fh.size,
+					       &auxdata,      /* aux_data */
+					       sizeof(auxdata),
+					       i_size_read(&nfsi->vfs_inode));
 }
 
 /*
@@ -272,7 +286,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
 	nfs_fscache_update_auxdata(&auxdata, nfsi);
-	fscache_relinquish_cookie(cookie, &auxdata, false);
+	fscache_relinquish_cookie(cookie, false);
 	nfsi->fscache = NULL;
 }
 
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 679055720dae..1e30fcb45665 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -74,9 +74,6 @@ struct nfs_fscache_inode_auxdata {
  * fscache-index.c
  */
 extern struct fscache_netfs nfs_fscache_netfs;
-extern const struct fscache_cookie_def nfs_fscache_server_index_def;
-extern const struct fscache_cookie_def nfs_fscache_super_index_def;
-extern const struct fscache_cookie_def nfs_fscache_inode_object_def;
 
 extern int nfs_fscache_register(void);
 extern void nfs_fscache_unregister(void);


