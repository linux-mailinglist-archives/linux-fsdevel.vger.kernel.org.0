Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD83F9CFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhH0QwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237357AbhH0Qv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630083067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4BmK4tXzTj52XbNl4SCvgGSrpy3bRofDkDM8Yrd/Go=;
        b=PoRrYsrNkWG/pEOSfAEqLBgo/SD7HsZKcwEDS2dq4KQU45Fys4IyiIqAmm2IU+lgT77ury
        7uC/uoGcBhP3Wf4C4tgNDbvvV8imZn+BrENnWmLvPKW9qkfkHOtQlp/f43vUKf8pv4J5bu
        kpVifgXTGAKaLN/goRXK5H8+UJs5it0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-Wac9k7IxMieEATBgyQ6G9g-1; Fri, 27 Aug 2021 12:51:03 -0400
X-MC-Unique: Wac9k7IxMieEATBgyQ6G9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E3E1009E32;
        Fri, 27 Aug 2021 16:51:01 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 792AA60C04;
        Fri, 27 Aug 2021 16:50:59 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 13/19] gfs2: Fix mmap + page fault deadlocks for buffered I/O
Date:   Fri, 27 Aug 2021 18:49:20 +0200
Message-Id: <20210827164926.1726765-14-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the .read_iter and .write_iter file operations, we're accessing
user-space memory while holding the inode glock.  There is a possibility
that the memory is mapped to the same file, in which case we'd recurse
on the same glock.

More complex scenarios can involve multiple glocks, processes, and even
cluster nodes.

Avoid these kinds of problems by disabling page faults while holding the
inode glock.  If a page fault would occur, we either end up with a
partial read or write, or with -EFAULT if nothing could be read or
written.  In either case, we know that we're not done with the
operation, so we indicate that we're willing to give up the inode glock
(HIF_MAY_DEMOTE) and then we fault in the missing pages.  If that made
us lose the inode glock, we return a partial read or write.  Otherwise,
we resume the operation.

This locking problem was originally reported by Jan Kara.  Linus came up
with the proposal to disable page faults.  Many thanks to Al Viro and
Matthew Wilcox for their feedback.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 5f328bc21d0b..fce3a5249e19 100644
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
@@ -885,6 +944,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *statfs_gh = NULL;
+	size_t prev_count = 0, window_size = 0;
+	size_t read = 0;
 	ssize_t ret;
 
 	/*
@@ -900,10 +961,11 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
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
 
@@ -914,19 +976,40 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	current->backing_dev_info = inode_to_bdi(inode);
+	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	pagefault_enable();
 	current->backing_dev_info = NULL;
+	if (ret > 0)
+		read += ret;
 
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

