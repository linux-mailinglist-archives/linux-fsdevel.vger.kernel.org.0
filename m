Return-Path: <linux-fsdevel+bounces-16794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1043E8A2C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 12:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334461C21356
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1054772;
	Fri, 12 Apr 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfCm2mI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054754646;
	Fri, 12 Apr 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917504; cv=none; b=gIfKgY4S4aolDEigt8w2Bncs7VnQ1aXlg99d8Esl8fRdBg7eCcCbepAWMF5SpTSncWCPRo2FXN7DTau9aohPDXcTJw0MN/xZw3xx0/PuCdtHJM8XpNwgH+MJsA9t7EJdTGD96f5AGF2Cc1aqxQqtRQZ4pCVEzwUboQ019zOtteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917504; c=relaxed/simple;
	bh=FI6PivxgPvrlGWfxc39bWEeLwYTaLLTEZfCmhrtJrvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WahDyJMfjEofaVWKlRXAqefY/5aGvUhOBrrvGJgolETrQXNIiln3lJax4llgFPKhb6DUF2hblY1FW5BbSljctAwCeF+28am3REs2dEEVo2bY12c4zOVS2wV2oy3f6T6gV/KhQRFzOzqD0Yp0QcGgFgFcV26TTn640TIY/fdeNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfCm2mI6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b50b8239fso4680476d6.0;
        Fri, 12 Apr 2024 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712917502; x=1713522302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miQDmesO/RBgoUpX1IHsaloLk8IF9hztcmdELINbAzk=;
        b=ZfCm2mI640DvXZvErkGuJQnORsTE8OJtWm6eB8z33KqBWaFBazexTQd4g4S0HZug57
         VmtlunZgILXBCN3lSsTKjqWCEy+LXfOdH5qI4iXV9kv29kKIt7++HsNuZmtd3x5VzUBp
         A2OabwBPOetzQw4pQseOVc/fSE7lCQGRklOThopncvhyOTDxfKtEZbnH5EIJt0SSGJ0S
         pEQjKQVPPZehT4tNegJgET24JrQyPb1593mUUQMUaOX4pHVLcMwE2smC47kj/gXRTnDa
         FK83DYf8Ma4nTvZv/+ksxR00mB4X44weU8pkNdpzQS6KZB3EVgUnTyxQuPm+Jmg2xZEc
         oICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917502; x=1713522302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miQDmesO/RBgoUpX1IHsaloLk8IF9hztcmdELINbAzk=;
        b=kuNAo24xwFpK7cevMPwJfKVmUi9gaoEcdGbn1dHv4CSTedISBWUdUfVqytoNmVEOeV
         kP9BNzeld1QPo6zapftbnjzSycXqu7bbrX/CCfBTZ7ycmdfJJQdD3Scx2AtCI+O3Gxfn
         Dq5JbEeLPh7CHrk2yjDZJZj1xw+1jrgHkCcQWVqsTwaYg9lu0sGlaYTdyG0cshiX3Ie2
         6oUSv7YK+nCjXMWYPSzJDv2fHyor/B/W1K4aXvN4hqtGk7dH8keh++0zSE4xE/OXC8O2
         w0TmwFxRsbXNE9rx1mBCL+XXfO2z+BFSY30rWkuPTvjKmjv7gw8CCp4kS0QFpWsf4DEk
         NBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU55ARdpqrzvBlOW1KuASiaLLqz/2SjSRNONYh0GRCVBmZ1R+Z1HqkC5OCw3ewLsUCI+Sabp9OpmsbcQLaVxT4jciMZM6T4M5C0T6hYbaC3Ic8yKGHR/6YomffGr19CJI4WS/KAEE93dV2yXQ3/UI1MpcLVlwDabrvZPvk/zFTZ1hTf0NEspCs=
X-Gm-Message-State: AOJu0YyCxFz8N57qqFioHNnBeMtHDpIaxlsmBZAEuPtGp2iiS7bCpubZ
	H6ETuy5Z3ZpMeiwkfsu23vyx/CMOagyk5QesMTzld2+qawRCjppSPcKfQhn8e7aNXAj7GCjuVQn
	YjHF7edghxOOC3IXDj+juVmXGIuE=
X-Google-Smtp-Source: AGHT+IGWQy3i+0q8X18gTJzvFH5ZkbhtlxQHxMUy5SC06zctHFldepd/giD11xVq17YF/GBManhuwTQ2w6v348IZNZk=
X-Received: by 2002:a05:6214:311:b0:69b:5f59:7bc0 with SMTP id
 i17-20020a056214031100b0069b5f597bc0mr106857qvu.16.1712917502317; Fri, 12 Apr
 2024 03:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000042c9190615cdb315@google.com> <20240411121319.adhz4ylacbv6ocuu@quack3>
 <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com>
 <875xwn8zxa.fsf@mailhost.krisman.be> <CACGdZYLJESbS6VCAza_V6PAeNb8k9nU2wYhBi-KmeYqYJ337mA@mail.gmail.com>
In-Reply-To: <CACGdZYLJESbS6VCAza_V6PAeNb8k9nU2wYhBi-KmeYqYJ337mA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Apr 2024 13:24:50 +0300
Message-ID: <CAOQ4uxiw9+0ZPNgbby0_WJzKrcCk79n-Xd1fOMtvsr022Z8EwA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, Jan Kara <jack@suse.cz>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:27=E2=80=AFPM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> On Thu, Apr 11, 2024 at 12:25=E2=80=AFPM Gabriel Krisman Bertazi
> <krisman@suse.de> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Thu, Apr 11, 2024 at 3:13=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > >>
> > >> On Thu 11-04-24 01:11:20, syzbot wrote:
> > >> > Hello,
> > >> >
> > >> > syzbot found the following issue on:
> > >> >
> > >> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 202=
40410
> > >> > git tree:       linux-next
> > >> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12be95=
5d180000
> > >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D16ca15=
8ef7e08662
> > >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a=
67b45f16d4e6
> > >> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils =
for Debian) 2.40
> > >> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c9=
1175180000
> > >> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af=
9d180000
> > >> >
> > >> > Downloadable assets:
> > >> > disk image: https://storage.googleapis.com/syzbot-assets/b050f81f7=
3ed/disk-6ebf211b.raw.xz
> > >> > vmlinux: https://storage.googleapis.com/syzbot-assets/412c9b9a536e=
/vmlinux-6ebf211b.xz
> > >> > kernel image: https://storage.googleapis.com/syzbot-assets/0165272=
16c47/bzImage-6ebf211b.xz
> > >> > mounted in repro: https://storage.googleapis.com/syzbot-assets/75a=
d050c9945/mount_0.gz
> > >> >
> > >> > IMPORTANT: if you fix the issue, please add the following tag to t=
he commit:
> > >> > Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> > >> >
> > >> > Quota error (device loop0): do_check_range: Getting block 0 out of=
 range 1-5
> > >> > EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworke=
r/u8:4: Failed to release dquot type 1
> > >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> > BUG: KASAN: slab-use-after-free in fsnotify+0x2a4/0x1f70 fs/notify=
/fsnotify.c:539
> > >> > Read of size 8 at addr ffff88802f1dce80 by task kworker/u8:4/62
> > >> >
> > >> > CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-20240=
410-syzkaller #0
> > >> > Hardware name: Google Google Compute Engine/Google Compute Engine,=
 BIOS Google 03/27/2024
> > >> > Workqueue: events_unbound quota_release_workfn
> > >> > Call Trace:
> > >> >  <TASK>
> > >> >  __dump_stack lib/dump_stack.c:88 [inline]
> > >> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > >> >  print_address_description mm/kasan/report.c:377 [inline]
> > >> >  print_report+0x169/0x550 mm/kasan/report.c:488
> > >> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> > >> >  fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
> > >> >  fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
> > >> >  __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
> > >> >  ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
> > >> >  quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
> > >> >  process_one_work kernel/workqueue.c:3218 [inline]
> > >> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
> > >> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
> > >> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > >> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >> >  </TASK>
> > >>
> > >> Amir, I believe this happens on umount when the filesystem calls
> > >> fsnotify_sb_error() after calling fsnotify_sb_delete().
> Hmm, so we're releasing dquots after already shutting down the
> filesystem? Is that expected? This "Failed to release dquot type"
> error message only appears if we have an open handle from
> ext4_journal_start (although this filesystem was mounted without a
> journal, so we hit ext4_get_nojournal()...)
> > In theory these two
> > >> calls can even run in parallel and fsnotify() can be holding
> > >> fsnotify_sb_info pointer while fsnotify_sb_delete() is freeing it so=
 we
> > >> need to figure out some proper synchronization for that...
> > >
> > > Is it really needed to handle any for non SB_ACTIVE sb?
> >
> > I think it should be fine to exclude volumes being teared down.  Cc'ing
> > Khazhy, who sponsored this work at the time and owned the use-case.
> In terms of real-world use case... not sure there is one - you'll
> notice the errors when you fsck/mount again later on, and any users
> who care about notifs should be gone by the time we're unmounting. But
> it seems weird to me that we can get write errors shutting everything
> down.

That's what I thought.
Anyway, my naive fix breaks IN_UNMOUNT event as well as some other
fanotify tests, so I will need to work on another fix.

Thanks,
Amir.

