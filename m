Return-Path: <linux-fsdevel+bounces-16711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDDB8A1C0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19061F225E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B461514EE;
	Thu, 11 Apr 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNd/H66f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB72E415;
	Thu, 11 Apr 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851634; cv=none; b=adb0ZqSr1BWcGS2n54N+w6iCH4eWCaKObJKd+6pGsRl5Q3lK39lwzc3761x6VP+dM1cuqyMX5iNLrnoDjuYG+5gAtCZcqXonHp7DoxRNhpjyNKQF5tTRIU4GnvEaWTQFF9OT6Cx1UnboWmQjj5Peg0gFx+/wDs1RQgvbanGrvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851634; c=relaxed/simple;
	bh=5PGOcfSSdDYshGRmZx13mgK8FTOFF2BORnZNhaSwLC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbGI3dR5Jy9auYArWmgzeztJsgvex4aQsrJcLTu0KseE4BGatY1lpar90KSbW8ixm1IJcat8q1KC0ojhJASoUFtK6yfraxMQiQ7sJH9Ju+pmes//C5KypH+C9YIqWgyhEkWcAfOOqtsmZq/to/5vq5yFLridirwVAyheX8w65dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNd/H66f; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69629b4ae2bso223296d6.3;
        Thu, 11 Apr 2024 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851632; x=1713456432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCJL7Yhjai6trMhKxfXz5O8cCLAAGPaww8mADW8uTPk=;
        b=YNd/H66fgtx61ngunZcjWPx1iYIFMoGis/uPkUeU5fl0pTfwZMNwDrMWfB2xojO5Lp
         84d9PQ/+rVPBXAkM6UbRqn4zXQGHPlXxEUHbdTgTEFqyxak48aZ6BlqvSZgE4qcTv49C
         sjYr8VqxWs+WXZVe+UPb9+d33ymwDVO91XSr5kVM/JR3t2CU8RHdt0LL+oZF+0jhc6e5
         w+poypX43o7BTcYfCJAhkZ27RBYywfdtni5kVKY6VwAxkorKLTGrDW45ptmMJ8H5kONV
         zZlTyqzNFNMLF7ZjyLdmS9QdTxA+w3kSxkISrQhZHf91oIoOrTTG9TKAjK7ybn2zBjO7
         O5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851632; x=1713456432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCJL7Yhjai6trMhKxfXz5O8cCLAAGPaww8mADW8uTPk=;
        b=V7n4IbtBTN635XUX191CRCxccuTbWH7Xua6NSA8qyBKB2AVBP7t2akx990ZU5SYiZ6
         5SWuH6UuCSQtiIel20oear+ECHGy6S0cBUJZzvyapf19+KdMna8xrGu/f8lrdoCyLS6m
         PyBRGZakEV+LvnNOeb6W4tiykC8bUWUzRlKrXioSX6WEgAu2OGSAgF4Yuf1l1q3h51xm
         zqleX5uVGa9W8TutQGf0qksBBF1Mu7n9xrcQd3eV8k7nH2bz0GrFlA71WyvFy0fMoUdV
         OY0F0US0iFZh8LzdRizz3dpVJkqN4tlUaPds0Z1LMAuRMmaiaJNVEQ/TjcQZ9FCxE6o9
         Ddmw==
X-Forwarded-Encrypted: i=1; AJvYcCV6PJ68Mo1pDfSv6v4aq/HIfKiYx++e7bSFT70ISioN82kPkKWCBrR9JKPdp5cP4gjam7bKopJojFdFiFYjO4LFHz/7lVUGyoDP+LcQ2NLeNo8DK9dIcIZhzaf17Ae5X5na0Ff8IdYv2AqC9oAGMXCgYkiDFAD4aUv1yv8D46j9wuSj0wiE/1M=
X-Gm-Message-State: AOJu0YxasVzQKRXK9KF8C45+YibQKcVy9o/yApSvWXP4pnt1c4MA/1cy
	AO3xvVwN/d0mwLbwCSkL5YgkOTh+ePlmdoJoGQlCg1N8P86FDLJzWgrUrpe8chr8+eJzM9cvFrb
	ET/dfHkr0YUlXR8AbFind7VPSB1Q=
X-Google-Smtp-Source: AGHT+IHGB8ZcfvsLjGVcI1/X1Vol3VjdRqvuRMFmABVLbUb66s7gO1K52gIUaCsdklEC72iOo7wpwSMBZ7zYSw5fRkU=
X-Received: by 2002:ad4:53c7:0:b0:699:1877:b0fb with SMTP id
 k7-20020ad453c7000000b006991877b0fbmr129384qvv.3.1712851632384; Thu, 11 Apr
 2024 09:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000042c9190615cdb315@google.com> <20240411121319.adhz4ylacbv6ocuu@quack3>
In-Reply-To: <20240411121319.adhz4ylacbv6ocuu@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Apr 2024 19:07:00 +0300
Message-ID: <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com, Gabriel Krisman Bertazi <krisman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:13=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 11-04-24 01:11:20, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12be955d180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D16ca158ef7e=
08662
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a67b45=
f16d4e6
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c911751=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/b050f81f73ed/d=
isk-6ebf211b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/412c9b9a536e/vmli=
nux-6ebf211b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/016527216c47=
/bzImage-6ebf211b.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/75ad050c=
9945/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> >
> > Quota error (device loop0): do_check_range: Getting block 0 out of rang=
e 1-5
> > EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworker/u8:=
4: Failed to release dquot type 1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in fsnotify+0x2a4/0x1f70 fs/notify/fsno=
tify.c:539
> > Read of size 8 at addr ffff88802f1dce80 by task kworker/u8:4/62
> >
> > CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-20240410-s=
yzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > Workqueue: events_unbound quota_release_workfn
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
> >  fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
> >  __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
> >  ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
> >  quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
> >  process_one_work kernel/workqueue.c:3218 [inline]
> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
>
> Amir, I believe this happens on umount when the filesystem calls
> fsnotify_sb_error() after calling fsnotify_sb_delete(). In theory these t=
wo
> calls can even run in parallel and fsnotify() can be holding
> fsnotify_sb_info pointer while fsnotify_sb_delete() is freeing it so we
> need to figure out some proper synchronization for that...

Is it really needed to handle any for non SB_ACTIVE sb?
How about something like this?
Is that enough? or more synchronization is needed?

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Thanks,
Amir.

