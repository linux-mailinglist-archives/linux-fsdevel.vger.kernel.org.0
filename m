Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD28A3CCB62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhGRWnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 18:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233807AbhGRWnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 18:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626648001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MwVjm5OXM9zYHFFAA3SH+qcDCGvezXdNuQatEJ1db8=;
        b=KVCkFYo4K9vl5fDKUCaLW1JwBr0B7e15d7Y4y0L71uQ6OyJl+wn34tPX4sbTZWph9X9g9f
        GWruPxpKEPdFGnAyo6euSVa/Oy131TGsfsu6LICJ6N7G0L6EYZU8jyuybRJivlE6jvwuX+
        hJCl+NbCpPgtzdDH654OKykMp7bPjbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-CDAXjn_TN3mDy0sqgYn1Vg-1; Sun, 18 Jul 2021 18:39:57 -0400
X-MC-Unique: CDAXjn_TN3mDy0sqgYn1Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1E08802C80;
        Sun, 18 Jul 2021 22:39:55 +0000 (UTC)
Received: from max.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6C3A60C0F;
        Sun, 18 Jul 2021 22:39:51 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 4/6] gfs2: Fix mmap + page fault deadlocks for buffered I/O
Date:   Mon, 19 Jul 2021 00:39:30 +0200
Message-Id: <20210718223932.2703330-5-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
References: <20210718223932.2703330-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the .read_iter and .write_iter file operations, we're accessing
user-space memory while holding the inodes glock.  There's a possibility
that the memory is mapped to the same file, in which case we'd recurse on
the same glock.

More complex scenarios can involve multiple glocks, processes, and even cluster
nodes.

Avoids these kinds of problems by disabling page faults while holding a glock.
If a page fault occurs, we either end up with a partial read or write, or with
-EFAULT if nothing could be read or written.  In that case, we drop the glock,
fault in the requested pages manually, and repeat the operation.

This locking problem in gfs2 was originally reported by Jan Kara.  Linus came
up with the proposal to disable page faults.  Many thanks to Al Viro and
Matthew Wilcox for their feedback as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 13f701493c3c..99df7934b4d8 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -824,6 +824,12 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	size_t written = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when whe're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and then we retry.
+	 */
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = gfs2_file_direct_read(iocb, to, &gh);
 		if (likely(ret != -ENOTBLK))
@@ -831,6 +837,7 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		iocb->ki_flags &= ~IOCB_DIRECT;
 	}
 	iocb->ki_flags |= IOCB_NOIO;
+	/* Leave page faults enabled while we're not holding any locks. */
 	ret = generic_file_read_iter(iocb, to);
 	iocb->ki_flags &= ~IOCB_NOIO;
 	if (ret >= 0) {
@@ -845,13 +852,19 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+retry:
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
 		goto out_uninit;
+	pagefault_disable();
 	ret = generic_file_read_iter(iocb, to);
+	pagefault_enable();
 	if (ret > 0)
 		written += ret;
 	gfs2_glock_dq(&gh);
+	if (unlikely(iov_iter_count(to) && (ret > 0 || ret == -EFAULT)) &&
+	    fault_in_iov_iter(to))
+		goto retry;
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return written ? written : ret;
@@ -863,9 +876,20 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro
 	struct inode *inode = file_inode(file);
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when whe're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and then we retry.
+	 */
+
+retry:
 	current->backing_dev_info = inode_to_bdi(inode);
+	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	pagefault_enable();
 	current->backing_dev_info = NULL;
+	if (unlikely(ret == -EFAULT) && fault_in_iov_iter(from))
+		goto retry;
 	return ret;
 }
 
-- 
2.26.3

