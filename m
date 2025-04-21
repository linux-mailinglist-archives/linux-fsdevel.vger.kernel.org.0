Return-Path: <linux-fsdevel+bounces-46774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C391A94AF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 04:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4960A3B3342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 02:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934925D55A;
	Mon, 21 Apr 2025 02:25:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0525A659;
	Mon, 21 Apr 2025 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202342; cv=none; b=MVucAtCEfc2KDKQtCO9i2xKVhWdOCr1ebLuC9f7X1mRBI5LRE4UBuZVv4bh5VXnDNsEC3rCKYspqCjMXyMibg8codMDVtagWed883GOifM/Qy/2DdPhxWCTHge4wlcAz3yadHxIaMHMJqMcRfj8qNKgRpDo9imh40LqfLyej/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202342; c=relaxed/simple;
	bh=1eah6+l3LHoQXYxuCvzywyHjC7gWndEgK9lEiAcaiQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9pTfPiqn3WhtgZFP+tgCd4FQm3fUgmqP7MBfkM5BPm/j0CbtLE8WcJjCWke7zqI+jM05pk0IotQdAMZtnQFhdEELKCJHBpMu46XSdL5HBBl/n9GucXYmgkbQo3cxHx5UflHWsGkqbACDaXMfyaG0WHuyJYW0QDwwwhUQUX5Mlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zgq2r46bqz4f3jXd;
	Mon, 21 Apr 2025 10:25:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6A7F41A018D;
	Mon, 21 Apr 2025 10:25:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+MrAVoFxZkKA--.3102S10;
	Mon, 21 Apr 2025 10:25:32 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v4 06/11] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Date: Mon, 21 Apr 2025 10:15:04 +0800
Message-ID: <20250421021509.2366003-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m1+MrAVoFxZkKA--.3102S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rJr4DAw1fAryDJw4rAFb_yoW8CFyUp3
	ZrWa4ayry5tF47C3Z5uFyI9FyYqa1YkFy7KrZrCws5u3W5GryUWF47ta47X3yDJFy7Xay3
	Ka4jkr9ruF4rCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
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
index 35100a435c88..56141d585ef8 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
 static void dm_set_stacking_limits(struct queue_limits *limits)
 {
 	blk_set_stacking_limits(limits);
-	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
+			    BLK_FEAT_WRITE_ZEROES_UNMAP;
 }
 
 /*
@@ -1852,8 +1853,10 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
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


