Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230224393BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhJYKeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 06:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJYKe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:34:27 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD737C061767
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 03:32:05 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t4so14887347oie.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0QnWPztlsrRoM5HO4MFrl5hX+n1/I11tCMVuj+w7U8=;
        b=gh2C0oDeLRx4W05Z5QcTixxzocX+J2wuaAYBOBR58Ea1BiaAkWbGE2t7RZknfSK8FF
         F2bMhbyhrTceCH4kWyuqHoL5gYddSREl0Ljw5a00FKyot0RHun7Xd7NSEcA4hwQ56bnr
         zhoDY+a6CNDE/hQaJuw3XmC3pBRFZSB7RGOhI+/gH3qVk0Su95s7dnT9Pqwva+xG1lxH
         deBbkAR58GQYNrWUr2W7xJi7mPt9B5oUy5lrWYQ0v0ORb29s4FD9F61NWiYdoq1rnRFg
         93dkxJuzfe1V9eSAxPEF8OWRVvfJRLkYVwo6xo9N3ti5oqIWC3VXx5V437QWSDRgd7J3
         SUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0QnWPztlsrRoM5HO4MFrl5hX+n1/I11tCMVuj+w7U8=;
        b=SGJoNw80V8k/NH/aM+qVtoU7IwfLSiJTN/iUBSg4j/iASAEpaBZeXNWpm4i94AlXKG
         MMBR06xcBGt0dTv+66WaUfQwTv9npQp0fZthrw5AKcVnczcu6YEfqBhTwRsSXaNThZRt
         mnB6bnOICeKJy/GEKCvH6jRH+7Itkjog1pB4BAjzmcM9KFluC5AZqAcBgz1oNMHSW0mv
         iRMzVqoKd7xTGHiLXLfIs5XdgjcWD/kEbXj6BWNbXN7HMyc5woS+4TOUbYb4Ygo5Ig5q
         OMMJVUwR0CG2tSCw2uSIPzGmLobFsks2+5XcG5yMQRqngS1BnK+g89fdXh3yryrK4C1G
         MyLg==
X-Gm-Message-State: AOAM5303QwB9BCL5Or4BvS5vjTfAk18HJqWEsyGEo4cGu8Y/6nzouE9Q
        ldB5pQ7LJsfx4gFDaR3Puv+33BQxn/wE5F6xrodPPg==
X-Google-Smtp-Source: ABdhPJz1wKIV7+08Iah66Oe22tvpOMW6pVLQVVTYmBXVxB5VceXtYx/xZf8ft4WIDG+m7H8oa7ejZPfQXKcJWUDINis=
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr11466075oih.134.1635157924929;
 Mon, 25 Oct 2021 03:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ddb95c05cf2ad54a@google.com>
In-Reply-To: <000000000000ddb95c05cf2ad54a@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Oct 2021 12:31:53 +0200
Message-ID: <CANpmjNPC6Oqq3+8ENDfM=jXUtY+_zWHAkAE5Wq87ZMYZMV6uLg@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_fqs_loop
To:     syzbot <syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Cc Paul

data race is in rcu code, presumably not yet discovered by rcutorture?

On Mon, 25 Oct 2021 at 12:29, syzbot
<syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=159c4954b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6339b6ea86d89fd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4dfb96a94317a78f44d9
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in call_rcu / rcu_gp_fqs_loop
>
> write to 0xffffffff837342e0 of 8 bytes by task 11 on cpu 1:
>  rcu_gp_fqs kernel/rcu/tree.c:1910 [inline]
>  rcu_gp_fqs_loop+0x348/0x470 kernel/rcu/tree.c:1971
>  rcu_gp_kthread+0x25/0x1a0 kernel/rcu/tree.c:2130
>  kthread+0x262/0x280 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30
>
> read to 0xffffffff837342e0 of 8 bytes by task 379 on cpu 0:
>  __call_rcu_core kernel/rcu/tree.c:2904 [inline]
>  __call_rcu kernel/rcu/tree.c:3020 [inline]
>  call_rcu+0x4c0/0x6d0 kernel/rcu/tree.c:3067
>  __dentry_kill+0x3ec/0x4e0 fs/dcache.c:596
>  dput+0xc6/0x360 fs/dcache.c:888
>  do_unlinkat+0x2a8/0x540 fs/namei.c:4172
>  __do_sys_unlink fs/namei.c:4217 [inline]
>  __se_sys_unlink fs/namei.c:4215 [inline]
>  __x64_sys_unlink+0x2c/0x30 fs/namei.c:4215
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xa0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> value changed: 0x0000000000005c0d -> 0x0000000000005c0e
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 379 Comm: udevd Tainted: G        W         5.15.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
