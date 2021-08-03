Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F493DF568
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhHCTTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239730AbhHCTT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628018354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IULcZE+GE0RHMHtw9EFWCvHkiLwAkm0qqTvH1XU9M1M=;
        b=A+sF10RZT0pBWUldMh68lVSoy/TFxohtv94K/uv/m1pSgxD2MLhU0lwA0AuxNQGQL/mWdX
        r/7W1Jb/xDfhNA5nA3YXY7jQZDThZSIXl+6U9UcMRP7RpxsjSZsHAZns1RX+1OM3yzNevy
        Mp+/NmyXNuUB68FIGteRH3pxK0I73sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-L1wwZNlZOW-pGMgnx9sAag-1; Tue, 03 Aug 2021 15:19:10 -0400
X-MC-Unique: L1wwZNlZOW-pGMgnx9sAag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6971800489;
        Tue,  3 Aug 2021 19:19:08 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD6C560C0F;
        Tue,  3 Aug 2021 19:19:02 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 12/12] gfs2: Fix mmap + page fault deadlocks for direct I/O
Date:   Tue,  3 Aug 2021 21:18:18 +0200
Message-Id: <20210803191818.993968-13-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-1-agruenba@redhat.com>
References: <20210803191818.993968-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also disable page faults during direct I/O requests and implement the same
kind of retry logic as in the buffered I/O case.

Direct I/O requests differ from buffered I/O requests in that they use
bio_iov_iter_get_pages for grabbing page references and faulting in pages
instead of triggering physical page faults.  Those manual page faults can be
disabled with the new iocb->noio flag.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index d98f690097e2..ed42b7675551 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -782,21 +782,47 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	struct file *file = iocb->ki_filp;
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 	size_t count = iov_iter_count(to);
+	size_t written = 0;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and retry.
+	 *
+	 * Unlike generic_file_read_iter, for reads, iomap_dio_rw can trigger
+	 * physical as well as manual page faults, and we need to disable both
+	 * kinds.
+	 */
+
 	if (!count)
 		return 0; /* skip atime */
 
 	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL, 0, 0);
+	pagefault_disable();
+	to->noio = true;
+	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
+			   IOMAP_DIO_PARTIAL, written);
+	to->noio = false;
+	pagefault_enable();
+
 	gfs2_glock_dq(gh);
+	if (ret > 0)
+		written = ret;
+	if (unlikely(iov_iter_count(to) && (ret > 0 || ret == -EFAULT)) &&
+	    iter_is_iovec(to) &&
+	    fault_in_iov_iter_writeable(to, SIZE_MAX) != 0)
+		goto retry;
 out_uninit:
 	gfs2_holder_uninit(gh);
-	return ret;
+	if (ret < 0)
+		return ret;
+	return written;
 }
 
 static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
@@ -809,6 +835,15 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
 
+	/*
+	 * In this function, we disable page faults when we're holding the
+	 * inode glock while doing I/O.  If a page fault occurs, we drop the
+	 * inode glock, fault in the pages manually, and retry.
+	 *
+	 * For writes, iomap_dio_rw only triggers manual page faults, so we
+	 * don't need to disable physical ones.
+	 */
+
 	/*
 	 * Deferred lock, even if its a write, since we do no allocation on
 	 * this path. All we need to change is the atime, and this lock mode
@@ -818,6 +853,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	 * VFS does.
 	 */
 	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
 		goto out_uninit;
@@ -826,11 +862,18 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
+	from->noio = true;
 	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0, 0);
+	from->noio = false;
+
 	if (ret == -ENOTBLK)
 		ret = 0;
 out:
 	gfs2_glock_dq(gh);
+	if (unlikely(ret == -EFAULT) &&
+	    iter_is_iovec(from) &&
+	    fault_in_iov_iter_readable(from, len) == len)
+		goto retry;
 out_uninit:
 	gfs2_holder_uninit(gh);
 	return ret;
-- 
2.26.3

