Return-Path: <linux-fsdevel+bounces-12469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29285F8C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4BE1C24BA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2771474D0;
	Thu, 22 Feb 2024 12:51:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3D136995;
	Thu, 22 Feb 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606304; cv=none; b=A7u7yYji3TB2wiZNt3wP4RmbMYYV9zvIHiHYDLr8r31hwWY7sYlIYq8alSAC6HkS5yC7Byer1fInjJO/apur9gI3+7EGzQsA9/KNg4/LkgsFG4+WfBEGnh9ANudWa2fgHiEK+0DhTyrumFr6+PJVwMgi7jtyMNZs25WernefRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606304; c=relaxed/simple;
	bh=iof+4ZVDwG4KIOz/TBbRiUr+PFy35FDOGG549ov2RAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdHpC+iHalMc0puCQARagz4m65htPc3/fuqySgs3vXcyrGEOwISrmc9ZdjiwEykCT3EpsMllbvt81XqfqcUOKuxvTjLUJZdrulleBenyZzWLh6HUn3YPcX6wyTvQRI6bthhlVaxt4tmXB8gnGPv6Spf3jZXGnCQ06Z4StF1aAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgY1D3QhBz4f3m7P;
	Thu, 22 Feb 2024 20:51:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9F4051A0FED;
	Thu, 22 Feb 2024 20:51:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S11;
	Thu, 22 Feb 2024 20:51:35 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [RFC v4 linux-next 07/19] erofs: prevent direct access of bd_inode
Date: Thu, 22 Feb 2024 20:45:43 +0800
Message-Id: <20240222124555.2049140-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S11
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW8CryfJry3Aw4UZr43Wrg_yoW3GFX_XF
	yxJr48W3y3X34ftFs8G3WUZrsFgw4YkF4F9FW7JrZxWF1UXr95ZrZrJ3W8Jr4DWw4kGFZ8
	AFs3Wr17tr4rXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to get inode
for the file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 433fc39ba423..dc2d43abe8c5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -70,7 +70,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	if (erofs_is_fscache_mode(sb))
 		buf->inode = EROFS_SB(sb)->s_fscache->inode;
 	else
-		buf->inode = sb->s_bdev->bd_inode;
+		buf->inode = file_inode(sb->s_bdev_file);
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
-- 
2.39.2


