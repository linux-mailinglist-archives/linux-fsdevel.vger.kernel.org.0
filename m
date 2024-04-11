Return-Path: <linux-fsdevel+bounces-16748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB88A2037
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434621F22807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F553199B0;
	Thu, 11 Apr 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0OLAO0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594221CF87
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867249; cv=none; b=tPEQsvtckiJfMxGpTHNYdLnQWeP+yM6uC2S46cACPS2QYIjqqdPPa8hWpTVWd9LshY0bE/GPWsKjWpDovlUTC+Wo1FDvcR1a+2GDOUqfxZVtnhbrXISV/J/iK5z0tshGjhijfRW+/KjGcB0OEA88mLo7eTJrBY02kUng3no3T6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867249; c=relaxed/simple;
	bh=l6Zg8E5l9E7YNNsH7iIZ4LMXwRy2isDpxVf8d7paD+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAbKdzBt26Zmdt/7EzWcAVEp/0qnMyLAdTUf/7b76RiPL48yO3MrZmeqj0V5wmuQ2pnLSY1piRk/Wj5SFTIWxYqqMxPt8zhK/UDi5811mf7X+r7hKARPmWFkGurwxwkyA0a7GYpP+xqtexj5th4h4IsPHC/rNHPQZo+wacTjon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A0OLAO0v; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47a0bebeacaso100215137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712867246; x=1713472046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnP8JVadrwUCkWdsPrjw1n1Qkf19BHzW9gV2hIgU+kk=;
        b=A0OLAO0vUbboK5mhCquWaRInaJmJqcCCEQhl13HPTOeNWyDWDVUuPWrkWpuFlv/alB
         H9POk+4jcQBO/p+WZIN+3qifxrLSClSoQ9jAPMmqqAzyHRsqMeHknP3CYrz9Falh9jRk
         HY+TeJ6tUHbwEoe5RBnK6pqIpR6A3hb1+EMEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867246; x=1713472046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnP8JVadrwUCkWdsPrjw1n1Qkf19BHzW9gV2hIgU+kk=;
        b=DJckR0J1ZCkZ9C8vt80Nyav1T54XcQHRmQVAo4o8gyaEg1Z5rBuIPvBU9Z+7/i1sJH
         N/lcPZukQEixuUOyvP4qM9hT03C8EDQgAk+q/Yn5gao2GKT1j8venMNoEr/QnqnPKn+B
         bHdxR8pzNOVeZ+yi7o/FnQK2xY6cCHcurvr3+ZVPPH94EKKccnicNGpN9l6wnKVBM74k
         MIL9Ex0CF6q9KG6W6Lg0hW8lJzxQWzN/10oDA46NejspsrWyITHQLGEv0K3CWKIYA7Ne
         KGo4HV8n24roQQdPo1BrndUaXvI0/kHy0cfPzj/KoU07rNmNlunsLFRgzGZErt/8LM4w
         Uayg==
X-Forwarded-Encrypted: i=1; AJvYcCVVog57D8NymNOXpLeeGXkr2I1UtNORYTZ3PwBg1t2okh+Yx+S/hRcFS/sA0TEMJVuR5EPV+DPRhE6K7Yga7DMRpaeRPaEPzGFn0w+2IQ==
X-Gm-Message-State: AOJu0YxMOpwyXxFbHzNcfqV4TsXbWfWZAmcyQvBixzlTGH5FiVz2Ooeh
	3h4VQ7QzTSS6XMPnRddf9l83IiIPzyfnc4iAnBmt8EFvhxRkW0L3sq7Iobp6qdbWaIm7gPl7O6M
	=
X-Google-Smtp-Source: AGHT+IENlxYltLvjgs8DVFBg0/oBNiZd44mr1JyBEV1llqmcR96Nc6b7cbZaov2STll5cb///NehhA==
X-Received: by 2002:a05:6102:cd2:b0:47a:3ac5:c839 with SMTP id g18-20020a0561020cd200b0047a3ac5c839mr1109424vst.13.1712867246545;
        Thu, 11 Apr 2024 13:27:26 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id u12-20020a0562140b0c00b00699410d2991sm1352311qvj.66.2024.04.11.13.27.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:27:26 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43477091797so12171cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW3XMd4ISjct8ME0dI2+yVjjW7LqydEkscK+2IQvQA/M4/TYN9R8HB7WIaTMN0qqtWWWZA5EmLSHcTwirrUywDkYkYo0RaCPtGSY8Iaw==
X-Received: by 2002:a05:622a:5a13:b0:436:5ce5:cfc5 with SMTP id
 fy19-20020a05622a5a1300b004365ce5cfc5mr71333qtb.2.1712867245457; Thu, 11 Apr
 2024 13:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000042c9190615cdb315@google.com> <20240411121319.adhz4ylacbv6ocuu@quack3>
 <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com> <875xwn8zxa.fsf@mailhost.krisman.be>
In-Reply-To: <875xwn8zxa.fsf@mailhost.krisman.be>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Thu, 11 Apr 2024 13:27:12 -0700
X-Gmail-Original-Message-ID: <CACGdZYLJESbS6VCAza_V6PAeNb8k9nU2wYhBi-KmeYqYJ337mA@mail.gmail.com>
Message-ID: <CACGdZYLJESbS6VCAza_V6PAeNb8k9nU2wYhBi-KmeYqYJ337mA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:25=E2=80=AFPM Gabriel Krisman Bertazi
<krisman@suse.de> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Apr 11, 2024 at 3:13=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >>
> >> On Thu 11-04-24 01:11:20, syzbot wrote:
> >> > Hello,
> >> >
> >> > syzbot found the following issue on:
> >> >
> >> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240=
410
> >> > git tree:       linux-next
> >> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12be955d=
180000
> >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D16ca158e=
f7e08662
> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a67=
b45f16d4e6
> >> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils fo=
r Debian) 2.40
> >> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c911=
75180000
> >> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d=
180000
> >> >
> >> > Downloadable assets:
> >> > disk image: https://storage.googleapis.com/syzbot-assets/b050f81f73e=
d/disk-6ebf211b.raw.xz
> >> > vmlinux: https://storage.googleapis.com/syzbot-assets/412c9b9a536e/v=
mlinux-6ebf211b.xz
> >> > kernel image: https://storage.googleapis.com/syzbot-assets/016527216=
c47/bzImage-6ebf211b.xz
> >> > mounted in repro: https://storage.googleapis.com/syzbot-assets/75ad0=
50c9945/mount_0.gz
> >> >
> >> > IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
> >> > Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> >> >
> >> > Quota error (device loop0): do_check_range: Getting block 0 out of r=
ange 1-5
> >> > EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworker/=
u8:4: Failed to release dquot type 1
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > BUG: KASAN: slab-use-after-free in fsnotify+0x2a4/0x1f70 fs/notify/f=
snotify.c:539
> >> > Read of size 8 at addr ffff88802f1dce80 by task kworker/u8:4/62
> >> >
> >> > CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-2024041=
0-syzkaller #0
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 03/27/2024
> >> > Workqueue: events_unbound quota_release_workfn
> >> > Call Trace:
> >> >  <TASK>
> >> >  __dump_stack lib/dump_stack.c:88 [inline]
> >> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >> >  print_address_description mm/kasan/report.c:377 [inline]
> >> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >> >  fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
> >> >  fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
> >> >  __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
> >> >  ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
> >> >  quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
> >> >  process_one_work kernel/workqueue.c:3218 [inline]
> >> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
> >> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
> >> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >> >  </TASK>
> >>
> >> Amir, I believe this happens on umount when the filesystem calls
> >> fsnotify_sb_error() after calling fsnotify_sb_delete().
Hmm, so we're releasing dquots after already shutting down the
filesystem? Is that expected? This "Failed to release dquot type"
error message only appears if we have an open handle from
ext4_journal_start (although this filesystem was mounted without a
journal, so we hit ext4_get_nojournal()...)
> In theory these two
> >> calls can even run in parallel and fsnotify() can be holding
> >> fsnotify_sb_info pointer while fsnotify_sb_delete() is freeing it so w=
e
> >> need to figure out some proper synchronization for that...
> >
> > Is it really needed to handle any for non SB_ACTIVE sb?
>
> I think it should be fine to exclude volumes being teared down.  Cc'ing
> Khazhy, who sponsored this work at the time and owned the use-case.
In terms of real-world use case... not sure there is one - you'll
notice the errors when you fsck/mount again later on, and any users
who care about notifs should be gone by the time we're unmounting. But
it seems weird to me that we can get write errors shutting everything
down.
>
> --
> Gabriel Krisman Bertazi

