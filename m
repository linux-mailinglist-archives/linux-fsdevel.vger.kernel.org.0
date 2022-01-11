Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7748AF2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiAKOKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 09:10:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41910 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiAKOKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:10:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38620B81A88;
        Tue, 11 Jan 2022 14:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30493C36AE3;
        Tue, 11 Jan 2022 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641910241;
        bh=Y0n/7+btWL1bZf6IVO9LjwDjdj0Cfs2HnkLx1qw+8WY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YRZ1Yj2X9TRu+U1lOS950zGkT5+2xaHuBDrLsqIJ8SlvQD/JU8FW/9DMEu4Mk/nIs
         EjCNHpFZtnZCFBlyufiZiqNgoZcKyFNKX3NcsL4SJHcNFLagNwjtF4VT4KvUERK4dM
         dwpDF99afJLOn4T1zf2FfZrPemEc+28REHN+VUhJoyg1xLtZfAoOFGUcy4dYQKr5u/
         kgn0oTIMJFdyrhGDoEIfYPnrVnhoUsbnMrOdslXdetd+kUK3FbSCM6EnBISx8an581
         GCD2ETnc647h8XLiq1uJshZ7Lro3sQDOOVnPuZ8LW2zm6jOf1qnnJSIp/lXIdhJYTs
         dyH/70Ctt35Fw==
Date:   Tue, 11 Jan 2022 15:10:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Kaia Yadira <hypericumperforatum4444@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     jgg@ziepe.ca, rcampbell@nvidia.com, aarcange@redhat.com,
        david@redhat.com, apopple@nvidia.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, sunhao.th@gmail.com,
        Aleksandr Nogikh <nogikh@google.com>,
        cruise k <cruise4k@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: KCSAN: data-race in task_mem / unmap_region
Message-ID: <20220111141034.qtpngo5o7igy27ux@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACDmwr_J0ZoS+TJcKTMXR+H9K0A0y=X22EGxiqdq6sHFDaGD0A@mail.gmail.com>
 <Yd2IVM1q2Mmck3fJ@casper.infradead.org>
 <CACDmwr-0J1C=8Eba9bX9sCRdxVmF_u370xWoNo5vnTr4giUPCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 09:56:59PM +0800, Kaia Yadira wrote:
> Hello,
> 
> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.
> 
> HEAD commit: a7904a538933 Linux 5.16-rc6
> git tree: upstream
> console output: KCSAN: data-race in task_mem / unmap_region
> kernel config: https://paste.ubuntu.com/p/QB39MJKWKb/plain/
> Syzlang reproducer: https://paste.ubuntu.com/p/q2DVwVh6hr/plain/
> 
> If you fix this issue, please add the following tag to the commit:
> 
> Reported-by: Hypericum <hypericumperforatum4444@gmail.com>
> 
> I think fs/proc/task_mmu.c visits the variable mm without locking and
> another mmap visits mm->hiwater_vm resulting in a data race.
> 
> reproducer log: https://paste.ubuntu.com/p/Sp6RDWKDfy/plain/
> reproducer report:
> ==================================================================
> BUG: KCSAN: data-race in task_mem / unmap_region
> 
> write to 0xffff8881095008b0 of 8 bytes by task 3712 on cpu 4:
>  update_hiwater_rss include/linux/mm.h:2102 [inline]
>  unmap_region+0x12b/0x1e0 mm/mmap.c:2648
>  __do_munmap+0xe6e/0x12b0 mm/mmap.c:2883
>  __vm_munmap mm/mmap.c:2906 [inline]
>  __do_sys_munmap+0x9f/0x160 mm/mmap.c:2932
>  __se_sys_munmap mm/mmap.c:2928 [inline]
>  __x64_sys_munmap+0x2d/0x40 mm/mmap.c:2928
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> read to 0xffff8881095008b0 of 8 bytes by task 1512 on cpu 7:
>  task_mem+0xfb/0x3d0 fs/proc/task_mmu.c:50
>  proc_pid_status+0x890/0x14d0 fs/proc/array.c:438
>  proc_single_show+0x84/0x100 fs/proc/base.c:778
>  seq_read_iter+0x2e3/0x930 fs/seq_file.c:230
>  seq_read+0x234/0x280 fs/seq_file.c:162
>  vfs_read+0x1e6/0x730 fs/read_write.c:479
>  ksys_read+0xd9/0x190 fs/read_write.c:619
>  __do_sys_read fs/read_write.c:629 [inline]
>  __se_sys_read fs/read_write.c:627 [inline]
>  __x64_sys_read+0x3e/0x50 fs/read_write.c:627
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> value changed: 0x000000000000065b -> 0x0000000000000662
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 7 PID: 1512 Comm: systemd-journal Not tainted 5.16.0-rc8+ #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> ==================================================================

On Tue, Jan 11, 2022 at 01:38:28PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 11, 2022 at 10:38:02AM +0100, Aleksandr Nogikh wrote:
> > Hi Matthew,
> > 
> > That report was not sent by syzbot, rather by someone else. syzbot tries to
> > be much more careful with the INFO: reports.
> > 
> > During the past couple of weeks there has been some outburst of similar
> > reports from various senders - this is the third different sender I see,
> > probably there are also much more.
> 
> Right.  Perhaps syzcaller could *not* call sched_setscheduler() by
> default.  Require an --i-know-what-im-doing-and-wont-submit-bogus-reports
> flag to be specified by the user in order to call that syscall?

Yeah, can we stop reports from this particular non-"official" syzkaller
instance, please? We've received at least 3 or 4 of those just today and
frankly the reports generated here are not very useful in debugging
these issues; especially when contrasted with syzkaller "proper".
Frankly, it's pretty difficult to even tell they're legitimate. At first
I thought this is spam.

Honestly, I think we need to require that static analyzer, fuzzers and
so on need to register themselves with kernel.org or some other way
before allowing them to spam mailing lists.
