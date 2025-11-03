Return-Path: <linux-fsdevel+bounces-66798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E349C2C447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D5834F3244
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEDF274B2E;
	Mon,  3 Nov 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQlrHaKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A4274B2B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177879; cv=none; b=VvU60SKlQZqhzyRADlLiHZAqrqajeUmQ2WD+FRGrePLtabeluDR1Lw07VGQZWnegbjMU2C6p1zEIEc6vuu29apIFQzj5UhV+DoW1YU7PYj9E6wnBikxMpN09VEEeIyYxmJWlXLijs04BM/bz2HWFbs9yy7Ng/Bh7PB7GfjpQByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177879; c=relaxed/simple;
	bh=2gkYZFqYgKSUsJOLpAT78NXyMt5HgottpznDKoDBdbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSz2wYxDJLIaunyzv2ZPqnezUCstmg2n45iMImFcJy+G1vsN2HbdadZDIqpnXiyEYTTeaCb/j81xRJUHKDKGcl27Jzh6H+RJ8O+SR/lwtq2K4RlEE+2L1LK0cfGoU2CK3VmQDVXRyCz9S3BqMCunpQrmnqnhCAKeMCp8ED4QjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQlrHaKa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aad4823079so1007485b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762177877; x=1762782677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EPdjPiIDzYkYRpxuuVMsNgyCcV1A8N85TloYP1uLj/Q=;
        b=RQlrHaKaWgcSN2995w8o3FW3AsgDYpe3RSD1uFv6gNkuNuIbOJ0CdFrtz0nndxB8ik
         SeCZmD3/qZurF7gq8Gf7wbJj13thNC2SV2ST0tHx2Ws46+HbnKrQg87N7MQpX2vHfLUn
         lwjvvYE4YWn3msOLxTYQQDmjdEiWWzt8RlAtNfrur/C7nvKyJb14sVlW1PMgiLRG6t8O
         HTyKOp2+Gf7xunjBJgow793nxVMVyycAodo4skLQJCWjxkBMI1tci30Mz9TFABMAjnjI
         6OLjjoj5jn53UybOOuuRhDqrVmzWv9nX/g1zAxSNPWAclB8hvZe1maVcUVjjFA2cwM8i
         AlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177877; x=1762782677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPdjPiIDzYkYRpxuuVMsNgyCcV1A8N85TloYP1uLj/Q=;
        b=TV535al6AYd7BU31vhsIF3h9/yD0qQ/YKOE1pyJpMLlr+bgsH0oeEVimDUB2/23WWO
         k5No1q+kfmyksUb/lpZ9qULGrYRVGWkzWrKOss5NYtyjlozKDEVx+DA8A26OW5FoXlI3
         wk+zlP07jkj5zK7UwQlC3bl9Wyzrfb93TFlcTLcVtI6FGUCF5poTfci8haR8pNrSu4jJ
         +kdexrgXsN8eWbokl2Nx0eaCFzIIqV6jzI5Y45kjxPDYgnmsNTlZ/0Tb6OUTe4RRJvaK
         QdazhPFPHuqhIey4Mc14qAZ1uTD0TJUaFTbm//mmw1XKtzml/cP6+SGy94ImI81Ai3eu
         JifA==
X-Forwarded-Encrypted: i=1; AJvYcCUqveCgfwqFUb2ycmlGyBc8by655sqkq0m8rCfPfSkpCeetpA/iS4dZ+BK2vCSv9RAeD6Mno722CW/Sl8i4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzfu7YiDWCqy6erElLYIW7LmWELcRMPuO3D5nZUddiLftp8P5t
	3GHUFVPyfk1qP9sEU9bZx8Hh58Y071elXY4YFwCdHlvecdjtnMNictbN
X-Gm-Gg: ASbGncsR7KsxK7cnl3Vi1JlJadwpAiV/MBFvlAh/lGE7NaUz68XBMU9cKwCQQ+NyU4K
	mh+lKJRouY8fhGK5nUV2t3xdteghXzd7S43nu+9+zpvjr57ml0X9/hm+2QE9IkmpW7sZWl9o0U7
	yUaEl9Ijubr7/GHjhYRdY+OcDAtCJY9KvGY8VcjnTA04lhIlOBTZJq5TXmZkqlMzRjyGo7Bdq3K
	lm4h4yCi4sqHPh3oIyWyzeysaHBYgoymNP7m4aItT1N2n6OwLW4QAiXJex6Gh+GS7y/HRKgVD/J
	O3y8S1HUQzjVJTi8FGa6IYjFZCUqXBl9Z14Eri/wtrVPU65ICFAlYeVRDRy9hjrNpL2UUyoVqoP
	lpu2sOk09N5PYj9RfUGK99HIk7vVZYI2L6xP8zFPWA1xuQB1U/Djg05gmot1Vky9yaT2B+wKeSC
	jG1/LAHy4+v7U9FIWvHhV1Ujz8bwGdLKg=
X-Google-Smtp-Source: AGHT+IF2eDA6sFLYUCQ/ZtRsSNh/W+1dG7NW13d1GNmK5KfQxelzDaX+iUgyHsTKq3tjqChwqB22Yg==
X-Received: by 2002:a05:6a20:3d8e:b0:347:67b8:731e with SMTP id adf61e73a8af0-348ca55d30amr16010144637.14.1762177876671;
        Mon, 03 Nov 2025 05:51:16 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ac21ef0c69sm1784979b3a.48.2025.11.03.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:51:16 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v3] fix missing sb_min_blocksize() return value checks in some filesystems
Date: Mon,  3 Nov 2025 21:50:24 +0800
Message-ID: <20251103135024.35289-1-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When emulating an nvme device on qemu with both logical_block_size and
physical_block_size set to 8 KiB, but without format, a kernel panic
was triggered during the early boot stage while attempting to mount a
vfat filesystem.

[95553.682035] EXT4-fs (nvme0n1): unable to set blocksize
[95553.684326] EXT4-fs (nvme0n1): unable to set blocksize
[95553.686501] EXT4-fs (nvme0n1): unable to set blocksize
[95553.696448] ISOFS: unsupported/invalid hardware sector size 8192
[95553.697117] ------------[ cut here ]------------
[95553.697567] kernel BUG at fs/buffer.c:1582!
[95553.697984] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[95553.698602] CPU: 0 UID: 0 PID: 7212 Comm: mount Kdump: loaded Not tainted 6.18.0-rc2+ #38 PREEMPT(voluntary)
[95553.699511] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[95553.700534] RIP: 0010:folio_alloc_buffers+0x1bb/0x1c0
[95553.701018] Code: 48 8b 15 e8 93 18 02 65 48 89 35 e0 93 18 02 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc <0f> 0b 90 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
[95553.702648] RSP: 0018:ffffd1b0c676f990 EFLAGS: 00010246
[95553.703132] RAX: ffff8cfc4176d820 RBX: 0000000000508c48 RCX: 0000000000000001
[95553.703805] RDX: 0000000000002000 RSI: 0000000000000000 RDI: 0000000000000000
[95553.704481] RBP: ffffd1b0c676f9c8 R08: 0000000000000000 R09: 0000000000000000
[95553.705148] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[95553.705816] R13: 0000000000002000 R14: fffff8bc8257e800 R15: 0000000000000000
[95553.706483] FS:  000072ee77315840(0000) GS:ffff8cfdd2c8d000(0000) knlGS:0000000000000000
[95553.707248] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[95553.707782] CR2: 00007d8f2a9e5a20 CR3: 0000000039d0c006 CR4: 0000000000772ef0
[95553.708439] PKRU: 55555554
[95553.708734] Call Trace:
[95553.709015]  <TASK>
[95553.709266]  __getblk_slow+0xd2/0x230
[95553.709641]  ? find_get_block_common+0x8b/0x530
[95553.710084]  bdev_getblk+0x77/0xa0
[95553.710449]  __bread_gfp+0x22/0x140
[95553.710810]  fat_fill_super+0x23a/0xfc0
[95553.711216]  ? __pfx_setup+0x10/0x10
[95553.711580]  ? __pfx_vfat_fill_super+0x10/0x10
[95553.712014]  vfat_fill_super+0x15/0x30
[95553.712401]  get_tree_bdev_flags+0x141/0x1e0
[95553.712817]  get_tree_bdev+0x10/0x20
[95553.713177]  vfat_get_tree+0x15/0x20
[95553.713550]  vfs_get_tree+0x2a/0x100
[95553.713910]  vfs_cmd_create+0x62/0xf0
[95553.714273]  __do_sys_fsconfig+0x4e7/0x660
[95553.714669]  __x64_sys_fsconfig+0x20/0x40
[95553.715062]  x64_sys_call+0x21ee/0x26a0
[95553.715453]  do_syscall_64+0x80/0x670
[95553.715816]  ? __fs_parse+0x65/0x1e0
[95553.716172]  ? fat_parse_param+0x103/0x4b0
[95553.716587]  ? vfs_parse_fs_param_source+0x21/0xa0
[95553.717034]  ? __do_sys_fsconfig+0x3d9/0x660
[95553.717548]  ? __x64_sys_fsconfig+0x20/0x40
[95553.717957]  ? x64_sys_call+0x21ee/0x26a0
[95553.718360]  ? do_syscall_64+0xb8/0x670
[95553.718734]  ? __x64_sys_fsconfig+0x20/0x40
[95553.719141]  ? x64_sys_call+0x21ee/0x26a0
[95553.719545]  ? do_syscall_64+0xb8/0x670
[95553.719922]  ? x64_sys_call+0x1405/0x26a0
[95553.720317]  ? do_syscall_64+0xb8/0x670
[95553.720702]  ? __x64_sys_close+0x3e/0x90
[95553.721080]  ? x64_sys_call+0x1b5e/0x26a0
[95553.721478]  ? do_syscall_64+0xb8/0x670
[95553.721841]  ? irqentry_exit+0x43/0x50
[95553.722211]  ? exc_page_fault+0x90/0x1b0
[95553.722681]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[95553.723166] RIP: 0033:0x72ee774f3afe
[95553.723562] Code: 73 01 c3 48 8b 0d 0a 33 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d da 32 0f 00 f7 d8 64 89 01 48
[95553.725188] RSP: 002b:00007ffe97148978 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
[95553.725892] RAX: ffffffffffffffda RBX: 00005dcfe53d0080 RCX: 000072ee774f3afe
[95553.726526] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
[95553.727176] RBP: 00007ffe97148ac0 R08: 0000000000000000 R09: 000072ee775e7ac0
[95553.727818] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[95553.728459] R13: 00005dcfe53d04b0 R14: 000072ee77670b00 R15: 00005dcfe53d1a28
[95553.729086]  </TASK>

The panic occurs as follows:
1. logical_block_size is 8KiB, causing {struct super_block *sb}->s_blocksize
is initialized to 0.
vfat_fill_super
 - fat_fill_super
  - sb_min_blocksize
   - sb_set_blocksize //return 0 when size is 8KiB.
2. __bread_gfp is called with size == 0, causing folio_alloc_buffers() to
compute an offset equal to folio_size(folio), which triggers a BUG_ON.
fat_fill_super
 - sb_bread
  - __bread_gfp  // size == {struct super_block *sb}->s_blocksize == 0
   - bdev_getblk
    - __getblk_slow
     - grow_buffers
      - grow_dev_folio
       - folio_alloc_buffers  // size == 0
        - folio_set_bh //offset == folio_size(folio) and panic

To fix this issue, add proper return value checks for sb_min_blocksize()
in vfat, exfat, isofs, and xfs. Add the __must_check mark to
sb_min_blocksize().

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
for sb_set_blocksize()")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
v3:
- remove the unnecessary blocksize variable definition
v2:
- add the __must_check mark to sb_min_blocksize() and include the Fixes
tag
---
 block/bdev.c       | 2 +-
 fs/exfat/super.c   | 5 ++++-
 fs/fat/inode.c     | 6 +++++-
 fs/isofs/inode.c   | 5 +++++
 fs/xfs/xfs_super.c | 5 ++++-
 include/linux/fs.h | 2 +-
 6 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..638f0cd458ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_set_blocksize);
 
-int sb_min_blocksize(struct super_block *sb, int size)
+int __must_check sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_logical_block_size(sb->s_bdev);
 	if (size < minsize)
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..74d451f732c7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -433,7 +433,10 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
-	sb_min_blocksize(sb, 512);
+	if (!sb_min_blocksize(sb, 512)) {
+		exfat_err(sb, "unable to set blocksize");
+		return -EINVAL;
+	}
 
 	/* read boot sector */
 	sbi->boot_bh = sb_bread(sb, 0);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 9648ed097816..9cfe20a3daaf 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1595,8 +1595,12 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
 
 	setup(sb); /* flavour-specific stuff that needs options */
 
+	error = -EINVAL;
+	if (!sb_min_blocksize(sb, 512)) {
+		fat_msg(sb, KERN_ERR, "unable to set blocksize");
+		goto out_fail;
+	}
 	error = -EIO;
-	sb_min_blocksize(sb, 512);
 	bh = sb_bread(sb, 0);
 	if (bh == NULL) {
 		fat_msg(sb, KERN_ERR, "unable to read boot sector");
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..ad3143d4066b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_freesbi;
 	}
 	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
+	if (!opt->blocksize) {
+		printk(KERN_ERR
+		       "ISOFS: unable to set blocksize\n");
+		goto out_freesbi;
+	}
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
 	sbi->s_session = opt->session;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1067ebb3b001..bc71aa9dcee8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
-	sb_min_blocksize(sb, BBSIZE);
+	if (!sb_min_blocksize(sb, BBSIZE)) {
+		xfs_err(mp, "unable to set blocksize");
+		return -EINVAL;
+	}
 	sb->s_xattr = xfs_xattr_handlers;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..26d4ca0f859a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+extern int __must_check sb_min_blocksize(struct super_block *, int);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
-- 
2.43.0


