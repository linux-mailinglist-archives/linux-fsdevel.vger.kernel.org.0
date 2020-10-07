Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B8285FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgJGNWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 09:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbgJGNWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602076937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qdKfm8VeTTkUEHKC2yxyyIFpAIkQtVlXdOI42cjmIMc=;
        b=gspRmIzwIS5KyFNLzFIZJvHCyWRPr11MzyIhv7qhy5YVVTfDjPpXK6pvvO0fy86nLQPqsb
        90oovEd44f9jGfPgmw1mrdpkT+F0P6fa+9txajvKBIz8cIbdfejfZW88AUIxYI5moMkLRq
        sE0YkAeMjAk3otRPVK/wStKHdqW17/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-C93RWiLCN3qeLxwUP_hCxQ-1; Wed, 07 Oct 2020 09:22:16 -0400
X-MC-Unique: C93RWiLCN3qeLxwUP_hCxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7437802ED4;
        Wed,  7 Oct 2020 13:22:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-196.rdu2.redhat.com [10.10.116.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6F255D9DD;
        Wed,  7 Oct 2020 13:22:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix deadlock between writeback and truncate
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Oct 2020 14:22:12 +0100
Message-ID: <160207693283.3934207.6150787285715868358.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs filesystem has a lock[*] that it uses to serialise I/O operations
going to the server (vnode->io_lock), as the server will only perform one
modification operation at a time on any given file or directory.  This
prevents the the filesystem from filling up all the call slots to a server
with calls that aren't going to be executed in parallel anyway, thereby
allowing operations on other files to obtain slots.

  [*] Note that is probably redundant for directories at least since
      i_rwsem is used to serialise directory modifications and
      lookup/reading vs modification.  The server does allow parallel
      non-modification ops, however.

When a file truncation op completes, we truncate the in-memory copy of the
file to match - but we do it whilst still holding the io_lock, the idea
being to prevent races with other operations.

However, if writeback starts in a worker thread simultaneously with
truncation (whilst notify_change() is called with i_rwsem locked, writeback
pays it no heed), it may manage to set PG_writeback bits on the pages that
will get truncated before afs_setattr_success() manages to call
truncate_pagecache().  Truncate will then wait for those pages - whilst
still inside io_lock:

    # cat /proc/8837/stack
    [<0>] wait_on_page_bit_common+0x184/0x1e7
    [<0>] truncate_inode_pages_range+0x37f/0x3eb
    [<0>] truncate_pagecache+0x3c/0x53
    [<0>] afs_setattr_success+0x4d/0x6e
    [<0>] afs_wait_for_operation+0xd8/0x169
    [<0>] afs_do_sync_operation+0x16/0x1f
    [<0>] afs_setattr+0x1fb/0x25d
    [<0>] notify_change+0x2cf/0x3c4
    [<0>] do_truncate+0x7f/0xb2
    [<0>] do_sys_ftruncate+0xd1/0x104
    [<0>] do_syscall_64+0x2d/0x3a
    [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

The writeback operation, however, stalls indefinitely because it needs to
get the io_lock to proceed:

    # cat /proc/5940/stack
    [<0>] afs_get_io_locks+0x58/0x1ae
    [<0>] afs_begin_vnode_operation+0xc7/0xd1
    [<0>] afs_store_data+0x1b2/0x2a3
    [<0>] afs_write_back_from_locked_page+0x418/0x57c
    [<0>] afs_writepages_region+0x196/0x224
    [<0>] afs_writepages+0x74/0x156
    [<0>] do_writepages+0x2d/0x56
    [<0>] __writeback_single_inode+0x84/0x207
    [<0>] writeback_sb_inodes+0x238/0x3cf
    [<0>] __writeback_inodes_wb+0x68/0x9f
    [<0>] wb_writeback+0x145/0x26c
    [<0>] wb_do_writeback+0x16a/0x194
    [<0>] wb_workfn+0x74/0x177
    [<0>] process_one_work+0x174/0x264
    [<0>] worker_thread+0x117/0x1b9
    [<0>] kthread+0xec/0xf1
    [<0>] ret_from_fork+0x1f/0x30

and thus deadlock has occurred.

Note that whilst afs_setattr() calls filemap_write_and_wait(), the fact
that the caller is holding i_rwsem doesn't preclude more pages being
dirtied through an mmap'd region.

Fix this by:

 (1) Use the vnode validate_lock to mediate access between afs_setattr()
     and afs_writepages():

     (a) Exclusively lock validate_lock in afs_setattr() around the whole
     	 RPC operation.

     (b) If WB_SYNC_ALL isn't set on entry to afs_writepages(), trying to
     	 shared-lock validate_lock and returning immediately if we couldn't
     	 get it.

     (c) If WB_SYNC_ALL is set, wait for the lock.

     The validate_lock is also used to validate a file and to zap its cache
     if the file was altered by a third party, so it's probably a good fit
     for this.

 (2) Move the truncation outside of the io_lock in setattr, using the same
     hook as is used for local directory editing.

     This requires the old i_size to be retained in the operation record as
     we commit the revised status to the inode members inside the io_lock
     still, but we still need to know if we reduced the file size.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c    |   47 ++++++++++++++++++++++++++++++++++++++---------
 fs/afs/internal.h |    1 +
 fs/afs/write.c    |   11 +++++++++++
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1d13d2e882ad..0fe8844b4bee 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -810,14 +810,32 @@ void afs_evict_inode(struct inode *inode)
 
 static void afs_setattr_success(struct afs_operation *op)
 {
-	struct inode *inode = &op->file[0].vnode->vfs_inode;
+	struct afs_vnode_param *vp = &op->file[0];
+	struct inode *inode = &vp->vnode->vfs_inode;
+	loff_t old_i_size = i_size_read(inode);
+
+	op->setattr.old_i_size = old_i_size;
+	afs_vnode_commit_status(op, vp);
+	/* inode->i_size has now been changed. */
+
+	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
+		loff_t size = op->setattr.attr->ia_size;
+		if (size > old_i_size)
+			pagecache_isize_extended(inode, old_i_size, size);
+	}
+}
+
+static void afs_setattr_edit_file(struct afs_operation *op)
+{
+	struct afs_vnode_param *vp = &op->file[0];
+	struct inode *inode = &vp->vnode->vfs_inode;
 
-	afs_vnode_commit_status(op, &op->file[0]);
 	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
-		loff_t i_size = inode->i_size, size = op->setattr.attr->ia_size;
-		if (size > i_size)
-			pagecache_isize_extended(inode, i_size, size);
-		truncate_pagecache(inode, size);
+		loff_t size = op->setattr.attr->ia_size;
+		loff_t i_size = op->setattr.old_i_size;
+
+		if (size < i_size)
+			truncate_pagecache(inode, size);
 	}
 }
 
@@ -825,6 +843,7 @@ static const struct afs_operation_ops afs_setattr_operation = {
 	.issue_afs_rpc	= afs_fs_setattr,
 	.issue_yfs_rpc	= yfs_fs_setattr,
 	.success	= afs_setattr_success,
+	.edit_dir	= afs_setattr_edit_file,
 };
 
 /*
@@ -863,11 +882,16 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (S_ISREG(vnode->vfs_inode.i_mode))
 		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
 
+	/* Prevent any new writebacks from starting whilst we do this. */
+	down_write(&vnode->validate_lock);
+
 	op = afs_alloc_operation(((attr->ia_valid & ATTR_FILE) ?
 				  afs_file_key(attr->ia_file) : NULL),
 				 vnode->volume);
-	if (IS_ERR(op))
-		return PTR_ERR(op);
+	if (IS_ERR(op)) {
+		ret = PTR_ERR(op);
+		goto out_unlock;
+	}
 
 	afs_op_set_vnode(op, 0, vnode);
 	op->setattr.attr = attr;
@@ -880,5 +904,10 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	op->file[0].update_ctime = 1;
 
 	op->ops = &afs_setattr_operation;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+
+out_unlock:
+	up_write(&vnode->validate_lock);
+	_leave(" = %d", ret);
+	return ret;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 18042b7dab6a..e5f0446f27e5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -812,6 +812,7 @@ struct afs_operation {
 		} store;
 		struct {
 			struct iattr	*attr;
+			loff_t		old_i_size;
 		} setattr;
 		struct afs_acl	*acl;
 		struct yfs_acl	*yacl;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 4b2265cb1891..da12abd6db21 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -738,11 +738,21 @@ static int afs_writepages_region(struct address_space *mapping,
 int afs_writepages(struct address_space *mapping,
 		   struct writeback_control *wbc)
 {
+	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	pgoff_t start, end, next;
 	int ret;
 
 	_enter("");
 
+	/* We have to be careful as we can end up racing with setattr()
+	 * truncating the pagecache since the caller doesn't take a lock here
+	 * to prevent it.
+	 */
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		down_read(&vnode->validate_lock);
+	else if (!down_read_trylock(&vnode->validate_lock))
+		return 0;
+
 	if (wbc->range_cyclic) {
 		start = mapping->writeback_index;
 		end = -1;
@@ -762,6 +772,7 @@ int afs_writepages(struct address_space *mapping,
 		ret = afs_writepages_region(mapping, wbc, start, end, &next);
 	}
 
+	up_read(&vnode->validate_lock);
 	_leave(" = %d", ret);
 	return ret;
 }


