Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6737A858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 16:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhEKOC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 10:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhEKOC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620741681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/J2SbDDpf1/xl12w6sV/ZvOSp9oddaI9kZRn1S4ksFA=;
        b=MBWemO5ULQJSPpJ/5Q9pjQpNyZ4yELbNsT5g5pWa8aS0IidVJbXFTuqT8WgevS7XlcOCx+
        zQtQDobslKAR1x5ZHFCsBUow1bo7t5o5nXt7Uq8orjPsY8k+tKLBZtmT6O7qtF+q5UAZJi
        bWCVqpQdwPaSh02iVQDtYsELfw3gbF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-UbNFmkdyNFOv3l7m6nD3FA-1; Tue, 11 May 2021 10:01:19 -0400
X-MC-Unique: UbNFmkdyNFOv3l7m6nD3FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 067BA18E5641;
        Tue, 11 May 2021 14:01:17 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8040E5D6D1;
        Tue, 11 May 2021 14:01:15 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] [RFC] Trigger retry from fault vm operation
Date:   Tue, 11 May 2021 16:01:13 +0200
Message-Id: <20210511140113.1225981-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

we have a locking problem in gfs2 that I don't have a proper solution for, so
I'm looking for suggestions.

What's happening is that a page fault triggers during a read or write
operation, while we're holding a glock (the cluster-wide gfs2 inode
lock), and the page fault requires another glock.  We can recognize and
handle the case when both glocks are the same, but when the page fault requires
another glock, there is a chance that taking that other glock would deadlock.

When we realize that we may not be able to take the other glock in gfs2_fault,
we need to communicate that to the read or write operation, which will then
drop and re-acquire the "outer" glock and retry.  However, there doesn't seem
to be a good way to do that; we can only indicate that a page fault should fail
by returning VM_FAULT_SIGBUS or similar; that will then be mapped to -EFAULT.
We'd need something like VM_FAULT_RESTART that can be mapped to -EBUSY so that
we can tell the retry case apart from genuine -EFAULT errors.

To show what I mean, below is a proof of concept that adds a restart_hack flag
to struct task_struct as a side channel.  An even uglier alternative would be
to abuse task->journal_info.

The obvious response to this email would be "fix your locking order".  Well, we
can do that by pinning the user pages in gfs2_file_{read,write}_iter before
taking the "outer" glock, but we'd ideally only do that when it's actually
necessary (i.e., when gfs2_fault has indicated to retry).

Thanks for any thoughts.

Andreas
---
 fs/gfs2/file.c        | 37 +++++++++++++++++++++++++++++++++++--
 include/linux/sched.h |  1 +
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 658fed79d65a..253e720f2df0 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -543,10 +543,15 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int err;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_TRY, &gh);
 	if (likely(!recursive)) {
 		err = gfs2_glock_nq(&gh);
 		if (err) {
+			if (err == GLR_TRYFAILED) {
+				current->restart_hack = 1;
+				ret = VM_FAULT_SIGBUS;
+				goto out_uninit;
+			}
 			ret = block_page_mkwrite_return(err);
 			goto out_uninit;
 		}
@@ -773,12 +778,16 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 		return 0; /* skip atime */
 
 	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+restart:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
 
+	current->restart_hack = 0;
 	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0);
 	gfs2_glock_dq(gh);
+	if (unlikely(ret == -EFAULT) && current->restart_hack)
+		goto restart;
 out_uninit:
 	gfs2_holder_uninit(gh);
 	return ret;
@@ -803,6 +812,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	 * VFS does.
 	 */
 	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+
+restart:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
@@ -811,11 +822,14 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
+	current->restart_hack = 0;
 	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
 out:
 	gfs2_glock_dq(gh);
+	if (unlikely(ret == -EFAULT) && current->restart_hack)
+		goto restart;
 out_uninit:
 	gfs2_holder_uninit(gh);
 	return ret;
@@ -834,7 +848,9 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 		iocb->ki_flags &= ~IOCB_DIRECT;
 	}
+restart1:
 	iocb->ki_flags |= IOCB_NOIO;
+	current->restart_hack = 0;
 	ret = generic_file_read_iter(iocb, to);
 	iocb->ki_flags &= ~IOCB_NOIO;
 	if (ret >= 0) {
@@ -842,6 +858,8 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 		written = ret;
 	} else {
+		if (unlikely(ret == -EFAULT) && current->restart_hack)
+			goto restart1;
 		if (ret != -EAGAIN)
 			return ret;
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -849,13 +867,18 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+
+restart2:
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
 		goto out_uninit;
+	current->restart_hack = 0;
 	ret = generic_file_read_iter(iocb, to);
 	if (ret > 0)
 		written += ret;
 	gfs2_glock_dq(&gh);
+	if (unlikely(ret == -EFAULT) && current->restart_hack)
+		goto restart2;
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return written ? written : ret;
@@ -912,13 +935,18 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out_unlock;
 
 		iocb->ki_flags |= IOCB_DSYNC;
+restart1:
+		current->restart_hack = 0;
 		current->backing_dev_info = inode_to_bdi(inode);
 		buffered = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 		current->backing_dev_info = NULL;
 		if (unlikely(buffered <= 0)) {
+			if (unlikely(buffered == -EFAULT) && current->restart_hack)
+				goto restart1;
 			if (!ret)
 				ret = buffered;
 			goto out_unlock;
+		}
 
 		/*
 		 * We need to ensure that the page cache pages are written to
@@ -935,10 +963,15 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (!ret || ret2 > 0)
 			ret += ret2;
 	} else {
+restart2:
+		current->restart_hack = 0;
 		current->backing_dev_info = inode_to_bdi(inode);
 		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 		current->backing_dev_info = NULL;
-		if (likely(ret > 0)) {
+		if (unlikely(ret <= 0)) {
+			if (unlikely(ret == -EFAULT) && current->restart_hack)
+				goto restart2;
+		} else {
 			iocb->ki_pos += ret;
 			ret = generic_write_sync(iocb, ret);
 		}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c881384517..de053ac8d8d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1067,6 +1067,7 @@ struct task_struct {
 
 	/* Journalling filesystem info: */
 	void				*journal_info;
+	unsigned			restart_hack:1;
 
 	/* Stacked block device info: */
 	struct bio_list			*bio_list;
-- 
2.26.3

