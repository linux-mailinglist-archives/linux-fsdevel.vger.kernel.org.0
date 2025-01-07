Return-Path: <linux-fsdevel+bounces-38575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4DA04372
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4593A484E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA11F2C51;
	Tue,  7 Jan 2025 14:55:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621981E377F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261727; cv=none; b=Lm4bOQaVA/EVulzU0RkIu3D1PsJqhWDpxqhpLQMxq9+j0WQc8/YrBum/CHuRNagnDtxDpRJfQ4BvLuKUZALvDY3dHrAvyZAAzzlRsW04dSJboPu9LUQHLvCtidNKDgwb7Ki/XvFkxXPaDY9tRZd9MUbIOoAivjj+G7qKfroi5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261727; c=relaxed/simple;
	bh=0qCdKQneBWA3BwlJOfMq+7AvSFPRHBE0X4fX4DJMnR8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ltBOlCTCbzufTDmIWVkLctUppiThMMJvzOJ9Lr4i5fqktXJZ0cnGA9L+Lq0Zk3twV5Kyjj7+BshuFNScCLHK8gt41TNknelh/Zbx3qIngLw9biDH5HkUVPvgQ4vSyUom8XNEl2mxBbdOcWR5w2p6xekTclc4pwEV1D3TPvAU8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844cffcb685so1312268939f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 06:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261723; x=1736866523;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSKaeHJFMWVUK3VjWZa7esu3kPsB2GUSA4L0GU0PtQM=;
        b=BzFcvRdau6s3GbDWuVMfpja0Nn4Bqy6voBfWmPjEbYLh4D0jUngr6PoUtFWzSZl3eu
         7JhFMc8/5cY772LQBm/JsEVYBEoJESoJ3IIu6i7n8CO829xj7mYEcTO9usmHTzgCJeZC
         8Pran8k2NjU/8NyFkoe4suBM0ot5oPIZrAXtM0bWpnSE6XHzbJVapkILCkxOewO5jNef
         +ZIk1NaoTw+soORvIqdEf+THihXSFe3WVlOUGHqY4vwAE+8WJF/9mEbPS0cxAA4LrOYF
         KJQxoXvd2WOR3vJ1KWGX8zsri3iHvzHiPbHvOIW+duaZIy/A/yEWvyDnkelWXw1L2Q/X
         tU5w==
X-Forwarded-Encrypted: i=1; AJvYcCV+2bsyZK0vT38iS8Vqx5UDgtjpPHSHq5v8ml+IRrHevbIIpEPYMqIK7vPH+XkiJORYpbQPYbaVagZf92AC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fzQ8Zdy4pY03Ne8eyHRAFs/hLhbAZlDBfEeuwSufnSsf0aRq
	nAgaN/7QNnl8yuJqu6In4hvKq/qXlr49YBTeXlYHAmiWdhTB7L45cEPCvWzUsYWmi4zl5UuRKNi
	ecaKQF5w7JzOVzyPEzV6D8DbKEHS6NTzvwrkrRi8MM6cjPBNoOyGV/jI=
X-Google-Smtp-Source: AGHT+IGQ8dCg4whOOtvGiEoWvmgh0Gbdh1ATM9BBN8zxViw0eBD/8Qg26jMGPH4DCekypTW59rsnV44lUsUBeDwjsEjrA2DvRAzs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d5:b0:847:4fc0:c775 with SMTP id
 ca18e2360f4ac-8499e6275a8mr5640759239f.8.1736261723373; Tue, 07 Jan 2025
 06:55:23 -0800 (PST)
Date: Tue, 07 Jan 2025 06:55:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677d405b.050a0220.3b3668.02cc.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in __xa_clear_mark /
 file_write_and_wait_range (2)
From: syzbot <syzbot+007c9229c84d20508ed4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbfd64d25c7a Merge tag 'vfs-6.13-rc7.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d924b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ab3e6c069ff12aa
dashboard link: https://syzkaller.appspot.com/bug?extid=007c9229c84d20508ed4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05565573a810/disk-fbfd64d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab7f10eda1f6/vmlinux-fbfd64d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9e23f8269e0/bzImage-fbfd64d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+007c9229c84d20508ed4@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 1024
EXT4-fs: Ignoring removed orlov option
EXT4-fs (loop2): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
==================================================================
BUG: KCSAN: data-race in __xa_clear_mark / file_write_and_wait_range

write to 0xffff88812f452b24 of 4 bytes by interrupt on cpu 0:
 xa_mark_clear lib/xarray.c:77 [inline]
 xas_clear_mark lib/xarray.c:925 [inline]
 __xa_clear_mark+0x1cc/0x1f0 lib/xarray.c:1957
 __folio_end_writeback+0x187/0x490 mm/page-writeback.c:3093
 folio_end_writeback+0x74/0x1f0 mm/filemap.c:1624
 ext4_finish_bio+0x476/0x8e0 fs/ext4/page-io.c:144
 ext4_end_bio+0x18c/0x2c0
 bio_endio+0x369/0x410 block/bio.c:1645
 blk_update_request+0x368/0x860 block/blk-mq.c:981
 blk_mq_end_request+0x26/0x50 block/blk-mq.c:1143
 lo_complete_rq+0xce/0x180 drivers/block/loop.c:386
 blk_complete_reqs block/blk-mq.c:1218 [inline]
 blk_done_softirq+0x74/0xb0 block/blk-mq.c:1223
 handle_softirqs+0xbf/0x280 kernel/softirq.c:561
 run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
 smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff88812f452b24 of 4 bytes by task 21332 on cpu 1:
 xa_marked include/linux/xarray.h:424 [inline]
 mapping_tagged include/linux/fs.h:504 [inline]
 filemap_fdatawrite_wbc mm/filemap.c:384 [inline]
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 file_write_and_wait_range+0x116/0x2f0 mm/filemap.c:778
 generic_buffers_fsync_noflush+0x46/0x120 fs/buffer.c:600
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x1ff/0x6c0 fs/ext4/fsync.c:151
 vfs_fsync_range+0x116/0x130 fs/sync.c:187
 generic_write_sync include/linux/fs.h:2904 [inline]
 ext4_buffered_write_iter+0x326/0x370 fs/ext4/file.c:305
 ext4_file_write_iter+0x383/0xf20
 iter_file_splice_write+0x5f1/0x980 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x160/0x2c0 fs/splice.c:1164
 splice_direct_to_actor+0x302/0x670 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0xd7/0x150 fs/splice.c:1233
 do_sendfile+0x398/0x660 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64 fs/read_write.c:1410 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1410
 x64_sys_call+0xfbd/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:41
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x06000021 -> 0x0a000021

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 21332 Comm: syz.2.7270 Not tainted 6.13.0-rc6-syzkaller-00036-gfbfd64d25c7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


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

