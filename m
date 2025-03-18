Return-Path: <linux-fsdevel+bounces-44273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C006A66C71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07B7189B4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9511F8729;
	Tue, 18 Mar 2025 07:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123091A7045;
	Tue, 18 Mar 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283855; cv=none; b=Sj2feCxvuPNzQSiv7UAMT/smYncMLdyw/sF+oieoVYW8htSBm2ETLuUvWt+EV4f7NSBFgcIp4stfmMEdOQ6KzawzJfA8iEM/GwbEEwQtWeqlojMvjmft2B5UUYOrvRhbdjgXio84l0/xVJthUnH0EzSNCeK0Vvky9/i0MPTjV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283855; c=relaxed/simple;
	bh=D62hU0UbBe50hVmwESXBSTMdGOW2ppQgTS0YlGm3+5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvhCP+u5h1p7ZRYq2ojmkaHRCW9xCiODdlRWZuDqug3Kjz3vndd5lcmnNQmrjWrDP7M5e5kaqREFke3/Q7aP1S446otH/bF3fl/lxqKSawWXK9ysrj7wLmLgYhPyrTeVTp+Isg4V/LpiDFvDBlDs8F/Sv69SNSEQa7UJDrS40A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kB73R6z4f3khd;
	Tue, 18 Mar 2025 15:43:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9215A1A058E;
	Tue, 18 Mar 2025 15:44:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S4;
	Tue, 18 Mar 2025 15:44:07 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH -next v3 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Date: Tue, 18 Mar 2025 15:35:35 +0800
Message-ID: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH6189JNlnEt1YGw--.55732S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy3AryrZF43Zr4UAFW5KFg_yoW3tryfpa
	y8XryYkryDKryxC3s3ua1I9ryrZws5ArW3Gw4xK34UuFZ8ZF1xKFs2ga4Yqa9rZFyxW3WD
	XFsF9r9ru3W7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjTRMv31DUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since RFC v2:
 - Rebase codes on next-20250314.
 - Add support for nvme multipath.
 - Add support for NVMeT with block device backing.
 - Clear FALLOC_FL_WRITE_ZEROES if dm clear
   limits->max_write_zeroes_sectors.
 - Complement the counterpart userspace tools(util-linux and xfs_io)
   and tests(blktests and xfstests), please see below for details.
Changes since RFC v1:
 - Switch to add a new write zeroes operation, FALLOC_FL_WRITE_ZEROES,
   in fallocate, instead of just adding a supported flag to
   FALLOC_FL_ZERO_RANGE.
 - Introduce a new flag BLK_FEAT_WRITE_ZEROES_UNMAP to the block
   device's queue limit features, and implement it on SCSI sd driver,
   NVMe SSD driver and dm driver.
 - Implement FALLOC_FL_WRITE_ZEROES on both the ext4 filesystem and
   block device (bdev).

RFC v2: https://lore.kernel.org/linux-fsdevel/20250115114637.2705887-1-yi.zhang@huaweicloud.com/
RFC v1: https://lore.kernel.org/linux-fsdevel/20241228014522.2395187-1-yi.zhang@huaweicloud.com/

The counterpart userspace tools changes and tests are here:
 - util-linux: https://lore.kernel.org/linux-fsdevel/20250318073218.3513262-1-yi.zhang@huaweicloud.com/ 
 - xfsprogs: https://lore.kernel.org/linux-fsdevel/20250318072318.3502037-1-yi.zhang@huaweicloud.com/
 - xfstests: https://lore.kernel.org/linux-fsdevel/20250318072615.3505873-1-yi.zhang@huaweicloud.com/
 - blktests: https://lore.kernel.org/linux-fsdevel/20250318072835.3508696-1-yi.zhang@huaweicloud.com/

Currently, we can use the fallocate command to quickly create a
pre-allocated file. However, on most filesystems, such as ext4 and XFS,
fallocate create pre-allocation blocks in an unwritten state, and the
FALLOC_FL_ZERO_RANGE flag also behaves similarly. The extent state must
be converted to a written state when the user writes data into this
range later, which can trigger numerous metadata changes and consequent
journal I/O. This may leads to significant write amplification and
performance degradation in synchronous write mode. Therefore, we need a
method to create a pre-allocated file with written extents that can be
used for pure overwriting. At the monent, the only method available is
to create an empty file and write zero data into it (for example, using
'dd' with a large block size). However, this method is slow and consumes
a considerable amount of disk bandwidth, we must pre-allocate files in
advance but cannot add pre-allocated files while user business services
are running.

Fortunately, with the development and more and more widely used of
flash-based storage devices, we can efficiently write zeros to SSDs
using the unmap write zeroes command if the devices do not write
physical zeroes to the media. For example, if SCSI SSDs support the
UMMAP bit or NVMe SSDs support the DEAC bit[1], the write zeroes command
does not write actual data to the device, instead, NVMe converts the
zeroed range to a deallocated state, which works fast and consumes
almost no disk write bandwidth. Consequently, this feature can provide
us with a faster method for creating pre-allocated files with written
extents and zeroed data.

This series aims to implement this by:
1. Introduce a new feature BLK_FEAT_WRITE_ZEROES_UNMAP to the block
   device queue limit features, which indicates whether the storage is
   device explicitly supports the unmapped write zeroes command. This
   flag should be set to 1 by the driver if the attached disk supports
   this command. Users can check this flag by querying:

       /sys/block/<disk>/queue/write_zeroes_unmap

2. Introduce a new flag FALLOC_FL_WRITE_ZEROES into the fallocate,
   filesystems with this operaion should allocate written extents and
   issuing zeroes to the range of the device. If the device supports
   unmap write zeroes command, the zeroing can be accelerated, if not,
   we currently still allow to fall back to submit zeroes data. Users
   can verify if the device supports the unmap write zeroes command and
   then decide whether to use it.

This series implemented the BLK_FEAT_WRITE_ZEROES_UNMAP flag for SCSI,
NVMe and device-mapper drivers, and added the FALLOC_FL_WRITE_ZEROES
support for ext4 and raw bdev devices. Any comments are welcome.

I've tested performance with this series on ext4 filesystem on my
machine with an Intel Xeon Gold 6248R CPU, a 7TB KCD61LUL7T68 NVMe SSD
which supports unmap write zeroes command with the Deallocated state
and the DEAC bit. Feel free to give it a try.

0. Ensure the NVMe device supports WRITE_ZERO command.

 $ cat /sys/block/nvme5n1/queue/write_zeroes_max_bytes
   8388608
 $ nvme id-ns -H /dev/nvme5n1 | grep -i -A 3 "dlfeat"
   dlfeat  : 25
   [4:4] : 0x1   Guard Field of Deallocated Logical Blocks is set to CRC
                 of The Value Read
   [3:3] : 0x1   Deallocate Bit in the Write Zeroes Command is Supported
   [2:0] : 0x1   Bytes Read From a Deallocated Logical Block and its
                 Metadata are 0x00

1. Compare 'dd' and fallocate with unmap write zeroes, the later one is
   significantly faster than 'dd'.

   Create a 1GB and 10GB zeroed file.
    $dd if=/dev/zero of=foo bs=2M count=$count oflag=direct
    $time fallocate -w -l $size bar

    #1G
    dd:                     0.5s
    FALLOC_FL_WRITE_ZEROES: 0.17s

    #10G
    dd:                     5.0s
    FALLOC_FL_WRITE_ZEROES: 1.7s

2. Run fio overwrite and fallocate with unmap write zeroes
   simultaneously, fallocate has little impact on write bandwidth and
   only slightly affects write latency.

 a) Test bandwidth costs.
  $ fio -directory=/test -direct=1 -iodepth=10 -fsync=0 -rw=write \
        -numjobs=10 -bs=2M -ioengine=libaio -size=20G -runtime=20 \
        -fallocate=none -overwrite=1 -group_reportin -name=bw_test

   Without background zero range:
    bw (MiB/s): min= 2068, max= 2280, per=100.00%, avg=2186.40

   With background zero range:
    bw (MiB/s): min= 2056, max= 2308, per=100.00%, avg=2186.20

 b) Test write latency costs.
  $ fio -filename=/test/foo -direct=1 -iodepth=1 -fsync=0 -rw=write \
        -numjobs=1 -bs=4k -ioengine=psync -size=5G -runtime=20 \
        -fallocate=none -overwrite=1 -group_reportin -name=lat_test

   Without background zero range:
   lat (nsec): min=9269, max=71635, avg=9840.65

   With a background zero range:
   lat (usec): min=9, max=982, avg=11.03

3. Compare overwriting in a pre-allocated unwritten file and a written
   file in O_DSYNC mode. Write to a file with written extents is much
   faster.

  # First mkfs and create a test file according to below three cases,
  # and then run fio.

  $ fio -filename=/test/foo -direct=1 -iodepth=1 -fdatasync=1 \
        -rw=write -numjobs=1 -bs=4k -ioengine=psync -size=5G \
        -runtime=20 -fallocate=none -group_reportin -name=test

   unwritten file:                 IOPS=20.1k, BW=78.7MiB/s
   unwritten file + fast_commit:   IOPS=42.9k, BW=167MiB/s
   written file:                   IOPS=98.8k, BW=386MiB/s

Thanks,
Yi.

---

[1] https://nvmexpress.org/specifications/
    NVM Command Set Specification, section 3.2.8

Zhang Yi (10):
  block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
  nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports DEAC bit
  nvme-multipath: add BLK_FEAT_WRITE_ZEROES_UNMAP support
  nvmet: set WZDS and DRB if device supports BLK_FEAT_WRITE_ZEROES_UNMAP
  scsi: sd: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports unmap
    zeroing mode
  dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
  fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
  block: add FALLOC_FL_WRITE_ZEROES support
  block: factor out common part in blkdev_fallocate()
  ext4: add FALLOC_FL_WRITE_ZEROES support

 Documentation/ABI/stable/sysfs-block | 14 +++++++
 block/blk-settings.c                 |  6 +++
 block/blk-sysfs.c                    |  3 ++
 block/fops.c                         | 37 +++++++++--------
 drivers/md/dm-table.c                |  7 +++-
 drivers/md/dm.c                      |  1 +
 drivers/nvme/host/core.c             | 21 +++++-----
 drivers/nvme/host/multipath.c        |  3 +-
 drivers/nvme/target/io-cmd-bdev.c    |  4 ++
 drivers/scsi/sd.c                    |  5 +++
 fs/ext4/extents.c                    | 59 ++++++++++++++++++++++------
 fs/open.c                            |  1 +
 include/linux/blkdev.h               |  8 ++++
 include/linux/falloc.h               |  3 +-
 include/trace/events/ext4.h          |  3 +-
 include/uapi/linux/falloc.h          | 18 +++++++++
 16 files changed, 149 insertions(+), 44 deletions(-)

-- 
2.46.1


