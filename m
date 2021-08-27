Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9253F9BBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhH0Pbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 11:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234149AbhH0Pbg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:31:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4541360232;
        Fri, 27 Aug 2021 15:30:44 +0000 (UTC)
Date:   Fri, 27 Aug 2021 17:30:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] general protection fault in legacy_parse_param
Message-ID: <20210827153041.z3jundji5usj3afj@wittgenstein>
References: <0000000000004e5ec705c6318557@google.com>
 <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
 <d11c276d-65a0-5273-d797-1092e1e2692a@schaufler-ca.com>
 <CAHC9VhSq88YjA-VGSTKkc4hkc_KOK=mnoAYiX1us6O6U0gFzAQ@mail.gmail.com>
 <CACT4Y+bj4epytaY4hhEx5GF+Z2xcMnS4AEg=JcrTEnWvXWFuGQ@mail.gmail.com>
 <CAHC9VhQLi+1r3BmSeQre+EEtEyvhSmmT-ABLjvzk0J-J9v9URw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhQLi+1r3BmSeQre+EEtEyvhSmmT-ABLjvzk0J-J9v9URw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 06, 2021 at 08:50:44AM -0400, Paul Moore wrote:
> On Mon, Jul 5, 2021 at 1:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Sun, Jul 4, 2021 at 4:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Sat, Jul 3, 2021 at 6:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > On 7/2/2021 10:51 PM, Dmitry Vyukov wrote:
> > > > > On Sat, Jul 3, 2021 at 7:41 AM syzbot
> > > > > <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com> wrote:
> > > > >> Hello,
> > > > >>
> > > > >> syzbot found the following issue on:
> > > > >>
> > > > >> HEAD commit:    62fb9874 Linux 5.13
> > > > >> git tree:       upstream
> > > > >> console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
> > > > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
> > > > >> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
> > > > >> compiler:       Debian clang version 11.0.1-2
> > > > >>
> > > > >> Unfortunately, I don't have any reproducer for this issue yet.
> > > > >>
> > > > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > >> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > > > > +Casey for what looks like a smackfs issue
> > > >
> > > > This is from the new mount infrastructure introduced by
> > > > David Howells in November 2018. It makes sense that there
> > > > may be a problem in SELinux as well, as the code was introduced
> > > > by the same developer at the same time for the same purpose.
> > > >
> > > > > The crash was triggered by this test case:
> > > > >
> > > > > 21:55:33 executing program 1:
> > > > > r0 = fsopen(&(0x7f0000000040)='ext3\x00', 0x1)
> > > > > fsconfig$FSCONFIG_SET_STRING(r0, 0x1, &(0x7f00000002c0)='smackfsroot',
> > > > > &(0x7f0000000300)='default_permissions', 0x0)
> > > > >
> > > > > And I think the issue is in smack_fs_context_parse_param():
> > > > > https://elixir.bootlin.com/linux/latest/source/security/smack/smack_lsm.c#L691
> > > > >
> > > > > But it seems that selinux_fs_context_parse_param() contains the same issue:
> > > > > https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2919
> > > > > +So selinux maintainers as well.
> > > > >
> > > > >> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > > > >> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > > >> CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
> > > > >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > >> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
> > > > >> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
> > > > >> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
> > > > >> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
> > > > >> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
> > > > >> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
> > > > >> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
> > > > >> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
> > > > >> FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > > >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > >> CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
> > > > >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > >> Call Trace:
> > > > >>  legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
> > > > >>  vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
> > >
> > > It's Sunday morning and perhaps my mind is not yet in a "hey, let's
> > > look at VFS kernel code!" mindset, but I'm not convinced the problem
> > > is the 'param->string = NULL' assignment in the LSM hooks.  In both
> > > the case of SELinux and Smack that code ends up returning either a 0
> > > (Smack) or a 1 (SELinux) - that's a little odd in it's own way, but I
> > > don't believe it is relevant here - either way these return values are
> > > not equal to -ENOPARAM so we should end up returning early from
> > > vfs_parse_fs_param before it calls down into legacy_parse_param():
> > >
> > > Taken from https://elixir.bootlin.com/linux/latest/source/fs/fs_context.c#L109 :
> > >
> > >   ret = security_fs_context_parse_param(fc, param);
> > >   if (ret != -ENOPARAM)
> > >     /* Param belongs to the LSM or is disallowed by the LSM; so
> > >      * don't pass to the FS.
> > >      */
> > >     return ret;
> > >
> > >   if (fc->ops->parse_param) {
> > >     ret = fc->ops->parse_param(fc, param);
> > >     if (ret != -ENOPARAM)
> > >       return ret;
> > >   }
> >
> > Hi Paul,
> >
> > You are right.
> > I almost connected the dots, but not exactly.
> > Now that I read more code around, setting "param->string = NULL" in
> > smack_fs_context_parse_param() looks correct to me (the fs copies and
> > takes ownership of the string).
> >
> > I don't see how the crash happened...
> 
> FWIW, I poked around a bit too and couldn't see anything obvious
> either, but I can't pretend to know as much about the VFS layer as the
> VFS folks.  Hopefully they might have better luck.

I'm not sure that's right.
If the smack hook runs first, it will set

param->string = NULL

now the selinux hook runs. But the selinux param hook doesn't end up in
selinux_add_opt() instead it will fail before
opt = fs_parse(fc, selinux_fs_parameters, param, &result);
which will return -ENOPARAM since it's not a selinux option subsequently
causing the crash.

Does that sound plausible?

Christian
