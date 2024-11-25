Return-Path: <linux-fsdevel+bounces-35781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C99D857B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08406B3E479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDD1ADFEA;
	Mon, 25 Nov 2024 11:46:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6ED199947;
	Mon, 25 Nov 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535195; cv=none; b=Ofob12PAmkTcF/zI9zsTzpG8cNMQWW3z7MmaChN/B8Z3nDbUIN62OgTSbK8KlFrzWv5RS0V9mJ3jensoAtcnB1d14c+NR1U2+jJ3dQt5uWisQqCLIIpJ+9B6YkMwekxvhX7BmHNTjq2a6hAq8m2c4Z4idSTaqP5fMynZX4IiIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535195; c=relaxed/simple;
	bh=/2j/eWlrAYGxOEIvn8+oQk9bo/y0Fur0VRbGnmnV0k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhGbm/diOgEDZrXW5uB83bEC6UUpnvjj10z95z6NVKSvVFSnMkhTKFhFTa7fXCzO2nUuQGA/6jndcJZqpzV9Nab6t2Ssw0esjVe2vBqJy12HD9EsYi3yxst8qx+Vp4+8EADnDdXkPqUnEOO2n9mcTr7hFIT7iXbDFDXaaK1GXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxkS84dYxz4f3kq5;
	Mon, 25 Nov 2024 19:46:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 445851A0197;
	Mon, 25 Nov 2024 19:46:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S10;
	Mon, 25 Nov 2024 19:46:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6/9] ext4: correct the journal credits calculations of allocating blocks
Date: Mon, 25 Nov 2024 19:44:16 +0800
Message-ID: <20241125114419.903270-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
References: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1DurW5Ww4rKrWrZFWDJwb_yoW8Ar1kp3
	ZxCFW8Gr1rZw1UuFW8Ga1UXr18Wa1kGa17ZFWrAw1aqFZxJryfGrn8t3W0vFyFqFWxZF1Y
	vF4rK34UJ3W5ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The journal credits calculation in ext4_ext_index_trans_blocks() is
currently inadequate. It only multiplies the depth of the extents tree
and doesn't account for the blocks that may be required for adding the
leaf extents themselves.

After enabling large folios, we can easily run out of handle credits,
triggering a warning in jbd2_journal_dirty_metadata() on filesystems
with a 1KB block size. This occurs because we may need more extents when
iterating through each folio. Therefore, we should modify ext4_ext_index
trans_blocks() to include a count of the leaf extents as well.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 5 +++--
 fs/ext4/inode.c   | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..1dbcf0cb8003 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2405,9 +2405,10 @@ int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 	depth = ext_depth(inode);
 
 	if (extents <= 1)
-		index = depth * 2;
+		index = depth * 2 + extents;
 	else
-		index = depth * 3;
+		index = depth * 3 +
+			DIV_ROUND_UP(extents, ext4_ext_space_block(inode, 0));
 
 	return index;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e7b485b0f81b..0ef41e264ee8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5687,7 +5687,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 	 * Now let's see how many group bitmaps and group descriptors need
 	 * to account
 	 */
-	groups = idxblocks + pextents;
+	groups = idxblocks;
 	gdpblocks = groups;
 	if (groups > ngroups)
 		groups = ngroups;
-- 
2.46.1


