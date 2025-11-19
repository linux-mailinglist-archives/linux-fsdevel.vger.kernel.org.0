Return-Path: <linux-fsdevel+bounces-69135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4858C70C71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 755C84E26B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877432C945;
	Wed, 19 Nov 2025 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiGe9OTr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE6366DD8
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579888; cv=none; b=VVIbxdUQhzXyeuS0NQeTpqaJUdI+eyvY4TIBKl9vpJ/cK7cUTjqM0Igbc37obd8yKmWT4SplKL6xIA8D8/swUGVacLfQostGYCn+7pEMlY4B8939kxcCAiZuhYxlGYOtKW5/tru5FBZbQ1jozoP0YMWoX2x+jfNNje2fHVzaIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579888; c=relaxed/simple;
	bh=sXvNveCj5RsR7izZgDl7xr9mf+tj0WUfN0BozgR4LCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ9gfbxMqydPk+8V5JuJHKBR32MuhkhdUKvMerbSK5ycPQ3S6OSP1EgUV1yenhZuojM+Uv0DbpT1Wj0BRxjO4TG07eqdxLcow6xs0gjwtQxdo6rnc9fbouaH21qgjzKS14Y2p5MAtAzVjaPrw5bx+EsrpMHEuctbVZUXi5ZOdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiGe9OTr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso5650e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 11:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763579876; x=1764184676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/R12esZSwS32SVcJpndlG9aLDEVya1imjhVyURtQMg=;
        b=TiGe9OTrmLdKlLGZs0taK+sKMvv4LRv4jLmG0poERXMRakUp5nxij2prNlpdP4m+CR
         PdReel9mAL5UoKZ4/S9rw368pEvd/nZQpD9x2CvzLo8tU8kMtBojHpdgOAEMR2z5Ph6D
         uZq/N0TvqbxUzOIuTcdtJmka7ik1MlW5leCosRO6UThDebmbOyYxwCf/E0DfIEmw76dr
         8WaRykr6YRi3z+i6YilILaLtdHo2MWwzMHEfyP/ap/QtXIs1PINZsyx8rvzjOw4EeIhb
         sxSUd7/Xxmpbx42HF1/G00xf0R5ZGCDwyS3zTN8aTa6JqAbdtUGcYHN+0u3eERSrypVu
         fJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763579876; x=1764184676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/R12esZSwS32SVcJpndlG9aLDEVya1imjhVyURtQMg=;
        b=wKdDXh1v4jGiWrjVDCLFrK1vyc4gt/3qS4IHsJjDZ1XMMlfXns1haVeDaYWDYJ3rkH
         USqopQStwYQlA/f/hHahn6cD7nhW4cnsRcAjw4knfeYL8UAYyUvZSGTFEyBhAqgD5Zgw
         1llqtxiTijb6q2ZHHCk28fjjgXi0FVIaei1bRUGAxDwXhvp39G+GJz2QNI0KrGYQh0Ib
         Cm/I4LjF1TIL+gd7+sJvVUSzMmqr/qTMcgc+EcpH4A2DvGOOYxz4UvADOt83M6u1mVxg
         wFiA8akBC+MKXBoKhv9E2OgEZ4K98hd8AFaE7WB0Yr6QakzhKStLcUDxcUmY2I6huvIX
         RUbg==
X-Forwarded-Encrypted: i=1; AJvYcCWLat183svfbqzE6X+FZSbTcRNZsEuCElJaq1MAs+WfyhmVKBlLxP6oAazGAobGtFU/k85gmOm2PJN7f0Oe@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3IwjnAf3XFjvBu8vlQkwgewWnskq3p3+CBCMOg5weuz2GKxP
	gzHiJiWKinDDql9P9thx99jsmJ/qUM9oM8z9C9ytwnKyjyZqhcA+CjIyNC4NWK2OQYPRAQ25fhZ
	LR4Xvf05e2jSyCnUY0G19hPIS31CxpD8=
X-Gm-Gg: ASbGncscgpkfpJ6R972KhbUDRiXNQzitB9avkRk2v6Ui5TPuKTpHCdb4idkW4NDmuoz
	5gK30fV2IjGkAW9sBHpx8J9smRjakPU8AfUB8ZAoRgJj3gAQ2Yt04s+Iv0m/mFiej10RnyMdm2k
	cBhBnodOD2hzScX3jw91SR2BPxCECc134e/aF1kKphveelAd9+eM+yu6EMJRW7nZKwIkayjfXGZ
	BV+U/wxrOpAZVoL5ejvqEqpfNZcZv4/VirFPg3/56HGVlMoVy3r9eELX0+nTLceYvZ9nA==
X-Google-Smtp-Source: AGHT+IHxivACkU+pa3LNz9bpvNraWDgovPdx7Tl+tv0X9qqpM5slXy09YI3O4oLYonvXdSJ6kPHqByxTQztdyYAEZtc=
X-Received: by 2002:a05:6512:1246:b0:595:8062:135 with SMTP id
 2adb3069b0e04-5969e2e7384mr8863e87.20.1763579875450; Wed, 19 Nov 2025
 11:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com> <aR08JNZt4e8DNFwb@casper.infradead.org>
 <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com> <20251119182750.GD196391@frogsfrogsfrogs>
In-Reply-To: <20251119182750.GD196391@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 19 Nov 2025 11:17:41 -0800
X-Gm-Features: AWmQ_bl0t27vYxwFUx8av_HcsdpnW5EVJ1Zv__dQVKdV_FhMjAmPIiKz1TIdZLM
Message-ID: <CAJnrk1apaZmNyMGQ5ixfH8-10VL_aQAG8--3m-rUmB6-e-dtVQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:27=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Nov 19, 2025 at 10:10:40AM -0800, Joanne Koong wrote:
> > On Tue, Nov 18, 2025 at 7:40=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Tue, Nov 11, 2025 at 11:36:56AM -0800, Joanne Koong wrote:
> > > > Use loff_t instead of u64 for file positions and offsets to be
> > > > consistent with kernel VFS conventions. Both are 64-bit types. loff=
_t is
> > > > signed for historical reasons but this has no practical effect.
> > >
> > > generic/303       run fstests generic/303 at 2025-11-19 03:27:51
> > > XFS: Assertion failed: imap.br_startblock !=3D DELAYSTARTBLOCK, file:=
 fs/xfs/xfs_reflink.c, line: 1569
> > > ------------[ cut here ]------------
> > > kernel BUG at fs/xfs/xfs_message.c:102!
> > > Oops: invalid opcode: 0000 [#1] SMP NOPTI
> > > CPU: 8 UID: 0 PID: 2422 Comm: cp Not tainted 6.18.0-rc1-ktest-00035-g=
b94488503277 #169 NONE
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debia=
n-1.16.3-2 04/01/2014
> > > RIP: 0010:assfail+0x3c/0x46
> > > Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 =
e8 e4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0=
b 5d c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
> > > RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
> > > RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
> > > RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
> > > RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
> > > R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
> > > R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
> > > FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  xfs_reflink_remap_blocks+0x259/0x450
> > >  xfs_file_remap_range+0xe9/0x3d0
> > >  vfs_clone_file_range+0xde/0x460
> > >  ioctl_file_clone+0x50/0xc0
> > >  __x64_sys_ioctl+0x619/0x9d0
> > >  ? do_sys_openat2+0x99/0xd0
> > >  x64_sys_call+0xed0/0x1da0
> > >  do_syscall_64+0x6a/0x2e0
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x7fc4cd34d37b
> > > Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 =
89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 0=
0 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> > > RSP: 002b:00007ffeb4734050 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc4cd34d37b
> > > RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> > > RBP: 00007ffeb4734490 R08: 00007ffeb4734660 R09: 0000000000000002
> > > R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000001
> > > R13: 0000000000000000 R14: 0000000000008000 R15: 0000000000000002
> > >  </TASK>
> > > Modules linked in:
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:assfail+0x3c/0x46
> > > Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 =
e8 e4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0=
b 5d c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
> > > RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
> > > RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
> > > RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
> > > RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
> > > R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
> > > R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
> > > FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
> > > PKRU: 55555554
> > > Kernel panic - not syncing: Fatal exception
> > > Kernel Offset: disabled
> > > ---[ end Kernel panic - not syncing: Fatal exception ]---
> > >
> >
> > First off, it's becoming clear to me that I didn't test this patchset
> > adequately enough. I had run xfstests on fuse but didn't run it on
> > XFS. My apologies for that, I should have done that and caught these
> > bugs myself, and will certainly do so next time.
> >
> > For this test failure, it's because the change from u64 to loff_t is
> > overflowing loff_t on xfs. The failure is coming from this line change
> > in particular:
> >
> > -static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range=
_start,
> > - u64 range_end)
> > +static unsigned iomap_find_dirty_range(struct folio *folio, loff_t
> > *range_start,
> > + loff_t range_end)
> >
> > which is called when writing back the folio (in iomap_writeback_folio()=
).
> >
> > I added some printks and it's overflowing because we are trying to
> > write back a 4096-byte folio starting at position 9223372036854771712
> > (2^63 - 4096) in the file which results in an overflowed end_pos of
> > 9223372036854775808 (2^63) when calculating folio_pos + folio_size.
> >
> > I'm assuming XFS uses these large folio positions as a sentinel/marker
> > and that it's not actually a folio at position 9223372036854771712,
> > but either way, this patch doesn't seem viable with how XFS currently
> > works and I think it needs to get dropped.
>
> xfs supports 9223372036854775807-byte files, so 0x7FFFFFFFFFFFF000
> is a valid location for a folio.

Is 9223372036854775807 the last valid file position supported on xfs
or does xfs also support positions beyond that?

Thanks,
Joanne
>
> --D
>
> > I'm going to run the rest of the xfstests suite on XFS for this
> > patchset series to verify there are no other issues.
> >
> > Thanks,
> > Joanne

