Return-Path: <linux-fsdevel+bounces-43116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46341A4E2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380B116CB27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5F628D055;
	Tue,  4 Mar 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcFemKbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11528D04B;
	Tue,  4 Mar 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100971; cv=none; b=cfCmJyfT8efE1ld+wuj5J90qzqOUf1ti4eCfFe3PuD241xHVHstX0oiV1i9RH5fwr06o/PV/JOZBlY9nRz3mrmSYmJN5eP7IuxdXdc1yNBMvwCQfigaASJ7RjvbmnjgRAjcIOvVdXTiAPgs1EumTtvMwVcdNDZYBZIj8WH1dV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100971; c=relaxed/simple;
	bh=eEFdiJOaEVKrpUaRlZwl75jN1e5eVLcbLsgHGryUtdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eft8PBLObV0OkVY4EyaG0ssHcffaxIH9ydp9nau48W1jEvdvmuVhQ9jrGkZMTqRiRuD8GwzHsCQ+sKjjkZ0gWYebf6VJOBm1iECu+IPtDmzMEVeE0PnI4Dc/HFnjLEQEY6XnxP28R5746b8Ca3dFI0A01/gqlaL5n3OvN2T3pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcFemKbY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso4102321a12.0;
        Tue, 04 Mar 2025 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741100968; x=1741705768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uScpjqVdvtyhYM2KhX5vJuMrPWoXeP89vsFp+SL+gX8=;
        b=XcFemKbYM1FWGGMBhtKwxJP58EoAeRem/OKkDHu5sjabry5os38BbfYtcMV+FQ+Z2I
         u9KQ1igIwU+kMz0HpffiAY9SHFcjiBadky86i0t2OWNGNjr28ihJYjlI0lR3j5qeWa0Q
         6cBmW+CgY4UXFb13QnxSW5NVX7JN/Wn0ED/RpEKpIVDsYnRJzVR/s8s8I7ynrGBZXZIH
         Rd8NCMldunb73QT4+r09fzqtesfM2sVROPh8xIWs9Z0/v3Mx58X65eWbFugBy1ew5SE3
         PBJWuCnZJhaFrrzunHiw/KYlRD4Tr/j3n9WZ81BVsCcxmJn3b5V1oK2GILpmP2F0PDkG
         EsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100968; x=1741705768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uScpjqVdvtyhYM2KhX5vJuMrPWoXeP89vsFp+SL+gX8=;
        b=KGd52hU+bOrc1cqzBecscgJd5Onny230LBS/mUgrJtcN2SC+X/783CVbafsjOOyRi2
         P3uLQCeGjxaHxHpN8UIlpmOxRS4gO+waqWFJJcROVIQBMu4VIeEoFm9TkIkZBi9Q8sko
         qdJfij8FmFdszSfTCuNT79ZVnjbqSYuuGw51DcKfKDMlF73hx1YNSsTHMuDq43IiMdHj
         iB2VVaqifgrGuUAVzdcjwYL5RTESQ14us+wVrskNMj119HtyqfYZz5QBBABmnGKg7SB1
         ffPkx0itgSBuHCqfJkeQS88SFID+5isKLJN+fgiA/LPeYjEEnUc4hi+Ysze4UyxFEkZZ
         xUXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYItrm4PjLFssFaBflJ4WGgIY8rEj12VgLLuasELjxAGUyq8gY5jajO05OwTA3WNB2pFZLZWlVZ/HHOOt@vger.kernel.org, AJvYcCW5uP+jgnecaf8CNDtD/eikADBHPz8sPJEd+ROOoQS0UW5pXXPNawww87jotQd/Wewjgu3acK6zCw6DUKAQ@vger.kernel.org, AJvYcCWW5AY5hTsGu8O415v8mnHeuQh/lxty21qHl6zCJ5vzfKDnagrqm9s430TPgZiXb9h5ZqkfeRGDfuJD@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuk9W6/mqFOnKp7bAx0PRjteIuBFE5QHSaQOgOaXg5iWau35+
	+QQ+jyXIcPA5Io9LcK/vUDELo16HFKgaoKEPYmJESt+Hl+jPa9ky7/y01qLcEvKtvqPyzQG+hIO
	22fOR8hJ+/ZCkipOZf9Frh5UyQzQ=
X-Gm-Gg: ASbGncuM06xEy/lkxWvqGnhJ77oNsg72rTqZg/Yi05LMVaEJ0qKYb5ctGJFVg9xV3AZ
	2IfhVQ6UDbj/zwtVRly6jCBjqyAOGuCgbWpn8yDPT2eWuky1PhUxLbc6+CH9nGhR5F+ZaAijmjo
	xnAZt9KdViIyJhLi6aT5+glyD6hA==
X-Google-Smtp-Source: AGHT+IHxR0cwkhSFVSPMWkrlapNGHCWwGdTT7x02t4m21exntSehVi3S/37dxuVDHFNW8eKYB7iVNMBU1lK1vmK+pLQ=
X-Received: by 2002:a17:907:8d8e:b0:abf:4f76:54fb with SMTP id
 a640c23a62f3a-abf4f76581bmr1625373466b.28.1741100967755; Tue, 04 Mar 2025
 07:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a487f7.050a0220.19061f.05fc.GAE@google.com> <67c4881e.050a0220.1dee4d.0054.GAE@google.com>
 <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
In-Reply-To: <7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Mar 2025 16:09:16 +0100
X-Gm-Features: AQ5f1JoLLbZNPxO-xd1f_LSLjlaGstdrdYj_T0YCerlA_4xnNwU6BEXWPH0Cvq4
Message-ID: <CAOQ4uxjf5H_vj-swF7wEvUkPobEuxs2q6jfO9jFsx4pqxtJMMg@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:06=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Josef, Amir,
>
> this is indeed an interesting case:
>
> On Sun 02-03-25 08:32:30, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> ...
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 6440 at ./include/linux/fsnotify.h:145 fsnotify_fi=
le_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 6440 Comm: syz-executor370 Not tainted 6.14.0-rc4-sy=
zkaller-ge056da87c780 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 12/27/2024
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > lr : fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145
> > sp : ffff8000a42569d0
> > x29: ffff8000a42569d0 x28: ffff0000dcec1b48 x27: ffff0000d68a1708
> > x26: ffff0000d68a16c0 x25: dfff800000000000 x24: 0000000000008000
> > x23: 0000000000000001 x22: ffff8000a4256b00 x21: 0000000000001000
> > x20: 0000000000000010 x19: ffff0000d68a16c0 x18: ffff8000a42566e0
> > x17: 000000000000e388 x16: ffff800080466c24 x15: 0000000000000001
> > x14: 1fffe0001b31513c x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
> > x8 : ffff0000c6d98000 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000001000
> > x2 : ffff8000a4256b00 x1 : 0000000000000001 x0 : 0000000000000000
> > Call trace:
> >  fsnotify_file_area_perm+0x20c/0x25c include/linux/fsnotify.h:145 (P)
> >  filemap_fault+0x12b0/0x1518 mm/filemap.c:3509
> >  xfs_filemap_fault+0xc4/0x194 fs/xfs/xfs_file.c:1543
> >  __do_fault+0xf8/0x498 mm/memory.c:4988
> >  do_read_fault mm/memory.c:5403 [inline]
> >  do_fault mm/memory.c:5537 [inline]
> >  do_pte_missing mm/memory.c:4058 [inline]
> >  handle_pte_fault+0x3504/0x57b0 mm/memory.c:5900
> >  __handle_mm_fault mm/memory.c:6043 [inline]
> >  handle_mm_fault+0xfa8/0x188c mm/memory.c:6212
> >  do_page_fault+0x570/0x10a8 arch/arm64/mm/fault.c:690
> >  do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
> >  do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:919
> >  el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
> >  el1h_64_sync_handler+0x60/0xcc arch/arm64/kernel/entry-common.c:510
> >  el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
> >  __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline] (P)
> >  fault_in_readable+0x168/0x310 mm/gup.c:2234 (P)
> >  fault_in_iov_iter_readable+0x1dc/0x22c lib/iov_iter.c:94
> >  iomap_write_iter fs/iomap/buffered-io.c:950 [inline]
> >  iomap_file_buffered_write+0x490/0xd54 fs/iomap/buffered-io.c:1039
> >  xfs_file_buffered_write+0x2dc/0xac8 fs/xfs/xfs_file.c:792
> >  xfs_file_write_iter+0x2c4/0x6ac fs/xfs/xfs_file.c:881
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0x704/0xa9c fs/read_write.c:679
>
> The backtrace actually explains it all. We had a buffered write whose
> buffer was mmapped file on a filesystem with an HSM mark. Now the prefaul=
ting
> of the buffer happens already (quite deep) under the filesystem freeze
> protection (obtained in vfs_write()) which breaks assumptions of HSM code
> and introduces potential deadlock of HSM handler in userspace with filesy=
stem
> freezing. So we need to think how to deal with this case...

Ouch. It's like the splice mess all over again.
Except we do not really care to make this use case work with HSM
in the sense that we do not care to have to fill in the mmaped file content
in this corner case - we just need to let HSM fail the access if content is
not available.

If you remember, in one of my very early version of pre-content events,
the pre-content event (or maybe it was FAN_ACCESS_PERM itself)
carried a flag (I think it was called FAN_PRE_VFS) to communicate to
HSM service if it was safe to write to fs in the context of event handling.

At the moment, I cannot think of any elegant way out of this use case
except annotating the event from fault_in_readable() as "unsafe-for-write".
This will relax the debugging code assertion and notify the HSM service
(via an event flag) that it can ALLOW/DENY, but it cannot fill the file.
Maybe we can reuse the FAN_ACCESS_PERM event to communicate
this case to HSM service.

WDYT?

Thanks,
Amir.

