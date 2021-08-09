Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513EC3E4018
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhHIGee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhHIGee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:34:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C226C0613CF;
        Sun,  8 Aug 2021 23:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UxBtPmDy4DIybU1SgbXva6a1UPnFEyqj7JCXf4/Yuj0=; b=eCORjvjVf1W6pHG1wx9hoIrVHB
        WMNa2hP3L3cd8bFjNE5ciAgi4A3FjeZsHL1hJANeCUtNTQxhHetf/dXt8nKKcaRMebk3L/xO1Zf7P
        3iLTLAehx/IOZMqk3VIcu46VBNlfrLYhOhGiFAG6orC0J+Da/tvI5DGOR/vsn4Vg4sanOqlnZ33Z0
        axpMAeA9rxZbzJyivda/zjEIlrjyT+EWtFMu+HBHnIjseYzXKaIbLKvprdnWHO1Mlzm7CwKZD+I0U
        pp0xefBVVX+o6vuJJiXp9bpVoTZPTh1V2zBUgoKVjAsbjjCM/bnIxnE7uaADruO2WjzW7q+uJDuly
        e3Yf36pw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyp2-00AhnG-2b; Mon, 09 Aug 2021 06:31:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 23/30] fsdax: switch dax_iomap_rw to use iomap_iter
Date:   Mon,  9 Aug 2021 08:12:37 +0200
Message-Id: <20210809061244.1196573-24-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch the dax_iomap_rw implementation to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4d63040fd71f56..51da45301350a6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1103,20 +1103,21 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	return size;
 }
 
-static loff_t
-dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
+		struct iov_iter *iter)
 {
+	const struct iomap *iomap = &iomi->iomap;
+	loff_t length = iomap_length(iomi);
+	loff_t pos = iomi->pos;
 	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
-	struct iov_iter *iter = data;
 	loff_t end = pos + length, done = 0;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
 
 	if (iov_iter_rw(iter) == READ) {
-		end = min(end, i_size_read(inode));
+		end = min(end, i_size_read(iomi->inode));
 		if (pos >= end)
 			return 0;
 
@@ -1133,7 +1134,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	 * written by write(2) is visible in mmap.
 	 */
 	if (iomap->flags & IOMAP_F_NEW) {
-		invalidate_inode_pages2_range(inode->i_mapping,
+		invalidate_inode_pages2_range(iomi->inode->i_mapping,
 					      pos >> PAGE_SHIFT,
 					      (end - 1) >> PAGE_SHIFT);
 	}
@@ -1209,31 +1210,29 @@ ssize_t
 dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops)
 {
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	loff_t pos = iocb->ki_pos, ret = 0, done = 0;
-	unsigned flags = 0;
+	struct iomap_iter iomi = {
+		.inode		= iocb->ki_filp->f_mapping->host,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(iter),
+	};
+	loff_t done = 0;
+	int ret;
 
 	if (iov_iter_rw(iter) == WRITE) {
-		lockdep_assert_held_write(&inode->i_rwsem);
-		flags |= IOMAP_WRITE;
+		lockdep_assert_held_write(&iomi.inode->i_rwsem);
+		iomi.flags |= IOMAP_WRITE;
 	} else {
-		lockdep_assert_held(&inode->i_rwsem);
+		lockdep_assert_held(&iomi.inode->i_rwsem);
 	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
-		flags |= IOMAP_NOWAIT;
+		iomi.flags |= IOMAP_NOWAIT;
 
-	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
-				iter, dax_iomap_actor);
-		if (ret <= 0)
-			break;
-		pos += ret;
-		done += ret;
-	}
+	while ((ret = iomap_iter(&iomi, ops)) > 0)
+		iomi.processed = dax_iomap_iter(&iomi, iter);
 
-	iocb->ki_pos += done;
+	done = iomi.pos - iocb->ki_pos;
+	iocb->ki_pos = iomi.pos;
 	return done ? done : ret;
 }
 EXPORT_SYMBOL_GPL(dax_iomap_rw);
@@ -1307,7 +1306,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	}
 
 	/*
-	 * Note that we don't bother to use iomap_apply here: DAX required
+	 * Note that we don't bother to use iomap_iter here: DAX required
 	 * the file system block size to be equal the page size, which means
 	 * that we never have to deal with more than a single extent here.
 	 */
@@ -1561,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	}
 
 	/*
-	 * Note that we don't use iomap_apply here.  We aren't doing I/O, only
+	 * Note that we don't use iomap_iter here.  We aren't doing I/O, only
 	 * setting up a mapping, so really we're using iomap_begin() as a way
 	 * to look up our filesystem block.
 	 */
-- 
2.30.2

