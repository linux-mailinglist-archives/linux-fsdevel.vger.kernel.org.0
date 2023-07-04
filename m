Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076A7478A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGDTXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGDTXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFF10DA
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688498540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F9uTCmOrCCGGvfYnmrlpJhQABTj4UokRMqWz/zJVKVo=;
        b=F2+eVigS7XDVyLra3C2IvoTRTjbHQ6ioN0nJ5s3uSa/d28+yWm35r3oqtvNv3xLwRKDdNz
        Tko1FIW7On5WSJ6TB4Aw+eeyd1ZajqRIHEqRxsDSvsRiX+PNwrFCc3PNqY19dE/Gb3VcEp
        Gq84gyqB+NCa55c//O/Fx/xcdLg9eIY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-E031IvP4MH22QcHWqEMA_A-1; Tue, 04 Jul 2023 15:22:16 -0400
X-MC-Unique: E031IvP4MH22QcHWqEMA_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6897C185A792;
        Tue,  4 Jul 2023 19:22:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A2E12166B31;
        Tue,  4 Jul 2023 19:22:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix accidental truncation when storing data
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1591987.1688498535.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 04 Jul 2023 20:22:15 +0100
Message-ID: <1591988.1688498535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this fix please?

Thanks,
David
---
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
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/3526895.1687960024@warthog.procyon.org.uk/
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

