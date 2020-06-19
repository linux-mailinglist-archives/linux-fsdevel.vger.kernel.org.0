Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801F8201241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394118AbgFSPul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394132AbgFSPuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:50:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F93C06174E;
        Fri, 19 Jun 2020 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gqRrOSjrTbnmLixbeSJjNyufrKjbx8bQ0hoWXFgHbbA=; b=FUNxybH2BQdZYCAyU9DCQsfcFT
        milNvBpSYbFN9uggxqVw0KSSDEG8nnbG+ql3mVjPp7AGcKj7l66qo7y2pl6Hsv7KKr6kCa51ScPTA
        EWwUCzuL0G+vNeMOviK7AWZvLfdFPi8VUhljOifHnmuFJUfXW3CJKbQ1H2c5PTeuGieu8SbXAa1Dp
        YrWnLx/3z4T6G+ocOe4jNVdXNTaCsztfIZqLGclRIelAdmBMlLEo5XKpVhrctiNhazPND5Tcu3MFM
        mJb5LKpxVvyhwWPmmJKuO6DX/PwVz4UKmTlTElCrFBDQmypl5AUn9Db+94F3puc3J3a2YbmpFPz9Q
        NxC1wcFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmJHo-0005rh-J2; Fri, 19 Jun 2020 15:50:36 +0000
Date:   Fri, 19 Jun 2020 08:50:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        agruenba@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200619155036.GZ8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
The advantage of this patch is that we can avoid taking any filesystem
lock, as long as the pages being accessed are in the cache (and we don't
need to readahead any pages into the cache).  We also avoid an indirect
function call in these cases.

I'm sure reusing the name call_read_iter() is the wrong way to go about
this, but renaming all the callers would make this a larger patch.
I'm happy to do it if something like this stands a chance of being
accepted.

Compared to Andreas' patch, I removed the -ECANCELED return value.
We can happily return 0 from generic_file_buffered_read() and it's less
code to handle that.  I bypass the attempt to read from the page cache
for O_DIRECT reads, and for inodes which have no cached pages.  Hopefully
this will avoid calling generic_file_buffered_read() for drivers which
implement read_iter() (although I haven't audited them all to check that

This could go horribly wrong if filesystems rely on doing work in their
->read_iter implementation (eg checking i_size after acquiring their
lock) instead of keeping the page cache uptodate.  On the other hand,
the ->map_pages() method is already called without locks, so filesystems
should already be prepared for this.

Arguably we could do something similar for writes.  I'm a little more
scared of that patch since filesystems are more likely to want to do
things to keep their fies in sync for writes.

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15e..7b899538d3c0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -401,6 +401,41 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
 
+ssize_t call_read_iter(struct file *file, struct kiocb *iocb,
+				     struct iov_iter *iter)
+{
+	ssize_t written, ret = 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		goto uncached;
+	if (!file->f_mapping->nrpages)
+		goto uncached;
+
+	iocb->ki_flags |= IOCB_CACHED;
+	ret = generic_file_buffered_read(iocb, iter, 0);
+	iocb->ki_flags &= ~IOCB_CACHED;
+
+	if (likely(!iov_iter_count(iter)))
+		return ret;
+
+	if (ret == -EAGAIN) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return ret;
+		ret = 0;
+	} else if (ret < 0) {
+		return ret;
+	}
+
+uncached:
+	written = ret;
+
+	ret = file->f_op->read_iter(iocb, iter);
+	if (ret > 0)
+		written += ret;
+
+	return written ? written : ret;
+}
+
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = len };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c4ab4dc1cd7..0985773feffd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -315,6 +315,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_CACHED		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -1895,11 +1896,7 @@ struct inode_operations {
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
 
-static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
-				     struct iov_iter *iter)
-{
-	return file->f_op->read_iter(kio, iter);
-}
+ssize_t call_read_iter(struct file *, struct kiocb *, struct iov_iter *);
 
 static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
 				      struct iov_iter *iter)
diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..4ee97941a1f2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2028,7 +2028,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED))
 				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
@@ -2038,12 +2038,16 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 				goto no_cached_page;
 		}
 		if (PageReadahead(page)) {
+			if (iocb->ki_flags & IOCB_CACHED) {
+				put_page(page);
+				goto out;
+			}
 			page_cache_async_readahead(mapping,
 					ra, filp, page,
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED)) {
 				put_page(page);
 				goto would_block;
 			}

