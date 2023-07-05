Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770074852D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGENjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGENjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:39:24 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2003BA;
        Wed,  5 Jul 2023 06:39:22 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-445046c7f12so413173137.0;
        Wed, 05 Jul 2023 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688564362; x=1691156362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykccF1p4HFFtQC8JWpMl/kD+lzV51nuPgYjt2y0juQg=;
        b=ska9EAjpu10VzQuM8n30GfNjcOoDCsExcwjkSgE5SgmrzrTPSLrQnZC7zBqknoeQES
         dQaDsgTyi1pCgecOtNP2Q0LGpCVcCgZEapUYg1RFEGiJBETRXElOamkT52YFBomvnWXQ
         qQPO46taQQdwFQlqTXWN6FIg6A9gGkT9lpFaH7iXJbvlvi8X16Mho9lxtcCE+aiKZ2ho
         kH/w8xHQSIFo4c2M+vchHXqO8diplALxnA8C7w0exllWLQ86glkZ/O2/xYSPzUMq7CtK
         ILgQ6qvBbu3gVPTm0zLO2jhsE2JM7JdB7H4tYS24jQVQezeyrQE5EcNQjx6s/G9nFEND
         1QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564362; x=1691156362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykccF1p4HFFtQC8JWpMl/kD+lzV51nuPgYjt2y0juQg=;
        b=G2IKoQH9Qnlvu+BCz4Z2YCXyY2XGbuqdPmCzDaZj3fUIHZDrIzprgnebTJk9AJM6s7
         yCfRV1lqPrUAcnZqIq5ZSFphiQ17rEmSB0T0/lw37TWY6xi2f84zT1wYRGvhAqTOSAAs
         2QVI1ysqfuajEm+zmmGxgrumyrnuo3l7F/ev7kyPaNG7eg2JkPszgJmJi6U0+fm4S4/8
         2fkVl/25YPB0wk3/hEttPmx/M/Se+aHjeykcy+4keMdDvxuazdvuSGognZBxOh1XU0hd
         x3egP5RByvHaf4Wth72B38mEdTPI1Qc1rFLfx9U7b+ukbxRopHmWdBQ2EsHBeWMSEs96
         srWQ==
X-Gm-Message-State: ABy/qLZeCDLrZn+EjahYFs7tCopENyVM6U4RYwbXf5zSsHvePviRE9U2
        txUD2PuTTIGsJ5DTVlIi9bNwslJ3NJNT/dYTeRE=
X-Google-Smtp-Source: APBJJlGxDJ3T8gUTM1C/SI34dPMB/Hh47FuszbvTJVOgIelYkTVQ6V/mUiUFAOgmncahGcpWX0KnLjXQ+X39Lq72X9Y=
X-Received: by 2002:a67:e3ba:0:b0:444:c36:1b24 with SMTP id
 j26-20020a67e3ba000000b004440c361b24mr5020350vsm.11.1688564361984; Wed, 05
 Jul 2023 06:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f34d705ffbc2604@google.com> <20230705-aufgearbeitet-kaffee-44ff4731a7dd@brauner>
In-Reply-To: <20230705-aufgearbeitet-kaffee-44ff4731a7dd@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 Jul 2023 16:39:10 +0300
Message-ID: <CAOQ4uxgjnYyeQL-LbS5kQ7+C0d6sjzKqMDWAtZW8cAkPaed6=Q@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in d_path
To:     Christian Brauner <brauner@kernel.org>
Cc:     syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 5, 2023 at 4:06=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Jul 05, 2023 at 05:00:45AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.m=
bx"
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14fad002a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1085b4238c9=
eb6ba
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da67fc5321ffb4=
b311c98
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/fef94e788067/d=
isk-d5280145.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/576412ea518b/vmli=
nux-d5280145.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/685a0e4be06b=
/bzImage-d5280145.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> >
> > general protection fault, probably for non-canonical address 0xdffffc00=
0000000a: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
> > CPU: 1 PID: 10127 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-1147=
8-gd528014517f2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/27/2023
> > RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
> > Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84=
 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 =
00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
> > RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
> > RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
> > RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
> > RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
> > R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
> > R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
> > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
> >  seqcount_lockdep_reader_access+0x139/0x220 include/linux/seqlock.h:102
> >  get_fs_root_rcu fs/d_path.c:244 [inline]
> >  d_path+0x2f0/0x6e0 fs/d_path.c:286
> >  audit_log_d_path+0xd3/0x310 kernel/audit.c:2139
> >  dump_common_audit_data security/lsm_audit.c:224 [inline]
> >  common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
> >  smack_log+0x421/0x540 security/smack/smack_access.c:383
> >  smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
> >  smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1202
> >  security_inode_getattr+0xd3/0x120 security/security.c:2114
> >  vfs_getattr+0x25/0x70 fs/stat.c:167
> >  ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
> >  ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
> >  ima_file_free+0x26e/0x4b0 security/integrity/ima/ima_main.c:203
>
> Ugh, I think the root of this might all be the call back into
> vfs_getattr() that happens on overlayfs:
>
> __fput()
> -> ima_file_free()
>    -> mutex_lock()
>    -> vfs_getattr_nosec()
>       -> i_op->getattr() =3D=3D ovl_getattr()
>          -> vfs_getattr()
>             -> security_inode_getattr()
>    -> mutex_unlock()
>
> So either overlayfs needs to call vfs_getattr_nosec() when the request
> comes from vfs_getattr_nosec() or this needs to use
> backing_file_real_path() to operate on the real underlying path.
>
> Thoughts?

The latter.

IMA code cannot operate on a mixture of real inode (file_inode())
real dentry (file_dentry()) and ovl path, especially for reading
stat.change_cookie which is not really well defined in ovl.

At least those direct f_path references need to be fixed:

security/integrity/ima/ima_main.c:
vfs_getattr_nosec(&file->f_path, &stat,
security/integrity/ima/ima_api.c:       result =3D
vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
security/integrity/ima/ima_crypto.c:            f =3D
dentry_open(&file->f_path, flags, file->f_cred);

and then all the places that format full path for audit logs:
security/integrity/ima/ima_main.c:      *pathname =3D
ima_d_path(&file->f_path, pathbuf, filename);

Need to decide if it is prefered to log the full ovl path or the
relative real path (relative to the private mount clone of the ovl layer).

Thanks,
Amir.
