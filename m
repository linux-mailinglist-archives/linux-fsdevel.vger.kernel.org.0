Return-Path: <linux-fsdevel+bounces-50560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A9BACD553
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742AD1899706
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A219066B;
	Wed,  4 Jun 2025 02:21:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C63594F;
	Wed,  4 Jun 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003708; cv=none; b=bgXPQWNwlx/9900vEUcKEDcRZ6+LENSAnMgKW/cah8gSvh2C4sOBnLVYETaHnc/xWvaA5ra8NT1n5Bp0n6UYWLtwo86xjQ7Eb5nTJxPl16zO62SCwbaqbWS18PdxsvH94VCmmhdu124X1AANf/FokD1IkRj09Yd5p4yGxC7Qedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003708; c=relaxed/simple;
	bh=xhZvMESc55g+qRWJ4xx7cgzusA78J8NvqvJvA/N9ZVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z929S5qBs8EjuVYtupPe2Xhbn4PgG2DsUTYwYCGpu9YZIvTZ70Qc56hkKGnfzOgJ6AuzLUHd0EU7R3Tidp7NJLn9mTbs9wJoD58Sc4vdJqRImfpSbTDG9WMyRjtjzeylznPp7gfIuTMVBPjtGcsNgb7EtVgVkvPSVBB6DV4nDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBrtc2hzRzKHN3y;
	Wed,  4 Jun 2025 10:21:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B8D641A0A0D;
	Wed,  4 Jun 2025 10:21:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+nrT9oedfBOQ--.14997S4;
	Wed, 04 Jun 2025 10:21:40 +0800 (CST)
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
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Date: Wed,  4 Jun 2025 10:08:40 +0800
Message-ID: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+nrT9oedfBOQ--.14997S4
X-Coremail-Antispam: 1UD129KBjvJXoW3ZFWxXw17Cr45Ww1rCw1xXwb_yoWDWrW8pa
	yUXF4Ykr1DKryxC3s3ua1I9ryrZws5AFW3Gw4Ik34UZFZ8XF1xKFs2ga4Yva9rJFyxW3WD
	XFsrKr9rua47A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since RFC v4:
 - Rebase codes on 6.16-rc1.
 - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
   interface to RW mode. User can disable the unmap write zeroes
   operation by writing '0' to it when the operation is slow.
 - Modify the documentation of write_zeroes_unmap sysfs interface as
   Martin suggested.
 - Remove the statx interface.
 - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
   if the block device does not enable the unmap write zeroes operation,
   it should return -EOPNOTSUPP.
Changes sicne RFC v3:
 - Rebase codes on 6.15-rc2.
 - Add a note in patch 1 to indicate that the unmap write zeros command
   is not always guaranteed as Christoph suggested.
 - Rename bdev_unmap_write_zeroes() helper and move it to patch 1 as
   Christoph suggested.
 - Introduce a new statx attribute flag STATX_ATTR_WRITE_ZEROES_UNMAP as
   Christoph and Christian suggested.
 - Exchange the order of the two patches that modified
   blkdev_fallocate() as Christoph suggested.
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

RFC v4: https://lore.kernel.org/linux-fsdevel/20250421021509.2366003-1-yi.zhang@huaweicloud.com/
RFC v3: https://lore.kernel.org/linux-fsdevel/20250318073545.3518707-1-yi.zhang@huaweicloud.com/
RFC v2: https://lore.kernel.org/linux-fsdevel/20250115114637.2705887-1-yi.zhang@huaweicloud.com/
RFC v1: https://lore.kernel.org/linux-fsdevel/20241228014522.2395187-1-yi.zhang@huaweicloud.com/

The counterpart userspace tools changes and tests are here:
 - util-linux: https://lore.kernel.org/linux-fsdevel/20250318073218.3513262-1-yi.zhang@huaweicloud.com/ 
 - xfsprogs: https://lore.kernel.org/linux-fsdevel/20250318072318.3502037-1-yi.zhang@huaweicloud.com/
 - xfstests: https://lore.kernel.org/linux-fsdevel/20250318072615.3505873-1-yi.zhang@huaweicloud.com/
 - blktests: https://lore.kernel.org/linux-fsdevel/20250318072835.3508696-1-yi.zhang@huaweicloud.com/

Original Description:

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
extents and zeroed data. However, please note that this may be a
best-effort optimization rather than a mandatory requirement, some
devices may partially fall back to writing physical zeroes due to
factors such as receiving unaligned commands. 

This series aims to implement this by:
1. Introduce a new feature BLK_FEAT_WRITE_ZEROES_UNMAP to the block
   device queue limit features, which indicates whether the storage is
   device explicitly supports the unmapped write zeroes command. This
   flag should be set to 1 by the driver if the attached disk supports
   this command.

2. Introduce a queue limit flag, BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED,
   along with a corresponding sysfs entry. Users can query the support
   status of the unmap write zeroes operation and disable this operation
   if the write zeroes operation is very slow.

       /sys/block/<disk>/queue/write_zeroes_unmap

3. Introduce a new flag, FALLOC_FL_WRITE_ZEROES, into the fallocate.
   Filesystems that support this operation should allocate written
   extents and issue zeroes to the specified range of the device. For
   local block device filesystems, this operation should depend on the
   write_zeroes_unmap operaion of the underlying block device. It should
   return -EOPNOTSUPP if the device doesn't enable unmap write zeroes
   operaion.

This series implements the BLK_FEAT_WRITE_ZEROES_UNMAP feature and
BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED flag for SCSI, NVMe and
device-mapper drivers, and add the FALLOC_FL_WRITE_ZEROES and
STATX_ATTR_WRITE_ZEROES_UNMAP support for ext4 and raw bdev devices.
Any comments are welcome.

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
    NVM Command Set Specification, Figure 82 and Figure 114.

Zhang Yi (10):
  block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
  nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports DEAC bit
  nvme-multipath: add BLK_FEAT_WRITE_ZEROES_UNMAP support
  nvmet: set WZDS and DRB if device supports BLK_FEAT_WRITE_ZEROES_UNMAP
  scsi: sd: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports unmap
    zeroing mode
  dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
  fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
  block: factor out common part in blkdev_fallocate()
  block: add FALLOC_FL_WRITE_ZEROES support
  ext4: add FALLOC_FL_WRITE_ZEROES support

 Documentation/ABI/stable/sysfs-block | 20 +++++++++
 block/blk-settings.c                 |  6 +++
 block/blk-sysfs.c                    | 25 +++++++++++
 block/fops.c                         | 44 +++++++++++--------
 drivers/md/dm-table.c                |  7 ++-
 drivers/md/dm.c                      |  1 +
 drivers/nvme/host/core.c             | 21 +++++----
 drivers/nvme/host/multipath.c        |  3 +-
 drivers/nvme/target/io-cmd-bdev.c    |  4 ++
 drivers/scsi/sd.c                    |  5 +++
 fs/ext4/extents.c                    | 66 +++++++++++++++++++++++-----
 fs/open.c                            |  1 +
 include/linux/blkdev.h               | 18 ++++++++
 include/linux/falloc.h               |  3 +-
 include/trace/events/ext4.h          |  3 +-
 include/uapi/linux/falloc.h          | 18 ++++++++
 16 files changed, 201 insertions(+), 44 deletions(-)

-- 
2.46.1


