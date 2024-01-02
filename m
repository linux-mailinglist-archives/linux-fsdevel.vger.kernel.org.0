Return-Path: <linux-fsdevel+bounces-7090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52417821BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557BB1C21F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AEFBE2;
	Tue,  2 Jan 2024 12:42:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC9101C5;
	Tue,  2 Jan 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CCv4vzQz4f3kpt;
	Tue,  2 Jan 2024 20:42:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 677041A036B;
	Tue,  2 Jan 2024 20:42:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S4;
	Tue, 02 Jan 2024 20:42:02 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 00/25] ext4: use iomap for regular file's buffered IO path and enable large foilo
Date: Tue,  2 Jan 2024 20:38:53 +0800
Message-Id: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1DGFy5KFy8KrWxur1UAwb_yoW3Zr45pF
	ZIkF4fKr1kW34xua97Cw13tr40ga1rWr47Ww13W34I9F1UAF18ZFn7KF10vFy3ArW7JryU
	Zr4Iyry8W3WFy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	Up6wZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello,

This is my second version of the RFC patch series that convert ext4
regular file's buffered IO path to iomap. I've been fixing a lot of bugs
in v1 and rebased it on 6.7 and with Christoph's "map multiple blocks
per ->map_blocks in iomap writeback" series [1].

This series only support ext4 with the default features and mount
options, doesn't support inline_data, bigalloc, dax, fs_verity, fs_crypt
and data=journal mode, ext4 would fall back to buffer_head path
automatically if you enabled these features/options. Although it has
many limitations now, it can satisfy the requirements of common cases
and bring a great performance benefit.

This series have passed kvm-xfstests tests in auto mode, no obvious
issues have been found. I will keep doing stress tests, hope most of the
corner cases had been covered. For the convenience of review, I split
the implementation into small patches, any comments will be helpful.

Changes since v1:
 - Introduce seq count for iomap buffered write and writeback to protect
   races from extents changes, e.g. truncate, mwrite.
 - Always allocate unwritten extents for new blocks, drop dioread_lock
   mode, and make no distinctions between dioread_lock and
   dioread_nolock.
 - Don't add ditry data range to jinode, drop data=ordered mode, and
   make no distinctions between data=ordered and data=writeback mode.
 - Postpone updating i_disksize to endio.
 - Allow splitting extents and use reserved space in endio.
 - Instead of reimplement a new delayed mapping helper
   ext4_iomap_da_map_blocks() for buffer write, try to reuse
   ext4_da_map_blocks().
 - Add support for disabling large folio on active inodes.
 - Support online defragmentation, make file fall back to buffer_head
   and disable large folio in ext4_move_extents().
 - Move ext4_nonda_switch() in advance to prevent deadlock in mwrite.
 - Add dirty_len and pos trace info to trace_iomap_writepage_map().
 - Update patch 1-6 to v2 [2].

Patch 1-6: this is a preparation series, it changes ext4_map_blocks()
and ext4_set_iomap() to recognize delayed only extents, I've send it out
separately[2] because I've done full tests and suppose this can be
reviewed and merged first.

Patch 7-8: these are two minor iomap changes, one is don't update i_size
in zero_range and the other one is for debug in iomap writeback path
that I've discussed whit Christoph [3].

Patch 9-14: this is another preparation series, including some changes
for delayed extents. Firstly, it factor out buffer_head from
ext4_da_map_blocks(), make it to support adding multi-blocks once a
time. Then make unwritten to written extents conversion in endio use to
reserved space, reduce the risk of potential data loss. Finally,
introduce a sequence counter for extent status tree, which is useful
for iomap buffer write and write back.

Patch 15-21: Implement buffered IO iomap path for read, write, mmap,
zero range, truncate and writeback, replace current buffered_head path.
Please look at the following patch for details.

Patch 22-25: Convert to iomap for regular file's buffered IO path
besides inline_data, bigalloc, dax, fs_verity, fs_crypt, and
data=journal mode, and enable large folio. It should be note that
buffered iomap path hasn't support Online defrag yet, so we need fall
back to buffer_head and disable large folio automatically if user call
EXT4_IOC_MOVE_EXT.

About Tests:
 - I've test it through kvm-xfstests in auto mode.
 - I've done a performance tests below.

   Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU
   with 400GB system ram, 200GB ramdisk and 1TB nvme ssd disk.

   == buffer read ==

                  buffer head        iomap with large folio
   type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
   ----------------------------------------------------
   hole     4K    565k    2206       811k    3167
   hole     64K   45.1k   2820       78.1k   4879
   hole     1M    2744    2744       4890    4891
   ramdisk  4K    436k    1703       554k    2163
   ramdisk  64K   29.6k   1848       44.0k   2747
   ramdisk  1M    1994    1995       2809    2809
   nvme     4K    306k    1196       324k    1267
   nvme     64K   19.3k   1208       24.3k   1517
   nvme     1M    1694    1694       2256    2256

   == buffer write ==

                                        buffer head   ext4_iomap    
   type   Overwrite Sync Writeback bs  IOPS   BW      IOPS   BW
   -------------------------------------------------------------
   cache    N       N    N         4K   395k   1544   415k   1621
   cache    N       N    N         64K  30.8k  1928   80.1k  5005
   cache    N       N    N         1M   1963   1963   5641   5642
   cache    Y       N    N         4K   423k   1652   443k   1730
   cache    Y       N    N         64K  33.0k  2063   80.8k  5051
   cache    Y       N    N         1M   2103   2103   5588   5589
   ramdisk  N       N    Y         4K   362k   1416   307k   1198
   ramdisk  N       N    Y         64K  22.4k  1399   64.8k  4050
   ramdisk  N       N    Y         1M   1670   1670   4559   4560
   ramdisk  N       Y    N         4K   9830   38.4   13.5k  52.8
   ramdisk  N       Y    N         64K  5834   365    10.1k  629
   ramdisk  N       Y    N         1M   1011   1011   2064   2064
   ramdisk  Y       N    Y         4K   397k   1550   409k   1598
   ramdisk  Y       N    Y         64K  29.2k  1827   73.6k  4597
   ramdisk  Y       N    Y         1M   1837   1837   4985   4985
   ramdisk  Y       Y    N         4K   173k   675    182k   710
   ramdisk  Y       Y    N         64K  17.7k  1109   33.7k  2105
   ramdisk  Y       Y    N         1M   1128   1129   1790   1791
   nvme     N       N    Y         4K   298k   1164   290k   1134
   nvme     N       N    Y         64K  21.5k  1343   57.4k  3590
   nvme     N       N    Y         1M   1308   1308   3664   3664
   nvme     N       Y    N         4K   10.7k  41.8   12.0k  46.9
   nvme     N       Y    N         64K  5962   373    8598   537
   nvme     N       Y    N         1M   676    677    1417   1418
   nvme     Y       N    Y         4K   366k   1430   373k   1456
   nvme     Y       N    Y         64K  26.7k  1670   56.8k  3547
   nvme     Y       N    Y         1M   1745   1746   3586   3586
   nvme     Y       Y    N         4K   59.0k  230    61.2k  239
   nvme     Y       Y    N         64K  13.0k  813    21.0k  1311
   nvme     Y       Y    N         1M   683    683    1368   1369
 
TODO
 - Keep on doing stress tests and fixing.
 - I will rebase and resend my another patch set "ext4: more accurate
   metadata reservaion for delalloc mount option[4]", it's useful for
   iomap conversion. After this series, I suppose we could totally drop
   ext4_nonda_switch() and prevent the risk of data loss caused by
   extents splitting.
 - Support for more features and mount options in the future.

[1] https://lore.kernel.org/linux-fsdevel/20231207072710.176093-1-hch@lst.de/
[2] https://lore.kernel.org/linux-ext4/20231223110223.3650717-1-yi.zhang@huaweicloud.com/
[3] https://lore.kernel.org/linux-fsdevel/20231207150311.GA18830@lst.de/
[4] https://lore.kernel.org/linux-ext4/20230824092619.1327976-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (25):
  ext4: refactor ext4_da_map_blocks()
  ext4: convert to exclusive lock while inserting delalloc extents
  ext4: correct the hole length returned by ext4_map_blocks()
  ext4: add a hole extent entry in cache after punch
  ext4: make ext4_map_blocks() distinguish delalloc only extent
  ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type
  iomap: don't increase i_size if it's not a write operation
  iomap: add pos and dirty_len into trace_iomap_writepage_map
  ext4: allow inserting delalloc extents with multi-blocks
  ext4: correct delalloc extent length
  ext4: also mark extent as delalloc if it's been unwritten
  ext4: factor out bh handles to ext4_da_get_block_prep()
  ext4: use reserved metadata blocks when splitting extent in endio
  ext4: introduce seq counter for extent entry
  ext4: add a new iomap aops for regular file's buffered IO path
  ext4: implement buffered read iomap path
  ext4: implement buffered write iomap path
  ext4: implement writeback iomap path
  ext4: implement mmap iomap path
  ext4: implement zero_range iomap path
  ext4: writeback partial blocks before zero range
  ext4: fall back to buffer_head path for defrag
  ext4: partially enable iomap for regular file's buffered IO path
  filemap: support disable large folios on active inode
  ext4: enable large folio for regular file with iomap buffered IO path

 fs/ext4/ext4.h              |  14 +-
 fs/ext4/ext4_jbd2.c         |   6 +
 fs/ext4/ext4_jbd2.h         |   7 +
 fs/ext4/extents.c           | 145 +++++---
 fs/ext4/extents_status.c    |  39 ++-
 fs/ext4/extents_status.h    |   4 +-
 fs/ext4/file.c              |  19 +-
 fs/ext4/ialloc.c            |   5 +
 fs/ext4/inode.c             | 638 +++++++++++++++++++++++++++++-------
 fs/ext4/move_extent.c       |  35 ++
 fs/ext4/page-io.c           | 107 ++++++
 fs/ext4/super.c             |   3 +
 fs/iomap/buffered-io.c      |   7 +-
 fs/iomap/trace.h            |  43 ++-
 include/linux/pagemap.h     |  13 +
 include/trace/events/ext4.h |  31 +-
 mm/readahead.c              |   6 +-
 17 files changed, 921 insertions(+), 201 deletions(-)

-- 
2.39.2


