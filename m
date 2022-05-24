Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B2532C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiEXOoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiEXOoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 10:44:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168F6C575
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 07:44:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so31272782lfb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PPAHCr5neZTO5dDk3mCWvedxuHzUssgvW2coYrOgLp8=;
        b=CDwbNgcIbs6tKKmFiIIU9Ca+4UURFxGkK49ljr7S76LCKBrdYzVV0kGP+kSzdBlDF2
         X22GxneS4WxITht4E5CvGQttmenaNVUujCHOlNwSLeEhrdrsjt+2gvD5z59DbKH0msR5
         VS3s8xJEjjQoVP81DM7BExqMCNqT/mSZSUUifjQ6Hh1LKXPF5eLpLxcbWL7ELdPg+xqw
         pnUBGjpYlspfZHEWbT2nhQeLdX1udwgexQXscJ9UIdU+XY2BXFIRKPxRXZgPm6Dn3mf5
         N4jdRwUq8QP5m1S8fm/UJ/Z2qRYhnnTZPQfxVBaFfJbPexU++imLyTWOWuy2d6Wy0ddN
         izjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PPAHCr5neZTO5dDk3mCWvedxuHzUssgvW2coYrOgLp8=;
        b=V3CKDL29NkkFZf6wZTlxNlOS0BBir+kgeAjCK5xxIxJIE0ISLUaDpyipDNTl/fQudk
         49DWvBUnzuCxb3PzWO9EJt1ChXyCpPCwxZfNjpNTaHdHKPRZKtJoZDcyH0y8HuNpXln2
         V1Un4KKey2Gz3h7BfZ87z+xe2eciLCZqj6fR3STDlDfiAxX47qevxs55shXwcllSVecF
         NXGpik9gcTDAUovjFXGMZurwZBp84C/5iRT3eifVdVM5SGPLpQY3+xLj9JEOSgiBbBTq
         v4+bTxSdimhWW1KCXnN1syTFEzmwzKIi8qOrzdnAOzozR5ilBnCy8S4349XNPp3sAqzw
         9QBg==
X-Gm-Message-State: AOAM531iS6tGXFxG6K33JYE378INRX7uwbRFmJp4unn+S+EUX0/6A5ee
        hiKMia9eCTSL8Q2Cf5BI1kpHdZAl2DWUwhjt/D1YoI0XBofREg==
X-Google-Smtp-Source: ABdhPJyrR3wFmOkDZnf03zLeOf8XkWmkB50vgdnW2fSD52ridVY1WAUm3NHEvz9JCQ3D7mBgQ4+EY/6jeEqG5R5Pstw=
X-Received: by 2002:a05:6512:3c94:b0:477:ba25:de54 with SMTP id
 h20-20020a0565123c9400b00477ba25de54mr19950013lfv.137.1653403446614; Tue, 24
 May 2022 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056e02f05dfb6e11a@google.com> <20220524103246.opewohl7da34k2ry@quack3.lan>
 <20220524104658.xxbl53pshdzwvaxx@pali> <20220524113704.gdwvao43b23hyf7z@quack3.lan>
In-Reply-To: <20220524113704.gdwvao43b23hyf7z@quack3.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 May 2022 16:43:54 +0200
Message-ID: <CACT4Y+ah3gzWurFSfiPi9YqXOzS1TyfwCeP9N6QArKGVG+fP4A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in udf_close_lvid
To:     Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, alden.tondettar@gmail.com,
        hch@infradead.org, jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 May 2022 at 13:37, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-05-22 12:46:58, Pali Roh=C3=A1r wrote:
> > On Tuesday 24 May 2022 12:32:46 Jan Kara wrote:
> > >
> > > Hello!
> > >
> > > I had a look into this bug and I actually think this reproducer progr=
am does
> > > something that is always going to be problematic. The reproducer has:
> > >
> > > #{"threaded":true,"repeat":true,"procs":6,"slowdown":1,"sandbox":"","=
close_fds":false}
> > >
> > > syz_mount_image$udf(...)
> > > r0 =3D syz_open_dev$loop(&(0x7f0000000080), 0x0, 0x109002)
> > > mmap(addr, 0x600000, PROT_WRITE, MAP_SHARED | MAP_FIXED, r0, 0x0)
> > > pipe(addr)
> > >
> > > So the reproducer effectively corrupts random loop devices with outpu=
t from
> > > pipe(2) syscall while there are filesystems mounted on them by other
> > > threads. This is a guaranteed way to shoot yourself in the foot and c=
rash
> > > the kernel. You can say the kernel should not allow writing to mounte=
d devices
> > > and I'd generally agree but there are some cornercases (e.g. bootload=
ers or
> > > lowlevel filesystem tools) which happen to do this so we cannot forbi=
d that due
> > > to compatibility reasons. So syzbot probably needs to implement some
> > > internal logic not to futz with loop devices that are currently mount=
ed.
> > >
> > >                                                             Honza
> >
> > Hello! Bootloaders and other similar software in most cases needs to
> > update first sector or sectors with bootloader data or main superblock
> > of filesystem (where are metadata like label or UUIDs)... In most cases
> > these "write" operations do not touch filesystem data.
>
> Well, we generally try to move away from updating superblock directly by
> userspace - e.g. these days we have ioctls to update label or uuid so tha=
t
> coordination with the kernel is done properly. But there are still cases
> where this happens.
>
> > So I'm thinking if it would not make sense to add some kernel config
> > option to disallow write operations on mounted block devices, with some
> > filesystem hook/callback which can allow writing to specific block.
> >
> > E.g. UDF filesystem does not use first 32kB of disk and userspace
> > software can overwrite it as it wants even when fs is mounted, without
> > crashing kernel. So that udf hook/callback would allow write access to
> > this area.
> >
> > Userspace applications always invent "smart" things and I think it is a
> > good idea to protect kernel if it is possible.
> >
> > I understand that there is need to overwrite mounted block device.
> > Updating bootloader stored at the beginning of the rootfs disk is
> > important operation. Also changing filesystem label at runtime / mounte=
d
> > fs is something which users want and it is legitimate requirement. For
> > UDF this change is not easy operation and userspace software (e.g.
> > udflabel) needs to update lot of blocks on device, which can really
> > break mounted udf fs.
>
> Well, the difficulty is with identifying where writing is OK and where no=
t.
> It is not always is simple range at the beginning of the device where
> writes can happen (although that probably covers majority of cases). But
> thinking more about it the problem is not so much with applications
> modifying disk contents (we don't trust disk contents much) but with
> applications modifying buffer cache where we believe we have validated da=
ta
> structures. So we could somehow disallow buffer cache modification under
> mounted filesystem. Either the filesystem and app view of buffer cache
> would be inconsistent or apps would be doing direct IO when the filesyste=
m
> is mounted. Either option has its consequences but maybe we could create
> something working out of that.

Did not know it's not OK to write loop-associated fd.

It's quite hard to prohibit the fuzzer from doing this. It's possible
to prohibit whole syscalls, or opening particular files, or executing
particular ioctl commands. But there are lots of interesting ways how
an fd can be shared/messed with.
We could prohibit opening /dev/loop*, or associating loop with fd, but
it will inhibit all useful loop testing. And will also prohibit
testing mounting of all filesystems.

It will be good if the kernel provides some config that prohibits such
unsafe operation. Or, of course, if it prohibits only "buffer cache
modification".




> > > On Mon 23-05-22 17:17:21, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    4b0986a3613c Linux 5.18
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D125ba35=
5f00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1350d39=
7b63b3036
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D60864ed35=
b1073540d57
> > > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f=
71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1732a=
04df00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1518963=
9f00000
> > > >
> > > > The issue was bisected to:
> > > >
> > > > commit 781d2a9a2fc7d0be53a072794dc03ef6de770f3d
> > > > Author: Jan Kara <jack@suse.cz>
> > > > Date:   Mon May 3 09:39:03 2021 +0000
> > > >
> > > >     udf: Check LVID earlier
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14de=
ecd3f00000
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16de=
ecd3f00000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12deecd=
3f00000
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com
> > > > Fixes: 781d2a9a2fc7 ("udf: Check LVID earlier")
> > > >
> > > > UDF-fs: error (device loop0): udf_fill_super: Error in udf_iget, bl=
ock=3D96, partition=3D0
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: use-after-free in udf_close_lvid+0x68a/0x980 fs/udf/sup=
er.c:2072
> > > > Write of size 1 at addr ffff8880839e0190 by task syz-executor234/36=
15
> > > >
> > > > CPU: 1 PID: 3615 Comm: syz-executor234 Not tainted 5.18.0-syzkaller=
 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
> > > >  print_address_description+0x65/0x4b0 mm/kasan/report.c:313
> > > >  print_report+0xf4/0x210 mm/kasan/report.c:429
> > > >  kasan_report+0xfb/0x130 mm/kasan/report.c:491
> > > >  udf_close_lvid+0x68a/0x980 fs/udf/super.c:2072
> > > >  udf_fill_super+0xde8/0x1b20 fs/udf/super.c:2309
> > > >  mount_bdev+0x26c/0x3a0 fs/super.c:1367
> > > >  legacy_get_tree+0xea/0x180 fs/fs_context.c:610
> > > >  vfs_get_tree+0x88/0x270 fs/super.c:1497
> > > >  do_new_mount+0x289/0xad0 fs/namespace.c:3040
> > > >  do_mount fs/namespace.c:3383 [inline]
> > > >  __do_sys_mount fs/namespace.c:3591 [inline]
> > > >  __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > RIP: 0033:0x7fd64e59b08a
> > > > Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a=
8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007fd64e546168 EFLAGS: 00000286 ORIG_RAX: 0000000000000=
0a5
> > > > RAX: ffffffffffffffda RBX: 00007fd64e5461c0 RCX: 00007fd64e59b08a
> > > > RDX: 0000000020000000 RSI: 0000000020000700 RDI: 00007fd64e546180
> > > > RBP: 000000000000000e R08: 00007fd64e5461c0 R09: 00007fd64e5466b8
> > > > R10: 0000000000000810 R11: 0000000000000286 R12: 00007fd64e546180
> > > > R13: 0000000020000350 R14: 0000000000000003 R15: 0000000000000004
> > > >  </TASK>
> > > >
> > > > The buggy address belongs to the physical page:
> > > > page:ffffea00020e7800 refcount:0 mapcount:0 mapping:000000000000000=
0 index:0x0 pfn:0x839e0
> > > > flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > > > raw: 00fff00000000000 ffffea00020e7808 ffffea00020e7808 00000000000=
00000
> > > > raw: 0000000000000000 0000000000000000 00000000ffffffff 00000000000=
00000
> > > > page dumped because: kasan: bad access detected
> > > > page_owner info is not present (never set?)
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff8880839e0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >  ffff8880839e0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > >ffff8880839e0180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >                          ^
> > > >  ffff8880839e0200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >  ffff8880839e0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > For information about bisection process see: https://goo.gl/tpsmEJ#=
bisection
> > > > syzbot can test patches for this issue, for details see:
> > > > https://goo.gl/tpsmEJ#testing-patches
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20220524113704.gdwvao43b23hyf7z%40quack3.lan.
