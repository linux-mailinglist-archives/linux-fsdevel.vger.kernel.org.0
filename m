Return-Path: <linux-fsdevel+bounces-66831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1CC2D37C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9193BEC4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4703191D9;
	Mon,  3 Nov 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKKeVLVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C23191AD
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187829; cv=none; b=cYErfRXhUAYqG6IaCurx7+NmoO4joCPYRsr/L2xbyGMaUWqMwtmOURUPRnmINB2MuKhBq2BEjIf/cXRj7FvcbK4nryQ7qcAHIljL7qPh2Q+hpb+y70R0RDYtpc2As8Sc1pSvGBF9EZE2cbtt1zw4LqLUwVzRzOxpV9nMk1ScKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187829; c=relaxed/simple;
	bh=mUCmd8W8b1UfMTtsn/FXl9qjWm3KYORpGLNFAC7UbRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzGP8xM1uuZLLlwAR63Q9u4yTOv7fTkUenFL4NeOWyGhdc1+uBl4bQCskt0Xv/WZR/lGK6/AIOcL4z+GqAHIrcKkh9lZ4M36mdIBPCWazyPXERr+IftDmZQBtLIuAYSm7cf1jQ/2ns8q82H5u825RaYku0tqkWM72yYb2MyqI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKKeVLVu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3401314d845so6071751a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187826; x=1762792626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KO2yXPY3uj3eiiThLX7QWgGsmYZSUtzXjXez/9ov8Yw=;
        b=UKKeVLVu8D/9WpC72NjeRXl58szn23lhNetvb/XVs/MCdaROEQkDqS03R06mDgaKKY
         z9fbAtaRK2NOias9X9ZOnJ2srqZMdBL0rE6zBonvDsANkS8TuTS8GPAcJ0kd/PXlqkpN
         IsqqzdtE+8xMDElSok8+GIOQp8kstfMuUNMPEwxhrhUx4LrDPbupZuvVsL9tsxAlUl+R
         DPRrj0LP0SQ1qBwojb2JpdKEA7Vc5tgR5BNZ3tZXDlKCj0Y5UoMA6tg+dGF1weVaWSsg
         P1nmqoTqxqb1tyMrh3xN3LIWP+lce+F64mY5Ac+20DyBTiW6GR3n4sjrWdbdDNZhzvWK
         9Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187826; x=1762792626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO2yXPY3uj3eiiThLX7QWgGsmYZSUtzXjXez/9ov8Yw=;
        b=IHnpzLsCadvSsEE7MyIEE8n7zPWSqmAkpKz+STpdyn8t78sin2u3Z5/OO/n5f2WSgj
         xO5HUBO3ZuNIQgM+E3rqG6FxjBtnlPOiHPg+WgTCR1bV9AE2TihPf+2y/sDs2lAirNHI
         RQbK5CdJ6Pj3rDBqlMOKPm7G6hc0DlE/MDE3Ld14y8U5nDAuYJU6n5IzbfgyF4bV4O1n
         ZvztgrLI1+VbgdS6MCyLSlv9cqH5RdwhU2FNWc9RdSBci684RWW6nmdzV1ArVNAkwY4Q
         7AcwnhUHrG0/SkCX3n2M5We4yyEpgWhhzwAs2JDbxHyQK+xlxZwTJfsQGYpB1vaMzhsA
         DxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCHUKOxKyvHyT5Uhz1mtmhDK8sqn5mTmztarqb1gGlABVGerw5YZGzIxAnoyMdkFya2c3YlVJE7RXBb0Nr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0D6D258EPyq+r6kDmAmSh+BkDiK9QCgWU9PuCE1MSv4nBPRql
	pqZRJDBijJUR6gp2DNhVTsJb8w9jkQdc6cy0EkY0y78PPS9UcVyRDz07
X-Gm-Gg: ASbGncuRP/G6uv6U+VjNHfpvQkD4tobMn0RtpoGvEYh513BlxX7Mfox9nxp+eaCOX1D
	VweMnBgsz42lfWPNTdC23eeDTUiCeyFeLuaq/h3n/QypuNoR/EidHSdATZozYOSnHtwX8NT0MSt
	5GTiQvvZi24JPrB076693kCKuwYkTJNkpzP10I5oeHcguBccqWfFcGA3n49OETEYVT/ASo4iMd7
	al+f0pbPqEV7eAPrMRKeSjvpIbj0mO0pSH02tOgnBnEzMz3WnEHp4CuUlb1pN5WREO1Og5cRm+6
	qgKdO7xrNUecJWHPs6IjUtFOUTrLYQqLFe12/pUmMYAO8cINqSJt8ZCREKwFJi49pZ3sJQPm6ED
	fFNU2jBL35CwcVWzFQUfA7K8gRIdc5mwHUeAjT4vkPwOlzDG7g6ppSY2/yN+T1s9eCQhwzk0tDz
	87aVJMg5uC+Y7Gnpkck7Fp9aL2t6Y=
X-Google-Smtp-Source: AGHT+IFqicDQztpq+UnHVa90deXNQVEjhn0LWRPRieWkdrfme/ZHZGd9yTFfMSbCRSONPGQpBaM0iA==
X-Received: by 2002:a17:90b:51d1:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-3408306b9f3mr15835496a91.23.1762187825621;
        Mon, 03 Nov 2025 08:37:05 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:05 -0800 (PST)
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
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v4 1/5] vfat: fix missing sb_min_blocksize() return value checks
Date: Tue,  4 Nov 2025 00:36:14 +0800
Message-ID: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
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

To fix this issue, add proper return value checks for
sb_min_blocksize().

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
for sb_set_blocksize()")
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v4:
- split the changes into 5 patches
v3:
- remove the unnecessary blocksize variable definition
v2:
- add the __must_check mark to sb_min_blocksize() and include the Fixes
tag
---
 fs/fat/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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
-- 
2.43.0


