Return-Path: <linux-fsdevel+bounces-20039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214A8CCD3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82DD1F21964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3012013CF8A;
	Thu, 23 May 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+nOSAGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34113CA92
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450269; cv=none; b=uqTyTixmRejMSMaM9NWiliWAnOiB6m+yuu4cCukg9McjiS6YD2eKSoTs4BS9CxtjrGL6oYOmNnudS8ZwxD9T5PDKP6t7WoW+QG7EMXhFhMmTG3uVUnvxfCsT5i5kF8Gijq3RSLnEgULcC0MznLTLrM7l5L++4Npapnz+GUyANyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450269; c=relaxed/simple;
	bh=lnjUifyPSPVB7tejsJYdTy3kJITVOSvFjQFhkzP75y4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qYd+toi6N6ukZ5CBPBmiTaGEkGJ+W/9cAWLx/fIg7GP9w4u4w3djli/SkW4uDUMCMr3tFhmU8sZSDO0stCc1Smc3Qk1yO5l19+5fv0I7aCoI3P6Wa5XFXFnny5YBQ59B56e/Xz7P1JwEIBGht4YL7AYy1J2L9kZ7CVYdsKAuGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+nOSAGB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716450267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLhXmfF9Sj87o1Kh7Mk5PB3h8im3PzkGpLpb1UjE6M4=;
	b=c+nOSAGBt0MLqJtP7OouZjBehHBfm4KJp6Mnu6V5GoOxknQnYYLg6fFpskTX+jIquBEZP1
	JtOQ/X+gt8UE7QfukyU8SB9m2KYGhHUXMnSOTq6EENFTVls4JKYD1AfzDj7b9xEHauh+rI
	1dFUNdoifnhmX45O9Qg6uaZYOD7SNaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-xEhMxZGhNqmZTQdYoGCbdQ-1; Thu, 23 May 2024 03:44:21 -0400
X-MC-Unique: xEhMxZGhNqmZTQdYoGCbdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0EA881227E;
	Thu, 23 May 2024 07:44:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA96C15BED;
	Thu, 23 May 2024 07:44:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zj0ErxVBE3DYT2Ea@gpd>
References: <Zj0ErxVBE3DYT2Ea@gpd> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-41-dhowells@redhat.com>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <531993.1716450257.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 May 2024 08:44:17 +0100
Message-ID: <531994.1716450257@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Andrea,

Note that there are changes to the netfslib write-side upstream and you mi=
ght
also want to apply the attached.

In https://bugs.launchpad.net/ubuntu/+source/autopkgtest/+bug/2056461 you =
say:

| It seems that kernel 6.8 introduced a regression in the 9pfs related to
| caching and netfslib, that can cause some user-space apps to read conten=
t
| from files that is not up-to-date (when they are used in a producer/cons=
umer
| fashion).

Can you clarify how these files are being used?

David
---
commit 39302c160390441ed5b4f4f7ad480c44eddf0962
Author: David Howells <dhowells@redhat.com>
Date:   Wed May 22 17:30:22 2024 +0100

    netfs, 9p: Fix race between umount and async request completion
    =

    There's a problem in 9p's interaction with netfslib whereby a crash oc=
curs
    because the 9p_fid structs get forcibly destroyed during client teardo=
wn
    (without paying attention to their refcounts) before netfslib has fini=
shed
    with them.  However, it's not a simple case of deferring the clunking =
that
    p9_fid_put() does as that requires the client.
    =

    The problem is that netfslib has to unlock pages and clear the IN_PROG=
RESS
    flag before destroying the objects involved - including the pid - and,=
 in
    any case, nothing checks to see if writeback completed barring looking=
 at
    the page flags.
    =

    Fix this by keeping a count of outstanding I/O requests (of any type) =
and
    waiting for it to quiesce during inode eviction.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Eric Van Hensbergen <ericvh@kernel.org>
    cc: Latchesar Ionkov <lucho@ionkov.net>
    cc: Dominique Martinet <asmadeus@codewreck.org>
    cc: Christian Schoenebeck <linux_oss@crudebyte.com>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: Steve French <sfrench@samba.org>
    cc: v9fs@lists.linux.dev
    cc: linux-afs@lists.infradead.org
    cc: linux-cifs@vger.kernel.org
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8c9a896d691e..57cfa9f65046 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -354,6 +354,7 @@ void v9fs_evict_inode(struct inode *inode)
 		version =3D cpu_to_le32(v9inode->qid.version);
 		netfs_clear_inode_writeback(inode, &version);
 =

+		netfs_wait_for_outstanding_io(inode);
 		clear_inode(inode);
 		filemap_fdatawrite(&inode->i_data);
 =

@@ -361,8 +362,10 @@ void v9fs_evict_inode(struct inode *inode)
 		if (v9fs_inode_cookie(v9inode))
 			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
-	} else
+	} else {
+		netfs_wait_for_outstanding_io(inode);
 		clear_inode(inode);
+	}
 }
 =

 struct inode *
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 94fc049aff58..c831e711a4ac 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -652,6 +652,7 @@ void afs_evict_inode(struct inode *inode)
 =

 	afs_set_cache_aux(vnode, &aux);
 	netfs_clear_inode_writeback(inode, &aux);
+	netfs_wait_for_outstanding_io(inode);
 	clear_inode(inode);
 =

 	while (!list_empty(&vnode->wb_keys)) {
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index c90d482b1650..f4a642727479 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -72,6 +72,7 @@ struct netfs_io_request *netfs_alloc_request(struct addr=
ess_space *mapping,
 		}
 	}
 =

+	atomic_inc(&ctx->io_count);
 	trace_netfs_rreq_ref(rreq->debug_id, 1, netfs_rreq_trace_new);
 	netfs_proc_add_rreq(rreq);
 	netfs_stat(&netfs_n_rh_rreq);
@@ -124,6 +125,7 @@ static void netfs_free_request(struct work_struct *wor=
k)
 {
 	struct netfs_io_request *rreq =3D
 		container_of(work, struct netfs_io_request, work);
+	struct netfs_inode *ictx =3D netfs_inode(rreq->inode);
 	unsigned int i;
 =

 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
@@ -142,6 +144,9 @@ static void netfs_free_request(struct work_struct *wor=
k)
 		}
 		kvfree(rreq->direct_bv);
 	}
+
+	if (atomic_dec_and_test(&ictx->io_count))
+		wake_up_var(&ictx->io_count);
 	call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }
 =

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ec5b639f421a..21c9e173ea9a 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -435,6 +435,7 @@ cifs_evict_inode(struct inode *inode)
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
+	netfs_wait_for_outstanding_io(inode);
 	clear_inode(inode);
 }
 =

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index d2d291a9cdad..3ca3906bb8da 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -68,6 +68,7 @@ struct netfs_inode {
 	loff_t			remote_i_size;	/* Size of the remote file */
 	loff_t			zero_point;	/* Size after which we assume there's no data
 						 * on the server */
+	atomic_t		io_count;	/* Number of outstanding reqs */
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
@@ -474,6 +475,7 @@ static inline void netfs_inode_init(struct netfs_inode=
 *ctx,
 	ctx->remote_i_size =3D i_size_read(&ctx->inode);
 	ctx->zero_point =3D LLONG_MAX;
 	ctx->flags =3D 0;
+	atomic_set(&ctx->io_count, 0);
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache =3D NULL;
 #endif
@@ -517,4 +519,20 @@ static inline struct fscache_cookie *netfs_i_cookie(s=
truct netfs_inode *ctx)
 #endif
 }
 =

+/**
+ * netfs_wait_for_outstanding_io - Wait for outstanding I/O to complete
+ * @ctx: The netfs inode to wait on
+ *
+ * Wait for outstanding I/O requests of any type to complete.  This is in=
tended
+ * to be called from inode eviction routines.  This makes sure that any
+ * resources held by those requests are cleaned up before we let the inod=
e get
+ * cleaned up.
+ */
+static inline void netfs_wait_for_outstanding_io(struct inode *inode)
+{
+	struct netfs_inode *ictx =3D netfs_inode(inode);
+
+	wait_var_event(&ictx->io_count, atomic_read(&ictx->io_count) =3D=3D 0);
+}
+
 #endif /* _LINUX_NETFS_H */


