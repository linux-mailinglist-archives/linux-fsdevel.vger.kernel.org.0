Return-Path: <linux-fsdevel+bounces-73190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DECD11443
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35AA53097D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36E340DB2;
	Mon, 12 Jan 2026 08:35:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D6331214
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206927; cv=none; b=dMf6yzuUYnxf0+LJld3TqR9WWELhwB7CcHVTE8BhXke+g/IxnpzZWh4GQxLoRcgNYBA/cImEoj+tyEJgXb9QS0xQr6XJqMv02zPU0tXMyrdBK7pjry8okgWQzUrxzNtvmBhcqqf4A9e1bFdCdNQmWSmFmpCskIOj3eey6fMt8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206927; c=relaxed/simple;
	bh=WTVtOpumTFGYus15qkA/UfC7BQZWnNNRbPYkbxx03Fc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kocQFTiTMOXoyYFai9XMEWX75eAXPXW8z8tm4qGcecgo78iuitBpK5m13lWvlu6holu/UveJnqmX4eCEl6SrjmkVwBOr0H8t6d/YJ3oblcVFIVZIANMCBVoT8qmeyXlq1BpKyvTMW9n82b5AIWNvNTWqxL4jg7/m2fgUJhARUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c7599a6f1fso20117619a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 00:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768206924; x=1768811724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hf3hK9th7s0xLdXJi+JD7lyNJWbgkO4+mlWuq40DxgM=;
        b=BKmBsI3GjOhAaHpjNtpOinND7ZeqAlDGcy7MjtAN9LnbWwk+gwaoo6wzH6g60orNAH
         gAdpYMr0OIzQAUnJljTKtDaTnalmH+3hiq8FkGpkCOgs05tBNwCOylPwiNxW0BXQmSId
         QcHCN9GDuVRs/+xVZUz9C82LVjVik09RXWhvNXticwFrvuM7XX0lMuM2XW92FLT9XLM7
         DJ+ZqE+zN4d94tmD56wqfGbyJAhmzxQw1U4sAAvys/d/v1nF2hQRUKPEZJqzSsovBJw+
         tpdoJj9t62VMVbWr/slPh4pA6T1XFxdLm1MnsZl3otkQ8GWBlpqWsJ+TaBUO9+IG37dv
         PEdw==
X-Forwarded-Encrypted: i=1; AJvYcCXk/+rk95cCfePrctLvNIIrBVj8s8yVlqqr+4ZrzdbzUBRfw61JQPSU7b9QSwlaxBHZCdLVkHK5f/AnYiOn@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIhbz6iV3Q9JYvAwCsdbtDSf5tuYUIK19W4XuRkVxhiocA3oW
	Xn/yEixYa/xOyceN7QUApXnGfq6shbQpVbm1yiINL7kqhfEXJMNFUxi9/SsnVRWMEuH8p56u1S6
	pJddSJWeGdxUS8Oy7wOqrj7EfErg7OkUqgl8ogLRhhKbjxc/Hxn6wtPquIMI=
X-Google-Smtp-Source: AGHT+IGUBTzCVtkq1XytkujkGpc6qNJJMsapUeXnQMUoes11HO8TAbYTEw0IuI25LJU+AbHgw2+GiOe8jbB0gzetAv7glJC1Kf8A
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6101:b0:65c:fa23:2cf7 with SMTP id
 006d021491bc7-65f54f7e6b0mr6082478eaf.65.1768206924493; Mon, 12 Jan 2026
 00:35:24 -0800 (PST)
Date: Mon, 12 Jan 2026 00:35:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6964b24c.050a0220.eaf7.008b.GAE@google.com>
Subject: [syzbot] [fs?] KMSAN: kernel-infoleak-after-free in anon_pipe_read
From: syzbot <syzbot+175753aff92b396b1f30@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7f98ab9da046 Merge tag 'for-6.19-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1334af92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3903bdf68407a14
dashboard link: https://syzkaller.appspot.com/bug?extid=175753aff92b396b1f30
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c40942ffda39/disk-7f98ab9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63f72388d8d6/vmlinux-7f98ab9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/751895685a54/bzImage-7f98ab9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+175753aff92b396b1f30@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_ubuf include/linux/iov_iter.h:30 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_and_advance include/linux/iov_iter.h:330 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_iter+0xef3/0x33f0 lib/iov_iter.c:197
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 _copy_to_iter+0xef3/0x33f0 lib/iov_iter.c:197
 copy_page_to_iter+0x482/0x910 lib/iov_iter.c:374
 anon_pipe_read+0x769/0x1e80 fs/pipe.c:343
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0x8ed/0xf90 fs/read_write.c:572
 ksys_read fs/read_write.c:715 [inline]
 __do_sys_read fs/read_write.c:724 [inline]
 __se_sys_read fs/read_write.c:722 [inline]
 __ia32_sys_read+0x1f9/0x4d0 fs/read_write.c:722
 ia32_sys_call+0x191f/0x4340 arch/x86/include/generated/asm/syscalls_32.h:4
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x154/0x320 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was stored to memory at:
 memcpy_to_folio include/linux/highmem.h:518 [inline]
 zswap_decompress+0x2bd/0x1000 mm/zswap.c:946
 zswap_load+0x262/0x570 mm/zswap.c:1627
 swap_read_folio+0x662/0x3050 mm/page_io.c:637
 swap_cluster_readahead+0x725/0xb20 mm/swap_state.c:652
 shmem_swapin_cluster mm/shmem.c:1745 [inline]
 shmem_swapin_folio+0x1fd9/0x3ee0 mm/shmem.c:2329
 shmem_get_folio_gfp+0x92a/0x1fc0 mm/shmem.c:2489
 shmem_get_folio mm/shmem.c:2662 [inline]
 shmem_file_splice_read+0x350/0x11e0 mm/shmem.c:3567
 do_splice_read fs/splice.c:982 [inline]
 splice_file_to_pipe+0x5b4/0x8f0 fs/splice.c:1292
 do_splice+0x29d8/0x30d0 fs/splice.c:1376
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __ia32_sys_splice+0x112/0x1a0 fs/splice.c:1618
 ia32_sys_call+0x31a6/0x4340 arch/x86/include/generated/asm/syscalls_32.h:314
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x154/0x320 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 free_pages_prepare mm/page_alloc.c:1328 [inline]
 free_unref_folios+0x26a/0x29a0 mm/page_alloc.c:3000
 folios_put_refs+0xaac/0xb10 mm/swap.c:1002
 folios_put include/linux/mm.h:1671 [inline]
 __folio_batch_release+0xe1/0x100 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x929/0x20c0 mm/shmem.c:1137
 shmem_truncate_range mm/shmem.c:1249 [inline]
 shmem_evict_inode+0x22c/0xed0 mm/shmem.c:1379
 evict+0x6a9/0xca0 fs/inode.c:837
 iput_final fs/inode.c:1951 [inline]
 iput+0xc6f/0x1070 fs/inode.c:2003
 do_unlinkat+0x58a/0xd80 fs/namei.c:5443
 __do_sys_unlink fs/namei.c:5474 [inline]
 __se_sys_unlink fs/namei.c:5472 [inline]
 __ia32_sys_unlink+0x70/0xa0 fs/namei.c:5472
 ia32_sys_call+0x1e4a/0x4340 arch/x86/include/generated/asm/syscalls_32.h:11
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x154/0x320 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Bytes 0-1023 of 1024 are uninitialized
Memory access of size 1024 starts at ffff8880731d2000
Data copied to user address 0000000056912be0

CPU: 1 UID: 0 PID: 5779 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

