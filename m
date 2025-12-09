Return-Path: <linux-fsdevel+bounces-71005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2974CAF24A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 08:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DBE03012DE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE377221F24;
	Tue,  9 Dec 2025 07:32:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650992139C9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265539; cv=none; b=ikSG2XIfmwqLMhaWNZDgpTxEU0UFRyl59r7XT2W8U34ATNBE5WcufhvmEhjNvFlWOiP0WzYRZZcywxDWNp4bAdD6OIO0wD0KjfWTqWdIYQ8lGLVfb41eqga0NrkGb2jQvXERFSvjqTExVZW9limA4cCt5dqjdD4/6xI4puxikls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265539; c=relaxed/simple;
	bh=J/4JYCvk/+LRKhxkmSyM7lbHTbMLPWcKEB/jDN51shI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soijkVoRxIiveyT8VelJFFjHdRk7/BmV7nK+Kviwn6UzSz+h2tPLjjorXxALlMRiV09N6s72050HoQVTBm0yWQLM2CxaPt2KrbLokruJ9tgE1TRcWzdIuP0JvNmNcbN3Zw+yJ9rKMFdiUFQ7YrwinajpQNdsI8d3hLbtDQXtjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQVrz3RYnzKHLyG
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 15:31:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A56C21A06DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 15:32:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDH80150DdpHC18BA--.12048S4;
	Tue, 09 Dec 2025 15:32:10 +0800 (CST)
From: libaokun@huaweicloud.com
To: ntfs3@lists.linux.dev
Cc: almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	syzbot+23aee7afc440fe803545@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: fix ntfs_mount_options leak in ntfs_fill_super()
Date: Tue,  9 Dec 2025 15:21:41 +0800
Message-Id: <20251209072141.2936193-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH80150DdpHC18BA--.12048S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw15Jw48Zw13JF47ZrWUArb_yoW5Gw1kpr
	y3ur18Kr48tF10qanFqFs5Xw1fCayDCFWjgryfXw13Aw1Dt3W7Ka4vy3s5KrZrZrWkJr1F
	vr4qyrWagryjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFXo7DU
	UUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWkthuQYCAABs6

From: Baokun Li <libaokun1@huawei.com>

In ntfs_fill_super(), the fc->fs_private pointer is set to NULL without
first freeing the memory it points to. This causes the subsequent call to
ntfs_fs_free() to skip freeing the ntfs_mount_options structure.

This results in a kmemleak report:

  unreferenced object 0xff1100015378b800 (size 32):
    comm "mount", pid 582, jiffies 4294890685
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 ed ff ed ff 00 04 00 00  ................
    backtrace (crc ed541d8c):
      __kmalloc_cache_noprof+0x424/0x5a0
      __ntfs_init_fs_context+0x47/0x590
      alloc_fs_context+0x5d8/0x960
      __x64_sys_fsopen+0xb1/0x190
      do_syscall_64+0x50/0x1f0
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

This issue can be reproduced using the following commands:
        fallocate -l 100M test.file
        mount test.file /tmp/test

Since sbi->options is duplicated from fc->fs_private and does not
directly use the memory allocated for fs_private, it is unnecessary to
set fc->fs_private to NULL.

Additionally, this patch simplifies the code by utilizing the helper
function put_mount_options() instead of open-coding the cleanup logic.

Reported-by: syzbot+23aee7afc440fe803545@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=23aee7afc440fe803545
Fixes: aee4d5a521e9 ("ntfs3: fix double free of sbi->options->nls and clarify ownership of fc->fs_private")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ntfs3/super.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8b0cf0ed4f72..0567a3b224ed 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -705,9 +705,7 @@ static void ntfs_put_super(struct super_block *sb)
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
 	if (sbi->options) {
-		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls_name);
-		kfree(sbi->options);
+		put_mount_options(sbi->options);
 		sbi->options = NULL;
 	}
 
@@ -1253,7 +1251,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 	sbi->options = options;
-	fc->fs_private = NULL;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
@@ -1679,9 +1676,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 out:
 	/* sbi->options == options */
 	if (options) {
-		unload_nls(options->nls);
-		kfree(options->nls_name);
-		kfree(options);
+		put_mount_options(sbi->options);
 		sbi->options = NULL;
 	}
 
-- 
2.39.2


