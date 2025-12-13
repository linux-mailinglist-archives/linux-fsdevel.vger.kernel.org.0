Return-Path: <linux-fsdevel+bounces-71232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC61CBA318
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 03:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B44E030E25E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAAD2561A2;
	Sat, 13 Dec 2025 02:22:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D324A051;
	Sat, 13 Dec 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592561; cv=none; b=LaN9qAlaWIR3ZqdwMgF80ETOHQi5tZzSV0E621UIzZhUIzKYnMPMwUiEmuwOEfFg1LM59GhmdkxHk54LCuQTpS/P2xMPrAPa6V8meR5r0eHAnO8/okSweiVLt9lhNEGiSmF6AjXMYwKGQYof84/jdwxbeya3RTSfazqbTJB8XUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592561; c=relaxed/simple;
	bh=vHa49KzYROJ486fgwOL4NCzq946Egw8SI1/w3v0jJ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1KRc34bAm32pfsXA3CHyz/hsViLvQSkyrH3LJW1Aih9DJL+zlDLJmjbIkm9UDpsYgTVtqvg3kJKO/PMpNTSrITNsKqw6E7BzsmKLFgZY7paV55KpHMz6eCfFasKfD3o4VUOD5yCV6RiRl34avrl1G+hxjCzzRTtyRngi2oYdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSqpf72cVzYQtxq;
	Sat, 13 Dec 2025 10:22:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4EFD81A07BB;
	Sat, 13 Dec 2025 10:22:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3F1HTzTxpFXQ7Bg--.63968S10;
	Sat, 13 Dec 2025 10:22:28 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next 6/7] ext4: simply the mapping query logic in ext4_iomap_begin()
Date: Sat, 13 Dec 2025 10:20:07 +0800
Message-ID: <20251213022008.1766912-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3F1HTzTxpFXQ7Bg--.63968S10
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyDZFWUKFykXFyktr48Xrb_yoWkKrX_Wa
	y8u3y8CrWrZr4kua9rua43ur1qkFykKw43CFW8Jry5Xa95Jrs5Cr9avr9xGr45WF42gFZ5
	ursrXr4SyF13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In the write path mapping check of ext4_iomap_begin(), the return value
'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
it can be returned directly without checking IOMAP_ATOMIC.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 88144e2ce3e2..39348ee46e5c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3815,15 +3815,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		 */
 		if (offset + length <= i_size_read(inode)) {
 			ret = ext4_map_blocks(NULL, inode, &map, 0);
-			/*
-			 * For atomic writes the entire requested length should
-			 * be mapped.
-			 */
 			if ((map.m_flags & EXT4_MAP_MAPPED) ||
 			    (!(flags & IOMAP_DAX) &&
 			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
-				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
-				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
+				/*
+				 * For atomic writes the entire requested
+				 * length should be mapped.
+				 */
+				if (ret == orig_mlen ||
+				    (!(flags & IOMAP_ATOMIC) && ret > 0))
 					goto out;
 			}
 			map.m_len = orig_mlen;
-- 
2.46.1


