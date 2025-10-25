Return-Path: <linux-fsdevel+bounces-65611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D3C08A08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599F71CC14B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2812DCF50;
	Sat, 25 Oct 2025 03:30:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1F273D6D;
	Sat, 25 Oct 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363014; cv=none; b=LzzEybf59hpi1MOTXVa9LOE0/NMvV+Hvm8CHmTXeWItCt7qXznkc4LN9SYJ9kXtDk+ZxzWEsJ0xBD+cjXYk2QPdS2pNt2pLC2BxRay8eIM5y7Bh1SxfGTzwqaxiaiEaRrAuSC5AstycFNN4qDWd4AL+UptV9MyFfNLQ0E+NQoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363014; c=relaxed/simple;
	bh=eT5cEN37P4zMYUiWwsqyNiPeaGDU+PUJzbhLLNbqhHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ld5aRasxu2tZyT1ANDejK+WDLLJx5deaQZsstnf2NlCfe2N3p69ygxedJ1Y8ruGVvPn6sWAWF9O5wH9T2HmGdwwOLdrD9YLQuqa1SkuwuEyeu/DM7HP4RquhNMmn+ainLwNkxJEnvidbfzfOn/3ZGXxGiHtAmcDC9E94Q0jefks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlcT4Gx5zKHMQB;
	Sat, 25 Oct 2025 11:29:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4756C1A0FE8;
	Sat, 25 Oct 2025 11:30:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHnEQ6RPxox1YbBg--.45388S28;
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
Subject: [PATCH 24/25] ext4: add checks for large folio incompatibilities when BS > PS
Date: Sat, 25 Oct 2025 11:22:20 +0800
Message-Id: <20251025032221.2905818-25-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHnEQ6RPxox1YbBg--.45388S28
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUAr4kKFWDJF1rXr4fKrg_yoW5KFWxpF
	Z5CryrAr48uF1Duan7KF4kWr1Y93WFkayUJ3ySg34UJ3srG340qFWftF1rtF12qrW8W34f
	XF4rtryxCw43CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBWj7Ua9I8AABsf

From: Baokun Li <libaokun1@huawei.com>

Supporting a block size greater than the page size (BS > PS) requires
support for large folios. However, several features (e.g., verity, encrypt)
and mount options (e.g., data=journal) do not yet support large folios.

To prevent conflicts, this patch adds checks at mount time to prohibit
these features and options from being used when BS > PS. Since the data
mode cannot be changed on remount, there is no need to check on remount.

A new mount flag, EXT4_MF_LARGE_FOLIO, is introduced. This flag is set
after the checks pass, indicating that the filesystem has no features or
mount options incompatible with large folios. Subsequent checks can simply
test for this flag to avoid redundant verifications.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  3 ++-
 fs/ext4/inode.c | 10 ++++------
 fs/ext4/super.c | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8223ed29b343..f1163deb0812 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1859,7 +1859,8 @@ static inline int ext4_get_resgid(struct ext4_super_block *es)
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
 	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
-	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
+	EXT4_MF_JOURNAL_DESTROY,/* Journal is in process of destroying */
+	EXT4_MF_LARGE_FOLIO,	/* large folio is support */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b3fa29923a1d..04f9380d4211 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5143,14 +5143,12 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
-	if (!S_ISREG(inode->i_mode))
-		return false;
-	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
-	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
+	if (!ext4_test_mount_flag(sb, EXT4_MF_LARGE_FOLIO))
 		return false;
-	if (ext4_has_feature_verity(sb))
+
+	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (ext4_has_feature_encrypt(sb))
+	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
 		return false;
 
 	return true;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7338c708ea1d..fdc006a973aa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5034,6 +5034,28 @@ static const char *ext4_has_journal_option(struct super_block *sb)
 	return NULL;
 }
 
+static int ext4_check_large_folio(struct super_block *sb)
+{
+	const char *err_str = NULL;
+
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		err_str = "data=journal";
+	else if (ext4_has_feature_verity(sb))
+		err_str = "verity";
+	else if (ext4_has_feature_encrypt(sb))
+		err_str = "encrypt";
+
+	if (!err_str) {
+		ext4_set_mount_flag(sb, EXT4_MF_LARGE_FOLIO);
+	} else if (sb->s_blocksize > PAGE_SIZE) {
+		ext4_msg(sb, KERN_ERR, "bs(%lu) > ps(%lu) unsupported for %s",
+			 sb->s_blocksize, PAGE_SIZE, err_str);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 			   int silent)
 {
@@ -5310,6 +5332,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	ext4_apply_options(fc, sb);
 
+	err = ext4_check_large_folio(sb);
+	if (err < 0)
+		goto failed_mount;
+
 	err = ext4_encoding_init(sb, es);
 	if (err)
 		goto failed_mount;
-- 
2.46.1


