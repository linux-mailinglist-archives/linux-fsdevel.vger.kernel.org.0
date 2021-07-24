Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1033A3D498D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhGXSyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229756AbhGXSyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627155309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahB/v6U/xP9AlZ0hKlPiYyAr767PhYNFGz5xudMNDn4=;
        b=izq0CGPImg52ip01c5uGQ20wY8Tiekkezc8rBA7BzKeCiCFoPy3/ohY+Kd+Neo7lq5RLxx
        DlCL0zf6NVbDCdWjyXOVMU/G8pt/mmM8hFFmwh/1V8JMl5YV1nl7enUNC5gTGmLmIwDlkG
        W6xxDIaoj06W0vQy8k2JGsjk5npHyZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-amHYFzY8Oty12B9PRSFCGA-1; Sat, 24 Jul 2021 15:35:07 -0400
X-MC-Unique: amHYFzY8Oty12B9PRSFCGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 859048042E7;
        Sat, 24 Jul 2021 19:35:06 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11308669F3;
        Sat, 24 Jul 2021 19:35:03 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 3/8] gfs2: Fix mmap + page fault deadlocks for buffered I/O
Date:   Sat, 24 Jul 2021 21:34:44 +0200
Message-Id: <20210724193449.361667-4-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-1-agruenba@redhat.com>
References: <20210724193449.361667-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index 55ec1cadc9e6..3aa66d4de383 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -843,6 +843,12 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	size_t written = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and then we retry.
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
+	    iov_iter_fault_in_writeable(to, SIZE_MAX) == 0)
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
+	 * inode glock, fault in the pages manually, and then we retry.
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
+	    iov_iter_fault_in_readable(from, SIZE_MAX) == 0)
+		goto retry;
 	return ret;
 }
 
-- 
2.26.3

