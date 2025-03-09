Return-Path: <linux-fsdevel+bounces-43543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BCA583E7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 13:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67CC16693E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022F1CEAC2;
	Sun,  9 Mar 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwQtMZQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021F2B9A4;
	Sun,  9 Mar 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522172; cv=none; b=Zd4JnTGawldqzXECFUuhO/zu2eXyIvjoXhletbvgi921mf4gJdtbtTgq+rYVTTHg1r6A7vfm+seAs9e7k8Ql6L79X5a8ivzYO8EqqjQ2nwYcijXYPSOdUNo5EAw808mKt65OsXocoA9oQj8fkfAKWHuEkha6qP6i1euzb3PX/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522172; c=relaxed/simple;
	bh=ZhP9smmuWO9l/Up2QlUkikbvgn36q+8XzGsHx1Ysp7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gzm/QIJ5NkkieHLa0b4lhZeMBRT/9N/nvZwMGkGUh8Xvg9hoKLFRDXvcl118++xZ7IIQ3iCB+imvYUAobUvvmBbyM8CcQ6ig+oQ1TxQgJVtMq7/x0zYdy239Jv2xopg3uv/l6WfZxOak5UYH4qxQ5FLcN9P9DMV/UgQ/zRgbBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwQtMZQa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso5773889a12.0;
        Sun, 09 Mar 2025 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741522169; x=1742126969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNxlWzrhZAfEP/KkGdHRDcm/Kf2Os7XzcAXdYkXJHik=;
        b=fwQtMZQag3NGz+H4FOf2hJ5gLBmsqNVTcXWf2T1Gnxechc80JQ0OwYNAYqNlfAmgga
         hLqJGpYjfOhA6ZqC3hCjVAwvrRe98HPep6TjTIQuhVRUw4q1KiLvspQb125DDqVeB8a9
         H7LSG0j1UR1jVOHHWkNKz+7K90zpIJjXRQ2gkZsncYK8IhFjeeeJJU6R56JcqX7NLaWj
         8U/Ba1rsjfTciP5glv81FtCGNGPrG2ugzlvctskgJEPTnVaMrkRjRJwjDNnxaRVi55aN
         +Kp78qcXqUvVRtKxUq0do9B+EWEisVqGWo8DKkDvzpyOar1CIYFKVVDZjEwl2U2L81di
         ycKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741522169; x=1742126969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNxlWzrhZAfEP/KkGdHRDcm/Kf2Os7XzcAXdYkXJHik=;
        b=qytk0rw/MYbnVhWumxZ+KpwUnoiBpZEkjy9Gu+161aLli5YlPxfHbu+bviXQrpEA6g
         2qMRUTx6IzZNW91b29CT/wYDO8Znh8r2AoyW2ySR1ARiKxItdzy3O2I1h8RjEODIltu1
         WCOCGj0gtuuHxCOeOhzF2pHX3itfF1opp+FafrWTlctdUPVSJ8DZJcfbT48iJbKOqUgf
         gBCCJ2YDzhBjosD6H4xG+ssCXPu+sHsOh8UHSFP8V4HlWKWsDIco5FH7XMiFFfQB63Z6
         E57tjGUq/NPul9TVSwjuCBqvzgdZXkbMe77GsDLyErPM9qoJg512JDQRRnjaUPYUBtEV
         WhFg==
X-Forwarded-Encrypted: i=1; AJvYcCURu8ZUU29TjzmrqjSy1iCWbNZrldiAUs2IKlayEIwXVOUeyy9GmRMR9ExrCsiDk7+02/h9689yubOGntnr@vger.kernel.org, AJvYcCWmgw/nSbOj2wNGruwFEgdbSFWkeJDSHlsqzARvKc/IyVfLnT+KhE8+UgX9fdurVGQIvNOWZcZhi35E@vger.kernel.org, AJvYcCX1Baksy61S5RQCdFMSXCClYTY7lqWxRh1JlQy1l2+dwF4MJuFNFJhrAIJGF7U81hSGc9WXyO0l3udjS4pL@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+Jpe3IzVjopdDmmup9hR+aQCTJZFhmREJ1xl/Cq+SRcujDfA
	80Mw/HslxKj2sIoU9MEfEw7CiAkzaZ7FcidhxlNFGrGYByFwgJ5yGFhVujyiKUjnUeUVIfkRzmN
	6YiYs2CYPlD2VP06laxIug882Xr8=
X-Gm-Gg: ASbGnctNo80na9vKslXdOUJdh6J6dA3mlTfLcBIKtPBzrx0FAI1wCYLz8Seicwk/3t9
	CLNnrmFB2U0Xy2vs5r2iNgEGnC8FF0A/KckCQB442rFlwCOGHBnSZQLaQXtlIHiWzy/QKxZweTD
	53zFb8qx2lptwgTtqFa1AMP8M/EQ==
X-Google-Smtp-Source: AGHT+IGgrFqJJNVC5UL1diLMhW9a2kAoskP4FsjK8wLzW90lJ1WC8VhXDjuGoC56OFwUe9K9Bp/gIxMdquEqcns7K9M=
X-Received: by 2002:a17:907:c15:b0:abf:b2d1:bb4c with SMTP id
 a640c23a62f3a-ac252ed8d23mr1177626466b.52.1741522168700; Sun, 09 Mar 2025
 05:09:28 -0700 (PDT)
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
 <CAOQ4uxht4zLKegu==cg4rs-GmL3p-bfYZt_sXNu+yxwTccSM4g@mail.gmail.com>
In-Reply-To: <CAOQ4uxht4zLKegu==cg4rs-GmL3p-bfYZt_sXNu+yxwTccSM4g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 9 Mar 2025 13:09:16 +0100
X-Gm-Features: AQ5f1JqWUBTbrJKW9qBHk2sgfGwSWVhKZct8CRch-tjqmxf_0yFsxo8aOQ5NZZs
Message-ID: <CAOQ4uxg0ZYb5vBVx3iH6TKO9cX4pGxu+b1UctvDVOk6qcSFEAA@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 6:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Mar 7, 2025 at 5:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Fri, Mar 7, 2025 at 4:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> > >
> > > On Tue, Mar 04, 2025 at 10:13:39PM +0100, Amir Goldstein wrote:
> > > > On Tue, Mar 4, 2025 at 9:37=E2=80=AFPM Josef Bacik <josef@toxicpand=
a.com> wrote:
> > > > >
> > > > > On Tue, Mar 04, 2025 at 09:27:20PM +0100, Amir Goldstein wrote:
> > > > > > On Tue, Mar 4, 2025 at 5:15=E2=80=AFPM Josef Bacik <josef@toxic=
panda.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrot=
e:
> > > > > > > > On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@suse=
.cz> wrote:
> > > > > > > > >
> > > > > > > > > Josef, Amir,
> > > > > > > > >
> > > > > > > > > this is indeed an interesting case:
> > > > > > > > >
> > > > > > > > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > > > > > > > syzbot has found a reproducer for the following issue o=
n:
> > > > > > > > > ...
> > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h=
:145 fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > > > > > > > Modules linked in:
> > > > > > > > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not taint=
ed 6.14.0-rc4-syzkaller-ge056da87c780 #0
> > > > > > > > > > Hardware name: Google Google Compute Engine/Google Comp=
ute Engine, BIOS Google 12/27/2024
> > > > > > > > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> > > > > > > > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/=
fsnotify.h:145
> > > > > > > > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/=
fsnotify.h:145
> > > > > > > > > > sp : ffff8000a42569d0
> > > > > > > > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff00=
00d68a1708
> > > > > > > > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 000000=
0000008000
> > > > > > > > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 000000=
0000001000
> > > > > > > > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff80=
00a42566e0
> > > > > > > > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 000000=
0000000001
> > > > > > > > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 000000=
0000000000
> > > > > > > > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 000000=
0000000000
> > > > > > > > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 000000=
0000000000
> > > > > > > > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 000000=
0000001000
> > > > > > > > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 000000=
0000000000
> > > > > > > > > > Call trace:
> > > > > > > > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsno=
tify.h:145 (P)
> > > > > > > > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > > > > > > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > > > > > > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > > > > > > > >  do_read_fault mm/memory.c:5403 [inline]
> > > > > > > > > >  do_fault mm/memory.c:5537 [inline]
> > > > > > > > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > > > > > > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > > > > > > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > > > > > > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > > > > > > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > > > > > > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:=
783
> > > > > > > > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > > > > > > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:4=
32
> > > > > > > > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry=
-common.c:510
> > > > > > > > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > > > > > > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:16=
9 [inline] (P)
> > > > > > > > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > > > > > > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:=
94
> > > > > > > > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > > > > > > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffere=
d-io.c:1039
> > > > > > > > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:=
792
> > > > > > > > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > > > > > > > >  new_sync_write fs/read_write.c:586 [inline]
> > > > > > > > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > > > > > > > >
> > > > > > > > > The backtrace actually explains it all. We had a buffered=
 write whose
> > > > > > > > > buffer was mmapped file on a filesystem with an HSM mark.=
 Now the prefaulting
> > > > > > > > > of the buffer happens already (quite deep) under the file=
system freeze
> > > > > > > > > protection (obtained in vfs_write()) which breaks assumpt=
ions of HSM code
> > > > > > > > > and introduces potential deadlock of HSM handler in users=
pace with filesystem
> > > > > > > > > freezing. So we need to think how to deal with this case.=
..
> > > > > > > >
> > > > > > > > Ouch. It's like the splice mess all over again.
> > > > > > > > Except we do not really care to make this use case work wit=
h HSM
> > > > > > > > in the sense that we do not care to have to fill in the mma=
ped file content
> > > > > > > > in this corner case - we just need to let HSM fail the acce=
ss if content is
> > > > > > > > not available.
> > > > > > > >
> > > > > > > > If you remember, in one of my very early version of pre-con=
tent events,
> > > > > > > > the pre-content event (or maybe it was FAN_ACCESS_PERM itse=
lf)
> > > > > > > > carried a flag (I think it was called FAN_PRE_VFS) to commu=
nicate to
> > > > > > > > HSM service if it was safe to write to fs in the context of=
 event handling.
> > > > > > > >
> > > > > > > > At the moment, I cannot think of any elegant way out of thi=
s use case
> > > > > > > > except annotating the event from fault_in_readable() as "un=
safe-for-write".
> > > > > > > > This will relax the debugging code assertion and notify the=
 HSM service
> > > > > > > > (via an event flag) that it can ALLOW/DENY, but it cannot f=
ill the file.
> > > > > > > > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > > > > > > > this case to HSM service.
> > > > > > > >
> > > > > > > > WDYT?
> > > > > > >
> > > > > > > I think that mmap was a mistake.
> > > > > >
> > > > > > What do you mean?
> > > > > > Isn't the fault hook required for your large executables use ca=
se?
> > > > >
> > > > > I mean the mmap syscall was a mistake ;).
> > > > >
> > > >
> > > > ah :)
> > > >
> > > > > >
> > > > > > >
> > > > > > > Is there a way to tell if we're currently in a path that is u=
nder fsfreeze
> > > > > > > protection?
> > > > > >
> > > > > > Not at the moment.
> > > > > > At the moment, file_write_not_started() is not a reliable check
> > > > > > (has false positives) without CONFIG_LOCKDEP.
> > > > > >
> > > >
> > > > One very ugly solution is to require CONFIG_LOCKDEP for
> > > > pre-content events.
> > > >
> > > > > > > Just denying this case would be a simpler short term solution=
 while
> > > > > > > we come up with a long term solution. I think your solution i=
s fine, but I'd be
> > > > > > > just as happy with a simpler "this isn't allowed" solution. T=
hanks,
> > > > > >
> > > > > > Yeh, I don't mind that, but it's a bit of an overkill consideri=
ng that
> > > > > > file with no content may in fact be rare.
> > > > >
> > > > > Agreed, I'm fine with your solution.
> > > >
> > > > Well, my "solution" was quite hand-wavy - it did not really say how=
 to
> > > > propagate the fact that faults initiated from fault_in_readable().
> > > > Do you guys have any ideas for a simple solution?
> > >
> > > Sorry I've been elbow deep in helping getting our machine replacement=
s working
> > > faster.
> > >
> > > I've been thnking about this, it's not like we can carry context from=
 the reason
> > > we are faulting in, at least not simply, so I think the best thing to=
 do is
> > > either
> > >
> > > 1) Emit a precontent event at mmap() time for the whole file, since r=
eally all I
> > > care about is faulting at exec time, and then we can just skip the pr=
econtent
> > > event if we're not exec.
> >
> > Sorry, not that familiar with exec code. Do you mean to issue pre-conte=
nt
> > for page fault only if memory is mapped executable or is there another =
way
> > of knowing that we are in exec context?
> >
> > If the former, then syzbot will catch up with us and write a buffer whi=
ch is
> > mapped readable and exec.
> >

Oh, I was being silly.
You meant to call the hook from page fault only for FMODE_EXEC.
This makes sense to me. I will try to write it up.

> > >
> > > 2) Revert the page fault stuff, put back your thing to fault the whol=
e file, and
> > > wait until we think of a better way to deal with this.
> > >
> > > Obviously I'd prefer not #2, but I'd really, really rather not chuck =
all of HSM
> > > because my page fault thing is silly.  I'll carry what I need interna=
lly while
> > > we figure out what to do upstream.  #1 doesn't seem bad, but I haven'=
t thought
> > > about it that hard.  Thanks,
> > >
> >
> > So I started to test this patch, but I may be doing something very
> > terribly wrong
> > with this. Q: What is this something that is terribly wrong?
> >
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 2788df98080f8..a8822b44d4967 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3033,13 +3033,27 @@ static inline void file_start_write(struct file=
 *file)
> >         if (!S_ISREG(file_inode(file)->i_mode))
> >                 return;
> >         sb_start_write(file_inode(file)->i_sb);
> > +       /*
> > +        * Prevent fault-in user pages that may call HSM hooks with
> > +        * sb_writers held.
> > +        */
> > +       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> > +               pagefault_disable();
> >  }
> >
> >  static inline bool file_start_write_trylock(struct file *file)
> >  {
> >         if (!S_ISREG(file_inode(file)->i_mode))
> >                 return true;
> > -       return sb_start_write_trylock(file_inode(file)->i_sb);
> > +       if (!sb_start_write_trylock(file_inode(file)->i_sb))
> > +               return false;
> > +       /*
> > +        * Prevent fault-in user pages that may call HSM hooks with
> > +        * sb_writers held.
> > +        */
> > +       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> > +               pagefault_disable();
> > +       return true;
> >  }
> >
> >  /**
> > @@ -3053,6 +3067,8 @@ static inline void file_end_write(struct file *fi=
le)
> >         if (!S_ISREG(file_inode(file)->i_mode))
> >                 return;
> >         sb_end_write(file_inode(file)->i_sb);
> > +       if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> > +               pagefault_enable();
> >  }
>
> One thing that is wrong is that this is checking if the written file
> is marked for
> pre-content events, not the input buffer mmaped file.
>
> What we would have needed here is a check of
>   unlikely(fsnotify_sb_has_priority_watchers(sb,
>                                                 FSNOTIFY_PRIO_PRE_CONTENT=
)))
>
> But Linus will not like that...
>
> Do we even care about optimizing the pre-content hooks of sporadic files
> that are not marked for pre-content events when there are pre-content
> watches on the filesystem?
>
> I think all of our use cases mark the sb for pre-content events anyway
> and do not care about a bit of overhead for non-marked files.
> If that is the case we can do away with the extra optimization
> and then the changes above will really solve the issue.
>
> I've squashed the followup change to the fsnotify-fixes branch.

This was actually a partial revert of commit 318652e07fa5b ("fsnotify:
check if file is actually being watched for pre-content events on open"),
so posted it as a separate patch.

I am not sure if we need this if we go the route of event on mmap(),
but posted the patches so we have them if we decide that they are useful.

Thanks,
Amir.

