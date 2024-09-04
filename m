Return-Path: <linux-fsdevel+bounces-28493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EC696B37F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3DF285932
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0B155314;
	Wed,  4 Sep 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD67Hpxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AA1494AB;
	Wed,  4 Sep 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436299; cv=none; b=TLFcRwJK2j2JDQCQtJdMetBvl1NJesbkX37xbvGZ6V1nxxWvsGDKTxlU9N3og+WYGlSVJjcqpx/Ce1g58TzxU1n1fXzdczbJROkoLn3dWLVS4UM5oytKaM0txuT75iYFliKA7wNOI6vH+bLPVkxXfBqGcQ2wuBkC0f1ArKaWX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436299; c=relaxed/simple;
	bh=kV6eUoyBuXHDWCvv5RZG9ev+01d7rb/4uyqtTs/FdLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkhVep+5YUbBQXk+0ySGDyM5sVSafr3858xO2Cs4loi2r40sPHaV3AmsvPUcFOaf6kYUKq40znEUgSc/ppGDbEhsui1L81rvWgcz1WZZnNck5TnIGSBdpAwzsg1XCxeaIahNqLbJ2SYOhCymviIbzfrjsB/ND5ob/xSYIRLVbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD67Hpxj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7177e6cd298so93941b3a.3;
        Wed, 04 Sep 2024 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725436296; x=1726041096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vg1mSeI6zz72mJj4C7GXUflyu+QpLqxkE7tXkXD/vgE=;
        b=PD67HpxjjkhS39zUVzkY9tRNdzh8SL3pZJRceyrfhMAkuFTrRVZ70wYY/mcO44HZCf
         V1bpZmfENAe+ySeWC2xoM3z7eSf6+tJ7miggTmXe5oWGe4PYiBGE9ERFqtXnLpnCTS0O
         XCORgbr7sy0QvBKCABK2p32LIPEVf4FlqJgJ+BbPP3+I/WBBiwrbFGqisfeuqJPNEg77
         ri530bf963JYApFWLuTaJWEewDUstKIDINokC7ab20sdfxrRZVTbFMr9MD5g4aj2OIex
         Gd2M2bsSQgIeLKVh2QtLPzAsqMJSznHlQX72I7hpf5FCn7cez1VX5PQYKeadlSLY2E2r
         4G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725436296; x=1726041096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vg1mSeI6zz72mJj4C7GXUflyu+QpLqxkE7tXkXD/vgE=;
        b=rX94WXU/TRWrLGbBA0d1evfnPrhe1OB28UZpgE55CgKd4Aaj9RQtaABifrQrzgIAV1
         azKyjlS///o/WgamCBLGP3ZQ809r372NzvqiWNFpwjC1N8W9v3ZZHHAWmwrVBnNqJ+7m
         RfWl23YGWGvNl87BtcnFR6if0xRoV/PmmI1kPZGf6QAY02DxKrwvpjFC/05ZSVmjE3MU
         XynMRt9qNC27qQZgy+VtdBXxPRp1qhDX0YXn1clqsnHKh/24WbKWzKBoG6aXcVvK2AwI
         QEqoSMsY8foaTRNbKVfesXd9Rumr/KyYE3Jq7lFOtxWSv9yAFG1nHQR+oydWYhIJOFSK
         XARw==
X-Forwarded-Encrypted: i=1; AJvYcCUK15psDy1Z8gRJbXlSMdkyQJU3lfypw8AEO0IOAodkycT8N/GY9n26B+OjkCiiT81Y9mEkJIk9xPANEre/Qw==@vger.kernel.org, AJvYcCUZRaGvCg8bG3iOEPrmO+n4IRK1USwg1A+8mxXtvP7r5Ac5egM3dqoy7oR5vOwiqfj0SZKqQwwofo5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzabYWApm+cbop5X3rLsHUrpg69OG4o57+Yzx3XXhbr+/omGh8n
	GaZYLEXZYYoedo0eBJWjzpFSc97tvXntex0V7urDKw9IGe8CveAJ8a9woqsJ
X-Google-Smtp-Source: AGHT+IELmM1EQLS9IdhWxoxVcs7iUKqtiecZAVt4BnkMBoKxT8fn8gVNvpEC9xi8LfktBBuf9ZqL2w==
X-Received: by 2002:a05:6a20:2a18:b0:1cc:e5eb:e91f with SMTP id adf61e73a8af0-1cce5ebe9b2mr14214871637.1.1725436296147;
        Wed, 04 Sep 2024 00:51:36 -0700 (PDT)
Received: from [127.0.0.1] ([191.96.241.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b924710dsm5385895ad.108.2024.09.04.00.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:51:35 -0700 (PDT)
Message-ID: <d20fadedac56247b3a92c651737b4e8bda05a879.camel@gmail.com>
Subject: Re: [PATCH] iomap: clean preallocated blocks in iomap_end() when 0
 bytes was written.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz,  brauner@kernel.org, djwong@kernel.org, hch@lst.de, 
 syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Date: Wed, 04 Sep 2024 15:51:31 +0800
In-Reply-To: <ZterXrqAFi9knEbD@dread.disaster.area>
References: <20240903054808.126799-1-sunjunchao2870@gmail.com>
	 <ZterXrqAFi9knEbD@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 10:35 +1000, Dave Chinner wrote:
Hi, Dave. Thanks for your review and comments.=20
> On Tue, Sep 03, 2024 at 01:48:08PM +0800, Julian Sun wrote:
> > Hi, all.
> >=20
> > Recently, syzbot reported a issue as following:
> >=20
> > WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 __iomap_write_b=
egin fs/iomap/buffered-io.c:727 [inline]
> > WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 iomap_write_beg=
in+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
> > CPU: 1 UID: 0 PID: 5222 Comm: syz-executor247 Not tainted 6.11.0-rc2-sy=
zkaller-00111-gee9a43b7cfe2 #0
> > RIP: 0010:__iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
> > RIP: 0010:iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
> > Call Trace:
> > =C2=A0<TASK>
> > =C2=A0iomap_unshare_iter fs/iomap/buffered-io.c:1351 [inline]
> > =C2=A0iomap_file_unshare+0x460/0x780 fs/iomap/buffered-io.c:1391
> > =C2=A0xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1681
> > =C2=A0xfs_file_fallocate+0x6be/0xa50 fs/xfs/xfs_file.c:997
> > =C2=A0vfs_fallocate+0x553/0x6c0 fs/open.c:334
> > =C2=A0ksys_fallocate fs/open.c:357 [inline]
> > =C2=A0__do_sys_fallocate fs/open.c:365 [inline]
> > =C2=A0__se_sys_fallocate fs/open.c:363 [inline]
> > =C2=A0__x64_sys_fallocate+0xbd/0x110 fs/open.c:363
> > =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > =C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f2d716a6899
> >=20
> > syzbot constructed the following scenario: syzbot called the write()
> > system call, passed an illegal pointer, and attempted to write 0x1017
> > bytes, resulting in 0 bytes written and returning EFAULT to user
> > space. Then, it called the write() system call again, passed another
> > illegal pointer, and attempted to write 0xfea7 bytes, resulting in
> > 0xe00 bytes written. Finally called copy_file_range() sys call and
> > fallocate() sys call with FALLOC_FL_UNSHARE_RANGE flag.
> >=20
> > What happened here is: during the first write, xfs_buffered_write_iomap=
_begin()
> > used preallocated 512 blocks, inserted an extent with a length of 512 a=
nd
> > reserved 512 blocks in the quota, with the iomap length being 1M.
>=20
> Why did XFS preallocate 512 blocks? The file was opened O_TRUNC, so
> it should be zero length and a write of just over 4100 bytes will
> not trigger speculative prealloc on a zero length file (threshold is
> 64kB). Indeed, the first speculative prealloc will only be 64kB in
> size...

Perhaps my wording was misleading. This might not be actual preallocation,=
=C2=A0
but rather it reached the following statement.
	if (xfs_has_allocsize(mp))
		prealloc_blocks =3D mp->m_allocsize_blocks;
And mp->m_allocsize_blocks is 512.
>=20
> Hence it's not immediately obvious what precondition is causing this
> behaviour to occur.
>=20
> > However, when the write failed(0 byte was written), only 0x1017 bytes w=
ere
> > passed to iomap_end() instead of the preallocated 1M bytes/512 blocks.
> > This caused only 3 blocks to be unreserved for the quota in iomap_end()=
,
> > instead of 512, and the corresponding extent information also only remo=
ved
> > 3 blocks instead of 512.
>=20
> Why 3 blocks? what was the filesystem block size? 2kB?

Exactly. GDB observed that sb_blocksize was 2048 and sb_blocklog was 11.
>=20
> This also smells of delayed allocation, because if it were
> -preallocation- it would be unwritten extents and we don't punch
> them out on write failures. See my first question....
>=20
> Regardless, the behaviour is perfectly fine. The remainder of the
> blocks are beyond EOF, and so have no impact on anything at this
> point in time.
>=20
> > As a result, during the second write, the iomap length was 3 blocks
> > instead of the expected 512 blocks,
>=20
> What was the mapping? A new delalloc extent from 0 to 6kB? If so,
> that is exactly as expected, because there's a hole in the file
> there.

Yeah. There's a delalloc extent from 0 to 6KB.
And below is the log of extent changes during the reproduction=C2=A0
process before the panic.

[   24.466778][ T2491] write begin for ino 9292 offset 0 count 4119 offset_=
fsb 0 end_fsb 3=20
[   24.467325][ T2491] insert extent pos:0 off:0 count:512 start:4503599627=
239434
[   24.467909][ T2491] iomap->offset is 0 iomap->length is 1048576
[   24.468603][ T2491] update extent before pos:0 off:0 count:512 start:450=
3599627239434
[   24.469089][ T2491] update extent after  pos:0 off:3 count:509 start:450=
3599627239434
write: Bad address
[   24.469734][ T2491] write begin for ino 9292 offset 0 count 65191 offset=
_fsb 0 end_fsb 32=20
[   24.470206][ T2491] update extent before pos:0 off:3 count:509 start:450=
3599627239434
[   24.470673][ T2491] update extent after  pos:0 off:0 count:512 start:450=
3599627239434
[   24.471110][ T2491] iomap->offset is 0 iomap->length is 6144
[   24.471916][ T2491] update extent before pos:0 off:0 count:512 start:450=
3599627239434
[   24.472382][ T2491] update extent after  pos:0 off:0 count:2 start:45035=
99627239429
[   24.472838][ T2491] insert extent pos:1 off:3 count:509 start:4503599627=
239430
[   24.473270][ T2491] write begin for ino 9292 offset 3584 count 61607 off=
set_fsb 1 end_fsb 32=20
write ret is 0xe00
[   24.474517][ T2491] update extent before pos:0 off:0 count:2 start:45035=
99627239429
[   24.474994][ T2491] update extent after  pos:0 off:0 count:2 start:13
[   24.476451][    T8] update extent before pos:0 off:0 count:2 start:13
[   24.476902][    T8] update extent after  pos:0 off:0 count:2 start:13
[   24.478880][ T2491] insert extent pos:0 off:0 count:2 start:13
copy_file_range ret is 0xe00
[   24.481463][ T2491] write begin for ino 9292 offset 0 count 8192 offset_=
fsb 0 end_fsb 4=20
[   24.481968][ T2491] insert extent pos:0 off:0 count:32 start:45035996272=
39430
[   24.482422][ T2491] write begin for ino 9292 offset 4096 count 4096 offs=
et_fsb 2 end_fsb 4=20
[   24.482882][ T2491] write begin for ino 9292 offset 6144 count 2048 offs=
et_fsb 3 end_fsb 4

Note the last two logs: fallocate() successfully unshared 4k bytes,=C2=A0
then skipped the last 2k=C2=A0bytes because they were not being shared,=C2=
=A0
and then=C2=A0attempted to unshare 2k bytes beyond EOF.
>=20
> > which ultimately triggered the
> > issue reported by syzbot in the fallocate() system call.
>=20
> How? We wrote 3584 bytes, which means the first 2 blocks were
> written and marked dirty, and the third block should have been
> punched out by the same process that punched the delalloc blocks in
> the first write. We end up with a file size of 3584 bytes, and
> a delalloc mapping for those first two blocks followed by a hole,
> followed by another delalloc extent beyond EOF.
>=20
> There is absolutely nothing incorrect about this state - this is
> exactly how we want delalloc beyond EOF to be handled. i.e. it
> remains in place until it is explicitly removed. An normal
> application would fix the write buffer and rewrite the data, thereby
> using the space beyond EOF that we've already preallocated.
Got it. Thanks for your explanation.
>=20
> IOWs, this change in this patch is papering over the issue by
> preventing short writes from leaving extents beyond EOF, rather than
> working out why either CFR or UNSHARE is going wrong when there are
> extents beyond EOF.
Yeah, totally agreed.=20
>=20
> So, onto the copy_file_range() bit.
>=20
> Then CFR was called with a length of 0xffffffffa003e45bul, which is
> almost 16EB in size. This should result in -EOVERFLOW, because that
> is out of the range that an loff_t can represent.
>=20
> i.e. generic_copy_file_checks() does this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pos_in + count < pos_=
in || pos_out + count < pos_out)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EOVERFLOW;
>=20
> and pos_in is a loff_t which is signed. Hence (0 + 15EB) should
> overflow to a large negative offset and be less than 0. Implicit
> type casting rules always break my brain - this looks like it is
> casting everything to unsigned, thereby not actually checking if
> we're overflowing the max offset the kernel can operate on.
Yes! The check was supposed to fail here, but it didn't. Maybe what=20
we should do is like this:
	if (pos_in + (loff_t)count < pos_in || pos_out + (loff_t)count < pos_out)
                return -EOVERFLOW;
My tests showed that CFR returned -EOVERFLOW with=C2=A0the change.

A search for the keyword "Ensure offsets don't wrap" shows that there is=C2=
=A0
also this kind of implicit conversion issue in generic_remap_checks().
And xfs_exchange_range_checks() uses check_add_overflow() to check for=C2=
=A0
overflow. Clearly, the latter is a more elegant way of checking.=C2=A0

I'm wondering if we have any tools or can we create a tool to check=C2=A0
for such implicit conversions.=C2=A0GCC provides -Wconversion, but it repor=
ts=C2=A0
too many issues, and people=C2=A0might get overwhelmed by such information.
Or can we find a method to filter the warning that we really need to fix?
>=20
> This oversize length is not caught by a check against max file size
> supported by the superblock, either,, because the count gets
> truncated to EOF before the generic checks against supported maximum
> file sizes are done.
>=20
> That seems ... wrong. Look at fallocate() - after checking for
> overflow, it checks offset + len against inode->i_sb->s_maxbytes and
> returns -EFBIG at that point.

In this case, offset is 0 and len is 8192, so the check in fallocate()
should passed.
>=20
> IOWs, I think CFR should be doing nothing but returning either
> -EOVERFLOW of -EFBIG here because the length is way longer than
> maximum supported file offset for any file operation in Linux.=C2=A0 Then
> unshare should do nothing because the file is not shared and should
> not have the reflink flag set on it.....
>=20
> However, the strace indicates that:
>=20
> copy_file_range(6, [0], 5, NULL, 18446744072099193947, 0) =3D 3584
>=20
> That it is copying 3584 bytes. i.e. the overflow check is broken.
> It indicates, however, that the file size is as expected from the
> the short writes that occurred.
>=20
> Hence the unshare operation should only be operating on the range of
> 0-3584 bytes because that is the only possible range of the file
> that is shared.
>=20
> However, the fallocate() call is for offset 0, length 0x2000 bytes
> (8kB), and these ranges are passed directly from XFS to
> iomap_file_unshare().=C2=A0 iomap_file_unshare() never checks the range
> against EOF, either, and so we've passed a range beyond EOF to
> iomap_file_unshare() for it to process. That seems ... wrong.
>=20
> Hence the unshare does:
>=20
> first map:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 - 4k - unshare successfu=
lly.
> second map:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04k - 6k - hole, skip. Beyond EOF=
.
> third map:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A06k - 8k - delalloc, beyond =
EOF so needs zeroing.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Fires warnings because UNSHARE.

Yes. A slight difference: the second mapping was skipped because it wasn't=
=C2=A0
marked with IOMAP_F_SHARED.=20
>=20
> IOWs, iomap_file_unshare() will walk beyond EOF blissfully unaware
> it is trying to unshare blocks that cannot ever be shared first
> place because reflink will not share blocks beyond EOF. And because
> those blocks are beyond EOF, they will always trigger the "need
> zeroing" case in __iomap_write_begin() and fire warnings.
>=20
> So, yeah, either xfs_file_fallocate() or iomap_file_unshare() need
> to clamp the range being unshared to EOF.
>=20
> Hence this looks like a couple of contributing issues that need to
> be fixed:
>=20
> - The CFR overflow checks look broken.
> - The unshare range is never trimmed to EOF.

Exactly. The first can be fixed with using check_add_overflow() macro.
The latter one maybe can be fixed with the following patch:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86ac..8898d5ec606f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *i=
ter)
        /* don't bother with holes or unwritten extents */
        if (srcmap->type =3D=3D IOMAP_HOLE || srcmap->type =3D=3D IOMAP_UNW=
RITTEN)
                return length;
+       /* don't try to unshare any extents that beyond EOF. */
+       if (pos > i_size_read(iter->inode))
+               return length;
=20
        do {
                struct folio *folio;

>=20
> but it's definitely not a bug caused by short writes leaving
> delalloc extents beyond EOF. There are many, many ways that
> we can create delalloc extents beyond EOF before running an UNSHARE
> operation that can trip over them like this.
>=20

I see. Thanks again for your detailed and patient explanation.=20
> -Dave.

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

