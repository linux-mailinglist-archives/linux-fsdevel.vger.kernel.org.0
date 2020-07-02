Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6288F212A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGBQvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:51:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726796AbgGBQvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593708695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+ndlDtkJHwk4RF17SCQ46WL0iE0gMN06cDaLV9IAwo=;
        b=DoeOkZs8q1RLP5oS3Q7jDgH7O7g/uTDq2DZrvyNqz6acsUGPuKWpTRz7gnMkUSNdBWwRpw
        3VcPpHKzx1kOE5gJpihNnPtp9EJZA2+8DYrvuiVcn5qXymXE0XKIYctlkLPePsAVSemE8f
        B7rTO5HW5aSurl6vGJpU4Gl4GYeQRJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-uHprCz_-N--qYsiVpAEwVg-1; Thu, 02 Jul 2020 12:51:32 -0400
X-MC-Unique: uHprCz_-N--qYsiVpAEwVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DD66107BEF6;
        Thu,  2 Jul 2020 16:51:31 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 430C279231;
        Thu,  2 Jul 2020 16:51:29 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC 3/4] gfs2: Rework read and page fault locking
Date:   Thu,  2 Jul 2020 18:51:19 +0200
Message-Id: <20200702165120.1469875-4-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-1-agruenba@redhat.com>
References: <20200702165120.1469875-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far, gfs2 has taken the filesystem locks inside the ->readpage and
->readahead address space operations.  These operations are too
low-level, causing lock ordering problems and workarounds.  To get rid
of those, move the locking to the ->read_iter file and ->fault vm
operations.

The cache consistency model of filesystems like gfs2 is such that if
data is found in the page cache, the data is up to date and can be used
without taking any filesystem locks.  If a page is not cached,
filesystem locks must be taken before populating the page cache.

To avoid taking the inode glock when the data is already cached, the
->read_iter file operation first tries to read the data with the
IOCB_NOIO flag set.  If that fails, the inode glock is taken and the
operation is repeated with the IOCB_NOIO flag cleared.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 59 ++++----------------------------------------------
 fs/gfs2/file.c | 55 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 786c1ce8f030..28f097636e78 100644
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
@@ -597,24 +561,9 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 static int gfs2_readpages(struct file *file, struct address_space *mapping,
 			  struct list_head *pages, unsigned nr_pages)
 {
-	struct inode *inode = mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	struct gfs2_holder gh;
-	int ret;
-
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	ret = gfs2_glock_nq(&gh);
-	if (unlikely(ret))
-		goto out_uninit;
-	if (!gfs2_is_stuffed(ip))
-		ret = mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
-	gfs2_glock_dq(&gh);
-out_uninit:
-	gfs2_holder_uninit(&gh);
-	if (unlikely(gfs2_withdrawn(sdp)))
-		ret = -EIO;
-	return ret;
+	if (!gfs2_is_stuffed(GFS2_I(mapping->host)))
+		return mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
+	return 0;
 }
 
 /**
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fe305e4bfd37..607bbf4dfadb 100644
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
@@ -824,15 +845,45 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct gfs2_inode *ip;
+	struct gfs2_holder gh;
+	size_t written = 0;
 	ssize_t ret;
 
+	gfs2_holder_mark_uninitialized(&gh);
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = gfs2_file_direct_read(iocb, to);
 		if (likely(ret != -ENOTBLK))
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
+	if (gfs2_holder_initialized(&gh))
+		gfs2_glock_dq(&gh);
+out_uninit:
+	if (gfs2_holder_initialized(&gh))
+		gfs2_holder_uninit(&gh);
+	return written ? written : ret;
 }
 
 /**
-- 
2.26.2

