Return-Path: <linux-fsdevel+bounces-14284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B387A795
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10F41C21FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F73FEF;
	Wed, 13 Mar 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ba9jDpDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DE15D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333024; cv=none; b=RSGOIMOOTBgHMnqaDJNm5kPDjSwxbKo3mo17SUuGWAVW8JQxMcFHtd25dXTx80n1rhZKGDIxwsZ2EiDL9Bio2qSE1m2judUybbEavYS4LtODn7jeckpEpYi08nv3Vt/cFD78Vf4RVwVMLSa0AylARQGQrqU7V520J3P12iUof88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333024; c=relaxed/simple;
	bh=0hqLpmuGMRDAf+9/djNwRW9FUt0aeX/Yme0YtOAjwy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCihrqMPMtLbSS7fzFtTvkoyFMZ0nAh9oqxP2onfSsVsHJnsdvCX7rHbr+vNvVOgW13qd1ZbewB/jnoDNGFLhyzZmA56Bpy9mM4jGzBbeYF+9WG0lSfrdxIR0UBk8P/Xn7IZIv8XVVaqDbRrIaWXSrPjCOVUEcMzeCKCfnS2X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ba9jDpDT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-568241f40e9so7282070a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710333019; x=1710937819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OIF4Fc4Z0ShBIrufIlVVoKIqH9rvxydvsfVMxQSq6zc=;
        b=ba9jDpDTXFo7eFb0WwNjJgz0itJERz9mMx9Jd4ST0F/DoEmYJbmdlJVT/xaBNoTfFY
         HUPkvtO0/cQ5g4Jmvd8i+xm1Hn+g3eqIL7q4lyiEn33EU4r7y+f/dWIoEk4emEJVHzy8
         x2/7ZhFWyxuuizduMrMjD4S4goXU5hfljHzWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333019; x=1710937819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIF4Fc4Z0ShBIrufIlVVoKIqH9rvxydvsfVMxQSq6zc=;
        b=IdkEshTkO/Sfkmj3nO50XBwJMNgExuDPBaKGlnGaGSuq/sBWe4ywfn0LkbM1eZsUz3
         JyAbRwabKyTjHdM/5ONZlWGvUreL2BlQBq7Jay74nYd9vIfTgVwT85PL9HFSFXAU4gGf
         KDCbuLyte3yenzs0Kani/o0qnBPnpDOAVQDNhtfleevpt36QaL87lH1viXADqQy4AZzH
         c9mZBuwyVvl6xsccBzs1QFmzHQzgtejYmg2IFT2azpcj+C4Crn46tVfqMtyDJB4cDFPj
         HgKW2p1yHobW4aPAUBiVA6PV48f4skg998itpYU1BUJ4q6wmtH0UkerclsIyolNQ0rGu
         k81w==
X-Forwarded-Encrypted: i=1; AJvYcCVYhPIkog15KFVM2O0VfydbSZw+R6QPrBN/5s4YywayGs5TblgkyicU85hROCX3Bnyps+cAwbAGW2yhm+CulOrSk8RjT30mDK9gtSw97g==
X-Gm-Message-State: AOJu0YztBmyTwienDvgvHFG/vEpVl7StdJPHULJG+nWbhr8bCYaWoDzG
	uwTQrCmVxDSHe3Q74D539HkYl2lK/CpzSUSAvC3zH2YwvjEZ7zUZPMaeKRjxRputyysF5R9N34G
	BJ4bHDZmhzXbTvQYkFf1fYzxnBIRe1DEUoMyoc4W5ev2alpTGVBw=
X-Google-Smtp-Source: AGHT+IFmrKjYYCkpy+98jZlu+hgla77QBj+haqGQnyrO+7qWMh1PuKV3gv6mo7TKD7jV8YDR+Dl/0Rm/WBQmlyz1nMM=
X-Received: by 2002:a17:907:8748:b0:a46:2772:de9b with SMTP id
 qo8-20020a170907874800b00a462772de9bmr7068270ejc.22.1710333019111; Wed, 13
 Mar 2024 05:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000074c6de06112cd910@google.com>
In-Reply-To: <00000000000074c6de06112cd910@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Mar 2024 13:30:07 +0100
Message-ID: <CAJfpegumD0gDXpZwy53pPu54ifOfW-tTBLniLHep3sW2Z96MjQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (3)
To: syzbot <syzbot+af9aa785e14a67796a87@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[Cc: Rafael]

On Mon, 12 Feb 2024 at 11:36, syzbot
<syzbot+af9aa785e14a67796a87@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    841c35169323 Linux 6.8-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1215e120180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fbd950b5071b7ea3
> dashboard link: https://syzkaller.appspot.com/bug?extid=af9aa785e14a67796a87
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ef821afd15d3/disk-841c3516.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e41102f18e6e/vmlinux-841c3516.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a17352b259d8/bzImage-841c3516.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+af9aa785e14a67796a87@syzkaller.appspotmail.com
>
> F2FS-fs (loop1): Found nat_bits in checkpoint
> F2FS-fs (loop1): Mounted with checkpoint version = 48b305e5
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-rc4-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.1/640 is trying to acquire lock:
> ffff888072750310 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
>
> but task is already holding lock:
> ffff888023f61c68 (&pipe->mutex/1){+.+.}-{3:3}, at: splice_file_to_pipe+0x2e/0x500 fs/splice.c:1292
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #4 (&pipe->mutex/1){+.+.}-{3:3}:
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
>        do_splice_from fs/splice.c:941 [inline]
>        do_splice+0xd77/0x1880 fs/splice.c:1354
>        __do_splice fs/splice.c:1436 [inline]
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
>        do_syscall_64+0xf9/0x240
>        entry_SYSCALL_64_after_hwframe+0x6f/0x77

plain fs sb_writers --> pipe->mutex

This is just a plain splice from a pipe to a regular file (which can
be on the upper layer of overlayfs).

> -> #3 (sb_writers#4){.+.+}-{0:0}:
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1639 [inline]
>        sb_start_write+0x4d/0x1c0 include/linux/fs.h:1775
>        mnt_want_write+0x3f/0x90 fs/namespace.c:409
>        ovl_fix_origin fs/overlayfs/namei.c:908 [inline]
>        ovl_lookup+0x1394/0x2a60 fs/overlayfs/namei.c:1143
>        __lookup_slow+0x28c/0x3f0 fs/namei.c:1693
>        lookup_slow+0x53/0x70 fs/namei.c:1710
>        walk_component fs/namei.c:2001 [inline]
>        link_path_walk+0x9cd/0xe80 fs/namei.c:2328
>        path_lookupat+0xa9/0x450 fs/namei.c:2481
>        filename_lookup+0x255/0x610 fs/namei.c:2511
>        user_path_at_empty+0x42/0x60 fs/namei.c:2920
>        user_path_at include/linux/namei.h:57 [inline]
>        __do_sys_chdir fs/open.c:556 [inline]
>        __se_sys_chdir+0xbf/0x220 fs/open.c:550
>        do_syscall_64+0xf9/0x240
>        entry_SYSCALL_64_after_hwframe+0x6f/0x77

overlayfs directory i_mutex --> plain fs sb_writers

This is perfectly normal lock ordering for overlayfs: lock the
overlayfs inode, then call mnt_want_write() on the upper filesystem.

> -> #2 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:812 [inline]
>        lookup_slow+0x45/0x70 fs/namei.c:17091
>        walk_component+0x2e1/0x410 fs/namei.c:2001
>        lookup_last fs/namei.c:2458 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2482
>        filename_lookup+0x255/0x610 fs/namei.c:2511
>        kern_path+0x35/0x50 fs/namei.c:2619
>        lookup_bdev+0xc5/0x290 block/bdev.c:1014
>        resume_store+0x1a0/0x710 kernel/power/hibernate.c:1183
>        kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
>        call_write_iter include/linux/fs.h:2085 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0xa81/0xcb0 fs/read_write.c:590
>        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>        do_syscall_64+0xf9/0x240
>        entry_SYSCALL_64_after_hwframe+0x6f/0x77

kernfs of->mutex --> overlayfs directory i_mutex

The device name is written to /sys/power/resume. When performing the
lookup of the name, the inode lock is taken on the directory, which
happens to be on overlayfs.

> -> #1 (&of->mutex){+.+.}-{3:3}:
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
>        seq_read_iter+0x3d0/0xd60 fs/seq_file.c:225
>        call_read_iter include/linux/fs.h:2079 [inline]
>        new_sync_read fs/read_write.c:395 [inline]
>        vfs_read+0x978/0xb70 fs/read_write.c:476
>        ksys_read+0x1a0/0x2c0 fs/read_write.c:619
>        do_syscall_64+0xf9/0x240
>        entry_SYSCALL_64_after_hwframe+0x6f/0x77

seqfile p->lock --> kernfs of->mutex

Reading an attribute.  It could be "/sys/power/resume", but here we
don't know, it's just the same lock class.

> -> #0 (&p->lock){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
>        proc_reg_read_iter+0x1c3/0x290 fs/proc/inode.c:302
>        call_read_iter include/linux/fs.h:2079 [inline]
>        copy_splice_read+0x661/0xb60 fs/splice.c:365
>        do_splice_read fs/splice.c:985 [inline]
>        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
>        __do_sys_sendfile64 fs/read_write.c:1356 [inline]
>        __se_sys_sendfile64+0x100/0x1e0 fs/read_write.c:1348
>        do_syscall_64+0xf9/0x240
>        entry_SYSCALL_64_after_hwframe+0x6f/0x77

pipe->mutex --> seqfile p->lock

This is a sendfile from a seqfile.   Could have been
"/sys/power/resume" as well, AFAICS.

I don't really know  if/how this needs fixing, but that path lookup in
resume_store() looks a bit nasty.

Thanks,
Miklos

>
> other info that might help us debug this:
>
> Chain exists of:
>   &p->lock --> sb_writers#4 --> &pipe->mutex/1
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&pipe->mutex/1);
>                                lock(sb_writers#4);
>                                lock(&pipe->mutex/1);
>   lock(&p->lock);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor.1/640:
>  #0: ffff888023f61c68 (&pipe->mutex/1){+.+.}-{3:3}, at: splice_file_to_pipe+0x2e/0x500 fs/splice.c:1292
>
> stack backtrace:
> CPU: 1 PID: 640 Comm: syz-executor.1 Not tainted 6.8.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>  seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
>  proc_reg_read_iter+0x1c3/0x290 fs/proc/inode.c:302
>  call_read_iter include/linux/fs.h:2079 [inline]
>  copy_splice_read+0x661/0xb60 fs/splice.c:365
>  do_splice_read fs/splice.c:985 [inline]
>  splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>  do_sendfile+0x515/0xdc0 fs/read_write.c:1301
>  __do_sys_sendfile64 fs/read_write.c:1356 [inline]
>  __se_sys_sendfile64+0x100/0x1e0 fs/read_write.c:1348
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f3acde7dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3acec5e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f3acdfac050 RCX: 00007f3acde7dda9
> RDX: 0000000020000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: 00007f3acdeca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f3acdfac050 R15: 00007fff9463d788
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

