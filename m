Return-Path: <linux-fsdevel+bounces-65604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E632C089A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 120624E1C5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64E2D8371;
	Sat, 25 Oct 2025 03:30:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB719DF6A;
	Sat, 25 Oct 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363012; cv=none; b=BcPRBG/jUJPEh8xVLKzH3+zUY60odNClWrHqbJQTnpYwZJXcU+UQ06msjSWPhLMbjwNI681FDyC2EnD3yqHdazZ1yZdzWgvGFodRpUMbVWIDP1RP9syYXjWTE69C9Ml+S0+d7gjtkoyy1SLnL8Iu70/u+REx8u97C3EPvt6HKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363012; c=relaxed/simple;
	bh=o/+yNmSfds55CFkUhuQ7CnCj0E8N/F/+MVQdRdrnhHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCRzImUoNTIT71hCD/JvNiYucvYFwt9s++9k9fPPDLqJEzpHbLqPLvsWu+pc4ozLe82uFtmWdj0lOPSFGUDKQOovDYBtAsqYcVIKqFn++NUmKw/8PrGXQZfLyDdw2uqPN9JNpX9isJ/mR3UEog1KbRGNS5RkyXbWGnPMXNT+QfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcS4VHfzKHMPD;
	Sat, 25 Oct 2025 11:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5283D1A0A86;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S15;
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
Subject: [PATCH 11/25] ext4: support large block size in ext4_mb_load_buddy_gfp()
Date: Sat, 25 Oct 2025 11:22:07 +0800
Message-Id: <20251025032221.2905818-12-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251025032221.2905818-1-libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S15
X-Coremail-Antispam: 1UD129KBjvJXoWxArykWFyUGry7JrW7Jr18Krg_yoWrJr43pF
	srGrn8Gr47WFnxWwsru34SqF1Fgas3uFWUGFWfWF1fZFy3t3WxKFnrK3WUJF1jgay7J3Z7
	XFW5ZryfuF17W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJHQADsp

From: Baokun Li <libaokun1@huawei.com>

Currently, ext4_mb_load_buddy_gfp() uses blocks_per_page to calculate the
folio index and offset. However, when blocksize is larger than PAGE_SIZE,
blocks_per_page becomes zero, leading to a potential division-by-zero bug.

To support BS > PS, use bytes to compute folio index and offset within
folio to get rid of blocks_per_page.

Also, if buddy and bitmap land in the same folio, we get that folio’s ref
instead of looking it up again before updating the buddy.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/mballoc.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6070d3c86678..3494c6fe5bfb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1642,17 +1642,15 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 
 /*
  * Locking note:  This routine calls ext4_mb_init_cache(), which takes the
- * block group lock of all groups for this page; do not hold the BG lock when
+ * block group lock of all groups for this folio; do not hold the BG lock when
  * calling this routine!
  */
 static noinline_for_stack int
 ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		       struct ext4_buddy *e4b, gfp_t gfp)
 {
-	int blocks_per_page;
 	int block;
 	int pnum;
-	int poff;
 	struct folio *folio;
 	int ret;
 	struct ext4_group_info *grp;
@@ -1662,7 +1660,6 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	might_sleep();
 	mb_debug(sb, "load group %u\n", group);
 
-	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
 	if (!grp)
 		return -EFSCORRUPTED;
@@ -1690,8 +1687,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	 * So for each group we need two blocks.
 	 */
 	block = group * 2;
-	pnum = block / blocks_per_page;
-	poff = block % blocks_per_page;
+	pnum = EXT4_LBLK_TO_P(inode, block);
 
 	/* Avoid locking the folio in the fast path ... */
 	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
@@ -1723,7 +1719,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 					goto err;
 				}
 				mb_cmp_bitmaps(e4b, folio_address(folio) +
-					       (poff * sb->s_blocksize));
+					offset_in_folio(folio,
+						EXT4_LBLK_TO_B(inode, block)));
 			}
 			folio_unlock(folio);
 		}
@@ -1739,12 +1736,18 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 
 	/* Folios marked accessed already */
 	e4b->bd_bitmap_folio = folio;
-	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
+	e4b->bd_bitmap = folio_address(folio) +
+			 offset_in_folio(folio, EXT4_LBLK_TO_B(inode, block));
 
 	block++;
-	pnum = block / blocks_per_page;
-	poff = block % blocks_per_page;
+	pnum = EXT4_LBLK_TO_P(inode, block);
+	/* buddy and bitmap are on the same folio? */
+	if (folio_contains(folio, pnum)) {
+		folio_get(folio);
+		goto update_buddy;
+	}
 
+	/* we need another folio for the buddy */
 	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
 	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
 		if (!IS_ERR(folio))
@@ -1779,9 +1782,11 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		goto err;
 	}
 
+update_buddy:
 	/* Folios marked accessed already */
 	e4b->bd_buddy_folio = folio;
-	e4b->bd_buddy = folio_address(folio) + (poff * sb->s_blocksize);
+	e4b->bd_buddy = folio_address(folio) +
+			offset_in_folio(folio, EXT4_LBLK_TO_B(inode, block));
 
 	return 0;
 
-- 
2.46.1


