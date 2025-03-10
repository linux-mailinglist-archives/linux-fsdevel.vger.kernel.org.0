Return-Path: <linux-fsdevel+bounces-43654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C32A5A29F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973D6175A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245823372C;
	Mon, 10 Mar 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxIi/1Wm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA871C3F34;
	Mon, 10 Mar 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630926; cv=none; b=pGfD8l+qyXuUePiCoi1E/GuZx3te7Nx5dDIyVkxJSCyaHRFbIlSpdmdRy5S5kMZzWJCQwAVDAAEs0De7Yp2tVK46okzefZQcn6sfdL1lCQQoItSedqI+AkcgbuuusqlYJN4CXNkH4n3UwE9XmrVcphH39fHB6CVDJcZwvzoF8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630926; c=relaxed/simple;
	bh=SkjOumrPZ8pqrIzJ1V5CWQluO4ng3WvoP3slVoeW3oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWCdOY4FMrd61/npqd4D5pCxSWV9c9AKKclE6/6OCJ1v6e0qYZbGwVJs/TgnSYHqQ5/R6NHXjyHAeQnFE3FAywdQypJvlNIiGqgjPThaTq+CJSGE93NcKZKrCtnzmUTjcLpyn8M3txTPCq/UCsFK4qsi3urDOzeflAijnKH1CTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxIi/1Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226E6C4CEEE;
	Mon, 10 Mar 2025 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741630926;
	bh=SkjOumrPZ8pqrIzJ1V5CWQluO4ng3WvoP3slVoeW3oo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HxIi/1Wm03gmXfbzvtISFLsBvvMmetPAt7JCEgwfvNoUzzLDa3+BP9lJGcUMokP4q
	 RdQJ2Tl9dTM0bT69Z0dDvbOArqtmgpsH8pBpn0NULzDOJIA3K6O/ZsNRAumVqIYfNr
	 eBe2NpfkqSeve02qTaKaWuzSuRrJ7wLGUc4GKxsm5MExMBnPSrq9y74PTgWgf0A13g
	 ENgga/+BHraI2lPfLeev3b+en4iA5flMP5OEAVrMiu1P7FgQktLlpdI5tMGJD0ptcD
	 Pv13FGAvCSA0n7YPSpatPKhw+MaM68+nDRq3Nxe3vkaqM00oBB9k8/j6D6F5icuQfB
	 9dXLxcY9RhJ4A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54943bb8006so5118691e87.0;
        Mon, 10 Mar 2025 11:22:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdsfrFssH/M8nNjTo7PCKnMBVXR69v5o+Qc84TnJ7/JGqQ+uUYVhf5S8WxcCwSO/SJJMrX6maeb+Y=@vger.kernel.org, AJvYcCWD9aV4MVfa3aTwHJtFJse7G0g1nOxUXmL4SsMyloX4o4XFAJY42HT23j5mw7LnEkEfKG7+g88Wo/N1tmJkMw==@vger.kernel.org, AJvYcCWwIgH5oU00PJuvDOqsI9wXcck+IX7HCl/uwGR0MEW4zJNn0tzIPi+LbgaI5lTxnsD5bmLw6J+Y/v7fm11A@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJC/IRaHu7U48LPg2cvkJeNnnc+aFSOdmeDib3iCdfpGDEQoW
	hGobT09OV1Jcfm3Dhfp5uxY5FByW4Wyi7T7AK2s1aolpcQRjW4+0vg8YExaKYvJrhwE9lx78xXQ
	4b0Dt1qXRcYRPzEbcvXpn1GPYVYM=
X-Google-Smtp-Source: AGHT+IF7GoDCUbQdzcJ6DIyWWAIySKv+qn9qgrauGfCi9A1X9uKn03VlhxmcPGNsWa43LGR/2J4P1S95NSjRQdBl51Q=
X-Received: by 2002:a05:6512:b14:b0:545:532:fd2f with SMTP id
 2adb3069b0e04-54990e5da2cmr4479337e87.12.1741630924469; Mon, 10 Mar 2025
 11:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd0276.050a0220.14db68.006c.GAE@google.com> <8cf7d7efdc069772d69f913b02e5f67feadce18e.camel@HansenPartnership.com>
In-Reply-To: <8cf7d7efdc069772d69f913b02e5f67feadce18e.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Mar 2025 19:21:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
X-Gm-Features: AQ5f1JrLbe1rn0WB5HUKTnGtdoEau4kOg9QVT7Mpm8s0v1YpGXXtA4_W0dv3ECE
Message-ID: <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>, jk@ozlabs.org, 
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 17:50, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sat, 2025-03-08 at 18:52 -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-
> > next/p..
> > git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-
> > kernelci
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=14ce9c64580000
> > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=019072ad24ab1d948228
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> > Debian) 2.40
> > userspace arch: arm64
> > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=111ed7a0580000
> > C reproducer:
> > https://syzkaller.appspot.com/x/repro.c?x=13b97c64580000
> >
> > Downloadable assets:
> > disk image:
> > https://storage.googleapis.com/syzbot-assets/3d8b1b7cc4c0/disk-e056da87.raw.xz
> > vmlinux:
> > https://storage.googleapis.com/syzbot-assets/b84c04cff235/vmlinux-e056da87.xz
> > kernel image:
> > https://storage.googleapis.com/syzbot-assets/2ae4d0525881/Image-e056da87.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > Reported-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com
> >
> > efivarfs: resyncing variable state
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.14.0-rc4-syzkaller-ge056da87c780 #0 Not tainted
> > --------------------------------------------
> > syz-executor772/6443 is trying to acquire lock:
> > ffff0000c6826558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at:
> > inode_lock include/linux/fs.h:877 [inline]
> > ffff0000c6826558 (&sb->s_type->i_mutex_key#16):4}, at:
> > iterate_dir+0x3b4/0x5f4 fs/readdir.c:101
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&sb->s_type->i_mutex_key#16);
> >   lock(&sb->s_type->i_mutex_key#16);
> >
> >  *** DEADLOCK ***
>
> I can't figure out how you got here.  the shared lock in readdir.c is
> on the directory and the inode_lock in the actor is on the files within
> the directory.  The only way to get those to be the same is if the
> actor gets called on the '.' element, which efivarfs_pm_notify is
> supposed to skip with the
>
>         file->f_pos = 2;        /* skip . and .. */
>
> line.  Emitting the '.' and '..' in positions 0 and 1 is hard coded
> into libfs.c:dcache_readdir() unless you're also applying a patch that
> alters that behaviour?
>

The repro log also has

program crashed: BUG: unable to handle kernel paging request in
efivarfs_pm_notify

preceding the other log output regarding the locks, so the deadlock
might be a symptom of another problem.

