Return-Path: <linux-fsdevel+bounces-39281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EDA12322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515B97A1CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44124225D;
	Wed, 15 Jan 2025 11:52:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0942416A0;
	Wed, 15 Jan 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941935; cv=none; b=uVlU4QLYpNKLJUG91aStGDKSq0IaCZPedtF1bCIkG9GrIxWQPdw0MvSWOYfBIGuwG/zgNFECJloVzq3Qi7SRWhDu9NJtTTpkhsE//3f6c7K8U9ailk4EuXqJXDJV13C7SPW+C73R+6TJfd3UMO3F/QsI6B3X2DH+9UHlvmAZyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941935; c=relaxed/simple;
	bh=34A7PDLZ8mF6GKEkFqLnWG4X8tYtxPQ2DBhm0IJb0Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKiDj+9vUlzuGyoLCpIsci81HKgiAKGUj9taIIj+4GXJn435fkEpxZyDP8hyJ4hRaPWs7MPuWE1BWGYpxiOSCnhVjFXHXjU7fiGUxprNzR9Ue6/85i5vrQpCY6VJoO2BfxCC7VT8AdVHlJuR4kf0vtc4uYbmrvoo/ii9cK8t/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YY4953bZ2z4f3jqy;
	Wed, 15 Jan 2025 19:51:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ABB2C1A0B62;
	Wed, 15 Jan 2025 19:52:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9aoYdnvK0ZBA--.21959S6;
	Wed, 15 Jan 2025 19:52:08 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v2 2/8] nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports DEAC bit
Date: Wed, 15 Jan 2025 19:46:31 +0800
Message-Id: <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9aoYdnvK0ZBA--.21959S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8Ar4xJF4kuF15CrWUCFg_yoW8CFW5pF
	W3Xa42k348WF47C3sxXw47AFy5Gw1kGa4UWF1xK345Wr15A34Fgr1Fka43XrWkX3s3WayY
	yF4DK3srCa15XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When the device supports the Write Zeroes command and the DEAC bit, it
indicates that the deallocate bit in the Write Zeroes command is
supported, and the bytes read from a deallocated logical block are
zeroes. This means the device supports unmap Write Zeroes, so set the
BLK_FEAT_WRITE_ZEROES_UNMAP feature to the device's queue limit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a970168a3014..8a359370154d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2210,22 +2210,25 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
-	ret = queue_limits_commit_update(ns->disk->queue, &lim);
-	if (ret) {
-		blk_mq_unfreeze_queue(ns->disk->queue);
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
+		if (lim.max_write_zeroes_sectors)
+			lim.features |= BLK_FEAT_WRITE_ZEROES_UNMAP;
+	}
+
+	ret = queue_limits_commit_update(ns->disk->queue, &lim);
+	if (ret) {
+		blk_mq_unfreeze_queue(ns->disk->queue);
+		goto out;
+	}
+
+	set_capacity_and_notify(ns->disk, capacity);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
-- 
2.39.2


