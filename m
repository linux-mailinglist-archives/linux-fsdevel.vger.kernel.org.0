Return-Path: <linux-fsdevel+bounces-6785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F481C998
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B161F24E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7B182A8;
	Fri, 22 Dec 2023 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVV3ulNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341217992
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703246461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJQmrSBfBKkF1FEAH3EILbfyiDOBLbXiZySEe1rSlv0=;
	b=PVV3ulNs8WXTgAHZSENULp4kD00duOqe/rKzO0f6sHqUZATiS/FR2DKxIH9uxuISFywqvS
	4HaoEXf8oPhYQQMWOyaXJ+CAXU6+0dY3G5LiUotg4TAAtx8PqajyP/6wIhqP/tZaKGFdYX
	kbl5oCyUjDu7OT82niKcWLM6+DkOtas=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-6IC2kF7KOuGC0hQW2X7v9g-1; Fri,
 22 Dec 2023 07:00:56 -0500
X-MC-Unique: 6IC2kF7KOuGC0hQW2X7v9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD5373C2A1D2;
	Fri, 22 Dec 2023 12:00:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 776331C060AF;
	Fri, 22 Dec 2023 12:00:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2202548.1703245791@warthog.procyon.org.uk>
References: <2202548.1703245791@warthog.procyon.org.uk> <20231221230153.GA1607352@dev-arch.thelio-3990X> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-38-dhowells@redhat.com>
Cc: dhowells@redhat.com, Nathan Chancellor <nathan@kernel.org>,
    Anna Schumaker <Anna.Schumaker@Netapp.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] Fix oops in NFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2229135.1703246451.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Dec 2023 12:00:51 +0000
Message-ID: <2229136.1703246451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

David Howells <dhowells@redhat.com> wrote:

> A better way, though, is to move the call to nfs_netfs_inode_init()
> and give it a flag to say whether or not we want the facility.

Okay, I think I'll fold in the attached change.

David
---
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 55345753ae8d..b66466e97459 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -249,7 +249,7 @@ void v9fs_free_inode(struct inode *inode)
 static void v9fs_set_netfs_context(struct inode *inode)
 {
 	struct v9fs_inode *v9inode =3D V9FS_I(inode);
-	netfs_inode_init(&v9inode->netfs, &v9fs_req_ops);
+	netfs_inode_init(&v9inode->netfs, &v9fs_req_ops, true);
 }
 =

 int v9fs_init_inode(struct v9fs_session_info *v9ses,
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 1f656005018e..9c517269ff95 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -76,7 +76,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb=
, bool root)
 	/* there shouldn't be an existing inode */
 	BUG_ON(!(inode->i_state & I_NEW));
 =

-	netfs_inode_init(&vnode->netfs, NULL);
+	netfs_inode_init(&vnode->netfs, NULL, false);
 	inode->i_size		=3D 0;
 	inode->i_mode		=3D S_IFDIR | S_IRUGO | S_IXUGO;
 	if (root) {
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 2b44a342b4a1..381521e9e118 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -58,7 +58,7 @@ static noinline void dump_vnode(struct afs_vnode *vnode,=
 struct afs_vnode *paren
  */
 static void afs_set_netfs_context(struct afs_vnode *vnode)
 {
-	netfs_inode_init(&vnode->netfs, &afs_req_ops);
+	netfs_inode_init(&vnode->netfs, &afs_req_ops, true);
 }
 =

 /*
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 3149d79a9dbe..0c25d326afc4 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -574,7 +574,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	doutc(fsc->client, "%p\n", &ci->netfs.inode);
 =

 	/* Set parameters for the netfs library */
-	netfs_inode_init(&ci->netfs, &ceph_netfs_ops);
+	netfs_inode_init(&ci->netfs, &ceph_netfs_ops, false);
 =

 	spin_lock_init(&ci->i_ceph_lock);
 =

diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 5407ab8c8783..e3cb4923316b 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -80,7 +80,7 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_dat=
a *netfs)
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
 {
-	netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops);
+	netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops, false);
 }
 extern void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr);
 extern void nfs_netfs_read_completion(struct nfs_pgio_header *hdr);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a5374218efe4..06a03dd1aff1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -456,22 +456,27 @@ static inline struct netfs_inode *netfs_inode(struct=
 inode *inode)
  * netfs_inode_init - Initialise a netfslib inode context
  * @ctx: The netfs inode to initialise
  * @ops: The netfs's operations list
+ * @use_zero_point: True to use the zero_point read optimisation
  *
  * Initialise the netfs library context struct.  This is expected to foll=
ow on
  * directly from the VFS inode struct.
  */
 static inline void netfs_inode_init(struct netfs_inode *ctx,
-				    const struct netfs_request_ops *ops)
+				    const struct netfs_request_ops *ops,
+				    bool use_zero_point)
 {
 	ctx->ops =3D ops;
 	ctx->remote_i_size =3D i_size_read(&ctx->inode);
-	ctx->zero_point =3D ctx->remote_i_size;
+	ctx->zero_point =3D LLONG_MAX;
 	ctx->flags =3D 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache =3D NULL;
 #endif
 	/* ->releasepage() drives zero_point */
-	mapping_set_release_always(ctx->inode.i_mapping);
+	if (use_zero_point) {
+		ctx->zero_point =3D ctx->remote_i_size;
+		mapping_set_release_always(ctx->inode.i_mapping);
+	}
 }
 =

 /**


