Return-Path: <linux-fsdevel+bounces-18651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B78BAF0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686961C213E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444702B9C0;
	Fri,  3 May 2024 14:35:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965B79F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746937; cv=none; b=dCj8fDlQh1mNCbTInRgsll2mTy09ujfAoD7TFh639NSj39oV/SRrzK8VENDQPH24EetSZyGjWAV2+/yEIH01v25hfX4QQgXCwKqTbmxsAY3uaj7zTqRvv3qwv0OJgKTTIIY6Wup5FEjFDB/vxjXhKks8eK8Yx27mcE596efixh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746937; c=relaxed/simple;
	bh=jIYHM0VBe1wfaYl5+8QwQz1GG7xLW+t8PT0teQ+g3aw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eOWjkA6gTuFR4YmiGfPW23HcE4yLFsHdc+xJ6h32Euy40vCygyKNdimqVerGhGzClNj/tmW23tc8WwI9Tx6AwxuATPLtQ7BB1FLNzZ8kDJ8uiDMEqq/9zRT46pTnUnFc/dM/Gy8vloa8UXX37qyqOIVd2T+7FWhTHBNfqRnjY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dee81b7e97so324587239f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 07:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746935; x=1715351735;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsSzpfD8lOTtWXQxeFGK18lo4s0V8otbNhT9TpnetXo=;
        b=JsPiBELIR6ctCr1nar11laAoMmdjvNDBr/yDF6Ff0nxT444Z2dCrBrN8govvT0AeRm
         U+FTMMH2AXB+GfIY9zrkGeD0Etw4CZ+0WL61DTBDxmoR7wpanhzAtE7w+axWP4xIQnIL
         dXDD7ZYqzH26v+lL2R8FjmaczwN8xf/RR7oRVyd5BjE9OlJ2u0k6HpHOGiI/lN58Spkc
         9Q5/rYt0PuEAjJu96mVssBFtd8unW9lJnOmudliN3EZAN+lP4X937Xhq6R7chuYFW81C
         E1qPjpYvgLjsJegUGo8FYtC3zJg0PSUaKVEkkAhzr2zS1NrdOBL7uVJnD3gf2lpNdNKF
         j/QA==
X-Forwarded-Encrypted: i=1; AJvYcCXv0F6zmA6fqLiiPzlnFvv2iyB9NlKGeffmTGggv7Jl7JDo8Oj7v8Obj9/vwyiUGU2XlSdBL6lRwtRiqzUIWnGVXVcvqf+6TMpFlQ6hLQ==
X-Gm-Message-State: AOJu0YwnJ8Qnopv7ns1A5SdA7f+rV1frz0hDl6EWoerOWKI8fWSTOr1z
	Ijnsc5xV9nRQdfs/Qz+WDiisUr1iof3yJVIvmCtWR9z5poAR6e1ujOKg8PKUUeHLDcS9Lx60orF
	PtE/wsxoWU6Nv4FUTg1ppOcmd+/HOmDfGUhNA7IGya152IBcKaUCz+gg=
X-Google-Smtp-Source: AGHT+IEhC6sNK8T+GpJrYnzOv8q+FwfHkr3Kj7cjLpEYEANPnm3z/Na6NISm5TYfxM0pY3fkZL+zcigix4lxRAkDgL5EK/tcFC4M
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158f:b0:7de:e182:ddf1 with SMTP id
 e15-20020a056602158f00b007dee182ddf1mr106541iow.0.1714746935721; Fri, 03 May
 2024 07:35:35 -0700 (PDT)
Date: Fri, 03 May 2024 07:35:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbce8506178da1e8@google.com>
Subject: [syzbot] [bcachefs?] WARNING in cleanup_srcu_struct (4)
From: syzbot <syzbot+6cf577c8ed4e23fe436b@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14004498980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf577c8ed4e23fe436b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cf577c8ed4e23fe436b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 32609 at kernel/rcu/srcutree.c:664 cleanup_srcu_struct+0x3d9/0x520 kernel/rcu/srcutree.c:664
Modules linked in:
CPU: 1 PID: 32609 Comm: syz-executor.1 Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:cleanup_srcu_struct+0x3d9/0x520 kernel/rcu/srcutree.c:664
Code: c6 00 44 0e 8b 48 c7 c7 80 42 0e 8b 48 8b 8d 80 01 00 00 48 83 c4 20 5b 5d 41 5c 41 5d 83 e1 03 41 5e 41 5f e9 08 68 fa ff 90 <0f> 0b 90 eb aa 90 0f 0b 90 48 b8 00 00 00 00 00 fc ff df 4c 89 f2
RSP: 0018:ffffc900033cfcb0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 1ffff1100f597531 RSI: ffffffff8158f30a RDI: ffffe8fffed21708
RBP: ffff88807acba800 R08: 0000000000000000 R09: 0000000000000008
R10: ffffffff8f9f4fd7 R11: 0000000000000000 R12: ffff8880ae104240
R13: ffff88807acba980 R14: ffff88807acba988 R15: ffffed1015c20849
FS:  000055556f23f480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b36579198 CR3: 000000002c59c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_fs_btree_iter_exit+0x46e/0x630 fs/bcachefs/btree_iter.c:3279
 __bch2_fs_free fs/bcachefs/super.c:562 [inline]
 bch2_fs_release+0xfb/0x670 fs/bcachefs/super.c:610
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f671907f057
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffcd284548 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f671907f057
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffcd284600
RBP: 00007fffcd284600 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffcd2856c0
R13: 00007f67190c93b9 R14: 00000000001e28e3 R15: 0000000000000003
 </TASK>


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

