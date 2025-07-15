Return-Path: <linux-fsdevel+bounces-54906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC4B04EB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C601E7AD328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90E2D0C99;
	Tue, 15 Jul 2025 03:27:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4A6FBF;
	Tue, 15 Jul 2025 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550035; cv=none; b=XTtC827gxid35cE4ReN54YC3MA3iWowSLfPmwWMz+CYKmqLtG8SgzI8vxHgC1J02n/hBV5VU+q3ME3daP0BC6Ws+p4NPkvqCXnlle+ln6Fz1UPJvUencn+olGRG/PPK7xH+Cf1yZowGgIRblO2M6mAvQW6KsDbsS2yFv4YM+xpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550035; c=relaxed/simple;
	bh=atfrjIauy1ItkJU6XhIyOdBfAhDGceSKKQb+tx5X7OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeF07ZVcHBhOvL+dY1IVKUNY8eKZQLeQjAeF1VIEJVLxEaceCxpvZBiYNpEE8N7FhntXK2R9KIiBlI5rwk+xnr6J2BS9j0/d325b98QSWRli02hheBwH29VzDXIpQ3yFEtT8CszvvTFFuu9ptepJ2DS0w3n0C2CbSm1HaEiHGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bh4P95nYdzYQtyd;
	Tue, 15 Jul 2025 11:27:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8D56D1A0FB3;
	Tue, 15 Jul 2025 11:27:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhOFynVor4g7AQ--.28397S4;
	Tue, 15 Jul 2025 11:27:07 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sfr@canb.auug.org.au,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] ext4: fix the compile error of EXT4_MAX_PAGECACHE_ORDER macro
Date: Tue, 15 Jul 2025 11:12:03 +0800
Message-ID: <20250715031203.2966086-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhOFynVor4g7AQ--.28397S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4xXryxuFWrtw4UGF4UArb_yoWkWrX_Z3
	WxZr48Ww15Xw4vkrsYyF9Iqrn29a4Fkr1Y9FW7tF93WF1UXrZ8Can3Ga4xAF45WrWUXrZx
	ZFykJFykKF1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since both the input and output parameters of the
EXT4_MAX_PAGECACHE_ORDER should be unsigned int type, switch to using
umin() instead of min(). This will silence the compile error reported by
_compiletime_assert() on powerpc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250715082230.7f5bcb1e@canb.auug.org.au/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1bce9ebaedb7..6fd3692c4faf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5204,7 +5204,7 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
  * where the PAGE_SIZE exceeds 4KB.
  */
 #define EXT4_MAX_PAGECACHE_ORDER(i)		\
-		min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
+		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
 void ext4_set_inode_mapping_order(struct inode *inode)
 {
 	if (!ext4_should_enable_large_folio(inode))
-- 
2.46.1


