Return-Path: <linux-fsdevel+bounces-65616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9FC08A2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE87D3BFAB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0A2E1EE2;
	Sat, 25 Oct 2025 03:30:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B782D978A;
	Sat, 25 Oct 2025 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363017; cv=none; b=XhjnhiZS/QBDmlrH/BgwV1yr/2jtIJkbMyfayru6aPc0buTYxJlVE0dvISS9ESJzG2Ty0Be3483X4BURolB0zwRZMIU5z4MYA4c4e0sgO0ZIxSvAEOJsCyY6t7gocw5Z+SeOgA25uRfrD5FwcWCukOSMV0NCQljjJnKouSSHBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363017; c=relaxed/simple;
	bh=VGktx5fV3mvcEcsamy+r9TS/X79co1WNFdTFpf0V4FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GR6idsQUWWxKMIMzPMi39asmktsCRQkrPU04TVrwDNMebk/e0jEAxnvYT8d7jXycm0e0Xvqg6894eRCwS7uQsf7LdoBd7i2GV5PCWuf2RNwmcL9tzfZSiYbsB3m8cu7xVdwKSFqoU0eDTwVrLtv6hNVqdPlCEuqBwIEY02xcpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcT4tGCzKHMQB;
	Sat, 25 Oct 2025 11:29:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 61CC31A1B60;
	Sat, 25 Oct 2025 11:30:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S29;
	Sat, 25 Oct 2025 11:30:05 +0800 (CST)
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
Subject: [PATCH 25/25] ext4: enable block size larger than page size
Date: Sat, 25 Oct 2025 11:22:21 +0800
Message-Id: <20251025032221.2905818-26-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S29
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxArW7Gr1DJF18Cr1UGFg_yoW8tw45pF
	WrCFy8Gr15W34v9an2ga1DZF18K3y0kFWUXa4Fgw1xZrZrJ340grn7tF15XFyjqrZ3ZryF
	qF18Ary7XwnxCFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9I8QAAsf

From: Baokun Li <libaokun1@huawei.com>

Since block device (See commit 3c20917120ce ("block/bdev: enable large
folio support for large logical block sizes")) and page cache (See commit
ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
cache")) has the ability to have a minimum order when allocating folio,
and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
large folio for regular file"), now add support for block_size > PAGE_SIZE
in ext4.

set_blocksize() -> bdev_validate_blocksize() already validates the block
size, so ext4_load_super() does not need to perform additional checks.

Here we only need to enable large folio by default when s_min_folio_order
is greater than 0 and add the FS_LBS bit to fs_flags.

In addition, mark this feature as experimental.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 3 +++
 fs/ext4/super.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 04f9380d4211..ba6cf05860ae 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5146,6 +5146,9 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 	if (!ext4_test_mount_flag(sb, EXT4_MF_LARGE_FOLIO))
 		return false;
 
+	if (EXT4_SB(sb)->s_min_folio_order)
+		return true;
+
 	if (!S_ISREG(inode->i_mode))
 		return false;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fdc006a973aa..4c0bd79bdf68 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5053,6 +5053,9 @@ static int ext4_check_large_folio(struct super_block *sb)
 		return -EINVAL;
 	}
 
+	if (sb->s_blocksize > PAGE_SIZE)
+		ext4_msg(sb, KERN_NOTICE, "EXPERIMENTAL bs(%lu) > ps(%lu) enabled.",
+			 sb->s_blocksize, PAGE_SIZE);
 	return 0;
 }
 
@@ -7432,7 +7435,8 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
+				  FS_LBS,
 };
 MODULE_ALIAS_FS("ext4");
 
-- 
2.46.1


