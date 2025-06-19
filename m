Return-Path: <linux-fsdevel+bounces-52217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC4AE03B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2880E7A5FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9F251791;
	Thu, 19 Jun 2025 11:32:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C32459DE;
	Thu, 19 Jun 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332719; cv=none; b=sUEz2lUe0dOK1SR5wTVr1NRl5Q3Aane74xm6wACpwddP+F8+zmh4roYhi2W/9DDxAjivMglipPEvO1QCaTc0WFhMekNStHBZRPSKJpMmqO5gEFovYWF3cYX6mfs2eASQqtpUdHENx5VVAjUI11sWwJQwOStf6NKdjZ92wVxKXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332719; c=relaxed/simple;
	bh=FCBFLnmYvvjZmGqTyBAIDLtgtBH4FovV38bNkXCCplk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZUWh4vYQBa9vQDHuO30Uo9rfBgDUgllBr771oRFmDDqEeMThxcQodq2v+uZi3TqKpkfscYzvvAXxHe5mAT+j4rt1cPAjdkpDY4bjIJsF/XPUlDAgv1q3WI0sgC4tqqQ25leCT6YMZflf6JSWqmBp+BDwRr5ey+/zOIVRjbY/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNS03z8zKHMxF;
	Thu, 19 Jun 2025 19:31:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 590531A193E;
	Thu, 19 Jun 2025 19:31:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S9;
	Thu, 19 Jun 2025 19:31:50 +0800 (CST)
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
Subject: [PATCH v2 5/9] dm: clear unmap write zeroes limits when disabling write zeroes
Date: Thu, 19 Jun 2025 19:18:02 +0800
Message-ID: <20250619111806.3546162-6-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCH618Y9VNoihn_Pw--.51230S9
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4xXr4xAr18AFWkKw17ZFb_yoWDGwb_Ca
	4ruFWDXry5CF1Sqr43AFn3ZrWYkryUXF18WF1Iq3sagFW8Xr95CF1vvFyY93W8ZFyjkF4U
	ZF1kX34S9rs7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRRtCztUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The unmap write zeroes limits have been set to the stacking queue limits
by default in blk_set_stacking_limits() and blk_stack_limits(), but it
should be cleared if any underlying device does not support it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 drivers/md/dm-table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 24a857ff6d0b..d9d5e6aa5707 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -2065,8 +2065,10 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		limits->discard_alignment = 0;
 	}
 
-	if (!dm_table_supports_write_zeroes(t))
+	if (!dm_table_supports_write_zeroes(t)) {
 		limits->max_write_zeroes_sectors = 0;
+		limits->max_hw_wzeroes_unmap_sectors = 0;
+	}
 
 	if (!dm_table_supports_secure_erase(t))
 		limits->max_secure_erase_sectors = 0;
-- 
2.46.1


