Return-Path: <linux-fsdevel+bounces-10084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8B8479FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2344C1F27C68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D25980628;
	Fri,  2 Feb 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YocfUc9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4915E5CF;
	Fri,  2 Feb 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903690; cv=none; b=qvFlswdfXOdF5xN+WL2TxkH9bsMNyKYTS06HFa0fpuXm8xEElpX2u86d8AxCmkzhifuMdl0+0fzkKRgS6cTUW2LNV8MxMf6dVo4Q67xM479QI1VjWZ00AQzg6cDvPtnYpiHdv8AveI8lF0x4+q08yxHXoPl124jDpyrFWHBYghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903690; c=relaxed/simple;
	bh=zis5a832DNVLDWMLTosC40g+8JGoXNTfiM52H9fknoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raNUcJJypfZE+W0I1pTZzZ8Xgmg2WmQrKDWRx5udcklaZ/kLOzXGMWUA3YIlON+ZyRhhZtPbNWg7hZcxIkZiZLpeMrecOkRIysJX45R4fYeD1eRlsGM7MzsUQ6k9ocVtRcMtOEXAhDh/9vxZQMrrcxJxf2bvJ2KWi6aspO0VsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YocfUc9n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EPDigTwMYSBeKa6P2S6F9u1gtv1/BziHaf0fSlf2HG8=; b=YocfUc9nh/plb0/y4ycGxYL6+3
	yPQ1rAiT7ueetm5FzW01bar2EInuaNROHYtFNNeGTe5QMK0+3rWHA//rSaRsSe+ag2RRTXquD2mTU
	I/lWvLuNqLdKV/fVocNPbkVhYS7sEC74KzbpO57m559oGE1jTBiIkkJHrfbYswIotesGLbfWOaeZS
	dJV69wh0VbhGRp16QQesbTiM1W/5mZIld142xIqSV8NYPZU0Z3o2THgbEto+ZXCY7IY8WSrYb5Mj6
	1aGJk0q2+0edXHuc6eMwZaEC+D5BeyfK/1nvArJ0exyaLUy9REv+4mexNBN7luPnJk5RnXaoj9oJK
	R5M0xuxg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzcd-00000001wBG-08ua;
	Fri, 02 Feb 2024 19:54:47 +0000
Date: Fri, 2 Feb 2024 19:54:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: Introduce buffered_write_operations
Message-ID: <Zb1IhounqHjhreZD@casper.infradead.org>
References: <20240130055414.2143959-1-willy@infradead.org>
 <20240130055414.2143959-2-willy@infradead.org>
 <20240130081252.GC22621@lst.de>
 <ZbsfuaANd4DIVb4w@casper.infradead.org>
 <20240201044246.GA14117@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201044246.GA14117@lst.de>

On Thu, Feb 01, 2024 at 05:42:46AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 01, 2024 at 04:36:09AM +0000, Matthew Wilcox wrote:
> > +static struct folio *iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> > +               size_t len)
> > 
> > with corresponding changes.  Again, ends up looking slightly cleaner.
> 
> iomap also really needs some tweaks to the naming in the area as a
> __foo function calling foo as the default is horrible.  I'll take a
> look at your patches and can add that on top.
> 
> > f2fs also doesn't seem terribly objectional; passing rpages between
> > begin & end.
> > 
> > ocfs2 is passing a ocfs2_write_ctxt between the two.
> 
> Well, it might be the intended purpose, but as-is it is horribly
> inefficient - they need to do a dynamic allocation for every
> page they iterate over.  So all of them are candidates for an
> iterator model that does this allocation once per write.

Oh, I see what you mean.  What I could do is pass in the fsdata,
like this.

commit 753c7d2d62e1
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jan 29 23:20:34 2024 -0500

    fs: Introduce buffered_write_operations
    
    Start the process of moving write_begin and write_end out from the
    address_space_operations to their own struct.
    
    The new write_begin returns the folio or an ERR_PTR instead of returning
    the folio by reference.  It also accepts len as a size_t and (as
    documented) the len may be larger than PAGE_SIZE.
    
    Pass an optional buffered_write_operations pointer to various functions
    in filemap.c.  The old names are available as macros for now, except
    for generic_file_write_iter() which is used as a function pointer by
    many filesystems.  If using the new functions, the filesystem can have
    per-operation fsdata instead of per-page fsdata.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..a79c7f15ca9f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -18,6 +18,27 @@
 
 struct folio_batch;
 
+struct buffered_write_operations {
+	struct folio *(*write_begin)(struct file *, struct address_space *,
+			loff_t pos, size_t len, void **fsdata);
+	size_t (*write_end)(struct file *, struct address_space *,
+			loff_t pos, size_t len, size_t copied,
+			struct folio *folio, void **fsdata);
+};
+
+ssize_t filemap_write_iter(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *, void *fsdata);
+ssize_t __filemap_write_iter(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *, void *fsdata);
+ssize_t filemap_perform_write(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *, void *fsdata);
+
+ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
+#define generic_perform_write(kiocb, iter)		\
+	filemap_perform_write(kiocb, iter, NULL, NULL)
+#define __generic_file_write_iter(kiocb, iter)		\
+	__filemap_write_iter(kiocb, iter, NULL, NULL)
+
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..214266aeaca5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -95,7 +95,7 @@
  *    ->invalidate_lock		(filemap_fault)
  *      ->lock_page		(filemap_fault, access_process_vm)
  *
- *  ->i_rwsem			(generic_perform_write)
+ *  ->i_rwsem			(filemap_perform_write)
  *    ->mmap_lock		(fault_in_readable->do_page_fault)
  *
  *  bdi->wb.list_lock
@@ -3890,7 +3890,8 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
+ssize_t filemap_perform_write(struct kiocb *iocb, struct iov_iter *i,
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
@@ -3900,11 +3901,10 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		struct folio *folio;
+		size_t offset;		/* Offset into pagecache folio */
+		size_t bytes;		/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
-		void *fsdata = NULL;
 
 		offset = (pos & (PAGE_SIZE - 1));
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
@@ -3927,19 +3927,33 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		status = a_ops->write_begin(file, mapping, pos, bytes,
+		if (ops) {
+			folio = ops->write_begin(file, mapping, pos, bytes, &fsdata);
+			if (IS_ERR(folio)) {
+				status = PTR_ERR(folio);
+				break;
+			}
+		} else {
+			struct page *page;
+			status = a_ops->write_begin(file, mapping, pos, bytes,
 						&page, &fsdata);
-		if (unlikely(status < 0))
-			break;
+			if (unlikely(status < 0))
+				break;
+			folio = page_folio(page);
+		}
 
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
-		flush_dcache_page(page);
+		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
+		flush_dcache_folio(folio);
 
-		status = a_ops->write_end(file, mapping, pos, bytes, copied,
-						page, fsdata);
+		if (ops)
+			status = ops->write_end(file, mapping, pos, bytes,
+					copied, folio, &fsdata);
+		else
+			status = a_ops->write_end(file, mapping, pos, bytes,
+					copied, &folio->page, fsdata);
 		if (unlikely(status != copied)) {
 			iov_iter_revert(i, copied - max(status, 0L));
 			if (unlikely(status < 0))
@@ -3969,12 +3983,13 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	iocb->ki_pos += written;
 	return written;
 }
-EXPORT_SYMBOL(generic_perform_write);
+EXPORT_SYMBOL(filemap_perform_write);
 
 /**
- * __generic_file_write_iter - write data to a file
- * @iocb:	IO state structure (file, offset, etc.)
- * @from:	iov_iter with data to write
+ * __filemap_write_iter - write data to a file
+ * @iocb: IO state structure (file, offset, etc.)
+ * @from: iov_iter with data to write
+ * @ops: How to inform the filesystem that a write is starting/finishing.
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates
@@ -3992,7 +4007,8 @@ EXPORT_SYMBOL(generic_perform_write);
  * * number of bytes written, even for truncated writes
  * * negative error code if no data has been written at all
  */
-ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t __filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -4019,27 +4035,29 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			return ret;
 		return direct_write_fallback(iocb, from, ret,
-				generic_perform_write(iocb, from));
+				filemap_perform_write(iocb, from, ops, fsdata));
 	}
 
-	return generic_perform_write(iocb, from);
+	return filemap_perform_write(iocb, from, ops, fsdata);
 }
-EXPORT_SYMBOL(__generic_file_write_iter);
+EXPORT_SYMBOL(__filemap_write_iter);
 
 /**
- * generic_file_write_iter - write data to a file
+ * filemap_write_iter - write data to a file
  * @iocb:	IO state structure
  * @from:	iov_iter with data to write
  *
- * This is a wrapper around __generic_file_write_iter() to be used by most
+ * This is a wrapper around __filemap_write_iter() to be used by most
  * filesystems. It takes care of syncing the file in case of O_SYNC file
  * and acquires i_rwsem as needed.
+ *
  * Return:
- * * negative error code if no data has been written at all of
+ * * negative error code if no data has been written at all or if
  *   vfs_fsync_range() failed for a synchronous write
  * * number of bytes written, even for truncated writes
  */
-ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
@@ -4048,13 +4066,18 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0)
-		ret = __generic_file_write_iter(iocb, from);
+		ret = __filemap_write_iter(iocb, from, ops, fsdata);
 	inode_unlock(inode);
 
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
 }
+
+ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return filemap_write_iter(iocb, from, NULL, NULL);
+}
 EXPORT_SYMBOL(generic_file_write_iter);
 
 /**

