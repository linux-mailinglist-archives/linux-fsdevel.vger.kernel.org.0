Return-Path: <linux-fsdevel+bounces-39283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D6A12324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE5A3A6815
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB73242278;
	Wed, 15 Jan 2025 11:52:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5624169C;
	Wed, 15 Jan 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941935; cv=none; b=NT9Y1XdCIG1Q/4Sp+9Lqj6AQeoSLIW3djg1DeVpr5lMfEfSxi47EwRHE7Zk3wnDtLQK+QNCPPS3TIEnsYMovjXQ4tUK++HWx/ETMiczvp4sAGx7dMQyVZhunFPsmvNixaRGex4pgZJg/HmqmrVgOJhzRKpuCwj2b9CiG+6zPhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941935; c=relaxed/simple;
	bh=w+cp6TaXaukmKvaQzWJQ8Yn4IwABLAP8m7ANk+ORhYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPIsomlSFjE0pdYMu0rFyeax+ubxjP8SbrACFl541w//iEuFVammbBcotwCdd2H+iHZ7eURjk0Bb+58af9yjHkb673FBWdHgDFMEuIA+jcaeHDWYYjUxtqYi0/bSBEpss1cnMxmYapmjGgrZ0TdiGqdtJ1/gBU41OAI3BDbpdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY49423xZz4f3jqw;
	Wed, 15 Jan 2025 19:51:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 785BC1A16E6;
	Wed, 15 Jan 2025 19:52:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S4;
	Wed, 15 Jan 2025 19:52:03 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v2 0/8] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Date: Wed, 15 Jan 2025 19:46:29 +0800
Message-Id: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9aoYdnvK0ZBA--.21959S4
X-Coremail-Antispam: 1UD129KBjvJXoW3tFW5AFyrKw1fur1DCrWruFg_yoWkWFyDpF
	Wjgr1UGrW5Kr1fC3Z7ua10gr15Zws5ArW3Gw4vg34UZa45WF1xKa1vgFyFg397XFWxW3WU
	XF43tFy3u3W7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUlYL9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Changes since v1:
 - Switch to add a new write zeroes operation, FALLOC_FL_WRITE_ZEROES,
   in fallocate, instead of just adding a supported flag to
   FALLOC_FL_ZERO_RANGE.
 - Introduce a new flag BLK_FEAT_WRITE_ZEROES_UNMAP to the block
   device's queue limit features, and implement it on SCSI sd driver,
   NVMe SSD driver and dm driver.
 - Implement FALLOC_FL_WRITE_ZEROES on both the ext4 filesystem and
   block device (bdev).

v1: https://lore.kernel.org/linux-fsdevel/20241228014522.2395187-1-yi.zhang@huaweicloud.com/

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
   flag should be set to 1 by the driver it the attached disk supports
   this command. Users can check this flag by querying:

       /sys/block/<disk>/queue/write_zeroes_unmap

2. Introduce a new flag FALLOC_FL_FORCE_ZERO into the fallocate,
   filesystems with this operaion should allocate written extents and
   issuing zeroes to the range of the device. If the device supports
   unmap write zeroes command, the zeroing can be accelerated, if not,
   we currently still allow to fall back to submit zeroes data. Users
   can verify if the device supports the unmap write zeroes command and
   then decide whether to use it.

I initially implemented the BLK_FEAT_WRITE_ZEROES_UNMAP flag for SCSI
and NVMe drivers, and I also added the FALLOC_FL_FORCE_ZERO flag for
ext4 and block devices. Any comments are welcome. Once the kernel
changes are finalized, I will do comprehensive tests, and update the
man page documentation, as well as the corresponding user-mode tools.

NOTE: this series is based on my ext4 fallocate refactor series[2] which
      hasn't been merged to the mainline yet.

I've briefly modified xfs_io and fallocate tool in util-linux[3], and
tested performance with this series on ext4 filesystem on my machine
with an Intel Xeon Gold 6248R CPU, a 7TB KCD61LUL7T68 NVMe SSD which
supports unmap write zeroes command with the Deallocated state and the
DEAC bit. Feel free to give it a try.

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

1. Compare 'dd' and fallocate with force zero range, the zero range is
   significantly faster than 'dd'.

 a) Create a 1GB zeroed file.
  $ dd if=/dev/zero of=foo bs=2M count=512 oflag=direct
    512+0 records in
    512+0 records out
    1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.504496 s, 2.1 GB/s

  $ time fallocate -Z -l 1G bar  # -Z is a new option to do actual zero
    real    0m0.171s
    user    0m0.001s
    sys     0m0.003s

 b) Create a 10GB zeroed file.
  $ dd if=/dev/zero of=foo bs=2M count=5120 oflag=direct  
    5120+0 records in
    5120+0 records out
    10737418240 bytes (11 GB, 10 GiB) copied, 5.04009 s, 2.1 GB/s

  $ time fallocate -Z -l 10G bar
    real    0m1.724s
    user    0m0.000s
    sys     0m0.024s

2. Run fio overwrite and fallocate with force zero range simultaneously,
   fallocate has little impact on write bandwidth and only slightly
   affects write latency.

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
[2] https://lore.kernel.org/linux-ext4/20241220011637.1157197-1-yi.zhang@huaweicloud.com/
[3] Here is a simple support of xfs_io and fallocate tool in util-linux.
    Feel free to give it a try.

1. util-linux
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index ac7c687f2..a2bfa8d39 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -66,6 +66,10 @@
 # define FALLOC_FL_INSERT_RANGE		0x20
 #endif
 
+#ifndef FALLOC_FL_WRITE_ZEROES
+# define FALLOC_FL_WRITE_ZEROES		0x80
+#endif
+
 #include "nls.h"
 #include "strutils.h"
 #include "c.h"
@@ -95,6 +99,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
 	fputs(_(" -p, --punch-hole     replace a range with a hole (implies -n)\n"), out);
 	fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
+	fputs(_(" -w, --write-zeroes   write zeroes and ensure allocation of a range\n"), out);
 #ifdef HAVE_POSIX_FALLOCATE
 	fputs(_(" -x, --posix          use posix_fallocate(3) instead of fallocate(2)\n"), out);
 #endif
@@ -305,6 +310,7 @@ int main(int argc, char **argv)
 	    { "dig-holes",      no_argument,       NULL, 'd' },
 	    { "insert-range",   no_argument,       NULL, 'i' },
 	    { "zero-range",     no_argument,       NULL, 'z' },
+	    { "write-zeroes",   no_argument,       NULL, 'w' },
 	    { "offset",         required_argument, NULL, 'o' },
 	    { "length",         required_argument, NULL, 'l' },
 	    { "posix",          no_argument,       NULL, 'x' },
@@ -313,9 +319,10 @@ int main(int argc, char **argv)
 	};
 
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
-		{ 'c', 'd', 'p', 'z' },
+		{ 'c', 'd', 'p', 'z', 'w' },
 		{ 'c', 'n' },
-		{ 'x', 'c', 'd', 'i', 'n', 'p', 'z'},
+		{ 'w', 'n' },
+		{ 'x', 'c', 'd', 'i', 'n', 'p', 'z', 'w'},
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -325,7 +332,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while ((c = getopt_long(argc, argv, "hvVncpdizxl:o:", longopts, NULL))
+	while ((c = getopt_long(argc, argv, "hvVncpdizwxl:o:", longopts, NULL))
 			!= -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -355,6 +362,9 @@ int main(int argc, char **argv)
 		case 'z':
 			mode |= FALLOC_FL_ZERO_RANGE;
 			break;
+		case 'w':
+			mode |= FALLOC_FL_WRITE_ZEROES;
+			break;
 		case 'x':
 #ifdef HAVE_POSIX_FALLOCATE
 			posix = 1;

2. xfs_io
diff --git a/io/prealloc.c b/io/prealloc.c
index 8e968c9f..96daf1a1 100644
--- a/io/prealloc.c
+++ b/io/prealloc.c
@@ -30,6 +30,10 @@
 #define FALLOC_FL_UNSHARE_RANGE 0x40
 #endif
 
+#ifndef FALLOC_FL_WRITE_ZEROES
+#define FALLOC_FL_WRITE_ZEROES 0x80
+#endif
+
 static cmdinfo_t allocsp_cmd;
 static cmdinfo_t freesp_cmd;
 static cmdinfo_t resvsp_cmd;
@@ -377,6 +381,28 @@ funshare_f(
 	return 0;
 }
 
+static int
+fwrite_zeroes_f(
+	int		argc,
+	char		**argv)
+{
+	xfs_flock64_t	segment;
+	int		mode = FALLOC_FL_WRITE_ZEROES;
+
+	if (!offset_length(argv[1], argv[2], &segment)) {
+		exitcode = 1;
+		return 0;
+	}
+
+	if (fallocate(file->fd, mode,
+			segment.l_start, segment.l_len)) {
+		perror("fallocate");
+		exitcode = 1;
+		return 0;
+	}
+	return 0;
+}
+
 void
 prealloc_init(void)
 {
@@ -489,4 +515,14 @@ prealloc_init(void)
 	funshare_cmd.oneline =
 	_("unshares shared blocks within the range");
 	add_command(&funshare_cmd);
+
+	funshare_cmd.name = "fwrite_zeroes";
+	funshare_cmd.cfunc = fwrite_zeroes_f;
+	funshare_cmd.argmin = 2;
+	funshare_cmd.argmax = 2;
+	funshare_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
+	funshare_cmd.args = _("off len");
+	funshare_cmd.oneline =
+	_("zeroes space and eliminates holes by allocating and writing zeroes");
+	add_command(&funshare_cmd);
 }


Zhang Yi (8):
  block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
  nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports DEAC bit
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
 drivers/md/dm-table.c                |  3 +-
 drivers/nvme/host/core.c             | 21 +++++-----
 drivers/scsi/sd.c                    |  5 +++
 fs/ext4/extents.c                    | 59 ++++++++++++++++++++++------
 fs/open.c                            |  1 +
 include/linux/blkdev.h               |  3 ++
 include/linux/falloc.h               |  3 +-
 include/trace/events/ext4.h          |  3 +-
 include/uapi/linux/falloc.h          | 18 +++++++++
 13 files changed, 134 insertions(+), 42 deletions(-)

-- 
2.39.2


