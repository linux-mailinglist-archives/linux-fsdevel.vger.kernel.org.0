Return-Path: <linux-fsdevel+bounces-44270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CFA66C26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805021898510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE12063FC;
	Tue, 18 Mar 2025 07:37:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2B1FECBA;
	Tue, 18 Mar 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283425; cv=none; b=LWLUkkEJhdiqte+mJ8wegLthw7AfylSel+J/+uQoKtKFwpADCBXjBe0w7rs2wjyHX8C5iIOx9hfrvLGF0UAmE/3Y/xU8THGurS19E5wn4S37EAP8E6VlQudtsB6hDnHXPzDKz6t6zY6fKSfh7jiIUawqyF0UEv/kTr7hm2BlT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283425; c=relaxed/simple;
	bh=FxIKGGj1FAzSa3q463IdI5kXhXubtDHbU714Dd9j8Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF/J9cbsrfMdhkGyUVCxdxZjSWuC6aKNjxfSyx5NQjUHOiH7P2gs7FmLZ17EhT0kDw/unz3Zcg4DDQNC56REnqXdjvZqFyqGH0qppSnAVSn85FEVRztp0gPcWRDHzcd3E4zzBKSa6KX3hpQ2PTV5UzYWGzj6Jfw1RUQ7wmRd+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Z33Pmcz4f3jt7;
	Tue, 18 Mar 2025 15:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0FC21A149B;
	Tue, 18 Mar 2025 15:37:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+PItlnS19YGw--.63204S6;
	Tue, 18 Mar 2025 15:37:00 +0800 (CST)
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
Subject: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
Date: Tue, 18 Mar 2025 15:28:34 +0800
Message-ID: <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXu1+PItlnS19YGw--.63204S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWxZw1DKFW5JFyxJFyfCrg_yoW5Xw1fpa
	47GF9Yyr47Wr12g3W3uF17WF1rC395ArW3Jay7Cry0krZrZ34aga4xKFy7Z34ftrZ5W3Z5
	Aa13ta9Ykr1UtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRGg4-UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Test block device unmap write zeroes sysfs interface with device-mapper
stacked devices. The /sys/block/<disk>/queue/write_zeroes_unmap
interface should return 1 if the underlying devices support the unmap
write zeroes command, and it should return 0 otherwise.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 common/rc        | 16 ++++++++++++++
 tests/dm/003     | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/dm/003.out |  2 ++
 3 files changed, 75 insertions(+)
 create mode 100755 tests/dm/003
 create mode 100644 tests/dm/003.out

diff --git a/common/rc b/common/rc
index bc6c2e4..60c21f2 100644
--- a/common/rc
+++ b/common/rc
@@ -615,3 +615,19 @@ _io_uring_restore()
 		echo "$IO_URING_DISABLED" > /proc/sys/kernel/io_uring_disabled
 	fi
 }
+
+# get real device path name by following link
+_real_dev()
+{
+	local dev=$1
+	if [ -b "$dev" ] && [ -L "$dev" ]; then
+		dev=`readlink -f "$dev"`
+	fi
+	echo $dev
+}
+
+# basename of a device
+_short_dev()
+{
+	echo `basename $(_real_dev $1)`
+}
diff --git a/tests/dm/003 b/tests/dm/003
new file mode 100755
index 0000000..1013eb5
--- /dev/null
+++ b/tests/dm/003
@@ -0,0 +1,57 @@
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
+device_requries() {
+	_require_test_dev_sysfs queue/write_zeroes_unmap
+}
+
+setup_test_device() {
+	if ! _configure_scsi_debug "$@"; then
+		return 1
+	fi
+
+	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+	local blk_sz="$(blockdev --getsz "$dev")"
+	dmsetup create test --table "0 $blk_sz linear $dev 0"
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
+	setup_test_device lbprz=0
+	umap="$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 0 ]]; then
+		echo "Test disable WRITE SAME with unmap failed."
+	fi
+	cleanup_test_device
+
+	# enable WRITE SAME with unmap
+	setup_test_device lbprz=1 lbpws=1
+	umap="$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_zeroes_unmap")"
+	if [[ $umap -ne 1 ]]; then
+		echo "Test enable WRITE SAME with unmap failed."
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
2.46.1


