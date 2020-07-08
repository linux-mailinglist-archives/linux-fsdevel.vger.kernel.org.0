Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0921822F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgGHI1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 04:27:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46572 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgGHI1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594196834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nkl9/v1z2n5oTxi5AR2lnE/ZboSNKokLUsnZ/l22yc8=;
        b=ii8HmGkT6vuc3EN/7LtKI29+YS2xEBIU7Gl5qnWJAZ2N2wueLYXpzkVsZWQmrMldcMBfNp
        i6Ii1DW8+vMA9uNRUABsPbeE+SyOQPNYMbpH3b788CVmDcL49b+lVoreFvFsK+HRcMEL/z
        m/+0zdox1M9hHaPTQVYt/kRHgxIS0Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-EekmgsW0PuybJaMHpAOPKA-1; Wed, 08 Jul 2020 04:27:10 -0400
X-MC-Unique: EekmgsW0PuybJaMHpAOPKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663F919057A1;
        Wed,  8 Jul 2020 08:27:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74F4860E3E;
        Wed,  8 Jul 2020 08:27:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix interruption of operations
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Jul 2020 09:27:07 +0100
Message-ID: <159419682767.3479071.15857808307874696111.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs filesystem driver allows unstarted operations to be cancelled by
signal, but most of these can easily be restarted (mkdir for example).  The
primary culprits for reproducing this are those applications that use
SIGALRM to display a progress counter.

File lock-extension operation is marked uninterruptible as we have a
limited time in which to do it, and the release op is marked
uninterruptible also as if we fail to unlock a file, we'll have to wait 20
mins before anyone can lock it again.

The store operation logs a warning if it gets interruption, e.g.:

	kAFS: Unexpected error from FS.StoreData -4

because it's run from the background - but it can also be run from
fdatasync()-type things.  However, store options aren't marked
interruptible at the moment.

Fix this in the following ways:

 (1) Mark store operations as uninterruptible.  It might make sense to
     relax this for certain situations, but I'm not sure how to make sure
     that background store ops aren't affected by signals to foreground
     processes that happen to trigger them.

 (2) In afs_get_io_locks(), where we're getting the serialisation lock for
     talking to the fileserver, return ERESTARTSYS rather than EINTR
     because a lot of the operations (e.g. mkdir) are restartable if we
     haven't yet started sending the op to the server.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_operation.c |    4 ++--
 fs/afs/write.c        |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index c264839b2fd0..24fd163c6323 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -71,7 +71,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 		swap(vnode, vnode2);
 
 	if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
-		op->error = -EINTR;
+		op->error = -ERESTARTSYS;
 		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [I 0]");
 		return false;
@@ -80,7 +80,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 
 	if (vnode2) {
 		if (mutex_lock_interruptible_nested(&vnode2->io_lock, 1) < 0) {
-			op->error = -EINTR;
+			op->error = -ERESTARTSYS;
 			op->flags |= AFS_OPERATION_STOP;
 			mutex_unlock(&vnode->io_lock);
 			op->flags &= ~AFS_OPERATION_LOCK_0;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index abfc8d3dc20c..60918b80b729 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -449,6 +449,7 @@ static int afs_store_data(struct address_space *mapping,
 	op->store.first_offset = offset;
 	op->store.last_to = to;
 	op->mtime = vnode->vfs_inode.i_mtime;
+	op->flags |= AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
 
 try_next_key:


