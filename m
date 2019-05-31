Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6466A312EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfEaQr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54371 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfEaQr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so3260969wme.4;
        Fri, 31 May 2019 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13bIynaRm34FrH0n8xWjSPCIT6ibxHwcE1TmN0qrOd4=;
        b=OYZGopPIgKXTAcfamW8N1HcbscQbjtfz+63cMCIKX2h2G1DIszXrLfICIWzh2juny1
         uZAAsTIeqRDO5cyI47QMQI2P9yQqGTC9pbF7wNygnPnzSUBafRcPAYBeDrfkdnef3ppT
         KX5jT4tlMO/ixe4uDyDaH2hIis9goBtQxlDisU7AAe1kF6usCkkEjGNhuYGysihe3itt
         0DHbSnhDCUoSMT4bbYwdAziikMq6aaxoVo1loa7UkrbZotp58JHuByOM99EpJOAC0tHH
         Q+Z5txKXP5XsrTNMNoLf/aENmh4kTGbpBr4AkCFILCANpb9EuUV3E6MLiGIA7g/V76Wc
         zLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13bIynaRm34FrH0n8xWjSPCIT6ibxHwcE1TmN0qrOd4=;
        b=tEmZUwULHR6h3XLGzNDRZEwB9KtX5pwVFsnSeAGCUthryrFa7Q7tyEggjekeNSOJin
         aQ2vu7BIvMaHcT4SSOjLV9KmmrrgIiKIimFQIZ+h471WTsGYbJrKkFiZF45YCFXx/3od
         FeLIx0V1nuNE+ka1rInfRxVMw+JdsP3gAB9JYvkOLoz4TVQ7r3XB+wc7j+avRzgw02M8
         Ov58FQFCWVax+YpbSSfztMb/x9ZyMNzCjnBWijHoQ/vRED/1ts9/4A2RcT2mw7LWpFxg
         yABUR7bGmVS9mLkbq/qgqWNGtpbI/PLcf1CQttO1jS2GObpOMNhk91og5xMqw2Jp8xMn
         6Hzg==
X-Gm-Message-State: APjAAAUbwBChWkqSEoNqmUQFHjg4yat5UPSqhV5bVwvTFHgYjNIpoAHa
        WBVjwTgJZQvXzPRTmhc9ZQC+QTjo
X-Google-Smtp-Source: APXvYqykJDJXjVuCo8nV8XzpwynyCeN0fTGZRZ7mBKHGTQX30Y8yEkPChspLKCKQlwAx8f3pDep5pA==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr1217916wmh.81.1559321244873;
        Fri, 31 May 2019 09:47:24 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:24 -0700 (PDT)
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
Subject: [PATCH v4 8/9] vfs: allow copy_file_range to copy across devices
Date:   Fri, 31 May 2019 19:47:00 +0300
Message-Id: <20190531164701.15112-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
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
index e87f7b2023af..4cd41ed5cc53 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 	if (src_inode == dst_inode)
 		return -EINVAL;
+	if (src_inode->i_sb != dst_inode->i_sb)
+		return -EXDEV;
 	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
 		return -EROFS;
 
@@ -2109,7 +2111,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
 
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(src_file, src_off, dst_file,
 					      dst_off, len, flags);
 	return ret;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c65823270313..f11eea6125c1 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1149,7 +1149,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 					len, flags);
 	free_xid(xid);
 
-	if (rc == -EOPNOTSUPP)
+	if (rc == -EOPNOTSUPP || rc == -EXDEV)
 		rc = generic_copy_file_range(src_file, off, dst_file,
 					     destoff, len, flags);
 	return rc;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e03901ae729b..569baf286835 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
+
 	inode_lock(inode_out);
 
 	if (fc->writeback_cache) {
@@ -3182,7 +3185,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
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
index cec7e7b1f693..eb3898fb3328 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1599,7 +1599,18 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
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
@@ -1622,10 +1633,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (flags != 0)
 		return -EINVAL;
 
-	/* this could be relaxed once a method supports cross-fs copies */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
-		return -EXDEV;
-
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
 				       flags);
 	if (unlikely(ret))
@@ -1648,7 +1655,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
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

