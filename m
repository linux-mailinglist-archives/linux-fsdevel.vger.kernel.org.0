Return-Path: <linux-fsdevel+bounces-63199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02594BB1AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B89E1924393
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DC2D7DFB;
	Wed,  1 Oct 2025 20:18:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97A283C83
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759349916; cv=none; b=Ar9nEtqFjFWD2l3362EgIF8AIP+7eeGnIG8ieDBy3+Bp9Dy4IkK6PTPvYJAtadFPbIZMX6aYdWDp9sAzOB+gIUGiktWiTpdLYKpIYtapqsnuhpbYPq8ea2Z2IQpu8kuBYrT6xnW9T3iH1GtU7ZOTEQ3mwjjGNgRRrgk8Rq/FFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759349916; c=relaxed/simple;
	bh=gSTdKHmsdNxJtnwO20o5Qkbtv/za6DDPfn6WnH5RvSg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R6EtavAfdGXJjuxzSw5oayoUwsH7U80SrUOs5m7KZyQ/w4l8RZyCm5hkbgpQ2JTegswBpLk0gNO5OSgIscabIHeEe2P3WP/i/9RTnXuJk+gL7eVgeWykk3fDyYwGv6W6e+s/eCwa0tn1KUK0Ys98bqg95r4I0AAvLGI/9CAji+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-425788b03a0so7169345ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759349913; x=1759954713;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M00EfwyF4qlA8K1vxooFUQHiYpKD6upKIHd6xufrdbc=;
        b=mXseyxTtg10kd8MO8hyr56bbTfCWbrz9w9pqdq5WWLexz70A7fY+dmzg/tjKpJyCUC
         Hc1v3rMDk5dJnTKRaw+kqq6l7Qv/2TwfgYTY8r+ACfyAjo/ZR01j17PDN06d18dvACZY
         cef9YqDi0aVn11PBRfXrw0W3M/IhWWO2q5h5iMABffJK7/7tBPk15w0PqW84EHHrm0wG
         hLqlpY15iTnVgfROklT7WcleBDp+IQVGj/5w6gh4eHI0l8pBkW8FbL9vlCC7yhfHPzD3
         H1uXVvqmpT9KnyrFvRUuM7KdWlwWnGRb9Fg45eXig2jtkc17jje5gIH7jo6wDeXoSDtd
         Tvjw==
X-Forwarded-Encrypted: i=1; AJvYcCX+mnjo66+AI7BUKoQVEgdSQIbr2lRIeM9+1JV6TyXT0BJf7Q11/QHD6Et0Fc4biZIObCI166MsnG5ldEeW@vger.kernel.org
X-Gm-Message-State: AOJu0YwGadQNNotFHu8wPQnlQmAUfuAvUrGFiie5Zya292pV7Lp2usSi
	D5QpiQ8WjLNxRMlOO0rR9XCh+rd5gy4yncNveRtVSOTTEoDhQdx2tJZ1pyhsXzrbgO/x391ZaC2
	peowWDb/4lh2RVEMNWvwSJ9Kd7n5kXNcMe6/8dl74CUKCY//84Z3uwdl0eWs=
X-Google-Smtp-Source: AGHT+IFwISl6Sgw6HAZs7+QRQAo28c8ntoQFfdZCKcp/Eo2gTblddWhKn/6LZDtQWcY3FE/F3BYYErjqh6tqMVikqfoF3Z4RRLCu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2781:b0:425:8aea:7313 with SMTP id
 e9e14a558f8ab-42d8160c6f3mr71188035ab.18.1759349913698; Wed, 01 Oct 2025
 13:18:33 -0700 (PDT)
Date: Wed, 01 Oct 2025 13:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd8c99.a00a0220.102ee.0061.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in copy_mnt_ns
From: syzbot <syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126f605b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e0f8855a87443d6a2413
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374b858580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15602092580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fb1f87b20e9/disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aebfd0341e80/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11452a5eed6c/bzImage-50c19e20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=1019 which is not allocated.
WARNING: CPU: 1 PID: 6112 at lib/idr.c:592 ida_free+0x280/0x310 lib/idr.c:592
Modules linked in:
CPU: 1 UID: 0 PID: 6112 Comm: syz.4.41 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x280/0x310 lib/idr.c:592
Code: 00 00 00 00 fc ff df 48 8b 5c 24 10 48 8b 7c 24 40 48 89 de e8 71 2c 0c 00 90 48 c7 c7 a0 7b 76 8c 44 89 fe e8 41 11 54 f6 90 <0f> 0b 90 90 eb 34 e8 85 a2 90 f6 49 bd 00 00 00 00 00 fc ff df eb
RSP: 0018:ffffc90003087b60 EFLAGS: 00010246

RAX: d54b8a9e76833a00 RBX: 0000000000000a02 RCX: ffff888026663c80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90003087c60 R08: ffff8880b8924293 R09: 1ffff11017124852
R10: dffffc0000000000 R11: ffffed1017124853 R12: 1ffff92000610f70
R13: dffffc0000000000 R14: ffff88801d6d9000 R15: 00000000000003fb
FS:  000055558bcc4500(0000) GS:ffff888126473000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feaa252acf0 CR3: 000000005ee84000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_mnt_ns+0x197/0x820 fs/namespace.c:4168
 create_new_namespaces+0xd1/0x720 kernel/nsproxy.c:78
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3132
 __do_sys_unshare kernel/fork.c:3203 [inline]
 __se_sys_unshare kernel/fork.c:3201 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feaa258eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd780455e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007feaa27e5fa0 RCX: 00007feaa258eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000002a020400
RBP: 00007ffd78045640 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007feaa27e5fa0 R14: 00007feaa27e5fa0 R15: 0000000000000001
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

