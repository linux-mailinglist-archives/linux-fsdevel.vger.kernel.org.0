Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17664266A7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgIKV7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgIKV7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:59:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5811C061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 14:59:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e7so9095718qtj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jr65qAjWonZpJu277jcIQGXrj5NFYpjfdQGASbMcApw=;
        b=PAx0hw+t/3ZbaZRgRxQmmfoZPvYgr6k/2qKOgxpqH4bRcPJY/OsTDUEcJaX9XFUITc
         JeT4Ba/PqCySsufq3RG7YDNQCSbbvDDo6xgTx3YV/Sb6aajkWBHTWurvTJAyifNNR6ZN
         XNoxCtzEv0bCfwsSJnsIcUoNtStX3MDBCrPRvQAtkYN4OIN82H7r6QT62GfVCJ31Lksg
         bbf+0jLWHSk0n1eZlz/Ag+bSz+3lUyNGTgUoS8c7d/NIqsJ0AAL+QlHvCF7dOk6p4Ufw
         NY0RBINgQ39tCILagkNBI2uilbB4GvQm67qVRW3SdqPHJjvp1Ca5WwyrgHn7k1DhWEh9
         l7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jr65qAjWonZpJu277jcIQGXrj5NFYpjfdQGASbMcApw=;
        b=D5DkFjB2iOSbwu5ep4lhNHDsPeZBTU1/I1u/kDi20wwVK8SHkaPVfcZQ05IsknTblg
         UaGtw6lF8rZ1rPtQ9fDjv2kuuUbOqC0w1Yhh6uITLRRmK6FzO7AFCfS8x6/UeQlskuha
         bJAmIXgpxJuhvXCk9WYVxubAX1hALF3GP6ob2Vf6QbTcOYSPRphvAPX+C8feX4Lkny/x
         STiMqemvhmH4r/MNbd8PDjLx3RR7cmRzn9uFh6MEWm34ZB9+8npbCJbFMEPWLmKpKpQD
         2ZeCfXWBhvSPPe5jZVSiYZY406XAFn5psATGBolU+7aTccJotrXcZD303zphhEvx7fep
         BMnw==
X-Gm-Message-State: AOAM531CaJQUjf5mrYUUdNPlYouum2djtBhbO/wPOj0STxYDWOOT5xAo
        21LT24uhthwSx7y7lC/u7O7d6gfKqTOpp/pb
X-Google-Smtp-Source: ABdhPJxPk5RFqrR9QQcqLJxvQh6Sqt4bPDD6YaFxC44pQGWIaDaLN1dbWKvZdqVt/swblfgxnvNzDg==
X-Received: by 2002:aed:3e0e:: with SMTP id l14mr4123228qtf.150.1599861550657;
        Fri, 11 Sep 2020 14:59:10 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p129sm4183033qkc.43.2020.09.11.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:59:10 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:59:04 -0400
From:   Qian Cai <cai@lca.pw>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: slab-out-of-bounds in iov_iter_revert()
Message-ID: <20200911215903.GA16973@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Super easy to reproduce on today's mainline by just fuzzing for a few minutes
on virtiofs (if it ever matters). Any thoughts?

[  511.089112] BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0xd8/0x3c0
iov_iter_revert at lib/iov_iter.c:1135
(inlined by) iov_iter_revert at lib/iov_iter.c:1080
[  511.092650] Read of size 8 at addr ffff88869e11dff8 by task trinity-c1/11868
[  511.096178] 
[  511.096897] CPU: 20 PID: 11868 Comm: trinity-c1 Not tainted 5.9.0-rc4+ #1
[  511.100257] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[  511.103999] Call Trace:
[  511.105002]  dump_stack+0x7c/0xb0
[  511.106329]  ? iov_iter_revert+0xd8/0x3c0
[  511.107915]  print_address_description.constprop.7+0x1e/0x230
[  511.110193]  ? kmsg_dump_rewind_nolock+0x59/0x59
[  511.112038]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  511.113890]  ? iov_iter_revert+0xd8/0x3c0
[  511.115469]  ? iov_iter_revert+0xd8/0x3c0
[  511.117082]  kasan_report.cold.9+0x37/0x86
[  511.118711]  ? do_readv+0x20/0x1b0
[  511.120078]  ? iov_iter_revert+0xd8/0x3c0
[  511.122614]  iov_iter_revert+0xd8/0x3c0
[  511.124673]  generic_file_read_iter+0x139/0x220
[  511.127386]  fuse_file_read_iter+0x239/0x270 [fuse]
[  511.130229]  ? fuse_direct_IO+0x600/0x600 [fuse]
[  511.133491]  ? rwsem_optimistic_spin+0x3d0/0x3d0
[  511.137177]  ? wake_up_q+0x92/0xd0
[  511.139702]  ? kasan_unpoison_shadow+0x30/0x40
[  511.142518]  do_iter_readv_writev+0x307/0x350
[  511.144850]  ? no_seek_end_llseek_size+0x20/0x20
[  511.147155]  do_iter_read+0x13f/0x2e0
[  511.148696]  vfs_readv+0xcc/0x130
[  511.150118]  ? compat_rw_copy_check_uvector+0x1e0/0x1e0
[  511.152300]  ? enqueue_hrtimer+0x60/0x100
[  511.154043]  ? hrtimer_start_range_ns+0x32f/0x4c0
[  511.157561]  ? hrtimer_run_softirq+0x100/0x100
[  511.161514]  ? _raw_spin_lock_irq+0x7b/0xd0
[  511.164570]  ? _raw_write_unlock_irqrestore+0x20/0x20
[  511.167568]  ? hrtimer_active+0x71/0xa0
[  511.169331]  ? mutex_lock+0x8e/0xe0
[  511.171694]  ? __mutex_lock_slowpath+0x10/0x10
[  511.174580]  ? perf_call_bpf_enter.isra.21+0x110/0x110
[  511.177926]  ? __fget_light+0xa3/0x100
[  511.179916]  do_readv+0xc1/0x1b0
[  511.181331]  ? vfs_readv+0x130/0x130
[  511.182867]  ? ktime_get_coarse_real_ts64+0x4a/0x70
[  511.185455]  do_syscall_64+0x33/0x40
[  511.188008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  511.191314] RIP: 0033:0x7f11e9b4578d
[  511.193639] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 08
[  511.202148] RSP: 002b:00007fff9b5eec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
[  511.205620] RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007f11e9b4578d
[  511.210533] RDX: 0000000000000091 RSI: 0000000002c49450 RDI: 00000000000000e1
[  511.214992] RBP: 0000000000000013 R08: 000000008d8d8d8d R09: 00000000000002d2
[  511.218631] R10: 00000020845754a0 R11: 0000000000000246 R12: 0000000000000002
[  511.221595] R13: 00007f11ea227058 R14: 00007f11ea2356c0 R15: 00007f11ea227000
[  511.225949] 
[  511.227008] Allocated by task 11748:
[  511.229204]  kasan_save_stack+0x19/0x40
[  511.231404]  __kasan_kmalloc.constprop.8+0xc1/0xd0
[  511.234647]  perf_event_mmap+0x28f/0x5f0
[  511.237170]  mmap_region+0x1cc/0xa50
[  511.239192]  do_mmap+0x3e5/0x6a0
[  511.241337]  vm_mmap_pgoff+0x15f/0x1b0
[  511.243586]  ksys_mmap_pgoff+0x2d3/0x320
[  511.245903]  do_syscall_64+0x33/0x40
[  511.247914]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  511.250139] 
[  511.250797] Freed by task 11748:
[  511.252160]  kasan_save_stack+0x19/0x40
[  511.253775]  kasan_set_track+0x1c/0x30
[  511.255348]  kasan_set_free_info+0x1b/0x30
[  511.257072]  __kasan_slab_free+0x108/0x150
[  511.258785]  kfree+0x95/0x380
[  511.260050]  perf_event_mmap+0x4aa/0x5f0
[  511.261694]  mmap_region+0x1cc/0xa50
[  511.263198]  do_mmap+0x3e5/0x6a0
[  511.264564]  vm_mmap_pgoff+0x15f/0x1b0
[  511.266133]  ksys_mmap_pgoff+0x2d3/0x320
[  511.267773]  do_syscall_64+0x33/0x40
[  511.269276]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  511.272756] 
[  511.273583] The buggy address belongs to the object at ffff88869e11c000
[  511.273583]  which belongs to the cache kmalloc-4k of size 4096
[  511.281456] The buggy address is located 4088 bytes to the right of
[  511.281456]  4096-byte region [ffff88869e11c000, ffff88869e11d000)
[  511.288473] The buggy address belongs to the page:
[  511.291093] page:0000000073d20fbc refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x69e118
[  511.296681] head:0000000073d20fbc order:3 compound_mapcount:0 compound_pincount:0
[  511.301118] flags: 0x17ffffc0010200(slab|head)
[  511.303426] raw: 0017ffffc0010200 0000000000000000 0000000300000001 ffff888107c4ef80
[  511.307482] raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
[  511.310957] page dumped because: kasan: bad access detected
[  511.313233] 
[  511.313867] Memory state around the buggy address:
[  511.315849]  ffff88869e11de80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  511.318933]  ffff88869e11df00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  511.322715] >ffff88869e11df80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  511.325993]                                                                 ^
[  511.330020]  ffff88869e11e000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  511.334333]  ffff88869e11e080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
