Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E01D3128431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 22:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfLTV6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 16:58:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46187 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfLTV6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:58:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so5585311pgb.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aK6HDeuP8paXZpubuxZWZ6zkxAQQyMhP2RbH4r/ZzkM=;
        b=SvcsQ0ClBVw+J5qGVPP358Vejfq3sGFN+gtEaQRVIt7zqdcRr2ayUhxKtJlJ+ZUmVj
         exyAZ6jpN7NjtAwTdVHX9K9RivzQcAIRLfGrk7cac4p0l5CRHIOy867S/qSEtEG8Iraz
         xHT0bJyhCC+qY6PSXMUCMd/KOHsVlpeZqGo7DxRh9VaoTqUiY/qTK65achySt7ZRQo6Z
         p8VUYUUrzna6gHa2QoxEuIBG3jtGf1cBw/9ylmvhihzeWKDNSahmmmx11j+6Z0TbjblJ
         bP7Joif+bTsSZ5M6o54mCJQgF3kvztAnuk60zUrhG7dfn21Cj0GPegYvyrUeA+wXM4Io
         B0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aK6HDeuP8paXZpubuxZWZ6zkxAQQyMhP2RbH4r/ZzkM=;
        b=GubXfsR/a9MtdQPGFS62rPp6W/V7LjWgagklJl9dSyi/C63Ky0mXgDu9PaPO6xqIQB
         /4U8Ryn6ysQ/E4JVPdrMpF5MrA7jGk46Lfg8z9vnjxhNief9D3gb78UPB2YMnvjGJ/On
         AvWsNumluqt5DgLS5NF6yLzTqyVowG7fqo4fnodJ9WgS3ARY4XxNprQDahjLc+V5CT8J
         eM2uBzMQX0XE/fnpegVZ2D6IY+GINMcnLy1VGePiWu6JFRY3Fmjd2uUGRIQQhjrGxXCt
         LQDy+6tWorK6DDwAzHv43Oqauy0ZnvA9ajZ0Cbh1fJgph0Ea7wwTmw/fYIqlPMxlTFxD
         dxHA==
X-Gm-Message-State: APjAAAXI/VEZjXDFWDPPI55yf6oMBuDk88HHZ+QB8qki0HIk99mrJ0QP
        amYCFcBAZwI2Hx/YtS0jUzsDKw==
X-Google-Smtp-Source: APXvYqw7sCV5qCxYvuSr3qfKq2ICqeOrLatuYPr25VGk2QoiNSZX9ypaNjHJo0/OTr3xRwOXOU534Q==
X-Received: by 2002:a62:3603:: with SMTP id d3mr17807181pfa.37.1576879126603;
        Fri, 20 Dec 2019 13:58:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1349? ([2620:10d:c090:180::4be8])
        by smtp.gmail.com with ESMTPSA id d5sm9601881pfd.107.2019.12.20.13.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 13:58:46 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in io_wq_flush
To:     syzbot <syzbot+a2cf8365eb32fc6dbb5e@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000aa4ede059a297356@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94dbbaec-e19d-04a3-4858-79197bf19ba0@kernel.dk>
Date:   Fri, 20 Dec 2019 14:58:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <000000000000aa4ede059a297356@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/20/19 2:35 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7ddd09fc Add linux-next specific files for 20191220
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a074c1e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
> dashboard link: https://syzkaller.appspot.com/bug?extid=a2cf8365eb32fc6dbb5e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1190743ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b97f1ee00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a2cf8365eb32fc6dbb5e@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in io_wq_flush+0x1f7/0x210 fs/io-wq.c:1009
> Read of size 8 at addr ffff88809ea14b00 by task kworker/1:2/2797
> 
> CPU: 1 PID: 2797 Comm: kworker/1:2 Not tainted  
> 5.5.0-rc2-next-20191220-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: events io_ring_file_ref_switch
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>   print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
>   __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
>   kasan_report+0x12/0x20 mm/kasan/common.c:639
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>   io_wq_flush+0x1f7/0x210 fs/io-wq.c:1009
>   io_destruct_skb+0x8e/0xc0 fs/io_uring.c:4668
>   skb_release_head_state+0xeb/0x260 net/core/skbuff.c:652
>   skb_release_all+0x16/0x60 net/core/skbuff.c:663
>   __kfree_skb net/core/skbuff.c:679 [inline]
>   kfree_skb net/core/skbuff.c:697 [inline]
>   kfree_skb+0x101/0x420 net/core/skbuff.c:691
>   io_ring_file_put fs/io_uring.c:4836 [inline]
>   io_ring_file_ref_switch+0x68a/0xac0 fs/io_uring.c:4881
>   process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
>   worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Allocated by task 9381:
>   save_stack+0x23/0x90 mm/kasan/common.c:72
>   set_track mm/kasan/common.c:80 [inline]
>   __kasan_kmalloc mm/kasan/common.c:513 [inline]
>   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
>   kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
>   kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
>   kmalloc include/linux/slab.h:555 [inline]
>   kzalloc include/linux/slab.h:669 [inline]
>   io_wq_create+0x52/0xa40 fs/io-wq.c:1024
>   io_sq_offload_start fs/io_uring.c:5244 [inline]
>   io_uring_create fs/io_uring.c:6002 [inline]
>   io_uring_setup+0xf4a/0x2080 fs/io_uring.c:6062
>   __do_sys_io_uring_setup fs/io_uring.c:6075 [inline]
>   __se_sys_io_uring_setup fs/io_uring.c:6072 [inline]
>   __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:6072
>   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 9381:
>   save_stack+0x23/0x90 mm/kasan/common.c:72
>   set_track mm/kasan/common.c:80 [inline]
>   kasan_set_free_info mm/kasan/common.c:335 [inline]
>   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
>   __cache_free mm/slab.c:3426 [inline]
>   kfree+0x10a/0x2c0 mm/slab.c:3757
>   io_wq_destroy+0x2ce/0x3c0 fs/io-wq.c:1116
>   io_finish_async+0x128/0x1b0 fs/io_uring.c:4657
>   io_ring_ctx_free fs/io_uring.c:5569 [inline]
>   io_ring_ctx_wait_and_kill+0x330/0x9a0 fs/io_uring.c:5644
>   io_uring_release+0x42/0x50 fs/io_uring.c:5652
>   __fput+0x2ff/0x890 fs/file_table.c:280
>   ____fput+0x16/0x20 fs/file_table.c:313
>   task_work_run+0x145/0x1c0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
>   prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
>   do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff88809ea14b00
>   which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 0 bytes inside of
>   192-byte region [ffff88809ea14b00, ffff88809ea14bc0)
> The buggy address belongs to the page:
> page:ffffea00027a8500 refcount:1 mapcount:0 mapping:ffff8880aa400000  
> index:0x0
> raw: 00fffe0000000200 ffffea00027a8148 ffffea00027a8f08 ffff8880aa400000
> raw: 0000000000000000 ffff88809ea14000 0000000100000010 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff88809ea14a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88809ea14a80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>> ffff88809ea14b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff88809ea14b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff88809ea14c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================

#syz invalid

This is fixed in the current tree, pushing out a new linux-next
branch.

-- 
Jens Axboe

