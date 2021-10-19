Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34265433775
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhJSNpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 09:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235804AbhJSNpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634651011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSb4dFhMHkVctcSRPuxGwemujZJKmyBkMqFwibclOJM=;
        b=D0DV82nsC1sjRgGWmTzDULZAELfrtl5QNnrzG338LyNxxBdqYSwGQg4TzqMfnPIBJ61cCu
        Lrx2gqhr63voZH2qiTwZV+w4PoC6q18UIILdxHVKLpajBxrIPFIhVOd2ZXqx5cSE9ClOY0
        pLhvsQewLRHKb0MAmOcNjW5ChCPCNIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-f18-vMRjPIujyaCVSRRwuQ-1; Tue, 19 Oct 2021 09:43:26 -0400
X-MC-Unique: f18-vMRjPIujyaCVSRRwuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D80380DDE0;
        Tue, 19 Oct 2021 13:43:24 +0000 (UTC)
Received: from max.com (unknown [10.40.193.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7748010016FC;
        Tue, 19 Oct 2021 13:43:04 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v8 11/17] gfs2: Fix mmap + page fault deadlocks for buffered I/O
Date:   Tue, 19 Oct 2021 15:41:58 +0200
Message-Id: <20211019134204.3382645-12-agruenba@redhat.com>
In-Reply-To: <20211019134204.3382645-1-agruenba@redhat.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the .read_iter and .write_iter file operations, we're accessing
user-space memory while holding the inode glock.  There is a possibility
that the memory is mapped to the same file, in which case we'd recurse
on the same glock.

We could detect and work around this simple case of recursive locking,
but more complex scenarios exist that involve multiple glocks,
processes, and cluster nodes, and working around all of those cases
isn't practical or even possible.

Avoid these kinds of problems by disabling page faults while holding the
inode glock.  If a page fault would occur, we either end up with a
partial read or write or with -EFAULT if nothing could be read or
written.  In either case, we know that we're not done with the
operation, so we indicate that we're willing to give up the inode glock
and then we fault in the missing pages.  If that made us lose the inode
glock, we return a partial read or write.  Otherwise, we resume the
operation.

This locking problem was originally reported by Jan Kara.  Linus came up
with the idea of disabling page faults.  Many thanks to Al Viro and
Matthew Wilcox for their feedback.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 8f37e4bab995..b07b9c2d0446 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -776,6 +776,36 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 	return ret ? ret : ret1;
 }
 
+static bool should_fault_in_pages(struct iov_iter *i, size_t *prev_count,
+				  size_t *window_size)
+{
+	char __user *p = i->iov[0].iov_base + i->iov_offset;
+	size_t count = iov_iter_count(i);
+	size_t size;
+
+	if (!iter_is_iovec(i))
+		return false;
+
+	if (*prev_count != count || !*window_size) {
+		int pages, nr_dirtied;
+
+		pages = min_t(int, BIO_MAX_VECS,
+			      DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE));
+		nr_dirtied = max(current->nr_dirtied_pause -
+				 current->nr_dirtied, 1);
+		pages = min(pages, nr_dirtied);
+		size = (size_t)PAGE_SIZE * pages - offset_in_page(p);
+	} else {
+		size = (size_t)PAGE_SIZE - offset_in_page(p);
+		if (*window_size <= size)
+			return false;
+	}
+
+	*prev_count = count;
+	*window_size = size;
+	return true;
+}
+
 static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 				     struct gfs2_holder *gh)
 {
@@ -840,9 +870,17 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct gfs2_inode *ip;
 	struct gfs2_holder gh;
+	size_t prev_count = 0, window_size = 0;
 	size_t written = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we indicate
+	 * that the inode glock may be dropped, fault in the pages manually,
+	 * and retry.
+	 */
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = gfs2_file_direct_read(iocb, to, &gh);
 		if (likely(ret != -ENOTBLK))
@@ -864,13 +902,35 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+retry:
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
 		goto out_uninit;
+retry_under_glock:
+	pagefault_disable();
 	ret = generic_file_read_iter(iocb, to);
+	pagefault_enable();
 	if (ret > 0)
 		written += ret;
-	gfs2_glock_dq(&gh);
+
+	if (unlikely(iov_iter_count(to) && (ret > 0 || ret == -EFAULT)) &&
+	    should_fault_in_pages(to, &prev_count, &window_size)) {
+		size_t leftover;
+
+		gfs2_holder_allow_demote(&gh);
+		leftover = fault_in_iov_iter_writeable(to, window_size);
+		gfs2_holder_disallow_demote(&gh);
+		if (leftover != window_size) {
+			if (!gfs2_holder_queued(&gh)) {
+				if (written)
+					goto out_uninit;
+				goto retry;
+			}
+			goto retry_under_glock;
+		}
+	}
+	if (gfs2_holder_queued(&gh))
+		gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return written ? written : ret;
@@ -885,8 +945,17 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *statfs_gh = NULL;
+	size_t prev_count = 0, window_size = 0;
+	size_t read = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we indicate
+	 * that the inode glock may be dropped, fault in the pages manually,
+	 * and retry.
+	 */
+
 	if (inode == sdp->sd_rindex) {
 		statfs_gh = kmalloc(sizeof(*statfs_gh), GFP_NOFS);
 		if (!statfs_gh)
@@ -894,10 +963,11 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
-
+retry_under_glock:
 	if (inode == sdp->sd_rindex) {
 		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 
@@ -908,21 +978,42 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	current->backing_dev_info = inode_to_bdi(inode);
+	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	pagefault_enable();
 	current->backing_dev_info = NULL;
-	if (ret > 0)
+	if (ret > 0) {
 		iocb->ki_pos += ret;
+		read += ret;
+	}
 
 	if (inode == sdp->sd_rindex)
 		gfs2_glock_dq_uninit(statfs_gh);
 
+	if (unlikely(iov_iter_count(from) && (ret > 0 || ret == -EFAULT)) &&
+	    should_fault_in_pages(from, &prev_count, &window_size)) {
+		size_t leftover;
+
+		gfs2_holder_allow_demote(gh);
+		leftover = fault_in_iov_iter_readable(from, window_size);
+		gfs2_holder_disallow_demote(gh);
+		if (leftover != window_size) {
+			if (!gfs2_holder_queued(gh)) {
+				if (read)
+					goto out_uninit;
+				goto retry;
+			}
+			goto retry_under_glock;
+		}
+	}
 out_unlock:
-	gfs2_glock_dq(gh);
+	if (gfs2_holder_queued(gh))
+		gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
 	if (statfs_gh)
 		kfree(statfs_gh);
-	return ret;
+	return read ? read : ret;
 }
 
 /**
-- 
2.26.3

