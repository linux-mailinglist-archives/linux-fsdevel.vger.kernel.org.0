Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7B4D4EFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiCJQY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiCJQXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2029198D07
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OEvdGln4GLB/K6WbXv/BIS67SElyOgtgishIXX+IXU=;
        b=SQo9TRpbuRykNsn+zSkuGI/UeWhQ7D9Zt9GlLfwk4XGiz/VKsEAgnfh78siEt1V5awALOX
        GEY5u1UMTvHDqb/KVmneZJSBM5XqQELxotEygr+tcLrISsg/nrzhHoJ5tejkmfruSN6Dhl
        MLf5xqmrW5bpWodFsutdAT427VdGY4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-ixK_enuePSaw29LoFcSyjg-1; Thu, 10 Mar 2022 11:21:24 -0500
X-MC-Unique: ixK_enuePSaw29LoFcSyjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25C5F1854E31;
        Thu, 10 Mar 2022 16:21:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 089AB7C04D;
        Thu, 10 Mar 2022 16:20:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 20/20] afs: Maintain netfs_i_context::remote_i_size
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, linux-afs@lists.infradead.org,
        dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 16:20:35 +0000
Message-ID: <164692923592.2099075.5466132542956550401.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make afs use netfslib's tracking for the server's idea of what the current
inode size is independently of inode->i_size.  We really want to use this
value when calculating the new vnode size when initiating a StoreData RPC
op rather than the size stat() presents to the user (ie. inode->i_size) as
the latter is affected by as-yet uncommitted writes.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/164623014626.3564931.8375344024648265358.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678220204.1200972.17408022517463940584.stgit@warthog.procyon.org.uk/ # v2
---

 fs/afs/inode.c |    1 +
 fs/afs/write.c |    7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 5b5e40197655..2fe402483ad5 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -246,6 +246,7 @@ static void afs_apply_status(struct afs_operation *op,
 		 * idea of what the size should be that's not the same as
 		 * what's on the server.
 		 */
+		vnode->netfs_ctx.remote_i_size = status->size;
 		if (change_size) {
 			afs_set_i_size(vnode, status->size);
 			inode->i_ctime = t;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index e4b47f67a408..85c9056ba9fb 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -353,9 +353,10 @@ static const struct afs_operation_ops afs_store_data_operation = {
 static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos,
 			  bool laundering)
 {
+	struct netfs_i_context *ictx = &vnode->netfs_ctx;
 	struct afs_operation *op;
 	struct afs_wb_key *wbk = NULL;
-	loff_t size = iov_iter_count(iter), i_size;
+	loff_t size = iov_iter_count(iter);
 	int ret = -ENOKEY;
 
 	_enter("%s{%llx:%llu.%u},%llx,%llx",
@@ -377,15 +378,13 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 		return -ENOMEM;
 	}
 
-	i_size = i_size_read(&vnode->vfs_inode);
-
 	afs_op_set_vnode(op, 0, vnode);
 	op->file[0].dv_delta = 1;
 	op->file[0].modification = true;
 	op->store.write_iter = iter;
 	op->store.pos = pos;
 	op->store.size = size;
-	op->store.i_size = max(pos + size, i_size);
+	op->store.i_size = max(pos + size, ictx->remote_i_size);
 	op->store.laundering = laundering;
 	op->mtime = vnode->vfs_inode.i_mtime;
 	op->flags |= AFS_OPERATION_UNINTR;


