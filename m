Return-Path: <linux-fsdevel+bounces-46486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61910A8A1EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49558169DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920F2973DB;
	Tue, 15 Apr 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J1Xjwsfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB12DFA56;
	Tue, 15 Apr 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728816; cv=none; b=Y83v8ItnnAzqJ+Fx+pbwEZ9n7+5KlSsjCCl7srCMwVKqW5tqseJYKM2tSHBPbKNw26Bpmqg9c/95GBhuGGUt/3P07316E1fJASt/G4ycoAjoxAeXr1mCrVhxLW6lMtJUm7zR5aTjt/U0NFYGt3ViXnRn04A9zOyxrmcPkFglPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728816; c=relaxed/simple;
	bh=YGwRxGwbrpuUevoI0RjmwEDzdtCQcZOdUfqlW6kdsYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e9+HEi6+z1BeeErEiusQCg9wk5rv/ljZZIol8BVhmPOA20NZfQoIlPcsfuY/NZQIGTdJiPhzYU5FplOVxI6vUR1krH1REJvJjEBCVOA+NYoUvftD11GvCUqPZcDHLzCjIO+vNxfBq8iNMRaa5xIh1kg5ngRoMMgXdR7EnWsSZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J1Xjwsfk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mF6vRbR4S90qv8/I2/dPptY8vGJP6bDRNJYyBJahYEI=; b=J1XjwsfkWPkuErmsaCLEHKVVjl
	GKReg5c8aOEdOpLY3GlUKJhFjCQ1416mDZI7vaFT2w/zFKVlGRMLwS3POp2hB1C54cUWbCJV5k5Gm
	h/XHTGGtgWpruImSfI4h9/5l5imoUoUwDkjCNKr2XCTtZMXLVgtSYKR/RwwojUsR8OCvT5SxL/sBO
	gPNXwxK4A+o+f7f9SpeBcN9TCgfQ79Be1CGrTucDC/vEBY35/Uf1VrYZIkCKiQUGbzm7B5tvzydIx
	a8HtFHtr8IPFPrqKpCRCJKRRzevx/sw43nQDQ5WXPpfuNglKZqz1v9oUbX3nMlWJqSrjL5b4zg/r9
	DeLoLJSA==;
Received: from 179-125-92-204-dinamico.pombonet.net.br ([179.125.92.204] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4hfC-00Gyg0-Nw; Tue, 15 Apr 2025 16:53:27 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 15 Apr 2025 11:53:04 -0300
Subject: [PATCH] ext4: inline: fix len overflow in ext4_prepare_inline_data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
X-B4-Tracking: v=1; b=H4sIANBy/mcC/x2MzQqDMBAGX0X23IVEopa+ivTgz2e7IIlsRAXx3
 V08DjPMSRkqyPQpTlJskiVFA/8qaPh38QeW0ZhKV1Yu+IpxrIEXxdKpuThLBKcNOs1p5/fYOzS
 hGXpfky2sm+R49u33um5Darg9bgAAAA==
X-Change-ID: 20250415-ext4-prepare-inline-overflow-8db0e747cb16
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Tao Ma <boyu.mt@taobao.com>, 
 Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

When running the following code on an ext4 filesystem with inline_data
feature enabled, it will lead to the bug below.

        fd = open("file1", O_RDWR | O_CREAT | O_TRUNC, 0666);
        ftruncate(fd, 30);
        pwrite(fd, "a", 1, (1UL << 40) + 5UL);

That happens because write_begin will succeed as when
ext4_generic_write_inline_data calls ext4_prepare_inline_data, pos + len
will be truncated, leading to ext4_prepare_inline_data parameter to be 6
instead of 0x10000000006.

Then, later when write_end is called, we hit:

        BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

at ext4_write_inline_data.

Fix it by using a loff_t type for the len parameter in
ext4_prepare_inline_data instead of an unsigned int.

[   44.545164] ------------[ cut here ]------------
[   44.545530] kernel BUG at fs/ext4/inline.c:240!
[   44.545834] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   44.546172] CPU: 3 UID: 0 PID: 343 Comm: test Not tainted 6.15.0-rc2-00003-g9080916f4863 #45 PREEMPT(full)  112853fcebfdb93254270a7959841d2c6aa2c8bb
[   44.546523] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   44.546523] RIP: 0010:ext4_write_inline_data+0xfe/0x100
[   44.546523] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 49
[   44.546523] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
[   44.546523] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: 0000010000000006
[   44.546523] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: ffff9329c158e738
[   44.546523] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[   44.546523] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: 0000006210000000
[   44.546523] R13: fffffc7e4015e700 R14: 0000010000000005 R15: ffff9329c158e738
[   44.546523] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) knlGS:0000000000000000
[   44.546523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.546523] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: 0000000000770eb0
[   44.546523] PKRU: 55555554
[   44.546523] Call Trace:
[   44.546523]  <TASK>
[   44.546523]  ext4_write_inline_data_end+0x126/0x2d0
[   44.546523]  generic_perform_write+0x17e/0x270
[   44.546523]  ext4_buffered_write_iter+0xc8/0x170
[   44.546523]  vfs_write+0x2be/0x3e0
[   44.546523]  __x64_sys_pwrite64+0x6d/0xc0
[   44.546523]  do_syscall_64+0x6a/0xf0
[   44.546523]  ? __wake_up+0x89/0xb0
[   44.546523]  ? xas_find+0x72/0x1c0
[   44.546523]  ? next_uptodate_folio+0x317/0x330
[   44.546523]  ? set_pte_range+0x1a6/0x270
[   44.546523]  ? filemap_map_pages+0x6ee/0x840
[   44.546523]  ? ext4_setattr+0x2fa/0x750
[   44.546523]  ? do_pte_missing+0x128/0xf70
[   44.546523]  ? security_inode_post_setattr+0x3e/0xd0
[   44.546523]  ? ___pte_offset_map+0x19/0x100
[   44.546523]  ? handle_mm_fault+0x721/0xa10
[   44.546523]  ? do_user_addr_fault+0x197/0x730
[   44.546523]  ? do_syscall_64+0x76/0xf0
[   44.546523]  ? arch_exit_to_user_mode_prepare+0x1e/0x60
[   44.546523]  ? irqentry_exit_to_user_mode+0x79/0x90
[   44.546523]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[   44.546523] RIP: 0033:0x7f42999c6687
[   44.546523] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   44.546523] RSP: 002b:00007ffeae4a7930 EFLAGS: 00000202 ORIG_RAX: 0000000000000012
[   44.546523] RAX: ffffffffffffffda RBX: 00007f4299934740 RCX: 00007f42999c6687
[   44.546523] RDX: 0000000000000001 RSI: 000055ea6149200f RDI: 0000000000000003
[   44.546523] RBP: 00007ffeae4a79a0 R08: 0000000000000000 R09: 0000000000000000
[   44.546523] R10: 0000010000000005 R11: 0000000000000202 R12: 0000000000000000
[   44.546523] R13: 00007ffeae4a7ac8 R14: 00007f4299b86000 R15: 000055ea61493dd8
[   44.546523]  </TASK>
[   44.546523] Modules linked in:
[   44.568501] ---[ end trace 0000000000000000 ]---
[   44.568889] RIP: 0010:ext4_write_inline_data+0xfe/0x100
[   44.569328] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 49
[   44.570931] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
[   44.571356] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: 0000010000000006
[   44.571959] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: ffff9329c158e738
[   44.572571] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[   44.573148] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: 0000006210000000
[   44.573748] R13: fffffc7e4015e700 R14: 0000010000000005 R15: ffff9329c158e738
[   44.574335] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) knlGS:0000000000000000
[   44.575027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.575520] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: 0000000000770eb0
[   44.576112] PKRU: 55555554
[   44.576338] Kernel panic - not syncing: Fatal exception
[   44.576517] Kernel Offset: 0x1a600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org
---
 fs/ext4/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2c9b762925c72f2ff5a402b02500370bc1eb0eb1..e5e6bf0d338b965a885fb99581f9ed5e51c5257c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -397,7 +397,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 }
 
 static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
-				    unsigned int len)
+				    loff_t len)
 {
 	int ret, size, no_expand;
 	struct ext4_inode_info *ei = EXT4_I(inode);

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250415-ext4-prepare-inline-overflow-8db0e747cb16

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


