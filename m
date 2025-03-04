Return-Path: <linux-fsdevel+bounces-43177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F0AA4EF3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 22:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA51516563E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B882777F4;
	Tue,  4 Mar 2025 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSXl3qck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CD1FDA9D;
	Tue,  4 Mar 2025 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122834; cv=none; b=PW6PkIswR6lhpntIe1lpyQklnmV0CryhS2eMXeQdVstebC4NsMnylAT2nUh/MvSbmjyOR6NAbfthJutyk0z4yTOMO0aOQTvAwTEEfYNbZqYIac9MbzXWBk0PILa+uTp4n2igjp6kdkMEXw0dkxRf4zYpDkpSovq+AnkPYYQt9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122834; c=relaxed/simple;
	bh=JMe/qcspcoiZchvQQU0hMSSgEZILtqwU9OoakxbHb9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlB7k8OxMx+0GpJvXUgwHzqvzLpZmcnzoRZUu2vKc4L8jLxJ6gC6mC3/yty5NNmqfriD9yA+4AdV4mSlBKaHWIcQtchpmyV3U+UNmCxG4BNye/wajvuPadQImQn8dYpSfpszpv23etiEzndLgCgIMNqCqYtUCOMZLFb6HZRzFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSXl3qck; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf45d8db04so598258766b.1;
        Tue, 04 Mar 2025 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122831; x=1741727631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J8YOwIEEVHyNCl0YcJAroXcURAnRLfse6R4+fdppn4=;
        b=jSXl3qck2y4BaU9frgxaTQd/+HVtJWTsKlBLdCiSTWoRXC47WEbtZ2zBVcPKy/vBGp
         RUSIeV70hlJQZGWidFKIN5siaxTr46FNKYgng87fpdaAWJsiyfeqetjc6XrKMhxZQ/yi
         1dvyUbrMsvVZMbJseRiZYI34q1PM+XvaKdL04yDlfMCavxgDeLuHnYcs9lbcc3ObK6E4
         gDjlII/h+9fX5BgzKN5ve4wN11r+rtzhVrqP8t9KnGPwV6qC3YSi+NrMwvtmO4yft3gU
         wrh9QtnzvJhLYyFo6m5ho/lzcHpGZ/G9xGOUIJvtRGex2pkyEB9AQBbbArbDA5uSika+
         DwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122831; x=1741727631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J8YOwIEEVHyNCl0YcJAroXcURAnRLfse6R4+fdppn4=;
        b=J96rnif+7JTqL+3jW5iIwASlwjXtW4I90kGheLVfk6RqVd96fDyEzRiWZ8TVyFvvKf
         trIupfDNbcw/nr/LEnlFwH4KnmemBzghZilC8RFiZ8mEwuACTY9hoWNbjI770gzcMP9H
         IiFgyxfd45Gm6n1QP0+mD5QwHY5iymVkZTmxeQki8YLdsm6iRMRLk+vGKL2Q1YQyhIR3
         lxea5qpZOSAcDDTZZZCSp7hti3I7sUmQBpiUsbbnDbj59au/j9CcSDC9YU1H8TAUViR0
         sox6XH2NQ8boVZJob+rPnqAE+u4ZIkwLJFeZNtFOX9uSb+i+Ec2T/E4BW7e2yi4UTgzb
         pTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEp+kg8fRfbodvO2cQavJYJI4s48Z18JcfCEaoWCVAmM4SxdHtDEzjqD/M1GMvCcyH8T3RBG5IKdl6AlRT@vger.kernel.org, AJvYcCUlXkItj6R9UmSmXxZ5SUHyhBgVnM078MyX+0WCPJvfmZ+FofGIkQjYeG8XY8PsTSyjh1NI8xwiQW37@vger.kernel.org, AJvYcCXFr8ZlgQy1VJsca8bFAj3nYjj8akmDE2k8ItyhBf1IOPT2Mpi83xYiaQqENCf6qgExUXvJNudTC/culN9L@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XSY/FUD7heDCZtd8DsbJo5pOccLdmZ45yd2gKSUoD4iNLqX/
	n5gdDZu+q2t+6DL6Ie6xAgqlLyqkRqo9wS/zWrUR3x7SSg0s8c8342tUMTWFR9tI63pi95OdtZ4
	7mN+6HPVME/LGFIVnE2fMlbXnqyQ=
X-Gm-Gg: ASbGnctTd5PqX1pBwhFXjqULAPm92FFDJAYSrSNx5KvguBOoDOP0D1LCHIygYBTKgNH
	a9bSx2MaLqkS42WzZ55Tq8wd3t7upjB5dGcoTR9tr/4fRGibLejlrUg6I+rvF72TtK3ZUeTyG7i
	cro9lWFPeM8q+WZWlU2gSOLYNrqQ==
X-Google-Smtp-Source: AGHT+IFZrWlJPjDY/K1dKn6KwlpO6FY0o5jmsajcaXfdxae8w/3rlNFD6nvU8jAFvHJ57tKEXe9DLGo3vFHWtTW1S+E=
X-Received: by 2002:a17:907:7f8a:b0:ac1:ec42:6cb6 with SMTP id
 a640c23a62f3a-ac20db006a5mr74629566b.52.1741122830557; Tue, 04 Mar 2025
 13:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com> <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
 <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
 <CAOQ4uxjf5H_vj-swF7wEvUkPobEuxs2q6jfO9jFsx4pqxtJMMg@mail.gmail.com>
 <20250304161509.GA4047943@perftesting> <CAOQ4uxj0cN-sUN=EE0+9tRhMFFrWLQ0T_i0fprwNRr92Hire6Q@mail.gmail.com>
 <20250304203657.GA4063187@perftesting>
In-Reply-To: <20250304203657.GA4063187@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Mar 2025 22:13:39 +0100
X-Gm-Features: AQ5f1JqNtzknjQuSpiU1bx2jheCURHcVXVhGUHYQJGqWgiCdDvdg1aIGdH7j2m0
Message-ID: <CAOQ4uxihyR8u5c0T8q85ySNgp4U1T0MMSR=+vv3HWNFcvezRPQ@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, 
	syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:37=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> > On Tue, Mar 4, 2025 at 5:15=E2=80=AFPM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> > >
> > > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrote:
> > > > On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > Josef, Amir,
> > > > >
> > > > > this is indeed an interesting case:
> > > > >
> > > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > > syzbot has found a reproducer for the following issue on:
> > > > > ...
> > > > > > ------------[ cut here ]------------
> > > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145 fsn=
otify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > Modules linked in:
> > > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6.14.=
0-rc4-syzkaller-ge056da87c780 #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 12/27/2024
> > > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D-=
-)
> > > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify=
.h:145
> > > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify=
.h:145
> > > > > > sp : ffff8000a42569d0
> > > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d68a17=
08
> > > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 00000000000080=
00
> > > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 00000000000010=
00
> > > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a42566=
e0
> > > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 00000000000000=
01
> > > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 00000000000000=
00
> > > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 00000000000000=
00
> > > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 00000000000000=
00
> > > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 00000000000010=
00
> > > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 00000000000000=
00
> > > > > > Call trace:
> > > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:1=
45 (P)
> > > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > > >  do_fault mm/memory.c:5537 [inline]
> > > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
> > > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> > > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-common.=
c:510
> > > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inlin=
e] (P)
> > > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> > > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io.c:1=
039
> > > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
> > > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > > >
> > > > > The backtrace actually explains it all. We had a buffered write w=
hose
> > > > > buffer was mmapped file on a filesystem with an HSM mark. Now the=
 prefaulting
> > > > > of the buffer happens already (quite deep) under the filesystem f=
reeze
> > > > > protection (obtained in vfs_write()) which breaks assumptions of =
HSM code
> > > > > and introduces potential deadlock of HSM handler in userspace wit=
h filesystem
> > > > > freezing. So we need to think how to deal with this case...
> > > >
> > > > Ouch. It's like the splice mess all over again.
> > > > Except we do not really care to make this use case work with HSM
> > > > in the sense that we do not care to have to fill in the mmaped file=
 content
> > > > in this corner case - we just need to let HSM fail the access if co=
ntent is
> > > > not available.
> > > >
> > > > If you remember, in one of my very early version of pre-content eve=
nts,
> > > > the pre-content event (or maybe it was FAN_ACCESS_PERM itself)
> > > > carried a flag (I think it was called FAN_PRE_VFS) to communicate t=
o
> > > > HSM service if it was safe to write to fs in the context of event h=
andling.
> > > >
> > > > At the moment, I cannot think of any elegant way out of this use ca=
se
> > > > except annotating the event from fault_in_readable() as "unsafe-for=
-write".
> > > > This will relax the debugging code assertion and notify the HSM ser=
vice
> > > > (via an event flag) that it can ALLOW/DENY, but it cannot fill the =
file.
> > > > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > > > this case to HSM service.
> > > >
> > > > WDYT?
> > >
> > > I think that mmap was a mistake.
> >
> > What do you mean?
> > Isn't the fault hook required for your large executables use case?
>
> I mean the mmap syscall was a mistake ;).
>

ah :)

> >
> > >
> > > Is there a way to tell if we're currently in a path that is under fsf=
reeze
> > > protection?
> >
> > Not at the moment.
> > At the moment, file_write_not_started() is not a reliable check
> > (has false positives) without CONFIG_LOCKDEP.
> >

One very ugly solution is to require CONFIG_LOCKDEP for
pre-content events.

> > > Just denying this case would be a simpler short term solution while
> > > we come up with a long term solution. I think your solution is fine, =
but I'd be
> > > just as happy with a simpler "this isn't allowed" solution. Thanks,
> >
> > Yeh, I don't mind that, but it's a bit of an overkill considering that
> > file with no content may in fact be rare.
>
> Agreed, I'm fine with your solution.

Well, my "solution" was quite hand-wavy - it did not really say how to
propagate the fact that faults initiated from fault_in_readable().
Do you guys have any ideas for a simple solution?

Thanks,
Amir.

