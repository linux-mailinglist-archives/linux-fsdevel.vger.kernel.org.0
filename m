Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA4265B93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKI13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 04:27:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgIKI1U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:27:20 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5448876F5274B33334EF;
        Fri, 11 Sep 2020 16:27:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 16:27:09 +0800
Subject: Re: [RFC PATCH V4] iomap: add support to track dirty state of sub
 pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <david@fromorbit.com>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20200821123306.1658495-1-yukuai3@huawei.com>
 <20200821124424.GQ17456@casper.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com>
Date:   Fri, 11 Sep 2020 16:27:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200821124424.GQ17456@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/21 20:44, Matthew Wilcox wrote:
> On Fri, Aug 21, 2020 at 08:33:06PM +0800, Yu Kuai wrote:
>> changes from v3: - add IOMAP_STATE_ARRAY_SIZE - replace set_bit / 
>> clear_bit with bitmap_set / bitmap_clear - move 
>> iomap_set_page_dirty() out of 'iop->state_lock' - merge 
>> iomap_set/clear_range_dirty() and 
>> iomap_iop_clear/clear_range_dirty()
> 
> I'm still working on the iomap parts of the THP series (fixing up 
> invalidatepage right now), but here are some of the relevant bits 
> (patch series to follow)
> 

Hi, Matthew

Since your THP iomap patches were reviewed, I made some modifications
based on these patches.

Best regards,
Yu Kuai

---
  fs/iomap/buffered-io.c | 92 +++++++++++++++++++++++++++++++++---------
  1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index edf5eea56cf5..bc7f57748be8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -23,13 +23,17 @@

  /*
   * Structure allocated for each page or THP when block size < page size
- * to track sub-page uptodate status and I/O completions.
+ * to track sub-page status and I/O completions.
   */
  struct iomap_page {
  	atomic_t		read_bytes_pending;
  	atomic_t		write_bytes_pending;
-	spinlock_t		uptodate_lock;
-	unsigned long		uptodate[];
+	spinlock_t		state_lock;
+	/*
+	 * The first half bits are used to track sub-page uptodate status,
+	 * the second half bits are for dirty status.
+	 */
+	unsigned long		state[];
  };

  static inline struct iomap_page *to_iomap_page(struct page *page)
@@ -57,9 +61,9 @@ iomap_page_create(struct inode *inode, struct page *page)
  	if (iop || nr_blocks <= 1)
  		return iop;

-	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
  			GFP_NOFS | __GFP_NOFAIL);
-	spin_lock_init(&iop->uptodate_lock);
+	spin_lock_init(&iop->state_lock);
  	attach_page_private(page, iop);
  	return iop;
  }
@@ -74,7 +78,7 @@ iomap_page_release(struct page *page)
  		return;
  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(bitmap_full(iop->state, nr_blocks) !=
  			PageUptodate(page));
  	kfree(iop);
  }
@@ -105,7 +109,7 @@ iomap_adjust_read_range(struct inode *inode, struct 
iomap_page *iop,

  		/* move forward for each leading block marked uptodate */
  		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
  				break;
  			*pos += block_size;
  			poff += block_size;
@@ -115,7 +119,7 @@ iomap_adjust_read_range(struct inode *inode, struct 
iomap_page *iop,

  		/* truncate len if we find any trailing uptodate block(s) */
  		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, iop->state)) {
  				plen -= (last - i + 1) * block_size;
  				last = i - 1;
  				break;
@@ -139,6 +143,55 @@ iomap_adjust_read_range(struct inode *inode, struct 
iomap_page *iop,
  	*lenp = plen;
  }

+static void
+iomap_set_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	struct inode *inode = page->mapping->host;
+	unsigned int blocks_per_page = i_blocks_per_page(inode, page);
+	unsigned int first = (off >> inode->i_blkbits) + blocks_per_page;
+	unsigned int last = ((off + len - 1) >> inode->i_blkbits) + 
blocks_per_page;
+	unsigned long flags;
+	struct iomap_page *iop;
+
+	if (PageError(page))
+		return;
+
+	if (len)
+		iomap_set_page_dirty(page);
+
+	if (!page_has_private(page))
+		return;
+
+	iop = to_iomap_page(page);
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first, last - first + 1);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void
+iomap_clear_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	struct inode *inode = page->mapping->host;
+	unsigned int blocks_per_page = i_blocks_per_page(inode, page);
+	unsigned int first = (off >> inode->i_blkbits) + blocks_per_page;
+	unsigned int last = ((off + len - 1) >> inode->i_blkbits) + 
blocks_per_page;
+	unsigned long flags;
+	struct iomap_page *iop;
+
+	if (PageError(page))
+		return;
+
+	if (!page_has_private(page))
+		return;
+
+	iop = to_iomap_page(page);
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_clear(iop->state, first, last - first + 1);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
  static void
  iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned 
len)
  {
@@ -148,11 +201,11 @@ iomap_iop_set_range_uptodate(struct page *page, 
unsigned off, unsigned len)
  	unsigned last = (off + len - 1) >> inode->i_blkbits;
  	unsigned long flags;

-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first, last - first + 1);
+	if (bitmap_full(iop->state, i_blocks_per_page(inode, page)))
  		SetPageUptodate(page);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
  }

  static void
@@ -445,7 +498,7 @@ iomap_is_partially_uptodate(struct page *page, 
unsigned long from,

  	if (iop) {
  		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
  				return 0;
  		return 1;
  	}
@@ -683,7 +736,7 @@ static size_t __iomap_write_end(struct inode *inode, 
loff_t pos, size_t len,
  	if (unlikely(copied < len && !PageUptodate(page)))
  		return 0;
  	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
+	iomap_set_range_dirty(page, offset_in_page(pos), len);
  	return copied;
  }

@@ -997,7 +1050,6 @@ iomap_page_mkwrite_actor(struct inode *inode, 
loff_t pos, loff_t length,
  	} else {
  		WARN_ON_ONCE(!PageUptodate(page));
  		iomap_page_create(inode, page);
-		set_page_dirty(page);
  	}

  	return length;
@@ -1007,7 +1059,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault 
*vmf, const struct iomap_ops *ops)
  {
  	struct page *page = vmf->page;
  	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
+	unsigned int length, dirty_bits;
  	loff_t offset;
  	ssize_t ret;

@@ -1016,6 +1068,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault 
*vmf, const struct iomap_ops *ops)
  	if (ret < 0)
  		goto out_unlock;
  	length = ret;
+	dirty_bits = ret;

  	offset = page_offset(page);
  	while (length > 0) {
@@ -1028,6 +1081,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault 
*vmf, const struct iomap_ops *ops)
  		length -= ret;
  	}

+	iomap_set_range_dirty(page, 0, dirty_bits);
  	wait_for_stable_page(page);
  	return VM_FAULT_LOCKED;
  out_unlock:
@@ -1340,11 +1394,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
  	struct iomap_page *iop = to_iomap_page(page);
  	struct iomap_ioend *ioend, *next;
  	unsigned len = i_blocksize(inode);
+	unsigned int blocks_per_page = i_blocks_per_page(inode, page);
  	u64 file_offset; /* file offset of page */
  	int error = 0, count = 0, i;
  	LIST_HEAD(submit_list);

-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
+	WARN_ON_ONCE(blocks_per_page > 1 && !iop);
  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);

  	/*
@@ -1355,7 +1410,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
  	for (i = 0, file_offset = page_offset(page);
  	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
  	     i++, file_offset += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !test_bit(i, iop->state + blocks_per_page))
  			continue;

  		error = wpc->ops->map_blocks(wpc, inode, file_offset);
@@ -1404,6 +1459,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
  		 */
  		set_page_writeback_keepwrite(page);
  	} else {
+		iomap_clear_range_dirty(page, 0, PAGE_SIZE);
  		clear_page_dirty_for_io(page);
  		set_page_writeback(page);
  	}
-- 
2.25.4


.




