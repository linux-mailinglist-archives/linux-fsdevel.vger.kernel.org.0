Return-Path: <linux-fsdevel+bounces-43173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672CA4EE51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3E3A97F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FE24EAB7;
	Tue,  4 Mar 2025 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I165j7Rx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6317DA93;
	Tue,  4 Mar 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120055; cv=none; b=nalgSY/GOqyqxlGY6mydqBjvpCyA6F/yg/Dz1oAXfKsm3oY5JZBC3drerzVZZLfQWulgdnScE7sf1NCUy/a1y/hQny4MPOY/rzPnOhmjTEu3TTspHNmWIfEimrl4SR6ok7fhQOEYn7AqbPINblFmkxeVYSqFtBpwGcK8tcyTHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120055; c=relaxed/simple;
	bh=xV8tlncvGMfnMX1OhOGvNarO9Z++GXkiwPoaztl/MZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLa3btysXPXcMoVmvU3q1boemyJCiFICkbXOdrbNLkqJJE8k7xc7S4gyiTPoWx9LM0S1CiG971r+QmmsDliUecTT8RbPhTpHmGQExJxT6VsZ/rQN5vaN5R8xAwB0zUn5FjCqg3TDAdYgJOIzNNoAmxezWByxe9Ww+PXtFsFXINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I165j7Rx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e549af4927so4547631a12.2;
        Tue, 04 Mar 2025 12:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741120052; x=1741724852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn9ky4z5dMSLl5RskSlFZc3RtSEkfN0OwnmLO2V6eds=;
        b=I165j7RxBPOXSycVb911JsunVyuKggsZjwPU5UY50FMr1tSKxEfnefr6HbzdCNM/uN
         ZoatLunc814HlbbmTQm+GCqxoYPiN2kjszEWTkOOfHDEfEDZuX/G/Jn3QjlAVCb0jeZX
         H4eqodxSt4c3XtyQumlCnCmxceYTrLkKziE9kZBVYWFAn2oGoMf0ENDbSkeIqqkJX2rm
         qH4PphgRnh7trAo9d/YwNZAAbiGouAmyhSyWnxd9gJd4uhj1HXnrqIGdUZtqqIcGyROI
         a/YU7AdQd2Ba7of34mrsP70uI39nTp3ozc7irAKb1jSm+KL5yWxKRMSrYKDko3PIyOe/
         d0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120052; x=1741724852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn9ky4z5dMSLl5RskSlFZc3RtSEkfN0OwnmLO2V6eds=;
        b=M1jdXT0wZxvHPwiVLV/ty6wwKcWStDZxavflIfhscCaObqD6GQRDXIrtCsgApaBK4p
         lfQ5iGG/wmB4da241fhjZzEyUDbGmomiJM898Qg7uk579ZzNNVTZB8Z1+1VdzDSwUdaW
         0Ky3S9NR65fvLhMasQUNiCqNDtaNhFu/jG6FSLNSuwf8DxH4YFTreSziQu89MVmlGhkD
         e3bTi6jArCDxDYC71cbvqP9pVQXKGBmEqbmdQOd7e+voHtkr8NmbDItyp6+ry6mEW/Sc
         nBnJAKBFPWTq0H40KDcgpBJ/WHEq71QaZya0cZ5Q0Wbo8CbxvLD5K8eKKDg1z37Dd23s
         LCXg==
X-Forwarded-Encrypted: i=1; AJvYcCVgTzPbB8CSTJgkiD4W1Q9iWGXpuJ/4uHhOAoU7GfIcdA4zRwFecQdQJPYdrvOJt6RUsLQPpavHK3fV@vger.kernel.org, AJvYcCX9VKFm/kEF+G1aFoDto0QTqRCPMJp7WMkIM+B1D/MJUGpwFBS6gytR/hMkhTMJ9K3bw5UHlh/JCDaISJhk@vger.kernel.org, AJvYcCXVyuDArF68BhX1TkFZzGMwKL11NwkvzhkPXkIn7+J3jc2IvRlRj9NZuEjFM8/nWDdAaQMghp33r6dTVANG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hFEup7J2VHXiethCCkOwTZu0EBN4btSKUu+ehtlvjc+u7y4J
	DXMQwxl7fS+0khXs6qYD37/w4sYbODnZXrTIY2cMDGCApwzDP4P+3h6qt998+atA9tCUTnyqF64
	nOeAb3/q/J3RJp9c7/toU6580mDA=
X-Gm-Gg: ASbGncsuuqALamkQHqHyxED/6x0jWsGURhg83F26TdhwgIsopek5yGTZ1v9iUOLjGZC
	7dtyXI5gMRMsNt5tcn7UJSFK3D5hLhQ/tq4xAnyiqszIEWfnFqRFFHp1t0SvnFcbKS+IwtFEcbb
	KC9Bv371Srwhdrx1tcPw2O8YYXoQ==
X-Google-Smtp-Source: AGHT+IHAIoJ0E+pxrzOSe5eeebBWS9Dt9S9yaMu+lz0dKVZefv8M1z2h5EJXZXlzDsPBXuOKAWHb5+UGNnCVo3QTjv8=
X-Received: by 2002:a17:906:4fc7:b0:ac2:551:4a38 with SMTP id
 a640c23a62f3a-ac20d925104mr50035866b.26.1741120051525; Tue, 04 Mar 2025
 12:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com> <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
 <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
 <CAOQ4uxjf5H_vj-swF7wEvUkPobEuxs2q6jfO9jFsx4pqxtJMMg@mail.gmail.com> <20250304161509.GA4047943@perftesting>
In-Reply-To: <20250304161509.GA4047943@perftesting>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Mar 2025 21:27:20 +0100
X-Gm-Features: AQ5f1Jo62ERWo7QAFZgtTJaHo7SsHhqhpis6fOJNRGSu3Cz1rXE-1Ym7ZbVDGEM
Message-ID: <CAOQ4uxj0cN-sUN=EE0+9tRhMFFrWLQ0T_i0fprwNRr92Hire6Q@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 5:15=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Tue, Mar 04, 2025 at 04:09:16PM +0100, Amir Goldstein wrote:
> > On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Josef, Amir,
> > >
> > > this is indeed an interesting case:
> > >
> > > On Sun 02-03-25 08:32:30, syzbot wrote:
> > > > syzbot has found a reproducer for the following issue on:
> > > ...
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145 fsnotif=
y_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > > > Modules linked in:
> > > > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6.14.0-rc=
4-syzkaller-ge056da87c780 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 12/27/2024
> > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > > > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:1=
45
> > > > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:1=
45
> > > > sp : ffff8000a42569d0
> > > > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d68a1708
> > > > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000000000008000
> > > > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000000000001000
> > > > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a42566e0
> > > > x17: 000000000000e388 x16: ffff800080466c24 x15: 0000000000000001
> > > > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000000000000000
> > > > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
> > > > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000000000000000
> > > > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000001000
> > > > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000000000000000
> > > > Call trace:
> > > >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145 (=
P)
> > > >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> > > >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> > > >  __do_fault+0xf8/0x498 mm/memory.c:4988
> > > >  do_read_fault mm/memory.c:5403 [inline]
> > > >  do_fault mm/memory.c:5537 [inline]
> > > >  do_pte_missing mm/memory.c:4058 [inline]
> > > >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> > > >  __handle_mm_fault mm/memory.c:6043 [inline]
> > > >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> > > >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> > > >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
> > > >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> > > >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> > > >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-common.c:51=
0
> > > >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> > > >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline] (=
P)
> > > >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> > > >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> > > >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> > > >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io.c:1039
> > > >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
> > > >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> > > >  new_sync_write fs/read_write.c:586 [inline]
> > > >  vfs_write+0x704/0xa9c fs/read_write.c:679
> > >
> > > The backtrace actually explains it all. We had a buffered write whose
> > > buffer was mmapped file on a filesystem with an HSM mark. Now the pre=
faulting
> > > of the buffer happens already (quite deep) under the filesystem freez=
e
> > > protection (obtained in vfs_write()) which breaks assumptions of HSM =
code
> > > and introduces potential deadlock of HSM handler in userspace with fi=
lesystem
> > > freezing. So we need to think how to deal with this case...
> >
> > Ouch. It's like the splice mess all over again.
> > Except we do not really care to make this use case work with HSM
> > in the sense that we do not care to have to fill in the mmaped file con=
tent
> > in this corner case - we just need to let HSM fail the access if conten=
t is
> > not available.
> >
> > If you remember, in one of my very early version of pre-content events,
> > the pre-content event (or maybe it was FAN_ACCESS_PERM itself)
> > carried a flag (I think it was called FAN_PRE_VFS) to communicate to
> > HSM service if it was safe to write to fs in the context of event handl=
ing.
> >
> > At the moment, I cannot think of any elegant way out of this use case
> > except annotating the event from fault_in_readable() as "unsafe-for-wri=
te".
> > This will relax the debugging code assertion and notify the HSM service
> > (via an event flag) that it can ALLOW/DENY, but it cannot fill the file=
.
> > Maybe we can reuse the FAN_ACCESS_PERM event to communicate
> > this case to HSM service.
> >
> > WDYT?
>
> I think that mmap was a mistake.

What do you mean?
Isn't the fault hook required for your large executables use case?

>
> Is there a way to tell if we're currently in a path that is under fsfreez=
e
> protection?

Not at the moment.
At the moment, file_write_not_started() is not a reliable check
(has false positives) without CONFIG_LOCKDEP.

> Just denying this case would be a simpler short term solution while
> we come up with a long term solution. I think your solution is fine, but =
I'd be
> just as happy with a simpler "this isn't allowed" solution. Thanks,

Yeh, I don't mind that, but it's a bit of an overkill considering that
file with no content may in fact be rare.

Thanks,
Amir.

