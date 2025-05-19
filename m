Return-Path: <linux-fsdevel+bounces-49393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB144ABBB5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309B23B1EDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF2274656;
	Mon, 19 May 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dRUm4Eal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939B4C92;
	Mon, 19 May 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651391; cv=none; b=B9TF0+E1dSw+XTiTfGr/zTufOwKLoaVSLYJTLjngno+HXNGVmg+c91pVUNZYlZHQEHEf9egE+u+JuM6wZTcG2jUq5GEVS/rtcmYI/ZXT5r13VfCOHQtUmFOssv/dqPYgj5MwCfknzoua1cLf2XrBgo+yDdIB4v4viKpXNpQMm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651391; c=relaxed/simple;
	bh=S8QUrRNxJY/I87qAbHHhRL5c67O+zlU6bkC4edR4hoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JO2nRPbP5fNf3nmmNM5QbyYNbm31dQBytIfcGq8ruwvl3BFf7aCDE2+Xi8cXRQNWi0AbF9VN4j3k4cJ20VQfcx1zvE7zSCuXh1PiORgKjWgIoJucGGsx/qV2YKv6kCIzQ3JsktMwZD/R6/NdIIYrsr71UDiBcnATdDAQsfOxysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dRUm4Eal; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/wjRdfKuYR+hu2GSwHqSaLOLcZnsXAkfGl3Iw/Uu0yk=; b=dRUm4Ealz8kSO3D5W76W1aftie
	wb5W/LFwNxCCOVi67XFQRn1fxbdkvMQL9luJ/cx/NtOKKc4Aem/27ZIpNWgmTFS9j+bMBK3pwg6Zv
	VsYBZpA/HmJp1eqPoKt1U1vi0LgMyzdwwkqH06GDpeJsgO0LFBY0VOlAYxLsSKoPk5JNIzesitcDX
	KSh5MkheKWb5Wezr1K7U3Vw4GH40pzTTVufFYahWQRQRSMIjoZge3eKypQ6AqB5jxuJNLT9Bs9qW7
	zS8wVMzf2HpiZTG520xtUgvfoqJajgJ6yt+Em6grAHn/swM+tTmocfQ5vJuH6Jkn+aX6DfjM1YRYM
	S15cjD5w==;
Received: from 179-125-70-180-dinamico.pombonet.net.br ([179.125.70.180] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uGxxP-00ACFf-IE; Mon, 19 May 2025 12:42:55 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 19 May 2025 07:42:46 -0300
Subject: [PATCH] ext4: inline: do not convert when writing to memory map
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com>
X-B4-Tracking: v=1; b=H4sIACULK2gC/x3MQQqDMBBG4avIrBtIBrOwVyklhPgnDm1TSUQF8
 e4Gl9/ivYMqiqDSszuoYJUq/9xgHh2FyecEJWMzsWarrRkU9qV3kr+S4Waf4H6frcgCFXoO3kT
 NPFhq+VwQZb/Xr/d5XpIKAG9qAAAA
X-Change-ID: 20250519-ext4_inline_page_mkwrite-c42ca1f02295
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
 Tao Ma <boyu.mt@taobao.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Eric Biggers <ebiggers@google.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

inline data handling has a race between writing and writing to a memory
map.

When ext4_page_mkwrite is called, it calls ext4_convert_inline_data, which
destroys the inline data, but if block allocation fails, restores the
inline data. In that process, we could have:

CPU1					CPU2
destroy_inline_data
					write_begin (does not see inline data)
restory_inline_data
					write_end (sees inline data)

This leads to bugs like the one below, as write_begin did not prepare for
the case of inline data, which is expected by the write_end side of it.

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor110 Not tainted 6.13.0-rc3-syzkaller-00209-g499551201b5f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0xdc7/0xdd0 fs/ext4/inline.c:774
Code: 47 1d 8c e8 4b 3a 91 ff 90 0f 0b e8 63 7a 47 ff 48 8b 7c 24 10 48 c7 c6 e0 47 1d 8c e8 32 3a 91 ff 90 0f 0b e8 4a 7a 47 ff 90 <0f> 0b 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900031c7320 EFLAGS: 00010293
RAX: ffffffff8257f9a6 RBX: 000000000000005a RCX: ffff888012968000
RDX: 0000000000000000 RSI: 000000000000005a RDI: 000000000000005b
RBP: ffffc900031c7448 R08: ffffffff8257ef87 R09: 1ffff11006806070
R10: dffffc0000000000 R11: ffffed1006806071 R12: 000000000000005a
R13: dffffc0000000000 R14: ffff888076b65bd8 R15: 000000000000005b
FS:  00007f5c6bacf6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000a00 CR3: 0000000073fb6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 generic_perform_write+0x6f8/0x990 mm/filemap.c:4070
 ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x892/0x1c50
 iter_file_splice_write+0xbfc/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11d/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x588/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c6bb18d09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c6bacf218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f5c6bba0708 RCX: 00007f5c6bb18d09
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f5c6bba0700 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 00007f5c6bb6d620
R13: 00007f5c6bb6d0c0 R14: 0031656c69662f2e R15: 8088e3ad122bc192
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

This happens because ext4_page_mkwrite is not protected by the inode_lock.
The xattr semaphore is not sufficient to protect inline data handling in a
sane way, so we need to rely on the inode_lock. Adding the inode_lock to
ext4_page_mkwrite is not an option, otherwise lock-ordering problems with
mmap_lock may arise.

The conversion inside ext4_page_mkwrite was introduced at commit
7b4cc9787fe3 ("ext4: evict inline data when writing to memory map"). This
fixes a documented bug in the commit message, which suggests some
alternatives fixes.

The alternative of keeping the data inline is left as an exercise for the
reader.

Instead, block allocation still happens, just as it does right now. But
removal of the inline data is only done when pages are written back.

Fixes: 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map")
Reported-by: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org
---
 fs/ext4/inode.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a64e42ded09c82497ed7617071aa19..38653d5c8b32ede2b130285ab13ef1e96b1ba783 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2620,8 +2620,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 			ret = PTR_ERR(handle);
 			goto out_writepages;
 		}
-		BUG_ON(ext4_test_inode_state(inode,
-				EXT4_STATE_MAY_INLINE_DATA));
+		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 		ext4_destroy_inline_data(handle, inode);
 		ext4_journal_stop(handle);
 	}
@@ -6222,10 +6221,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 
 	filemap_invalidate_lock_shared(mapping);
 
-	err = ext4_convert_inline_data(inode);
-	if (err)
-		goto out_ret;
-
 	/*
 	 * On data journalling we skip straight to the transaction handle:
 	 * there's no delalloc; page truncated will be checked later; the

---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250519-ext4_inline_page_mkwrite-c42ca1f02295

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


