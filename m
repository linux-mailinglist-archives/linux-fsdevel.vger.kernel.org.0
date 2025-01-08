Return-Path: <linux-fsdevel+bounces-38637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58014A055BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E411607E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AE1E9B2B;
	Wed,  8 Jan 2025 08:49:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B41AB50D;
	Wed,  8 Jan 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326164; cv=none; b=YaSN+ljM6mpYEO8twjhYu4rYQd2plz5pMoSEfcqnQVFa2g3ZBD1waaLQ7SpSRloDSXRWYT0VmucHPUIRt5aS1DaYsho6NouX01g9Slh2nz2a4aYnJvGZF5R81weoyqQKqytC6yPeiJR7ZURbSika3C0FCIeje/jCpSn5SIz4rAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326164; c=relaxed/simple;
	bh=Z0oONnx76KH0hh7KJWo7iC7rNFDg3i4itSUWb0woCqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLi4j2ymRw6mJ39YzdLsKKDwACLoHzIe7SVPdycvjGFDERJDmLwBvKzJoACpWHYLneZ7ECh2N0eugzfttU5+0SXrQKBGehedtx64yLtfb8yguGvA6f8CyGeenAfiLGYlWku4XNysgIsKiFPvv4BPCul1Al9fqabdDbFaGqn4pcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YShR655MTz4f3kG0;
	Wed,  8 Jan 2025 16:48:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC3A41A1119;
	Wed,  8 Jan 2025 16:49:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB321_7O35nRaZ8AQ--.57305S4;
	Wed, 08 Jan 2025 16:49:06 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	willy@infradead.org,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [xfstests PATCH v3] generic: add a partial pages zeroing out test
Date: Wed,  8 Jan 2025 16:44:07 +0800
Message-Id: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB321_7O35nRaZ8AQ--.57305S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWrtw4fGrW7Zw4xGw4Durg_yoW5tF15pF
	WF93Wakr4xJ3W7W393CFnrAr1rAFs3ZF47ur9rW3s8ZFW0qrn7CF9Igry8JrW3Gw40vr4F
	vrs2q34jgr18XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This addresses a data corruption issue encountered during partial page
zeroing in ext4 which the block size is smaller than the page size [1].
Add a new test which is expanded upon generic/567, this test performs a
zeroing range test that spans two partial pages to cover this case, and
also generalize it to work for non-4k page sizes.

Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v2->v3:
 - Put the verifyfile in $SCRATCH_MNT and remove the overriding
   _cleanup.
 - Correct the test name.
v1->v2:
 - Add a new test instead of modifying generic/567.
 - Generalize the test to work for non-4k page sizes.
v2: https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/

 tests/generic/758     | 68 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/758.out |  3 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out

diff --git a/tests/generic/758 b/tests/generic/758
new file mode 100755
index 00000000..bf0a342b
--- /dev/null
+++ b/tests/generic/758
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. 758
+#
+# Test mapped writes against zero-range to ensure we get the data
+# correctly written. This can expose data corruption bugs on filesystems
+# where the block size is smaller than the page size.
+#
+# (generic/567 is a similar test but for punch hole.)
+#
+. ./common/preamble
+_begin_fstest auto quick rw zero
+
+# Import common functions.
+. ./common/filter
+
+_require_scratch
+_require_xfs_io_command "fzero"
+
+verifyfile=$SCRATCH_MNT/verifyfile
+testfile=$SCRATCH_MNT/testfile
+
+pagesz=$(getconf PAGE_SIZE)
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+_dump_files()
+{
+	echo "---- testfile ----"
+	_hexdump $testfile
+	echo "---- verifyfile --"
+	_hexdump $verifyfile
+}
+
+# Build verify file, the data in this file should be consistent with
+# that in the test file.
+$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
+		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
+		$verifyfile | _filter_xfs_io >> /dev/null
+
+# Zero out straddling two pages to check that the mapped write after the
+# range-zeroing are correctly handled.
+$XFS_IO_PROG -t -f \
+	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
+	-c "mmap -rw 0 $((pagesz * 3))" \
+	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
+	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
+	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
+	-c "close"      \
+$testfile | _filter_xfs_io > $seqres.full
+
+echo "==== Pre-Remount ==="
+if ! cmp -s $testfile $verifyfile; then
+	echo "Data does not match pre-remount."
+	_dump_files
+fi
+_scratch_cycle_mount
+echo "==== Post-Remount =="
+if ! cmp -s $testfile $verifyfile; then
+	echo "Data does not match post-remount."
+	_dump_files
+fi
+
+status=0
+exit
diff --git a/tests/generic/758.out b/tests/generic/758.out
new file mode 100644
index 00000000..d01c1959
--- /dev/null
+++ b/tests/generic/758.out
@@ -0,0 +1,3 @@
+QA output created by 758
+==== Pre-Remount ===
+==== Post-Remount ==
-- 
2.39.2


