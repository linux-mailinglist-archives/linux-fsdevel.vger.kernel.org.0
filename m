Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAE2E3A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfE2Rn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfE2Rnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so2379663wrb.9;
        Wed, 29 May 2019 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T2Smjb+P/jamD/M2jOo9Duoj3MRoGI3Hr+9fU0qlJ6w=;
        b=FU1FhQe1TIQdXbxXVf5dUrBoSLGXOIJMF39wk8OT0iVzWXt6cRkIxk5E/6Mm1SBygS
         0Ny+shwFxfXEXz/ET5VAXJp02SE5E09b8AsbMMvPcz2sKlHr0qP+jB7VQ/NI++XxbdAx
         5eGO1zStdB4JYZj20CKwnNzYU118nPj5y1MtHy6jhCwjSl5YX4kPUrLmhhxdwDRfkFI9
         uzoqhOZ91LZ83r+YNijpFAkr2yB0fK4JEqgWl2ahEHASmD9CBoHoYVhZoHzYAM0Uuhj9
         dtWyi+CtS1M65llXJNXqALbsOtznGOyDG3VbWllmR2yNIyccZZpJ+/zJFzLXmgCPenoJ
         EeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T2Smjb+P/jamD/M2jOo9Duoj3MRoGI3Hr+9fU0qlJ6w=;
        b=AJ/w/B19J7cDlZpmEgO7ce9aKf2W2ClxgBpln/oqtzrDygIKeMQ07NPMJbfGzviu6P
         Wrksea5oThEp6eehtckpmgF7K65EklHQqRanloWa5hMJ5tdwJJGUrk04rGoZbHgf2iq0
         UfZaySOZsKhLN9I+/MZifn+OzS14glzhmEDsY8EF5YjoKBiCYKIBzgvnZ1H1M1vfWp37
         sWMOJOyjRCUx5cg9DmAxmmyO3OAadP4hacb7TS4b7Qq+cm6ayfw884QZ0so7s562qBbk
         vA+zxHJfMPMPx2rOYFibIjkTeO87p+ww/LYU7zykz6nhpQvsBRzb9sa6z7tiDR3ZpYiG
         bIGA==
X-Gm-Message-State: APjAAAUrq4J4VCOclPiGQbDedQ+EoFgRZdADdnXBPrROCAHJa9NHx1QN
        S8yhVtzF2HqCekA0JPFLcmw=
X-Google-Smtp-Source: APXvYqy5Ykid2UHE9Xy5TwnsBq4/hT/qPUHgFp/uKL/KopsjCES3wSKuYyQJelul4J8R3Ch0F2ys6g==
X-Received: by 2002:adf:e945:: with SMTP id m5mr9492027wrn.90.1559151832848;
        Wed, 29 May 2019 10:43:52 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:52 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v3 13/13] vfs: allow copy_file_range to copy across devices
Date:   Wed, 29 May 2019 20:43:17 +0300
Message-Id: <20190529174318.22424-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to enable cross-filesystem copy_file_range functionality
where possible, so push the "same superblock only" checks down to
the individual filesystem callouts so they can make their own
decisions about cross-superblock copy offload and fallack to
generic_copy_file_range() for cross-superblock copy.

[Amir] We do not call ->remap_file_range() in case the inodes are not
on the same sb and do not call ->copy_file_range() in case the inodes
are not on the same filesystem type.

This changes behavior of the copy_file_range(2) syscall, which will
now allow cross filesystem in-kernel copy.  CIFS already supports
cross-superblock copy, between two shares to the same server. This
functionality will now be available via the copy_file_range(2) syscall.

Cc: Steve French <stfrench@microsoft.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ceph/file.c    |  4 +++-
 fs/cifs/cifsfs.c  |  2 +-
 fs/fuse/file.c    |  5 ++++-
 fs/nfs/nfs4file.c |  5 ++++-
 fs/read_write.c   | 20 ++++++++++++++------
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8a70708e1aca..e9614d686301 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 	if (src_inode == dst_inode)
 		return -EINVAL;
+	if (src_inode->i_sb != dst_inode->i_sb)
+		return -EXDEV;
 	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
 		return -EROFS;
 
@@ -2126,7 +2128,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
 
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(src_file, src_off, dst_file,
 					      dst_off, len, flags);
 	return ret;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ab6c5c24146d..83956452c108 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1154,7 +1154,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 					len, flags);
 	free_xid(xid);
 
-	if (rc == -EOPNOTSUPP)
+	if (rc == -EOPNOTSUPP || rc == -EXDEV)
 		rc = generic_copy_file_range(src_file, off, dst_file,
 					     destoff, len, flags);
 	return rc;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7f33d68f66d9..eab00cd089e8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
+
 	inode_lock(inode_out);
 
 	err = file_modified(file_out);
@@ -3187,7 +3190,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
 
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(src_file, src_off, dst_file,
 					      dst_off, len, flags);
 	return ret;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 4842f3ab3161..f4157eb1f69d 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				      struct file *file_out, loff_t pos_out,
 				      size_t count, unsigned int flags)
 {
+	/* Only offload copy if superblock is the same */
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
@@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
 				     flags);
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(file_in, pos_in, file_out,
 					      pos_out, count, flags);
 	return ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index 706ea5f276a7..d8930bb735cb 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1618,7 +1618,18 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  size_t len, unsigned int flags)
 {
-	if (file_out->f_op->copy_file_range)
+	/*
+	 * Although we now allow filesystems to handle cross sb copy, passing
+	 * an inode of the wrong filesystem type to filesystem operation can
+	 * often result in an attempt to dereference the wrong concrete inode
+	 * struct, so avoid doing that until we really have a good reason.
+	 * The incentive for passing inode from different sb to filesystem is
+	 * NFS cross server copy and for that use case, enforcing same
+	 * filesystem type is acceptable.
+	 */
+	if (file_out->f_op->copy_file_range &&
+	    file_inode(file_in)->i_sb->s_type ==
+	    file_inode(file_out)->i_sb->s_type)
 		return file_out->f_op->copy_file_range(file_in, pos_in,
 						       file_out, pos_out,
 						       len, flags);
@@ -1641,10 +1652,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (flags != 0)
 		return -EINVAL;
 
-	/* this could be relaxed once a method supports cross-fs copies */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
-		return -EXDEV;
-
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
 				       flags);
 	if (unlikely(ret))
@@ -1667,7 +1674,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * Try cloning first, this is supported by more file systems, and
 	 * more efficient if both clone and copy are supported (e.g. NFS).
 	 */
-	if (file_in->f_op->remap_file_range) {
+	if (file_in->f_op->remap_file_range &&
+	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
 		loff_t cloned;
 
 		cloned = file_in->f_op->remap_file_range(file_in, pos_in,
-- 
2.17.1

