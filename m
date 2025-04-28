Return-Path: <linux-fsdevel+bounces-47506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE76A9ED1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48751A812CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9281625F78D;
	Mon, 28 Apr 2025 09:38:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650113D8B1
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833111; cv=none; b=TOdC9CqW+4ciwxwfbR8zHVXF0IfUc4s4rEfv6ZsrMAdYgBVZ3+R8iA/8fp9fdOcARwVKaG0gMthUqZR3f02Nk+3UJV1mxfLgUqtT9h8zwMsJSV53hP4/AXmB+QHJS6aZUgrO/AIf60XmRBRdIrNlPIs/xTDcx4eLdlqIK3Dw0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833111; c=relaxed/simple;
	bh=mn+t/RacBxME/p1WkOJ7gtkz/AVEfXFenCy1kgWUAFc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DSOhr+Bsk67bQtUwzAnHNckbMWjHgLgMOQxa9hlu4X0k9X14mvJPZqPAEpRiowQOFyFCmF9WimulZAmIDkkstmLzY2q3WnA98Fgt1x/hdd4hQF1GxR8zDW/tuAnsSjkSHP9+LPQD62p4ikYVhkNWr0PkjKjhhX90Z4xm9rnk/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86186c58c41so445544439f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 02:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833108; x=1746437908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMTnP6AIsjjPpmrQ+G1mFdxyIFOKyDG0YgiEfdQ8gfI=;
        b=ShQDrgx9ZzcPgfmoIOvDZSFaBrHkoGw8WGNfOpWfrQSiTUWQWIAkbq/2ScLkAVUaG8
         6RMnn7rU52IEvF5hdMaTrYd7P4L2+T9mS30Q0zc4PfyoiwDBQTb1HF5kOot0tDfnF1Vm
         rMAfIVfAsErvt9ghEEYwyHV4IV5IlXG9vBkS6PCZxJKeI9GtUdHsouF9XgSVoh/6/iwG
         Ff65TvSeQYEiW3fyo2+/kl+bN1AG1Zd2ohpbDKZgkglHMwCSHvGc3dqq/h/kvQE8jbU0
         eOijxobwSFo/MZ8B9bCPmIj5OTtljmUQB4cWFb+qkoNwVBPQO2dpftEG5OblLwnAWk2v
         cV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0VMzeydpLLlqevvfjQ6/EuXU/MlA5EyPG29y2rBxUvEA7TBxesMlWu1yNY4bRABx84Vec3SiZhaKc5rK7@vger.kernel.org
X-Gm-Message-State: AOJu0YyaX2LTsCEDuEwmd4PysoOkBpmiXNMPPDbwwt2mwmPgBmPrmIQq
	6ev9tIBuWlg/WfeAlWkeWTOvVrPLUFF/wHcgQjepExKEh6y/Zuou45q5wNv41L3gp5kmV5jBV/n
	vf8dnQpfgeYdUzbz+ymLkfPNkqSrNaHPhajJoUiXKQr6lvPKXnZSKWKo=
X-Google-Smtp-Source: AGHT+IHo5S0y/4Gw8E/UVyBmpcTYAQMN+ue1sq5sfpoafxKP9FdmUl50C1Ato7sVRi0TAzi1wWePzYbTqkmH+r5xWqv5r2vhuLP2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340e:b0:85e:2e8b:602 with SMTP id
 ca18e2360f4ac-86467a4dfa5mr711592639f.2.1745833108651; Mon, 28 Apr 2025
 02:38:28 -0700 (PDT)
Date: Mon, 28 Apr 2025 02:38:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680f4c94.050a0220.2b69d1.035b.GAE@google.com>
Subject: [syzbot] [io-uring] KMSAN: uninit-value in putname
From: syzbot <syzbot+9b12063ba8beec94f5b8@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a33b5a08cbbd Merge tag 'sched_ext-for-6.15-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f77fac580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca45111586bf9a6
dashboard link: https://syzkaller.appspot.com/bug?extid=9b12063ba8beec94f5b8
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e23fd3b01d5c/disk-a33b5a08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d39e4ee184b3/vmlinux-a33b5a08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4117549249f/bzImage-a33b5a08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b12063ba8beec94f5b8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in putname+0x8f/0x1d0 fs/namei.c:285
 putname+0x8f/0x1d0 fs/namei.c:285
 io_statx_cleanup+0x57/0x80 io_uring/statx.c:70
 io_clean_op+0x154/0x690 io_uring/io_uring.c:411
 io_free_batch_list io_uring/io_uring.c:1424 [inline]
 __io_submit_flush_completions+0x1b00/0x1cd0 io_uring/io_uring.c:1465
 io_submit_flush_completions io_uring/io_uring.h:165 [inline]
 io_fallback_req_func+0x28e/0x4e0 io_uring/io_uring.c:260
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xc1d/0x1e80 kernel/workqueue.c:3319
 worker_thread+0xea3/0x1500 kernel/workqueue.c:3400
 kthread+0x6ce/0xf10 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4167 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_noprof+0x926/0xe20 mm/slub.c:4217
 getname_flags+0x102/0xa20 fs/namei.c:146
 getname_uflags+0x3a/0x50 fs/namei.c:222
 io_statx_prep+0x26f/0x430 io_uring/statx.c:39
 io_init_req io_uring/io_uring.c:2140 [inline]
 io_submit_sqe io_uring/io_uring.c:2187 [inline]
 io_submit_sqes+0x10c1/0x2f50 io_uring/io_uring.c:2342
 __do_sys_io_uring_enter io_uring/io_uring.c:3402 [inline]
 __se_sys_io_uring_enter+0x410/0x4db0 io_uring/io_uring.c:3336
 __x64_sys_io_uring_enter+0x11f/0x1a0 io_uring/io_uring.c:3336
 x64_sys_call+0x2dbb/0x3c80 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 10442 Comm: kworker/0:3 Tainted: G        W           6.15.0-rc3-syzkaller-00008-ga33b5a08cbbd #0 PREEMPT(undef) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events io_fallback_req_func
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

