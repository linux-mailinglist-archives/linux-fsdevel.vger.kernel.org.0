Return-Path: <linux-fsdevel+bounces-38116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF89FC542
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 13:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA537A06CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBB1B21AD;
	Wed, 25 Dec 2024 12:55:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFF19644B;
	Wed, 25 Dec 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735131319; cv=none; b=cSZZhJGL10LIbOz8rcZeJX4d4YXo0NJifWVNPalnZ8aDKpuAnCKFvfF0d5+X8PC7MDPgwSnjkS2GHNUBiDDtk7ifVWqsjxbnb81wI480i2EtK9d3QYwB2v5XSTTD2PxxWT0nOFq8p5ROnkW2unqu5xP6Dq3jwFITXZP4D7hP2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735131319; c=relaxed/simple;
	bh=4P3YOpop29SVgZczagH6A3LKAr0smpjKrwZy3VgJRg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEFqJndfNs/OLhZd1G2sKJXOOdUAeJECPdHihA9N5Dg974NzBWj8JEwI7+IveyK2LE9UrRZQKaygWRjNjVfeEZzqgp5mrI+wLdLxKcxiPd8PxHZHiXHV25Sws+cF2jPs7e9IDlO6twFykZqZD8E5l9g8ynEQukULIBH6RG2TG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJBYS0pNxz4f3jqs;
	Wed, 25 Dec 2024 20:54:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B6A671A018C;
	Wed, 25 Dec 2024 20:55:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDnwoaeAGxnKLZmFg--.41657S4;
	Wed, 25 Dec 2024 20:55:04 +0800 (CST)
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
Subject: [xfstests PATCH v2] generic: add a partial pages zeroing out test
Date: Wed, 25 Dec 2024 20:51:20 +0800
Message-ID: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnwoaeAGxnKLZmFg--.41657S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWrKr1UCFWUZw4DWr18AFb_yoW5uFWUpF
	Wru3Wayr4xJ3W7G393CFnrAr1rJan3ZF47ur9rW3s0vFW0qwn7GasIgryxJrW3Gr10vr4F
	vr4kX34jgr48XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
Add a new test which is expanded upon generic/567, this test performs a
zeroing range test that spans two partial pages to cover this case, and
also generalize it to work for non-4k page sizes.

Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v1->v2:
 - Add a new test instead of modifying generic/567.
 - Generalize the test to work for non-4k page sizes.
v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/

 tests/generic/758     | 76 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/758.out |  3 ++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out

diff --git a/tests/generic/758 b/tests/generic/758
new file mode 100755
index 00000000..e03b5e80
--- /dev/null
+++ b/tests/generic/758
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. generic/758
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
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $verifyfile $testfile
+}
+
+# Import common functions.
+. ./common/filter
+
+_require_test
+_require_scratch
+_require_xfs_io_command "fzero"
+
+verifyfile=$TEST_DIR/verifyfile
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


