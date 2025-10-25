Return-Path: <linux-fsdevel+bounces-65610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A097EC089F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99131CC0DA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274C2DC768;
	Sat, 25 Oct 2025 03:30:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30542C031B;
	Sat, 25 Oct 2025 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363014; cv=none; b=cf3M6GSvULvH3Wi90SzaL04sPumRHhWGhpOw036rnCB80Gu68WWIap/GLYXEojCTGDR83lQABzpK2I/d2rBY9xGc/pLaqtgqfGgnbf3qVx5jfeKO5RRVOk26y8fqDSTRIt6R0/EPtDuLDs5SBVfmJDy8SMkuimQrd4vlbdeJ9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363014; c=relaxed/simple;
	bh=rtscdptD+wxdUqzFvfZNLTlaTFfsdl/+1WsXXOUs0JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjKw/wjHgSB883b3aJNmQi8jA3kL9iblOhdwqXZ/NAyPjpzymisU9mXkMUw3kNaPV+AqBreQyoGGF5VFGgKcYdmE1GTf5ibFvVoqz58QMHouOghPS556x4PrmZMy7Kz2wGsNgd61CQiKZioG6aAorpXgFoxYg9Q608scx/bt0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcS6FHMzKHMPS;
	Sat, 25 Oct 2025 11:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 92BB71A19DA;
	Sat, 25 Oct 2025 11:30:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S19;
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
Subject: [PATCH 15/25] ext4: rename 'page' references to 'folio' in multi-block allocator
Date: Sat, 25 Oct 2025 11:22:11 +0800
Message-Id: <20251025032221.2905818-16-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S19
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy7GF15AF45JF1rXFy8AFb_yoWrGryDpF
	sxCw15Cr1kWrn8u3Zruayj9w1Sy3yv9FWkCrWxWr18Zr9xXryIgFnrtF1UtFy0gFZ7AFn5
	ZF4avF13ur17J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAMBWj7UbRJHgABso

From: Zhihao Cheng <chengzhihao1@huawei.com>

The ext4 multi-block allocator now fully supports folio objects. Update
all variable names, function names, and comments to replace legacy 'page'
terminology with 'folio', improving clarity and consistency.

No functional changes.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/mballoc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 155c43ff2bc2..cf07d1067f5f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -98,14 +98,14 @@
  * block bitmap and buddy information. The information are stored in the
  * inode as:
  *
- *  {                        page                        }
+ *  {                        folio                        }
  *  [ group 0 bitmap][ group 0 buddy] [group 1][ group 1]...
  *
  *
  * one block each for bitmap and buddy information.  So for each group we
- * take up 2 blocks. A page can contain blocks_per_page (PAGE_SIZE /
- * blocksize) blocks.  So it can have information regarding groups_per_page
- * which is blocks_per_page/2
+ * take up 2 blocks. A folio can contain blocks_per_folio (folio_size /
+ * blocksize) blocks.  So it can have information regarding groups_per_folio
+ * which is blocks_per_folio/2
  *
  * The buddy cache inode is not stored on disk. The inode is thrown
  * away when the filesystem is unmounted.
@@ -1556,7 +1556,7 @@ static int ext4_mb_get_buddy_folio_lock(struct super_block *sb,
 	return 0;
 }
 
-static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
+static void ext4_mb_put_buddy_folio_lock(struct ext4_buddy *e4b)
 {
 	if (e4b->bd_bitmap_folio) {
 		folio_unlock(e4b->bd_bitmap_folio);
@@ -1570,7 +1570,7 @@ static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
 
 /*
  * Locking note:  This routine calls ext4_mb_init_cache(), which takes the
- * block group lock of all groups for this page; do not hold the BG lock when
+ * block group lock of all groups for this folio; do not hold the BG lock when
  * calling this routine!
  */
 static noinline_for_stack
@@ -1618,7 +1618,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	if (e4b.bd_buddy_folio == NULL) {
 		/*
 		 * If both the bitmap and buddy are in
-		 * the same page we don't need to force
+		 * the same folio we don't need to force
 		 * init the buddy
 		 */
 		ret = 0;
@@ -1634,7 +1634,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 err:
-	ext4_mb_put_buddy_page_lock(&e4b);
+	ext4_mb_put_buddy_folio_lock(&e4b);
 	return ret;
 }
 
@@ -2227,7 +2227,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	ac->ac_buddy = ret >> 16;
 
 	/*
-	 * take the page reference. We want the page to be pinned
+	 * take the folio reference. We want the folio to be pinned
 	 * so that we don't get a ext4_mb_init_cache_call for this
 	 * group until we update the bitmap. That would mean we
 	 * double allocate blocks. The reference is dropped
@@ -2933,7 +2933,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
 	if (cr < CR_ANY_FREE && spin_is_locked(ext4_group_lock_ptr(sb, group)))
 		return 0;
 
-	/* This now checks without needing the buddy page */
+	/* This now checks without needing the buddy folio */
 	ret = ext4_mb_good_group_nolock(ac, group, cr);
 	if (ret <= 0) {
 		if (!ac->ac_first_err)
@@ -4725,7 +4725,7 @@ static void ext4_discard_allocated_blocks(struct ext4_allocation_context *ac)
 				   "ext4: mb_load_buddy failed (%d)", err))
 			/*
 			 * This should never happen since we pin the
-			 * pages in the ext4_allocation_context so
+			 * folios in the ext4_allocation_context so
 			 * ext4_mb_load_buddy() should never fail.
 			 */
 			return;
-- 
2.46.1


