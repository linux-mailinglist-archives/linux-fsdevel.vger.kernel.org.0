Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0C1CBA2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEHVvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 17:51:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgEHVvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 17:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588974693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mj04HZ7mvvO2/7hjzPs2ixKAeuvpGcyRfUqAELX/Bo=;
        b=MyGvCQjfOVJyL5BAib8d872h8OJ3yQzFIYPIh5VBYQLnYJAqqaKtvxTs9wrlzxfWozjffW
        cER6l2e4MrFkS5NMzszVQg5ZQrLYYNaLjYdRT3x6hNNVPpHF+4ikOMCaU6K1Ro5O4aZHdz
        Q06H20Xej4BUBxg6jJdGUUuq9W3RP/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218--enK5OAGNmq5-Li6e_6R8Q-1; Fri, 08 May 2020 17:51:31 -0400
X-MC-Unique: -enK5OAGNmq5-Li6e_6R8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05EDD1895A39;
        Fri,  8 May 2020 21:51:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26F1D1E6;
        Fri,  8 May 2020 21:51:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/4] NFSv4: Fix fscache cookie aux_data to ensure change_attr
 is included
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 May 2020 22:51:27 +0100
Message-ID: <158897468722.1116213.9964942101141957205.stgit@warthog.procyon.org.uk>
In-Reply-To: <158897464246.1116213.8184341356151224705.stgit@warthog.procyon.org.uk>
References: <158897464246.1116213.8184341356151224705.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

Commit 402cb8dda949 ("fscache: Attach the index key and aux data to
the cookie") added the aux_data and aux_data_len to parameters to
fscache_acquire_cookie(), and updated the callers in the NFS client.
In the process it modified the aux_data to include the change_attr,
but missed adding change_attr to a couple places where aux_data was
used.  Specifically, when opening a file and the change_attr is not
added, the following attempt to lookup an object will fail inside
cachefiles_check_object_xattr() = -116 due to
nfs_fscache_inode_check_aux() failing memcmp on auxdata and returning
FSCACHE_CHECKAUX_OBSOLETE.

Fix this by adding nfs_fscache_update_auxdata() to set the auxdata
from all relevant fields in the inode, including the change_attr.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.c |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index f51718415606..a60df88efc40 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -225,6 +225,19 @@ void nfs_fscache_release_super_cookie(struct super_block *sb)
 	}
 }
 
+static void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
+				  struct nfs_inode *nfsi)
+{
+	memset(auxdata, 0, sizeof(*auxdata));
+	auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+
+	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
+		auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
+}
+
 /*
  * Initialise the per-inode cache cookie pointer for an NFS inode.
  */
@@ -238,14 +251,7 @@ void nfs_fscache_init_inode(struct inode *inode)
 	if (!(nfss->fscache && S_ISREG(inode->i_mode)))
 		return;
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
-
-	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
-		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
+	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
 					       &nfs_fscache_inode_object_def,
@@ -265,11 +271,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
 
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+	nfs_fscache_update_auxdata(&auxdata, nfsi);
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
 }
@@ -309,11 +311,7 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	if (!fscache_cookie_valid(cookie))
 		return;
 
-	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
-	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
-	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
-	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
+	nfs_fscache_update_auxdata(&auxdata, nfsi);
 
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);


