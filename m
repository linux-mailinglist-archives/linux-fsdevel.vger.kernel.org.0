Return-Path: <linux-fsdevel+bounces-19187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F38C1186
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C25C1F21E1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69D15CD7D;
	Thu,  9 May 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRy4DqfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CC3A8CB;
	Thu,  9 May 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266356; cv=none; b=S5sU9AyMvKhH/dSEYG9XQ/1vuIe7RCIsXO+tUWRgEBiTXSQH5Ci3q6UAQJhp6wxR2rRCa96GBG92aPXNjy0LyGoJLdFDRz06eFMfMyKXtqIH4XqNpKd+gs2gWqNgC0eC7KUJTphofayFoj7OWwCY75rs7Dc467KCFd275RBsMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266356; c=relaxed/simple;
	bh=HNc9XbbgS2dUmbPVOOp70WxEHGidcNobnCHsVzb0ViM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJC0SfgdsTot0rz30DkM8Ixil12JCYWjMd9gbF6e13ZYpCTRPwkhFZm6W/LnTAls7doR188sVS85q8LvleEPZiR+DyJCD8CFtKav4lXARb0UqEoBvCnOmCk3E1/BjSKNqRf8qj8d4cv6OPXTU/LVBzEGW+piNOnQ9/p1XObaLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRy4DqfX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792c031ffdeso47082785a.2;
        Thu, 09 May 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715266353; x=1715871153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhlR7+SOVypTDb9MtbmoK6AZhtMXL00cn78hl+eDd+o=;
        b=RRy4DqfXIexXSN1xBhHlbLpH+ZfqMMuHCiDglXipDDDd9Zja2gJ4y0eW/N+kvuHZvY
         zet/uAEhyYaipW3rhhkBYCm0bUZIOvsaft9AIiDDN4TuAVW9+kFyV9y67srz9LDSzZMx
         ireoMAzDr/sF0i7aneydSuKBVO1K+3G/w76rTT2s99WvPVkFWQaFbelkHjFYRXYUpdm/
         xJirafV/EBEq1FQUDziHPO+PUU897xTD7z2ZqUggSaVgNlYlC1T1thL8LsRpk0dR/Z5i
         2SXZrgGvp1IRBvi/F3SwmlEv63nrHkMz5XsnbK4KWm943mQjiQQNMLPU4p/WW+54OQE0
         vdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715266353; x=1715871153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhlR7+SOVypTDb9MtbmoK6AZhtMXL00cn78hl+eDd+o=;
        b=NTCbCPG0tqwJtJpQ6hBQyMyR1PSGaRbglNqnBORffRnl9j3ukzqaFu+5sZHmiZEIYT
         HNpOY8Pthlh4hPVkRLflbBiw2PflLfn95+QMuvLWIsX2YaNx/G6/QXyuCb0Kn5WZGCZE
         NzU8MgwMVpSaA1l6+vZ5HWvJMB7gvU/BFrEWLc2xgaeEEqK9wXhn5dUjG66wXfut8Qhl
         vayKX7HobW4N3s9z8Y3uzIwcb4rlPScIDI+ML/1dXHhRLvJZ5LSIdM7Kc+mwi7/bMs5i
         BrBs6+qj8td2yZbGmup3qh+KRW9Ay7r72MQplcIiFEIoxhU7LZlPAfizeOsmX6BiNSeK
         qV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCYnW9O0Sgx+Gotmz2d9pVIASpTBenR66lhvZCwBC1mhrZbwFzTohLECYByWM0vQOPSN8Lpgc7iDcY9iiXCyTqs4urkT8IOQPubuDRR7UfCnX3+eZlND5H8c0y+ZjZyDtg4gVL7zGLdBWmONfK9SXFImxNlYhekiBoavS7PzDCxnLAh7ub
X-Gm-Message-State: AOJu0YzXjr9GSlSpngzwFBfRpwmv8SOU+f7TvldzS0waH6WlNePjy1X9
	PybxtxBxiBCfgRQANwld8TzxkufF3yVj+2/Mx0eQXExJ121x2C44eCqJUtBnmszbyplF5rzQs2T
	5U0qYaJdANoxxBbDksho1MHVIJ/M=
X-Google-Smtp-Source: AGHT+IFIEc05OqxcxSaNYPjKcycOmNxclvYY9HSZOIMajfAr/kWSClbeiNApoVPlOyfgpL25BlczauH8RUoLGBRyLuY=
X-Received: by 2002:a05:6214:c63:b0:6a0:b3cc:ee0f with SMTP id
 6a1803df08f44-6a1514c26c2mr57720126d6.43.1715266352877; Thu, 09 May 2024
 07:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000091228c0617eaae32@google.com> <20240508231904.2259-1-hdanton@sina.com>
 <CAOQ4uxhDBbSh-4xbLgS=e6LtaZe2-E9Scgb9uP4ysCZEGG2skA@mail.gmail.com> <20240509104848.2403-1-hdanton@sina.com>
In-Reply-To: <20240509104848.2403-1-hdanton@sina.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2024 17:52:21 +0300
Message-ID: <CAOQ4uxg8karas=5JxmCg0P5Wxhfzn41evgs_OUxd1GxBRpb4zQ@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:49=E2=80=AFPM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Thu, 9 May 2024 09:37:24 +0300 Amir Goldstein <amir73il@gmail.com>
> > On Thu, May 9, 2024 at 2:19=E2=80=AFAM Hillf Danton <hdanton@sina.com> =
wrote:
> > > On Tue, 07 May 2024 22:36:18 -0700
> > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://g=
it.kern..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D137daa6=
c980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d7ea7d=
e0cb32587
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4c493dcd5=
a68168a94b2
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1134f=
3c0980000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1367a50=
4980000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/ea1961ce01=
fe/disk-dccb07f2.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/445a00347402/=
vmlinux-dccb07f2.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/461aed7c=
4df3/bzImage-dccb07f2.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: possible circular locking dependency detected
> > > > 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0 Not tainted
> > > > ------------------------------------------------------
> > > > syz-executor149/5078 is trying to acquire lock:
> > > > ffff88802a978888 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x5=
3/0x3b0 fs/kernfs/file.c:154
> > > >
> > > > but task is already holding lock:
> > > > ffff88802d80b540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd=
60 fs/seq_file.c:182
> > > >
> > > > which lock already depends on the new lock.
> > > >
> > > >
> > > > the existing dependency chain (in reverse order) is:
> > > >
> > > > -> #4 (&p->lock){+.+.}-{3:3}:
> > > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > > >        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> > > >        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> > > >        seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
> > > >        call_read_iter include/linux/fs.h:2104 [inline]
> > > >        copy_splice_read+0x662/0xb60 fs/splice.c:365
> > > >        do_splice_read fs/splice.c:985 [inline]
> > > >        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
> > > >        do_sendfile+0x515/0xdc0 fs/read_write.c:1301
> > > >        __do_sys_sendfile64 fs/read_write.c:1362 [inline]
> > > >        __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
> > > >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > -> #3 (&pipe->mutex){+.+.}-{3:3}:
> > > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > > >        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> > > >        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> > > >        iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
> > > >        backing_file_splice_write+0x2bc/0x4c0 fs/backing-file.c:289
> > > >        ovl_splice_write+0x3cf/0x500 fs/overlayfs/file.c:379
> > > >        do_splice_from fs/splice.c:941 [inline]
> > > >        do_splice+0xd77/0x1880 fs/splice.c:1354
>
>                 file_start_write(out);
>                 ret =3D do_splice_from(ipipe, out, &offset, len, flags);
>                 file_end_write(out);
>
> The correct locking order is
>
>                 sb_writers

This is sb of overlayfs

>                 inode lock

This is real inode

See comment above ovl_lockdep_annotate_inode_mutex_key()
for more details.

Thanks,
Amir.

