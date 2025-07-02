Return-Path: <linux-fsdevel+bounces-53695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C146FAF60C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81E71C45012
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3C30E84C;
	Wed,  2 Jul 2025 18:04:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E86303DE7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479476; cv=none; b=MP4W5DXyAQ1tlqcGicuiRy7pk5+A+8KQxoZ1bQ3mkLEZm1ZV4HlsODacOp52HuBN09GuJRvHxLebgtDr7bewcHLcct1+FV6Zw4H7beYI5XHMe3sK0+e0YjtMBZ1xi11RGn5rlPOXCEdzF7e0oaTtumuN6Z0c3GRc+29OUfp41kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479476; c=relaxed/simple;
	bh=MeGhe2mttaKHpCVGJgrYdXNCwVK11eBfRyYgPxHqVJI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=prNMgMhELOcIDH7sdnjjcu3N+eInsaHic9xocrtYreUro38anSB8xmBpRIKoYIKNj6tO5RjmaM4Ww4AYfK4uZoZe+4vo2B4B2654miEf0tXk8Mx+6NYDU2t6L53W2gACD22tgAB/FY3vDynQLPshI1SGb/+w15QbVIK8bK4GBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3de3b5b7703so30919075ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 11:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751479473; x=1752084273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWF48hCLYWTcAUa93f/lkLlH9TGxtsXE9JeXqdiBcZI=;
        b=J+bX0cHTwncTq3DDlEIvH/BBY7dKjqlIxQMfnhWmwozbWXdUgbrO+IszQLQd+fo9Q+
         oDOJZfv3YntovoX77kM4cADdEK9HRWiuNUlJ6eNQGfBcnvtXQYxetdjn9uIYmhgBOzNe
         6m8XRy1KOltmUFdZxW4o5QrKvu0LsKMYDhsFlSzI/uHuYjxS0p+qKzzYZeibkM+wI5Wz
         xnYN0T4p4SuuK1IYDOWO3yCbr0/kUdy3Z6+K6Ca7dPjgAGUz5NhcN/zVRNKZNlTzBQU0
         NTv+b7h5DsHqg3UmDCAwf6DgfyeMs43eknBD/mPFingmWIO0iRFBvMvBhfp4oDiczVGl
         DSgA==
X-Forwarded-Encrypted: i=1; AJvYcCUAD4GmbSsmxosDora705vZhvJbR3LPaTdKHmlJAYcpsZYN5tHQc6ZvFbDBHhcURekF6SZah0e8TNapJWPB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85TViCQKylsfpDdLuiymM0SpYSV2FyplGXR6KHrpl6p1WCRGp
	b6STyRDFVFuheR5j0Z2b8k6ay6YB3QbDjwW45D25XymaC0DgEl/VP8vQc2nI4g28iJqqgD2K4KR
	pRMf7Img/BOaXo/D9qPNF+TDAPX5/+ZNFK/swsuknxZ4W//bewfadROHtzAc=
X-Google-Smtp-Source: AGHT+IEDDPHJ6rByvRwtWViZclAbpUat+tBrzPzW5bYNpP27gP4LoBLScAVZMw2cVIFqPF5yFIuoPmFXMeliS+GLfYdnNv8By5RB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3008:b0:3df:4ad5:3a71 with SMTP id
 e9e14a558f8ab-3e0549c5d57mr46047685ab.11.1751479473494; Wed, 02 Jul 2025
 11:04:33 -0700 (PDT)
Date: Wed, 02 Jul 2025 11:04:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686574b1.a70a0220.2b31f5.0002.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in __simple_recursive_removal
From: syzbot <syzbot+6d7771315ecb9233f395@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152d348c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70c16e4e191115d4
dashboard link: https://syzkaller.appspot.com/bug?extid=6d7771315ecb9233f395
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106bd770580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b048c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d4ef6bedc5b/disk-50c8770a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15b7565dc0ef/vmlinux-50c8770a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b397342a62b/bzImage-50c8770a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d7771315ecb9233f395@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.16.0-rc4-next-20250702-syzkaller #0 Not tainted
--------------------------------------------
syz-executor365/5837 is trying to acquire lock:
ffff8880792cc650 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
ffff8880792cc650 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: __simple_recursive_removal+0x95/0x510 fs/libfs.c:614

but task is already holding lock:
ffff888027bf0148 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
ffff888027bf0148 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: bm_entry_write+0x289/0x540 fs/binfmt_misc.c:737

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sb->s_type->i_mutex_key#15);
  lock(&sb->s_type->i_mutex_key#15);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor365/5837:
 #0: ffff88807e5fc428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3098 [inline]
 #0: ffff88807e5fc428 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682
 #1: ffff888027bf0148 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #1: ffff888027bf0148 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: bm_entry_write+0x289/0x540 fs/binfmt_misc.c:737

stack backtrace:
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor365 Not tainted 6.16.0-rc4-next-20250702-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3044
 check_deadlock kernel/locking/lockdep.c:3096 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3898
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:869 [inline]
 __simple_recursive_removal+0x95/0x510 fs/libfs.c:614
 remove_binfmt_handler fs/binfmt_misc.c:694 [inline]
 bm_entry_write+0x4f7/0x540 fs/binfmt_misc.c:749
 vfs_write+0x27e/0xa90 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f147e7aa369
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed0db9fa8 EFLAGS: 00000246 ORIG_RAX


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

