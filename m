Return-Path: <linux-fsdevel+bounces-38176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A909FD8C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 02:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A341885726
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FB482EB;
	Sat, 28 Dec 2024 01:49:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BC3B1A1;
	Sat, 28 Dec 2024 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350598; cv=none; b=mTqhmv0D4YwBO2Rx1zBHb3Mgi1IrbGqlGpKf3OrZ2kzI0GGBd4E+rR5OccEpmkK4KblztdiGrS21+63T+LL8VyPU+Cs7tOoO8N7NvR08f3yI/AWoXUhjSRFNioMtz42bI7AdNqIs9A+as4Ot2YabdktsDSPHsKIf4/UZzCSRFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350598; c=relaxed/simple;
	bh=AXtyMcZWGbCzPMx2LykKFVxauMONIkwojzl4bJy5xK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zd+0nh1wlniPF5SZBcDk0WFaR8tKz4PEQBI71IRpHCylITzcdu+6DerPHqZcAODJBsl5fr2958s25puVozw023fJUc7tEvvoC/3uJIeUlCalJKZXVAO2ZdSHHzjuhlxva5n5WFgq7T1HjHi3zcA8Ld98e0feoIGKd10h0vyHSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YKlfG026Wz4f3lfJ;
	Sat, 28 Dec 2024 09:49:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEA161A0196;
	Sat, 28 Dec 2024 09:49:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4cuWW9nXPNWFw--.42357S4;
	Sat, 28 Dec 2024 09:49:44 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH 0/2] fallocate: introduce FALLOC_FL_FORCE_ZERO flag
Date: Sat, 28 Dec 2024 09:45:20 +0800
Message-Id: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4cuWW9nXPNWFw--.42357S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuw17tr1xAr4kGFyDGw17Wrg_yoWfXryxpa
	yjgr1UK340qryfC3s3Ca1vgr1rXws5Gr45Gr42v34UZas8WF1fKa1qgw1FqayxZFWfGF1U
	Xw43try3uF12vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, we can use the fallocate command to quickly create a
pre-allocated file. However, on most filesystems, such as ext4 and XFS,
fallocate create pre-allocation blocks in an unwritten state, and the
FALLOC_FL_ZERO_RANGE flag also behaves similarly. The extent state must
be converted to a written state when the user writes data into this
range later, which can trigger numerous metadata changes and consequent
journal I/O. This may leads to significant write amplification and
performance degradation in synchronous write mode. Therefore, we need a
method to create a pre-allocated file with written extents. At the
monent, the only method available is to create an empty file and write
zero data into it (for example, using 'dd' with a large block size).
However, this method is slow and consumes a considerable amount of disk
bandwidth, we must pre-allocate files in advance but cannot add
pre-allocated files while user business services are running.

Fortunately, with the development and more and more widely used of
flash-based storage devices, we can efficiently write zeros to SSDs
using the WRITE_ZERO command. If SCSI SSDs support the UMMAP bit or NVMe
SSDs support the DEAC bit[1], the WRITE_ZERO command does not write
actual data to the device, instead, NVMe converts the zeroed range to a
deallocated state, which works fast and consumes almost no disk write
bandwidth. Consequently, this feature can provide us with a faster
method for creating pre-allocated files with written extents and zeroed
data.

This series aims to implement this by introducing a new flag
FALLOC_FL_FORCE_ZERO into the fallocate, and providing a brief
demonstration on ext4(note: this is based on my ext4 fallocate refactor
series[2] which hasn't been merged yet), which will be used for further
test and discussion. This flag serves as a supported flag for
FALLOC_FL_ZERO_RANGE, it enforce the file system to issue zeros and
allocate written extents during the FALLOC_FL_FORCE_ZERO operation. If
the underlying storage supports WRITE_ZERO, the zero range operation
can be accelerated, if not, it defaults to write zero data, similar to
a direct write.

I've modified xfs_io and fallocate tool in util-linux[3], and tested
performance with this series on ext4 filesystem on my machine with an
Intel Xeon Gold 6248R CPU, a 7TB KCD61LUL7T68 NVMe SSD which supports
WRITE_ZERO with the Deallocated state and the DEAC bit.

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

Any comments are welcome.

Thanks,
Yi.

---

[1] https://nvmexpress.org/specifications/
    NVM Command Set Specification, section 3.2.8
[2] https://lore.kernel.org/linux-ext4/20241220011637.1157197-1-yi.zhang@huaweicloud.com/
[3] Here is a simple support of xfs_io and fallocate tool in util-linux.
    Feel free to give it a try.

1. xfs_io

diff --git a/io/prealloc.c b/io/prealloc.c
index 8e968c9f..66ae63d6 100644
--- a/io/prealloc.c
+++ b/io/prealloc.c
@@ -30,6 +30,10 @@
 #define FALLOC_FL_UNSHARE_RANGE 0x40
 #endif
 
+#ifndef FALLOC_FL_FORCE_ZERO
+#define FALLOC_FL_FORCE_ZERO 0x80
+#endif
+
 static cmdinfo_t allocsp_cmd;
 static cmdinfo_t freesp_cmd;
 static cmdinfo_t resvsp_cmd;
@@ -324,16 +328,20 @@ fzero_f(
 	int		mode = FALLOC_FL_ZERO_RANGE;
 	int		c;
 
-	while ((c = getopt(argc, argv, "k")) != EOF) {
+	while ((c = getopt(argc, argv, "kz")) != EOF) {
 		switch (c) {
 		case 'k':
 			mode |= FALLOC_FL_KEEP_SIZE;
 			break;
+		case 'z':
+			mode |= FALLOC_FL_FORCE_ZERO;
+			break;
 		default:
 			command_usage(&fzero_cmd);
 		}
 	}
-        if (optind != argc - 2)
+	if (optind != argc - 2 ||
+	    ((mode & FALLOC_FL_KEEP_SIZE) && (mode & FALLOC_FL_FORCE_ZERO)))
                 return command_usage(&fzero_cmd);
 
 	if (!offset_length(argv[optind], argv[optind + 1], &segment))
@@ -475,7 +483,7 @@ prealloc_init(void)
 	fzero_cmd.argmin = 2;
 	fzero_cmd.argmax = 3;
 	fzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
-	fzero_cmd.args = _("[-k] off len");
+	fzero_cmd.args = _("[-k | -z ] off len");
 	fzero_cmd.oneline =
 	_("zeroes space and eliminates holes by preallocating");
 	add_command(&fzero_cmd);

2. util-linux

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index ac7c687f2..55627ce4b 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -66,6 +66,10 @@
 # define FALLOC_FL_INSERT_RANGE		0x20
 #endif
 
+#ifndef FALLOC_FL_FORCE_ZERO
+# define FALLOC_FL_FORCE_ZERO		0x80
+#endif
+
 #include "nls.h"
 #include "strutils.h"
 #include "c.h"
@@ -305,6 +309,7 @@ int main(int argc, char **argv)
 	    { "dig-holes",      no_argument,       NULL, 'd' },
 	    { "insert-range",   no_argument,       NULL, 'i' },
 	    { "zero-range",     no_argument,       NULL, 'z' },
+	    { "force-zero",     no_argument,       NULL, 'Z' },
 	    { "offset",         required_argument, NULL, 'o' },
 	    { "length",         required_argument, NULL, 'l' },
 	    { "posix",          no_argument,       NULL, 'x' },
@@ -313,9 +318,10 @@ int main(int argc, char **argv)
 	};
 
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
-		{ 'c', 'd', 'p', 'z' },
+		{ 'c', 'd', 'p', 'z', 'Z' },
 		{ 'c', 'n' },
-		{ 'x', 'c', 'd', 'i', 'n', 'p', 'z'},
+		{ 'Z', 'n' },
+		{ 'x', 'c', 'd', 'i', 'n', 'p', 'z', 'Z'},
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
@@ -325,7 +331,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while ((c = getopt_long(argc, argv, "hvVncpdizxl:o:", longopts, NULL))
+	while ((c = getopt_long(argc, argv, "hvVncpdizZxl:o:", longopts, NULL))
 			!= -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -355,6 +361,9 @@ int main(int argc, char **argv)
 		case 'z':
 			mode |= FALLOC_FL_ZERO_RANGE;
 			break;
+		case 'Z':
+			mode |= FALLOC_FL_ZERO_RANGE | FALLOC_FL_FORCE_ZERO;
+			break;
 		case 'x':
 #ifdef HAVE_POSIX_FALLOCATE
 			posix = 1;



Zhang Yi (2):
  fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
  ext4: add FALLOC_FL_FORCE_ZERO support

 fs/ext4/extents.c           | 42 +++++++++++++++++++++++++++++++------
 fs/open.c                   | 14 ++++++++++---
 include/linux/falloc.h      |  5 ++++-
 include/trace/events/ext4.h |  3 ++-
 include/uapi/linux/falloc.h | 12 +++++++++++
 5 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.39.2


