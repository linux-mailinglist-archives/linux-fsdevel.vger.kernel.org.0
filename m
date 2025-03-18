Return-Path: <linux-fsdevel+bounces-44278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E2A66C91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29D11887ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF602066EE;
	Tue, 18 Mar 2025 07:44:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061A1F4CA4;
	Tue, 18 Mar 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283858; cv=none; b=QWjJBhERrZGI1pwIbjcen69GnAvgASY+YBFqJBYdEnw4jno1eN3dibt3DuxMvYIy7n1P+5uchVWMN01/knDRHXQ5g59/o6Np0+v1kSMGZUjQuSKi/79ZJh+PygNo0HD6s/0YuGuAMbqrKuHz1AbAdEn+ZEXCdkosM5/Yf7AukGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283858; c=relaxed/simple;
	bh=X4pMOYTSWhX0IJM2gqJZG979HxvaHLl2kbgCXf1BEYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhS/AJOHqyOwgeRbkhj9hkTZSj/S/R7vcIsSjSDi+AYPdjzb/bdfPiCIw/HmUB6odzUK4Y1XQQPow4UUWj9I661d6gKiSn9cpbUAvV5LeQMA1wcwkcvCcf1lwqbTgFfFIURXdBvFDC/7HgCHohXbazn5QF3OQJn803PSv2zCrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kF0BLNz4f3lg9;
	Tue, 18 Mar 2025 15:43:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1A06C1A058E;
	Tue, 18 Mar 2025 15:44:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S9;
	Tue, 18 Mar 2025 15:44:12 +0800 (CST)
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
Subject: [RFC PATCH -next v3 05/10] scsi: sd: set BLK_FEAT_WRITE_ZEROES_UNMAP if device supports unmap zeroing mode
Date: Tue, 18 Mar 2025 15:35:40 +0800
Message-ID: <20250318073545.3518707-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCH6189JNlnEt1YGw--.55732S9
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3tF18AF48ur4kZFW5Wrg_yoWDZwc_Ca
	1fur9rJr4vyFyIkrWfXF43Cryvvan7uFyjgrnFqrySyrZ7Zrs5J3Wvvr1av3WUJayUK343
	Aa9rXr1Syr1DJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRitxhPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When the device supports the Write Zeroes command and the zeroing mode
is set to SD_ZERO_WS16_UNMAP or SD_ZERO_WS10_UNMAP, this means that the
device supports unmap Write Zeroes, so set the corresponding
BLK_FEAT_WRITE_ZEROES_UNMAP feature to the device's queue limit.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 950d8c9fb884..652630b410de 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1118,6 +1118,11 @@ static void sd_config_write_same(struct scsi_disk *sdkp,
 	else
 		sdkp->zeroing_mode = SD_ZERO_WRITE;
 
+	if (sdkp->max_ws_blocks &&
+	    (sdkp->zeroing_mode == SD_ZERO_WS16_UNMAP ||
+	     sdkp->zeroing_mode == SD_ZERO_WS10_UNMAP))
+		lim->features |= BLK_FEAT_WRITE_ZEROES_UNMAP;
+
 	if (sdkp->max_ws_blocks &&
 	    sdkp->physical_block_size > logical_block_size) {
 		/*
-- 
2.46.1


