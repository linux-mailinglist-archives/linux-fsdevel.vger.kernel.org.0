Return-Path: <linux-fsdevel+bounces-16450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A389DD6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC99B23B00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8E85652;
	Tue,  9 Apr 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="W6HWQ7ZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098E12F5A3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674687; cv=none; b=Pi5SYGomK0HpOyA/6KOg+DNfoGnrJwmpr6Ul5vbV0tvgjUKovWRdwDl5bTwjDI3nOor+O/bEkbIUtSEd+7QfNZjV5rOl7EaWOijFuvBlujeMjUBeuOh8AC0X1yH6KR5A6sFBRpt0luB2nCrLVXznFljqYzWRYEfRC666iahwXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674687; c=relaxed/simple;
	bh=dl0LmiRM57HxUberHzme3n8QEAA+YThYtslFTlwTygQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2S36XdGAjw0j2p8bnE7xcDZdWS2BcyQY7Z+RdOgRfBDEq0X14AhOnWxqpZlAXBVahdZJB5e68gJLtZcDgyd5GlW68+12qVqp/F+b2ZdY+quMPfhjhfGh117daDCzNcHrzU8Rawyp5om/Xmk2WRQCdKdUOogZwENNi8pWTSqyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=W6HWQ7ZN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso7984349a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712674684; x=1713279484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YW0DLDmEm9uNtI52bYp3RB2ImO6QOJ3pl+va1BwBzrQ=;
        b=W6HWQ7ZNccxHqSVQvBr6yuef52Csa9WyE8jqTR1J1REX/gy6cy9F60tPGedrD1xDtP
         THzbZXMixL/ad24plxzfFq7EU0CiY6wj4rVB+bF3rnp4ggkXt/m4pMmR4soDM/vCbYRa
         fEgcDd6xqtYFarjo0E/hZAudzpl/plD352CvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674684; x=1713279484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW0DLDmEm9uNtI52bYp3RB2ImO6QOJ3pl+va1BwBzrQ=;
        b=PbKMdm1KpBkoKVJ9xUHb8YHda2Tr11bANYHjgmtUza0UVRCrhfnQORDtn3TGkuFVz7
         /A3kRSjfL4Ai3AKrEJNFJOPv0b2Tk/b1dLvwjCxW4wGV9+tiliQfkas1dwqTfQkacQiL
         GlqkHHuUKvTIP/KlFxOXE7TEf9zWI+6rxWAuhwvfx703ezZZVfwfbyz59o+8BPySZX+e
         +RDMyMlNnxMhB32BUzAZaTfQKnUuXoufKIrO2gvd7WFeEc1Q1h6K3J9xIxdEdzA7MVqp
         yF4NMT779u3+259Gs3Orx/JxApGqttoHT8F7KV6Sjm/WonpV3yRsLL7NNDbDMzpIUxnw
         GDgw==
X-Forwarded-Encrypted: i=1; AJvYcCUYMHIdATQp4NYYg2VM3BsLu+Jen3YptfyJndKSTcp7ezzLTFmqDbH+ge+R4PKTe0lYOmMhs7zXyL1In5E+XTjlkVKwsKeeB6HmlfCPNg==
X-Gm-Message-State: AOJu0Yy0/pYDOCAQVF50MEUkWqOdWbLffkhH8eB8L72omZsT7uztWcL7
	ClVna4vcSDmgCz6Lac+3dKJ4uBbZQ9cxyleen1toH3W8P7xlnC2Uiz6krMlSKmTV3QxvqhSxW2U
	K9ttK+2TXgoEnPIIHvqtThlJ1qbn6MOc8ambU0w==
X-Google-Smtp-Source: AGHT+IHFiIPOHxqrMjVufM6QXBOhuAfE36e/H8FaEbTDUe7+yQjy2Ne6XXy+lMNyphhF6J5e598+HBEa92gQr3tP3cU=
X-Received: by 2002:a17:906:f584:b0:a51:dd18:bd21 with SMTP id
 cm4-20020a170906f58400b00a51dd18bd21mr4548590ejd.16.1712674683807; Tue, 09
 Apr 2024 07:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d7de3c0615946534@google.com>
In-Reply-To: <000000000000d7de3c0615946534@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Apr 2024 16:57:52 +0200
Message-ID: <CAJfpegu9D9u-15ptf+dvsBJGJLYqs9OoC1kszSwk2OK49JTKTw@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in lookup_one_unlocked
To: syzbot <syzbot+ac3c5eb32b9d409dc11d@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

And this one too.

#syz dup: possible deadlock in kernfs_fop_llseek



On Mon, 8 Apr 2024 at 13:49, syzbot
<syzbot+ac3c5eb32b9d409dc11d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17adb6d3180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c5eb32b9d409dc11d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ac3c5eb32b9d409dc11d@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> syz-executor.1/9023 is trying to acquire lock:
> ffff88805d610740 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
> ffff88805d610740 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_slow fs/namei.c:1708 [inline]
> ffff88805d610740 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_one_unlocked+0x197/0x290 fs/namei.c:2817
>
> but task is already holding lock:
> ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
> ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1708
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #5 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:803 [inline]
>        lookup_slow+0x45/0x70 fs/namei.c:1708
>        walk_component+0x2e1/0x410 fs/namei.c:2004
>        lookup_last fs/namei.c:2461 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2485
>        filename_lookup+0x256/0x610 fs/namei.c:2514
>        kern_path+0x35/0x50 fs/namei.c:2622
>        lookup_bdev+0xc5/0x290 block/bdev.c:1072
>        resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>        kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
>        call_write_iter include/linux/fs.h:2108 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0xa84/0xcb0 fs/read_write.c:590
>        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #4 (&of->mutex){+.+.}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
>        seq_read_iter+0x3d0/0xd60 fs/seq_file.c:225
>        call_read_iter include/linux/fs.h:2102 [inline]
>        new_sync_read fs/read_write.c:395 [inline]
>        vfs_read+0x97b/0xb70 fs/read_write.c:476
>        ksys_read+0x1a0/0x2c0 fs/read_write.c:619
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #3 (&p->lock){+.+.}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
>        call_read_iter include/linux/fs.h:2102 [inline]
>        copy_splice_read+0x662/0xb60 fs/splice.c:365
>        do_splice_read fs/splice.c:985 [inline]
>        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
>        __do_sys_sendfile64 fs/read_write.c:1362 [inline]
>        __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #2 (&pipe->mutex){+.+.}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
>        do_splice_from fs/splice.c:941 [inline]
>        do_splice+0xd77/0x1880 fs/splice.c:1354
>        __do_splice fs/splice.c:1436 [inline]
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #1 (sb_writers#4){.+.+}-{0:0}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1662 [inline]
>        sb_start_write+0x4d/0x1c0 include/linux/fs.h:1798
>        mnt_want_write+0x3f/0x90 fs/namespace.c:409
>        ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
>        lookup_open fs/namei.c:3497 [inline]
>        open_last_lookups fs/namei.c:3566 [inline]
>        path_openat+0x1425/0x3240 fs/namei.c:3796
>        do_filp_open+0x235/0x490 fs/namei.c:3826
>        do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
>        do_sys_open fs/open.c:1421 [inline]
>        __do_sys_open fs/open.c:1429 [inline]
>        __se_sys_open fs/open.c:1425 [inline]
>        __x64_sys_open+0x225/0x270 fs/open.c:1425
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:803 [inline]
>        lookup_slow fs/namei.c:1708 [inline]
>        lookup_one_unlocked+0x197/0x290 fs/namei.c:2817
>        ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
>        ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
>        ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
>        ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
>        __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
>        lookup_slow+0x53/0x70 fs/namei.c:1709
>        walk_component+0x2e1/0x410 fs/namei.c:2004
>        lookup_last fs/namei.c:2461 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2485
>        filename_lookup+0x256/0x610 fs/namei.c:2514
>        kern_path+0x35/0x50 fs/namei.c:2622
>        lookup_bdev+0xc5/0x290 block/bdev.c:1072
>        resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>        kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
>        call_write_iter include/linux/fs.h:2108 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0xa84/0xcb0 fs/read_write.c:590
>        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> other info that might help us debug this:
>
> Chain exists of:
>   &ovl_i_mutex_dir_key[depth] --> &of->mutex --> &ovl_i_mutex_dir_key[depth]#3
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   rlock(&ovl_i_mutex_dir_key[depth]#3);
>                                lock(&of->mutex);
>                                lock(&ovl_i_mutex_dir_key[depth]#3);
>   rlock(&ovl_i_mutex_dir_key[depth]);
>
>  *** DEADLOCK ***
>
> 5 locks held by syz-executor.1/9023:
>  #0: ffff888059ebf248 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x259/0x320 fs/file.c:1191
>  #1: ffff88802f972420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2853 [inline]
>  #1: ffff88802f972420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x233/0xcb0 fs/read_write.c:586
>  #2: ffff88801edfd088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
>  #3: ffff888019281918 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
>  #4: ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
>  #4: ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1708
>
> stack backtrace:
> CPU: 1 PID: 9023 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>  down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>  inode_lock_shared include/linux/fs.h:803 [inline]
>  lookup_slow fs/namei.c:1708 [inline]
>  lookup_one_unlocked+0x197/0x290 fs/namei.c:2817
>  ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
>  ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
>  ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
>  ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
>  __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
>  lookup_slow+0x53/0x70 fs/namei.c:1709
>  walk_component+0x2e1/0x410 fs/namei.c:2004
>  lookup_last fs/namei.c:2461 [inline]
>  path_lookupat+0x16f/0x450 fs/namei.c:2485
>  filename_lookup+0x256/0x610 fs/namei.c:2514
>  kern_path+0x35/0x50 fs/namei.c:2622
>  lookup_bdev+0xc5/0x290 block/bdev.c:1072
>  resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>  kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2108 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa84/0xcb0 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f389687de69
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f38963ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f38969abf80 RCX: 00007f389687de69
> RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000006
> RBP: 00007f38968ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f38969abf80 R15: 00007ffca27d9338
>  </TASK>
> PM: Image not found (code -6)
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
>

