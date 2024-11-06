Return-Path: <linux-fsdevel+bounces-33726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F19BE244
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56F41F24C2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A887B1D90BD;
	Wed,  6 Nov 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="fkW11+rK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421801D79B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884873; cv=none; b=HYIFvofuu9hGT1GvCV37htAmcIa652tFcru5cXS+RT4Oo15QRPCGHE8fp/gd8xIXyXAEl7fMPcC/i+c3KOaW90ZbiOFhRjCqnT/yTd/4bTmbXBaucnLVZ/nmVBFq4mn2imY5AcDKRWJX9R8UHXfDs2Vn93JTaB7fyxsruvItHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884873; c=relaxed/simple;
	bh=uPCPCQ69kt1hSEoRyBei0kngtqI2c6oh3GLt50HM8UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFWWAMQlaP3SA15+QOBxYRyJWZlr7NqZhzgN48bxhqBfZMOPP55b92oQ+20XuZHjf7gZol1FfzFrlNNnv0FIRIsLuEBd2N2eb4CvIXdewQ/hE8Jeof8ZRK/stY8eV//L7zCnPaUg10Ktdpl/SnPBfP99GjTif5K//XJ8KmUDlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=fkW11+rK; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:1611:0:640:6020:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 7A1866090B;
	Wed,  6 Nov 2024 12:21:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5LdIPq0Df4Y0-UsBuh7TZ;
	Wed, 06 Nov 2024 12:21:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730884866; bh=k+4RQcjonrzwApxokLdx41JH3uNqhr6WcQulLScph1U=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=fkW11+rKyQxWC3kL5LIIJj7GmgPFDaZT1BGm3lMXRP6xcmBA/IdC23Fk67oM6mCKC
	 OT4o7kk2dGWw97WBg0iNDfyLWW6Fzdwm+F8Bls72lal9J29PlGrH8eRzd2NK7WXy/2
	 ppA5SVYDnFRyMI/QxTePA1m9efspAyKfaBaMiazc=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com
Subject: [PATCH v2] ocfs2: fix UBSAN warning in ocfs2_verify_volume()
Date: Wed,  6 Nov 2024 12:21:00 +0300
Message-ID: <20241106092100.2661330-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <8a14ce14-8c91-4778-84d8-2eebec945325@linux.alibaba.com>
References: <8a14ce14-8c91-4778-84d8-2eebec945325@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following splat triggered by UBSAN:

UBSAN: shift-out-of-bounds in fs/ocfs2/super.c:2336:10
shift exponent 32768 is too large for 32-bit type 'int'
CPU: 2 UID: 0 PID: 5255 Comm: repro Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x241/0x360
 ? __pfx_dump_stack_lvl+0x10/0x10
 ? __pfx__printk+0x10/0x10
 ? __asan_memset+0x23/0x50
 ? lockdep_init_map_type+0xa1/0x910
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420
 ocfs2_fill_super+0xf9c/0x5750
 ? __pfx_ocfs2_fill_super+0x10/0x10
 ? __pfx_validate_chain+0x10/0x10
 ? __pfx_validate_chain+0x10/0x10
 ? validate_chain+0x11e/0x5920
 ? __lock_acquire+0x1384/0x2050
 ? __pfx_validate_chain+0x10/0x10
 ? string+0x26a/0x2b0
 ? widen_string+0x3a/0x310
 ? string+0x26a/0x2b0
 ? bdev_name+0x2b1/0x3c0
 ? pointer+0x703/0x1210
 ? __pfx_pointer+0x10/0x10
 ? __pfx_format_decode+0x10/0x10
 ? __lock_acquire+0x1384/0x2050
 ? vsnprintf+0x1ccd/0x1da0
 ? snprintf+0xda/0x120
 ? __pfx_lock_release+0x10/0x10
 ? do_raw_spin_lock+0x14f/0x370
 ? __pfx_snprintf+0x10/0x10
 ? set_blocksize+0x1f9/0x360
 ? sb_set_blocksize+0x98/0xf0
 ? setup_bdev_super+0x4e6/0x5d0
 mount_bdev+0x20c/0x2d0
 ? __pfx_ocfs2_fill_super+0x10/0x10
 ? __pfx_mount_bdev+0x10/0x10
 ? vfs_parse_fs_string+0x190/0x230
 ? __pfx_vfs_parse_fs_string+0x10/0x10
 legacy_get_tree+0xf0/0x190
 ? __pfx_ocfs2_mount+0x10/0x10
 vfs_get_tree+0x92/0x2b0
 do_new_mount+0x2be/0xb40
 ? __pfx_do_new_mount+0x10/0x10
 __se_sys_mount+0x2d6/0x3c0
 ? __pfx___se_sys_mount+0x10/0x10
 ? do_syscall_64+0x100/0x230
 ? __x64_sys_mount+0x20/0xc0
 do_syscall_64+0xf3/0x230
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f37cae96fda
Code: 48 8b 0d 51 ce 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1e ce 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff6c1aa228 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff6c1aa240 RCX: 00007f37cae96fda
RDX: 00000000200002c0 RSI: 0000000020000040 RDI: 00007fff6c1aa240
RBP: 0000000000000004 R08: 00007fff6c1aa280 R09: 0000000000000000
R10: 00000000000008c0 R11: 0000000000000206 R12: 00000000000008c0
R13: 00007fff6c1aa280 R14: 0000000000000003 R15: 0000000001000000
 </TASK>

For a really damaged superblock, the value of 'i_super.s_blocksize_bits'
may exceed the maximum possible shift for an underlying 'int'. So add an
extra check whether the aforementioned field represents the valid block
size, which is 512 bytes, 1K, 2K, or 4K.

Reported-by: syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=56f7cd1abe4b8e475180
Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: variable name and message nits as suggested by Joseph
---
 fs/ocfs2/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3d404624bb96..c79b4291777f 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2319,6 +2319,7 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			       struct ocfs2_blockcheck_stats *stats)
 {
 	int status = -EAGAIN;
+	u32 blksz_bits;
 
 	if (memcmp(di->i_signature, OCFS2_SUPER_BLOCK_SIGNATURE,
 		   strlen(OCFS2_SUPER_BLOCK_SIGNATURE)) == 0) {
@@ -2333,11 +2334,15 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 				goto out;
 		}
 		status = -EINVAL;
-		if ((1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits)) != blksz) {
+		/* Acceptable block sizes are 512 bytes, 1K, 2K and 4K. */
+		blksz_bits = le32_to_cpu(di->id2.i_super.s_blocksize_bits);
+		if (blksz_bits < 9 || blksz_bits > 12) {
 			mlog(ML_ERROR, "found superblock with incorrect block "
-			     "size: found %u, should be %u\n",
-			     1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits),
-			       blksz);
+			     "size bits: found %u, should be 9, 10, 11, or 12\n",
+			     blksz_bits);
+		} else if ((1 << le32_to_cpu(blksz_bits)) != blksz) {
+			mlog(ML_ERROR, "found superblock with incorrect block "
+			     "size: found %u, should be %u\n", 1 << blksz_bits, blksz);
 		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=
 			   OCFS2_MAJOR_REV_LEVEL ||
 			   le16_to_cpu(di->id2.i_super.s_minor_rev_level) !=
-- 
2.47.0


