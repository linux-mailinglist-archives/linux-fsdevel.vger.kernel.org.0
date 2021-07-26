Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193D93D5838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhGZKZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 06:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbhGZKZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627297581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ad2ryKrfK6sJyTkUWOpK6mUvcD3y5ZEk3RAUKPbVjNc=;
        b=cwi3AxDbqO2j34kUGNOwYI+DKPy1CR1D8YKkU4D2aSgnFWr67KxmSYOucqvP7WH9+B0Elf
        5WpuR4QUGPUFnoOWrHi1lQs0J9BR8wRBlIua8XiheivVwLCiuFiqYu+BJk3dzUig4vI5Ei
        1yls3mnf2+7nlXLF0/IbBqqmfZtJhHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-w0pUUMoZMBaG1V_MtCOAzw-1; Mon, 26 Jul 2021 07:06:19 -0400
X-MC-Unique: w0pUUMoZMBaG1V_MtCOAzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB848799F6;
        Mon, 26 Jul 2021 11:06:17 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 277C810016F8;
        Mon, 26 Jul 2021 11:06:14 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Date:   Mon, 26 Jul 2021 13:06:11 +0200
Message-Id: <20210726110611.459173-1-agruenba@redhat.com>
In-Reply-To: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com> <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com> <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com> <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's the promised update.  Passes fstests on gfs2.

Thanks,
Andreas

--

Subject: iomap: Support tail packing

The existing inline data support only works for cases where the entire
file is stored as inline data.  For larger files, EROFS stores the
initial blocks separately and then can pack a small tail adjacent to the
inode.  Generalise inline data to allow for tail packing.  Tails may not
cross a page boundary in memory.

We currently have no filesystems that support tail packing and writing,
so that case is currently disabled (see iomap_write_begin_inline).  I'm
not aware of any reason why this code path shouldn't work, however.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 38 +++++++++++++++++++++++++-------------
 fs/iomap/direct-io.c   |  9 +++++----
 include/linux/iomap.h  | 20 +++++++++++++++++++-
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..dee6b0952ef8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+static int iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
 {
-	size_t size = i_size_read(inode);
+	size_t size = i_size_read(inode) - iomap->offset;
 	void *addr;
 
 	if (PageUptodate(page))
-		return;
+		return 0;
 
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline and tail-packed data must start page aligned in the file */
+	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
+		return -EIO;
+	if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inline_data)))
+		return -EIO;
+	if (WARN_ON_ONCE(page_has_private(page)))
+		return -EIO;
 
 	addr = kmap_atomic(page);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
 	SetPageUptodate(page);
+	return 0;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -247,9 +251,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
+		int ret = iomap_read_inline_data(inode, page, iomap);
+		return ret ?: PAGE_SIZE;
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
@@ -589,6 +592,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(srcmap->offset != 0))
+		return -EIO;
+	return iomap_read_inline_data(inode, page, srcmap);
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
@@ -671,11 +683,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
-	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	BUG_ON(!iomap_inline_data_size_valid(iomap));
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
 	kunmap_atomic(addr);
 
 	mark_inode_dirty(inode);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..6fdae86d0f1d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,21 +380,22 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
+		return -EIO;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
 
 		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+			memset(iomap_inline_data(iomap, size), 0, pos - size);
+		copied = copy_from_iter(iomap_inline_data(iomap, pos), length, iter);
 		if (copied) {
 			if (pos + copied > size)
 				i_size_write(inode, pos + copied);
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(iomap_inline_data(iomap, pos), length, iter);
 	}
 	dio->size += copied;
 	return copied;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..c6af1ef608c6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -28,7 +28,7 @@ struct vm_fault;
 #define IOMAP_DELALLOC	1	/* delayed allocation blocks */
 #define IOMAP_MAPPED	2	/* blocks allocated at @addr */
 #define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
-#define IOMAP_INLINE	4	/* data inline in the inode */
+#define IOMAP_INLINE	4	/* inline or tail-packed data */
 
 /*
  * Flags reported by the file system from iomap_begin:
@@ -97,6 +97,24 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+/*
+ * Returns the inline data pointer for logical offset @pos.
+ */
+static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data + pos - iomap->offset;
+}
+
+/*
+ * Check if the mapping's length is within the valid range for inline data.
+ * This is used to guard against accessing data beyond the page inline_data
+ * points at.
+ */
+static inline bool iomap_inline_data_size_valid(struct iomap *iomap)
+{
+	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.26.3

