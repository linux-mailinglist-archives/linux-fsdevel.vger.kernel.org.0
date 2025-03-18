Return-Path: <linux-fsdevel+bounces-44271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B874CA66C2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57881421499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB51FA14B;
	Tue, 18 Mar 2025 07:37:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960A202978;
	Tue, 18 Mar 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283426; cv=none; b=Tmn5B1W1YsaffqnNRNL4uSfL0M0m50B36fq66uJYBiDz+y0IDk0e1i9J63MuODF5e//l8mDpWptTGl9lM+ndft435th6VVT0llHmZw3OpC8mhak8JekTGNaFj/Kh8NujHVhkPTkmD/xh0L6K52edxAmcM1T6uOPzjzNxWxDP564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283426; c=relaxed/simple;
	bh=qRhWbIArakniweM68OrA5PdRGrB5BfFvmCp41RraK68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiWlReq3bhyWkq2eRU82QRjxVdfjpgsC/ouXHeHcCvXJdYd4XvSKvxjFIpzlkyPlmJozMsyV1fpvnsujMag9E49VGZgCniYu0NgSfa8ORG0FYNMjcuAbMg2OcUrdFmGQfCAlns5YSrmS5Qr9l+m6ac9l01CYyWl2lRCfbQbHOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Yx31Blz4f3m76;
	Tue, 18 Mar 2025 15:36:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 789501A06D7;
	Tue, 18 Mar 2025 15:37:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+PItlnS19YGw--.63204S7;
	Tue, 18 Mar 2025 15:37:01 +0800 (CST)
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
Subject: [PATCH blktests 3/3] nvme/060: add unmap write zeroes tests
Date: Tue, 18 Mar 2025 15:28:35 +0800
Message-ID: <20250318072835.3508696-4-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXu1+PItlnS19YGw--.63204S7
X-Coremail-Antispam: 1UD129KBjvJXoWxur48WF45GF13KFyUZw4ruFg_yoW5XF17pa
	yUKF9Ikr1xW3Wagw1fZa15WFyfCw4kZw12y34xKw1jyr9rX343Wrn7K34jvw1fGF93Ww18
	ZayjgFWrur1DGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRWv3bUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test block device unmap write zeroes sysfs interface with NVMeT devices
which are based on various SCSI debug devices. The
/sys/block/<disk>/queue/write_zeroes_unmap interface should return 1 if
the NVMeT devices support the unmap write zeroes command, and it should
return 0 otherwise.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 tests/nvme/060     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  4 +++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/nvme/060
 create mode 100644 tests/nvme/060.out

diff --git a/tests/nvme/060 b/tests/nvme/060
new file mode 100755
index 0000000..524176f
--- /dev/null
+++ b/tests/nvme/060
@@ -0,0 +1,68 @@
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
+device_requries() {
+	_require_test_dev_sysfs queue/write_zeroes_unmap
+}
+
+setup_test_device() {
+	if ! _configure_scsi_debug "$@"; then
+		return 1
+	fi
+
+	local port="$(_create_nvmet_port)"
+	_create_nvmet_subsystem --blkdev "/dev/${SCSI_DEBUG_DEVICES[0]}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvme_connect_subsys
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
+	setup_test_device lbprz=0
+	umap="$(cat "/sys/block/$(_find_nvme_ns "${def_subsys_uuid}")/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	cleanup_test_device
+
+	# enable WRITE SAME with unmap
+	setup_test_device lbprz=1 lbpws=1
+	umap="$(cat "/sys/block/$(_find_nvme_ns "${def_subsys_uuid}")/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 1 ]]; then
+		echo "Test enable WRITE SAME with unmap failed."
+	fi
+	cleanup_test_device
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/060.out b/tests/nvme/060.out
new file mode 100644
index 0000000..e60714d
--- /dev/null
+++ b/tests/nvme/060.out
@@ -0,0 +1,4 @@
+Running nvme/060
+disconnected 1 controller(s)
+disconnected 1 controller(s)
+Test complete
-- 
2.46.1


