Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A487485B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjGEOLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGEOLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208E1726;
        Wed,  5 Jul 2023 07:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102E261451;
        Wed,  5 Jul 2023 14:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A178DC433CA;
        Wed,  5 Jul 2023 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688566257;
        bh=5iGNb04ddzZJMynP9Ws7gYXu/VZvLag0Eg3xzRPytUc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tK83zM2uLv+vK01Bnsu9dFYjSvLhodEWAvPX24JOrtjj1sLEfmk7SAJkuV7CHclzf
         sAIGzKjQ9xyjN6itnS+RO1BDkUPUyziHJexN9FoDBXeco8c+/F0l/+cqoZ9p2NgilJ
         r0CMCLO1a3UUyW4t8JNcdRUSBjm1gavOpprkHLNfd3XA9x49aL6VGlT5X7XMdEAtwj
         ZxpX3UH6UcxI2IJN2PVEuc9TnUl36i2diynSglUZ9t8po3hdUJWdlte3VbNNzje29e
         44ssGoyre1q1SgMWurKLUBJC9A7x/mjpsRcKn9JZO55ZS1OoWpZaq+DetOyfbjAkH+
         mhLc4X7NOkGOQ==
Message-ID: <23a3b7a6c26f61d101ba71a83c6541c21d332da9.camel@kernel.org>
Subject: Re: [syzbot] [overlayfs?] general protection fault in d_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 05 Jul 2023 10:10:55 -0400
In-Reply-To: <CAOQ4uxgX15F-zAYp0CV2zRLnSx6+m3=ejW2k4q8FdZqri5h8ng@mail.gmail.com>
References: <0000000000004f34d705ffbc2604@google.com>
         <20230705-aufgearbeitet-kaffee-44ff4731a7dd@brauner>
         <f966d10e793a9e8e2edb22cf09c25f097e638df9.camel@kernel.org>
         <CAOQ4uxgX15F-zAYp0CV2zRLnSx6+m3=ejW2k4q8FdZqri5h8ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-07-05 at 16:54 +0300, Amir Goldstein wrote:
> On Wed, Jul 5, 2023 at 4:41=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Wed, 2023-07-05 at 15:05 +0200, Christian Brauner wrote:
> > > On Wed, Jul 05, 2023 at 05:00:45AM -0700, syzbot wrote:
> > > > Hello,
> > > >=20
> > > > syzbot found the following issue on:
> > > >=20
> > > > HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and=
 *.mbx"
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14fad00=
2a80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1085b42=
38c9eb6ba
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da67fc5321=
ffb4b311c98
> > > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils f=
or Debian) 2.35.2
> > > >=20
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >=20
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/fef94e7880=
67/disk-d5280145.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/576412ea518b/=
vmlinux-d5280145.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/685a0e4b=
e06b/bzImage-d5280145.xz
> > > >=20
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> > > >=20
> > > > general protection fault, probably for non-canonical address 0xdfff=
fc000000000a: 0000 [#1] PREEMPT SMP KASAN
> > > > KASAN: null-ptr-deref in range [0x0000000000000050-0x00000000000000=
57]
> > > > CPU: 1 PID: 10127 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-=
11478-gd528014517f2 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 05/27/2023
> > > > RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
> > > > Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0=
f 84 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c=
 00 00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
> > > > RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
> > > > RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
> > > > RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
> > > > RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
> > > > R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
> > > > R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
> > > > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
> > > >  seqcount_lockdep_reader_access+0x139/0x220 include/linux/seqlock.h=
:102
> > > >  get_fs_root_rcu fs/d_path.c:244 [inline]
> > > >  d_path+0x2f0/0x6e0 fs/d_path.c:286
> > > >  audit_log_d_path+0xd3/0x310 kernel/audit.c:2139
> > > >  dump_common_audit_data security/lsm_audit.c:224 [inline]
> > > >  common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
> > > >  smack_log+0x421/0x540 security/smack/smack_access.c:383
> > > >  smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
> > > >  smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1202
> > > >  security_inode_getattr+0xd3/0x120 security/security.c:2114
> > > >  vfs_getattr+0x25/0x70 fs/stat.c:167
> > > >  ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
> > > >  ima_check_last_writer security/integrity/ima/ima_main.c:171 [inlin=
e]
> > > >  ima_file_free+0x26e/0x4b0 security/integrity/ima/ima_main.c:203
> > >=20
> > > Ugh, I think the root of this might all be the call back into
> > > vfs_getattr() that happens on overlayfs:
> > >=20
> > > __fput()
> > > -> ima_file_free()
> > >    -> mutex_lock()
> > >    -> vfs_getattr_nosec()
> > >       -> i_op->getattr() =3D=3D ovl_getattr()
> > >          -> vfs_getattr()
> > >           -> security_inode_getattr()
> > >    -> mutex_unlock()
> > >=20
> > > So either overlayfs needs to call vfs_getattr_nosec() when the reques=
t
> > > comes from vfs_getattr_nosec() or this needs to use
> > > backing_file_real_path() to operate on the real underlying path.
> > >=20
> > > Thoughts?
> > >=20
> >=20
> > When you say "this needs to use backing_file_real_path()", what do you
> > mean by "this"? IMA?
> >=20
> > That said, passing some sort of NOSEC flag to vfs_getattr that
> > designates the call as kernel-internal seems like the more correct thin=
g
> > to do here, and might be useful in other weird stacking cases like this=
.
> >=20
>=20
> I don't think that NOSEC is the root cause.
>=20
> If you ever noticed file_dentry() sprinkled through fs code,
> it is only there because if that code were to call use helpers
> that rely on file_inode() and d_inode(file->f_path.dentry) being
> the same - bad things will happen and NOSEC will not cover
> all those bad things.
>=20
> IMA code also has file_dentry() sprinkled.
> But it still accesses file->f_path in a few places and that
> can result in bad things.
>=20

Ok, that makes sense, and is a lot less invasive than having to rework
vfs_getattr.
--=20
Jeff Layton <jlayton@kernel.org>
