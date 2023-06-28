Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780D77412FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjF1NsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232218AbjF1NsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687960037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fn/bqfguGzs3lkCA5wKrTQnKBSDaj3bzPZJgusB7pXE=;
        b=D7MrOkA2v+dpVPYLBlxnJ6FXdpM47qzSigIua6QZA96p961flgITIW6ZbasBDS0XfWevLt
        MNWyjCK6wFZe2DXl/0NAGpBPiDmrGNFZsQvCoKlpgPIjwGJHef6To2hbtfTJFCPjLi/ROb
        hfehA2HxmMB0ubgBU1DxG95bPFxXyBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-2BDt8uANN7Kp1jMQTQhbfQ-1; Wed, 28 Jun 2023 09:47:14 -0400
X-MC-Unique: 2BDt8uANN7Kp1jMQTQhbfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08CF488D1A1;
        Wed, 28 Jun 2023 13:47:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5AC40C2063;
        Wed, 28 Jun 2023 13:47:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix accidental truncation when storing data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3526894.1687960024.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 28 Jun 2023 14:47:04 +0100
Message-ID: <3526895.1687960024@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

When an AFS FS.StoreData RPC call is made, amongst other things it is give=
n
the resultant file size to be.  On the server, this is processed by
truncating the file to new size and then writing the data.

Now, kafs has a lock (vnode->io_lock) that serves to serialise operations
against a specific vnode (ie. inode), but the parameters for the op are se=
t
before the lock is taken.  This allows two writebacks (say sync and kswapd=
)
to race - and if writes are ongoing the writeback for a later write could
occur before the writeback for an earlier one if the latter gets
interrupted.

Note that afs_writepages() cannot take i_mutex and only takes a shared loc=
k
on vnode->validate_lock.

Also note that the server does the truncation and the write inside a lock,
so there's no problem at that end.

Fix this by moving the calculation for the proposed new i_size inside the
vnode->io_lock.  Also reset the iterator (which we might have read from)
and update the mtime setting there.

Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/write.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 8750b99c3f56..c1f4391ccd7c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -413,17 +413,19 @@ static int afs_store_data(struct afs_vnode *vnode, s=
truct iov_iter *iter, loff_t
 	afs_op_set_vnode(op, 0, vnode);
 	op->file[0].dv_delta =3D 1;
 	op->file[0].modification =3D true;
-	op->store.write_iter =3D iter;
 	op->store.pos =3D pos;
 	op->store.size =3D size;
-	op->store.i_size =3D max(pos + size, vnode->netfs.remote_i_size);
 	op->store.laundering =3D laundering;
-	op->mtime =3D vnode->netfs.inode.i_mtime;
 	op->flags |=3D AFS_OPERATION_UNINTR;
 	op->ops =3D &afs_store_data_operation;
 =

 try_next_key:
 	afs_begin_vnode_operation(op);
+
+	op->store.write_iter =3D iter;
+	op->store.i_size =3D max(pos + size, vnode->netfs.remote_i_size);
+	op->mtime =3D vnode->netfs.inode.i_mtime;
+
 	afs_wait_for_operation(op);
 =

 	switch (op->error) {

