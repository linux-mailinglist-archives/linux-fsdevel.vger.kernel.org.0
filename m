Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3D7A9A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjIUSfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIUSfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:35:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221EC7EA09;
        Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CC4C32797;
        Thu, 21 Sep 2023 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695292356;
        bh=m/+/D371jffaOA8o1LIPl89PMVOlUOOmU2SCvTrXif8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=knTld6Pi/jUz4xBO5sLOgt7MUoeiL5QtpHwvz+/hv6oCGG5yA1drqbx1tZAZcnZu/
         eFCEHryapcANCg1o7Aispz+4aziBUKBr8dGVoyrDyiN2Ct6sWVNJgGQglrLGutzwv+
         vCd+r3US8L+feHEp5tL4dVwZpcV13xE+u5b6ucEiqxZz0qoOJrh6SfJ/b8tyCokfKD
         fK1/l94Z9zKf5Yq6jDz6NouUU6Del5+6rnpS+Ar20lP5wqwxVCnWgB78N5XMeBPjrR
         EUh6MVd6La/VFix2EKM2rnYu9jiNfwhuWKNvIOhiekgazhuw0fW5KrCGGhoRe7PQww
         yw3imG1Rqhnag==
Message-ID: <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com
Date:   Thu, 21 Sep 2023 06:32:33 -0400
In-Reply-To: <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com>
References: <000000000000259bd8060596e33f@google.com>
         <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
         <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com>
         <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
         <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com>
         <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
         <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-20 at 17:52 -0700, Casey Schaufler wrote:
> On 9/20/2023 5:10 PM, Stefan Berger wrote:
> >=20
> > On 9/20/23 18:09, Stefan Berger wrote:
> > >=20
> > > On 9/20/23 17:16, Jeff Layton wrote:
> > > > On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wrote:
> > > > > On 9/20/23 13:01, Stefan Berger wrote:
> > > > > > On 9/17/23 20:04, syzbot wrote:
> > > > > > > syzbot has bisected this issue to:
> > > > > > >=20
> > > > > > > commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
> > > > > > > Author: Jeff Layton <jlayton@kernel.org>
> > > > > > > Date:=A0=A0 Mon Apr 17 16:55:51 2023 +0000
> > > > > > >=20
> > > > > > > =A0=A0=A0=A0=A0 IMA: use vfs_getattr_nosec to get the i_versi=
on
> > > > > > >=20
> > > > > > > bisection log:
> > > > > > > https://syzkaller.appspot.com/x/bisect.txt?x=3D106f7e54680000
> > > > > > > start commit:=A0=A0 a747acc0b752 Merge tag
> > > > > > > 'linux-kselftest-next-6.6-rc2'
> > > > > > > of g..
> > > > > > > git tree:=A0=A0=A0=A0=A0=A0 upstream
> > > > > > > final oops:
> > > > > > > https://syzkaller.appspot.com/x/report.txt?x=3D126f7e54680000
> > > > > > > console output:
> > > > > > > https://syzkaller.appspot.com/x/log.txt?x=3D146f7e54680000
> > > > > > > kernel config:
> > > > > > > https://syzkaller.appspot.com/x/.config?x=3Ddf91a3034fe3f122
> > > > > > > dashboard link:
> > > > > > > https://syzkaller.appspot.com/bug?extid=3Da67fc5321ffb4b311c9=
8
> > > > > > > syz repro:
> > > > > > > https://syzkaller.appspot.com/x/repro.syz?x=3D1671b694680000
> > > > > > > C reproducer:
> > > > > > > https://syzkaller.appspot.com/x/repro.c?x=3D14ec94d8680000
> > > > > > >=20
> > > > > > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmai=
l.com
> > > > > > > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > > > > > i_version")
> > > > > > >=20
> > > > > > > For information about bisection process see:
> > > > > > > https://goo.gl/tpsmEJ#bisection
> > > > > > The final oops shows this here:
> > > > > >=20
> > > > > > BUG: kernel NULL pointer dereference, address: 0000000000000058
> > > > > > #PF: supervisor read access in kernel mode
> > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > PGD 0 P4D 0
> > > > > > Oops: 0000 [#1] PREEMPT SMP
> > > > > > CPU: 0 PID: 3192 Comm: syz-executor.0 Not tainted
> > > > > > 6.4.0-rc2-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne,
> > > > > > BIOS Google 08/04/2023
> > > > > > RIP: 0010:__lock_acquire+0x35/0x490 kernel/locking/lockdep.c:49=
46
> > > > > > Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7 11 e4 02 00 0f =
84 05
> > > > > > 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe 01 77 0c 89 f0
> > > > > > <49> 8b
> > > > > > 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4 e8 74 f6 ff
> > > > > > RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
> > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000000=
02
> > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
50
> > > > > > RBP: 0000000000000002 R08: 0000000000000001 R09: 00000000000000=
00
> > > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000=
00
> > > > > > R13: 0000000000000000 R14: ffff888102ea5340 R15: 00000000000000=
50
> > > > > > FS:=A0 0000000000000000(0000) GS:ffff88813bc00000(0000)
> > > > > > knlGS:0000000000000000
> > > > > > CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000000000000058 CR3: 0000000003aa8000 CR4: 00000000003506=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > Call Trace:
> > > > > > =A0=A0<TASK>
> > > > > > =A0=A0lock_acquire+0xd8/0x1f0 kernel/locking/lockdep.c:5691
> > > > > > =A0=A0seqcount_lockdep_reader_access include/linux/seqlock.h:10=
2 [inline]
> > > > > > =A0=A0get_fs_root_rcu fs/d_path.c:243 [inline]
> > > > > > =A0=A0d_path+0xd1/0x1f0 fs/d_path.c:285
> > > > > > =A0=A0audit_log_d_path+0x65/0x130 kernel/audit.c:2139
> > > > > > =A0=A0dump_common_audit_data security/lsm_audit.c:224 [inline]
> > > > > > =A0=A0common_lsm_audit+0x3b3/0x840 security/lsm_audit.c:458
> > > > > > =A0=A0smack_log+0xad/0x130 security/smack/smack_access.c:383
> > > > > > =A0=A0smk_tskacc+0xb1/0xd0 security/smack/smack_access.c:253
> > > > > > =A0=A0smack_inode_getattr+0x8a/0xb0 security/smack/smack_lsm.c:=
1187
> > > > > > =A0=A0security_inode_getattr+0x32/0x50 security/security.c:2114
> > > > > > =A0=A0vfs_getattr+0x1b/0x40 fs/stat.c:167
> > > > > > =A0=A0ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:173
> > > > > > =A0=A0ima_check_last_writer security/integrity/ima/ima_main.c:1=
71
> > > > > > [inline]
> > > > > > =A0=A0ima_file_free+0xbd/0x130 security/integrity/ima/ima_main.=
c:203
> > > > > > =A0=A0__fput+0xc7/0x220 fs/file_table.c:315
> > > > > > =A0=A0task_work_run+0x7d/0xa0 kernel/task_work.c:179
> > > > > > =A0=A0exit_task_work include/linux/task_work.h:38 [inline]
> > > > > > =A0=A0do_exit+0x2c7/0xa80 kernel/exit.c:871 <------------------=
-----
> > > > > > =A0=A0do_group_exit+0x85/0xa0 kernel/exit.c:1021
> > > > > > =A0=A0get_signal+0x73c/0x7f0 kernel/signal.c:2874
> > > > > > =A0=A0arch_do_signal_or_restart+0x89/0x290 arch/x86/kernel/sign=
al.c:306
> > > > > > =A0=A0exit_to_user_mode_loop+0x61/0xb0 kernel/entry/common.c:16=
8
> > > > > > =A0=A0exit_to_user_mode_prepare+0x64/0xb0 kernel/entry/common.c=
:204
> > > > > > =A0=A0__syscall_exit_to_user_mode_work kernel/entry/common.c:28=
6 [inline]
> > > > > > =A0=A0syscall_exit_to_user_mode+0x2b/0x1d0 kernel/entry/common.=
c:297
> > > > > > =A0=A0do_syscall_64+0x4d/0x90 arch/x86/entry/common.c:86
> > > > > > =A0=A0entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > >=20
> > > > > >=20
> > > > > > do_exit has called exit_fs(tsk) [
> > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/kernel/exit.c#=
L867 ]
> > > > > >=20
> > > > > > exit_fs(tsk) has set tsk->fs =3D NULL [
> > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/fs_struct.c=
#L103
> > > > > > ]
> > > > > >=20
> > > > > > I think this then bites in d_path() where it calls:
> > > > > >=20
> > > > > > =A0=A0=A0=A0 get_fs_root_rcu(current->fs, &root);=A0=A0 [
> > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/d_path.c#L2=
85 ]
> > > > > >=20
> > > > > > current->fs is likely NULL here.
> > > > > >=20
> > > > > > If this was correct it would have nothing to do with the actual
> > > > > > patch,
> > > > > > though, but rather with the fact that smack logs on process
> > > > > > termination. I am not sure what the solution would be other tha=
n
> > > > > > testing for current->fs =3D=3D NULL in d_path before using it a=
nd
> > > > > > returning an error that is not normally returned or trying to
> > > > > > intercept this case in smack.
> > > > > I have now been able to recreate the syzbot issue with the test
> > > > > program
> > > > > and the issue is exactly the one described here, current->fs =3D=
=3D NULL.
> > > > >=20
> > > > Earlier in this thread, Amir had a diagnosis that IMA is
> > > > inappropriately
> > > > trying to use f_path directly instead of using the helpers that are
> > > > friendly for stacking filesystems.
> > > >=20
> > > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYyeQL-LbS5kQ7+C0d6s=
jzKqMDWAtZW8cAkPaed6=3DQ@mail.gmail.com/
> > > >=20
> > > >=20
> > > > I'm not an IMA hacker so I'm not planning to roll a fix here. Perha=
ps
> > > > someone on the IMA team could try this approach?
> > >=20
> > >=20
> > > I have applied this patch here from Amir now and it does NOT resolve
> > > the issue:
> > >=20
> > > https://lore.kernel.org/linux-integrity/296dae962a2a488bde682d3def074=
db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55e87950d0cfa1d5eb=
0
> > >=20
> > >=20
> >=20
> > This seems to resolve the issue:
> >=20
> > diff --git a/security/smack/smack_access.c
> > b/security/smack/smack_access.c
> > index 585e5e35710b..57afcea1e39b 100644
> > --- a/security/smack/smack_access.c
> > +++ b/security/smack/smack_access.c
> > @@ -347,6 +347,9 @@ void smack_log(char *subject_label, char
> > *object_label, int request,
> > =A0=A0=A0=A0=A0=A0=A0 struct smack_audit_data *sad;
> > =A0=A0=A0=A0=A0=A0=A0 struct common_audit_data *a =3D &ad->a;
> >=20
> > +=A0=A0=A0=A0=A0=A0 if (current->flags & PF_EXITING)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > +
>=20
> Based on what I see here I can understand that this prevents the panic,
> but it isn't so clear what changed that introduced the problem.
>=20
> > =A0=A0=A0=A0=A0=A0=A0 /* check if we have to log the current event */
> > =A0=A0=A0=A0=A0=A0=A0 if (result < 0 && (log_policy & SMACK_AUDIT_DENIE=
D) =3D=3D 0)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >=20
> >=20

Apparently, it's this patch:

    db1d1e8b9867 IMA: use vfs_getattr_nosec to get the i_version

At one time, IMA would reach directly into the inode to get the
i_version and ctime. That was fine for certain filesystems, but with
more recent changes it needs to go through ->getattr instead. Evidently,
it's selecting the wrong inode to query when dealing with overlayfs and
that's causing panics at times.

As to why the above patch helps, I'm not sure, but given that it doesn't
seem to change which inode is being queried via getattr, it seems like
this is probably papering over the real bug. That said, IMA and
overlayfs are not really in my wheelhouse, so I could be very wrong
here.
--=20
Jeff Layton <jlayton@kernel.org>
