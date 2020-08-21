Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD924D511
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgHUMdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 08:33:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbgHUMda (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:33:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF8891460589A2CF625A;
        Fri, 21 Aug 2020 20:33:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 20:33:20 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <willy@infradead.org>, <david@fromorbit.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [RFC PATCH V4] iomap: add support to track dirty state of sub pages
Date:   Fri, 21 Aug 2020 20:33:06 +0800
Message-ID: <20200821123306.1658495-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes from v3:
 - add IOMAP_STATE_ARRAY_SIZE
 - replace set_bit / clear_bit with bitmap_set / bitmap_clear
 - move iomap_set_page_dirty() out of 'iop->state_lock'
 - merge iomap_set/clear_range_dirty() and iomap_iop_clear/clear_range_dirty()

changes from v2:
 as suggested by Mathew:
 - move iomap_set_page_dirty() into iomap_set_range_dirty()
 - add DIRTY_BITS()
 - move ioamp_set_rannge_dirty() from iomap_page_mkwrite_actor() to
   iomap_page_mkwrite()
 - clear the dirty bits of entire page in iomap_writepage_map

changes from v1:
 - separate set dirty and clear dirty functions
 - don't test uptodate bit in iomap_writepage_map()
 - use one bitmap array for uptodate and dirty.

commit 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O
without buffer heads") replace the per-block structure buffer_head with
the per-page structure iomap_page. However, iomap_page can't track the
dirty state of sub pages, which will cause performance issue since sub
pages will be writeback even if they are not dirty.

For example, if block size is 4k and page size is 64k:

dd if=/dev/zero of=testfile bs=4k count=16 oflag=sync

With buffer_head implementation, the above dd cmd will writeback 4k in
each round. However, with iomap_page implementation, the range of
writeback in each round is from the start of the page to the end offset
we just wrote.

Thus add support to track dirty state in iomap_page.

I tested this path with:
test environment:
	platform:	arm64
	kernel:		v5.8
	pagesize:	64k
	blocksize:	4k

test case:
	dd if=/dev/zero of=/mnt/testfile bs=1M count=128
	fio --ioengine=sync --rw=randwrite --iodepth=64 --name=test --filename=/mnt/testfile --bs=4k --fsync=1

The test result is:
a. with patch

```
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=4576KiB/s][r=0,w=1144 IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=233608: Fri Aug 21 08:09:21 2020
  write: IOPS=1152, BW=4609KiB/s (4720kB/s)(128MiB/28437msec)
    clat (nsec): min=3000, max=23580, avg=4944.15, stdev=1589.23
     lat (nsec): min=3160, max=24500, avg=5109.51, stdev=1592.11
    clat percentiles (nsec):
     |  1.00th=[ 3376],  5.00th=[ 3600], 10.00th=[ 3824], 20.00th=[ 4016],
     | 30.00th=[ 4128], 40.00th=[ 4192], 50.00th=[ 4256], 60.00th=[ 4320],
     | 70.00th=[ 4448], 80.00th=[ 7200], 90.00th=[ 7968], 95.00th=[ 8160],
     | 99.00th=[ 8512], 99.50th=[ 8768], 99.90th=[10688], 99.95th=[12224],
     | 99.99th=[20352]
   bw (  KiB/s): min= 1920, max= 4800, per=99.97%, avg=4607.39, stdev=395.03, samples=56
   iops        : min=  480, max= 1200, avg=1151.84, stdev=98.76, samples=56
  lat (usec)   : 4=18.41%, 10=81.45%, 20=0.13%, 50=0.01%
  fsync/fdatasync/sync_file_range:
    sync (usec): min=651, max=22374, avg=852.24, stdev=430.25
    sync percentiles (usec):
     |  1.00th=[  660],  5.00th=[  660], 10.00th=[  668], 20.00th=[  668],
     | 30.00th=[  676], 40.00th=[  676], 50.00th=[  685], 60.00th=[  685],
     | 70.00th=[  693], 80.00th=[ 1401], 90.00th=[ 1418], 95.00th=[ 1434],
     | 99.00th=[ 1467], 99.50th=[ 1680], 99.90th=[ 7767], 99.95th=[ 7767],
     | 99.99th=[ 7767]
  cpu          : usr=0.41%, sys=2.18%, ctx=98400, majf=0, minf=4
  IO depths    : 1=200.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,32768,0,32767 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=4609KiB/s (4720kB/s), 4609KiB/s-4609KiB/s (4720kB/s-4720kB/s), io=128MiB (134MB), run=28437-28437msec

Disk stats (read/write):
  sda: ios=4/65441, merge=0/5, ticks=3/28859, in_queue=54849, util=99.70%
```

b. without patch

```
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=3003KiB/s][r=0,w=750 IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=9174: Tue Aug 18 04:17:16 2020
  write: IOPS=678, BW=2714KiB/s (2780kB/s)(128MiB/48286msec)
    clat (nsec): min=3420, max=26240, avg=5898.60, stdev=1824.49
     lat (nsec): min=3600, max=26860, avg=6065.21, stdev=1826.90
    clat percentiles (nsec):
     |  1.00th=[ 3792],  5.00th=[ 4128], 10.00th=[ 4320], 20.00th=[ 4512],
     | 30.00th=[ 4576], 40.00th=[ 4704], 50.00th=[ 4832], 60.00th=[ 4960],
     | 70.00th=[ 7968], 80.00th=[ 8256], 90.00th=[ 8512], 95.00th=[ 8768],
     | 99.00th=[ 9152], 99.50th=[ 9408], 99.90th=[11840], 99.95th=[13376],
     | 99.99th=[18560]
   bw (  KiB/s): min= 1016, max= 3128, per=99.92%, avg=2711.92, stdev=357.89, samples=96
   iops        : min=  254, max=  782, avg=677.98, stdev=89.47, samples=96
  lat (usec)   : 4=3.14%, 10=96.66%, 20=0.20%, 50=0.01%
  fsync/fdatasync/sync_file_range:
    sync (usec): min=814, max=24221, avg=1456.82, stdev=543.48
    sync percentiles (usec):
     |  1.00th=[  988],  5.00th=[  996], 10.00th=[  996], 20.00th=[ 1012],
     | 30.00th=[ 1029], 40.00th=[ 1221], 50.00th=[ 1270], 60.00th=[ 1287],
     | 70.00th=[ 1795], 80.00th=[ 1844], 90.00th=[ 2245], 95.00th=[ 2278],
     | 99.00th=[ 2442], 99.50th=[ 2737], 99.90th=[ 5407], 99.95th=[ 5538],
     | 99.99th=[ 5735]
  cpu          : usr=0.19%, sys=1.54%, ctx=98412, majf=0, minf=4
  IO depths    : 1=200.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,32768,0,32767 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=2714KiB/s (2780kB/s), 2714KiB/s-2714KiB/s (2780kB/s-2780kB/s), io=128MiB (134MB), run=48286-48286msec

Disk stats (read/write):
  sda: ios=4/65344, merge=0/5, ticks=2/48198, in_queue=88938, util=99.83%
```

c. ext4

```
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=3919KiB/s][r=0,w=979 IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=8682: Tue Aug 18 04:15:43 2020
  write: IOPS=960, BW=3840KiB/s (3932kB/s)(128MiB/34133msec)
    clat (usec): min=4, max=349, avg= 8.92, stdev= 2.94
     lat (usec): min=4, max=349, avg= 9.06, stdev= 2.94
    clat percentiles (nsec):
     |  1.00th=[ 6112],  5.00th=[ 6624], 10.00th=[ 6880], 20.00th=[ 7200],
     | 30.00th=[ 7456], 40.00th=[ 7712], 50.00th=[ 8032], 60.00th=[ 8384],
     | 70.00th=[ 9024], 80.00th=[11712], 90.00th=[12608], 95.00th=[13120],
     | 99.00th=[14272], 99.50th=[14656], 99.90th=[17536], 99.95th=[20352],
     | 99.99th=[33536]
   bw (  KiB/s): min= 1344, max= 3992, per=100.00%, avg=3839.88, stdev=314.69, samples=68
   iops        : min=  336, max=  998, avg=959.97, stdev=78.67, samples=68
  lat (usec)   : 10=74.64%, 20=25.31%, 50=0.05%, 100=0.01%, 500=0.01%
  fsync/fdatasync/sync_file_range:
    sync (usec): min=666, max=25174, avg=1021.69, stdev=871.62
    sync percentiles (usec):
     |  1.00th=[  685],  5.00th=[  693], 10.00th=[  701], 20.00th=[  701],
     | 30.00th=[  709], 40.00th=[  717], 50.00th=[  717], 60.00th=[  725],
     | 70.00th=[  734], 80.00th=[ 1500], 90.00th=[ 1516], 95.00th=[ 1532],
     | 99.00th=[ 6128], 99.50th=[ 6128], 99.90th=[ 7832], 99.95th=[ 8225],
     | 99.99th=[ 9634]
  cpu          : usr=0.32%, sys=2.87%, ctx=90254, majf=0, minf=4
  IO depths    : 1=200.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,32768,0,32767 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=3840KiB/s (3932kB/s), 3840KiB/s-3840KiB/s (3932kB/s-3932kB/s), io=128MiB (134MB), run=34133-34133msec

Disk stats (read/write):
  sda: ios=0/75055, merge=0/8822, ticks=0/40565, in_queue=68469, util=99.80%
```

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/iomap/buffered-io.c | 88 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..4539f98f3c12 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -21,15 +21,22 @@
 
 #include "../internal.h"
 
+#define DIRTY_BITS(x)	((x) + PAGE_SIZE / SECTOR_SIZE)
+#define IOMAP_STATE_ARRAY_SIZE	(PAGE_SIZE * 2 / SECTOR_SIZE)
+
 /*
  * Structure allocated for each page when block size < PAGE_SIZE to track
- * sub-page uptodate status and I/O completions.
+ * sub-page status and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
-	spinlock_t		uptodate_lock;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	spinlock_t		state_lock;
+	/*
+	 * The first half bits are used to track sub-page uptodate status,
+	 * the second half bits are for dirty status.
+	 */
+	DECLARE_BITMAP(state, IOMAP_STATE_ARRAY_SIZE);
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
@@ -52,8 +59,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
-	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	spin_lock_init(&iop->state_lock);
+	bitmap_zero(iop->state, IOMAP_STATE_ARRAY_SIZE);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
@@ -101,7 +108,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -111,7 +118,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, iop->state)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -135,6 +142,53 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
+static void
+iomap_set_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	struct inode *inode = page->mapping->host;
+	unsigned int first = DIRTY_BITS(off >> inode->i_blkbits);
+	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
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
+	unsigned int first = DIRTY_BITS(off >> inode->i_blkbits);
+	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
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
 iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
@@ -146,17 +200,17 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
+	spin_lock_irqsave(&iop->state_lock, flags);
 	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
 		if (i >= first && i <= last)
-			set_bit(i, iop->uptodate);
-		else if (!test_bit(i, iop->uptodate))
+			set_bit(i, iop->state);
+		else if (!test_bit(i, iop->state))
 			uptodate = false;
 	}
 
 	if (uptodate)
 		SetPageUptodate(page);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
 }
 
 static void
@@ -466,7 +520,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 
 	if (iop) {
 		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
 				return 0;
 		return 1;
 	}
@@ -705,7 +759,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
+	iomap_set_range_dirty(page, offset_in_page(pos), len);
 	return copied;
 }
 
@@ -1029,7 +1083,6 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 	} else {
 		WARN_ON_ONCE(!PageUptodate(page));
 		iomap_page_create(inode, page);
-		set_page_dirty(page);
 	}
 
 	return length;
@@ -1039,7 +1092,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
+	unsigned int length, bytes_in_page;
 	loff_t offset;
 	ssize_t ret;
 
@@ -1048,6 +1101,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 	if (ret < 0)
 		goto out_unlock;
 	length = ret;
+	bytes_in_page = ret;
 
 	offset = page_offset(page);
 	while (length > 0) {
@@ -1060,6 +1114,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 		length -= ret;
 	}
 
+	iomap_set_range_dirty(page, 0, bytes_in_page);
 	wait_for_stable_page(page);
 	return VM_FAULT_LOCKED;
 out_unlock:
@@ -1386,7 +1441,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	for (i = 0, file_offset = page_offset(page);
 	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
 	     i++, file_offset += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !test_bit(DIRTY_BITS(i), iop->state))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
@@ -1435,6 +1490,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 */
 		set_page_writeback_keepwrite(page);
 	} else {
+		iomap_clear_range_dirty(page, 0, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 		set_page_writeback(page);
 	}
-- 
2.25.4

