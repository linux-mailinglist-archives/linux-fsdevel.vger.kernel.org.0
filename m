Return-Path: <linux-fsdevel+bounces-52211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE9AE0392
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7055A3B795E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F12022B8B3;
	Thu, 19 Jun 2025 11:31:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B9132103;
	Thu, 19 Jun 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332713; cv=none; b=NsX7GOiiO2XR4ByWm9zNBgwwwtdVmUhfR+IAEG9MOMSCK2Iysc+v0otFbED41qyE5srCtO9nNz/L6x/I9O8dJmOOl625mQSacMY0e4a0CsjeAmKqBiz6AF7Adp8cwjzP++a0tI6r8uCFkaF3YryjP3QgsUcAr0qx9WFsmhWYuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332713; c=relaxed/simple;
	bh=8QBLpXQnmxXivG5DrxsrjAqte3GV9jc+kVp5fw8mp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfpR3kjDot3tH+8sbSTswwDoK45syLt83eUPGjif1S6gAkkZtxMJLPPoO0IX9+TXJNNmtwsQOWbI4J4hOrN9Ef4AAlFk9ub7UHuoB/rL0TRG6WREjO0XKspfk3+PmlIBDZ3wRhcm59e+n1YiezAvbSBbtKpTVOW6jtc3lVHevmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNP1J8XzYQvKc;
	Thu, 19 Jun 2025 19:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 19EF81A10F9;
	Thu, 19 Jun 2025 19:31:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S6;
	Thu, 19 Jun 2025 19:31:47 +0800 (CST)
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
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit
Date: Thu, 19 Jun 2025 19:17:59 +0800
Message-ID: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH618Y9VNoihn_Pw--.51230S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8Ar4xJF4kuF1UtryUAwb_yoW8Cw47pF
	W3Xa42kw1kWFsrC3sxJw47AFy5G3s5Ja4UKF97K3sYgr13A34Sgr1Fka43XaykW3s3Wa4F
	yF4DK3s7Ca98XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When the device supports the Write Zeroes command and the DEAC bit, it
indicates that the deallocate bit in the Write Zeroes command is
supported, and the bytes read from a deallocated logical block are
zeroes. This means the device supports unmap Write Zeroes operation, so
set the max_hw_wzeroes_unmap_sectors to max_write_zeroes_sectors on the
device's queue limit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/nvme/host/core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..90af4a15b696 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2420,22 +2420,24 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	else
 		lim.write_stream_granularity = 0;
 
-	ret = queue_limits_commit_update(ns->disk->queue, &lim);
-	if (ret) {
-		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
-		goto out;
-	}
-
-	set_capacity_and_notify(ns->disk, capacity);
-
 	/*
 	 * Only set the DEAC bit if the device guarantees that reads from
 	 * deallocated data return zeroes.  While the DEAC bit does not
 	 * require that, it must be a no-op if reads from deallocated data
 	 * do not return zeroes.
 	 */
-	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
+	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
 		ns->head->features |= NVME_NS_DEAC;
+		lim.max_hw_wzeroes_unmap_sectors = lim.max_write_zeroes_sectors;
+	}
+
+	ret = queue_limits_commit_update(ns->disk->queue, &lim);
+	if (ret) {
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		goto out;
+	}
+
+	set_capacity_and_notify(ns->disk, capacity);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue, memflags);
-- 
2.46.1


