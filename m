Return-Path: <linux-fsdevel+bounces-57619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24410B23E9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FF61A25F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5427F003;
	Wed, 13 Aug 2025 02:52:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344B26E140;
	Wed, 13 Aug 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053538; cv=none; b=COp7cj54SswiV/kO95QpIN9U4tsAHvxbHmgHxx/dPbyImzW5g9UAZOMao7xmgym7FL9mjphg3PrZNFigOkJVbpOvpfnHGTXHgQv9t9IS6CmpziHVED8MMdgggnYd3gXquSDOQcnFqFT+JTDH3yyjvIrhhLYrfJUlDqZk0XPQufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053538; c=relaxed/simple;
	bh=Ng1Ssi6NZ/gTlISD5WEog7sJSA+ksH4LKDz/q7bby0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMQXvvVyEocRa05MUN+fQYN0s90oJ2iPJxJhL0XC3XpUa3r3QFMkQ68y+qy3q3vtkWxnhOcRYKhdxD5r+aTfoLRPmWIKKyBrJWlWU3XDPTu39D0Qehq1bF986Rws7Y0twQlhVgoDlGelQ8yOEryIfVxRXHkpuqJPF8BbNlHqJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1tFV6bkCzKHMdD;
	Wed, 13 Aug 2025 10:52:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 28D581A12BF;
	Wed, 13 Aug 2025 10:52:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLQ_ZtoAscBDg--.14424S6;
	Wed, 13 Aug 2025 10:52:13 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
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
Subject: [PATCH blktests v2 2/3] dm/003: add unmap write zeroes tests
Date: Wed, 13 Aug 2025 10:44:20 +0800
Message-Id: <20250813024421.2507446-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
References: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhLQ_ZtoAscBDg--.14424S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1xJFWUZry3Zw17XFy5Arb_yoWrJF1rpa
	47CFy5KrWxGFnrWws3Z3W7WF13Aws5ArW3CayxJryj934DXr13WaykKFy2q3Z3GryfCwn5
	Aa17ta9Ykr1Uta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRMWlyDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test block device unmap write zeroes sysfs interface with device-mapper
stacked devices. The sysfs parameters should inherit from the underlying
SCSI device. We can disable write zeroes support by setting
/sys/block/dm-<X>/queue/write_zeroes_unmap_max_bytes to zero.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 common/rc        | 10 ++++++
 tests/dm/003     | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/dm/003.out |  2 ++
 3 files changed, 98 insertions(+)
 create mode 100755 tests/dm/003
 create mode 100644 tests/dm/003.out

diff --git a/common/rc b/common/rc
index dfc389f..bb96a88 100644
--- a/common/rc
+++ b/common/rc
@@ -668,3 +668,13 @@ _io_uring_restore()
 		echo "$IO_URING_DISABLED" > /proc/sys/kernel/io_uring_disabled
 	fi
 }
+
+# get real device path name by following link
+_real_dev()
+{
+	local dev=$1
+	if [ -b "$dev" ] && [ -L "$dev" ]; then
+		dev=$(readlink -f "$dev")
+	fi
+	echo $dev
+}
diff --git a/tests/dm/003 b/tests/dm/003
new file mode 100755
index 0000000..0b6bce2
--- /dev/null
+++ b/tests/dm/003
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Huawei.
+#
+# Test block device unmap write zeroes sysfs interface with device-mapper
+# stacked devices.
+
+. tests/dm/rc
+. common/scsi_debug
+
+DESCRIPTION="test unmap write zeroes sysfs interface with dm devices"
+QUICK=1
+
+requires() {
+	_have_scsi_debug
+}
+
+readonly TO_SKIP=255
+
+setup_test_device() {
+	local dev blk_sz dpath
+
+	if ! _configure_scsi_debug "$@"; then
+		return 1
+	fi
+
+	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes ]]; then
+		_exit_scsi_debug
+		return $TO_SKIP
+	fi
+
+	dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+	blk_sz="$(blockdev --getsz "$dev")"
+	dmsetup create test --table "0 $blk_sz linear $dev 0"
+
+	dpath=$(_real_dev /dev/mapper/test)
+	echo "${dpath##*/}"
+}
+
+cleanup_test_device() {
+	dmsetup remove test
+	_exit_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# disable WRITE SAME with unmap
+	local dname
+	dname=$(setup_test_device lbprz=0)
+	ret=$?
+	if ((ret)); then
+		if ((ret == TO_SKIP)); then
+			SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
+		fi
+		return 1
+	fi
+
+	umap_hw_bytes="$(cat "/sys/block/$dname/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/$dname/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne 0 || $umap_bytes -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	cleanup_test_device
+
+	# enable WRITE SAME with unmap
+	if ! dname=$(setup_test_device lbprz=1 lbpws=1); then
+		return 1
+	fi
+
+	zero_bytes="$(cat "/sys/block/$dname/queue/write_zeroes_max_bytes")"
+	umap_hw_bytes="$(cat "/sys/block/$dname/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/$dname/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne $zero_bytes || $umap_bytes -ne $zero_bytes ]]; then
+		echo "Test enable WRITE SAME with unmap failed."
+	fi
+
+	echo 0 > "/sys/block/$dname/queue/write_zeroes_unmap_max_bytes"
+	umap_bytes="$(cat "/sys/block/$dname/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_bytes -ne 0 ]]; then
+		echo "Test manually disable WRITE SAME with unmap failed."
+	fi
+	cleanup_test_device
+
+	echo "Test complete"
+}
diff --git a/tests/dm/003.out b/tests/dm/003.out
new file mode 100644
index 0000000..51a5405
--- /dev/null
+++ b/tests/dm/003.out
@@ -0,0 +1,2 @@
+Running dm/003
+Test complete
-- 
2.39.2


