Return-Path: <linux-fsdevel+bounces-59408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C149B387E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593A21C20865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621332DFA38;
	Wed, 27 Aug 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgxWFwCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4414BFA2;
	Wed, 27 Aug 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312934; cv=none; b=j9VW1VO5mqC5mBubKSWvoU4a1F3Zdv9pZqMx2bl7hhHk70NMhinz+ij+xp3ZBa7nSzbbsMi6xUqWGRMq2hOB/WeUv4M5lyNg7Xq4tYQDaeug9Q3K+uutWUaH4/FdrCVFE9bepHQEI7LC5vphUB2AhDHzqUgdG4oXrLVUjzFQVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312934; c=relaxed/simple;
	bh=Ze7VK/NW52ie7m6ocHgrkyf2cjqSdEf2HW/Tjqcxu1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMAfXzrhQHBcCpXjLnFW4V/UB5dRlJf8K65kTePXTmcL17NwQnY0XjnhlINmhHak+3TudRkVgt1ieVzq2u76gpogKaiXDJg+CorFUVw71ORJW67d0RXt8d5Wv+91XKWLZePz34GZltQvrXGh8xafzVa7wXSr8xjOOvwwAEusQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgxWFwCZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109921fe7so504421cf.0;
        Wed, 27 Aug 2025 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756312932; x=1756917732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukNwbFQiSMrKDLfMwG5KZXIBLapa00t8EPrxLnQbq5Q=;
        b=bgxWFwCZobzj9uecbE33Wlx9ICsRf4cFHuZUmZOcvsjOr3NpOwjfw9sTbG+hahtMDB
         7Ns3ebxgIB/aF2neLez4VVGcW1BHGmDFl0mNKqIZ6tZoQDFzlgl2wCTHi2/afadvF2Hk
         yXN1QcZw/JeomrZa0nNSBj4EsBxctuMaLYMulPTeZGr3OZyY8FzZxHuRhWSoUY1QAXOX
         fezGgEyt3HhS1O2+kMYp54QOM5Ss9sSMeKWK7iaDFkdDOa2U/GOHNlJ7neOhSzjnzBZg
         lzqCxvFxxl21FqJTl0/Hq+HUEDe8C5HWAgsDjbm3DVUxkUOkLcN1+3WkmpN2KmJHJSXS
         Oj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312932; x=1756917732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukNwbFQiSMrKDLfMwG5KZXIBLapa00t8EPrxLnQbq5Q=;
        b=Fiej0AMebJrX6apF+nzdi1W+12iSs2c4VrJ1TEhB/kwp7TXnEZafNnFwJ79hMZqTO/
         8f+Gm9XSnWjSZVFmE3Jv0bVYhXrqsdH1eMOfO8R/9K+twFp5dOCHxS4mD+oRoWqn5fsD
         AdwXKQchRGluHc/GJckpK2cp4jPLbhdheQ/YhKzA76E+IqnOoKyUwk2/5BMiAdi4BvkF
         jI1TjLGp5IC+LkgdbG/hAsE9szwvClG4GwIDK4u385QclRKh8kS9OCeG+rGcJIl5c7xk
         rXT+TCibFAUb3GkHitw2WCYzuJ8fLGFGsOxX0/YWTqYV0GZB38JSt9UQno7K3WtT3qGM
         WGjw==
X-Forwarded-Encrypted: i=1; AJvYcCU3pJVEYNYU/4pS9nLzqOO4xDFh8A/oy43FZtHNEUDIJCV6iEHWhNVOrN1qzKBA6uQ29gfyzXJtmZiu90S+@vger.kernel.org, AJvYcCVY7nz2wsxEkQm/BZp0pSU9/I2H/L6e/FZURToBnHg8lmuYZVdkQkyXEDrcehwxVRAfS2+2Yl6y9JuWjlI2@vger.kernel.org, AJvYcCXgngcZbawYQ+pkd9htN11IYdFTE8EAXrWLbCWsUwttb/12OzK9Nz3gMjbQKt5KQ8X/2cV9XLqW2SPfeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAfqW+5fP9JpIvCqrDIBMAaDe472iYdQzw1Yj/znjox59VVj3
	YCqKiEblGzrQ2/MSBc+UHwHJw4WxPoNslocuue1HnBxAXCWDYQKQLEWKRVALCqYIyb7H+3vX4LK
	5ytvNggY6aNgGFRbCxPGQViySS7Etd44=
X-Gm-Gg: ASbGncvkHpkg7anD+dwDvxIzvK0xV06GDinXzS1iSerNbrxGSBjANrpot0HsVWxiR0z
	CgnfewfaxNRpMlMnk26FFTYS4jYmp3dwNd9VTU2LiGNUOta+nGbJRs9aeBIzAIZRPpCcKX8Hoid
	qsrgqfBbYew5/mv/nBQ67+q2Lsk+NKXEXYKzBy+EaL55cuH+IFenWyULZoE3jPnDHxFCCzMdTrU
	l5C0mjG
X-Google-Smtp-Source: AGHT+IEdK6rv8rou1a4sOK6DISGx8RbBcTvJq0Xla0Iewbb5/AzkN8ABV37s99VrDH8YODTMQxRHkJAthNi4G6Esue0=
X-Received: by 2002:a05:622a:4016:b0:4ae:f8bb:7c6a with SMTP id
 d75a77b69052e-4b2aaaf96abmr235680241cf.54.1756312931784; Wed, 27 Aug 2025
 09:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68a841d7.050a0220.37038e.0051.GAE@google.com> <CANp29Y5zWmwXDq1uuzxi43_VXieykD2OOLF12YvBELCUS_Hibg@mail.gmail.com>
In-Reply-To: <CANp29Y5zWmwXDq1uuzxi43_VXieykD2OOLF12YvBELCUS_Hibg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 Aug 2025 09:42:01 -0700
X-Gm-Features: Ac12FXwHpDFGX3qpd9AovfJG44VaG3oJdBDPHtt5VXniGKE2sjOw13BopanbSYA
Message-ID: <CAJnrk1Ziam4ZqqyzOpbUD8j=RwJOK22Uz3VMqWZsUNiJ5bkBrg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] linux-next test error: WARNING in __folio_start_writeback
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com>, 
	David Hildenbrand <david@redhat.com>, mszeredi@redhat.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-next@vger.kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:45=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> I've bisected the problem to the following commit:
>
> commit 167f21a81a9c4dbd6970a4ee3853aecad405fa7f (HEAD)
> Author: Joanne Koong <joannelkoong@gmail.com>
> Date:   Mon Jul 7 16:46:06 2025 -0700
>
>     mm: remove BDI_CAP_WRITEBACK_ACCT
>
>     There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
>     its own writeback accounting. This commit removes
>     BDI_CAP_WRITEBACK_ACCT.
>
> Joanne Koong, could you please take a look at the syzbot report below?

Hi Aleksandr,

Thanks for bisecting this. This is a duplicate of what Marek reported
in [1]. His patch in [2] fixes the warning getting triggered.

Marek, could you submit your patch formally to the mm tree so it could
be picked up?


Thanks,
Joanne


[1] https://lore.kernel.org/linux-fsdevel/a91010a8-e715-4f3d-9e22-e4c34efc0=
408@samsung.com/T/#u
[2] https://lore.kernel.org/linux-fsdevel/a91010a8-e715-4f3d-9e22-e4c34efc0=
408@samsung.com/T/#m3aa6506ee7de302242e64861f8e2199f24e4ad46

>
> On Fri, Aug 22, 2025 at 12:09=E2=80=AFPM syzbot
> <syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0f4c93f7eb86 Add linux-next specific files for 20250822
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D172c07bc580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D21eed27c0de=
adb92
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0630e71306742=
d4b2aea
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/669ede8f5d66/d=
isk-0f4c93f7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/50feda89fe89/vmli=
nux-0f4c93f7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/317a0d3516fb=
/bzImage-0f4c93f7.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: ./include/linux/backing-dev.h:243 at inode_to_wb include/linux=
/backing-dev.h:239 [inline], CPU#1: kworker/u8:6/2949
> > WARNING: ./include/linux/backing-dev.h:243 at __folio_start_writeback+0=
x9d5/0xb70 mm/page-writeback.c:3027, CPU#1: kworker/u8:6/2949
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 2949 Comm: kworker/u8:6 Not tainted syzkaller #0 PRE=
EMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/12/2025
> > Workqueue: writeback wb_workfn (flush-8:0)
> > RIP: 0010:inode_to_wb include/linux/backing-dev.h:239 [inline]
> > RIP: 0010:__folio_start_writeback+0x9d5/0xb70 mm/page-writeback.c:3027
> > Code: 28 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 ce a2 29=
 00 49 8b 07 25 ff 3f 00 00 e9 1b fa ff ff e8 7c 04 c6 ff 90 <0f> 0b 90 e9 =
d6 fb ff ff e8 6e 04 c6 ff 48 c7 c7 a0 f8 5f 8e 4c 89
> > RSP: 0018:ffffc9000bb06ea0 EFLAGS: 00010293
> > RAX: ffffffff81fad344 RBX: ffffea00050de8c0 RCX: ffff88802ee29e00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffc9000bb07010 R08: ffffc9000bb06f97 R09: 0000000000000000
> > R10: ffffc9000bb06f80 R11: fffff52001760df3 R12: ffffea00050de8c8
> > R13: 0000000000000000 R14: ffff888023060880 R15: ffff888023060660
> > FS:  0000000000000000(0000) GS:ffff8881258c3000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f7354907000 CR3: 000000000e338000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  __block_write_full_folio+0x75f/0xe10 fs/buffer.c:1928
> >  blkdev_writepages+0xd1/0x170 block/fops.c:484
> >  do_writepages+0x32e/0x550 mm/page-writeback.c:2604
> >  __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1680
> >  writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:1976
> >  __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
> >  wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
> >  wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
> >  wb_do_writeback fs/fs-writeback.c:2315 [inline]
> >  wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2343
> >  process_one_work kernel/workqueue.c:3236 [inline]
> >  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
> >  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
> >  kthread+0x711/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >

