Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D797556CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 22:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjGPUyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 16:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGPUyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030CE45;
        Sun, 16 Jul 2023 13:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D85560E2C;
        Sun, 16 Jul 2023 20:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AB6C433C8;
        Sun, 16 Jul 2023 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540857;
        bh=dQJNXT7z4f+Rc/2+nxexWGiBHtZg0gmSSzhOCGso6Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+j4jUT1KOs1iEc6lZKkRq9q0Wsa3q+rG3RH5Tj/+CeNOWRGquiCaeM8Jf0o2/76F
         wIsbVBztJL/5lnrBFnECAwIHCnnmxhyhwbPlxToio9MV49TKtLRFwAJbk49VHDdENG
         F0sMoAQoTIsgzn+l0vg4ICDLQnnNEYducfkFR79A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 512/591] afs: Fix accidental truncation when storing data
Date:   Sun, 16 Jul 2023 21:50:51 +0200
Message-ID: <20230716194937.129813314@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 03275585cabd0240944f19f33d7584a1b099a3a8 ]

When an AFS FS.StoreData RPC call is made, amongst other things it is
given the resultant file size to be.  On the server, this is processed
by truncating the file to new size and then writing the data.

Now, kafs has a lock (vnode->io_lock) that serves to serialise
operations against a specific vnode (ie.  inode), but the parameters for
the op are set before the lock is taken.  This allows two writebacks
(say sync and kswapd) to race - and if writes are ongoing the writeback
for a later write could occur before the writeback for an earlier one if
the latter gets interrupted.

Note that afs_writepages() cannot take i_mutex and only takes a shared
lock on vnode->validate_lock.

Also note that the server does the truncation and the write inside a
lock, so there's no problem at that end.

Fix this by moving the calculation for the proposed new i_size inside
the vnode->io_lock.  Also reset the iterator (which we might have read
from) and update the mtime setting there.

Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/3526895.1687960024@warthog.procyon.org.uk/
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 08fd456dde67c..3ecc212b62099 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -381,17 +381,19 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	afs_op_set_vnode(op, 0, vnode);
 	op->file[0].dv_delta = 1;
 	op->file[0].modification = true;
-	op->store.write_iter = iter;
 	op->store.pos = pos;
 	op->store.size = size;
-	op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
 	op->store.laundering = laundering;
-	op->mtime = vnode->netfs.inode.i_mtime;
 	op->flags |= AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
 
 try_next_key:
 	afs_begin_vnode_operation(op);
+
+	op->store.write_iter = iter;
+	op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
+	op->mtime = vnode->netfs.inode.i_mtime;
+
 	afs_wait_for_operation(op);
 
 	switch (op->error) {
-- 
2.39.2



