Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B53DF55D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhHCTTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239720AbhHCTTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628018336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5BC1mFHM8gqsESWA6R9wx6W+Jva1HWfryPTXX6lIUw=;
        b=IaIayPHT50yNXGgGkdBzRWvZvKkbKFmBeEVsFFoiofU8y+JzrVLgvOBDo8fzS4+nZmtk0/
        8MxspfGK820BVs7v8fWvfFxazAdVJ4Nj+km8+MfwWCkGHWOrbUkipz6dzjBmW7YovShI2Y
        wE724CxcrSNLplMwg57rUopYJyaExpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-GIPZ1TGXPMCWBUpDsykEQQ-1; Tue, 03 Aug 2021 15:18:52 -0400
X-MC-Unique: GIPZ1TGXPMCWBUpDsykEQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751B81084F56;
        Tue,  3 Aug 2021 19:18:51 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1B8E60C0F;
        Tue,  3 Aug 2021 19:18:48 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 07/12] gfs2: Fix mmap + page fault deadlocks for buffered I/O
Date:   Tue,  3 Aug 2021 21:18:13 +0200
Message-Id: <20210803191818.993968-8-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-1-agruenba@redhat.com>
References: <20210803191818.993968-1-agruenba@redhat.com>
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
 fs/gfs2/file.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 55ec1cadc9e6..c0f86a28f1bf 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -843,6 +843,12 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -864,13 +870,20 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
+	    iter_is_iovec(to) &&
+	    fault_in_iov_iter_writeable(to, SIZE_MAX) != 0)
+		goto retry;
 out_uninit:
 	gfs2_holder_uninit(&gh);
 	return written ? written : ret;
@@ -882,9 +895,22 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro
 	struct inode *inode = file_inode(file);
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and retry.
+	 */
+
+retry:
 	current->backing_dev_info = inode_to_bdi(inode);
+	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	pagefault_enable();
 	current->backing_dev_info = NULL;
+	if (unlikely(ret == -EFAULT) &&
+	    iter_is_iovec(from) &&
+	    fault_in_iov_iter_readable(from, SIZE_MAX) != 0)
+		goto retry;
 	return ret;
 }
 
-- 
2.26.3

