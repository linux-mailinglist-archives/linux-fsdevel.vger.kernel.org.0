Return-Path: <linux-fsdevel+bounces-57620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF6B23E92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06C704E2CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE54280023;
	Wed, 13 Aug 2025 02:52:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC661270559;
	Wed, 13 Aug 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053538; cv=none; b=l9QJEkDJ99abgtXB0QRUfkCsIPHRT/UUiCR3Te/iPj5FK06tR+h8C5uTMnFv4E27ebZMo7+Qha/ukvNintwnwZhR9rmWJgVlBf+Kg/kNcGB4eCzCCmWggfdHVSd6uVzG226sl/WWbE4yFkr1zfx3qrZs17IgHD4JbB7X0dC8LkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053538; c=relaxed/simple;
	bh=pMO/5u3bPj59OUaY7EWtNX7Gfw7oK1jmCpyQpQRv/2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGdkBE9VZjj/iyhn3dTfjexGQ4XdjFjPedk+h7VzlMNFJ22kKWINbL8qxrca7bFW0SldLjx8zI8/HCJOCVMpoQlopaSez6UFK3K7uDjyVNDVaa4fTi1Jb69vuXAazzMEjhV4SsUREDcJ53F3J11HRg2/luPZuzxov/C8o8jH5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1tFX3F5xzYQtpJ;
	Wed, 13 Aug 2025 10:52:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0F6F81A0359;
	Wed, 13 Aug 2025 10:52:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLQ_ZtoAscBDg--.14424S7;
	Wed, 13 Aug 2025 10:52:14 +0800 (CST)
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
Subject: [PATCH blktests v2 3/3] nvme/065: add unmap write zeroes tests
Date: Wed, 13 Aug 2025 10:44:21 +0800
Message-Id: <20250813024421.2507446-4-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHwhLQ_ZtoAscBDg--.14424S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1fCr17tr1rZryfKrW5GFg_yoWrXF45pF
	yjyFyakrWxWFnrGws3Za17WF13Cw4vvry7Cay7tryj93srXry3WrWkKa4jqw1fGF93uw10
	yayjqFWS9r1UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRG2NZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test block device unmap write zeroes sysfs interface with NVMeT devices
which are based on various SCSI debug devices. The NVMe device's
/sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes
should equal to the write_zeroes_max_bytes if the SCSI debug device
enable the WRITE SAME command with unmap functionality, and it should
return 0 otherwise. /sys/block/<disk>/queue/write_zeroes_unmap_max_bytes
should be equal to write_zeroes_unmap_max_hw_bytes by default, and we
can disable write zeroes support by setting it to zero.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/nvme/065     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/065.out |  4 ++
 2 files changed, 100 insertions(+)
 create mode 100755 tests/nvme/065
 create mode 100644 tests/nvme/065.out

diff --git a/tests/nvme/065 b/tests/nvme/065
new file mode 100755
index 0000000..8631bfa
--- /dev/null
+++ b/tests/nvme/065
@@ -0,0 +1,96 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Huawei.
+#
+# Test block device unmap write zeroes sysfs interface with nvmet scsi
+# debug devices.
+
+. tests/nvme/rc
+. common/scsi_debug
+
+DESCRIPTION="test unmap write zeroes sysfs interface with nvmet devices"
+QUICK=1
+
+nvme_trtype=loop
+nvmet_blkdev_type="device"
+
+requires() {
+	_have_scsi_debug
+	_nvme_requires
+	_require_nvme_trtype_is_loop
+}
+
+readonly TO_SKIP=255
+
+setup_test_device() {
+	local port
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
+	port="$(_create_nvmet_port)"
+	_create_nvmet_subsystem --blkdev "/dev/${SCSI_DEBUG_DEVICES[0]}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvme_connect_subsys
+
+	echo $(_find_nvme_ns "${def_subsys_uuid}")
+}
+
+cleanup_test_device() {
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup --subsysnqn "${def_subsysnqn}"
+	_exit_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
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
diff --git a/tests/nvme/065.out b/tests/nvme/065.out
new file mode 100644
index 0000000..262cfc9
--- /dev/null
+++ b/tests/nvme/065.out
@@ -0,0 +1,4 @@
+Running nvme/065
+disconnected 1 controller(s)
+disconnected 1 controller(s)
+Test complete
-- 
2.39.2


