Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992905783C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiGRNeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGRNeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:34:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0868295;
        Mon, 18 Jul 2022 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rNwpaOK/N2Qeq5RKoVxUW3hv75fBSxrUcWivgUjoCTk=; b=o7JEAHsHOGfCmmwTBIHuXrUdDg
        XnY75RCIsTdPGVlvIIpB+2bpy7ZXR659/zif4C/tp8yqgzRHoJ22fg9iaAm63KvtDedAmhRJKui4S
        QiosQAuFdDmd9ldq3Zpe40j5lGRIompqjg87RcWvh3GIVaBiV6soyrvv4bgj93vz2jYd6mBxhulEm
        kj5d/KHzh4l9Wv/SFtCaY2VIuH4zwScgryB53j7pZGQQcaercaWy7rfGTwGf4lrjk1mSPZ/bKLce/
        5Qp+W9jaswDgVDtEw6aw3XWjhJDjrxj4D0L6rEakcDbRsoNg+CpRkfWMkAQqAI5Y66ItGV3u3pWB+
        tQzGUP+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDQt2-00CiXz-Ro; Mon, 18 Jul 2022 13:34:12 +0000
Date:   Mon, 18 Jul 2022 14:34:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: INFO: task hung in __block_write_begin_int
Message-ID: <YtVhVKPAfzGmHu95@casper.infradead.org>
References: <CAO4mrffrR_C1y=07=Sxgj6r=SAyA3yN-h-atcGkoKrnSku026A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrffrR_C1y=07=Sxgj6r=SAyA3yN-h-atcGkoKrnSku026A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:11:37PM +0800, Wei Chen wrote:
> Dear Linux Developer,
> 
> Recently when using our tool to fuzz kernel, the following crash was triggered:

This isn't interesting.  As root, you were able to set up a config where
you blocked for too long.  You can't just run syzcaller and say "hey, i
found a bug".  You have to understand what would be interesting & useful
bugs to find.

> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: clang 12.0.0
> console output:
> https://drive.google.com/file/d/1dk3H5-D3ppxAONucKu_Vh7uXI2e94HyI/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1dcYG-en7_om3HWtUUMip3vooPxr38is2/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/15cJ2SBbvNIBJXFux85lmVFz5kbwNsY4w/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> 
> INFO: task syz-executor:14691 blocked for more than 143 seconds.
>       Not tainted 5.15.0-rc5+ #14
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:25712 pid:14691 ppid:  6522 flags:0x00004004
> Call Trace:
>  __schedule+0xc1a/0x11e0
>  schedule+0x14b/0x210
>  io_schedule+0x83/0x100
>  bit_wait_io+0xe/0xc0
>  __wait_on_bit+0xbb/0x180
>  out_of_line_wait_on_bit+0x1c3/0x240
>  __block_write_begin_int+0x187e/0x1a10
>  block_write_begin+0x54/0x2c0
>  generic_perform_write+0x28c/0x5e0
>  __generic_file_write_iter+0x26d/0x540
>  blkdev_write_iter+0x3a2/0x560
>  vfs_write+0x868/0xf50
>  ksys_write+0x175/0x2b0
>  do_syscall_64+0x3d/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f08ee707c4d
> RSP: 002b:00007f08ebc6fc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f08ee82e0a0 RCX: 00007f08ee707c4d
> RDX: 00000000000006a8 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00007f08ee780d80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f08ee82e0a0
> R13: 00007ffc57334f2f R14: 00007ffc573350d0 R15: 00007f08ebc6fdc0
> 
> Showing all locks held in the system:
> 2 locks held by kworker/u2:1/10:
> 1 lock held by khungtaskd/21:
>  #0: ffffffff8cf1c040 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
> 1 lock held by in:imklog/6329:
>  #0: ffff888016c2dc70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x26c/0x310
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 21 Comm: khungtaskd Not tainted 5.15.0-rc5+ #14
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  dump_stack_lvl+0x1d8/0x2c4
>  nmi_cpu_backtrace+0x452/0x480
>  nmi_trigger_cpumask_backtrace+0x1a3/0x330
>  watchdog+0xdbe/0xe30
>  kthread+0x419/0x510
>  ret_from_fork+0x1f/0x30
> 
> Best,
> Wei
