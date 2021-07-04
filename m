Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825553BAD58
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhGDORB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhGDOQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 10:16:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3A9C061574
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 07:14:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n25so20145171edw.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWUB7H3BCNRAb41AhtBYLajPiiUTO0WN0NPEqMgBCxc=;
        b=bu95bYt2cziitAFIVzzAxLWWp3Jlrg36qS1KZAQvj04w7fV0NnTM4etfMni69+NLCp
         qzESxN95dWclDHkSmLBp18cHQMiIm9PHgFWn0kJEuvViGbDKKlO/XwdtZ8+hqq388PCW
         AHgy9MVJ/8TrXAD3OWTTQtjykhlx0CZShNY7f6A7svueO/nNNom17U4CUPOPQbYv/xUo
         r9ob2JAjkRiiUddeO1H0KOSfLSbx09LMcbpt29Vb+udzg2/vwybkS9jXOHwnDzNB+9hd
         NOPFgV6uP0r5fThqZoGiAQUpggFvFDkQk9Omi1eBZslyWpHkzQM9hol2U7i7c2webaMQ
         HEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWUB7H3BCNRAb41AhtBYLajPiiUTO0WN0NPEqMgBCxc=;
        b=Vr3tTJbKQm3S0ljIy0C7sSu/OY9/wrvjZy8tSeb3bbKVFI+d/o6vwY1zONqrIRqcng
         f9kSyzw0WLqi/OQiQC6YVMT0KH6tsrDMyRTdWU0/lmcdxXhDXH9pd08EIwHSmKi6wkVI
         ZcCuKFtn6vHAai3O3qqOEU8mP/4196b9EIyQk69Zawe7DhZGja6Rbk9s+nxTC/Ws9PA2
         jPIZA6+3ZWz4vGVYAoEz58iUWW/NzP+SmBo7utPRctByQgieGlih44fwoGTOR308yqFS
         GQfGHRbHoXudoboGl3ogjyAuaF93ZtjPC1wuPpqkNPGNQxgPzOL4OD6i1VqrdG7xld4/
         l45w==
X-Gm-Message-State: AOAM530x/f9U8hS22cFJ8eSQUzbIqc/Fft73daz2pFtryCt3tTvnP0wZ
        FOQhD3Bgyfy5DmlDdmEbAyqsj7k8cQfbkcGxS3z7
X-Google-Smtp-Source: ABdhPJxS/tv9ZNncQiVJbYZ1lI2y7MX210R7yigYAvxj9PXgRTnOKTuiXnRbhnnJETWs34cQr5P4OuGPs/RyiaLnI7Q=
X-Received: by 2002:a05:6402:3581:: with SMTP id y1mr10714014edc.31.1625408060419;
 Sun, 04 Jul 2021 07:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004e5ec705c6318557@google.com> <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
 <d11c276d-65a0-5273-d797-1092e1e2692a@schaufler-ca.com>
In-Reply-To: <d11c276d-65a0-5273-d797-1092e1e2692a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 4 Jul 2021 10:14:09 -0400
Message-ID: <CAHC9VhSq88YjA-VGSTKkc4hkc_KOK=mnoAYiX1us6O6U0gFzAQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in legacy_parse_param
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 3, 2021 at 6:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/2/2021 10:51 PM, Dmitry Vyukov wrote:
> > On Sat, Jul 3, 2021 at 7:41 AM syzbot
> > <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    62fb9874 Linux 5.13
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
> >> compiler:       Debian clang version 11.0.1-2
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > +Casey for what looks like a smackfs issue
>
> This is from the new mount infrastructure introduced by
> David Howells in November 2018. It makes sense that there
> may be a problem in SELinux as well, as the code was introduced
> by the same developer at the same time for the same purpose.
>
> > The crash was triggered by this test case:
> >
> > 21:55:33 executing program 1:
> > r0 = fsopen(&(0x7f0000000040)='ext3\x00', 0x1)
> > fsconfig$FSCONFIG_SET_STRING(r0, 0x1, &(0x7f00000002c0)='smackfsroot',
> > &(0x7f0000000300)='default_permissions', 0x0)
> >
> > And I think the issue is in smack_fs_context_parse_param():
> > https://elixir.bootlin.com/linux/latest/source/security/smack/smack_lsm.c#L691
> >
> > But it seems that selinux_fs_context_parse_param() contains the same issue:
> > https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2919
> > +So selinux maintainers as well.
> >
> >> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> >> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> >> CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
> >> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
> >> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
> >> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
> >> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
> >> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
> >> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
> >> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
> >> FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
> >>  vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117

It's Sunday morning and perhaps my mind is not yet in a "hey, let's
look at VFS kernel code!" mindset, but I'm not convinced the problem
is the 'param->string = NULL' assignment in the LSM hooks.  In both
the case of SELinux and Smack that code ends up returning either a 0
(Smack) or a 1 (SELinux) - that's a little odd in it's own way, but I
don't believe it is relevant here - either way these return values are
not equal to -ENOPARAM so we should end up returning early from
vfs_parse_fs_param before it calls down into legacy_parse_param():

Taken from https://elixir.bootlin.com/linux/latest/source/fs/fs_context.c#L109 :

  ret = security_fs_context_parse_param(fc, param);
  if (ret != -ENOPARAM)
    /* Param belongs to the LSM or is disallowed by the LSM; so
     * don't pass to the FS.
     */
    return ret;

  if (fc->ops->parse_param) {
    ret = fc->ops->parse_param(fc, param);
    if (ret != -ENOPARAM)
      return ret;
  }

> >>  vfs_fsconfig_locked fs/fsopen.c:265 [inline]
> >>  __do_sys_fsconfig fs/fsopen.c:439 [inline]
> >>  __se_sys_fsconfig+0xba9/0xff0 fs/fsopen.c:314
> >>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
> >>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> RIP: 0033:0x4665d9
> >> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007fe01ae27188 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> >> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> >> RDX: 00000000200002c0 RSI: 0000000000000001 RDI: 0000000000000003
> >> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000020000300 R11: 0000000000000246 R12: 000000000056bf80
> >> R13: 00007ffd4bb7c5bf R14: 00007fe01ae27300 R15: 0000000000022000
> >> Modules linked in:
> >> ---[ end trace 5d7119165725bd63 ]---

-- 
paul moore
www.paul-moore.com
