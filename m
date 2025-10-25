Return-Path: <linux-fsdevel+bounces-65598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF4C0899C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24D6F4E513D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4423B604;
	Sat, 25 Oct 2025 03:30:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF44259C92;
	Sat, 25 Oct 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363009; cv=none; b=PwNVhHbh/THz0S8047kpm0/ukLjZ2HfizG0tjZV0AMPQt3pzxr4cZtGGaTOKiNgInRHQu88KltMRxxTa12eIPwWvn6ceGlN7b40mHqAGdRK0mB40gnNIr3Axhlo4aH2gpweH8PjfiYu0kDKpWWHe4qpxPthvkSH55WdU/HVSFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363009; c=relaxed/simple;
	bh=YRz6t3tNGuDdfxm1rkoTMO37jW0qjNisU+Z04VXuTqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bK1SU7UuIaBSPASjb3UYJBqNProimSOPFMwuupZie7KYSIPBFRkaQsKcUNnPlSb0qrgAUcerWy0v9Sn4Oq2aAyd62mNq7bahTyv+BzBhGTf7nvbLLf3RETRUYDWnYGRpEGQ0N5WBXV5FtmuCNTuuXgXGbM8U1DlFHDVrlSMFAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcS1vzyzKHMNv;
	Sat, 25 Oct 2025 11:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EAD841A0A86;
	Sat, 25 Oct 2025 11:30:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S10;
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
Subject: [PATCH 06/25] ext4: introduce s_min_folio_order for future BS > PS support
Date: Sat, 25 Oct 2025 11:22:02 +0800
Message-Id: <20251025032221.2905818-7-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfJFyxtr4xKFyrCw13CFg_yoW8Kr4rpF
	nxCFyfGrW8Zry8uFs7WFsrX348Kay8KayUXr4S93W5urWaq3409rZrtF15AFyjqFWxXFWS
	qF1UKry7Cr1akrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUo0PSUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9I6gACsG

From: Baokun Li <libaokun1@huawei.com>

This commit introduces the s_min_folio_order field to the ext4_sb_info
structure. This field will store the minimum folio order required by the
current filesystem, laying groundwork for future support of block sizes
greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  3 +++
 fs/ext4/inode.c |  3 ++-
 fs/ext4/super.c | 10 +++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 93c2bf4d125a..bca6c3709673 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1677,6 +1677,9 @@ struct ext4_sb_info {
 	/* record the last minlen when FITRIM is called. */
 	unsigned long s_last_trim_minblks;
 
+	/* minimum folio order of a page cache allocation */
+	unsigned int s_min_folio_order;
+
 	/* Precomputed FS UUID checksum for seeding other checksums */
 	__u32 s_csum_seed;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a63513a3db53..889761ed51dd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5174,7 +5174,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
 	if (!ext4_should_enable_large_folio(inode))
 		return;
 
-	mapping_set_folio_order_range(inode->i_mapping, 0,
+	mapping_set_folio_order_range(inode->i_mapping,
+				      EXT4_SB(inode->i_sb)->s_min_folio_order,
 				      EXT4_MAX_PAGECACHE_ORDER(inode));
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index aa5aee4d1b63..d353e25a5b92 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5100,11 +5100,8 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	 * If the default block size is not the same as the real block size,
 	 * we need to reload it.
 	 */
-	if (sb->s_blocksize == blocksize) {
-		*lsb = logical_sb_block;
-		sbi->s_sbh = bh;
-		return 0;
-	}
+	if (sb->s_blocksize == blocksize)
+		goto success;
 
 	/*
 	 * bh must be released before kill_bdev(), otherwise
@@ -5135,6 +5132,9 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 		ext4_msg(sb, KERN_ERR, "Magic mismatch, very weird!");
 		goto out;
 	}
+
+success:
+	sbi->s_min_folio_order = get_order(blocksize);
 	*lsb = logical_sb_block;
 	sbi->s_sbh = bh;
 	return 0;
-- 
2.46.1


