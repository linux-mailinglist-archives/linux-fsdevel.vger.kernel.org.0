Return-Path: <linux-fsdevel+bounces-43548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99838A58547
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 16:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1345167AED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D51DE3C8;
	Sun,  9 Mar 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHTR5OHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306F1DE2C4;
	Sun,  9 Mar 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532600; cv=none; b=LMPB6GVsWhLJsmoDRfL18slihynRfJCsX7KChZ4UBD7/EcIHeZo4SgglCJB3Uxc/7rzZ5++ZgFJGAARXY06iQIG7AQi4sGak9VwoqSL7HFJfNLPWxS4nUt37BqwuTQUXv4C8yntk7ouMvxzHqIDQBEHvf0jEZE7kTVkuA7oxfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532600; c=relaxed/simple;
	bh=aJTNKX/v5Z05QI0IxwB6ctJWYKX7+xQaCAYI369UT1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwus6ze0Z7BGY5KEfCNRJFqRqYp7aHJyPzaUG/M0aE5vy9qrDhZbEyDvkn4fVJmdSg5JZzAXSXb0B3DlaUyk7h5k2Cs2Je78Kmdermz3eH7Bool/uflv5nULk71TRI2zPbCtl6DI7noN71R3wzGBvxqBw1YGGRVlq4XB1ofS3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHTR5OHB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so3564488a12.3;
        Sun, 09 Mar 2025 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741532597; x=1742137397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58BuOiwDzRUGRvcQUrzx2ytYjSYfIocMT0CLsdKSDUs=;
        b=iHTR5OHBZUQEfPpwwrPTtS/hD0KOcJxizGT0V953KRw3EU6PIyu6e4t0uTo5I797Zq
         A1dntOGA3U8UQvjwX3AHXInZGj3G+N+BcXhjla1RQNCT1gv0FczngrXM2tWl0PY693Pm
         m6DCVI1ivUZydOrP6hdhkEr9A18VnbZdl+DUMVhLSXHETsCaqFvW1d6qRwYVlLUcC0/q
         AvtDytbsDNpHoJPznYTUoxkCHAYlOFimNJvJkc/EfuHHXojSYtHNz2CJ7GwjxH1I0q2S
         oSKO4x3CjeoWIabdc7Ke0OFeyc5AKWW5wistsDOGju/uEWuxnM63ButoPkgyyP2ZXsLY
         CKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532597; x=1742137397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58BuOiwDzRUGRvcQUrzx2ytYjSYfIocMT0CLsdKSDUs=;
        b=u+kj+/ETcdZQyz51molzIOjjruwEyReF2lBs8SRYA6Vd4woWeYSpsISqP7loWLaLYB
         bfZKVmMUOVRt1eJ5BrNyWKuIqdbkcC5ZvowBKVzjjlsFRZgibOGEwOvT3WohJgDEbEkd
         k/AM3cJX1TgQrQOdIll4rJd8lCERy38OR1fYXsi7pDP8i8KRvFTBnk1AnByUFO/4nFCi
         LderDz0HcckBcw3KV9cdq9f1DULAdQkaY5qkW+ZuvCEMPUfTVF65uC6JrA/NFRGOQ80K
         FN/Kz0Ed1Oy7FdWUMZgvBXwED5AEAp54nol3aiTJ+3eOrOpnbDZf1tPQ5F2YcrmGPud/
         T0XA==
X-Forwarded-Encrypted: i=1; AJvYcCUrZFK6dqw3Z1CNB3JOfXJSHN7EcuFqm1Y1Ns4z6NHEm8cNaKThysbLiydUcqtx5bdaf7tidp4hrey2U6mq@vger.kernel.org, AJvYcCVeEUY3bQnqjeE5GkjCHtXClLvTVpfHsOzrSXFzdhs1Wf1oZUydqZwsbm0rmGcPERKSaTcu28xoicSn@vger.kernel.org, AJvYcCXP6QnBCjNIdbJ3cxi/o1BFApnLXmo8gKWqBreGzQ4zXcm0Av1Os6yarouevDvaHVVHeQgdtt82jbyZXYGs@vger.kernel.org
X-Gm-Message-State: AOJu0YyQM0xZpGEBv0uGL23FpVGPNeUxsNTrcPMlS8VYyknMcibABqMq
	mGjybag5ilIGWK+MKFhMuzL5tWIfPbw77g/zMYIcPPXhfhET10tqGoedDL7tnjWhy2A/hbS14X+
	5SYyaPYO9h37YYGlItkjufU8G/64=
X-Gm-Gg: ASbGncu6Z9h5UlMO55zddEcWuV6zgxL8MkX4/F17UvE7rQv446xzHIyGfj/Rd6GKwLN
	7t+m4aFckwbG33iHmX4c95WLi4YQzV5BcYg3IUwPHNGzpMkJ7oX6S0sur1y051BvRAnMKUTeWWF
	gW/GGl0Mmvn+PuJMVgI/UM6pdG5tUzvhMRii0R
X-Google-Smtp-Source: AGHT+IFb2qhYD4KxAUVmi6g2SZVlvZPtybJRL1STfVK1ZpiqkHozo0amrZs9S2vnzJEtlQa5w6C1nXB65Z0hsFWrgQQ=
X-Received: by 2002:a05:6402:27cc:b0:5e6:44d8:eced with SMTP id
 4fb4d7f45d1cf-5e644d8eebemr10665923a12.12.1741532596723; Sun, 09 Mar 2025
 08:03:16 -0700 (PDT)
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
 <20250304203657.GA4063187@perftesting> <CAOQ4uxihyR8u5c0T8q85ySNgp4U1T0MMSR=+vv3HWNFcvezRPQ@mail.gmail.com>
 <20250307154614.GA59451@perftesting> <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
 <CAOQ4uxht4zLKegu==cg4rs-GmL3p-bfYZt_sXNu+yxwTccSM4g@mail.gmail.com> <CAOQ4uxg0ZYb5vBVx3iH6TKO9cX4pGxu+b1UctvDVOk6qcSFEAA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg0ZYb5vBVx3iH6TKO9cX4pGxu+b1UctvDVOk6qcSFEAA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 9 Mar 2025 16:03:05 +0100
X-Gm-Features: AQ5f1JqU_hFa6mx0e2QH--uNiPNV68Z4RfuRNv2syz89NhWmdZ9BT6qBIbG0zWU
Message-ID: <CAOQ4uxj49ndz2oJcQMhZcXTAJ+_atUULNLPzLAw-BLzEdFwV+A@mail.gmail.com>
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

On Sun, Mar 9, 2025 at 1:09=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Mar 7, 2025 at 6:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Fri, Mar 7, 2025 at 5:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > >
> > > On Fri, Mar 7, 2025 at 4:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.=
com> wrote:
> > > >
> > > > On Tue, Mar 04, 2025 at 10:13:39PM +0100, Amir Goldstein wrote:
> > > > > On Tue, Mar 4, 2025 at 9:37=E2=80=AFPM Josef Bacik <josef@toxicpa=
nda.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> > > > > > > On Tue, Mar 4, 2025 at 5:15=E2=80=AFPM Josef Bacik <josef@tox=
icpanda.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wr=
ote:
> > > > > > > > > On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@su=
se.cz> wrote:
> > > > > > > > > >
> > > > > > > > > > Josef, Amir,
> > > > > > > > > >
> > > > > > > > > > this is indeed an interesting case:
> > > > > > > > > >
> > > > > > > > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > > > > > > > syzbot has found a reproducer for the following issue=
 on:
> > > > > > > > > > ...
> > > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify=
.h:145 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > > > > > Modules linked in:
> > > > > > > > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tai=
nted 6.14.0-rc4-syzkaller-ge056da87c780 #0
> > > > > > > > > > > Hardware name: Google Google Compute Engine/Google Co=
mpute Engine, BIOS Google 12/27/2024
> > > > > > > > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS=
 BTYPE=3D--)
> > > > > > > > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linu=
x/fsnotify.h:145
> > > > > > > > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linu=
x/fsnotify.h:145
> > > > > > > > > > > sp : ffff8000a42569d0
> > > > > > > > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff=
0000d68a1708
> > > > > > > > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000=
000000008000
> > > > > > > > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000=
000000001000
> > > > > > > > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff=
8000a42566e0
> > > > > > > > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 0000=
000000000001
> > > > > > > > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000=
000000000000
> > > > > > > > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000=
000000000000
> > > > > > > > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000=
000000000000
> > > > > > > > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000=
000000001000
> > > > > > > > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000=
000000000000
> > > > > > > > > > > Call trace:
> > > > > > > > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fs=
notify.h:145 (P)
> > > > > > > > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > > > > > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > > > > > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > > > > > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > > > > > > > >  do_fault mm/memory.c:5537 [inline]
> > > > > > > > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > > > > > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > > > > > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > > > > > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > > > > > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > > > > > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.=
c:783
> > > > > > > > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > > > > > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c=
:432
> > > > > > > > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/ent=
ry-common.c:510
> > > > > > > > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > > > > > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:=
169 [inline] (P)
> > > > > > > > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > > > > > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.=
c:94
> > > > > > > > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > > > > > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffe=
red-io.c:1039
> > > > > > > > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.=
c:792
> > > > > > > > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:88=
1
> > > > > > > > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > > > > > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > > > > > > > >
> > > > > > > > > > The backtrace actually explains it all. We had a buffer=
ed write whose
> > > > > > > > > > buffer was mmapped file on a filesystem with an HSM mar=
k. Now the prefaulting
> > > > > > > > > > of the buffer happens already (quite deep) under the fi=
lesystem freeze
> > > > > > > > > > protection (obtained in vfs_write()) which breaks assum=
ptions of HSM code
> > > > > > > > > > and introduces potential deadlock of HSM handler in use=
rspace with filesystem
> > > > > > > > > > freezing. So we need to think how to deal with this cas=
e...
> > > > > > > > >
> > > > > > > > > Ouch. It's like the splice mess all over again.
> > > > > > > > > Except we do not really care to make this use case work w=
ith HSM
> > > > > > > > > in the sense that we do not care to have to fill in the m=
maped file content
> > > > > > > > > in this corner case - we just need to let HSM fail the ac=
cess if content is
> > > > > > > > > not available.
> > > > > > > > >
> > > > > > > > > If you remember, in one of my very early version of pre-c=
ontent events,
> > > > > > > > > the pre-content event (or maybe it was FAN_ACCESS_PERM it=
self)
> > > > > > > > > carried a flag (I think it was called FAN_PRE_VFS) to com=
municate to
> > > > > > > > > HSM service if it was safe to write to fs in the context =
of event handling.
> > > > > > > > >
> > > > > > > > > At the moment, I cannot think of any elegant way out of t=
his use case
> > > > > > > > > except annotating the event from fault_in_readable() as "=
unsafe-for-write".
> > > > > > > > > This will relax the debugging code assertion and notify t=
he HSM service
> > > > > > > > > (via an event flag) that it can ALLOW/DENY, but it cannot=
 fill the file.
> > > > > > > > > Maybe we can reuse the FAN_ACCESS_PERM event to communica=
te
> > > > > > > > > this case to HSM service.
> > > > > > > > >
> > > > > > > > > WDYT?
> > > > > > > >
> > > > > > > > I think that mmap was a mistake.
> > > > > > >
> > > > > > > What do you mean?
> > > > > > > Isn't the fault hook required for your large executables use =
case?
> > > > > >
> > > > > > I mean the mmap syscall was a mistake ;).
> > > > > >
> > > > >
> > > > > ah :)
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Is there a way to tell if we're currently in a path that is=
 under fsfreeze
> > > > > > > > protection?
> > > > > > >
> > > > > > > Not at the moment.
> > > > > > > At the moment, file_write_not_started() is not a reliable che=
ck
> > > > > > > (has false positives) without CONFIG_LOCKDEP.
> > > > > > >
> > > > >
> > > > > One very ugly solution is to require CONFIG_LOCKDEP for
> > > > > pre-content events.
> > > > >
> > > > > > > > Just denying this case would be a simpler short term soluti=
on while
> > > > > > > > we come up with a long term solution. I think your solution=
 is fine, but I'd be
> > > > > > > > just as happy with a simpler "this isn't allowed" solution.=
 Thanks,
> > > > > > >
> > > > > > > Yeh, I don't mind that, but it's a bit of an overkill conside=
ring that
> > > > > > > file with no content may in fact be rare.
> > > > > >
> > > > > > Agreed, I'm fine with your solution.
> > > > >
> > > > > Well, my "solution" was quite hand-wavy - it did not really say h=
ow to
> > > > > propagate the fact that faults initiated from fault_in_readable()=
.
> > > > > Do you guys have any ideas for a simple solution?
> > > >
> > > > Sorry I've been elbow deep in helping getting our machine replaceme=
nts working
> > > > faster.
> > > >
> > > > I've been thnking about this, it's not like we can carry context fr=
om the reason
> > > > we are faulting in, at least not simply, so I think the best thing =
to do is
> > > > either
> > > >
> > > > 1) Emit a precontent event at mmap() time for the whole file, since=
 really all I
> > > > care about is faulting at exec time, and then we can just skip the =
precontent
> > > > event if we're not exec.
> > >
> > > Sorry, not that familiar with exec code. Do you mean to issue pre-con=
tent
> > > for page fault only if memory is mapped executable or is there anothe=
r way
> > > of knowing that we are in exec context?
> > >
> > > If the former, then syzbot will catch up with us and write a buffer w=
hich is
> > > mapped readable and exec.
> > >
>
> Oh, I was being silly.
> You meant to call the hook from page fault only for FMODE_EXEC.
> This makes sense to me. I will try to write it up.
>

Let'e see if that works:

#syz test: https://github.com/amir73il/linux fsnotify-mmap

So far only compile and sanity tested.

Thanks,
Amir.

