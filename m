Return-Path: <linux-fsdevel+bounces-16281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7889A9FC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02131C2109A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E073A8D0;
	Sat,  6 Apr 2024 09:17:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9A37163;
	Sat,  6 Apr 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395073; cv=none; b=TZRKppq0rkdF+ei9V10HkzDmT/1jv4vO7FKPBD6afAyT1tkuQeAcr0kssOGyMxxnlt78GXSqv1mgfW9fwTuzvinaAvBm769jCROvK2MgiFftvAg0IEIZXMz+P17BkaAvjgtV2ITRusS8M/oanaM8Vs4dYqzuKBaWOFnw6zi0+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395073; c=relaxed/simple;
	bh=jTqQFKQ6Hwm8j3owKWdmo2+A5Arsz1b5/slXYeVdVUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GlOZxvgtJ+YUGjjEfy+b5iLtzfX6yb8Bdn7NsReUGB5ekS0AAEDSuOxwjItrUNV4HHRhbJzMjybka5NxlOVn2ds1XqN/jrcpxTPLj8bb8W0PLTXqCSUQvwqwkMeFviL1+ttowHdIKucPFOfQl+2JQzeL4LsokhequDyJo0qLVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBF0v3tz4f3lVn;
	Sat,  6 Apr 2024 17:17:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 97EA51A058D;
	Sat,  6 Apr 2024 17:17:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S22;
	Sat, 06 Apr 2024 17:17:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 18/26] scsi: use bdev helper in scsi_bios_ptable()
Date: Sat,  6 Apr 2024 17:09:22 +0800
Message-Id: <20240406090930.2252838-19-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S22
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1UZw13ur4xJF1UGw47CFg_yoWfKFX_CF
	WS9w17Wr4xAan2qr15tF4avryvva1qgF109F4Sqasavw1UXr95Jryvqr13Aw47Gr4UAw1r
	C3W7XrWayrsFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

scsi_bios_ptable() is reading without opening disk as file, use the new
helper to read into block device page cache to prevent access bd_inode
directly from scsi.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/scsi/scsicam.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index e2c7d8ef205f..1c99b964a0eb 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,11 +32,10 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
 	unsigned char *res = NULL;
 	struct folio *folio;
 
-	folio = read_mapping_folio(mapping, 0, NULL);
+	folio = bdev_read_folio(bdev_whole(dev), 0);
 	if (IS_ERR(folio))
 		return NULL;
 
-- 
2.39.2


