Return-Path: <linux-fsdevel+bounces-56145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BCEB1407B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4561887515
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C14255E4E;
	Mon, 28 Jul 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCQ+ahFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F79218ABD;
	Mon, 28 Jul 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720793; cv=none; b=Jw0i7uopTPLXngPsVTua5zZz0oy2X+xAkiqI7cADRiDXyFgzBboijSY3JaZ8E4UwJwsXeJk0PcfljPYEEmx1BKG67zFRkUe1ArADGAjuXEIDJays02E5IG3FGJovuIVWfrLvTzpWSgc6X5vY1NeBz35LFt/3pfH11IOZdIbOr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720793; c=relaxed/simple;
	bh=DHdJY8Nyw/eezwSfp1iohf/MJLxMdT9rkKVeRnGagvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTPMa1xE+KFVAWhbdiZDCpMMOCqfsa1+mqU2h4C0HT4ubKcD8Plcxx4qD/rmpYFzsdXl49uVG3P/h8gRIUtZYNhQHX4t9K6G7un85Hbn/WOaWxyAQ1Rzv+0t18buyML06WB9Kaae+1E2oT2/VRaMYxls96hon240Ksr0LD2pu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCQ+ahFH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7dfff5327fbso595588785a.1;
        Mon, 28 Jul 2025 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753720790; x=1754325590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iqanfr5VpMEWo2OMfd7bLfbNXXcRloY7RJuwr1ZN80=;
        b=dCQ+ahFHDNXdyjMP79livhm6ksQ12W4SLW2qQCJYJ/lhbriYnc3ZyD+cE07mkM7isr
         7Cb/QFTIQNsukdLHsmGd7o/mXq4rbdeoEdlkegvYaUA2rJQVqKwq+3ITPBDBu4JKmoM0
         0En88sR8JixstomgS3l+HWgPSfKHrFZ0Drob715m5zRpwjItbEoNECNQcCXq4QvjmAcK
         /MFBBSRYb9LHiYMB373aCt/Tlu7dso3ppS3XFZ6V4zOYWrftNVe+Dbdt7Votwwr7OVN8
         P4/TlLfdilUdJAYsKPzzXc+h+EeeYwXDksaucLLRiVonHx3LXQHUzOn4oWlqqZlmCblL
         P29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720790; x=1754325590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iqanfr5VpMEWo2OMfd7bLfbNXXcRloY7RJuwr1ZN80=;
        b=AxXQadG4j8uJ8hxA/yr1PzeyjFz6ooG272wQyrz4GzozYaz2BhvJix5+3/vcQCujdh
         HvElEGnTKKGccA7JOYY9A4rTIST/UUlRNvrMwlDByyf5sIt6mPrb8awacYkQ/SDPDb9O
         WLEeiauJcswfClaXoHkttwpV6Ul/s+XmRv5PMHvkp3Pk3VgfODKv6V5zKaSvtX4vojIN
         853/7z4se4gQcNIOwfVJQOpt/vUnof9aGho4U69kUQ52TDo9/vN0KNbRw8sn1Q75Bo68
         VlW1XI/S8MNxnpSjqYaaOtAM50GPHKqKZP0giE4TfRzCoUbjWpYXGgANkSgHqzrNUimC
         MHVg==
X-Forwarded-Encrypted: i=1; AJvYcCVulGXx6ACrEYS2am6Nk7gtNMQoRW1h0hjmZvY77if4gGkVq8Iu7MxvN8K40Fs6EQB0vYqUTiSHxhBFq1uf@vger.kernel.org, AJvYcCWtMWBppBCWW1WeqrMqQr/kY7Yxbnsn1ms5WKi8AaZoIymOMVtpAhXGm8wXCUkRyW4LS2q2mWQxiM/51Nf3@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsoXLxNUcQosUmuiXTuG9HwWO6u7wQLQvUp2JGC+WHEN5y5AT
	khEQP3Hr67qxej+7XITxZ3Bc42bwjdqyLk7M+/onKr3Gr0Kmh/riVeH5terjgH8ljI0RWIf/g1K
	UHY5/O4bL+O19tE7eauxKBFSZu/r3zOg0Fd5jTW0=
X-Gm-Gg: ASbGncsGcUjYByRaMPcuxmlx/2QWn0f7tCWAoKohAZ3pwguMWGiIAOLaVsoQ0qcF54C
	FrY2ZwD4bzqkbKZC43w7UjPJPN4JegNj1yLJ5k1FlXYbVgZe7lBD7y2gG1MM57hOWxk7YF8BqEF
	eph8SX2ldxmT/T+NLYm//+gBqs45fBHFt21dRkA0/unuuXHU8hnbgEZsWZr+7MFIQ79llRFL+Up
	VzkZp+9yaW9PwM3fw==
X-Google-Smtp-Source: AGHT+IECywkzES5UCbVfFmefjBDbVTCVLgyFPbZf0HPtg7JDYn6X+ZvxwFYdG97YQKfxUrtcoofNwS+l1zO9DPdP4js=
X-Received: by 2002:a05:620a:284c:b0:7e6:5ef5:846c with SMTP id
 af79cd13be357-7e65ef5989cmr72434285a.66.1753720789798; Mon, 28 Jul 2025
 09:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-iomap-e5f67758f577@brauner>
 <aIYlKgQZNF7-LgIp@lappy>
In-Reply-To: <aIYlKgQZNF7-LgIp@lappy>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Jul 2025 09:39:37 -0700
X-Gm-Features: Ac12FXxV7al0oaIY8ZcYlWybr5Q6x7NpsVNZInsd-r6UEXpQUlTdTXw9cfUjif0
Message-ID: <CAJnrk1Z3mPjbBnYRgAgAe9t9R6uNWSo8smD4S2gTZg3NonaJfw@mail.gmail.com>
Subject: Re: [GIT PULL 14/14 for v6.17] vfs iomap
To: Sasha Levin <sashal@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 6:10=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Hey Christian,
>
> On Fri, Jul 25, 2025 at 01:27:20PM +0200, Christian Brauner wrote:
> >Hey Linus,
> >
> >/* Summary */
> >This contains the iomap updates for this cycle:
> >
> >- Refactor the iomap writeback code and split the generic and ioend/bio
> >  based writeback code. There are two methods that define the split
> >  between the generic writeback code, and the implemementation of it,
> >  and all knowledge of ioends and bios now sits below that layer.
> >
> >- This series adds fuse iomap support for buffered writes and dirty
> >  folio writeback. This is needed so that granular uptodate and dirty
> >  tracking can be used in fuse when large folios are enabled. This has
> >  two big advantages. For writes, instead of the entire folio needing to
> >  be read into the page cache, only the relevant portions need to be.
> >  For writeback, only the dirty portions need to be written back instead
> >  of the entire folio.
>
> While testing with the linus-next tree, it appears that LKFT can trigger
> the following warning, but only on arm64 tests (both on real HW as well
> as qemu):
>
> [ 333.129662] WARNING: CPU: 1 PID: 2580 at fs/fuse/file.c:2158 fuse_iomap=
_writeback_range+0x478/0x558 fuse
> [  333.132010] Modules linked in: btrfs blake2b_generic xor xor_neon raid=
6_pq zstd_compress sm3_ce sha3_ce sha512_ce fuse drm backlight ip_tables x_=
tables
> [  333.133982] CPU: 1 UID: 0 PID: 2580 Comm: msync04 Tainted: G        W =
          6.16.0-rc7 #1 PREEMPT
> [  333.134997] Tainted: [W]=3DWARN
> [  333.135497] Hardware name: linux,dummy-virt (DT)
> [  333.136114] pstate: 03402009 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYP=
E=3D--)
> WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and =
DEBUG_INFO
> [ 333.137090] pc : fuse_iomap_writeback_range+0x478/0x558 fuse
> [ 333.138009] lr : iomap_writeback_folio (fs/iomap/buffered-io.c:1586 fs/=
iomap/buffered-io.c:1710)
> [  333.138510] sp : ffff80008be8f8c0
> [  333.138653] x29: ffff80008be8f8c0 x28: fff00000c5198c00 x27: 000000000=
0000000
> [  333.138975] x26: fff00000d32b8c00 x25: 0000000000000000 x24: 000000000=
0000000
> [  333.139309] x23: 0000000000000000 x22: fffffc1fc039ba40 x21: 000000000=
0001000
> [  333.139600] x20: ffff80008be8f9f0 x19: 0000000000000000 x18: 000000000=
0000000
> [  333.139917] x17: 0000000000000000 x16: ffffbb40f61c3a48 x15: 000000000=
0000000
> [  333.142199] x14: ffffbb40f6924788 x13: 0000ffff8e8effff x12: 000000000=
0000000
> [  333.142739] x11: 1ffe0000199a9241 x10: fff00000ccd4920c x9 : ffffbb40f=
50bba18
> [  333.143466] x8 : ffff80008be8f778 x7 : ffffbb40ee180b68 x6 : ffffbb40f=
76c9000
> [  333.143718] x5 : 0000000000000000 x4 : 000000000000000a x3 : 000000000=
0001000
> [  333.143957] x2 : fff00000c0b6e600 x1 : 000000000000ffff x0 : 0bfffe000=
000400b
> [  333.144993] Call trace:
> WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and =
DEBUG_INFO
> [ 333.145466] fuse_iomap_writeback_range+0x478/0x558 fuse (P)
> [ 333.146136] iomap_writeback_folio (fs/iomap/buffered-io.c:1586 fs/iomap=
/buffered-io.c:1710)
> [ 333.146444] iomap_writepages (fs/iomap/buffered-io.c:1762)
> WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and =
DEBUG_INFO
> [ 333.146590] fuse_writepages+0xa0/0xe8 fuse
> [ 333.146774] do_writepages (mm/page-writeback.c:2636)
> [ 333.146915] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:376)
> [ 333.147788] __filemap_fdatawrite_range (mm/filemap.c:420)
> [ 333.148440] file_write_and_wait_range (mm/filemap.c:794)
> WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and =
DEBUG_INFO
> [ 333.149054] fuse_fsync+0x6c/0x138 fuse
> [ 333.149578] vfs_fsync_range (fs/sync.c:188)
> [ 333.149892] __arm64_sys_msync (mm/msync.c:96 mm/msync.c:32 mm/msync.c:3=
2)
> [ 333.150095] invoke_syscall.constprop.0 (arch/arm64/include/asm/syscall.=
h:61 arch/arm64/kernel/syscall.c:54)
> [ 333.150330] do_el0_svc (include/linux/thread_info.h:135 (discriminator =
2) arch/arm64/kernel/syscall.c:140 (discriminator 2) arch/arm64/kernel/sysc=
all.c:151 (discriminator 2))
> [ 333.150461] el0_svc (arch/arm64/include/asm/irqflags.h:82 (discriminato=
r 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/inc=
lude/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:=
165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1=
) arch/arm64/kernel/entry-common.c:768 (discriminator 1))
> [ 333.150583] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:787)
> [ 333.150729] el0t_64_sync (arch/arm64/kernel/entry.S:600)
> [  333.150862] ---[ end trace 0000000000000000 ]---
>
> I think that this is because the arm64 tests run on
> CONFIG_PAGE_SIZE_64KB=3Dy build, but I'm not sure why we don't see it wit=
h
> 4KB pages at all.
>
> An example link to a failing test that has the full log and more
> information: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v=
6.13-rc7-44385-g8a03a07bad83/testrun/29269158/suite/log-parser-test/test/ex=
ception-warning-cpu-pid-at-fsfusefile-fuse_iomap_writeback_range/details/
>

This was reported last week as well in [1]. The fix for this is in
https://lore.kernel.org/linux-fsdevel/20250723230850.2395561-1-joannelkoong=
@gmail.com/

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcn=
SkHsjZajVwwpM2HmJw@mail.gmail.com/

> --
> Thanks,
> Sasha
>

