Return-Path: <linux-fsdevel+bounces-67020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB7FC337C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D934BEFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48F224AF3;
	Wed,  5 Nov 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptR0KmoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C462940D;
	Wed,  5 Nov 2025 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303113; cv=none; b=t+GXxjKTELhEfdmyQvCSEmVwD3AYhAOVWEDLpkMkTGeRweLrGYAFYyFXbDzLHzpUGzKU9ethbXCXFI7Qcdle4lwkyS9rfOAcH85oBdLfZ3rtigttmRyT5XJuXBmMs10p1eWqWb9j/o4e7at57N4NCnAVC7PXhltx7Z36BZJp+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303113; c=relaxed/simple;
	bh=ozzedGexVm3c7LAJROJn2IsFXaRUObyKrN+iT0hZtCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKw4tcby5VQKjP8Yd7QMloQ0ek0pVnhtT80m/VSsUoWik4716bFgo4Mo5K8LZFWGl92kLGH03607MHC8ZgK/9f13cccBvMFPNJDiwLs3M0QDHmaunha6QMsEcQIDa7qRLPZ20E773j3WoivWKyNITu8B0tCbKTUA13CqPXZjQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptR0KmoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C518C4CEF7;
	Wed,  5 Nov 2025 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303111;
	bh=ozzedGexVm3c7LAJROJn2IsFXaRUObyKrN+iT0hZtCY=;
	h=From:To:Cc:Subject:Date:From;
	b=ptR0KmoBFtTbL19XkNIzXueSZWZY/twdtmdgLFHw75tnPtDRLgthL4Nu42I1+NGgP
	 R9YGZwqNNroue9gVRuJOYNFQl8c5CCpwsAb/DUR/WcDNILYwgUPd8NYjGCpxlA4LP2
	 1NoLoMvXzsIiAz/i4dwPKYEtJgwki5bEAnh5aniham5fCcjSgmCJtmVRQBVaQ7GIgk
	 Lh70Vw9Elxqxq8hv8mLW+41TPihRhOeqYz4Fmh1g1DHOdWO0n3htihIMSlbC5J+DKF
	 wBNG2RzCxDahK8tEKZinOcULkU3G+14Y2GCKiuCRrqWtYNCm9USN72qyt2RU76j0Qv
	 uA1GHnu4H3/xQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3] fscrypt: fix left shift underflow when inode->i_blkbits > PAGE_SHIFT
Date: Tue,  4 Nov 2025 16:36:42 -0800
Message-ID: <20251105003642.42796-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When simulating an nvme device on qemu with both logical_block_size and
physical_block_size set to 8 KiB, an error trace appears during
partition table reading at boot time. The issue is caused by
inode->i_blkbits being larger than PAGE_SHIFT, which leads to a left
shift of -1 and triggering a UBSAN warning.

[    2.697306] ------------[ cut here ]------------
[    2.697309] UBSAN: shift-out-of-bounds in fs/crypto/inline_crypt.c:336:37
[    2.697311] shift exponent -1 is negative
[    2.697315] CPU: 3 UID: 0 PID: 274 Comm: (udev-worker) Not tainted 6.18.0-rc2+ #34 PREEMPT(voluntary)
[    2.697317] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    2.697320] Call Trace:
[    2.697324]  <TASK>
[    2.697325]  dump_stack_lvl+0x76/0xa0
[    2.697340]  dump_stack+0x10/0x20
[    2.697342]  __ubsan_handle_shift_out_of_bounds+0x1e3/0x390
[    2.697351]  bh_get_inode_and_lblk_num.cold+0x12/0x94
[    2.697359]  fscrypt_set_bio_crypt_ctx_bh+0x44/0x90
[    2.697365]  submit_bh_wbc+0xb6/0x190
[    2.697370]  block_read_full_folio+0x194/0x270
[    2.697371]  ? __pfx_blkdev_get_block+0x10/0x10
[    2.697375]  ? __pfx_blkdev_read_folio+0x10/0x10
[    2.697377]  blkdev_read_folio+0x18/0x30
[    2.697379]  filemap_read_folio+0x40/0xe0
[    2.697382]  filemap_get_pages+0x5ef/0x7a0
[    2.697385]  ? mmap_region+0x63/0xd0
[    2.697389]  filemap_read+0x11d/0x520
[    2.697392]  blkdev_read_iter+0x7c/0x180
[    2.697393]  vfs_read+0x261/0x390
[    2.697397]  ksys_read+0x71/0xf0
[    2.697398]  __x64_sys_read+0x19/0x30
[    2.697399]  x64_sys_call+0x1e88/0x26a0
[    2.697405]  do_syscall_64+0x80/0x670
[    2.697410]  ? __x64_sys_newfstat+0x15/0x20
[    2.697414]  ? x64_sys_call+0x204a/0x26a0
[    2.697415]  ? do_syscall_64+0xb8/0x670
[    2.697417]  ? irqentry_exit_to_user_mode+0x2e/0x2a0
[    2.697420]  ? irqentry_exit+0x43/0x50
[    2.697421]  ? exc_page_fault+0x90/0x1b0
[    2.697422]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.697425] RIP: 0033:0x75054cba4a06
[    2.697426] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[    2.697427] RSP: 002b:00007fff973723a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[    2.697430] RAX: ffffffffffffffda RBX: 00005ea9a2c02760 RCX: 000075054cba4a06
[    2.697432] RDX: 0000000000002000 RSI: 000075054c190000 RDI: 000000000000001b
[    2.697433] RBP: 00007fff973723c0 R08: 0000000000000000 R09: 0000000000000000
[    2.697434] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[    2.697434] R13: 00005ea9a2c027c0 R14: 00005ea9a2be5608 R15: 00005ea9a2be55f0
[    2.697436]  </TASK>
[    2.697436] ---[ end trace ]---

This situation can happen for block devices because when
CONFIG_TRANSPARENT_HUGEPAGE is enabled, the maximum logical_block_size
is 64 KiB. set_init_blocksize() then sets the block device
inode->i_blkbits to 13, which is within this limit.

File I/O does not trigger this problem because for filesystems that do
not support the FS_LBS feature, sb_set_blocksize() prevents
sb->s_blocksize_bits from being larger than PAGE_SHIFT. During inode
allocation, alloc_inode()->inode_init_always() assigns inode->i_blkbits
from sb->s_blocksize_bits. Currently, only xfs_fs_type has the FS_LBS
flag, and since xfs I/O paths do not reach submit_bh_wbc(), it does not
hit the left-shift underflow issue.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
Cc: stable@vger.kernel.org
[EB: use folio_pos() and consolidate the two shifts by i_blkbits]
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting the fscrypt/for-current tree

 fs/crypto/inline_crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 5dee7c498bc8..ed6e926226b5 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -331,12 +331,11 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 	if (!mapping)
 		return false;
 	inode = mapping->host;
 
 	*inode_ret = inode;
-	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
-			(bh_offset(bh) >> inode->i_blkbits);
+	*lblk_num_ret = (folio_pos(folio) + bh_offset(bh)) >> inode->i_blkbits;
 	return true;
 }
 
 /**
  * fscrypt_set_bio_crypt_ctx_bh() - prepare a file contents bio for inline

base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.2


