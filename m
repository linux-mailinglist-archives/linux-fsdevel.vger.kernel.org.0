Return-Path: <linux-fsdevel+bounces-31430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB69966E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2A282A85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED718E75A;
	Wed,  9 Oct 2024 10:20:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3018DF9B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469225; cv=none; b=j3KVByXDcF4s8w/t99041mvgJlKM+5m28d7ob4CJ8QkEsW2BK17tBZDqZwFOit7QC7F16+yymtfqt41LlHn8hBLnkxhPBjXajzOFGtdJBk9Xg6WtmrHf9wUaI78yc1iobH1eJcPl90DcQMhPLyUK4OgziFrsAGIEiqq6RvwPB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469225; c=relaxed/simple;
	bh=qK4KQaIt3lrNwLlYXxWRnQeo7+2COMKtaUQGshtOGZg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WNKgNgdOxY4b92ovOI5sLX+yyKO4jFi/69l+j3rZvFqLgi9Z3YPUIkZIHdPZTLXc/AEoBhl/5zHs96Dty+PsAqfm1LzACAZyWymO1duksjrknt7iBqWCn1HNGarVn7x2bxFjLbkjhUoTor622q7d3ziX6G/H8pxfBUTiwE36Po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a342620f50so58361125ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 03:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469223; x=1729074023;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msJj4GiB8/jRjpLDDXAICgBBp9XCST7mD/0ou7XdrLU=;
        b=bYw0lPaHq2MEiJZD4w9abD8PqrVkBXuXK63bRyUSLkevu5taWa9PldPyRhZ2Uvmhwq
         QL8LDaQV1c3nMKbFL1ozjE1bNsfzlrt0AjqBWBUIfsIDGA/9eZyCyCxU1yQqml5PELgu
         jBbzE22M3HaLWH7lUmhCHDaFmQEo7zG3HMc42ngWqo+T/VPM8PP4iI+nM1tjZ+o8cknX
         Cs9JHSfT8iQTTnr92Tc4GH6RKyy+NIsYbhJ3XXiwvS/ouEF+MOt4Wll4y+hq/+NzKfqj
         PN/4HobWjGexb/TqL0FjBzxi/gb2dwo5aYtg5GH9RzQF9tm21wWw09dAIeGxrQQUjX4b
         mnew==
X-Forwarded-Encrypted: i=1; AJvYcCW1xFL7VHRPUXK4AL2AhSKlcjp6WZfPVoa92jEkUDfLbw1Ou9zOqxxppB8y1EZSgAKghdWC6ubi2NwVwWKx@vger.kernel.org
X-Gm-Message-State: AOJu0YySk15vsdgNF6LZ5+wykETJOa3M7qaWaev5UzqUG3kRfVsA8P6B
	jiEiqNSQQytkhDzxMCncip0BbyaEmfsmQRULEplijE0IjqEME1kUcLlZnXSXazmzuQB7+oG8+8z
	3Md5TDYKuzksz/TqDn8Vk6CwSF4hV07N/6rlXmu5VBcXuHk4PVUZ76z8=
X-Google-Smtp-Source: AGHT+IHzuK32eKNDgGIe5IK0Pc7jlPryOsh91ka5RJTr7nA7zaFq5OmjVp1xf3Jbyg2dod17W8Ca6DzvkMidbEzMcsDAFd9Gb9fU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a397d10ce2mr16425715ab.16.1728469223017; Wed, 09 Oct 2024
 03:20:23 -0700 (PDT)
Date: Wed, 09 Oct 2024 03:20:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670658e6.050a0220.22840d.0012.GAE@google.com>
Subject: [syzbot] [kernfs?] INFO: task hung in fdget_pos
From: syzbot <syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110fb307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9775e9a1af839423
dashboard link: https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0a79f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64ef5d6cfda3/disk-fc20a3e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/42c0ee676795/vmlinux-fc20a3e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3072d6383ea/bzImage-fc20a3e5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a8f928c45431/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com

INFO: task syz.2.17:5434 blocked for more than 159 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.17        state:D stack:27424 pid:5434  tgid:5432  ppid:5316   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f993c77dff9
RSP: 002b:00007f993d54e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f993c936058 RCX: 00007f993c77dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f993c7f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f993c936058 R15: 00007fffb8436518
 </TASK>
INFO: task syz.3.18:5439 blocked for more than 167 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.18        state:D stack:27424 pid:5439  tgid:5436  ppid:5317   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1134d7dff9
RSP: 002b:00007f1135adc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f1134f36058 RCX: 00007f1134d7dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f1134df0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1134f36058 R15: 00007ffe6e122188
 </TASK>
INFO: task syz.4.19:5441 blocked for more than 168 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.19        state:D stack:27424 pid:5441  tgid:5438  ppid:5327   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4c9ad7dff9
RSP: 002b:00007f4c9bc43038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000


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

