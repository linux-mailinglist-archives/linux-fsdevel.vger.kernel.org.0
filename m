Return-Path: <linux-fsdevel+bounces-41251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D5A2CCA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E3618831D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1F1917D8;
	Fri,  7 Feb 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBlhRl1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4321624F9;
	Fri,  7 Feb 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956824; cv=none; b=uAu31QG67EN7uc6fIRGDHz/XbiRgChjR2CsoI1MTw0/7PjG9zOq+IGM4Zf3L+i0CVEzU3jZo3nrm11Cjae7xD+uLfShXEOkUqsLD5k7dudqf2NH0UhPPkAL8S/av5cRe+LWSiyVultsPB3VvupxquvI++tEiAGjg6PeDLE0eXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956824; c=relaxed/simple;
	bh=qarPXWpicXFi48pwPuzafODk1yLIbX5SHYZ493qwT8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOO6ihb03Q1ZaDIyOp4AQOViC4R2O6+h1gfcoj7YIaaYgindGe3MbfiBv9G7anC5RoMrR2mufn6+0CiTBHxt6jDURA/1lNcugSdTp7FLZxOvXaWZwnU1VzFOy4mH3UebZGTfjgE9N4D4WIOSOiG5/Uh8zKH8s0nbsbL2H6vB1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBlhRl1A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de5bf41652so90278a12.1;
        Fri, 07 Feb 2025 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738956821; x=1739561621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvcv5oFO5yuh0ssL0C2FZl0cPKOHFQnsd+cAtQTfxww=;
        b=CBlhRl1AwE0uIW4L1I/PRrtnorFz7wDz6l6E+PXPMK1y/x3H9MXTwEGHI0jCdzng1m
         uScB4+vyPsJvvKItjwOtxhHmRgABmsTFPvzgBV2J3twfgGItaxqBFRMMg9GUSyVLeGoz
         JXqtopt06Zeh47z+AaNafP0DNl+C5FFOs9xo/aXCgOQtE3/K9T3osPiEK7EM1k4f/l4d
         ApyCJIPKQMKPH5dF5BmH099BajiEOD5VG3LtgMYwX2PhI37QKfe+GrB2ctfgyGaaeB5o
         gmQB0CNKuOlNjXirlWtthy4Rr223jKJ6a2Z9Vw9O3H5/o8p2fhZZ/32abLvC+oOJg8K0
         mHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738956821; x=1739561621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvcv5oFO5yuh0ssL0C2FZl0cPKOHFQnsd+cAtQTfxww=;
        b=XNQyla0D6kxHBm1HeYt0ZGud6iqHJS1HHE85GiLK7AjzgLd18RthXpTfg0XBdqSoEL
         xPbDRra5XfEkM0O3v/5K3Nre8IN4w4U8hAkLDSvO8EmZ/ZvwB4o5Wm3dIEY+kjJCktmi
         WU+rPJDwLMKybv2Ah0tZ58UpiHew2ltb2iay06GDk9rM1fqOA2uXWGzcUpnuvTtX5iHu
         f/qCYObMx1j/5CJUvh9trA8ZmTrRHK0+xFivQipInOlCqj9f6WMTbAKNDlP8ZqlFw5rN
         txUisHvqORBZewYFC+NszgXrpufSSBSXKeJj5hqe12lCtyqYBSZMkMRrdsPEGwdYmu40
         PJSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJKNMxcCzv2PWsbcNsgedtp14MtGgg26wGv7IufcBRdO1/X21/hQUeM2CY8U6bXwHmqz29s9HXC+1PHeB/@vger.kernel.org, AJvYcCXOK43RYIQzNwCy/A6fmtoi0cJ+i2BfN+AB4NsstpyRhr5p5+qU74CkqjhN+9OAy57FJ16GE2pjNaYdN3gW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rBTjZb93SxNrYCVcCvji3mSE1h1woWFCAm5834ljbMB/p4OR
	alHtOKQPuliW3IuxCRkvUE+VR2up5SyQudJBgngfxRJRpQX1g9Z4fvlTCFc9xPSNQaH+11p41Kw
	LMLGPlUtDLPTJDutX05TxsvFxbDUjTz5QV2I=
X-Gm-Gg: ASbGncv8Qq9J9MWN5Kqp6RBmIhRU2yY9GJDH580EUPviD43B+rafgEaVCYBiKbWAg8n
	f+J0YgdrZ13wuUC5HQPh4tZ5eQe8wXVuk0n6w9flkf8RS/f0+SYIhFcDyuxGFgWXzHB9YRhgQ
X-Google-Smtp-Source: AGHT+IFFs/Rqjxw2rV1FceqF1aOlkkljxp6UG0aTtGzBzzmTu3tUmF2R/pfQViZ76iqviap50rlzTA+TBnKXzO/8mSs=
X-Received: by 2002:a05:6402:13c8:b0:5dc:cc02:5d25 with SMTP id
 4fb4d7f45d1cf-5de45002faamr4611268a12.11.1738956820532; Fri, 07 Feb 2025
 11:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com> <20250206165404.495fd127b4dc32a62574841a@linux-foundation.org>
 <20250207-teuer-viermal-9c60839ff221@brauner>
In-Reply-To: <20250207-teuer-viermal-9c60839ff221@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Feb 2025 20:33:28 +0100
X-Gm-Features: AWEUYZmeqLI8aVU-FWqBjZ55K5Oj3LwvTof94Ff0ynkNlOpyfA4oM0EVeDHUmoo
Message-ID: <CAOQ4uxgB0q3bMT6+jE4WmYKhvxDdfUzfw1+67ohUfHsAVGeHGg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in fsnotify_file_area_perm
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 9:46=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Feb 06, 2025 at 04:54:04PM -0800, Andrew Morton wrote:
> >
> > Thanks.  Let me cc linux-fsdevel and a few others who might help with
> > this.
>
> Thanks! I already have a fix for this in vfs.fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.fixes&id=3Db13036454697d83e53bf754efbcaaedf431b7a8a
>

Yes, I hope that it is fixed.
The assertion in a fsnotify_file_area_perm() hook on page read fault
on the blockdev, which shouldn't have FMODE_FSNOTIFY_HSM set.


> I'll get that out today.
>

Thanks,
Amir.


> >
> >
> > On Thu, 06 Feb 2025 01:59:19 -0800 syzbot <syzbot+7229071b47908b19d5b7@=
syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of gi=
t://g..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D135c17245=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd033b14ae=
ef39158
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7229071b479=
08b19d5b7
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vm=
linux-69e858e0.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edaf=
c0/bzImage-69e858e0.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> > >
> > > loop0: detected capacity change from 0 to 32768
> > > XFS: ikeep mount option is deprecated.
> > > XFS (loop0): Mounting V5 Filesystem a2f82aab-77f8-4286-afd4-a8f747a74=
bab
> > > XFS (loop0): Ending clean mount
> > > XFS (loop0): Quotacheck needed: Please wait.
> > > XFS (loop0): Quotacheck: Done.
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 5321 at ./include/linux/fsnotify.h:145 fsnotify_=
file_area_perm+0x1e5/0x250 include/linux/fsnotify.h:145
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-syzkaller-09=
760-g69e858e0b8b2 #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debia=
n-1.16.3-2~bpo12+1 04/01/2014
> > > RIP: 0010:fsnotify_file_area_perm+0x1e5/0x250 include/linux/fsnotify.=
h:145
> > > Code: c3 cc cc cc cc e8 fb 8f c6 ff 49 83 ec 80 4c 89 e7 48 83 c4 08 =
5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 9f 00 00 e8 dc 8f c6 ff 90 <0f> 0b 90 e=
9 0a ff ff ff 48 c7 c1 10 73 1b 90 80 e1 07 80 c1 03 38
> > > RSP: 0018:ffffc9000d416320 EFLAGS: 00010283
> > > RAX: ffffffff81f8dce4 RBX: 0000000000000001 RCX: 0000000000100000
> > > RDX: ffffc9000e5c2000 RSI: 00000000000008fa RDI: 00000000000008fb
> > > RBP: 0000000000008000 R08: ffffffff81f8dbdc R09: 1ffff110087dca2e
> > > R10: dffffc0000000000 R11: ffffed10087dca2f R12: ffff888033d4b1c0
> > > R13: 0000000000000010 R14: dffffc0000000000 R15: ffffc9000d416460
> > > FS:  00007f5bca7346c0(0000) GS:ffff88801fc00000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020000100 CR3: 0000000033fd2000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  filemap_fault+0x14a9/0x16c0 mm/filemap.c:3509
> > >  __do_fault+0x135/0x390 mm/memory.c:4977
> > >  do_read_fault mm/memory.c:5392 [inline]
> > >  do_fault mm/memory.c:5526 [inline]
> > >  do_pte_missing mm/memory.c:4047 [inline]
> > >  handle_pte_fault mm/memory.c:5889 [inline]
> > >  __handle_mm_fault+0x4c44/0x70f0 mm/memory.c:6032
> > >  handle_mm_fault+0x3e5/0x8d0 mm/memory.c:6201
> > >  faultin_page mm/gup.c:1196 [inline]
> > >  __get_user_pages+0x1a92/0x4140 mm/gup.c:1491
> > >  __get_user_pages_locked mm/gup.c:1757 [inline]
> > >  __gup_longterm_locked+0xe64/0x17f0 mm/gup.c:2529
> > >  gup_fast_fallback+0x2266/0x29c0 mm/gup.c:3430
> > >  pin_user_pages_fast+0xcc/0x160 mm/gup.c:3536
> > >  iov_iter_extract_user_pages lib/iov_iter.c:1844 [inline]
> > >  iov_iter_extract_pages+0x3bb/0x5c0 lib/iov_iter.c:1907
> > >  __bio_iov_iter_get_pages block/bio.c:1181 [inline]
> > >  bio_iov_iter_get_pages+0x4f1/0x1460 block/bio.c:1263
> > >  iomap_dio_bio_iter+0xc9c/0x1740 fs/iomap/direct-io.c:406
> > >  __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
> > >  iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:792
> > >  xfs_file_dio_write_unaligned+0x2ef/0x6f0 fs/xfs/xfs_file.c:692
> > >  xfs_file_dio_write fs/xfs/xfs_file.c:725 [inline]
> > >  xfs_file_write_iter+0x5c6/0x720 fs/xfs/xfs_file.c:876
> > >  do_iter_readv_writev+0x71a/0x9d0
> > >  vfs_writev+0x38b/0xbc0 fs/read_write.c:1050
> > >  do_pwritev fs/read_write.c:1146 [inline]
> > >  __do_sys_pwritev2 fs/read_write.c:1204 [inline]
> > >  __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f5bc998cda9

