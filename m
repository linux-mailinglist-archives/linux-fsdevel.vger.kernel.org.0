Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB724865A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHRNrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 09:47:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgHRNqo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:46:44 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 560295C1CB765C8BB0E0;
        Tue, 18 Aug 2020 21:46:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 21:46:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <willy@infradead.org>, <david@fromorbit.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [RFC PATCH V2] iomap: add support to track dirty state of sub pages
Date:   Tue, 18 Aug 2020 21:46:18 +0800
Message-ID: <20200818134618.2345884-1-yukuai3@huawei.com>
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
	device:		sata ssd

test case:
	dd if=/dev/zero of=/mnt/testfile bs=1M count=128
	fio --ioengine=sync --rw=randwrite --iodepth=64 --name=test --filename=/mnt/testfile --bs=4k --fsync=1

The test result is:
a. with patch

```
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=4460KiB/s][r=0,w=1115 IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3158: Tue Aug 18 07:38:53 2020
  write: IOPS=1087, BW=4350KiB/s (4455kB/s)(128MiB/30129msec)
    clat (nsec): min=3020, max=22320, avg=4990.47, stdev=1613.56
     lat (nsec): min=3180, max=23220, avg=5157.69, stdev=1617.42
    clat percentiles (nsec):
     |  1.00th=[ 3376],  5.00th=[ 3568], 10.00th=[ 3824], 20.00th=[ 4016],
     | 30.00th=[ 4128], 40.00th=[ 4192], 50.00th=[ 4256], 60.00th=[ 4320],
     | 70.00th=[ 4512], 80.00th=[ 7392], 90.00th=[ 7840], 95.00th=[ 8032],
     | 99.00th=[ 8512], 99.50th=[ 8896], 99.90th=[12096], 99.95th=[14144],
     | 99.99th=[20096]
   bw (  KiB/s): min= 1504, max= 4496, per=100.00%, avg=4350.65, stdev=392.33, samples=60
   iops        : min=  376, max= 1124, avg=1087.65, stdev=98.08, samples=60
  lat (usec)   : 4=17.40%, 10=82.40%, 20=0.19%, 50=0.02%
  fsync/fdatasync/sync_file_range:
    sync (usec): min=677, max=24318, avg=903.99, stdev=455.75
    sync percentiles (usec):
     |  1.00th=[  685],  5.00th=[  693], 10.00th=[  701], 20.00th=[  701],
     | 30.00th=[  709], 40.00th=[  709], 50.00th=[  717], 60.00th=[  717],
     | 70.00th=[  725], 80.00th=[ 1467], 90.00th=[ 1483], 95.00th=[ 1500],
     | 99.00th=[ 1532], 99.50th=[ 1762], 99.90th=[ 7767], 99.95th=[ 7832],
     | 99.99th=[ 8094]
  cpu          : usr=0.33%, sys=2.13%, ctx=98405, majf=0, minf=4
  IO depths    : 1=200.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,32768,0,32767 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=4350KiB/s (4455kB/s), 4350KiB/s-4350KiB/s (4455kB/s-4455kB/s), io=128MiB (134MB), run=30129-30129msec

Disk stats (read/write):
  sda: ios=4/65596, merge=0/5, ticks=3/30579, in_queue=58279, util=99.72%
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
 fs/iomap/buffered-io.c | 91 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..0a501dc82dde 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -28,8 +28,12 @@
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
+	DECLARE_BITMAP(state, PAGE_SIZE / 256);
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
@@ -52,8 +56,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
-	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	spin_lock_init(&iop->state_lock);
+	bitmap_zero(iop->state, PAGE_SIZE * 2 / SECTOR_SIZE);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
@@ -101,7 +105,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -111,7 +115,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, iop->state)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -135,6 +139,64 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
+static void
+iomap_iop_set_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	struct inode *inode = page->mapping->host;
+	unsigned int total = PAGE_SIZE / SECTOR_SIZE;
+	unsigned int first = off >> inode->i_blkbits;
+	unsigned int last = (off + len - 1) >> inode->i_blkbits;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	for (i = first; i <= last; i++)
+		set_bit(i + total, iop->state);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void
+iomap_set_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	if (PageError(page))
+		return;
+
+	if (page_has_private(page))
+		iomap_iop_set_range_dirty(page, off, len);
+}
+
+static void
+iomap_iop_clear_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	struct inode *inode = page->mapping->host;
+	unsigned int total = PAGE_SIZE / SECTOR_SIZE;
+	unsigned int first = off >> inode->i_blkbits;
+	unsigned int last = (off + len - 1) >> inode->i_blkbits;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	for (i = first; i <= last; i++)
+		clear_bit(i + total, iop->state);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void
+iomap_clear_range_dirty(struct page *page, unsigned int off,
+		unsigned int len)
+{
+	if (PageError(page))
+		return;
+
+	if (page_has_private(page))
+		iomap_iop_clear_range_dirty(page, off, len);
+}
+
 static void
 iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
@@ -146,17 +208,17 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
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
@@ -466,7 +528,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 
 	if (iop) {
 		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
 				return 0;
 		return 1;
 	}
@@ -705,6 +767,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_dirty(page, offset_in_page(pos), len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
@@ -1030,6 +1093,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 		WARN_ON_ONCE(!PageUptodate(page));
 		iomap_page_create(inode, page);
 		set_page_dirty(page);
+		iomap_set_range_dirty(page, offset_in_page(pos), length);
 	}
 
 	return length;
@@ -1373,6 +1437,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
 	int error = 0, count = 0, i;
+	int total = PAGE_SIZE / SECTOR_SIZE;
 	LIST_HEAD(submit_list);
 
 	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
@@ -1386,7 +1451,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	for (i = 0, file_offset = page_offset(page);
 	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
 	     i++, file_offset += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !test_bit(i + total, iop->state))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
@@ -1435,6 +1500,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 */
 		set_page_writeback_keepwrite(page);
 	} else {
+		iomap_clear_range_dirty(page, 0,
+				end_offset - page_offset(page) + 1);
 		clear_page_dirty_for_io(page);
 		set_page_writeback(page);
 	}
-- 
2.25.4

