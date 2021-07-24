Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389A83D4992
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhGXSyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhGXSys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627155319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZOzxCOz9JX3kUYn4GT8aXcrfrZdUDpcYXmKfhFAysc=;
        b=RY6YGxine6TNGumAH0em2Q0UNBiy46PrsVeoFXQxZuem5lYIh7kqCByZzO7/SrIh6sQ/S3
        VhhxOPS1zgQWsJqTWQrzhbvqfDDRc4XbjtY4ZBgb9e8xEnEiP1IZoPyaYVdzp8Cm1eyzgX
        n/f/1TUnSUdbs0lElsFIuHOHHekFutw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-I0V6eKaKOeq00ptbKx4DCg-1; Sat, 24 Jul 2021 15:35:18 -0400
X-MC-Unique: I0V6eKaKOeq00ptbKx4DCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2580D1800D41;
        Sat, 24 Jul 2021 19:35:17 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2695544F1;
        Sat, 24 Jul 2021 19:35:10 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 5/8] iomap: Add done_before argument to iomap_dio_rw
Date:   Sat, 24 Jul 2021 21:34:46 +0200
Message-Id: <20210724193449.361667-6-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-1-agruenba@redhat.com>
References: <20210724193449.361667-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a done_before argument to iomap_dio_rw that indicates how much of the
request has already been transferred.  When the request succeeds, we report
that done_before additional bytes were tranferred.  This is useful for
finishing a request asynchronously when part of the request has already been
completed synchronously.

We'll use that to allow iomap_dio_rw to be used with page faults disabled: when
a page fault occurs while submitting a request, we synchronously complete the
part of the request that has already been submitted.  The caller can then take
care of the page fault and call iomap_dio_rw again for the rest of the request,
passing in the number of bytes already tranferred.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/btrfs/file.c       |  5 +++--
 fs/ext4/file.c        |  5 +++--
 fs/gfs2/file.c        |  4 ++--
 fs/iomap/direct-io.c  | 12 ++++++++----
 fs/xfs/xfs_file.c     |  6 +++---
 fs/zonefs/super.c     |  4 ++--
 include/linux/iomap.h |  4 ++--
 7 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ee34497500e1..ea13d88e8c14 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1945,7 +1945,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			     0);
+			     0, 0);
 
 	btrfs_inode_unlock(inode, ilock_flags);
 
@@ -3637,7 +3637,8 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops, 0);
+	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			   0, 0);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	return ret;
 }
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 816dedcbd541..4a5e7fd31fb5 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -74,7 +74,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, 0);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -566,7 +566,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ilock_shared)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0);
+			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
+			   0);
 	if (ret == -ENOTBLK)
 		ret = 0;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 3aa66d4de383..eea42cc94585 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -792,7 +792,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0, 0);
 	gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
@@ -826,7 +826,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
 out:
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index cc0b4bc8861b..51831ce93f6e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -31,6 +31,7 @@ struct iomap_dio {
 	atomic_t		ref;
 	unsigned		flags;
 	int			error;
+	size_t			done_before;
 	bool			wait_for_completion;
 
 	union {
@@ -128,7 +129,9 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 
 	kfree(dio);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+	return dio->done_before + ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
 
@@ -450,7 +453,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 struct iomap_dio *
 __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags)
+		unsigned int dio_flags, size_t done_before)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -477,6 +480,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->dops = dops;
 	dio->error = 0;
 	dio->flags = 0;
+	dio->done_before = done_before;
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
@@ -642,11 +646,11 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags)
+		unsigned int dio_flags, size_t done_before)
 {
 	struct iomap_dio *dio;
 
-	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags);
+	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, done_before);
 	if (IS_ERR_OR_NULL(dio))
 		return PTR_ERR_OR_ZERO(dio);
 	return iomap_dio_complete(dio);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cc3cfb12df53..3103d9bda466 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -259,7 +259,7 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -569,7 +569,7 @@ xfs_file_dio_write_aligned(
 	}
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, 0);
+			   &xfs_dio_write_ops, 0, 0);
 out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
@@ -647,7 +647,7 @@ xfs_file_dio_write_unaligned(
 
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, flags);
+			   &xfs_dio_write_ops, flags, 0);
 
 	/*
 	 * Retry unaligned I/O with exclusive blocking semantics if the DIO
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 70055d486bf7..85ca2f5fe06e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -864,7 +864,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		ret = zonefs_file_dio_append(iocb, from);
 	else
 		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-				   &zonefs_write_dio_ops, 0);
+				   &zonefs_write_dio_ops, 0, 0);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
@@ -999,7 +999,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		file_accessed(iocb->ki_filp);
 		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
-				   &zonefs_read_dio_ops, 0);
+				   &zonefs_read_dio_ops, 0, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 		if (ret == -EIO)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..8aea35f1a003 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -269,10 +269,10 @@ struct iomap_dio_ops {
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags);
+		unsigned int dio_flags, size_t done_before);
 struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags);
+		unsigned int dio_flags, size_t done_before);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
-- 
2.26.3

