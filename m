Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A75C7930CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbjIEVOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbjIEVOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:14:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE9C2
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:14:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c576d35feso2485059b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693948452; x=1694553252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NM1oGLUGoZvrP0ltmrgN2DF2+yVif4aBJXoikLwQQGk=;
        b=TjTL8Z4Eq5prJjW9ARRGS9ZGR5JDUYDp47NMteTxhcCzYohp+62DQeeMQZN5XHBAI9
         eMZyRpksBg0MvzAX9zuntaFiDx1C+1c3IcVMydlY7lcW08kAn0QbjiXb3R8F5BzVZ/TD
         lUtY2XmBuUmKEy2wGq0UO/DWSTvLa1BvHKrv6lohkcMCoFnIkYJwGIuLAYUEz/EtzBL4
         W0nF04lQT5WxXqB/2laU1MIt5bRLEFrKRDvISHwKvVVkKJbomEIeaTVhKcHIZ1fEmUOg
         dHQTnqVj5FtE9rdml1K2DzI7kQYNBHS1stnrVI8LaJtfHj5R9JiBAsgaKdszUvAhns57
         dZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693948452; x=1694553252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM1oGLUGoZvrP0ltmrgN2DF2+yVif4aBJXoikLwQQGk=;
        b=MhmGEGeYFP/gyVdTmzAgLKsVz8AYy+X4KmxkLbw/cEilZSFcw2dm87vBjVjUlE6Pof
         5cJjmTIedWDtZxtJ0OulzJmEbiuV0u4buvNnWY7a1H/Pz93ZVN1W6eQh/+K10HPWo6Vy
         btWLvwJAAMaUIp2QZzOFUhvRAUI9RN9V4Saa5lE0u5S+lrsVLhsL3EzroY4512mqmO0U
         xBRG6/8sb4lqvZvPaFNGEI95HXB12L9Ew3tNHWJhZDCnteXR40sgbYb4cdSECJDpD/S7
         T19Oe8+K2MjdAxr3pTlTCZLqInN73Bg4BpukF5kI8r34INufSemRDI/zORTc5I0jEoWt
         rhRQ==
X-Gm-Message-State: AOJu0YxKYuZ3QNaQqEty4cyWGg3ETsp+zswAFuwFuQMYSGN0YL96vvIB
        MYnp5uU+5ROBwitD7S62iNC56g==
X-Google-Smtp-Source: AGHT+IHgcDK9AMFCY9plrptEgGdXHnpLWqSP3cFReq9zYGqZQV+UCv0snLi8fOx9Hkdtp0O4y21XGQ==
X-Received: by 2002:a05:6a00:2291:b0:68a:49bc:e091 with SMTP id f17-20020a056a00229100b0068a49bce091mr17900230pfe.2.1693948452289;
        Tue, 05 Sep 2023 14:14:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id p29-20020a056a0026dd00b00682c864f35bsm18426pfw.140.2023.09.05.14.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:14:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qddN9-00BJEn-1v;
        Wed, 06 Sep 2023 07:14:07 +1000
Date:   Wed, 6 Sep 2023 07:14:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org,
        hch@lst.de
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
Message-ID: <ZPeaH+K75a0nIyBk@dread.disaster.area>
References: <000000000000e534bb0604959011@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e534bb0604959011@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc linux-block, Christoph]

Another iomap-blockdev related issue.

#syz set subsystems: block

syzbot developers: Please review how you are classifying subsystems,
this is the third false XFS classification in 24 hours.

-Dave.

On Mon, Sep 04, 2023 at 10:04:47PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1485e78fa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fcf738680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ee486d884228/disk-92901222.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b5187db0b1d1/vmlinux-92901222.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/82c4e42d693e/bzImage-92901222.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
> 
> INFO: task syz-executor.5:10017 blocked for more than 143 seconds.
>       Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.5  state:D stack:27624 pid:10017 ppid:5071   flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5382 [inline]
>  __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
>  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
>  io_schedule+0xbe/0x130 kernel/sched/core.c:9026
>  folio_wait_bit_common+0x3d2/0x9b0 mm/filemap.c:1304
>  folio_lock include/linux/pagemap.h:1042 [inline]
>  clean_bdev_aliases+0x56b/0x610 fs/buffer.c:1725
>  clean_bdev_bh_alias include/linux/buffer_head.h:219 [inline]
>  __block_write_begin_int+0x8d6/0x1470 fs/buffer.c:2115
>  iomap_write_begin+0x5be/0x17b0 fs/iomap/buffered-io.c:772
>  iomap_write_iter fs/iomap/buffered-io.c:907 [inline]
>  iomap_file_buffered_write+0x3d6/0x9a0 fs/iomap/buffered-io.c:968
>  blkdev_buffered_write block/fops.c:634 [inline]
>  blkdev_write_iter+0x572/0xca0 block/fops.c:688
>  call_write_iter include/linux/fs.h:1985 [inline]
>  do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
>  do_iter_write+0x17f/0x830 fs/read_write.c:860
>  vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
>  iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
>  do_splice_from fs/splice.c:933 [inline]
>  direct_splice_actor+0x118/0x180 fs/splice.c:1142
>  splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
>  do_splice_direct+0x1af/0x280 fs/splice.c:1194
>  do_sendfile+0xb88/0x1390 fs/read_write.c:1254
>  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1308 [inline]
>  __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdb8ca7cae9
> RSP: 002b:00007ffcd642da18 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fdb8cb9bf80 RCX: 00007fdb8ca7cae9
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
> RBP: 00007fdb8cac847a R08: 0000000000000000 R09: 0000000000000000
> R10: 0100000000000042 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000be7 R14: 00007fdb8cb9bf80 R15: 00007fdb8cb9bf80
>  </TASK>
> INFO: lockdep is turned off.
> NMI backtrace for cpu 1
> CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xfac/0x1230 kernel/hung_task.c:379
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 17 Comm: rcu_preempt Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:load_balance+0x10a/0x3130 kernel/sched/fair.c:10983
> Code: 4a 8d 3c f5 40 aa 5c 8c 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 2f 2e 00 00 31 c0 b9 0c 00 00 00 <4e> 8b 1c f5 40 aa 5c 8c 4c 89 94 24 f8 00 00 00 48 8d bc 24 00 01
> RSP: 0018:ffffc900001676c8 EFLAGS: 00000046
> RAX: 0000000000000000 RBX: ffff8880b983c700 RCX: 000000000000000c
> RDX: dffffc0000000000 RSI: ffffffff8ae90360 RDI: ffffffff8c5caa40
> RBP: ffffc90000167898 R08: ffffc90000167960 R09: 0000000000000000
> R10: ffff88801525ac00 R11: 0000000000000000 R12: 00000000000287d8
> R13: ffffc90000167960 R14: 0000000000000000 R15: 0000000100004d48
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000240 CR3: 000000000c976000 CR4: 0000000000350ef0
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  newidle_balance+0x710/0x1210 kernel/sched/fair.c:12059
>  pick_next_task_fair+0x87/0x1200 kernel/sched/fair.c:8234
>  __pick_next_task kernel/sched/core.c:6004 [inline]
>  pick_next_task kernel/sched/core.c:6079 [inline]
>  __schedule+0x493/0x59f0 kernel/sched/core.c:6659
>  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
>  schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
>  rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1613
>  rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1812
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
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
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

-- 
Dave Chinner
david@fromorbit.com
