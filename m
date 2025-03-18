Return-Path: <linux-fsdevel+bounces-44269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44FA66C02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875CF3BC832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469C0205AB3;
	Tue, 18 Mar 2025 07:37:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E11EB5D2;
	Tue, 18 Mar 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283424; cv=none; b=OTE60bGHrR5joF5p6SKvss/4htZ9vXdDJ5wp1Af1LNIucu0meeoaUN3dOxxdSRl5BhjEEcQdZ9/M38Az2r4QUQ/LcjLHaQlKjAN+0vcxYkeGdKSunIpUxG0zCJO9+WZJMRVUR+8CTYtejhdQwX6EKlHQtQAAi2DKFLmzispDido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283424; c=relaxed/simple;
	bh=wD2it5GJ5SfRK8NZd9+3Zn6EBh5SfvB1EVOuHC050K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCQFdMOwhkuJAdBOME77kMcE4O8dU0Cwn+bCFh3lTNRXP4/e8x9lcQIeNGjA9KYIwq2wpw9fank5Hei1oxI67bRlJJKwGApHL6aiNpRdmwHl0OFeHrOo3+TYxFU/FIhEOMKGTuQpaQ/62NZ7XOdaGE19gGcOmVnFKZpWn6ycXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Yx2Xc0z4f3khR;
	Tue, 18 Mar 2025 15:36:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ECB611A1940;
	Tue, 18 Mar 2025 15:36:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+PItlnS19YGw--.63204S5;
	Tue, 18 Mar 2025 15:36:59 +0800 (CST)
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
Subject: [PATCH blktests 1/3] scsi/010: add unmap write zeroes tests
Date: Tue, 18 Mar 2025 15:28:33 +0800
Message-ID: <20250318072835.3508696-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1+PItlnS19YGw--.63204S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5GrykJFy7XF48JF1DKFg_yoW8Krykp3
	48K3ZYkr4Iqw17G3WS9F47Wr13GaykAr17ZayxW34jvrykZryakw1IgFyUJFZ3Jr93Ww4F
	vFs5XFWFkr9rtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRb4SwUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test block device unmap write zeroes sysfs interface with various SCSI
debug devices. The /sys/block/<disk>/queue/write_zeroes_unmap interface
should return 1 if the SCSI device enable the WRITE SAME command with
unmap functionality, and it should return 0 otherwise.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

diff --git a/tests/scsi/010 b/tests/scsi/010
new file mode 100755
index 0000000..27a672c
--- /dev/null
+++ b/tests/scsi/010
@@ -0,0 +1,56 @@
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
+device_requries() {
+	_require_test_dev_sysfs queue/write_zeroes_unmap
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# disable WRITE SAME with unmap
+	if ! _configure_scsi_debug lbprz=0; then
+		return 1
+	fi
+	umap="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(16) with unmap
+	if ! _configure_scsi_debug lbprz=1 lbpws=1; then
+		return 1
+	fi
+	umap="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 1 ]]; then
+		echo "Test enable WRITE SAME(16) with unmap failed."
+	fi
+	_exit_scsi_debug
+
+	# enable WRITE SAME(10) with unmap
+	if ! _configure_scsi_debug lbprz=1 lbpws10=1; then
+		return 1
+	fi
+	umap="$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 1 ]]; then
+		echo "Test enable WRITE SAME(10) with unmap failed."
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
2.46.1


