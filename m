Return-Path: <linux-fsdevel+bounces-16347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D4189BA2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F4A1C22388
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C13BB50;
	Mon,  8 Apr 2024 08:26:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98538F96
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564779; cv=none; b=fo5ZvHpuFHoxeyW44LOfI6aSOXz/pKifV/9WzwxLCWp96rOrWWYab0HrG2FhbaHoZ+1kVdCeBb+8I8V4i55015MebGuVcjsmmSalwjnLCMWPbReUJREDccNDUgBHfXYAa2OSwJHdLt4W4GmdAnOlBp+sEf6wlIVZvnq2lMYvndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564779; c=relaxed/simple;
	bh=/Jtg+NeRPMsFlE0QQGjsP4QoCICP4TGVEmqGhuOhyJE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PrAkmSlL3Uy1CCHV9bnWlyrb7FPMU5dQdmIXar9hBqP5/E0uy3Xo1UzUfFJQd8ZKnOF9svFJRQbnv0/bXUGBcp7GcKTHwTVKkkKyRDo89SaPjWMGdgS/FCw3K2jXiGQLjhKqHW/1cO//isdvgpdkfhbDXkGAHiEj/NtiIMGwfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a2b97f88eso56745ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 01:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564777; x=1713169577;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpwnnhL0X5X253cB4zSmLnXn1GULv9cGLQ5C9RbRTj8=;
        b=skOryCGVXT4rxeCdWhCHpFl7pM/RaujLCHV4v5/G7isuqzXus1ZyQbJW8tEwvWmShh
         0+PPSe7HmlX3xrNsJ4fBYMu2eCxSQZp207T9u2Zglo/6i3qfqoY5RtPZt6g9zKDYawdC
         6D8IpTSiQcSms7ud0QYd2Y5UbySAssidJw0PITFrAiMXqc3jltH2XYjSFhPFMfCYJhFN
         F4t8nzC9Z31f3d/Wki5o3xK1ueUoJvHwfvGf18bYnaZIVYzBWY7NnWjKzdMLySGI2Et5
         qzxSw7Dx1qKrnNPCHgmLyL5Q6HM1ywFyn0RXLGZwGSCgPhzJAoBf91mijei61s8ErZyY
         gdFA==
X-Forwarded-Encrypted: i=1; AJvYcCXuH94V3xZ89+0WfFZCPEbxWDIwdanAcnqNTqlrC2m6QvnmnymEVJbwG1maO0R8eIa+Z3PUJFBEWbabDQ+jSl/GomUw248C4y2YiSp92g==
X-Gm-Message-State: AOJu0Yy3F+TZTrEozVYFZEpqXOF9QyUKIU79BP7JCqYVBTvVtW4vEp3A
	t9+i62KSC8eeeMqcyldasSFiB85Imw8yx2RTNKwEwn3pdb9RMWAAjBog/ADOpvhzPZXJT5i43UY
	y//kj67cpkMKAVcbvDaGc4k+EPrPq54WNcnfxKOAQEaKH63FXBmBdjfo=
X-Google-Smtp-Source: AGHT+IHNYmesH17RC4hBVq4RhTEaAwgh3U3TO/yO0EHYxbE0BSQhMEvihQ2J76h92zaR3+LhiHraj/1fC15O1XnIGJHFLYfBYOXU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:36a:23d5:e371 with SMTP id
 a12-20020a92c54c000000b0036a23d5e371mr186634ilj.6.1712564777018; Mon, 08 Apr
 2024 01:26:17 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:26:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000307a8e0615918f2b@google.com>
Subject: [syzbot] [ntfs3?] WARNING in attr_data_get_block (4)
From: syzbot <syzbot+8e034d7422d389827720@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10fbdda1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=8e034d7422d389827720
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171bf3a9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1084f189180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7a991be8b13a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e034d7422d389827720@syzkaller.appspotmail.com

R13: 00007ffd11b1eed8 R14: 431bde82d7b634db R15: 00007fad9422c03b
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x100, magic = 0x0, owner = 0xffff888022b61e01, curr 0xffff888022b61e00, list not empty
WARNING: CPU: 0 PID: 5077 at kernel/locking/rwsem.c:1342 __up_read+0x508/0x760 kernel/locking/rwsem.c:1342
Modules linked in:
CPU: 0 PID: 5077 Comm: syz-executor179 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__up_read+0x508/0x760 kernel/locking/rwsem.c:1342
Code: 24 10 80 3c 02 00 0f 85 21 02 00 00 48 8b 13 41 57 48 c7 c6 a0 bf 0c 8b 48 c7 c7 e0 bf 0c 8b 4c 8b 4c 24 08 e8 39 9a e5 ff 90 <0f> 0b 90 90 5f e9 c3 fe ff ff c6 05 2c 8a 1d 0e 01 90 4c 8d 7b 58
RSP: 0018:ffffc900043c6338 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880792208a0 RCX: ffffffff8150f3e9
RDX: ffff888022b61e00 RSI: ffffffff8150f3f6 RDI: 0000000000000001
RBP: ffffffff8f9f76b4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880792208a8
R13: 1ffff92000878c6b R14: ffff888079220908 R15: ffffffff8b0cbf60
FS:  00005555685f1380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fad9427a100 CR3: 0000000078f48000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 attr_data_get_block+0x1f9/0x1b70 fs/ntfs3/attrib.c:905
 ntfs_get_block_vbo+0x288/0xec0 fs/ntfs3/inode.c:587
 do_mpage_readpage+0x663/0x17c0 fs/mpage.c:232
 mpage_readahead+0x34d/0x590 fs/mpage.c:381
 ntfs_readahead+0x1f7/0x250 fs/ntfs3/inode.c:755
 read_pages+0x1ab/0xda0 mm/readahead.c:160
 page_cache_ra_unbounded+0x455/0x5f0 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x7b7/0xa70 mm/readahead.c:544
 ondemand_readahead+0x520/0x1140 mm/readahead.c:666
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:693
 page_cache_sync_readahead include/linux/pagemap.h:1300 [inline]
 filemap_get_pages+0xc0f/0x1840 mm/filemap.c:2507
 filemap_read+0x39b/0xcf0 mm/filemap.c:2603
 generic_file_read_iter+0x350/0x460 mm/filemap.c:2784
 ntfs_file_read_iter+0x258/0x330 fs/ntfs3/file.c:768
 __kernel_read+0x3ef/0xb20 fs/read_write.c:434
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2cf/0x3e0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1c6/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x7eb/0x950 security/integrity/ima/ima_api.c:291
 process_measurement+0x11ae/0x2100 security/integrity/ima/ima_main.c:359
 ima_file_check+0xc1/0x110 security/integrity/ima/ima_main.c:559
 security_file_post_open+0x70/0xc0 security/security.c:2975
 do_open fs/namei.c:3644 [inline]
 path_openat+0x17ad/0x2990 fs/namei.c:3799
 do_file_open_root+0x2dd/0x5b0 fs/namei.c:3851
 file_open_root+0x2a8/0x450 fs/open.c:1386
 do_handle_open+0x3c9/0x5c0 fs/fhandle.c:235
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fad941e3b19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd11b1ec88 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fad941e3b19
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007fad942765f0 R08: 00005555685f24c0 R09: 00005555685f24c0
R10: 00005555685f24c0 R11: 0000000000000246 R12: 00007ffd11b1ecb0
R13: 00007ffd11b1eed8 R14: 431bde82d7b634db R15: 00007fad9422c03b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

