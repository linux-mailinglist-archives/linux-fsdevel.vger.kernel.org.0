Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA87A9BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjIUTEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIUTEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B3E78;
        Thu, 21 Sep 2023 10:49:44 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ade101217bso782320b6e.0;
        Thu, 21 Sep 2023 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318583; x=1695923383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgErOgFgwIB3VwCWplXsojBWx1j8inMp/zhTB/tm4qs=;
        b=hq7w+clfiU0jbzSfOrlS7O8tgyC5/BMtLI/1woE+ytL7d7ICtMs6bxdoBPcUjeLXvO
         u20+oq9y3WmDxE4/4rp0d8EFahcNHeo9IBo/XlLrURQACQprBlvj++ad2O3FUotGi/HO
         lD5ZNOCE7MLDtIwm2SIkUJ1M//jI8u8SX/hNMOwurA0/iwmbe/9vcSMk6NT+AJmg6G8x
         FKFIddKnE3l6cvlnSa3XRtf2gTd+uHnbtiIuEqbpS5QU85lo5RBU2C6tHARcNur3TsKZ
         URQY/nfsurCgtdr3pzy4K8NTsXQNHUahUR/pZq2XnwczcGKLUk3gaDoBc1PPrkSa1llf
         F1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318583; x=1695923383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgErOgFgwIB3VwCWplXsojBWx1j8inMp/zhTB/tm4qs=;
        b=sB7koYWJy6ch7PhES4oFE73UVZNwtu0jGjN4NE75HnHJntDlKyaGcvhhd4xGnKZYjs
         dZ5qKk4kQIzk/cByd7ANLmylQMnuS5fzujkKPaAGSuzspa5yQ1LCzhxy9vwTyazD8sBT
         xmZjBk2IuvWVcJ09j9IXIZoP5QAvftMRuWP8dR8oSnpXSrdb8BbZRBKnmZ2NftpgGxLY
         oQXO8ecmjsObxlDm3FeqGEMlk+ERsOnnAqi38vDWeGxVzmSOzDMb8J/BrwdsqrxPULj3
         iy0txFCV4YqaCJ6P7mY1q/oqOJmGNxZa+9HvEZLRtIUTWVd7RyM3AcGIVx6wr2vp0Ll0
         YYUw==
X-Gm-Message-State: AOJu0YxRFOz2i9kWSVL09nW7DXMEFGlsiWvLh4HK5VRf6cXQv9Yn13IG
        b3PiknhRzNYuTaZVAXvZBn2PTytYnbY52TsJ3MGASJFl
X-Google-Smtp-Source: AGHT+IFhu9MnRqiv40HYNH1bCX0WIJFey5uSMvisrg5iUl0H+i6r0+DTw1qHwxCCoojZKHtpjorF3YDjDNgyFI+rvHI=
X-Received: by 2002:a0d:e68f:0:b0:59b:eb64:bcc5 with SMTP id
 p137-20020a0de68f000000b0059beb64bcc5mr5439383ywe.8.1695297826255; Thu, 21
 Sep 2023 05:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000259bd8060596e33f@google.com> <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com> <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com> <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com> <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
In-Reply-To: <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 15:03:34 +0300
Message-ID: <CAOQ4uxgp4PZqFkRmBBpyfL9zYokv_uUjgfbyjDLqWy_sLVmVnw@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in d_path
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 1:32=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-09-20 at 17:52 -0700, Casey Schaufler wrote:
> > On 9/20/2023 5:10 PM, Stefan Berger wrote:
> > >
> > > On 9/20/23 18:09, Stefan Berger wrote:
> > > >
> > > > On 9/20/23 17:16, Jeff Layton wrote:
> > > > > On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wrote:
> > > > > > On 9/20/23 13:01, Stefan Berger wrote:
> > > > > > > On 9/17/23 20:04, syzbot wrote:
> > > > > > > > syzbot has bisected this issue to:
> > > > > > > >
> > > > > > > > commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
> > > > > > > > Author: Jeff Layton <jlayton@kernel.org>
> > > > > > > > Date:   Mon Apr 17 16:55:51 2023 +0000
> > > > > > > >
> > > > > > > >       IMA: use vfs_getattr_nosec to get the i_version
> > > > > > > >
> > > > > > > > bisection log:
> > > > > > > > https://syzkaller.appspot.com/x/bisect.txt?x=3D106f7e546800=
00
> > > > > > > > start commit:   a747acc0b752 Merge tag
> > > > > > > > 'linux-kselftest-next-6.6-rc2'
> > > > > > > > of g..
> > > > > > > > git tree:       upstream
> > > > > > > > final oops:
> > > > > > > > https://syzkaller.appspot.com/x/report.txt?x=3D126f7e546800=
00
> > > > > > > > console output:
> > > > > > > > https://syzkaller.appspot.com/x/log.txt?x=3D146f7e54680000
> > > > > > > > kernel config:
> > > > > > > > https://syzkaller.appspot.com/x/.config?x=3Ddf91a3034fe3f12=
2
> > > > > > > > dashboard link:
> > > > > > > > https://syzkaller.appspot.com/bug?extid=3Da67fc5321ffb4b311=
c98
> > > > > > > > syz repro:
> > > > > > > > https://syzkaller.appspot.com/x/repro.syz?x=3D1671b69468000=
0
> > > > > > > > C reproducer:
> > > > > > > > https://syzkaller.appspot.com/x/repro.c?x=3D14ec94d8680000
> > > > > > > >
> > > > > > > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotm=
ail.com
> > > > > > > > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > > > > > > i_version")
> > > > > > > >
> > > > > > > > For information about bisection process see:
> > > > > > > > https://goo.gl/tpsmEJ#bisection
> > > > > > > The final oops shows this here:
> > > > > > >
> > > > > > > BUG: kernel NULL pointer dereference, address: 00000000000000=
58
> > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > PGD 0 P4D 0
> > > > > > > Oops: 0000 [#1] PREEMPT SMP
> > > > > > > CPU: 0 PID: 3192 Comm: syz-executor.0 Not tainted
> > > > > > > 6.4.0-rc2-syzkaller #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute En=
gine,
> > > > > > > BIOS Google 08/04/2023
> > > > > > > RIP: 0010:__lock_acquire+0x35/0x490 kernel/locking/lockdep.c:=
4946
> > > > > > > Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7 11 e4 02 00 0=
f 84 05
> > > > > > > 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe 01 77 0c 89 f=
0
> > > > > > > <49> 8b
> > > > > > > 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4 e8 74 f6 ff
> > > > > > > RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
> > > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000=
0002
> > > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000=
0050
> > > > > > > RBP: 0000000000000002 R08: 0000000000000001 R09: 000000000000=
0000
> > > > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000=
0000
> > > > > > > R13: 0000000000000000 R14: ffff888102ea5340 R15: 000000000000=
0050
> > > > > > > FS:  0000000000000000(0000) GS:ffff88813bc00000(0000)
> > > > > > > knlGS:0000000000000000
> > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > CR2: 0000000000000058 CR3: 0000000003aa8000 CR4: 000000000035=
06f0
> > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000
> > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000=
0400
> > > > > > > Call Trace:
> > > > > > >   <TASK>
> > > > > > >   lock_acquire+0xd8/0x1f0 kernel/locking/lockdep.c:5691
> > > > > > >   seqcount_lockdep_reader_access include/linux/seqlock.h:102 =
[inline]
> > > > > > >   get_fs_root_rcu fs/d_path.c:243 [inline]
> > > > > > >   d_path+0xd1/0x1f0 fs/d_path.c:285
> > > > > > >   audit_log_d_path+0x65/0x130 kernel/audit.c:2139
> > > > > > >   dump_common_audit_data security/lsm_audit.c:224 [inline]
> > > > > > >   common_lsm_audit+0x3b3/0x840 security/lsm_audit.c:458
> > > > > > >   smack_log+0xad/0x130 security/smack/smack_access.c:383
> > > > > > >   smk_tskacc+0xb1/0xd0 security/smack/smack_access.c:253
> > > > > > >   smack_inode_getattr+0x8a/0xb0 security/smack/smack_lsm.c:11=
87
> > > > > > >   security_inode_getattr+0x32/0x50 security/security.c:2114
> > > > > > >   vfs_getattr+0x1b/0x40 fs/stat.c:167
> > > > > > >   ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:173
> > > > > > >   ima_check_last_writer security/integrity/ima/ima_main.c:171
> > > > > > > [inline]
> > > > > > >   ima_file_free+0xbd/0x130 security/integrity/ima/ima_main.c:=
203
> > > > > > >   __fput+0xc7/0x220 fs/file_table.c:315
> > > > > > >   task_work_run+0x7d/0xa0 kernel/task_work.c:179
> > > > > > >   exit_task_work include/linux/task_work.h:38 [inline]
> > > > > > >   do_exit+0x2c7/0xa80 kernel/exit.c:871 <--------------------=
---
> > > > > > >   do_group_exit+0x85/0xa0 kernel/exit.c:1021
> > > > > > >   get_signal+0x73c/0x7f0 kernel/signal.c:2874
> > > > > > >   arch_do_signal_or_restart+0x89/0x290 arch/x86/kernel/signal=
.c:306
> > > > > > >   exit_to_user_mode_loop+0x61/0xb0 kernel/entry/common.c:168
> > > > > > >   exit_to_user_mode_prepare+0x64/0xb0 kernel/entry/common.c:2=
04
> > > > > > >   __syscall_exit_to_user_mode_work kernel/entry/common.c:286 =
[inline]
> > > > > > >   syscall_exit_to_user_mode+0x2b/0x1d0 kernel/entry/common.c:=
297
> > > > > > >   do_syscall_64+0x4d/0x90 arch/x86/entry/common.c:86
> > > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > > >
> > > > > > >
> > > > > > > do_exit has called exit_fs(tsk) [
> > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/kernel/exit.=
c#L867 ]
> > > > > > >
> > > > > > > exit_fs(tsk) has set tsk->fs =3D NULL [
> > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/fs_struct=
.c#L103
> > > > > > > ]
> > > > > > >
> > > > > > > I think this then bites in d_path() where it calls:
> > > > > > >
> > > > > > >      get_fs_root_rcu(current->fs, &root);   [
> > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/d_path.c#=
L285 ]
> > > > > > >
> > > > > > > current->fs is likely NULL here.
> > > > > > >
> > > > > > > If this was correct it would have nothing to do with the actu=
al
> > > > > > > patch,
> > > > > > > though, but rather with the fact that smack logs on process
> > > > > > > termination. I am not sure what the solution would be other t=
han
> > > > > > > testing for current->fs =3D=3D NULL in d_path before using it=
 and
> > > > > > > returning an error that is not normally returned or trying to
> > > > > > > intercept this case in smack.
> > > > > > I have now been able to recreate the syzbot issue with the test
> > > > > > program
> > > > > > and the issue is exactly the one described here, current->fs =
=3D=3D NULL.
> > > > > >
> > > > > Earlier in this thread, Amir had a diagnosis that IMA is
> > > > > inappropriately
> > > > > trying to use f_path directly instead of using the helpers that a=
re
> > > > > friendly for stacking filesystems.
> > > > >
> > > > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYyeQL-LbS5kQ7+C0d=
6sjzKqMDWAtZW8cAkPaed6=3DQ@mail.gmail.com/
> > > > >
> > > > >
> > > > > I'm not an IMA hacker so I'm not planning to roll a fix here. Per=
haps
> > > > > someone on the IMA team could try this approach?
> > > >
> > > >
> > > > I have applied this patch here from Amir now and it does NOT resolv=
e
> > > > the issue:
> > > >
> > > > https://lore.kernel.org/linux-integrity/296dae962a2a488bde682d3def0=
74db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55e87950d0cfa1d5=
eb0
> > > >
> > > >
> > >
> > > This seems to resolve the issue:
> > >
> > > diff --git a/security/smack/smack_access.c
> > > b/security/smack/smack_access.c
> > > index 585e5e35710b..57afcea1e39b 100644
> > > --- a/security/smack/smack_access.c
> > > +++ b/security/smack/smack_access.c
> > > @@ -347,6 +347,9 @@ void smack_log(char *subject_label, char
> > > *object_label, int request,
> > >         struct smack_audit_data *sad;
> > >         struct common_audit_data *a =3D &ad->a;
> > >
> > > +       if (current->flags & PF_EXITING)
> > > +               return;
> > > +
> >
> > Based on what I see here I can understand that this prevents the panic,
> > but it isn't so clear what changed that introduced the problem.
> >
> > >         /* check if we have to log the current event */
> > >         if (result < 0 && (log_policy & SMACK_AUDIT_DENIED) =3D=3D 0)
> > >                 return;
> > >
> > >
>
> Apparently, it's this patch:
>
>     db1d1e8b9867 IMA: use vfs_getattr_nosec to get the i_version
>
> At one time, IMA would reach directly into the inode to get the
> i_version and ctime. That was fine for certain filesystems, but with
> more recent changes it needs to go through ->getattr instead. Evidently,
> it's selecting the wrong inode to query when dealing with overlayfs and
> that's causing panics at times.
>

This is a partial story - one which I told and tried to solve with my patch=
.
It is true in some cases, but it wasn't the case in this reproducer.

Overlayfs keeps *two* files open, one for the ovl inode and one for
the 'real' inode in underlying fs.

IMA hooks can happen on either of these files.
fput of the ovl file will trigger fput of the real file.
My patch fixes IMA code that triggers on the real file,
which must use file_real_path() to get the path.
My patch really fixes a bug that was also introduced by your
patch, but it is not the bug that syzbot reported.

The syzbot reproducer is triggered on fput of the ovl file.
This is why my patch did not fix it.

> As to why the above patch helps, I'm not sure, but given that it doesn't
> seem to change which inode is being queried via getattr, it seems like
> this is probably papering over the real bug. That said, IMA and
> overlayfs are not really in my wheelhouse, so I could be very wrong
> here.

IMO, the solution is one of the two solutions that Christian proposed -
you had also proposed to propage the nosec context yourself
before I suggested my fix. I never said that it was wrong - just didn't
think it was the root cause for this regression, because there was
another bug under the lamppost.

Thanks,
Amir.
