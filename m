Return-Path: <linux-fsdevel+bounces-57617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA0B23E88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F34E1BA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20032271A71;
	Wed, 13 Aug 2025 02:52:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1C26FA5E;
	Wed, 13 Aug 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053536; cv=none; b=BthrDud59Ocs3bXxfAcclwXCSXxv+pIxy/69p/f0SWyvJPFqjANYXQA5AF7v81y9dnYgqv/O/tzJGEOk6OA/cKS2xiYOn/bSc1OaziGCtj4WlJZYVTsCGcqDkea7kdrrZ6iqgZT2N0CPEKGJTfGbGnS8dwqhRvci1eG1i+Tm8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053536; c=relaxed/simple;
	bh=NxZyK+a8lixK2ulGcEyfonl5LFiRlCKQlh0lQAKv610=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiYGtN0zFpq1EchH/aiTbhQ7TTgfiFgBhyc/ZNimwdZVXgMBKM47B9j8DNXrxePYwgqyxCtUgDKdNYNPLJJ1PCST2vRBVfdLMT138zhtlSMGisRDGK9w8xNjJTTA0ZDWlpZu9S31v9p0wE+jDNHCR/3eZDLWFFaGGRzKVRFN3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1tFV0wfxzYQtHM;
	Wed, 13 Aug 2025 10:52:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B6C4D1A0359;
	Wed, 13 Aug 2025 10:52:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLQ_ZtoAscBDg--.14424S4;
	Wed, 13 Aug 2025 10:52:12 +0800 (CST)
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
Subject: [PATCH blktests v2 0/3] blktest: add unmap write zeroes tests
Date: Wed, 13 Aug 2025 10:44:18 +0800
Message-Id: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhLQ_ZtoAscBDg--.14424S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4rtr43GrW7tw1xWw43Awb_yoW8tr15p3
	yUKFy5twn3KF17JasxXa1jgF15Jw4xJr1ak3Wxtr1UAry8ZFyfWF4qgr1aqr1xGrn3Ww10
	va1DtF9Y9w1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7sRiKsUtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Change since v2:
 - Modify the sysfs interfaces according to the kernel implementation.
 - Determine whether the kernel supports it by directly checking the
   existence of the sysfs interface, instead of using device_requries(). 
 - Drop _short_dev() helper and directly use _real_dev() to acquire dm
   path.
 - Check the return value of setup_test_device().
 - Fix the '"make check'" errors.


The Linux kernel (since version 6.17)[1] supports FALLOC_FL_WRITE_ZEROES
in fallocate(2) and add max_{hw|user}_wzeroes_unmap_sectors parameters
to the block device queue limit. These tests test those block device
unmap write zeroes sysfs interface

        /sys/block/<disk>/queue/write_zeroes_max_bytes
        /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes

with various SCSI/NVMe/device-mapper devices.

The value of /sys/block//queue/write_zeroes_unmap_max_hw_bytes should be
equal to a nonzero value of /sys/block//queue/write_zeroes_max_bytes if
the block device supports the unmap write zeroes command; otherwise, it
should return 0. We can also disable unmap write zeroes command by
setting /sys/block/<disk>/queue/write_zeroes_max_bytes to 0.

 - scsi/010 test SCSI devices.
 - dm/003 test device mapper stacked devices.
 - nvme/065 test NVMe devices.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c

Thanks,
Yi.

Zhang Yi (3):
  scsi/010: add unmap write zeroes tests
  dm/003: add unmap write zeroes tests
  nvme/065: add unmap write zeroes tests

 common/rc          | 10 +++++
 tests/dm/003       | 86 +++++++++++++++++++++++++++++++++++++++++
 tests/dm/003.out   |  2 +
 tests/nvme/065     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/065.out |  4 ++
 tests/scsi/010     | 84 ++++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 +
 7 files changed, 284 insertions(+)
 create mode 100755 tests/dm/003
 create mode 100644 tests/dm/003.out
 create mode 100755 tests/nvme/065
 create mode 100644 tests/nvme/065.out
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

-- 
2.39.2


