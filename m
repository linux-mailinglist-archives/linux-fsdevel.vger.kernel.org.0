Return-Path: <linux-fsdevel+bounces-43655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEBA5A2DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E4D1738E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422EB23535A;
	Mon, 10 Mar 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngwhcv3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFF233D98;
	Mon, 10 Mar 2025 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631096; cv=none; b=hWsKl6nRI8KDloltttSqSqxjpVe9qTEROra7uVS78XImXP8Kb+Zi+wQZSNDcVvfUqkMT9/itqRopoeeQLZi32H4omtqhjC6bWFuD3I4M30AfPppaJ+xSGws2ZsGFkKrGo5PhnGbWH5PKPro+ZZGnUCgMGyC2ISmirssryvyEtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631096; c=relaxed/simple;
	bh=IkGd7DLrk2ypLCT9DhcVtWOLsLwvcrPe7Zl9iOboKg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWrqybWwG7mKXpVwleM3SW4ryxzTarFKJi5LhTKSeYpJ/rmkWZfLjUyWLqv1GyQpu8baArZ8CHxyJLatuvvnFFO8dpxIpqBSfDkJt3gali4+VmRPKfKUZpy5XbQHBODhdTTUCnFX4Ss69jNJnQ2uv6QHx8rgIOZYp6NcJakj07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngwhcv3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCAAC4CEEC;
	Mon, 10 Mar 2025 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631096;
	bh=IkGd7DLrk2ypLCT9DhcVtWOLsLwvcrPe7Zl9iOboKg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ngwhcv3BBxZOn17k3Nr2ahQxspTK7eZxkThDzamNsjJniSP80hUhfhEqyc6jYskBk
	 I9v6rWag7ijnmPCL8VIp9Df6oO/UBMgMWVhorw8h5TYIovhX/KRtkvYl/nbo7Nt//q
	 FFq3mTkPn8T9DfG7HQwHlHqBLpN3zEYvs8htN4jfQ1+NQve56Eo4G89n7sCEZocS61
	 bIs0LilUq1Pdwa3Yzl9G/3FLP96DZ/Go1+OsqXYU+h52mBBfuuzLOaOHYkwymROy9w
	 XOo9E2OxG4Rc/APv2sdl0Gt5Ozlfy8g+iRhNOFSvYS6filL6rMC7NDUp+JxbtPryNL
	 zBjjCUlWZMQmg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549967c72bcso3126293e87.3;
        Mon, 10 Mar 2025 11:24:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxus5DaYZXGnJtX3DAL6zsDqh8+nxpBTuTLR57nBcRqB9F41Z1X71SXSwja9Cq66jduLK+xj2hdR3NtWEL@vger.kernel.org, AJvYcCX0JHM3ThhE64eMXWrMrEmpzKg8eQF8JrCGEjZ8jBHrHNHAbTG0AhUlz3LXA0u9Kpqpjr9cADK9Ik/TK+AAlw==@vger.kernel.org, AJvYcCXu4A4kNUqO/hHx0buQCNUsDIFVvlm91KNnuRNsqp1fpUIsATkbV9HBvVPOXQXFW4GLp2dW5bn/eVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiALLlqFaZ/9CWjx8TT4cUYl108OIL09xfUef9On0iw41eMZ/+
	QR7DyLAHOzQfc8QI71bSm2sctkUtk0C6zBWnUNUWAHabyxGCsuZYOXfGk7tqIbRHmIjE62pG46D
	x19Eh6jcT4p6W2zcxWmv8jiwW78Q=
X-Google-Smtp-Source: AGHT+IEYVX/TK3hkXMZJ+vXbq9P9RIUDJi2lu9r1F0cMejB1V+b4vDNeCWZM2Il+u9q9HjZn/hR39ZvBd/um7iOropM=
X-Received: by 2002:a05:6512:3993:b0:549:792a:a382 with SMTP id
 2adb3069b0e04-549910b59bdmr4658691e87.32.1741631094697; Mon, 10 Mar 2025
 11:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd0276.050a0220.14db68.006c.GAE@google.com> <8cf7d7efdc069772d69f913b02e5f67feadce18e.camel@HansenPartnership.com>
 <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
In-Reply-To: <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Mar 2025 19:24:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEfG=Q3pk6PsVZxf5qCjEBTwTjUCJcNwBPO3PqNmSp=hw@mail.gmail.com>
X-Gm-Features: AQ5f1Jqwty5yqdg2G3GZwGtOQrAbPKtEBOr05ar2n3rX90ReMnstOFG_G9GGZqE
Message-ID: <CAMj1kXEfG=Q3pk6PsVZxf5qCjEBTwTjUCJcNwBPO3PqNmSp=hw@mail.gmail.com>
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>, jk@ozlabs.org, 
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 19:21, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 10 Mar 2025 at 17:50, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Sat, 2025-03-08 at 18:52 -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-
> > > next/p..
> > > git tree:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-
> > > kernelci
> > > console output:
> > > https://syzkaller.appspot.com/x/log.txt?x=14ce9c64580000
> > > kernel config:
> > > https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=019072ad24ab1d948228
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> > > Debian) 2.40
> > > userspace arch: arm64
> > > syz repro:
> > > https://syzkaller.appspot.com/x/repro.syz?x=111ed7a0580000
> > > C reproducer:
> > > https://syzkaller.appspot.com/x/repro.c?x=13b97c64580000
> > >
> > > Downloadable assets:
> > > disk image:
> > > https://storage.googleapis.com/syzbot-assets/3d8b1b7cc4c0/disk-e056da87.raw.xz
> > > vmlinux:
> > > https://storage.googleapis.com/syzbot-assets/b84c04cff235/vmlinux-e056da87.xz
> > > kernel image:
> > > https://storage.googleapis.com/syzbot-assets/2ae4d0525881/Image-e056da87.gz.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the
> > > commit:
> > > Reported-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com
> > >
> > > efivarfs: resyncing variable state
> > > ============================================
> > > WARNING: possible recursive locking detected
> > > 6.14.0-rc4-syzkaller-ge056da87c780 #0 Not tainted
> > > --------------------------------------------
> > > syz-executor772/6443 is trying to acquire lock:
> > > ffff0000c6826558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at:
> > > inode_lock include/linux/fs.h:877 [inline]
> > > ffff0000c6826558 (&sb->s_type->i_mutex_key#16):4}, at:
> > > iterate_dir+0x3b4/0x5f4 fs/readdir.c:101
> > >
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0
> > >        ----
> > >   lock(&sb->s_type->i_mutex_key#16);
> > >   lock(&sb->s_type->i_mutex_key#16);
> > >
> > >  *** DEADLOCK ***
> >
> > I can't figure out how you got here.  the shared lock in readdir.c is
> > on the directory and the inode_lock in the actor is on the files within
> > the directory.  The only way to get those to be the same is if the
> > actor gets called on the '.' element, which efivarfs_pm_notify is
> > supposed to skip with the
> >
> >         file->f_pos = 2;        /* skip . and .. */
> >
> > line.  Emitting the '.' and '..' in positions 0 and 1 is hard coded
> > into libfs.c:dcache_readdir() unless you're also applying a patch that
> > alters that behaviour?
> >
>
> The repro log also has
>
> program crashed: BUG: unable to handle kernel paging request in
> efivarfs_pm_notify
>
> preceding the other log output regarding the locks, so the deadlock
> might be a symptom of another problem.

And one of the other logs has

[   47.650966][ T6617] syz.2.9/6617 is trying to acquire lock:
[   47.652339][ T6617] ffff0000d69f6558
(&sb->s_type->i_mutex_key#25){++++}-{4:4}, at:
efivarfs_actor+0x1b8/0x2b8
[   47.654943][ T6617]
[   47.654943][ T6617] but task is already holding lock:
[   47.656931][ T6617] ffff0000f5b84558
(&sb->s_type->i_mutex_key#25){++++}-{4:4}, at: iterate_dir+0x3b4/0x5f4

where the locks have the same name but the address is different.

So there is something dodgy going on here, and I'm inclined to just ignore it.

