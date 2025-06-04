Return-Path: <linux-fsdevel+bounces-50566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F2ACD581
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0228E17BED7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4EA1EE03D;
	Wed,  4 Jun 2025 02:21:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8A1D2F42;
	Wed,  4 Jun 2025 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003717; cv=none; b=HNBGNU50yQtipPtwTeh4OvI5J2gksfoGlwRS6Y6sWo8zMH9/FNuJymLE6Miuop7W+v3j0MwDzbJpBLMthYMAZTbj5N3dfXfnA9RIgnEBH7ZbJZQo0YREl5MgJJT0kz10NGZfvwVQJp+PlNDejcxKHSfzkrfUWhNIqLEvUY5KWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003717; c=relaxed/simple;
	bh=MEAFDPjrPywPakRo47G9v1FqUr6SzGWw21rDcsjCyvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/k+N61TMySQaNIiq5s3FUW1fe1sehjCbMgJXWXyLqRk0psRBhq6KQR9Z+erj2sD/ETlMA1G4hlc+dQL30c8Bsk+5AkbOj+UmeeTxvbu2PfgBoCCXjg2heueTWh5ITbwagEccWCOpQN7Caj6RxtWWC6emqCVUaMa6WdZDHfKMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bBrth4M3yzYQvP8;
	Wed,  4 Jun 2025 10:21:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A323F1A08F8;
	Wed,  4 Jun 2025 10:21:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+nrT9oedfBOQ--.14997S10;
	Wed, 04 Jun 2025 10:21:47 +0800 (CST)
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
Subject: [PATCH 06/10] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Date: Wed,  4 Jun 2025 10:08:46 +0800
Message-ID: <20250604020850.1304633-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+nrT9oedfBOQ--.14997S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rJr4DAw1fWFykWFW7urg_yoW8CFyUp3
	ZrWa43try5tF47C3Z5WFyI9FyYqa1YyFy7KrW7Cws5u3WUWryjgF47ta4UX3yDJFy7Xay7
	Ka4jkr9rCF4rGwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
default. This feature shall be disabled if any underlying device does
not support it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-table.c | 7 +++++--
 drivers/md/dm.c       | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 6b23e777e10e..4d450713b69d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -599,7 +599,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
 static void dm_set_stacking_limits(struct queue_limits *limits)
 {
 	blk_set_stacking_limits(limits);
-	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
+			    BLK_FEAT_WRITE_ZEROES_UNMAP;
 }
 
 /*
@@ -1851,8 +1852,10 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		limits->discard_alignment = 0;
 	}
 
-	if (!dm_table_supports_write_zeroes(t))
+	if (!dm_table_supports_write_zeroes(t)) {
 		limits->max_write_zeroes_sectors = 0;
+		limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
+	}
 
 	if (!dm_table_supports_secure_erase(t))
 		limits->max_secure_erase_sectors = 0;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5ab7574c0c76..b59c3dbeaaf1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1096,6 +1096,7 @@ void disable_write_zeroes(struct mapped_device *md)
 
 	/* device doesn't really support WRITE ZEROES, disable it */
 	limits->max_write_zeroes_sectors = 0;
+	limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
 }
 
 static bool swap_bios_limit(struct dm_target *ti, struct bio *bio)
-- 
2.46.1


