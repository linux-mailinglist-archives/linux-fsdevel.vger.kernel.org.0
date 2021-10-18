Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837814321A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhJRPFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbhJRPDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyfueRWcvZbFZpicF1tHL+3lmAtJffKA8+YjsGo6828=;
        b=O2mI8Y+4wq85HMCrlfhhAPgGACoqLiAoge5vIJkkZnh2DWEpWtjdZDeUTrDiLCuBVdd4Zq
        D1mDVq1FXrQV3+0jbyOVmcRA9TuwzXAOHD/Pp8bPCWY/695SDEvdgq3zH2zO3IzO/MIXLu
        qylVwjr+KO08q5BkJcWIEQ3bzMPh60c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-2IzxT3O8Mg-udXAv-P67-Q-1; Mon, 18 Oct 2021 11:01:04 -0400
X-MC-Unique: 2IzxT3O8Mg-udXAv-P67-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C4C80DDE3;
        Mon, 18 Oct 2021 15:01:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943FF60BF4;
        Mon, 18 Oct 2021 15:00:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 41/67] afs: Render cache cookie key as big endian
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
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
Date:   Mon, 18 Oct 2021 16:00:56 +0100
Message-ID: <163456925673.2614702.17571187496574827113.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Render the parts of the cookie key for an afs inode cookie as big endian.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/file.c     |    2 +-
 fs/afs/inode.c    |   16 ++++++++--------
 fs/afs/internal.h |    8 +++++++-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index b4666da93b54..5e29d433960d 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -189,7 +189,7 @@ int afs_release(struct inode *inode, struct file *file)
 
 	if ((file->f_mode & FMODE_WRITE)) {
 		i_size = i_size_read(&vnode->vfs_inode);
-		aux.data_version = vnode->status.data_version;
+		afs_set_cache_aux(vnode, &aux);
 		fscache_unuse_cookie(afs_vnode_cache(vnode), &aux, &i_size);
 	} else {
 		fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c21c1352b149..842570e4470f 100644
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
 
@@ -424,11 +424,11 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 		return;
 	}
 
-	key.vnode_id		= vnode->fid.vnode;
-	key.unique		= vnode->fid.unique;
-	key.vnode_id_ext[0]	= vnode->fid.vnode >> 32;
-	key.vnode_id_ext[1]	= vnode->fid.vnode_hi;
-	aux.data_version	= vnode->status.data_version;
+	key.vnode_id		= htonl(vnode->fid.vnode);
+	key.unique		= htonl(vnode->fid.unique);
+	key.vnode_id_ext[0]	= htonl(vnode->fid.vnode >> 32);
+	key.vnode_id_ext[1]	= htonl(vnode->fid.vnode_hi);
+	afs_set_cache_aux(vnode, &aux);
 
 	vnode->cache = fscache_acquire_cookie(
 		vnode->volume->cache,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 8e168c3fa5d1..3180ba6bd46d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -869,9 +869,15 @@ struct afs_operation {
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
 /*
  * We use page->private to hold the amount of the page that we've written to,
  * splitting the field into two parts.  However, we need to represent a range


