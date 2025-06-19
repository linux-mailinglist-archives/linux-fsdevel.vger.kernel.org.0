Return-Path: <linux-fsdevel+bounces-52159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E054CADFFA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE43A45B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD17D263F4E;
	Thu, 19 Jun 2025 08:20:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10832165E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321232; cv=none; b=Xj2FlkDvD515tYD4/fJMqsotvXA2Xu+Ot/sbegZg39sVKBQyGeisyOFg7XcMCjaDhoo7SHLEoQljmaNhpTBQj/Kub2/0//93prOEU6dG/gfZQ2S8iPau3UaLFZqAY1kQBofm55pNbi29HFN5hgF5OjzLmVjBqsqIyoyKj6H1x5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321232; c=relaxed/simple;
	bh=261sDo1GyqSpoit5EDehZ8hKlPpykt7N3iW2YK8Nh/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GdddSk+SLl6MEI1FpiH8Sk0irTNnYCYh5Oc+TSEwFwINzM4f1jE/vPcBOKGvqdHUwAidqAOVUvkrBypkb1tZd/ttn0Qrs7U+ahPC3pnwXtFLg097AYggFCMj7kKB2F0lKsBKK7AhWJLiy5rbfy7qACLJGA7l6AsKqbw23G+eP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd051e8e5so4948235ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 01:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321230; x=1750926030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5VND3YHAKVVef6wrkt7GOTMwT6AsDTRdwEZamFb2fU=;
        b=Wf6uSvVXt6k7sAIZjPiKbeWWi87A+jogEY+R2pz1Op16hwRqJwkEacImjQsrTutAiF
         WPnPJgTBxehCKNLjCk825LRoDsYkbuHN3NYykdUG5n6xwxz1Yon2ksTBbimR/dwvIlrW
         vI3Dkcz2nu2OAfwYphJpLCNhcrbIbqloqrId0zhJ77E4VMgLPUMLCNgV71ia+LX2XhVP
         wb+x5cczXdx+F3efvkPzkGGWckUMepMEDvXtfUycBzl+Ww89XzkFGNfemuswmws9kPHK
         GN+cEB1LkE2cHbaj7rDMBx/0jjJyuDn3BJNLr0TkSnXGQlhx1+TIdep8MI3jpx3BljSf
         lBNg==
X-Forwarded-Encrypted: i=1; AJvYcCVJRXmULS6DuCoARY4bUJxnW6kiisxHNyhoFZcVxO4+qvq7MJpgBYwdy8ZR8LnzsYprrmQbthd2GpcLe1W7@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAjShbsP/EVNt4Tc+ZntGOehmSH0Vqs0qrR9glMgYZTBKY68H
	RtwDIQW/aIbLlSgx6S359KClex9jzP/NnXrfHGhM6cBuR+D/oWU7Z9u3Eopyj8OqrIiSfYtsjPg
	uqo9qEIu7ADDb6rLxZu7lieqM+ZLKS1+roiki93iLwTVoZfPpKViqqYCMkzo=
X-Google-Smtp-Source: AGHT+IE9SYHZ0M03/4CZ4HxHMP2XlHQlC8tOVtlczY5YsdpXnMgZg8qqQz9KderSIsmW89xMPbcaTYwENsnTsmyMuwq5Q5x865aH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:3dd:b655:2d6a with SMTP id
 e9e14a558f8ab-3de07cff8camr235705765ab.7.1750321229797; Thu, 19 Jun 2025
 01:20:29 -0700 (PDT)
Date: Thu, 19 Jun 2025 01:20:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6853c84d.050a0220.216029.01ca.GAE@google.com>
Subject: [syzbot] [fs?] KMSAN: uninit-value in fsnotify_connector_destroy_workfn
From: syzbot <syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8c6bc74c7f89 Merge tag 'v6.16-rc1-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c9bd70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61539536677af51c
dashboard link: https://syzkaller.appspot.com/bug?extid=aaeb1646d01d0358cb2a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa187645a1d3/disk-8c6bc74c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c5f24a0cd2d/vmlinux-8c6bc74c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2cd7c92032f/bzImage-8c6bc74c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fsnotify_connector_destroy_workfn+0x108/0x160 fs/notify/mark.c:323
 fsnotify_connector_destroy_workfn+0x108/0x160 fs/notify/mark.c:323
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3321
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3402
 kthread+0xd5c/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e0/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4204
 fsnotify_attach_connector_to_object fs/notify/mark.c:663 [inline]
 fsnotify_add_mark_list fs/notify/mark.c:746 [inline]
 fsnotify_add_mark_locked+0x862/0x1a90 fs/notify/mark.c:821
 fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:888 [inline]
 inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
 inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
 __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:781 [inline]
 __se_sys_inotify_add_watch+0x129c/0x1760 fs/notify/inotify/inotify_user.c:729
 __x64_sys_inotify_add_watch+0x97/0xe0 fs/notify/inotify/inotify_user.c:729
 x64_sys_call+0x330f/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 4808 Comm: kworker/u8:25 Tainted: G      D W           6.16.0-rc1-syzkaller-00236-g8c6bc74c7f89 #0 PREEMPT(undef) 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound fsnotify_connector_destroy_workfn

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

