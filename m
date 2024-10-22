Return-Path: <linux-fsdevel+bounces-32548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC39A9698
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5591C21F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8EA13B79F;
	Tue, 22 Oct 2024 03:12:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25713D2A9;
	Tue, 22 Oct 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566779; cv=none; b=ZtyXQTHy8YLwCgGPAGcYDn0sfWtxdNH/FwcEPZKpHa+HI8oqsmHlXfcBMtkgDkILpP5WVwaFa670LoNudi3jMzS/69QvKf2T13diUSEiUB3mgIo+7zNjzN3RThV+4WnTACEisKM4JFKXMCLytJtesMOcuuX/dRwHoF4UQVVtJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566779; c=relaxed/simple;
	bh=se5QES22WA+gnVbOrSXmHMLpsGS4RvQGMsN3qT4K+ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5nuhzLxCSdJod3AUW/QrQ5R0pEqH7Ehtg5E6h6KKqpe2alTc5ww4zhKq0OM4JMUYu920GJUzNE63bqIH0pRYBq2EPzKUMlxC9YFwxUFX/CQRHBq2T2+7OciXAa60ux+msAxcMWEX7hCFaV9NFhITfkX9fQe6FGCHl42fGIOr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcg30D70z4f3lVg;
	Tue, 22 Oct 2024 11:12:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 325691A06D7;
	Tue, 22 Oct 2024 11:12:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S4;
	Tue, 22 Oct 2024 11:12:47 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 00/27] ext4: use iomap for regular file's buffered I/O path and enable large folio
Date: Tue, 22 Oct 2024 19:10:31 +0800
Message-ID: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWfur1kKF4DXFWftFWUJwb_yoWfWF1xpF
	Wakr1fKrn7W347ua97Cw1xtr1Yya1rGFW5ua1xW3y09F15Cry8ZFn2gF4F9Fy3ArWxJFyY
	vrW0vry8Ga45A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRtEfnUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Hello！

This patch series is the latest version based on my previous RFC
series[1], which converts the buffered I/O path of ext4 regular files to
iomap and enables large folios. After several months of work, almost all
preparatory changes have been upstreamed, thanks a lot for the review
and comments from Jan, Dave, Christoph, Darrick and Ritesh. Now it is
time for the main implementation of this conversion. 

This series is the main part of iomap buffered iomap conversion, it's
based on 6.12-rc4, and the code context is also depend on my anohter
cleanup series[1] (I've put that in this seris so we can merge it
directly), fixed all minor bugs found in my previous RFC v4 series.
Additionally, I've update change logs in each patch and also includes
some code modifications as Dave's suggestions. This series implements
the core iomap APIs on ext4 and introduces a mount option called
"buffered_iomap" to enable the iomap buffered I/O path. We have already
supported the default features, default mount options and bigalloc
feature. However, we do not yet support online defragmentation, inline
data, fs_verify, fs_crypt, ext3, and data=journal mode, ext4 will fall
to buffered_head I/O path automatically if you use those features and
options. Some of these features should be supported gradually in the
near future.

Most of the implementations resemble the original buffered_head path;
however, there are four key differences.

1. The first aspect is the block allocation in the writeback path. The
   iomap frame will invoke ->map_blocks() at least once for each dirty
   folio. To ensure optimal writeback performance, we aim to allocate a
   range of delalloc blocks that is as long as possible within the
   writeback length for each invocation. In certain situations, we may
   allocate a range of blocks that exceeds the amount we will actually
   write back. Therefore,
1) we cannot allocate a written extent for those blocks because it may
   expose stale data in such short write cases. Instead, we should
   allocate an unwritten extent, which means we must always enable the
   dioread_nolock option. This change could also bring many other
   benefits.
2) We should postpone updating the 'i_disksize' until the end of the I/O
   process, based on the actual written length. This approach can also
   prevent the exposure of zero data, which may occur if there is a
   power failure during an append write.
3) We do not need to pre-split extents during write-back, we can
   postpone this task until the end I/O process while converting
   unwritten extents.

2. The second reason is that since we always allocate unwritten space
   for new blocks, there is no risk of exposing stale data. As a result,
   we do not need to order the data, which allows us to disable the
   data=ordered mode. Consequently, we also do not require the reserved
   handle when converting the unwritten extent in the final I/O worker,
   we can directly start with the normal handle.

Series details:

Patch 1-10 is just another series of mine that refactors the fallocate
functions[1]. This series relies on the code context of that but has no
logical dependencies. I put this here just for easy access and merge.

Patch 11-21 implement the iomap buffered read/write path, dirty folio
write back path and mmap path for ext4 regular file. 

Patch 22-23 disable the unsupported online-defragmentation function and
disable the changing of the inode journal flag to data=journal mode.
Please look at the following patch for details.

Patch 24-27 introduce "buffered_iomap" mount option (is not enabled by
default now) to partially enable the iomap buffered I/O path and also
enable large folio.


About performance:

Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU with
400GB system ram, 200GB ramdisk and 4TB nvme ssd disk.

 fio -directory=/mnt -direct=0 -iodepth=$iodepth -fsync=$sync -rw=$rw \
     -numjobs=${numjobs} -bs=${bs} -ioengine=psync -size=$size \
     -runtime=60 -norandommap=0 -fallocate=none -overwrite=$overwrite \
     -group_reportin -name=$name --output=/tmp/test_log

 == buffer read ==

                buffer_head        iomap + large folio
 type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
 -------------------------------------------------------
 hole     4K    576k    2253       762k    2975     +32%
 hole     64K   48.7k   3043       77.8k   4860     +60%
 hole     1M    2960    2960       4942    4942     +67%
 ramdisk  4K    443k    1732       530k    2069     +19%
 ramdisk  64K   34.5k   2156       45.6k   2850     +32%
 ramdisk  1M    2093    2093       2841    2841     +36%
 nvme     4K    339k    1323       364k    1425     +8%
 nvme     64K   23.6k   1471       25.2k   1574     +7%
 nvme     1M    2012    2012       2153    2153     +7%


 == buffer write ==

                                       buffer_head  iomap + large folio
 type   Overwrite Sync Writeback  bs   IOPS   BW    IOPS   BW(MiB/s)
 ----------------------------------------------------------------------
 cache      N    N    N    4K     417k    1631    440k    1719   +5%
 cache      N    N    N    64K    33.4k   2088    81.5k   5092   +144%
 cache      N    N    N    1M     2143    2143    5716    5716   +167%
 cache      Y    N    N    4K     449k    1755    469k    1834   +5%
 cache      Y    N    N    64K    36.6k   2290    82.3k   5142   +125%
 cache      Y    N    N    1M     2352    2352    5577    5577   +137%
 ramdisk    N    N    Y    4K     365k    1424    354k    1384   -3%
 ramdisk    N    N    Y    64K    31.2k   1950    74.2k   4640   +138%
 ramdisk    N    N    Y    1M     1968    1968    5201    5201   +164%
 ramdisk    N    Y    N    4K     9984    39      12.9k   51     +29%
 ramdisk    N    Y    N    64K    5936    371     8960    560    +51%
 ramdisk    N    Y    N    1M     1050    1050    1835    1835   +75%
 ramdisk    Y    N    Y    4K     411k    1609    443k    1731   +8%
 ramdisk    Y    N    Y    64K    34.1k   2134    77.5k   4844   +127%
 ramdisk    Y    N    Y    1M     2248    2248    5372    5372   +139%
 ramdisk    Y    Y    N    4K     182k    711     186k    730    +3%
 ramdisk    Y    Y    N    64K    18.7k   1170    34.7k   2171   +86%
 ramdisk    Y    Y    N    1M     1229    1229    2269    2269   +85%
 nvme       N    N    Y    4K     373k    1458    387k    1512   +4%
 nvme       N    N    Y    64K    29.2k   1827    70.9k   4431   +143%
 nvme       N    N    Y    1M     1835    1835    4919    4919   +168%
 nvme       N    Y    N    4K     11.7k   46      11.7k   46      0%
 nvme       N    Y    N    64K    6453    403     8661    541    +34%
 nvme       N    Y    N    1M     649     649     1351    1351   +108%
 nvme       Y    N    Y    4K     372k    1456    433k    1693   +16%
 nvme       Y    N    Y    64K    33.0k   2064    74.7k   4669   +126%
 nvme       Y    N    Y    1M     2131    2131    5273    5273   +147%
 nvme       Y    Y    N    4K     56.7k   222     56.4k   220    -1%
 nvme       Y    Y    N    64K    13.4k   840     19.4k   1214   +45%
 nvme       Y    Y    N    1M     714     714     1504    1504   +111%

Thanks,
Yi.

Major changes since RFC v4:
 - Disable unsupported online defragmentation, do not fall back to
   buffer_head path.
 - Wite and wait data back while doing partial block truncate down to
   fix a stale data problem.
 - Disable the online changing of the inode journal flag to data=journal
   mode.
 - Since iomap can zero out dirty pages with unwritten extent, do not
   write data before zeroing out in ext4_zero_range(), and also do not
   zero partial blocks under a started journal handle.

[1] https://lore.kernel.org/linux-ext4/20241010133333.146793-1-yi.zhang@huawei.com/

---
RFC v4: https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zhang@huaweicloud.com/
RFC v3: https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
RFC v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zhang@huaweicloud.com/
RFC v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zhang@huaweicloud.com/


Zhang Yi (27):
  ext4: remove writable userspace mappings before truncating page cache
  ext4: don't explicit update times in ext4_fallocate()
  ext4: don't write back data before punch hole in nojournal mode
  ext4: refactor ext4_punch_hole()
  ext4: refactor ext4_zero_range()
  ext4: refactor ext4_collapse_range()
  ext4: refactor ext4_insert_range()
  ext4: factor out ext4_do_fallocate()
  ext4: move out inode_lock into ext4_fallocate()
  ext4: move out common parts into ext4_fallocate()
  ext4: use reserved metadata blocks when splitting extent on endio
  ext4: introduce seq counter for the extent status entry
  ext4: add a new iomap aops for regular file's buffered IO path
  ext4: implement buffered read iomap path
  ext4: implement buffered write iomap path
  ext4: don't order data for inode with EXT4_STATE_BUFFERED_IOMAP
  ext4: implement writeback iomap path
  ext4: implement mmap iomap path
  ext4: do not always order data when partial zeroing out a block
  ext4: do not start handle if unnecessary while partial zeroing out a
    block
  ext4: implement zero_range iomap path
  ext4: disable online defrag when inode using iomap buffered I/O path
  ext4: disable inode journal mode when using iomap buffered I/O path
  ext4: partially enable iomap for the buffered I/O path of regular
    files
  ext4: enable large folio for regular file with iomap buffered I/O path
  ext4: change mount options code style
  ext4: introduce a mount option for iomap buffered I/O path

 fs/ext4/ext4.h              |  17 +-
 fs/ext4/ext4_jbd2.c         |   3 +-
 fs/ext4/ext4_jbd2.h         |   8 +
 fs/ext4/extents.c           | 568 +++++++++++----------------
 fs/ext4/extents_status.c    |  13 +-
 fs/ext4/file.c              |  19 +-
 fs/ext4/ialloc.c            |   5 +
 fs/ext4/inode.c             | 755 ++++++++++++++++++++++++++++++------
 fs/ext4/move_extent.c       |   7 +
 fs/ext4/page-io.c           | 105 +++++
 fs/ext4/super.c             | 185 ++++-----
 include/trace/events/ext4.h |  57 +--
 12 files changed, 1153 insertions(+), 589 deletions(-)

-- 
2.46.1


