Return-Path: <linux-fsdevel+bounces-65615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F87C08A0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8283BE54D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DC2DF703;
	Sat, 25 Oct 2025 03:30:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E131DE2A7;
	Sat, 25 Oct 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363016; cv=none; b=a36vHekdV+Cnwyf0ZIn+97A0W+5xBb1vzZvpWyT3+lErvhnBcXJv0nvfnuum1BF96F5f5Ma9vBmzOr8ON9mQWNbvRSzVMlo2gqdRXTs0K4+20+h2YENfehp0b16gcuauNaBRcUWRB/ve8WxjsqM3Hkff0pkTT0mkm4fDUSVkE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363016; c=relaxed/simple;
	bh=HJG6BV4y/laly37/ga9zMZpAoAiq+tujKGnfMeijWwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4CYGkT5e1PKnTd+96yIO7EP/MGtRfZSALlquBxVOM4M4E1Go5Xz9PmTYvZ27FdSQNF3d1A1tvfQSy4x0lQqnHjvzb6chFIwsBF+VjvY9YbFmAsSzl/mxU58bq5HB8X3KMZJS/HqegwLk1Jc5EmzwaHb7cK+XEaoAb+18lW81YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcS20J6zKHMP3;
	Sat, 25 Oct 2025 11:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F1A241A116C;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S11;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
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
Subject: [PATCH 07/25] ext4: support large block size in ext4_calculate_overhead()
Date: Sat, 25 Oct 2025 11:22:03 +0800
Message-Id: <20251025032221.2905818-8-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S11
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DZw45Zw13CF1kKFy7trb_yoW8WF1xp3
	Z3GryxGrWruFy8uanrWa9rJF15K3yxGFyUKFWa9ry3urW7ta4S9ry3KFy5tr4xXFWxuryS
	v3W5KrWfuF15Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9I6gAEsA

From: Baokun Li <libaokun1@huawei.com>

ext4_calculate_overhead() used a single page for its bitmap buffer, which
worked fine when PAGE_SIZE >= block size. However, with block size greater
than page size (BS > PS) support, the bitmap can exceed a single page.

To address this, we now use __get_free_pages() to allocate multiple pages,
sized to the block size, to properly support BS > PS.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d353e25a5b92..7338c708ea1d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4182,7 +4182,8 @@ int ext4_calculate_overhead(struct super_block *sb)
 	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	ext4_fsblk_t overhead = 0;
-	char *buf = (char *) get_zeroed_page(GFP_NOFS);
+	gfp_t gfp = GFP_NOFS | __GFP_ZERO;
+	char *buf = (char *)__get_free_pages(gfp, sbi->s_min_folio_order);
 
 	if (!buf)
 		return -ENOMEM;
@@ -4207,7 +4208,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 		blks = count_overhead(sb, i, buf);
 		overhead += blks;
 		if (blks)
-			memset(buf, 0, PAGE_SIZE);
+			memset(buf, 0, sb->s_blocksize);
 		cond_resched();
 	}
 
@@ -4230,7 +4231,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	}
 	sbi->s_overhead = overhead;
 	smp_wmb();
-	free_page((unsigned long) buf);
+	free_pages((unsigned long)buf, sbi->s_min_folio_order);
 	return 0;
 }
 
-- 
2.46.1


