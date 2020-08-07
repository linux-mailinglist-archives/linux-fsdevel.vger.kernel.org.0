Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A723F35E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHGT5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:57:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39839 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726846AbgHGTzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PHi22BkJAek7xvY326jzMafeEyOJdaMjdrgxmITiXU=;
        b=UluaHTa8UbLw3MwhnLPdLVz3X7gWxmuvKb0JX4kcGA+R77mw4iaCxjI9lMgLicImUOmcwU
        Wv2JWZbrZJsHIchl/enq0jMH/H/PjzKAu7wrwG7bGoYe95kc0/HZrH89AuJ4VI1oK2ro+o
        RkUpJR5ItTr3WCBzSN/2+tiNOq+wWVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-UWWIYsY5Pb2C0eOynjdfpA-1; Fri, 07 Aug 2020 15:55:48 -0400
X-MC-Unique: UWWIYsY5Pb2C0eOynjdfpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A0C41902EA0;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47D652DE73;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 12972222E5B; Fri,  7 Aug 2020 15:55:39 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 15/20] fuse, dax: Take ->i_mmap_sem lock during dax page fault
Date:   Fri,  7 Aug 2020 15:55:21 -0400
Message-Id: <20200807195526.426056-16-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need some kind of locking mechanism here. Normal file systems like
ext4 and xfs seems to take their own semaphore to protect agains
truncate while fault is going on.

We have additional requirement to protect against fuse dax memory range
reclaim. When a range has been selected for reclaim, we need to make sure
no other read/write/fault can try to access that memory range while
reclaim is in progress. Once reclaim is complete, lock will be released
and read/write/fault will trigger allocation of fresh dax range.

Taking inode_lock() is not an option in fault path as lockdep complains
about circular dependencies. So define a new fuse_inode->i_mmap_sem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c    |  2 ++
 fs/fuse/file.c   | 15 ++++++++++++---
 fs/fuse/fuse_i.h |  7 +++++++
 fs/fuse/inode.c  |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..f40766c0693b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1609,8 +1609,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache(inode, outarg.attr.size);
 		invalidate_inode_pages2(inode->i_mapping);
+		up_write(&fi->i_mmap_sem);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index be7d90eb5b41..00ad27216cc3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2878,11 +2878,18 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 
 	if (write)
 		sb_start_pagefault(sb);
-
+	/*
+	 * We need to serialize against not only truncate but also against
+	 * fuse dax memory range reclaim. While a range is being reclaimed,
+	 * we do not want any read/write/mmap to make progress and try
+	 * to populate page cache or access memory we are trying to free.
+	 */
+	down_read(&get_fuse_inode(inode)->i_mmap_sem);
 	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+	up_read(&get_fuse_inode(inode)->i_mmap_sem);
 
 	if (write)
 		sb_end_pagefault(sb);
@@ -3849,9 +3856,11 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 			file_update_time(file);
 	}
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache_range(inode, offset, offset + length - 1);
-
+		up_write(&fi->i_mmap_sem);
+	}
 	fuse_invalidate_attr(inode);
 
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 22fb01ba55fb..1ddf526330a5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -181,6 +181,13 @@ struct fuse_inode {
 	 */
 	struct rw_semaphore i_dmap_sem;
 
+	/**
+	 * Can't take inode lock in fault path (leads to circular dependency).
+	 * So take this in fuse dax fault path to make sure truncate and
+	 * punch hole etc. can't make progress in parallel.
+	 */
+	struct rw_semaphore i_mmap_sem;
+
 	/** Sorted rb tree of struct fuse_dax_mapping elements */
 	struct rb_root_cached dmap_tree;
 	unsigned long nr_dmaps;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 41edc377a3df..4bd965d0ecf6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -88,6 +88,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
-- 
2.25.4

