Return-Path: <linux-fsdevel+bounces-38010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6EB9FA961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 03:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AED164F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627673EA69;
	Mon, 23 Dec 2024 02:43:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495714C70;
	Mon, 23 Dec 2024 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734921795; cv=none; b=BF6jEwOa8u0pyBekL9lFvnQzxqidyPdanow4Ux6R/DaUwbY06QXFegW5QOCCN2M2uBzyhV0RBW+ZJJlLw0CFhzon5uLtg+CCHhWAHaiaR0XV1OfpFuKUcXNmBPTTEyT/ZL0qXAj1elvvEs0Da8+oErnoJF3pLGbYynWIW/J9JXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734921795; c=relaxed/simple;
	bh=epH6mfC9cH98Qgtiyo4xjZbPdxf+AuONA7UNbMDxLMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mW+rzKykplIlZvuVk9ZQSkGmmEqErmyedMSK8T7MZLqxrtg0/PAr8gN3WYhZdHND/WpJvch+nDYXoaWTNi/pHAQ/OAh7xwygLRLE07B3vhjPTtFn8C+dbZzgt2lrVo05IHPbKp/rCYvIDrhdwOvyL1U1BGPM3hUzDtZmGw9QTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YGj473R3Hz4f3lWG;
	Mon, 23 Dec 2024 10:42:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 328C11A018C;
	Mon, 23 Dec 2024 10:43:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoIxzmhnKTuBFQ--.5176S4;
	Mon, 23 Dec 2024 10:43:05 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	willy@infradead.org,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [xfstests PATCH] generic/567: add partial pages zeroing out case
Date: Mon, 23 Dec 2024 10:39:30 +0800
Message-ID: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3XoIxzmhnKTuBFQ--.5176S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4kCw18tF1rAryfJF18Xwb_yoW5KFyDpF
	yfG34Syr48Z3W3AFZFk34UXryrJwn3ZF15Jry3Xr98Zr10y3W7GFsFgw10yr1UGr10vrs0
	vr4Dtryjgw48ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This addresses a data corruption issue encountered during partial page
zeroing in ext4 which the block size is smaller than the page size [1].
Expand this test to include a zeroing range test that spans two partial
pages to cover this case.

Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/generic/567     | 50 +++++++++++++++++++++++++------------------
 tests/generic/567.out | 18 ++++++++++++++++
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/tests/generic/567 b/tests/generic/567
index fc109d0d..756280e8 100755
--- a/tests/generic/567
+++ b/tests/generic/567
@@ -4,43 +4,51 @@
 #
 # FS QA Test No. generic/567
 #
-# Test mapped writes against punch-hole to ensure we get the data
-# correctly written. This can expose data corruption bugs on filesystems
-# where the block size is smaller than the page size.
+# Test mapped writes against punch-hole and zero-range to ensure we get
+# the data correctly written. This can expose data corruption bugs on
+# filesystems where the block size is smaller than the page size.
 #
 # (generic/029 is a similar test but for truncate.)
 #
 . ./common/preamble
-_begin_fstest auto quick rw punch
+_begin_fstest auto quick rw punch zero
 
 # Import common functions.
 . ./common/filter
 
 _require_scratch
 _require_xfs_io_command "fpunch"
+_require_xfs_io_command "fzero"
 
 testfile=$SCRATCH_MNT/testfile
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
-# Punch a hole straddling two pages to check that the mapped write after the
-# hole-punching is correctly handled.
-
-$XFS_IO_PROG -t -f \
--c "pwrite -S 0x58 0 12288" \
--c "mmap -rw 0 12288" \
--c "mwrite -S 0x5a 2048 8192" \
--c "fpunch 2048 8192" \
--c "mwrite -S 0x59 2048 8192" \
--c "close"      \
-$testfile | _filter_xfs_io
-
-echo "==== Pre-Remount ==="
-_hexdump $testfile
-_scratch_cycle_mount
-echo "==== Post-Remount =="
-_hexdump $testfile
+# Punch a hole and zero out straddling two pages to check that the mapped
+# write after the hole-punching and range-zeroing are correctly handled.
+_straddling_test()
+{
+	local test_cmd=$1
+
+	$XFS_IO_PROG -t -f \
+		-c "pwrite -S 0x58 0 12288" \
+		-c "mmap -rw 0 12288" \
+		-c "mwrite -S 0x5a 2048 8192" \
+		-c "$test_cmd 2048 8192" \
+		-c "mwrite -S 0x59 2048 8192" \
+		-c "close"      \
+	$testfile | _filter_xfs_io
+
+	echo "==== Pre-Remount ==="
+	_hexdump $testfile
+	_scratch_cycle_mount
+	echo "==== Post-Remount =="
+	_hexdump $testfile
+}
+
+_straddling_test "fpunch"
+_straddling_test "fzero"
 
 status=0
 exit
diff --git a/tests/generic/567.out b/tests/generic/567.out
index 0e826ed3..df89b8f3 100644
--- a/tests/generic/567.out
+++ b/tests/generic/567.out
@@ -17,3 +17,21 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
 *
 003000
+wrote 12288/12288 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
+*
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
+*
+002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
+*
+003000
+==== Post-Remount ==
+000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
+*
+000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
+*
+002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
+*
+003000
-- 
2.46.1


