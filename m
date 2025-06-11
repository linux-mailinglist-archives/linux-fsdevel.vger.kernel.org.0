Return-Path: <linux-fsdevel+bounces-51313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 964FFAD5403
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD300189351F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C337273D74;
	Wed, 11 Jun 2025 11:29:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5325D8F5;
	Wed, 11 Jun 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641386; cv=none; b=rXvo60JG27lzH3DxWAvIo0OYvALpG3mozuIc8/hFXilFPVHWevSEqy446IGo98hJ1zjj5mW7OTEeBrABJx9en33Wpnihhny6m/WC+3vrM3GH2foktu6rAPGJIz15wJR9F77ayD5UREFWacOMlpRkVmTkZtdxccE1J3CxnVPXC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641386; c=relaxed/simple;
	bh=PjZbjonEikl0ssZOOSWJaqyCJF5bAU8HJZK179JXyJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/vvBgQlHz7y5lblLXN2dIEoylMkRW+k3gSyTdE4CQhJ20835Id2Wz05HQIBON8T3Blgtykd9AKQKJiTPhQjyCvtueJKnOCYce/TcZMx8gZqL66FCPKSs7PLd8dmUYj9hHdJVUp13c3bongqg0yThlcg1CUkX2RdkyTSKgOV+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bHNjg2KxmzKHNRX;
	Wed, 11 Jun 2025 19:29:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A7A241A0E76;
	Wed, 11 Jun 2025 19:29:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacOXaElofvDPOw--.32023S10;
	Wed, 11 Jun 2025 19:29:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 6/6] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
Date: Wed, 11 Jun 2025 19:16:25 +0800
Message-ID: <20250611111625.1668035-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacOXaElofvDPOw--.32023S10
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7Zw48KrW5GFWrCF1fCrg_yoW8XF4xp3
	Z3CF1rJ34rWw4v9a18Ww42qr48Ka1kGa17uFWfAw15JFZxZr92krnFq34rAa45tFWfKw1q
	qF4Yyry3Gw1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbAnY7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The calculation of journal credits in ext4_meta_trans_blocks() should
include pextents, as each extent separately may be allocated from a
different group and thus need to update different bitmap and group
descriptor block.

Fixes: 0e32d8617012 ("ext4: correct the journal credits calculations of allocating blocks")
Reported-by: Jan Kara <jack@suse.cz>
Closes: https://lore.kernel.org/linux-ext4/nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9835145b1b27..9b6ebf823740 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6218,7 +6218,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 	int ret;
 
 	/*
-	 * How many index and lead blocks need to touch to map @lblocks
+	 * How many index and leaf blocks need to touch to map @lblocks
 	 * logical blocks to @pextents physical extents?
 	 */
 	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
@@ -6227,7 +6227,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 	 * Now let's see how many group bitmaps and group descriptors need
 	 * to account
 	 */
-	groups = idxblocks;
+	groups = idxblocks + pextents;
 	gdpblocks = groups;
 	if (groups > ngroups)
 		groups = ngroups;
-- 
2.46.1


