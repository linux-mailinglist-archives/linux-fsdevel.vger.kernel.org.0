Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5807A9969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIUSOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIUSNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C17686800;
        Thu, 21 Sep 2023 10:37:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88589C4E75E;
        Thu, 21 Sep 2023 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695309016;
        bh=yOPJ4TOv+C/reGbjSkc1/R1J3JBxmpTD949IMXlswNg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e6K74SkT+A04kLOCmqGzfej2ZVobUIkXLRcE3PXjxnuh6ZtNlgq23MrxeDHre/tio
         B/LzQ14tWZUSVrjsRmk2z4fnHXvI3veBTG6fe1AClj2azSS5oRFMvZqMvevBa+nK4W
         tAB9EK/uUCzwyTtLfqF9m67NJ7XCQWFnAMBnzAABtF7/48dwlFsSpovc2BEpfqj8dz
         Rk0jItrftz9Wmcc6pgA+paGsNI4ZLhfnRhAHesCjm4GaaVenfhLFP5XR7kHnv1HIMm
         hQVE7UD7DOw3XuoxfscVcO/3fP6sLuo+aBJSrSfRLD3EcgY1PDyW2WuLp7xpHqKVmL
         TFJM18nLHOzBA==
Message-ID: <028eefb0207e8cb163617ef28b8104e98d00ca2e.camel@kernel.org>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 21 Sep 2023 11:10:14 -0400
In-Reply-To: <7ef00ceb49abbb29c49a39287a7c3f28e00cf82a.camel@linux.ibm.com>
References: <000000000000259bd8060596e33f@google.com>
         <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
         <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com>
         <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
         <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com>
         <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
         <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com>
         <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
         <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
         <20230921-gedanken-salzwasser-40d25b921162@brauner>
         <7ef00ceb49abbb29c49a39287a7c3f28e00cf82a.camel@linux.ibm.com>
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

On Thu, 2023-09-21 at 10:52 -0400, Mimi Zohar wrote:
> On Thu, 2023-09-21 at 13:48 +0200, Christian Brauner wrote:
> > On Thu, Sep 21, 2023 at 07:24:23AM -0400, Mimi Zohar wrote:
> > > On Thu, 2023-09-21 at 06:32 -0400, Jeff Layton wrote:
> > > > On Wed, 2023-09-20 at 17:52 -0700, Casey Schaufler wrote:
> > > > > On 9/20/2023 5:10 PM, Stefan Berger wrote:
> > > > > >=20
> > > > > > On 9/20/23 18:09, Stefan Berger wrote:
> > > > > > >=20
> > > > > > > On 9/20/23 17:16, Jeff Layton wrote:
> > > > > > > > On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wrote:
> > > > > > > > > On 9/20/23 13:01, Stefan Berger wrote:
> > > > > > > > > > On 9/17/23 20:04, syzbot wrote:
> > > > > > > > > > > syzbot has bisected this issue to:
> > > > > > > > > > >=20
> > > > > > > > > > > commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
> > > > > > > > > > > Author: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > Date:   Mon Apr 17 16:55:51 2023 +0000
> > > > > > > > > > >=20
> > > > > > > > > > >       IMA: use vfs_getattr_nosec to get the i_version
> > > > > > > > > > >=20
> > > > > > > > > > > bisection log:
> > > > > > > > > > > https://syzkaller.appspot.com/x/bisect.txt?x=3D106f7e=
54680000
> > > > > > > > > > > start commit:   a747acc0b752 Merge tag
> > > > > > > > > > > 'linux-kselftest-next-6.6-rc2'
> > > > > > > > > > > of g..
> > > > > > > > > > > git tree:       upstream
> > > > > > > > > > > final oops:
> > > > > > > > > > > https://syzkaller.appspot.com/x/report.txt?x=3D126f7e=
54680000
> > > > > > > > > > > console output:
> > > > > > > > > > > https://syzkaller.appspot.com/x/log.txt?x=3D146f7e546=
80000
> > > > > > > > > > > kernel config:
> > > > > > > > > > > https://syzkaller.appspot.com/x/.config?x=3Ddf91a3034=
fe3f122
> > > > > > > > > > > dashboard link:
> > > > > > > > > > > https://syzkaller.appspot.com/bug?extid=3Da67fc5321ff=
b4b311c98
> > > > > > > > > > > syz repro:
> > > > > > > > > > > https://syzkaller.appspot.com/x/repro.syz?x=3D1671b69=
4680000
> > > > > > > > > > > C reproducer:
> > > > > > > > > > > https://syzkaller.appspot.com/x/repro.c?x=3D14ec94d86=
80000
> > > > > > > > > > >=20
> > > > > > > > > > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.ap=
pspotmail.com
> > > > > > > > > > > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to g=
et the
> > > > > > > > > > > i_version")
> > > > > > > > > > >=20
> > > > > > > > > > > For information about bisection process see:
> > > > > > > > > > > https://goo.gl/tpsmEJ#bisection
> > > > > > > > > > The final oops shows this here:
> > > > > > > > > >=20
> > > > > > > > > > BUG: kernel NULL pointer dereference, address: 00000000=
00000058
> > > > > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > > > > PGD 0 P4D 0
> > > > > > > > > > Oops: 0000 [#1] PREEMPT SMP
> > > > > > > > > > CPU: 0 PID: 3192 Comm: syz-executor.0 Not tainted
> > > > > > > > > > 6.4.0-rc2-syzkaller #0
> > > > > > > > > > Hardware name: Google Google Compute Engine/Google Comp=
ute Engine,
> > > > > > > > > > BIOS Google 08/04/2023
> > > > > > > > > > RIP: 0010:__lock_acquire+0x35/0x490 kernel/locking/lock=
dep.c:4946
> > > > > > > > > > Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7 11 e4 0=
2 00 0f 84 05
> > > > > > > > > > 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe 01 77 0=
c 89 f0
> > > > > > > > > > <49> 8b
> > > > > > > > > > 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4 e8 74 f=
6 ff
> > > > > > > > > > RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
> > > > > > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000=
0000000002
> > > > > > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000050
> > > > > > > > > > RBP: 0000000000000002 R08: 0000000000000001 R09: 000000=
0000000000
> > > > > > > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 000000=
0000000000
> > > > > > > > > > R13: 0000000000000000 R14: ffff888102ea5340 R15: 000000=
0000000050
> > > > > > > > > > FS:  0000000000000000(0000) GS:ffff88813bc00000(0000)
> > > > > > > > > > knlGS:0000000000000000
> > > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > > CR2: 0000000000000058 CR3: 0000000003aa8000 CR4: 000000=
00003506f0
> > > > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> > > > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> > > > > > > > > > Call Trace:
> > > > > > > > > >   <TASK>
> > > > > > > > > >   lock_acquire+0xd8/0x1f0 kernel/locking/lockdep.c:5691
> > > > > > > > > >   seqcount_lockdep_reader_access include/linux/seqlock.=
h:102 [inline]
> > > > > > > > > >   get_fs_root_rcu fs/d_path.c:243 [inline]
> > > > > > > > > >   d_path+0xd1/0x1f0 fs/d_path.c:285
> > > > > > > > > >   audit_log_d_path+0x65/0x130 kernel/audit.c:2139
> > > > > > > > > >   dump_common_audit_data security/lsm_audit.c:224 [inli=
ne]
> > > > > > > > > >   common_lsm_audit+0x3b3/0x840 security/lsm_audit.c:458
> > > > > > > > > >   smack_log+0xad/0x130 security/smack/smack_access.c:38=
3
> > > > > > > > > >   smk_tskacc+0xb1/0xd0 security/smack/smack_access.c:25=
3
> > > > > > > > > >   smack_inode_getattr+0x8a/0xb0 security/smack/smack_ls=
m.c:1187
> > > > > > > > > >   security_inode_getattr+0x32/0x50 security/security.c:=
2114
> > > > > > > > > >   vfs_getattr+0x1b/0x40 fs/stat.c:167
> > > > > > > > > >   ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:173
> > > > > > > > > >   ima_check_last_writer security/integrity/ima/ima_main=
.c:171
> > > > > > > > > > [inline]
> > > > > > > > > >   ima_file_free+0xbd/0x130 security/integrity/ima/ima_m=
ain.c:203
> > > > > > > > > >   __fput+0xc7/0x220 fs/file_table.c:315
> > > > > > > > > >   task_work_run+0x7d/0xa0 kernel/task_work.c:179
> > > > > > > > > >   exit_task_work include/linux/task_work.h:38 [inline]
> > > > > > > > > >   do_exit+0x2c7/0xa80 kernel/exit.c:871 <--------------=
---------
> > > > > > > > > >   do_group_exit+0x85/0xa0 kernel/exit.c:1021
> > > > > > > > > >   get_signal+0x73c/0x7f0 kernel/signal.c:2874
> > > > > > > > > >   arch_do_signal_or_restart+0x89/0x290 arch/x86/kernel/=
signal.c:306
> > > > > > > > > >   exit_to_user_mode_loop+0x61/0xb0 kernel/entry/common.=
c:168
> > > > > > > > > >   exit_to_user_mode_prepare+0x64/0xb0 kernel/entry/comm=
on.c:204
> > > > > > > > > >   __syscall_exit_to_user_mode_work kernel/entry/common.=
c:286 [inline]
> > > > > > > > > >   syscall_exit_to_user_mode+0x2b/0x1d0 kernel/entry/com=
mon.c:297
> > > > > > > > > >   do_syscall_64+0x4d/0x90 arch/x86/entry/common.c:86
> > > > > > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > do_exit has called exit_fs(tsk) [
> > > > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/kernel=
/exit.c#L867 ]
> > > > > > > > > >=20
> > > > > > > > > > exit_fs(tsk) has set tsk->fs =3D NULL [
> > > > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/fs_=
struct.c#L103
> > > > > > > > > > ]
> > > > > > > > > >=20
> > > > > > > > > > I think this then bites in d_path() where it calls:
> > > > > > > > > >=20
> > > > > > > > > >      get_fs_root_rcu(current->fs, &root);   [
> > > > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/d_p=
ath.c#L285 ]
> > > > > > > > > >=20
> > > > > > > > > > current->fs is likely NULL here.
> > > > > > > > > >=20
> > > > > > > > > > If this was correct it would have nothing to do with th=
e actual
> > > > > > > > > > patch,
> > > > > > > > > > though, but rather with the fact that smack logs on pro=
cess
> > > > > > > > > > termination. I am not sure what the solution would be o=
ther than
> > > > > > > > > > testing for current->fs =3D=3D NULL in d_path before us=
ing it and
> > > > > > > > > > returning an error that is not normally returned or try=
ing to
> > > > > > > > > > intercept this case in smack.
> > > > > > > > > I have now been able to recreate the syzbot issue with th=
e test
> > > > > > > > > program
> > > > > > > > > and the issue is exactly the one described here, current-=
>fs =3D=3D NULL.
> > > > > > > > >=20
> > > > > > > > Earlier in this thread, Amir had a diagnosis that IMA is
> > > > > > > > inappropriately
> > > > > > > > trying to use f_path directly instead of using the helpers =
that are
> > > > > > > > friendly for stacking filesystems.
> > > > > > > >=20
> > > > > > > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYyeQL-LbS5k=
Q7+C0d6sjzKqMDWAtZW8cAkPaed6=3DQ@mail.gmail.com/
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I'm not an IMA hacker so I'm not planning to roll a fix her=
e. Perhaps
> > > > > > > > someone on the IMA team could try this approach?
> > > > > > >=20
> > > > > > >=20
> > > > > > > I have applied this patch here from Amir now and it does NOT =
resolve
> > > > > > > the issue:
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-integrity/296dae962a2a488bde682=
d3def074db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55e87950d0=
cfa1d5eb0
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > > > This seems to resolve the issue:
> > > > > >=20
> > > > > > diff --git a/security/smack/smack_access.c
> > > > > > b/security/smack/smack_access.c
> > > > > > index 585e5e35710b..57afcea1e39b 100644
> > > > > > --- a/security/smack/smack_access.c
> > > > > > +++ b/security/smack/smack_access.c
> > > > > > @@ -347,6 +347,9 @@ void smack_log(char *subject_label, char
> > > > > > *object_label, int request,
> > > > > >         struct smack_audit_data *sad;
> > > > > >         struct common_audit_data *a =3D &ad->a;
> > > > > >=20
> > > > > > +       if (current->flags & PF_EXITING)
> > > > > > +               return;
> > > > > > +
> > > > >=20
> > > > > Based on what I see here I can understand that this prevents the =
panic,
> > > > > but it isn't so clear what changed that introduced the problem.
> > > > >=20
> > > > > >         /* check if we have to log the current event */
> > > > > >         if (result < 0 && (log_policy & SMACK_AUDIT_DENIED) =3D=
=3D 0)
> > > > > >                 return;
> > > > > >=20
> > > > > >=20
> > > >=20
> > > > Apparently, it's this patch:
> > > >=20
> > > >     db1d1e8b9867 IMA: use vfs_getattr_nosec to get the i_version
> > >=20
> > > Yes, the syzbot was updated with that info.
> > >=20
> > > > At one time, IMA would reach directly into the inode to get the
> > > > i_version and ctime. That was fine for certain filesystems, but wit=
h
> > > > more recent changes it needs to go through ->getattr instead. Evide=
ntly,
> > > > it's selecting the wrong inode to query when dealing with overlayfs=
 and
> > > > that's causing panics at times.
> > > >=20
> > > > As to why the above patch helps, I'm not sure, but given that it do=
esn't
> > > > seem to change which inode is being queried via getattr, it seems l=
ike
> > > > this is probably papering over the real bug. That said, IMA and
> > > > overlayfs are not really in my wheelhouse, so I could be very wrong
> > > > here.
> > >=20
> > > The call to vfs_getattr_nosec() somehow triggers a call to
> > > security_inode_getattr().  Without the call neither ovl_getattr() nor
> > > smack_inode_getattr() would be called.
> >=20
> > ima_file_free()
> > -> ima_check_last_writer()
> >    -> vfs_getattr_nosec()
> >       -> i_op->getattr() =3D=3D ovl_getattr()
> >          -> vfs_getattr()
> >             -> security_inode_getattr()
> > 	    -> real_i_op->getattr()
> >=20
> > is the callchain that triggers this.
>=20
> Thank you for the explanation as to why ovl_getattr() and subsequently
> smack_inode_getattr() is being called.
>=20
> >=20
> > ima_file_free() is called in a very sensitive location: __fput() that
> > can be called from task work when the process is already PF_EXITING.
> >=20
> > The ideal solution would be for ima to stop calling back into the
> > filesystems in this location at all but that's probably not going to
> > happen because I now realize you also set extended attributes from
> > __fput():
> >=20
> >=20
> > ima_check_last_writer()
> > -> ima_update_xatt()
> >    -> ima_fix_xattr()
> >       -> __vfs_setxattr_noperm()
> >=20
> > The __vfs_setxattr_noperm() codepath can itself trigger
> > security_inode_post_setxattr() and security_inode_setsecurity(). So
> > those hooks are hopefully safe to be called with PF_EXITING tasks as
> > well...
> >=20
> > Imho, this is all very wild but I'm not judging.
>=20
> Measuring and verifying immutable files is straight forward.=20
> Measuring, verifiying, and updating mutable file hashes is a lot more
> complicated.  Re-calculating the file hash everytime the file changes
> would impact performance.  The file hash is currently updated as the
> last writer closes the file (__fput).  One of the reasons for the wq
> was for IMA to safely calculate the file hash and and take the i_mutex
> to write the xattr.
>=20
> IMA support for mutable files makes IMA a lot more complicated.  Any
> improvement suggestions would be appreciated.
>=20
> >=20
> > Two solutions imho:
> > (1) teach stacking filesystems like overlayfs and ecryptfs to use
> >     vfs_getattr_nosec() in their ->getattr() implementation when they
> >     are themselves called via vfs_getattr_nosec(). This will fix this b=
y
> >     not triggering another LSM hook.
> > (2) make all ->getattr() LSM hooks PF_EXITING safe ideally don't do
> >     anything
>=20
> The original problem was detecting i_version change on overlayfs.
>=20
> Amir's proposed patch might resolve it without commit db1d1e8b9867
> ("IMA: use vfs_getattr_nosec to get the i_version").  However, as Amir
> said, it does not address the new problem introduced by it.   Assuming
> Amir's proposed patch resolves the original problem, an alternative
> solution would be to revert commit db1d1e8b9867.
>=20

If you're going to revert that commit, then I'm wondering what you
intend to do instead. Reaching directly into the inode to get this
information is really no bueno.
--=20
Jeff Layton <jlayton@kernel.org>
