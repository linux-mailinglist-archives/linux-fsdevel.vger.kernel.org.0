Return-Path: <linux-fsdevel+bounces-44274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F38A66C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7446D7AA239
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229D1FCF47;
	Tue, 18 Mar 2025 07:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E511E8356;
	Tue, 18 Mar 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283855; cv=none; b=YZQnnBY7epYHYx/v7z6r+fV6fiKu4uRDLUh9entU01uWnudA5luxVdDAAptO/UMlBlcCUOFZV/oXE4eRDSUTQ0/OZAePXgll3E538jkVvlOy6rr55rKnrmFEMx23gMaSkQRFfe6KwGi6KAclVP/BH6Do4485lu1rRV9lL4LKrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283855; c=relaxed/simple;
	bh=0e8UqTF5vmvRPxdty/jYK2vi3jsHPwFg82fdgBIcTco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCo6QRS91xSxUAzOg9KZ0wxVhCrLhu8cIRkH8RF+Cx9O2tJHCojzTd28P2T48tFG/mpVs5+f48eJ9irk/Cv9XzMkdyl6eTCHVNMdwBWcPVT7VX2tZtRmhzZq4UqR/JvvPyuij/L53xuB7hyKBm1bKa2XE51AMeS0piApead2FX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kB6d7Bz4f3m6s;
	Tue, 18 Mar 2025 15:43:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F28C01A12D5;
	Tue, 18 Mar 2025 15:44:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S6;
	Tue, 18 Mar 2025 15:44:10 +0800 (CST)
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
Subject: [RFC PATCH -next v3 02/10] nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports DEAC bit
Date: Tue, 18 Mar 2025 15:35:37 +0800
Message-ID: <20250318073545.3518707-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH6189JNlnEt1YGw--.55732S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8Ar4xJF4kuF15CrWUCFg_yoW8Cw4kpF
	43Xa42k348WFsrC3sxZw47AFy3Gw1kGa4jgFn7K34Ygr13A34Fgr1rKa43XFWkX393uayF
	yFWDt3s7Ca15XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRpwZwUUUUU=
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
index 24c3e1765d49..3af6a50f07ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2223,22 +2223,25 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
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
+		if (lim.max_write_zeroes_sectors)
+			lim.features |= BLK_FEAT_WRITE_ZEROES_UNMAP;
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


