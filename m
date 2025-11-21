Return-Path: <linux-fsdevel+bounces-69347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2698FC7783D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D92D4E8272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E612F9D94;
	Fri, 21 Nov 2025 06:10:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99A2DCBF2;
	Fri, 21 Nov 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705431; cv=none; b=IfqmOzmgmClgHy6rVADLkQmUxGfTeYgNnHyiqnXII9BhfSom5PyAV9BOJYaue1fEAcS8634rj2GsZ5FVWX/v96V9iOeFB+RozRJFlPjOu/fGumxfgHx2rDfmpqV0p0XtJxIXa9pWmR0VZ0D1HYRKmYCDyXVpoJU69pkuy6R6N2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705431; c=relaxed/simple;
	bh=STYeGxJAFvHud+GfnAY6pRfEKgGU0O7QjI24y13MnBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px5+m4TszayTrdHXSrdnJGhowwNabBkZHLHJN6YfpCSicj9Enzy73zLvyJujxxecyJwLoMxlh6xGKKJG0O9DonJbrZQqTvE2gSkUcAsPiw/CAUsUqvgwEMCvCzF0HRSOK5qm2K6Yq961hhaVUItLgqgOTU+LTqMaL442nGzSMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvR6bpqzKHMfQ;
	Fri, 21 Nov 2025 14:09:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B0F441A1A36;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S9;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 05/13] ext4: correct the mapping status if the extent has been zeroed
Date: Fri, 21 Nov 2025 14:08:03 +0800
Message-ID: <20251121060811.1685783-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15XFW8XF1rGw15XF43ZFb_yoW8Ar1xpF
	yxAF1rGr4j9a4j93yI9F48Zr17C3W8Gr4UAr4fX3yYgas3Kr1Fgr15ta4FyFyrW3y8Zayj
	vFW0k345GasxCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Before submitting I/O and allocating blocks with the
EXT4_GET_BLOCKS_PRE_IO flag set, ext4_split_convert_extents() may
convert the target extent range to initialized due to ENOSPC, ENOMEM, or
EQUOTA errors. However, it still marks the mapping as incorrectly
unwritten. Although this may not seem to cause any practical problems,
it will result in an unnecessary extent conversion operation after I/O
completion. Therefore, it's better to correct the returned mapping
status.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2db84f6b0056..19338f488550 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3916,6 +3916,8 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
+		int depth;
+
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						  flags, allocated);
 		if (IS_ERR(path))
@@ -3931,7 +3933,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto errout;
 		}
-		map->m_flags |= EXT4_MAP_UNWRITTEN;
+		/* Don't mark unwritten if the extent has been zeroed out. */
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
+		if (IS_ERR(path))
+			return path;
+		depth = ext_depth(inode);
+		if (ext4_ext_is_unwritten(path[depth].p_ext))
+			map->m_flags |= EXT4_MAP_UNWRITTEN;
 		goto out;
 	}
 	/* IO end_io complete, convert the filled extent to written */
-- 
2.46.1


