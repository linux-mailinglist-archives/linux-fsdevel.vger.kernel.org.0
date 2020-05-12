Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6F1CF88F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgELPFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgELPFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 11:05:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96FC061A0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 08:05:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r7so11379638edo.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uN80p8DJDhfAR4BxggcaeXg6nSSyC+bDlV85RCsNRjg=;
        b=NENUacsnhPU0zD7KO/+ipwA9SuVNmY9UHZjGfCTWzTkhmHqyeYpqZWyE6eLhDwTWzd
         thulbLe3YTwxlqTSb5hqgahvMwswhALC195DJYjTSzO7KvOvMZBK9kFUoRjLHoVHqbeZ
         W9CS6SXht8VgOZEVKSakhXbnj98yDF7DAfJyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uN80p8DJDhfAR4BxggcaeXg6nSSyC+bDlV85RCsNRjg=;
        b=UD6x6ebwQotKVxyXIcszl68IFDPlNhIkqhtF1QyhNe/skJuBL4d/7k9DhJkYzunkKF
         piJbZWHu8arSYllM0H2WWauM/j/pu7Jy+XvbRrWRzhHyy4i2yyuiznzSmaIbwznAa72u
         twoByrb2x0j48O0BxyWVjUqv7Hy4VwLifltiwTdD8ttip9dS9trnqBSrNhD9roYYD3Er
         H2OAMcEYY0WW7SSGanSqZ70p2NAcLivjJ9Z+bhGJL9DbGJCBSSzFLpsTOe9kcLuBmJvz
         VskM7u2Ee0fYFvtIs4K+Ot6cYtAPpTc7fyalhyVAqIB6pMOpoGfbiHYPK4stcJNdmckn
         rkkQ==
X-Gm-Message-State: AOAM533QnpWSKRBknxs1G3vAB+5xTWse7NJlhym2xyDsLmDRy6ucuuEz
        rzvdShFYXwDlAPUUW4iWShBNuz7mQx3Gj18+wTeYQQ==
X-Google-Smtp-Source: ABdhPJy5PhHQIA+eXsfjbgCq7jpWgLiM63J3f2hPfGv2ioIDV+PhHdwx7NwUDZxdaIQ7FYcVX3vWfPaHngiFBqi7Tb8=
X-Received: by 2002:a50:d785:: with SMTP id w5mr2645261edi.212.1589295903058;
 Tue, 12 May 2020 08:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b4684e05a2968ca6@google.com> <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
In-Reply-To: <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 May 2020 17:04:51 +0200
Message-ID: <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:06 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> On 4/5/20 8:06 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    1a323ea5 x86: get rid of 'errret' argument to __get_use=
r_x..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D132e940be00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8c1e9845833=
5a7d1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd6ec23007e951=
dadf3de
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12921933e=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D172e940be00=
000
> >
> > The bug was bisected to:
> >
> > commit e950564b97fd0f541b02eb207685d0746f5ecf29
> > Author: Miklos Szeredi <mszeredi@redhat.com>
> > Date:   Tue Jul 24 13:01:55 2018 +0000
> >
> >     vfs: don't evict uninitialized inode
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D115cad33=
e00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D135cad33=
e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D155cad33e00=
000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
> > Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
> >
> > overlayfs: upper fs does not support xattr, falling back to index=3Doff=
 and metacopy=3Doff.
> > ------------[ cut here ]------------
> > kernel BUG at mm/hugetlb.c:3416!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 7036 Comm: syz-executor110 Not tainted 5.6.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > RIP: 0010:__unmap_hugepage_range+0xa26/0xbc0 mm/hugetlb.c:3416
> > Code: 00 48 c7 c7 60 37 35 88 e8 57 b4 a2 ff e9 b3 fd ff ff e8 cd 90 c6=
 ff 0f 0b e9 c4 f7 ff ff e8 c1 90 c6 ff 0f 0b e8 ba 90 c6 ff <0f> 0b e8 b3 =
90 c6 ff 83 8c 24 c0 00 00 00 01 48 8d bc 24 a0 00 00
> > RSP: 0018:ffffc900017779b0 EFLAGS: 00010293
> > RAX: ffff88808cf5c2c0 RBX: ffffffff8c641c08 RCX: ffffffff81ac50b4
> > RDX: 0000000000000000 RSI: ffffffff81ac58a6 RDI: 0000000000000007
> > RBP: 0000000020000000 R08: ffff88808cf5c2c0 R09: ffffed10129d8111
> > R10: ffffed10129d8110 R11: ffff888094ec0887 R12: 0000000000003000
> > R13: 0000000000000000 R14: 0000000020003000 R15: 0000000000200000
> > FS:  00000000013c0880(0000) GS:ffff8880ae600000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000140 CR3: 0000000093554000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  __unmap_hugepage_range_final+0x30/0x70 mm/hugetlb.c:3507
> >  unmap_single_vma+0x238/0x300 mm/memory.c:1296
> >  unmap_vmas+0x16f/0x2f0 mm/memory.c:1332
> >  exit_mmap+0x2aa/0x510 mm/mmap.c:3126
> >  __mmput kernel/fork.c:1082 [inline]
> >  mmput+0x168/0x4b0 kernel/fork.c:1103
> >  exit_mm kernel/exit.c:477 [inline]
> >  do_exit+0xa51/0x2dd0 kernel/exit.c:780
> >  do_group_exit+0x125/0x340 kernel/exit.c:891
> >  __do_sys_exit_group kernel/exit.c:902 [inline]
> >  __se_sys_exit_group kernel/exit.c:900 [inline]
> >  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:900
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
>
> This is not new and certainly not caused by commit e950564b97fd.

Sorry for replying late...

> hugetlbf only operates on huge page aligned and sized files/mappings.
> To make sure this happens, the mmap code contians the following to 'round
> up' length to huge page size:
>
>         if (!(flags & MAP_ANONYMOUS)) {
>                 audit_mmap_fd(fd, flags);
>                 file =3D fget(fd);
>                 if (!file)
>                         return -EBADF;
>                 if (is_file_hugepages(file))
>                         len =3D ALIGN(len, huge_page_size(hstate_file(fil=
e)));
>                 retval =3D -EINVAL;
>                 if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(fi=
le)))
>                         goto out_fput;
>         } else if (flags & MAP_HUGETLB) {
>                 struct user_struct *user =3D NULL;
>                 struct hstate *hs;
>
>                 hs =3D hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUG=
E_MASK);
>                 if (!hs)
>                         return -EINVAL;
>
>                 len =3D ALIGN(len, huge_page_size(hs));
>
> However, in this syzbot test case the 'file' is in an overlayfs filesyste=
m
> created as follows:
>
> mkdir("./file0", 000)                   =3D 0
> mount(NULL, "./file0", "hugetlbfs", MS_MANDLOCK|MS_POSIXACL, NULL) =3D 0
> chdir("./file0")                        =3D 0
> mkdir("./file1", 000)                   =3D 0
> mkdir("./bus", 000)                     =3D 0
> mkdir("./file0", 000)                   =3D 0
> mount("\177ELF\2\1\1", "./bus", "overlay", 0, "lowerdir=3D./bus,workdir=
=3D./file1,u"...) =3D 0
>
> The routine is_file_hugepages() is just comparing the file ops to huegtlb=
fs:
>
>         if (file->f_op =3D=3D &hugetlbfs_file_operations)
>                 return true;
>
> Since the file is in an overlayfs, file->f_op =3D=3D ovl_file_operations.
> Therefore, length will not be rounded up to huge page size and we create =
a
> mapping with incorrect size which leads to the BUG.
>
> Because of the code in mmap, the hugetlbfs mmap() routine assumes length =
is
> rounded to a huge page size.  I can easily add a check to hugetlbfs mmap
> to validate length and return -EINVAL.  However, I think we really want t=
o
> do the 'round up' earlier in mmap.  This is because the man page says:
>
>    Huge page (Huge TLB) mappings
>        For mappings that employ huge pages, the requirements for the argu=
ments
>        of  mmap()  and munmap() differ somewhat from the requirements for=
 map=E2=80=90
>        pings that use the native system page size.
>
>        For mmap(), offset must be a multiple of the underlying huge page =
size.
>        The system automatically aligns length to be a multiple of the und=
erly=E2=80=90
>        ing huge page size.
>
> Since the location for the mapping is chosen BEFORE getting to the hugetl=
bfs
> mmap routine, we can not wait until then to round up the length.  Is ther=
e a
> defined way to go from a struct file * to the underlying filesystem so we
> can continue to do the 'round up' in early mmap code?

That's easy enough:

static inline struct file *real_file(struct file *file)
{
    return file->f_op !=3D ovl_file_operations ? file : file->private_data;
}

But adding more filesystem specific code to generic code does not
sound like the cleanest way to solve this...

> One other thing I noticed with overlayfs is that it does not contain a
> specific get_unmapped_area file_operations routine.  I would expect it to=
 at
> least check for and use the get_unmapped_area of the underlying filesyste=
m?
> Can someone comment if this is by design?

Not sure.  What exactly is f_op->get_unmapped_area supposed to do?

> In the case of hugetlbfs, get_unmapped_area is even provided by most
> architectures.  So, it seems like we would like/need to be calling the co=
rrect
> routine.

Okay.

Thanks,
Miklos
