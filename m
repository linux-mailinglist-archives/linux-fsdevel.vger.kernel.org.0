Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16E511E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiD0SDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbiD0SDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:03:18 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293FC3528BE;
        Wed, 27 Apr 2022 11:00:05 -0700 (PDT)
Received: from [192.168.88.87] (unknown [180.246.147.8])
        by gnuweeb.org (Postfix) with ESMTPSA id 250CF7E77D;
        Wed, 27 Apr 2022 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1651082405;
        bh=XdAGrol22+1eKW7oPzfG88ci2nrd5HqToTa9A9kshWc=;
        h=Date:To:References:Cc:From:Subject:In-Reply-To:From;
        b=kMTwiBswha74oiLnyt3LSCL0wxy6J2eRGwlmKRNTHwYobE40+1HtlWJntQsxsGtm2
         l+1Cwpk/syc6nCdHXuYksGcq7hU6LRaEA0p6R/CqAErGuzbPxGFVaLPAAK5MM/GC8v
         uI7pSn89aZ7lpOOZ2s7L1CDZ2UgIoAdxqo+txb1l7kWQ9eFLCrurHY1ooeGfXa7t87
         cRSUhD0iGM1wUCwMbU59vhO4fJMdPXV7npeahDv6vznI4hnBHPveDgtR2YrGOXWtNr
         YMOILDmA3jhXNiakhngqr+JHj/4SIRm0F8DvVNN5qF2U8aFpQ22jAc+hjjGySOVBKy
         4vqOx14wUNAfA==
Message-ID: <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
Date:   Thu, 28 Apr 2022 00:59:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gwml@vger.gnuweeb.org
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: Linux 5.18-rc4
In-Reply-To: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/25/22 5:22 AM, Linus Torvalds wrote:
> Fairly slow and calm week - which makes me just suspect that the other
> shoe will drop at some point.
> 
> But maybe things are just going really well this release. It's bound
> to happen _occasionally_, after all.

+ fs/exec.c maintainers.

Testing Linux 5.18-rc4 on my laptop, it has been running for 2 days. Got
the following lockdep splat this night. I don't have the reproducer. If
you need more information, feel free to let me know.

[78140.503644] ======================================================
[78140.503646] WARNING: possible circular locking dependency detected
[78140.503648] 5.18.0-rc4-superb-owl-00006-gd615b5416f8a #12 Tainted: G        W
[78140.503650] ------------------------------------------------------
[78140.503651] preconv/111629 is trying to acquire lock:
[78140.503653] ffff88834d633248 (&ctx->lock){+.+.}-{2:2}, at: update_file_ctx+0x19/0xe0
[78140.503663]
                but task is already holding lock:
[78140.503664] ffff888103d80458 (&newf->file_lock){+.+.}-{2:2}, at: iterate_fd+0x34/0x150
[78140.503669]
                which lock already depends on the new lock.

[78140.503671]
                the existing dependency chain (in reverse order) is:
[78140.503672]
                -> #4 (&newf->file_lock){+.+.}-{2:2}:
[78140.503675]        _raw_spin_lock+0x2f/0x40
[78140.503679]        seq_show+0x72/0x280
[78140.503681]        seq_read_iter+0x125/0x3c0
[78140.503684]        seq_read+0xd0/0xe0
[78140.503686]        vfs_read+0xf5/0x2f0
[78140.503688]        ksys_read+0x58/0xb0
[78140.503690]        do_syscall_64+0x3d/0x90
[78140.503693]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[78140.503695]
                -> #3 (&p->alloc_lock){+.+.}-{2:2}:
[78140.503699]        _raw_spin_lock+0x2f/0x40
[78140.503700]        newseg+0x25b/0x360
[78140.503703]        ipcget+0x3fb/0x480
[78140.503705]        __x64_sys_shmget+0x48/0x50
[78140.503708]        do_syscall_64+0x3d/0x90
[78140.503710]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[78140.503713]
                -> #2 (&new->lock){+.+.}-{2:2}:
[78140.503716]        _raw_spin_lock+0x2f/0x40
[78140.503718]        ipc_addid+0xb3/0x700
[78140.503720]        newseg+0x238/0x360
[78140.503722]        ipcget+0x3fb/0x480
[78140.503724]        __x64_sys_shmget+0x48/0x50
[78140.503727]        do_syscall_64+0x3d/0x90
[78140.503729]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[78140.503731]
                -> #1 (lock#3){+.+.}-{2:2}:
[78140.503735]        local_lock_acquire+0x1d/0x70
[78140.503738]        __radix_tree_preload+0x38/0x150
[78140.503740]        idr_preload+0xa/0x40
[78140.503743]        aa_alloc_secid+0x15/0xb0
[78140.503745]        aa_label_alloc+0x6c/0x1b0
[78140.503747]        aa_label_merge+0x52/0x430
[78140.503750]        update_file_ctx+0x3f/0xe0
[78140.503752]        aa_file_perm+0x56e/0x5c0
[78140.503754]        common_file_perm+0x70/0xd0
[78140.503756]        security_mmap_file+0x4b/0xd0
[78140.503759]        vm_mmap_pgoff+0x50/0x150
[78140.503761]        elf_map+0x9f/0x120
[78140.503763]        load_elf_binary+0x521/0xc80
[78140.503767]        bprm_execve+0x39f/0x660
[78140.503769]        do_execveat_common+0x1d0/0x220
[78140.503771]        __x64_sys_execveat+0x3d/0x50
[78140.503773]        do_syscall_64+0x3d/0x90
[78140.503775]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[78140.503777]
                -> #0 (&ctx->lock){+.+.}-{2:2}:
[78140.503780]        __lock_acquire+0x1573/0x2ce0
[78140.503783]        lock_acquire+0xbd/0x190
[78140.503785]        _raw_spin_lock+0x2f/0x40
[78140.503787]        update_file_ctx+0x19/0xe0
[78140.503788]        aa_file_perm+0x56e/0x5c0
[78140.503790]        match_file+0x78/0x90
[78140.503792]        iterate_fd+0xae/0x150
[78140.503794]        aa_inherit_files+0xbe/0x170
[78140.503796]        apparmor_bprm_committing_creds+0x50/0x80
[78140.503798]        security_bprm_committing_creds+0x1d/0x30
[78140.503800]        begin_new_exec+0x3c5/0x450
[78140.503802]        load_elf_binary+0x269/0xc80
[78140.503804]        bprm_execve+0x39f/0x660
[78140.503806]        do_execveat_common+0x1d0/0x220
[78140.503808]        __x64_sys_execve+0x36/0x40
[78140.503809]        do_syscall_64+0x3d/0x90
[78140.503812]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[78140.503815]
                other info that might help us debug this:

[78140.503816] Chain exists of:
                  &ctx->lock --> &p->alloc_lock --> &newf->file_lock

[78140.503820]  Possible unsafe locking scenario:

[78140.503821]        CPU0                    CPU1
[78140.503823]        ----                    ----
[78140.503824]   lock(&newf->file_lock);
[78140.503826]                                lock(&p->alloc_lock);
[78140.503828]                                lock(&newf->file_lock);
[78140.503830]   lock(&ctx->lock);
[78140.503832]
                 *** DEADLOCK ***

[78140.503833] 3 locks held by preconv/111629:
[78140.503835]  #0: ffff888111b62550 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x39/0x660
[78140.503840]  #1: ffff888111b625e8 (&sig->exec_update_lock){++++}-{3:3}, at: exec_mmap+0x4e/0x250
[78140.503844]  #2: ffff888103d80458 (&newf->file_lock){+.+.}-{2:2}, at: iterate_fd+0x34/0x150
[78140.503849]
                stack backtrace:
[78140.503851] CPU: 3 PID: 111629 Comm: preconv Tainted: G        W         5.18.0-rc4-superb-owl-00006-gd615b5416f8a #12 6fd282a37da6f0e0172ecfa29689f3d250476a2b
[78140.503855] Hardware name: HP HP Laptop 14s-dq2xxx/87FD, BIOS F.15 09/15/2021
[78140.503856] Call Trace:
[78140.503858]  <TASK>
[78140.503860]  dump_stack_lvl+0x5a/0x74
[78140.503863]  check_noncircular+0xd3/0xe0
[78140.503866]  ? register_lock_class+0x35/0x2a0
[78140.503870]  __lock_acquire+0x1573/0x2ce0
[78140.503872]  ? prepend_path+0x375/0x410
[78140.503876]  ? d_absolute_path+0x48/0x80
[78140.503879]  ? aa_path_name+0x132/0x470
[78140.503883]  ? lock_is_held_type+0xd0/0x130
[78140.503886]  lock_acquire+0xbd/0x190
[78140.503888]  ? update_file_ctx+0x19/0xe0
[78140.503892]  _raw_spin_lock+0x2f/0x40
[78140.503894]  ? update_file_ctx+0x19/0xe0
[78140.503896]  update_file_ctx+0x19/0xe0
[78140.503899]  aa_file_perm+0x56e/0x5c0
[78140.503904]  ? aa_inherit_files+0x170/0x170
[78140.503906]  match_file+0x78/0x90
[78140.503909]  iterate_fd+0xae/0x150
[78140.503912]  aa_inherit_files+0xbe/0x170
[78140.503915]  apparmor_bprm_committing_creds+0x50/0x80
[78140.503918]  security_bprm_committing_creds+0x1d/0x30
[78140.503921]  begin_new_exec+0x3c5/0x450
[78140.503924]  load_elf_binary+0x269/0xc80
[78140.503928]  ? lock_release+0x1ee/0x260
[78140.503930]  ? bprm_execve+0x399/0x660
[78140.503933]  bprm_execve+0x39f/0x660
[78140.503936]  do_execveat_common+0x1d0/0x220
[78140.503940]  __x64_sys_execve+0x36/0x40
[78140.503942]  do_syscall_64+0x3d/0x90
[78140.503946]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[78140.503948] RIP: 0033:0x7f700a8ea33b
[78140.503954] Code: Unable to access opcode bytes at RIP 0x7f700a8ea311.
[78140.503955] RSP: 002b:00007fff315e7db8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[78140.503958] RAX: ffffffffffffffda RBX: 00007fff315e7dc0 RCX: 00007f700a8ea33b
[78140.503960] RDX: 000056419e9ea7e0 RSI: 000056419e9e9160 RDI: 00007fff315e7dc0
[78140.503962] RBP: 00007fff315e7f60 R08: 0000000000000008 R09: 0000000000000000
[78140.503964] R10: 0000000000000001 R11: 0000000000000246 R12: 000056419e9ea760
[78140.503965] R13: 000056419e9e9160 R14: 00007fff315e9eb4 R15: 00007fff315e9ebc
[78140.503971]  </TASK>

-- 
Ammar Faizi
