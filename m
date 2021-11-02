Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF0442E33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKBMfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 08:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBMfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635856386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=faLoLpLyKy/Ab8XQ27t5jmK0JEkq3soAYUpBSCy17oY=;
        b=IK+AjIu611fdTN+F3jj2S9My+NFiyQvlN3s0ALv3BEmR79E/LiK0/USNJeOCg+ysAu2NpF
        IWIi6++YA9YFZzUN4r02jvOk9O9AyEp3BOYIL9V421un3yZ5HslyOWdeO0atS8rBVTa9b3
        qNbqdGLYX6/de3BUgcRkD5zk/tuGBoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Ww8bC-2wMe2RsfP5VGf83w-1; Tue, 02 Nov 2021 08:33:03 -0400
X-MC-Unique: Ww8bC-2wMe2RsfP5VGf83w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4574B802682;
        Tue,  2 Nov 2021 12:33:01 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06EF769119;
        Tue,  2 Nov 2021 12:32:08 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v9 17/17] gfs2: Fix mmap + page fault deadlocks for direct I/O
Date:   Tue,  2 Nov 2021 13:29:45 +0100
Message-Id: <20211102122945.117744-18-agruenba@redhat.com>
In-Reply-To: <20211102122945.117744-1-agruenba@redhat.com>
References: <20211102122945.117744-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also disable page faults during direct I/O requests and implement a
similar kind of retry logic as in the buffered I/O case.

The retry logic in the direct I/O case differs from the buffered I/O
case in the following way: direct I/O doesn't provide the kinds of
consistency guarantees between concurrent reads and writes that buffered
I/O provides, so once we lose the inode glock while faulting in user
pages, we always resume the operation.  We never need to return a
partial read or write.

This locking problem was originally reported by Jan Kara.  Linus came up
with the idea of disabling page faults.  Many thanks to Al Viro and
Matthew Wilcox for their feedback.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 99 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index f772ee0fcae3..40e6501c02e5 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -811,22 +811,64 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 {
 	struct file *file = iocb->ki_filp;
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
-	size_t count = iov_iter_count(to);
+	size_t prev_count = 0, window_size = 0;
+	size_t written = 0;
 	ssize_t ret;
 
-	if (!count)
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we indicate
+	 * that the inode glock may be dropped, fault in the pages manually,
+	 * and retry.
+	 *
+	 * Unlike generic_file_read_iter, for reads, iomap_dio_rw can trigger
+	 * physical as well as manual page faults, and we need to disable both
+	 * kinds.
+	 *
+	 * For direct I/O, gfs2 takes the inode glock in deferred mode.  This
+	 * locking mode is compatible with other deferred holders, so multiple
+	 * processes and nodes can do direct I/O to a file at the same time.
+	 * There's no guarantee that reads or writes will be atomic.  Any
+	 * coordination among readers and writers needs to happen externally.
+	 */
+
+	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
 	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
+retry_under_glock:
+	pagefault_disable();
+	to->nofault = true;
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
+			   IOMAP_DIO_PARTIAL, written);
+	to->nofault = false;
+	pagefault_enable();
+	if (ret > 0)
+		written = ret;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0, 0);
-	gfs2_glock_dq(gh);
+	if (should_fault_in_pages(ret, to, &prev_count, &window_size)) {
+		size_t leftover;
+
+		gfs2_holder_allow_demote(gh);
+		leftover = fault_in_iov_iter_writeable(to, window_size);
+		gfs2_holder_disallow_demote(gh);
+		if (leftover != window_size) {
+			if (!gfs2_holder_queued(gh))
+				goto retry;
+			goto retry_under_glock;
+		}
+	}
+	if (gfs2_holder_queued(gh))
+		gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
-	return ret;
+	if (ret < 0)
+		return ret;
+	return written;
 }
 
 static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
@@ -835,10 +877,20 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
-	size_t len = iov_iter_count(from);
-	loff_t offset = iocb->ki_pos;
+	size_t prev_count = 0, window_size = 0;
+	size_t read = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we indicate
+	 * that the inode glock may be dropped, fault in the pages manually,
+	 * and retry.
+	 *
+	 * For writes, iomap_dio_rw only triggers manual page faults, so we
+	 * don't need to disable physical ones.
+	 */
+
 	/*
 	 * Deferred lock, even if its a write, since we do no allocation on
 	 * this path. All we need to change is the atime, and this lock mode
@@ -848,22 +900,45 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	 * VFS does.
 	 */
 	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
-
+retry_under_glock:
 	/* Silently fall back to buffered I/O when writing beyond EOF */
-	if (offset + len > i_size_read(&ip->i_inode))
+	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0, 0);
+	from->nofault = true;
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
+			   IOMAP_DIO_PARTIAL, read);
+	from->nofault = false;
+
 	if (ret == -ENOTBLK)
 		ret = 0;
+	if (ret > 0)
+		read = ret;
+
+	if (should_fault_in_pages(ret, from, &prev_count, &window_size)) {
+		size_t leftover;
+
+		gfs2_holder_allow_demote(gh);
+		leftover = fault_in_iov_iter_readable(from, window_size);
+		gfs2_holder_disallow_demote(gh);
+		if (leftover != window_size) {
+			if (!gfs2_holder_queued(gh))
+				goto retry;
+			goto retry_under_glock;
+		}
+	}
 out:
-	gfs2_glock_dq(gh);
+	if (gfs2_holder_queued(gh))
+		gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
-	return ret;
+	if (ret < 0)
+		return ret;
+	return read;
 }
 
 static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
-- 
2.31.1

