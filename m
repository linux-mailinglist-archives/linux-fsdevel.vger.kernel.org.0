Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D621382B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGCJxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 05:53:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726432AbgGCJxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593770016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mT7+S/JZ0X5UTjCHTtZu+xMVOeg7qKFbo24bRgqj2g8=;
        b=DJo8Z0cVyyjco+5EDgF1G+hMnTIgYXZOOdwtM5WucqefPRSLOqFeIAkfghbF6udVWUyE8h
        V6vyr5qll59DiYGrMntlXL43my+Nz38hs+B1zIuhwi0uxlmiYjeEgsDJdzIO7b2A1haicr
        cw53ZAmVAqm6TlIPuBkZHyzjKi9KbH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-E3iaSV3zOIiSfGk0c4lyhw-1; Fri, 03 Jul 2020 05:53:34 -0400
X-MC-Unique: E3iaSV3zOIiSfGk0c4lyhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54630107ACCA;
        Fri,  3 Jul 2020 09:53:33 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71F656111F;
        Fri,  3 Jul 2020 09:53:31 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC v2 2/2] gfs2: Rework read and page fault locking
Date:   Fri,  3 Jul 2020 11:53:25 +0200
Message-Id: <20200703095325.1491832-3-agruenba@redhat.com>
In-Reply-To: <20200703095325.1491832-1-agruenba@redhat.com>
References: <20200703095325.1491832-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far, gfs2 has taken the inode glocks inside the ->readpage and
->readahead address space operations.  Since commit d4388340ae0b ("fs:
convert mpage_readpages to mpage_readahead"), gfs2_readahead is passed
the pages to read ahead locked.  With that, the current holder of the
inode glock may be trying to lock one of those pages while
gfs2_readahead is trying to take the inode glock, resulting in a
deadlock.

Fix that by moving the lock taking to the higher-level ->read_iter file
and ->fault vm operations.  This also gets rid of an ugly lock inversion
workaround in gfs2_readpage.

The cache consistency model of filesystems like gfs2 is such that if
data is found in the page cache, the data is up to date and can be used
without taking any filesystem locks.  If a page is not cached,
filesystem locks must be taken before populating the page cache.

To avoid taking the inode glock when the data is already cached,
gfs2_file_read_iter first tries to read the data with the IOCB_NOIO flag
set.  If that fails, the inode glock is taken and the operation is
retried with the IOCB_NOIO flag cleared.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 45 +------------------------------------------
 fs/gfs2/file.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 72c9560f4467..68cd700a2719 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -468,21 +468,10 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 }
 
 
-/**
- * __gfs2_readpage - readpage
- * @file: The file to read a page for
- * @page: The page to read
- *
- * This is the core of gfs2's readpage. It's used by the internal file
- * reading code as in that case we already hold the glock. Also it's
- * called by gfs2_readpage() once the required lock has been granted.
- */
-
 static int __gfs2_readpage(void *file, struct page *page)
 {
 	struct gfs2_inode *ip = GFS2_I(page->mapping->host);
 	struct gfs2_sbd *sdp = GFS2_SB(page->mapping->host);
-
 	int error;
 
 	if (i_blocksize(page->mapping->host) == PAGE_SIZE &&
@@ -505,36 +494,11 @@ static int __gfs2_readpage(void *file, struct page *page)
  * gfs2_readpage - read a page of a file
  * @file: The file to read
  * @page: The page of the file
- *
- * This deals with the locking required. We have to unlock and
- * relock the page in order to get the locking in the right
- * order.
  */
 
 static int gfs2_readpage(struct file *file, struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-	struct gfs2_inode *ip = GFS2_I(mapping->host);
-	struct gfs2_holder gh;
-	int error;
-
-	unlock_page(page);
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	error = gfs2_glock_nq(&gh);
-	if (unlikely(error))
-		goto out;
-	error = AOP_TRUNCATED_PAGE;
-	lock_page(page);
-	if (page->mapping == mapping && !PageUptodate(page))
-		error = __gfs2_readpage(file, page);
-	else
-		unlock_page(page);
-	gfs2_glock_dq(&gh);
-out:
-	gfs2_holder_uninit(&gh);
-	if (error && error != AOP_TRUNCATED_PAGE)
-		lock_page(page);
-	return error;
+	return __gfs2_readpage(file, page);
 }
 
 /**
@@ -598,16 +562,9 @@ static void gfs2_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_holder gh;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	if (gfs2_glock_nq(&gh))
-		goto out_uninit;
 	if (!gfs2_is_stuffed(ip))
 		mpage_readahead(rac, gfs2_block_map);
-	gfs2_glock_dq(&gh);
-out_uninit:
-	gfs2_holder_uninit(&gh);
 }
 
 /**
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fe305e4bfd37..bebde537ac8c 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -558,8 +558,29 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	return block_page_mkwrite_return(ret);
 }
 
+static vm_fault_t gfs2_fault(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_holder gh;
+	vm_fault_t ret;
+	int err;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	err = gfs2_glock_nq(&gh);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
+		goto out_uninit;
+	}
+	ret = filemap_fault(vmf);
+	gfs2_glock_dq(&gh);
+out_uninit:
+	gfs2_holder_uninit(&gh);
+	return ret;
+}
+
 static const struct vm_operations_struct gfs2_vm_ops = {
-	.fault = filemap_fault,
+	.fault = gfs2_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = gfs2_page_mkwrite,
 };
@@ -824,6 +845,9 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct gfs2_inode *ip;
+	struct gfs2_holder gh;
+	size_t written = 0;
 	ssize_t ret;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
@@ -832,7 +856,31 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 		iocb->ki_flags &= ~IOCB_DIRECT;
 	}
-	return generic_file_read_iter(iocb, to);
+	iocb->ki_flags |= IOCB_NOIO;
+	ret = generic_file_read_iter(iocb, to);
+	iocb->ki_flags &= ~IOCB_NOIO;
+	if (ret >= 0) {
+		if (!iov_iter_count(to))
+			return ret;
+		written = ret;
+	} else {
+		if (ret != -EAGAIN)
+			return ret;
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return ret;
+	}
+	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq(&gh);
+	if (ret)
+		goto out_uninit;
+	ret = generic_file_read_iter(iocb, to);
+	if (ret > 0)
+		written += ret;
+	gfs2_glock_dq(&gh);
+out_uninit:
+	gfs2_holder_uninit(&gh);
+	return written ? written : ret;
 }
 
 /**
-- 
2.26.2

