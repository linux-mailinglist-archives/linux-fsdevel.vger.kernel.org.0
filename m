Return-Path: <linux-fsdevel+bounces-57618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A6B23E9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E51A24270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D2275B1F;
	Wed, 13 Aug 2025 02:52:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35326C3A5;
	Wed, 13 Aug 2025 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053537; cv=none; b=UZ/Y2mqPasFlXQ51y7o/KSoj4IZCFAVUJZs/jJUF87IfIwLKPIEwW8urrarwUFL3HNdu8Jp1nuZpEmcJmqnrVRGM8g94G1KIRjv90XYhNkGOaTIans6nM9Q/7jt2sTAQGRz/sJ+4gVvrCjbyAjDjJX+N0rqw3xGFlKdB/qv2VZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053537; c=relaxed/simple;
	bh=pWPtEhrfKrsC9K7/YtHpy6pZ1rJYAEdnHYMeXUEPRCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdS8mKVcGPN5TFlW6dMvHyG4vCcNO7Y6gHdqakTRV+NQG0JD5yeBlW0XSA/8E6PQrnfG/ujXWxOuTCN42CadqrvzyzbqgGPqAqsnxKge8VCXR5N2S5Be+6mKsKefG2NNxrpXXb7134Nu4GrpiavqV3iJFjg0zX1/VQK+rSTRJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1tFV5qpyzYQtHM;
	Wed, 13 Aug 2025 10:52:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6A0CF1A1562;
	Wed, 13 Aug 2025 10:52:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLQ_ZtoAscBDg--.14424S5;
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
Subject: [PATCH blktests v2 1/3] scsi/010: add unmap write zeroes tests
Date: Wed, 13 Aug 2025 10:44:19 +0800
Message-Id: <20250813024421.2507446-2-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHwhLQ_ZtoAscBDg--.14424S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAF13tFy3tr43Ww1kXrWfuFg_yoWrArW3pr
	y0kFZYgrW8XrsrJrs5Cay7Wr13AanYyry7Way7Jryj93ykZr17urs7KFWjqa1fGryfCw40
	qay5XFWSkr1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0piRRR_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test block device unmap write zeroes sysfs interface with various SCSI
debug devices. /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes
should equal to the write_zeroes_max_bytes if the SCSI device enable the
WRITE SAME command with unmap functionality, and it should return 0
otherwise. /sys/block/<disk>/queue/write_zeroes_unmap_max_bytes should
be equal to write_zeroes_unmap_max_hw_bytes by default, and we can
disable write zeroes support by setting it to zero.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/scsi/010     | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

diff --git a/tests/scsi/010 b/tests/scsi/010
new file mode 100755
index 0000000..c5152a4
--- /dev/null
+++ b/tests/scsi/010
@@ -0,0 +1,84 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Huawei.
+#
+# Test block device unmap write zeroes sysfs interface with various scsi
+# devices.
+
+. tests/scsi/rc
+. common/scsi_debug
+
+DESCRIPTION="test unmap write zeroes sysfs interface with scsi devices"
+QUICK=1
+
+requires() {
+	_have_scsi_debug
+}
+
+setup_test_device() {
+	if ! _configure_scsi_debug "$@"; then
+		return 1
+	fi
+
+	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes ]]; then
+		_exit_scsi_debug
+		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
+		return 1
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# disable WRITE SAME with unmap
+	if ! setup_test_device lbprz=0; then
+		return 1
+	fi
+
+	umap_hw_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne 0 || $umap_bytes -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(16) with unmap
+	if ! setup_test_device lbprz=1 lbpws=1; then
+		return 1
+	fi
+
+	zero_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_max_bytes")"
+	umap_hw_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne $zero_bytes || $umap_bytes -ne $zero_bytes ]]; then
+		echo "Test enable WRITE SAME(16) with unmap failed."
+	fi
+
+	echo 0 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_bytes -ne 0 ]]; then
+		echo "Test manually disable WRITE SAME(16) with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(10) with unmap
+	if ! setup_test_device lbprz=1 lbpws10=1; then
+		return 1
+	fi
+
+	zero_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_max_bytes")"
+	umap_hw_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_hw_bytes")"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_hw_bytes -ne $zero_bytes || $umap_bytes -ne $zero_bytes ]]; then
+		echo "Test enable WRITE SAME(10) with unmap failed."
+	fi
+
+	echo 0 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes"
+	umap_bytes="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap_max_bytes")"
+	if [[ $umap_bytes -ne 0 ]]; then
+		echo "Test manually disable WRITE SAME(10) with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/scsi/010.out b/tests/scsi/010.out
new file mode 100644
index 0000000..6581d5e
--- /dev/null
+++ b/tests/scsi/010.out
@@ -0,0 +1,2 @@
+Running scsi/010
+Test complete
-- 
2.39.2


