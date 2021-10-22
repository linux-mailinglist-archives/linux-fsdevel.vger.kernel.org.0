Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29458437F32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhJVURy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:17:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhJVURt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:17:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E4AA212C6;
        Fri, 22 Oct 2021 20:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634933730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gruAYj2W5+dSZFH6GAIlb+7UeTkm9JbN30KUB4RxUoM=;
        b=WZd9SxStwDM7gIonuhJ1Px+SYVoT7BnaBv+KwiApusk1M+fGIzqRv9kwbYt2m+RB0PshWs
        woZc1zOLriMi7YPywiPD58+3vUxzD/bfYtGAyr79/WzN2ByvNoB5i54P5jI+VnJliS+Y2/
        a+xufXkNSd2mpUeOlPJjFmiEEBVXYEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634933730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gruAYj2W5+dSZFH6GAIlb+7UeTkm9JbN30KUB4RxUoM=;
        b=8SaHPDeCComtBMUwV/6i4n8zWUrJefXNNs1pGsL9mS0TWCPVCGipMYjNwWm9a+4z0m5JS5
        BzXZXYXEaC9YroBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 910601348D;
        Fri, 22 Oct 2021 20:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YTJbFeEbc2HmdgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 22 Oct 2021 20:15:29 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 2/5] mm: Switch mapping to device mapping
Date:   Fri, 22 Oct 2021 15:15:02 -0500
Message-Id: <98a26b87716dd6eec5214ee0dc2eac10eb47439d.1634933121.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634933121.git.rgoldwyn@suse.com>
References: <cover.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Get the device offset and last_index from the filesystem and read it
from the device directly. If the device page(s) have been read before,
it can be picked up directly for reads. If not the page is read from the
device. The page would be added to device's mapping instead of the file.

Con:
This moves the read from file's readpage to block device's readpage.
Post read filesystem checks such as data CRC will be ignored.
An option is to change readpage() prototype to include file offset and
call file->f_mapping->a_ops->readpage().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c    |  2 +-
 include/linux/fs.h |  7 ++++++-
 mm/filemap.c       | 34 ++++++++++++++++++++++++++--------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ba44039071e5..e171d822a05e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3654,7 +3654,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
-	return filemap_read(iocb, to, ret);
+	return filemap_read(iocb, to, ret, NULL);
 }
 
 const struct file_operations btrfs_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..9409f703bcd1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3229,8 +3229,13 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
+
+typedef pgoff_t (*file_offset_to_device_t)(struct file *filp, loff_t pos,
+		size_t len, pgoff_t *last_index);
+
 ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *to,
-		ssize_t already_read);
+		ssize_t already_read,
+		file_offset_to_device_t file_offset_to_device);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index d1458ecf2f51..21033503b0a1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2445,14 +2445,17 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 }
 
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct pagevec *pvec)
+		struct pagevec *pvec,
+		file_offset_to_device_t file_offset_to_device)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
 	struct file_ra_state *ra = &filp->f_ra;
+	struct super_block *sb = file_inode(filp)->i_sb;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct page *page;
+	bool switched = false;
 	int err = 0;
 
 	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
@@ -2461,6 +2464,19 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		return -EINTR;
 
 	filemap_get_read_batch(mapping, index, last_index, pvec);
+	if (!pagevec_count(pvec) && !switched && file_offset_to_device) {
+		pgoff_t idx, lidx;
+
+		idx = file_offset_to_device(filp, iocb->ki_pos,
+				iter->count, &lidx);
+		if (idx) {
+			mapping = sb->s_bdev->bd_inode->i_mapping;
+			index = idx;
+			last_index = lidx;
+			switched = true;
+			goto retry;
+		}
+	}
 	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
@@ -2471,8 +2487,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_page(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, pvec);
+		err = filemap_create_page(filp, mapping, index, pvec);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -2517,12 +2532,13 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
  * a negative error number.
  */
 ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
-		ssize_t already_read)
+		ssize_t already_read,
+		file_offset_to_device_t file_offset_to_device)
 {
 	struct file *filp = iocb->ki_filp;
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
-	struct inode *inode = mapping->host;
+	struct inode *inode = file_inode(filp);
 	struct pagevec pvec;
 	int i, error = 0;
 	bool writably_mapped;
@@ -2547,7 +2563,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		error = filemap_get_pages(iocb, iter, &pvec);
+		error = filemap_get_pages(iocb, iter, &pvec,
+				file_offset_to_device);
 		if (error < 0)
 			break;
 
@@ -2560,6 +2577,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * another truncate extends the file - this is desired though).
 		 */
 		isize = i_size_read(inode);
+
 		if (unlikely(iocb->ki_pos >= isize))
 			goto put_pages;
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
@@ -2586,7 +2604,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 					     page_size - offset);
 			size_t copied;
 
-			if (end_offset < page_offset(page))
+			if (!file_offset_to_device && (end_offset < page_offset(page)))
 				break;
 			if (i > 0)
 				mark_page_accessed(page);
@@ -2698,7 +2716,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			return retval;
 	}
 
-	return filemap_read(iocb, iter, retval);
+	return filemap_read(iocb, iter, retval, NULL);
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
-- 
2.33.1

