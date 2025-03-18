Return-Path: <linux-fsdevel+bounces-44268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF8A66C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A326916F267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B81E8356;
	Tue, 18 Mar 2025 07:37:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA81FA14B;
	Tue, 18 Mar 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283424; cv=none; b=bKQgdGsZypl8aYhK/oBVAYreN5YlbLZVicTsVvHjlXiCdyoHG+Sfd31D7W9pK+gtjibMGlmumrB968ZyzgD09hs2FhbPmM8JVqHfxqf4bgN49HEUuTnw+kSMB7Zfk199NIK/Eqv+KzeZb19lwUInCSTcYGsFmzW6nNf3IwjUG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283424; c=relaxed/simple;
	bh=1cW6+mDprDdMkoY8/4E/8OSoBhCG2dyFE3B47jeYNro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEcPTpWfrTUjM1OwcpKur3u6dv+okHJnDTOWJzgOMA7J5TqIiDSrj1R2o2njpblMXcZVgl1DQf2V19c7dLfl7t9pcB2YAXAfudG+qt4mXTEriF5F8kxVQb4nNWPAyCdPkZw6c0lVbRNJIPt4LKOK/H2t0Xaqx6GL8U+8CN2TPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3Z16k7Rz4f3jt7;
	Tue, 18 Mar 2025 15:36:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2EEF51A06DC;
	Tue, 18 Mar 2025 15:36:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+PItlnS19YGw--.63204S4;
	Tue, 18 Mar 2025 15:36:58 +0800 (CST)
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
Subject: [PATCH blktests 0/3] blktest: add unmap write zeroes tests
Date: Tue, 18 Mar 2025 15:28:32 +0800
Message-ID: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1+PItlnS19YGw--.63204S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw48try5XFy5Kw1kJFy3XFb_yoW8GFyxp3
	WDKF15tr1xKF17W3ZxWa1UXr15J3yxJryYyw4Iqr1UAry8Zry3Cryqg34YyryfGr1xWw1v
	yF1DXr95uF1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjTR_OzsDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The Linux kernel is planning to support FALLOC_FL_WRITE_ZEROES in
fallocate(2). Add tests for the newly added BLK_FEAT_WRITE_ZEROES_UNMAP
feature flag on the block device queue limit. These tests test block
device unmap write zeroes sysfs interface

        /sys/block/<disk>/queue/write_zeroes_unmap

with various SCSI/NVMe/device-mapper devices.

The /sys/block/<disk>/queue/write_zeroes_unmap interface should return
1 if the block device supports unmap write zeroes command, and it should
return 0 otherwise.

 - scsi/010 test SCSI devices.
 - dm/003 test device mapper stacked devices.
 - nvme/060 test NVMe devices.

Thanks,
Yi.

Zhang Yi (3):
  scsi/010: add unmap write zeroes tests
  dm/003: add unmap write zeroes tests
  nvme/060: add unmap write zeroes tests

 common/rc          | 16 +++++++++++
 tests/dm/003       | 57 ++++++++++++++++++++++++++++++++++++++
 tests/dm/003.out   |  2 ++
 tests/nvme/060     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  4 +++
 tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++
 tests/scsi/010.out |  2 ++
 7 files changed, 205 insertions(+)
 create mode 100755 tests/dm/003
 create mode 100644 tests/dm/003.out
 create mode 100755 tests/nvme/060
 create mode 100644 tests/nvme/060.out
 create mode 100755 tests/scsi/010
 create mode 100644 tests/scsi/010.out

-- 
2.46.1


