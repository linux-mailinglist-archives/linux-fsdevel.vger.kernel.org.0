Return-Path: <linux-fsdevel+bounces-44264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C14A66BD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EAE3B78CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F9204C0A;
	Tue, 18 Mar 2025 07:34:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9C1DE2CB;
	Tue, 18 Mar 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283291; cv=none; b=G5JI9QBwhsiT+boeFieOcAZYCiG2dKPVA1tGOF8e41ca2Ch03feWvJuhMAk7llohRvmahQsn+oL40fYL3aDhuy3zn3CSgc5a6K9WDtHlDiwUgLCxKZgu/3yA3CPtrfk6M7rKkHI9/pdLmjJ0uBtdHX+qjD9KvomLHLWy5nuWIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283291; c=relaxed/simple;
	bh=qEOODi0lrdl9IC2ERF9WciKLvHoxvGO4O2+nHw3o4D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMlEipTrjHOMcdYUMQE47EDyi1lxOxT/ecO5zkLVhNtFGjhrnVRdBeTeEfkW2UZanvS3pcgQoXDU5UNKeMAFEv12bhBUCbiNmh/KMxrZGyubgAq6DOcyhSXiMFZAzqbQvK0vLam9BSp1ygY65K+IPP2AXV0ekk2YFTLY0he2mhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3WS2ZyYz4f3jtK;
	Tue, 18 Mar 2025 15:34:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95AE41A058E;
	Tue, 18 Mar 2025 15:34:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8EItlnJDdYGw--.56140S7;
	Tue, 18 Mar 2025 15:34:45 +0800 (CST)
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
Subject: [PATCH xfstests 3/5] generic/766: test fallocate write zeroes on block device
Date: Tue, 18 Mar 2025 15:26:13 +0800
Message-ID: <20250318072615.3505873-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
References: <20250318072615.3505873-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8EItlnJDdYGw--.56140S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGry7Jw4xAFW8WF4kCry8Xwb_yoW5Kw1rpa
	10k3W5JryFgw17Grs3uryjvr1rGanY9F4ayF97Kry5ZryktFy8JFWqgr1jqr97X3srCwsY
	vaya9Fy3Kw4SqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRRwID5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test the fallocate FALLOC_FL_WRITE_ZEROES command on a block device,
including unsupported flags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/generic/766     | 80 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/766.out | 23 +++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100755 tests/generic/766
 create mode 100644 tests/generic/766.out

diff --git a/tests/generic/766 b/tests/generic/766
new file mode 100755
index 00000000..6f31c250
--- /dev/null
+++ b/tests/generic/766
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. 766
+#
+# Test fallocate(WRITE_ZEROES) on a block device, which should be able to
+# WRITE SAME (or equivalent) the range.
+#
+. ./common/preamble
+_begin_fstest blockdev rw zero
+
+_register_cleanup "_cleanup" BUS
+
+# Import common functions.
+. ./common/filter
+. ./common/scsi_debug
+
+# Modify as appropriate.
+_require_scsi_debug
+_require_xfs_io_command "fwzero"
+
+## 1. Test supported flags
+echo "Create with unmap writesame and format"
+dev=$(_get_scsi_debug_dev 512 512 0 4 "lbpws=1 lbpws10=1")
+_pwrite_byte 0x62 0 4m $dev >> $seqres.full
+$XFS_IO_PROG -c "fsync" $dev
+
+echo "Write zeroes"
+$XFS_IO_PROG -c "fwzero 512k 1m" $dev
+
+echo "Check contents"
+md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
+
+echo "Destroy device"
+_put_scsi_debug_dev
+
+echo "Create w/o unmap writesame and format"
+dev=$(_get_scsi_debug_dev 512 512 0 4 "lbpws=0 lbpws10=0 lbpu=0 write_same_length=0 unmap_max_blocks=0")
+_pwrite_byte 0x62 0 4m $dev >> $seqres.full
+$XFS_IO_PROG -c "fsync" $dev
+
+echo "Write zeroes, write fallback"
+$XFS_IO_PROG -c "fwzero 512k 1m" $dev
+
+echo "Check contents"
+md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
+
+echo "Destroy device"
+_put_scsi_debug_dev
+
+## 2. Test unsupported flags.
+echo "Create and format"
+dev=$(_get_scsi_debug_dev 4096 4096 0 4 "lbpws=1 lbpws10=1")
+_pwrite_byte 0x62 0 4m $dev >> $seqres.full
+$XFS_IO_PROG -c "fsync" $dev
+
+echo "Unaligned write zeroes"
+$XFS_IO_PROG -c "fwzero 512 512" $dev
+
+echo "Write zeroes past MAX_LFS_FILESIZE"
+# zod = MAX_LFS_FILESIZE
+zod=$(_get_max_lfs_filesize)
+$XFS_IO_PROG -c "fwzero 512k $zod" $dev
+
+echo "Write zeroes to MAX_LFS_FILESIZE"
+$XFS_IO_PROG -c "fwzero 0 $zod" $dev
+
+echo "Write zeroes starts past EOD"
+$XFS_IO_PROG -c "fwzero 900m 1m" $dev
+
+echo "Check contents"
+md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
+
+echo "Destroy device"
+_put_scsi_debug_dev
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/766.out b/tests/generic/766.out
new file mode 100644
index 00000000..7da0ceca
--- /dev/null
+++ b/tests/generic/766.out
@@ -0,0 +1,23 @@
+QA output created by 766
+Create with unmap writesame and format
+Write zeroes
+Check contents
+caa26edd6c70ce862eb7ec6f10b138a8  SCSI_DEBUG_DEV
+Destroy device
+Create w/o unmap writesame and format
+Write zeroes, write fallback
+Check contents
+caa26edd6c70ce862eb7ec6f10b138a8  SCSI_DEBUG_DEV
+Destroy device
+Create and format
+Unaligned write zeroes
+fallocate: Invalid argument
+Write zeroes past MAX_LFS_FILESIZE
+fallocate: File too large
+Write zeroes to MAX_LFS_FILESIZE
+fallocate: Invalid argument
+Write zeroes starts past EOD
+fallocate: Invalid argument
+Check contents
+b83f9394092e15bdcda585cd8e776dc6  SCSI_DEBUG_DEV
+Destroy device
-- 
2.46.1


