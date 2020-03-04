Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9117962A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgCDRB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:01:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48486 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729780AbgCDQ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIopJzsj++aiDVq7oYzrBdYDChpfyNBom1aJNIGl0sw=;
        b=iXSXcMaiAVxbx/fffK6Mkr97bGlQEpTA2LuRF6qnQJ5jLorNHazGU4Gl1S0rgFKiUoRY58
        BQmF377f2ngr7lOUXnDLIpJyB9Nh1FZxEH6ZXALBnA6h9v4gTidn0EqZK7tWxBmt6Crt0t
        RF8vfD+NykYXCQNl9rvHNVYO7Mjp0pU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-wFV-Go8GO2GAbrAt-RA3HQ-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: wFV-Go8GO2GAbrAt-RA3HQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C12107ACC9;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 293AA60FC2;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7CA0A225815; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 15/20] fuse, dax: Take ->i_mmap_sem lock during dax page fault
Date:   Wed,  4 Mar 2020 11:58:40 -0500
Message-Id: <20200304165845.3081-16-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
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
index de1e2fde60bd..ad699a60ec03 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1609,8 +1609,10 @@ int fuse_do_setattr(struct dentry *dentry, struct =
iattr *attr,
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize !=3D outarg.attr.size) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache(inode, outarg.attr.size);
 		invalidate_inode_pages2(inode->i_mapping);
+		up_write(&fi->i_mmap_sem);
 	}
=20
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 303496e6617f..ab56396cf661 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2907,11 +2907,18 @@ static vm_fault_t __fuse_dax_fault(struct vm_faul=
t *vmf,
=20
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
 	ret =3D dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
=20
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret =3D dax_finish_sync_fault(vmf, pe_size, pfn);
+	up_read(&get_fuse_inode(inode)->i_mmap_sem);
=20
 	if (write)
 		sb_end_pagefault(sb);
@@ -3869,9 +3876,11 @@ static long fuse_file_fallocate(struct file *file,=
 int mode, loff_t offset,
 			file_update_time(file);
 	}
=20
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache_range(inode, offset, offset + length - 1);
-
+		up_write(&fi->i_mmap_sem);
+	}
 	fuse_invalidate_attr(inode);
=20
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 490549862bda..3fea84411401 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -186,6 +186,13 @@ struct fuse_inode {
 	 */
 	struct rw_semaphore i_dmap_sem;
=20
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
index 93bc65607a15..abc881e6acb0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -88,6 +88,7 @@ static struct inode *fuse_alloc_inode(struct super_bloc=
k *sb)
 	fi->state =3D 0;
 	fi->nr_dmaps =3D 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget =3D fuse_alloc_forget();
--=20
2.20.1

