Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836AA3D5064
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 00:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGYVgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 17:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231292AbhGYVgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 17:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627251409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ihu2pnjGkxS62C8ME4R8VGgIAtcGREqgRpT3Z9wqgg=;
        b=FjSAZxPjEKNAdHhH74f5UjgFMmDaRz1jeYU5qsbBxytq0ltPpVl1PJVy5JW/wKC4M/Lu4x
        lixHyw0wpwFEK9Kx9p2efHs7vSZc8+CU5AB6rWYy25iEaFOkyOMN0C/fK/G8BeE0dD2vRW
        VUXAKlJh6mj4YW/zybau0cXx4KXFpq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-_sr7zHURPImymv7K2iP9vg-1; Sun, 25 Jul 2021 18:16:46 -0400
X-MC-Unique: _sr7zHURPImymv7K2iP9vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76CDA801A92;
        Sun, 25 Jul 2021 22:16:44 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB64C19D7C;
        Sun, 25 Jul 2021 22:16:41 +0000 (UTC)
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
Date:   Mon, 26 Jul 2021 00:16:39 +0200
Message-Id: <20210725221639.426565-1-agruenba@redhat.com>
In-Reply-To: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com> <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a fixed and cleaned up version that passes fstests on gfs2.

I see no reason why the combination of tail packing + writing should
cause any issues, so in my opinion, the check that disables that
combination in iomap_write_begin_inline should still be removed.

It turns out that returning the number of bytes copied from
iomap_read_inline_data is a bit irritating: the function is really used
for filling the page, but that's not always the "progress" we're looking
for.  In the iomap_readpage case, we actually need to advance by an
antire page, but in the iomap_file_buffered_write case, we need to
advance by the length parameter of iomap_write_actor or less.  So I've
changed that back.

I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
iomap_inline_data_size_valid into iomap_within_inline_data, which seems
more useful to me.

Thanks,
Andreas

--

Subject: [PATCH] iomap: Support tail packing

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
Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
 fs/iomap/direct-io.c   | 11 ++++++-----
 include/linux/iomap.h  | 22 +++++++++++++++++++++-
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..334bf98fdd4a 100644
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
@@ -247,7 +251,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
 		iomap_read_inline_data(inode, page, iomap);
 		return PAGE_SIZE;
 	}
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
+	BUG_ON(!iomap_within_inline_data(iomap, pos + copied - 1));
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
 	kunmap_atomic(addr);
 
 	mark_inode_dirty(inode);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..c9424e58f613 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,21 +380,22 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(!iomap_within_inline_data(iomap, pos + length - 1)))
+		return -EIO;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
-		loff_t size = inode->i_size;
+		loff_t size = iomap->offset + iomap->length;
 
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
index 479c1da3e221..c1b57d34cb76 100644
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
@@ -97,6 +97,26 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+/*
+ * Returns the inline data pointer for logical offset @pos.
+ */
+static void *iomap_inline_data(struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data + pos - iomap->offset;
+}
+
+/*
+ * Check if logical offset @pos is within the valid range for inline data.
+ * This is used to guard against accessing data beyond the page inline_data
+ * points at.
+ */
+static bool iomap_within_inline_data(struct iomap *iomap, loff_t pos)
+{
+	unsigned int size = PAGE_SIZE - offset_in_page(iomap->inline_data);
+
+	return pos - iomap->offset < size;
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.26.3

