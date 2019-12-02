Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5510E60A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 07:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLBGkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 01:40:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40865 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfLBGkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:40:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id z22so19460735qto.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2019 22:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syKeBHWe4HxWIQ5X+mPdFfW/TrjICdwgcKSYdntZoAw=;
        b=m91pVQxgzTI0E4n+uLlfZzxBobwKMj3ZjPelFZZYGrMIJA3ZOgEyVfWnhn9/Re94SD
         idw2eTq/Q7tH674gGaoEtgjdDBVA8dXP/Q/AM+mCozV21XWDymyggGXwZGjBIEavNy16
         /P21L19rESCvOY3jHZHYXp+/jHBl5ZTXbylJ5WWjnqvlQUe5phwwGOHBpRB4CxXRABc+
         BB4JAkRa7fmiiw7U5UVqeIZf1x4xqdUQsbpRx/LlHyXibeN7WPqr+r4vgSqNA32jvdpk
         Qg9OQi3PQSdAQKEEwkDG+B11X3eCrN/HrmO5szTELWzi4hTKOaA2y3OsAv+Gc9he35B6
         xHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syKeBHWe4HxWIQ5X+mPdFfW/TrjICdwgcKSYdntZoAw=;
        b=mYkaFk+tNNXE0vc82pkKYoApnIBXMPfDfS1sKh1pl7vXUkfim/Mah9UEh9wFwa6eK+
         MzTm9GLDtO5QFUt1ABEw1Q0+lgZtZjVI0ELIDCS+WyzQ9ADmFUYyuf5TV8w0GzBEnBRj
         Vx28UZ7st6Ps7qIh61xnGvphFnkoHPn6gUZxy5Qo824GvT93qombx5andv+WpLs1gf7/
         m3GIO8AOFI29NThUPS0ijaeUQsHDsbKaaJA87G++THyXr8/CMuoeapzyERHMryTDezNd
         dlSIOxMgkS5+Q4KHzBY1yA8mdRGARAwkdm5Nvh9C6ojJ7OqL5QNkum/yyZy6cwVgAnUp
         YvzA==
X-Gm-Message-State: APjAAAU4uLKswUttBgKlLn6QWiBiVyYGa1VKh0FqDKg7PPaY6a+ufwC8
        U65TyU1xbWyJwNUdfqRYvMrTUiKzZJ7z+98PsYvNmQ==
X-Google-Smtp-Source: APXvYqzD+DzF6FrOkbh/p0y3ZBjxdkdQ0V+WSD9FdLXrt8p7t7t7KrEHOcJatfDllO4ozZeULlWK4QKNTpGI3WGzp3Y=
X-Received: by 2002:ac8:ccf:: with SMTP id o15mr65616902qti.380.1575268843007;
 Sun, 01 Dec 2019 22:40:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000da160a0598b2c704@google.com>
In-Reply-To: <000000000000da160a0598b2c704@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Dec 2019 07:40:31 +0100
Message-ID: <CACT4Y+ZGx16qc8qtekP0Bx=syVQest8K_RVtEN084jnszx4qhA@mail.gmail.com>
Subject: Re: general protection fault in override_creds
To:     syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Anna.Schumaker@netapp.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 2, 2019 at 7:35 AM syzbot
<syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f9ffcee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
> dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com

I think this relates to fs/io_uring.c rather than kernel/cred.c.
+io_uring maintainers

> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9217 Comm: io_uring-sq Not tainted 5.4.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:creds_are_invalid kernel/cred.c:792 [inline]
> RIP: 0010:__validate_creds include/linux/cred.h:187 [inline]
> RIP: 0010:override_creds+0x9f/0x170 kernel/cred.c:550
> Code: ac 25 00 81 fb 64 65 73 43 0f 85 a3 37 00 00 e8 17 ab 25 00 49 8d 7c
> 24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84
> c0 74 08 3c 03 0f 8e 96 00 00 00 41 8b 5c 24 10 bf
> RSP: 0018:ffff88809c45fda0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000043736564 RCX: ffffffff814f3318
> RDX: 0000000000000002 RSI: ffffffff814f3329 RDI: 0000000000000010
> RBP: ffff88809c45fdb8 R08: ffff8880a3aac240 R09: ffffed1014755849
> R10: ffffed1014755848 R11: ffff8880a3aac247 R12: 0000000000000000
> R13: ffff888098ab1600 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd51c40664 CR3: 0000000092641000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   io_sq_thread+0x1c7/0xa20 fs/io_uring.c:3274
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Modules linked in:
> ---[ end trace f2e1a4307fbe2245 ]---
> RIP: 0010:creds_are_invalid kernel/cred.c:792 [inline]
> RIP: 0010:__validate_creds include/linux/cred.h:187 [inline]
> RIP: 0010:override_creds+0x9f/0x170 kernel/cred.c:550
> Code: ac 25 00 81 fb 64 65 73 43 0f 85 a3 37 00 00 e8 17 ab 25 00 49 8d 7c
> 24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84
> c0 74 08 3c 03 0f 8e 96 00 00 00 41 8b 5c 24 10 bf
> RSP: 0018:ffff88809c45fda0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000043736564 RCX: ffffffff814f3318
> RDX: 0000000000000002 RSI: ffffffff814f3329 RDI: 0000000000000010
> RBP: ffff88809c45fdb8 R08: ffff8880a3aac240 R09: ffffed1014755849
> R10: ffffed1014755848 R11: ffff8880a3aac247 R12: 0000000000000000
> R13: ffff888098ab1600 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd51c40664 CR3: 0000000092641000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000da160a0598b2c704%40google.com.
