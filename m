Return-Path: <linux-fsdevel+bounces-16288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADB89AA09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0554283686
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF839FE5;
	Sat,  6 Apr 2024 09:17:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A863BBE5;
	Sat,  6 Apr 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395076; cv=none; b=M3+WZoVeefJgAA60vUOqboq6VVOtXpstB5Xb89U7Llt89IKkm83e9BLIRwAcOs0XYHig4ABNAXYNHP3KaBpcTKbGmL1jcKQGF5wnQMO0kJjRgnsEMl4527UZjsi8p1vzZQuJIIANBMqm89t0ZGK7FZNPT4NKyzKkZgs3TOliHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395076; c=relaxed/simple;
	bh=Kh1zow+pxK8H/NTVbdXq3rJd+HWiY01On+hqvTU1d5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DaNzT0c6apNxg1LZr3J1dOOvRFVvYEQYA9peLWOLZxAme65QAcXT70cqxKoZKhWoqEyKAbFH8SQL9SSINT7Oju4qtmxqgwgRe5C0s3NsOp/LPZ8iDw3muUMCalD2RjohxgvNc8Rj9gzxKl22aooU87v8iyL066My5+uSSza9Etg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBH4SN0z4f3lfn;
	Sat,  6 Apr 2024 17:17:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E2131A0568;
	Sat,  6 Apr 2024 17:17:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S28;
	Sat, 06 Apr 2024 17:17:51 +0800 (CST)
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
Subject: [PATCH vfs.all 24/26] iomap: convert to use bdev_file
Date: Sat,  6 Apr 2024 17:09:28 +0800
Message-Id: <20240406090930.2252838-25-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S28
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4UJw1fXFy3Jw4rGFyrCrg_yoW8Gw4kpF
	n0kFyUKFW8Gr1UuFZrJ3yxZryYywn8G34UZry5W3y5GrWUtr92gFn5CF1jva48XrWvyan8
	XFyqgry8Cr1rC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

With previous commit both filesystems and raw block device provide
bdev_file while initializing iomap, it's safe to convert to use
bdev_file. Prepare to remove bd_inode from block_device after convert
buffer_head to use bdev_file as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/iomap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8ae384f0eeb1..1386f3a618fe 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,7 +97,7 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
-	struct block_device	*bdev;	/* block device for I/O */
+	struct file		*bdev_file; /* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
@@ -107,13 +107,13 @@ struct iomap {
 
 static inline struct block_device *iomap_bdev(const struct iomap *iomap)
 {
-	return iomap->bdev;
+	return iomap->bdev_file ? file_bdev(iomap->bdev_file) : NULL;
 }
 
 static inline void iomap_set_bdev_file(struct iomap *iomap,
 				       struct file *bdev_file)
 {
-	iomap->bdev = bdev_file ? file_bdev(bdev_file) : NULL;
+	iomap->bdev_file = bdev_file;
 }
 
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
-- 
2.39.2


