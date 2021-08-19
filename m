Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86943F20DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhHSTmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235332AbhHSTmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XWuyMTj+hy427MD7LC7x2B24g+i8ekxZt//CLsVy4g=;
        b=YpVbbmEUdKeHHHDPLegYTHzmAxpUXwtG/iX15VctuQ/q/FxIgSPsNdTe5CDoMbe4cB7hKY
        ZLXhGKAvtxMb/STd3Pn3e3n77YLk/wnph6hn3BdhXgfztx79S8Xb0HILqqXU3jW9euP/h2
        FUcy4+a5BCrzgvO8Esy24ovI1B4e5M0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-BlzBVgWhNvaG1TWQzD2q2Q-1; Thu, 19 Aug 2021 15:41:57 -0400
X-MC-Unique: BlzBVgWhNvaG1TWQzD2q2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B36AA87D542;
        Thu, 19 Aug 2021 19:41:55 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36EFB60938;
        Thu, 19 Aug 2021 19:41:53 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 12/19] gfs2: Fix mmap + page fault deadlocks for buffered I/O
Date:   Thu, 19 Aug 2021 21:40:55 +0200
Message-Id: <20210819194102.1491495-13-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the .read_iter and .write_iter file operations, we're accessing
user-space memory while holding the inodes glock.  There's a possibility
that the memory is mapped to the same file, in which case we'd recurse
on the same glock.

More complex scenarios can involve multiple glocks, processes, and even
cluster nodes.

Avoids these kinds of problems by disabling page faults while holding a
glock.  If a page fault occurs, we either end up with a partial read or
write, or with -EFAULT if nothing could be read or written.  In that
case, we indicate that we're willing to give up the glock, fault in the
requested pages manually, and repeat the operation.

This kind of locking problem in gfs2 was originally reported by Jan
Kara.  Linus came up with the proposal to disable page faults.  Many
thanks to Al Viro and Matthew Wilcox for their feedback.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 813154d60834..c4262d6ba5e4 100644
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
@@ -840,9 +870,16 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct gfs2_inode *ip;
 	struct gfs2_holder gh;
+	size_t prev_count = 0, window_size = 0;
 	size_t written = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and retry.
+	 */
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = gfs2_file_direct_read(iocb, to, &gh);
 		if (likely(ret != -ENOTBLK))
@@ -864,13 +901,35 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -882,13 +941,22 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro
 	struct inode *inode = file_inode(file);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
+	size_t prev_count = 0, window_size = 0;
+	size_t read = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and retry.
+	 */
+
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &ip->i_gh);
+retry:
 	ret = gfs2_glock_nq(&ip->i_gh);
 	if (ret)
 		goto out_uninit;
-
+retry_under_glock:
 	if (inode == sdp->sd_rindex) {
 		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 
@@ -899,20 +967,40 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro
 	}
 
 	current->backing_dev_info = inode_to_bdi(inode);
+	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	pagefault_enable();
 	current->backing_dev_info = NULL;
+	if (ret > 0)
+		read += ret;
 
 	if (inode == sdp->sd_rindex) {
 		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 
 		gfs2_glock_dq_uninit(&m_ip->i_gh);
 	}
-
+	if (unlikely(iov_iter_count(from) && (ret > 0 || ret == -EFAULT)) &&
+	    should_fault_in_pages(from, &prev_count, &window_size)) {
+		size_t leftover;
+
+		gfs2_holder_allow_demote(&ip->i_gh);
+		leftover = fault_in_iov_iter_readable(from, window_size);
+		gfs2_holder_disallow_demote(&ip->i_gh);
+		if (leftover != window_size) {
+			if (!gfs2_holder_queued(&ip->i_gh)) {
+				if (read)
+					goto out_uninit;
+				goto retry;
+			}
+			goto retry_under_glock;
+		}
+	}
 out_unlock:
-	gfs2_glock_dq(&ip->i_gh);
+	if (gfs2_holder_queued(&ip->i_gh))
+		gfs2_glock_dq(&ip->i_gh);
 out_uninit:
 	gfs2_holder_uninit(&ip->i_gh);
-	return ret;
+	return read ? read : ret;
 }
 
 /**
-- 
2.26.3

