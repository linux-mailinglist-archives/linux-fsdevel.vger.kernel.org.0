Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF537245FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 16:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbjFFOa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbjFFOa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:30:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E54CE70;
        Tue,  6 Jun 2023 07:30:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E2C0219CF;
        Tue,  6 Jun 2023 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686061820;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q69f4icfkOHrbAxFFRNRY6kAZj6ABf80i3vTyuJnkR0=;
        b=akejJ6cNzIhIozryk9dClUe9WjihrRXXXINQzJ6/rnDO0tAmE0EfzlPtFrfT8bR99REvI3
        PY1N85qn7sx2ZsQFKbnxKZ5ivfHDMbUssf/h/IiFxUPJB3uQI9KxNonhYHi9XTcOZzIh16
        gL6zxsLo5WUmic25UO78twuekTGyeQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686061820;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q69f4icfkOHrbAxFFRNRY6kAZj6ABf80i3vTyuJnkR0=;
        b=91m1GEoKjNSxTlKIh3KIHX9xvdTAiEAULUDalM33VQdRUv7QyojYwvIJXl92VYI2fNm1w6
        gOyhy1h4o00/n/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 321DB13519;
        Tue,  6 Jun 2023 14:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q4boCvxCf2QdfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 14:30:20 +0000
Date:   Tue, 6 Jun 2023 16:24:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] INFO: task hung in btrfs_sync_file (2)
Message-ID: <20230606142405.GI25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000086021605fd1b484c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000086021605fd1b484c@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_FAKE_RF_SHORT,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:15:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cc8ced280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=a694851c6ab28cbcfb9c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e7c35280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ea7ffe280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/8a4c583d7fb5/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
> 
> INFO: task syz-executor274:6164 blocked for more than 143 seconds.

143+ seconds in a lock might be a lot, but this is file sync and the
the system could be overloaded.

>       Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor274 state:D stack:24920 pid:6164  ppid:5041   flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5343 [inline]
>  __schedule+0x1d15/0x5790 kernel/sched/core.c:6669
>  schedule+0xde/0x1a0 kernel/sched/core.c:6745
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6804
>  rwsem_down_write_slowpath+0x3e2/0x1220 kernel/locking/rwsem.c:1178
>  __down_write_common kernel/locking/rwsem.c:1306 [inline]
>  __down_write kernel/locking/rwsem.c:1315 [inline]
>  down_write+0x1d2/0x200 kernel/locking/rwsem.c:1574
>  inode_lock include/linux/fs.h:775 [inline]

Inode lock

>  btrfs_inode_lock+0x7e/0xf0 fs/btrfs/inode.c:377
>  btrfs_sync_file+0x455/0x12d0 fs/btrfs/file.c:1808
>  vfs_fsync_range+0x13e/0x230 fs/sync.c:188
>  generic_write_sync include/linux/fs.h:2469 [inline]
>  btrfs_do_write_iter+0x520/0x1210 fs/btrfs/file.c:1680
>  call_write_iter include/linux/fs.h:1868 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x945/0xd50 fs/read_write.c:584
>  ksys_write+0x12b/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0de39026c9
> RSP: 002b:00007f0de38a5208 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f0de3984788 RCX: 00007f0de39026c9
> RDX: 0000000000000128 RSI: 0000000020004400 RDI: 0000000000000006
> RBP: 00007f0de3984780 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0de398478c
> R13: 00007fffb0c5635f R14: 00007f0de38a5300 R15: 0000000000022000
>  </TASK>
> INFO: task syz-executor274:6181 blocked for more than 143 seconds.
>       Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor274 state:D stack:26416 pid:6181  ppid:5041   flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5343 [inline]
>  __schedule+0x1d15/0x5790 kernel/sched/core.c:6669
>  schedule+0xde/0x1a0 kernel/sched/core.c:6745
>  wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
>  wait_extent_bit+0x56e/0x670 fs/btrfs/extent-io-tree.c:751
>  lock_extent+0x120/0x1c0 fs/btrfs/extent-io-tree.c:1742
>  btrfs_page_mkwrite+0x652/0x11a0 fs/btrfs/inode.c:8336
>  do_page_mkwrite+0x1a1/0x690 mm/memory.c:2934
>  wp_page_shared mm/memory.c:3283 [inline]
>  do_wp_page+0x356/0x34e0 mm/memory.c:3365
>  handle_pte_fault mm/memory.c:4967 [inline]
>  __handle_mm_fault+0x1635/0x4170 mm/memory.c:5092
>  handle_mm_fault+0x2af/0x9f0 mm/memory.c:5246
>  do_user_addr_fault+0x51a/0x1210 arch/x86/mm/fault.c:1440
>  handle_page_fault arch/x86/mm/fault.c:1534 [inline]
>  exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0010:rep_movs_alternative+0x33/0xb0 arch/x86/lib/copy_user_64.S:56
> Code: 46 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
> RSP: 0018:ffffc9000becf728 EFLAGS: 00050206
> RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000000038
> RDX: fffff520017d9efb RSI: ffffc9000becf7a0 RDI: 0000000020000120
> RBP: 0000000020000120 R08: 0000000000000000 R09: fffff520017d9efa
> R10: ffffc9000becf7d7 R11: 0000000000000001 R12: ffffc9000becf7a0
> R13: 0000000020000158 R14: 0000000000000000 R15: ffffc9000becf7a0
>  copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
>  raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
>  _copy_to_user lib/usercopy.c:41 [inline]
>  _copy_to_user+0xab/0xc0 lib/usercopy.c:34
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  fiemap_fill_next_extent+0x217/0x370 fs/ioctl.c:144
>  emit_fiemap_extent+0x18e/0x380 fs/btrfs/extent_io.c:2616
>  fiemap_process_hole+0x516/0x610 fs/btrfs/extent_io.c:2874

and extent enumeration from FIEMAP, this would qualify as a stress on
the inode

>  extent_fiemap+0x123b/0x1950 fs/btrfs/extent_io.c:3089
>  btrfs_fiemap+0xe9/0x170 fs/btrfs/inode.c:8008
>  ioctl_fiemap fs/ioctl.c:219 [inline]
>  do_vfs_ioctl+0x466/0x1670 fs/ioctl.c:810
>  __do_sys_ioctl fs/ioctl.c:868 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x10c/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0de39026c9
> RSP: 002b:00007f0ddc484208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f0de3984798 RCX: 00007f0de39026c9
> RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
> RBP: 00007f0de3984790 R08: 00007f0ddc484700 R09: 0000000000000000
> R10: 00007f0ddc484700 R11: 0000000000000246 R12: 00007f0de398479c
> R13: 00007fffb0c5635f R14: 00007f0ddc484300 R15: 0000000000022000
>  </TASK>
> 
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title

I was not able to decipher from the reproducer what exactly is the
workload, there are some writes, there's one ioctl called by number
(syscall(__NR_ioctl, r[0], 0xc020660b, 0x20000100ul)), no sync or fsync
so they're implicit.

This seems to be an 'invalid' report, the system is overloaded. There
are several other reports stuck in fsync() with the same time out. IIRC
the default is 300 so perhaps the syzkaller can be updated not to
trigger too early.
