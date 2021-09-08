Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C040407E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhIHVXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 17:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhIHVXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631136128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jpdRoOn5BDB05RQA7ROFiVgGX3Km8+6qyEssXip4Qec=;
        b=Ksb61Glr/mHOsaf0bgLUGZ4D1cYIObMNMTUNgyx/HCXWf86q8Aup7+idiF7iNMd2hFMT3B
        d5QkBenZZpYgefLleRleEKGYf2ZyLudgQfYp0zlAQ6xvpJo7AOOc7MZHzzkh9uJU/ZSw1p
        kdjRhNs6YoCijSCbj7wWHR2jaFMh25k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-ahF0wDRjMKqE0W3zIef4yw-1; Wed, 08 Sep 2021 17:22:07 -0400
X-MC-Unique: ahF0wDRjMKqE0W3zIef4yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE25918D6A2C;
        Wed,  8 Sep 2021 21:22:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD6260C04;
        Wed,  8 Sep 2021 21:22:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix updating of i_blocks on file/dir extension
From:   David Howells <dhowells@redhat.com>
To:     markus.suvanto@gmail.com
Cc:     linux-afs@lists.infradead.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 22:22:04 +0100
Message-ID: <163113612442.352844.11162345591911691150.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an afs file or directory is modified locally such that the total file
size is extended, i_blocks needs to be recalculated too.

Fix this by making afs_write_end() and afs_edit_dir_add() call
afs_set_i_size() rather than setting inode->i_size directly as that also
recalculates inode->i_blocks.

This can be tested by creating and writing into directories and files and
then examining them with du.  Without this change, directories show a 4
blocks (they start out at 2048 bytes) and files show 0 blocks; with this
change, they should show a number of blocks proportional to the file size
rounded up to 1024.

Fixes: 31143d5d515ece617ffccb7df5ff75e4d1dfa120 ("AFS: implement basic file write support")
Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/dir_edit.c |    4 ++--
 fs/afs/inode.c    |   10 ----------
 fs/afs/internal.h |   10 ++++++++++
 fs/afs/write.c    |    2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index f4600c1353ad..540b9fc96824 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -263,7 +263,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		if (b == nr_blocks) {
 			_debug("init %u", b);
 			afs_edit_init_block(meta, block, b);
-			i_size_write(&vnode->vfs_inode, (b + 1) * AFS_DIR_BLOCK_SIZE);
+			afs_set_i_size(vnode, (b + 1) * AFS_DIR_BLOCK_SIZE);
 		}
 
 		/* Only lower dir pages have a counter in the header. */
@@ -296,7 +296,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 new_directory:
 	afs_edit_init_block(meta, meta, 0);
 	i_size = AFS_DIR_BLOCK_SIZE;
-	i_size_write(&vnode->vfs_inode, i_size);
+	afs_set_i_size(vnode, i_size);
 	slot = AFS_DIR_RESV_BLOCKS0;
 	page = page0;
 	block = meta;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 126daf9969db..8fcffea2daf5 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -53,16 +53,6 @@ static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *paren
 		dump_stack();
 }
 
-/*
- * Set the file size and block count.  Estimate the number of 512 bytes blocks
- * used, rounded up to nearest 1K for consistency with other AFS clients.
- */
-static void afs_set_i_size(struct afs_vnode *vnode, u64 size)
-{
-	i_size_write(&vnode->vfs_inode, size);
-	vnode->vfs_inode.i_blocks = ((size + 1023) >> 10) << 1;
-}
-
 /*
  * Initialise an inode from the vnode status.
  */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c97618855b46..12b2bdae6d1a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1595,6 +1595,16 @@ static inline void afs_update_dentry_version(struct afs_operation *op,
 			(void *)(unsigned long)dir_vp->scb.status.data_version;
 }
 
+/*
+ * Set the file size and block count.  Estimate the number of 512 bytes blocks
+ * used, rounded up to nearest 1K for consistency with other AFS clients.
+ */
+static inline void afs_set_i_size(struct afs_vnode *vnode, u64 size)
+{
+	i_size_write(&vnode->vfs_inode, size);
+	vnode->vfs_inode.i_blocks = ((size + 1023) >> 10) << 1;
+}
+
 /*
  * Check for a conflicting operation on a directory that we just unlinked from.
  * If someone managed to sneak a link or an unlink in on the file we just
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 32a764c24284..2dfe3b3a53d6 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -137,7 +137,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		write_seqlock(&vnode->cb_lock);
 		i_size = i_size_read(&vnode->vfs_inode);
 		if (maybe_i_size > i_size)
-			i_size_write(&vnode->vfs_inode, maybe_i_size);
+			afs_set_i_size(vnode, maybe_i_size);
 		write_sequnlock(&vnode->cb_lock);
 	}
 


