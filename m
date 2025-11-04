Return-Path: <linux-fsdevel+bounces-66949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D186FC310E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40EB4219D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240B72D94A2;
	Tue,  4 Nov 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNcGqnS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9F2D2387
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260648; cv=none; b=KtkKQnj+tVIFHkVrSctzghb0ZO761uxjhHHPZx1YmNxT+8Ckynkvu4KPRTqhwVdDQZ7UtAfr9xsIy119NfTfOwJJK2rhFzlN+c+U+j1hJrGQEIfECu0bbu5hDbx1Wr5ZK96pUt2THm24MGSFJoIp2xrIWwnCEP6Efrwe/ZftjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260648; c=relaxed/simple;
	bh=/CsrGDKoxbv+WBhuuGaXHdSwgxHC4BxFYkS3KS1j/VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAPRdU/FKTw6/o8DMb2onLTuQDvDKI5taLRe5NVJO+UkZPTFRj6w5/Uj4SYX8qaI38SwQfZ8iQRDKyLL0/U2gCuwdRcrMISYS0WhBxb23eZH3thORE7qhIO3JTX9dCmlWEKeFOt65Nw6izPi6R/kdndsdV4396QQUzdQ3KHjSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNcGqnS5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so4429428b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260646; x=1762865446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTbdMZMCknDk5YhfGeRikK+ydoKaUITUUORTAPIpkPo=;
        b=XNcGqnS5O6kP/IHy6Fl0MraSD+wcd6TZ2LvToJUiBVyhIwn4KctznzzAulYMMpvx56
         b8AXOy7ODwAtKSRa1UkJF7ub8gCaea4H+shFYiRBlNrBW5zJYqIv4U0VyHKSpJzOdVgp
         PV9xsuiBJoi4HBaw6ljQhnjkX8qcwTx7o9/9Dw/lMm0jnRqOGvMgRjTytYX4uGxX0iw+
         /hjh9PRA+YMS2PoLrFLa1TgvNbOCQDQ+Q6sASTpCdUoKT9d1utSDebgzsGM56u5zNgI8
         a5NvGnhGLwBbESoSTeCuSbYEEeK71vuzSB46WPi4jHK1YrCr1+tehv5NafEbqNzc3WtJ
         HwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260646; x=1762865446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTbdMZMCknDk5YhfGeRikK+ydoKaUITUUORTAPIpkPo=;
        b=UHA+6V6IlH2z1JICOWAlAKYrdiq+W2fMxmwg6xp9xPTm9ZQQYpw3E4PWfvNKDOeWDA
         K7NUR15tqXnUqL+vYqRuIXFGuRVyz46eNlJ1xkp6ygNZF7fOHalM2+xcDCx8n1AiroW/
         uYdCxKP2dW3XDpmo4yq2NpATB7jTMlmbHa0igja7nc94RiO9eWVKI4wg6j2oa6YgVZWI
         QxLFuCbCYrk5EzGGWQ0NfRfNXWw0gqBRydmgucBFvBREWBNi6E6NdPShS7Jd0SMTKJNn
         Ygcnhr/XQE6DgpMHUmUPdksBQoqWoszq4W1bFnr19T0xG2/M4NjGRVwOoLFdgp3KWeeE
         /Ujw==
X-Forwarded-Encrypted: i=1; AJvYcCXiL69Q6/TbmFG+2qsu22CZKFaSzmioju6ryyyThqp+iypAG54AMFxsjb44smegnx94EQjrDPYc3kvdaf4l@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOAOPFbNJYW/xO7DMzFIeTUN3jsRfzDcQQfglpKc3J9LdTm2h
	mTcCykIAAt0N5wjX3EBPn9qLVrVJA0lK9/VmsDLExbAbVzf8sZyXTi15UmtO7VYMe8J9xw==
X-Gm-Gg: ASbGnctGhobExQHnb8Bd1/R8giP/g27of+1tb6gEJ4HZObCwJUfvrX+8ejn8MIoYfkw
	3FlxE7pVmU9MM5VzcEzTELrYBu1mmnB5tFJTaNX75EWCDv6SZ3kferUNBB3q9a5NZIK0eYmqWYP
	4SjHkO04wVx7ttqLNxMtijOjFOojSbECWHByido8cO7W8h4cQ9TNJen0iX3tpMFlTIS0i0z9tt6
	/oSJDOK1r4Q8FIsCdVPxzG+HtHRW/QDpYBGJo9CzONJ/UicMFVNWP0eI9snZi5K3mGPviDLAE/H
	aZCYCJpah8r+gUuHFuWnTd9PoJKWsQFObQXME6PGkqwnLRw9oze7wVBzq250OB70irpm3J/fT4N
	C4HOhBY+RaI5AGSUwRsi6eSQElRus63BUk+1YIH/O8pZz2G8pJ8ZyNaiGzaqBv7H8r7QoMmyy6v
	0KmpI05jjsCm6qU+70iuKUJrnmvoXCIyWMj8ZXCu7mcaEWAb4=
X-Google-Smtp-Source: AGHT+IGQYtSFcAKX8HnBEAXAu9KQVG5TtaDZXChmyVTWXsqdKGmlpqjDJBhuab7LPqSEXplDty6CPQ==
X-Received: by 2002:a05:6a00:c7:b0:7aa:aa7:a83a with SMTP id d2e1a72fcca58-7aa0aa7ab07mr8310408b3a.9.1762260646105;
        Tue, 04 Nov 2025 04:50:46 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:45 -0800 (PST)
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
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/5] vfat: fix missing sb_min_blocksize() return value checks
Date: Tue,  4 Nov 2025 20:50:06 +0800
Message-ID: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
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
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v6:
- fix 'Fixes tag' format error
- drop the pointless extern and spell out the parameter of
sb_set_blocksize and sb_set_blocksize
v5:
- add cc tag for 5th patch
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


