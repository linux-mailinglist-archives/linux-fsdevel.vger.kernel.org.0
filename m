Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0538512180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiD0StZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiD0StE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:49:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F637126358
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:32:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w1so4663580lfa.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LE417ya6E7m+nXp6VV/VN8esAD2AhVJo0XqStc9jrKk=;
        b=RkRpVLCj/djXRGkAnPrqrRcldz58N/lNU769t9fa5KcRaUz9rB5K4dE6u1yXQlsMfx
         I8k1XxLo6SaOA6pzgCwIGoXlEXQp6Z49mUgLLqc1AFPoQbQABpvC25LOj0cySPWBi5xY
         mlkA0T+/0sIcHgYnsbRjyF5k3OCP5ahpJ5jFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LE417ya6E7m+nXp6VV/VN8esAD2AhVJo0XqStc9jrKk=;
        b=1dyqpYlJ0vajD8hDzaEQ8siWu2MmNk7KYWIVQvwFgd5e7dUN5T9eTwu8Mv9Fqp1Aon
         eTcBKwbQDxwTOp2lfmb6gt2r7J0SU94j5tG5949a6f+BIuOh0OVi0OnuoPhyr2f4vYf3
         JxRV3IoXHlJ/A0S6XaYrrlyjYyQPAoQ1vCL7ezijOhYVZNQRE6HTso5g5HSTuxGXe9uz
         3RAoGnklEQ7Zpe3689kEu5Hx4FyWusoATCxaRrYHxCaKh525/KTGanEI3qLzOd0g5M5L
         y4frVaJ1+itTl+4hn87Qio3xxlbwi86XO4+cBcj7mG76Lymrq1Y7O3/bkLZwINbknyNS
         WZgA==
X-Gm-Message-State: AOAM530zQ6WzCqTO1i55a2IYni7q7OAw7qvvERBKtVCJkh6jYswerjwF
        ck6h24fNdebcq8EElFSJaLWpGWrYXQIGcXM5eL4=
X-Google-Smtp-Source: ABdhPJxSsMWeoHaCspVrOXovYOWJqzPJ9qA4nmXbJBEE0eh3IqRTlHseHUXpn8RQRtfSwdEGyBfyXg==
X-Received: by 2002:a05:6512:31c4:b0:471:9f60:d7f3 with SMTP id j4-20020a05651231c400b004719f60d7f3mr21590105lfe.141.1651084332207;
        Wed, 27 Apr 2022 11:32:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512339200b0047202d3531csm1287320lfg.115.2022.04.27.11.32.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 11:32:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id v1so3809793ljv.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 11:32:10 -0700 (PDT)
X-Received: by 2002:a2e:8789:0:b0:24f:124c:864a with SMTP id
 n9-20020a2e8789000000b0024f124c864amr10454141lji.164.1651084330452; Wed, 27
 Apr 2022 11:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
In-Reply-To: <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 11:31:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
Message-ID: <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks like it might be AppArmor-related.

Adding AppArmor and security module people to the participants.

Sorry for top-posting and quoting the whole thing, but this is really
just bringing in more people to the discussion.

So on the exec path we have

  apparmor_bprm_committing_creds() ->
    aa_inherit_files() ->
      iterate_fd (takes files->file_lock) ->
        aa_file_perm ->
          update_file_ctx (takes aa_file_ctx->lock)

which gives us that file_lock -> ctx lock order. All within AppArmor.

And then we apparently _also_ have the reverse ctx lock -> file_lock
order by way of 'alloc_lock', which is the 'task_lock()' thing

That one is a horror to decode and I didn't, but seems to go through
ipcget -> newseg..

Anybody?

         Linus

On Wed, Apr 27, 2022 at 11:00 AM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> On 4/25/22 5:22 AM, Linus Torvalds wrote:
> > Fairly slow and calm week - which makes me just suspect that the other
> > shoe will drop at some point.
> >
> > But maybe things are just going really well this release. It's bound
> > to happen _occasionally_, after all.
>
> + fs/exec.c maintainers.
>
> Testing Linux 5.18-rc4 on my laptop, it has been running for 2 days. Got
> the following lockdep splat this night. I don't have the reproducer. If
> you need more information, feel free to let me know.
>
> [78140.503644] ======================================================
> [78140.503646] WARNING: possible circular locking dependency detected
> [78140.503648] 5.18.0-rc4-superb-owl-00006-gd615b5416f8a #12 Tainted: G        W
> [78140.503650] ------------------------------------------------------
> [78140.503651] preconv/111629 is trying to acquire lock:
> [78140.503653] ffff88834d633248 (&ctx->lock){+.+.}-{2:2}, at: update_file_ctx+0x19/0xe0
> [78140.503663]
>                 but task is already holding lock:
> [78140.503664] ffff888103d80458 (&newf->file_lock){+.+.}-{2:2}, at: iterate_fd+0x34/0x150
> [78140.503669]
>                 which lock already depends on the new lock.
>
> [78140.503671]
>                 the existing dependency chain (in reverse order) is:
> [78140.503672]
>                 -> #4 (&newf->file_lock){+.+.}-{2:2}:
> [78140.503675]        _raw_spin_lock+0x2f/0x40
> [78140.503679]        seq_show+0x72/0x280
> [78140.503681]        seq_read_iter+0x125/0x3c0
> [78140.503684]        seq_read+0xd0/0xe0
> [78140.503686]        vfs_read+0xf5/0x2f0
> [78140.503688]        ksys_read+0x58/0xb0
> [78140.503690]        do_syscall_64+0x3d/0x90
> [78140.503693]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [78140.503695]
>                 -> #3 (&p->alloc_lock){+.+.}-{2:2}:
> [78140.503699]        _raw_spin_lock+0x2f/0x40
> [78140.503700]        newseg+0x25b/0x360
> [78140.503703]        ipcget+0x3fb/0x480
> [78140.503705]        __x64_sys_shmget+0x48/0x50
> [78140.503708]        do_syscall_64+0x3d/0x90
> [78140.503710]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [78140.503713]
>                 -> #2 (&new->lock){+.+.}-{2:2}:
> [78140.503716]        _raw_spin_lock+0x2f/0x40
> [78140.503718]        ipc_addid+0xb3/0x700
> [78140.503720]        newseg+0x238/0x360
> [78140.503722]        ipcget+0x3fb/0x480
> [78140.503724]        __x64_sys_shmget+0x48/0x50
> [78140.503727]        do_syscall_64+0x3d/0x90
> [78140.503729]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [78140.503731]
>                 -> #1 (lock#3){+.+.}-{2:2}:
> [78140.503735]        local_lock_acquire+0x1d/0x70
> [78140.503738]        __radix_tree_preload+0x38/0x150
> [78140.503740]        idr_preload+0xa/0x40
> [78140.503743]        aa_alloc_secid+0x15/0xb0
> [78140.503745]        aa_label_alloc+0x6c/0x1b0
> [78140.503747]        aa_label_merge+0x52/0x430
> [78140.503750]        update_file_ctx+0x3f/0xe0
> [78140.503752]        aa_file_perm+0x56e/0x5c0
> [78140.503754]        common_file_perm+0x70/0xd0
> [78140.503756]        security_mmap_file+0x4b/0xd0
> [78140.503759]        vm_mmap_pgoff+0x50/0x150
> [78140.503761]        elf_map+0x9f/0x120
> [78140.503763]        load_elf_binary+0x521/0xc80
> [78140.503767]        bprm_execve+0x39f/0x660
> [78140.503769]        do_execveat_common+0x1d0/0x220
> [78140.503771]        __x64_sys_execveat+0x3d/0x50
> [78140.503773]        do_syscall_64+0x3d/0x90
> [78140.503775]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [78140.503777]
>                 -> #0 (&ctx->lock){+.+.}-{2:2}:
> [78140.503780]        __lock_acquire+0x1573/0x2ce0
> [78140.503783]        lock_acquire+0xbd/0x190
> [78140.503785]        _raw_spin_lock+0x2f/0x40
> [78140.503787]        update_file_ctx+0x19/0xe0
> [78140.503788]        aa_file_perm+0x56e/0x5c0
> [78140.503790]        match_file+0x78/0x90
> [78140.503792]        iterate_fd+0xae/0x150
> [78140.503794]        aa_inherit_files+0xbe/0x170
> [78140.503796]        apparmor_bprm_committing_creds+0x50/0x80
> [78140.503798]        security_bprm_committing_creds+0x1d/0x30
> [78140.503800]        begin_new_exec+0x3c5/0x450
> [78140.503802]        load_elf_binary+0x269/0xc80
> [78140.503804]        bprm_execve+0x39f/0x660
> [78140.503806]        do_execveat_common+0x1d0/0x220
> [78140.503808]        __x64_sys_execve+0x36/0x40
> [78140.503809]        do_syscall_64+0x3d/0x90
> [78140.503812]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [78140.503815]
>                 other info that might help us debug this:
>
> [78140.503816] Chain exists of:
>                   &ctx->lock --> &p->alloc_lock --> &newf->file_lock
>
> [78140.503820]  Possible unsafe locking scenario:
>
> [78140.503821]        CPU0                    CPU1
> [78140.503823]        ----                    ----
> [78140.503824]   lock(&newf->file_lock);
> [78140.503826]                                lock(&p->alloc_lock);
> [78140.503828]                                lock(&newf->file_lock);
> [78140.503830]   lock(&ctx->lock);
> [78140.503832]
>                  *** DEADLOCK ***
>
> [78140.503833] 3 locks held by preconv/111629:
> [78140.503835]  #0: ffff888111b62550 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x39/0x660
> [78140.503840]  #1: ffff888111b625e8 (&sig->exec_update_lock){++++}-{3:3}, at: exec_mmap+0x4e/0x250
> [78140.503844]  #2: ffff888103d80458 (&newf->file_lock){+.+.}-{2:2}, at: iterate_fd+0x34/0x150
> [78140.503849]
>                 stack backtrace:
> [78140.503851] CPU: 3 PID: 111629 Comm: preconv Tainted: G        W         5.18.0-rc4-superb-owl-00006-gd615b5416f8a #12 6fd282a37da6f0e0172ecfa29689f3d250476a2b
> [78140.503855] Hardware name: HP HP Laptop 14s-dq2xxx/87FD, BIOS F.15 09/15/2021
> [78140.503856] Call Trace:
> [78140.503858]  <TASK>
> [78140.503860]  dump_stack_lvl+0x5a/0x74
> [78140.503863]  check_noncircular+0xd3/0xe0
> [78140.503866]  ? register_lock_class+0x35/0x2a0
> [78140.503870]  __lock_acquire+0x1573/0x2ce0
> [78140.503872]  ? prepend_path+0x375/0x410
> [78140.503876]  ? d_absolute_path+0x48/0x80
> [78140.503879]  ? aa_path_name+0x132/0x470
> [78140.503883]  ? lock_is_held_type+0xd0/0x130
> [78140.503886]  lock_acquire+0xbd/0x190
> [78140.503888]  ? update_file_ctx+0x19/0xe0
> [78140.503892]  _raw_spin_lock+0x2f/0x40
> [78140.503894]  ? update_file_ctx+0x19/0xe0
> [78140.503896]  update_file_ctx+0x19/0xe0
> [78140.503899]  aa_file_perm+0x56e/0x5c0
> [78140.503904]  ? aa_inherit_files+0x170/0x170
> [78140.503906]  match_file+0x78/0x90
> [78140.503909]  iterate_fd+0xae/0x150
> [78140.503912]  aa_inherit_files+0xbe/0x170
> [78140.503915]  apparmor_bprm_committing_creds+0x50/0x80
> [78140.503918]  security_bprm_committing_creds+0x1d/0x30
> [78140.503921]  begin_new_exec+0x3c5/0x450
> [78140.503924]  load_elf_binary+0x269/0xc80
> [78140.503928]  ? lock_release+0x1ee/0x260
> [78140.503930]  ? bprm_execve+0x399/0x660
> [78140.503933]  bprm_execve+0x39f/0x660
> [78140.503936]  do_execveat_common+0x1d0/0x220
> [78140.503940]  __x64_sys_execve+0x36/0x40
> [78140.503942]  do_syscall_64+0x3d/0x90
> [78140.503946]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [78140.503948] RIP: 0033:0x7f700a8ea33b
> [78140.503954] Code: Unable to access opcode bytes at RIP 0x7f700a8ea311.
> [78140.503955] RSP: 002b:00007fff315e7db8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> [78140.503958] RAX: ffffffffffffffda RBX: 00007fff315e7dc0 RCX: 00007f700a8ea33b
> [78140.503960] RDX: 000056419e9ea7e0 RSI: 000056419e9e9160 RDI: 00007fff315e7dc0
> [78140.503962] RBP: 00007fff315e7f60 R08: 0000000000000008 R09: 0000000000000000
> [78140.503964] R10: 0000000000000001 R11: 0000000000000246 R12: 000056419e9ea760
> [78140.503965] R13: 000056419e9e9160 R14: 00007fff315e9eb4 R15: 00007fff315e9ebc
> [78140.503971]  </TASK>
>
> --
> Ammar Faizi
