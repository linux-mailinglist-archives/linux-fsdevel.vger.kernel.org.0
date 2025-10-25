Return-Path: <linux-fsdevel+bounces-65612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF8C089ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFCD3BF226
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A532D24B8;
	Sat, 25 Oct 2025 03:30:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F462517AA;
	Sat, 25 Oct 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363014; cv=none; b=Vh051i/Hu3mMujOT0NtRURNntiUU64W5WoR1ekiAbyMbe7pCbVYyhseIAoo3cBymnJhlpOKPiIl5StVYjuwEYu5WZeNOMllwd6S8o4rDuwJii3b1BlQ6WQpUNwZAw5/KGVRo5nZkgpRLQahckgCWHrB6WEdCA/Do2G2VKF/2M2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363014; c=relaxed/simple;
	bh=FmVUn3+xEVIo1jPDBKJqn+eT2s2jLQkSeEAUP66Zy80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjON14I9FBX4KdzdqRDLALqzbjTYfMppS5H9DGs/Odv4S12xSl0eA0hqmIxggwX1y+qYw/CmSszSvhs4GVbGix0Vtuze3CnWOsMQnsygw0CTsLqCrbDKN8tsVi4aOzW02qBVHa6pCWW5D/nvOdHsBFX1gg1Ao2zJdeL2x2k2lyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcT2qr3zKHMQT;
	Sat, 25 Oct 2025 11:29:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1C8D11A1B52;
	Sat, 25 Oct 2025 11:30:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S26;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH 22/25] fs/buffer: prevent WARN_ON in __alloc_pages_slowpath() when BS > PS
Date: Sat, 25 Oct 2025 11:22:18 +0800
Message-Id: <20251025032221.2905818-23-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S26
X-Coremail-Antispam: 1UD129KBjvJXoWxJrykCF4kCr4rKry7uryUZFb_yoW8uF15pF
	4rKanxtrWkKF429Fy3AanxtFy3Kas5JayUCFWxW3s3Z3WDGF9I9rnrC3WUZF1rtFyxAFy0
	qF45ArWUuF17trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJIgAAsV

From: Baokun Li <libaokun1@huawei.com>

In __alloc_pages_slowpath(), allocating page units greater than order-1
with the __GFP_NOFAIL flag may trigger an unexpected WARN_ON. To avoid
this, handle the case separately in grow_dev_folio(). This ensures that
buffer_head-based filesystems will not encounter the warning when using
__GFP_NOFAIL to read metadata after BS > PS support is enabled.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/buffer.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbed..2f5a7dd199b2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1031,6 +1031,35 @@ static sector_t folio_init_buffers(struct folio *folio,
 	return end_block;
 }
 
+static struct folio *blkdev_get_folio(struct address_space *mapping,
+				      pgoff_t index, fgf_t fgp_flags, gfp_t gfp)
+{
+	struct folio *folio;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+
+	/*
+	 * Allocating page units greater than order-1 with __GFP_NOFAIL in
+	 * __alloc_pages_slowpath() can trigger an unexpected WARN_ON.
+	 * Handle this case separately to suppress the warning.
+	 */
+	if (min_order <= 1)
+		return __filemap_get_folio(mapping, index, fgp_flags, gfp);
+
+	while (1) {
+		folio = __filemap_get_folio(mapping, index, fgp_flags,
+					    gfp & ~__GFP_NOFAIL);
+		if (!IS_ERR(folio) || !(gfp & __GFP_NOFAIL))
+			return folio;
+
+		if (PTR_ERR(folio) != -ENOMEM && PTR_ERR(folio) != -EAGAIN)
+			return folio;
+
+		memalloc_retry_wait(gfp);
+	}
+
+	return folio;
+}
+
 /*
  * Create the page-cache folio that contains the requested block.
  *
@@ -1047,8 +1076,8 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	struct buffer_head *bh;
 	sector_t end_block = 0;
 
-	folio = __filemap_get_folio(mapping, index,
-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	folio = blkdev_get_folio(mapping, index,
+				 FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
 	if (IS_ERR(folio))
 		return false;
 
-- 
2.46.1


