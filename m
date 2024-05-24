Return-Path: <linux-fsdevel+bounces-20118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6948CE6F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B181C2225B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58E12C482;
	Fri, 24 May 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P39J+PgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8212C47A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560788; cv=none; b=PruvZRlKHIeUqwFt3TfQHjUEk98GbiXp5w9jU8+w0A8v1lKhtWugufrv/ndgLwGHpRRkORPjSy6qzGAqx1VyETGuKBcPyG7kMwK3R7XZYIeLoA1kvGvVpKdQO1AfydPkGgsht6xRrdxczZe/+9dBbk6XNguoE35b3SMQq6d7+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560788; c=relaxed/simple;
	bh=/hO+Wdk51Ceeo7dHaf4yVaejFzzuVQkXGewi20m1Row=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=YMRN+JC9+C5nlep1Ek7fMaRuf/NDU74dBWP/YWfWATLfIPW+2E3aHJuaGhLLJX0yqql63qx0ZuR6Zi7uu6ivYJxGJTS3C6vzNma497GWPCzMWetR5qdlqeL3wQM1O+Zv1h5KqUQHh/2ZnLuppwSLbYOMPaQX3gr6qpU2/F8U4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P39J+PgD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716560786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GLnGM17UL4b12TgJD1s/b9rU7JDsVx4PpoKaNTMgNmk=;
	b=P39J+PgDdkmvyI1GHVFrwyuES3UkvaMWko3H+3VIpXLHLDWWqFVixQmBCnbGvvAOjSBSzH
	+tmFKUGB3k+JG6SKRTEBB++gB1BYkeFDFPKaDmL7s4cSpdOQYsR/c0KcrKugjKf4725hpl
	6BDqQQxks7kJQp/Ho3iHhNCMXbprswM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-QUYKM_jeN5mRBk6fOMzu1g-1; Fri, 24 May 2024 10:26:23 -0400
X-MC-Unique: QUYKM_jeN5mRBk6fOMzu1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4613C800994;
	Fri, 24 May 2024 14:26:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63F432026D68;
	Fri, 24 May 2024 14:26:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>
cc: dhowells@redhat.com,
    syzbot+df038d463cca332e8414@syzkaller.appspotmail.com,
    syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com,
    syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
    Hillf Danton <hdanton@sina.com>,
    Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v3] netfs, 9p: Fix race between umount and async request completion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <755890.1716560771.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 15:26:11 +0100
Message-ID: <755891.1716560771@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

netfs, 9p: Fix race between umount and async request completion

There's a problem in 9p's interaction with netfslib whereby a crash occurs
because the 9p_fid structs get forcibly destroyed during client teardown
(without paying attention to their refcounts) before netfslib has finished
with them.  However, it's not a simple case of deferring the clunking that
p9_fid_put() does as that requires the p9_client record to still be
present.

The problem is that netfslib has to unlock pages and clear the IN_PROGRESS
flag before destroying the objects involved - including the fid - and, in
any case, nothing checks to see if writeback completed barring looking at
the page flags.

Fix this by keeping a count of outstanding I/O requests (of any type) and
waiting for it to quiesce during inode eviction.

Reported-by: syzbot+df038d463cca332e8414@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000005be0aa061846f8d6@google.com/
Reported-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000b86c5e06130da9c6@google.com/
Reported-by: syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000041f960618206d7e@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Tested-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Hillf Danton <hdanton@sina.com>
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
Notes:
    Changes
    =3D=3D=3D=3D=3D=3D=3D
    ver #3)
     - Adjust commit message; no change to the diff.
    ver #2)
     - Wait for outstanding I/O before clobbering the pagecache.

 fs/9p/vfs_inode.c      |    1 +
 fs/afs/inode.c         |    1 +
 fs/netfs/objects.c     |    5 +++++
 fs/smb/client/cifsfs.c |    1 +
 include/linux/netfs.h  |   18 ++++++++++++++++++
 5 files changed, 26 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8c9a896d691e..effb3aa1f3ed 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -349,6 +349,7 @@ void v9fs_evict_inode(struct inode *inode)
 	__le32 __maybe_unused version;
 =

 	if (!is_bad_inode(inode)) {
+		netfs_wait_for_outstanding_io(inode);
 		truncate_inode_pages_final(&inode->i_data);
 =

 		version =3D cpu_to_le32(v9inode->qid.version);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 94fc049aff58..15bb7989c387 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -648,6 +648,7 @@ void afs_evict_inode(struct inode *inode)
 =

 	ASSERTCMP(inode->i_ino, =3D=3D, vnode->fid.vnode);
 =

+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 =

 	afs_set_cache_aux(vnode, &aux);
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
index ec5b639f421a..14810ffd15c8 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -431,6 +431,7 @@ cifs_free_inode(struct inode *inode)
 static void
 cifs_evict_inode(struct inode *inode)
 {
+	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
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


