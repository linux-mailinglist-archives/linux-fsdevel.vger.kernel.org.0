Return-Path: <linux-fsdevel+bounces-16574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EAF89FA20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313C71F24049
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5414C16F853;
	Wed, 10 Apr 2024 14:38:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABE16E861;
	Wed, 10 Apr 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759912; cv=none; b=BcgZ4BnuKf3bjUD2eaw2+osqKRZ2t3Yp9XT3V5dxAj1d6tXtQOvDVHD6ziN4EL09UOXR+t2w+SS8THX+E5TBnR6M0DpzWszEsyMwzCnM5N+IlIIgA3+fyKq3GfBuhGqz7/uL8dub9USoVNrHZEyLgRW92676qFvqOpCEOI/7PFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759912; c=relaxed/simple;
	bh=NI3hafwnkJ6oUCdoMETsCzPIX2o4YWf6XB410k1+oek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+V6S2xYkq1ojaQpyP5s5+VrC8B5KabkWF3WYaqL9QzwihXKlUtm2l5xYPcZZe6xzqqm0MIPdyUgpREwBZh8WM/+2j613bW8Bv69qEbJB7QGzX1NtOCdpnm0YwIRXY1/WJyymMsfpxZqjpz+YYb2lnp+dV9szwuCVb5Rwkww6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF56L6y6Gz4f3kG1;
	Wed, 10 Apr 2024 22:38:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C995E1A0175;
	Wed, 10 Apr 2024 22:38:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S4;
	Wed, 10 Apr 2024 22:38:25 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RESEND RFC PATCH v4 00/34] ext4: use iomap for regular file's buffered IO path and enable large folio
Date: Wed, 10 Apr 2024 22:29:14 +0800
Message-Id: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S4
X-Coremail-Antispam: 1UD129KBjvJXoWfGFyDKw47WryxZF4UtF13urg_yoWDtrykpF
	WakF13tr1kWw1UuaykAw1Utr40g3W5XF4UGw1fW3y8ZF4DCFyxuFn7KF4F9FW5ArW7Ja4Y
	vF4Iy348uayvk37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
	6cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0pRDKIiUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hello!

This is the fourth version of RFC patch series that convert ext4 regular
file's buffered IO path to iomap and enable large folio. I've rebased it
on 6.9-rc3, it also **depends on my xfs/iomap fix series** which has
been reviewed but not merged yet[1]. Compared to the third vesion, this
iteration fixes an issue discovered in current ext4 code, and contains
another two main changes, 1) add bigalloc support and 2) simplify the
updating logic of reserved delalloc data block, both changes could be
sent out as preliminary patch series, besides these, others are some
small code cleanups, performance optimize and commit log improvements.
Please take a look at this series and any comments are welcome.

This series supports ext4 with the default features and mount
options(bigalloc is also supported), doesn't support non-extent(ext3),
inline_data, dax, fs_verity, fs_crypt and data=journal mode, ext4 would
fall back to buffer_head path automatically if you enabled those
features or options. Although it has many limitations now, it can satisfy
the requirements of most common cases and bring a significant performance
benefit for large IOs.

The iomap path would be simpler than the buffer_head path to some extent,
please note that there are 4 major differences:
1. Always allocate unwritten extent for new blocks, it means that it's
   not controlled by dioread_nolock mount option.
2. Since 1, there is no risk of exposing stale data during the append
   write, so we don't need to write back data before metadata, it's time
   to drop 'data = ordered' mode automatically.
3. Since 2, we don't need to reserve journal credits and use reserved
   handle for the extent status conversion during writeback.
4. We could postpone updating the i_disksize to the endio, it could
   avoid exposing zero data during append write and instantaneous power
   failure.

Series details:
Patch 1-9: this is the part 2 preparation series, it fix a problem
first, and makes ext4_insert_delayed_block() call path support inserting
multiple delalloc blocks (also support bigalloc), finally make
ext4_da_map_blocks() buffer_head unaware, I've send it out separately[2]
and hope this could be merged first.

Patch 10-19: this is the part 3 prepartory changes(picked out from my
metadata reservation series[3], these are not a strong dependency
patches, but I'd suggested these could be merged before the iomap
conversion). These patches moves ext4_da_update_reserve_space() to
ext4_es_insert_extent(), and always set EXT4_GET_BLOCKS_DELALLOC_RESERVE
when allocating delalloc blocks, no matter it's from delayed allocate or
non-delayed allocate (fallocate) path, it makes delalloc extents always
delonly. These can make delalloc reservation simpler and cleaner than
before.

Patch 20-34: These patches are the main implements of the buffered IO
iomap conversion, It first introduce a sequence counter for extent
status tree, then add a new iomap aops for read, write, mmap, replace
current buffered_head path. Finally, enable iomap path besides inline
data, non-extent, dax, fs_verity, fs_crypt, defrag and data=journal
mode, if user specify "buffered_iomap" mount option, also enable large
folio. Please look at the following patch for details.

About Tests:
 - Pass kvm-xfstests in auto mode, and the keep running stress tests and
   fault injection tests.
 - A performance tests below (tested on my version 3 series,
   theoretically there won't be much difference in this version).

   Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU
   with 400GB system ram, 200GB ramdisk and 1TB nvme ssd disk.

   == buffer read ==

                  buffer head        iomap + large folio
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

                                        buffer head  iomap + large folio
   type   Overwrite Sync Writeback bs   IOPS   BW    IOPS   BW
   ------------------------------------------------------------
   cache    N       N    N         4K   395k   1544  415k   1621
   cache    N       N    N         64K  30.8k  1928  80.1k  5005
   cache    N       N    N         1M   1963   1963  5641   5642
   cache    Y       N    N         4K   423k   1652  443k   1730
   cache    Y       N    N         64K  33.0k  2063  80.8k  5051
   cache    Y       N    N         1M   2103   2103  5588   5589
   ramdisk  N       N    Y         4K   362k   1416  307k   1198
   ramdisk  N       N    Y         64K  22.4k  1399  64.8k  4050
   ramdisk  N       N    Y         1M   1670   1670  4559   4560
   ramdisk  N       Y    N         4K   9830   38.4  13.5k  52.8
   ramdisk  N       Y    N         64K  5834   365   10.1k  629
   ramdisk  N       Y    N         1M   1011   1011  2064   2064
   ramdisk  Y       N    Y         4K   397k   1550  409k   1598
   ramdisk  Y       N    Y         64K  29.2k  1827  73.6k  4597
   ramdisk  Y       N    Y         1M   1837   1837  4985   4985
   ramdisk  Y       Y    N         4K   173k   675   182k   710
   ramdisk  Y       Y    N         64K  17.7k  1109  33.7k  2105
   ramdisk  Y       Y    N         1M   1128   1129  1790   1791
   nvme     N       N    Y         4K   298k   1164  290k   1134
   nvme     N       N    Y         64K  21.5k  1343  57.4k  3590
   nvme     N       N    Y         1M   1308   1308  3664   3664
   nvme     N       Y    N         4K   10.7k  41.8  12.0k  46.9
   nvme     N       Y    N         64K  5962   373   8598   537
   nvme     N       Y    N         1M   676    677   1417   1418
   nvme     Y       N    Y         4K   366k   1430  373k   1456
   nvme     Y       N    Y         64K  26.7k  1670  56.8k  3547
   nvme     Y       N    Y         1M   1745   1746  3586   3586
   nvme     Y       Y    N         4K   59.0k  230   61.2k  239
   nvme     Y       Y    N         64K  13.0k  813   21.0k  1311
   nvme     Y       Y    N         1M   683    683   1368   1369
 
TODO
 - Keep on doing stress tests and fixing.
 - Reserve enough space for delalloc metadata blocks and try to drop
   ext4_nonda_switch().
 - First support defrag and then support other more unsupported features
   and mount options.

Changes since v3:
 - Drop the part 1 prepartory patches which have been merged [4].
 - Drop the two iomap patches since I've submitted separately [1].
 - Fix an incorrect reserved delalloc blocks count and incorrect extent
   status cache issue found on current ext4 code.
 - Pick out part 2 prepartory patch series [2], it make
   ext4_insert_delayed_block() call path support inserting multiple
   delalloc blocks (also support bigalloc )and make ext4_da_map_blocks()
   buffer_head unaware.
 - Adjust and simplify the reserved delalloc blocks updating logic,
   preparing for reserving meta data blocks for delalloc.
 - Drop datasync dirty check in ext4_set_iomap() for buffered
   read/write, improves the concurrent performance on small I/Os.
 - Prevent always hold invalid_lock in page_cache_ra_order(), add
   lockless check.
 - Disable iomap path by default since it's experimental new, add a
   mount option "buffered_iomap" to enable it.
 - Some other minor fixes and change log improvements.
Changes since v2:
 - Update patch 1-6 to v3.
 - iomap_zero and iomap_unshare don't need to update i_size and call
   iomap_write_failed(), introduce a new helper iomap_write_end_simple()
   to avoid doing that.
 - Factor out ext4_[ext|ind]_map_blocks() parts from ext4_map_blocks(),
   introduce a new helper ext4_iomap_map_one_extent() to allocate
   delalloc blocks in writeback, which is always under i_data_sem in
   write mode. This is done to prevent the writing back delalloc
   extents become stale if it raced by truncate.
 - Add a lock detection in mapping_clear_large_folios().
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
 - Update patch 1-6 to v2.

[1] https://lore.kernel.org/linux-xfs/20240320110548.2200662-1-yi.zhang@huaweicloud.com/
[2] https://lore.kernel.org/linux-ext4/20240410034203.2188357-1-yi.zhang@huaweicloud.com/
[3] https://lore.kernel.org/linux-ext4/20230824092619.1327976-1-yi.zhang@huaweicloud.com/
[4] https://lore.kernel.org/linux-ext4/20240105033018.1665752-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

---
v3: https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zhang@huaweicloud.com/

Zhang Yi (34):
  ext4: factor out a common helper to query extent map
  ext4: check the extent status again before inserting delalloc block
  ext4: trim delalloc extent
  ext4: drop iblock parameter
  ext4: make ext4_es_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_reserve_space() reserve multi-clusters
  ext4: factor out check for whether a cluster is allocated
  ext4: make ext4_insert_delayed_block() insert multi-blocks
  ext4: make ext4_da_map_blocks() buffer_head unaware
  ext4: factor out ext4_map_create_blocks() to allocate new blocks
  ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
  ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
  ext4: let __revise_pending() return newly inserted pendings
  ext4: count removed reserved blocks for delalloc only extent entry
  ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
  ext4: drop ext4_es_delayed_clu()
  ext4: use ext4_map_query_blocks() in ext4_map_blocks()
  ext4: drop ext4_es_is_delonly()
  ext4: drop all delonly descriptions
  ext4: use reserved metadata blocks when splitting extent on endio
  ext4: introduce seq counter for the extent status entry
  ext4: add a new iomap aops for regular file's buffered IO path
  ext4: implement buffered read iomap path
  ext4: implement buffered write iomap path
  ext4: implement writeback iomap path
  ext4: implement mmap iomap path
  ext4: implement zero_range iomap path
  ext4: writeback partial blocks before zeroing out range
  ext4: fall back to buffer_head path for defrag
  ext4: partial enable iomap for regular file's buffered IO path
  filemap: support disable large folios on active inode
  ext4: enable large folio for regular file with iomap buffered IO path
  ext4: don't mark IOMAP_F_DIRTY for buffer write
  ext4: add mount option for buffered IO iomap path

-- 
2.39.2


