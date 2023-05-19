Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DC7093B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjESJiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjESJhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:37:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C241BC1;
        Fri, 19 May 2023 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bXtYYEEzQwvZPWpQse6yFS2DlWFyrRFvHXQe3dgGWLU=; b=wuR5MfjM+D3bTZWoEm9c9T3FyQ
        Jue/kbHK6tmzfma8e+SaYSkRo0i0M95KfzwDKIl7yAZarwpeGlFg8SOccbWg+5smRc3AQ4HdXO5Wr
        nxv736/1Pra0TlJRc6gOvRj0yJnIoeus3Ea9ZcLZX9vsbfDhxOOcJdu2Sh3OLpn1iJaVfJZVoL+PO
        6JYYrGM32hNNnf9ay0x08Yy8FXV4AEv6azjWxZA7R3S8/gudYOrARKgoCUAPoEHO6BpLCM3Eu/iHd
        Ze6v9o/MZ4FMpWwAoU8d5cZ1OtyW+xcKH2yx0ol+dIujh/Uz9vLoSMKaWdOFEP9SsxpBhnAOmgW1i
        fsiOwFhw==;
Received: from [2001:4bb8:188:3dd5:e8d0:68bb:e5be:210a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzwWe-00FjiA-3B;
        Fri, 19 May 2023 09:35:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/13] fs: factor out a direct_write_fallback helper
Date:   Fri, 19 May 2023 11:35:18 +0200
Message-Id: <20230519093521.133226-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519093521.133226-1-hch@lst.de>
References: <20230519093521.133226-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper dealing with handling the syncing of a buffered write fallback
for direct I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/libfs.c         | 36 ++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 59 ++++++++++------------------------------------
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 89cf614a327158..9f3791fc6e0715 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1613,3 +1613,39 @@ u64 inode_query_iversion(struct inode *inode)
 	return cur >> I_VERSION_QUERIED_SHIFT;
 }
 EXPORT_SYMBOL(inode_query_iversion);
+
+ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t direct_written, ssize_t buffered_written)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t pos = iocb->ki_pos, end;
+	int err;
+
+	/*
+	 * If the buffered write fallback returned an error, we want to return
+	 * the number of bytes which were written by direct I/O, or the error
+	 * code if that was zero.
+	 *
+	 * Note that this differs from normal direct-io semantics, which will
+	 * return -EFOO even if some bytes were written.
+	 */
+	if (unlikely(buffered_written < 0))
+		return buffered_written;
+
+	/*
+	 * We need to ensure that the page cache pages are written to disk and
+	 * invalidated to preserve the expected O_DIRECT semantics.
+	 */
+	end = pos + buffered_written - 1;
+	err = filemap_write_and_wait_range(mapping, pos, end);
+	if (err < 0) {
+		/*
+		 * We don't know how much we wrote, so just return the number of
+		 * bytes which were direct-written
+		 */
+		return err;
+	}
+	invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	return direct_written + buffered_written;
+}
+EXPORT_SYMBOL_GPL(direct_write_fallback);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e4efc1792a877a..576a945db178ef 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2738,6 +2738,8 @@ extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
 ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
+ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t direct_written, ssize_t buffered_written);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index c1b988199aece5..875b2108d0a05f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4008,25 +4008,21 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
-	struct inode 	*inode = mapping->host;
-	ssize_t		written = 0;
-	ssize_t		err;
-	ssize_t		status;
+	struct inode *inode = mapping->host;
+	ssize_t ret;
 
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = inode_to_bdi(inode);
-	err = file_remove_privs(file);
-	if (err)
+	ret = file_remove_privs(file);
+	if (ret)
 		goto out;
 
-	err = file_update_time(file);
-	if (err)
+	ret = file_update_time(file);
+	if (ret)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t pos, endbyte;
-
-		written = generic_file_direct_write(iocb, from);
+		ret = generic_file_direct_write(iocb, from);
 		/*
 		 * If the write stopped short of completing, fall back to
 		 * buffered writes.  Some filesystems do this for writes to
@@ -4034,46 +4030,15 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * not succeed (even if it did, DAX does not handle dirty
 		 * page-cache pages correctly).
 		 */
-		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
-			goto out;
-
-		pos = iocb->ki_pos;
-		status = generic_perform_write(iocb, from);
-		/*
-		 * If generic_perform_write() returned a synchronous error
-		 * then we want to return the number of bytes which were
-		 * direct-written, or the error code if that was zero.  Note
-		 * that this differs from normal direct-io semantics, which
-		 * will return -EFOO even if some bytes were written.
-		 */
-		if (unlikely(status < 0)) {
-			err = status;
-			goto out;
-		}
-		/*
-		 * We need to ensure that the page cache pages are written to
-		 * disk and invalidated to preserve the expected O_DIRECT
-		 * semantics.
-		 */
-		endbyte = pos + status - 1;
-		err = filemap_write_and_wait_range(mapping, pos, endbyte);
-		if (err == 0) {
-			written += status;
-			invalidate_mapping_pages(mapping,
-						 pos >> PAGE_SHIFT,
-						 endbyte >> PAGE_SHIFT);
-		} else {
-			/*
-			 * We don't know how much we wrote, so just return
-			 * the number of bytes which were direct-written
-			 */
-		}
+		if (ret >= 0 && iov_iter_count(from) && !IS_DAX(inode))
+			ret = direct_write_fallback(iocb, from, ret,
+					generic_perform_write(iocb, from));
 	} else {
-		written = generic_perform_write(iocb, from);
+		ret = generic_perform_write(iocb, from);
 	}
 out:
 	current->backing_dev_info = NULL;
-	return written ? written : err;
+	return ret;
 }
 EXPORT_SYMBOL(__generic_file_write_iter);
 
-- 
2.39.2

