Return-Path: <linux-fsdevel+bounces-69130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C22C7099E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0805350B24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7154366DAE;
	Wed, 19 Nov 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5aVdLZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032C364E96
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575866; cv=none; b=JLsRaFcPYRyiGHnNragDPiFcqbsk8SexBMJtMmFOLXpL+b/m5lP/4FCfUD1g1Ry1yuWwHxfAkFgtQGGSg+J6gHlUm9/67yeX4pEXIN+HsuOSqeTiYgHSAP+qzXAnJeG9Geo98PhZ3Bw4O2Rp0Do6YO4RQnOnBUiO0lRWerwoaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575866; c=relaxed/simple;
	bh=zdZ1Y8GhSQongkA81bDEbEzCiCv/AlYX/8cOkPrNi/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3Wdx9aw7odtpksjX/0OeXKiasHIGIHXySlEG7Wq+zZpKLq+Pt4rH1F925uLqQktqDFkrQWzmt22KVNww+PRYXq6q18GdFySPWmxtn+t7GGS/gPXIIS+QTKU5LYkyovJ+6OFEM24F62Y/3cHkh4gwo/fH/M2470XND1TPXDRxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5aVdLZG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-595819064cdso18141e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763575856; x=1764180656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SII8EDUHp2G/+OVTXEL27EbwiX9iF0Ts0kDDhJtrOWA=;
        b=L5aVdLZGm6wPxFhHR715Px55low8/ASMQuu4QN86Pv3SnrJNXbgQnpRywHIjzpCXMa
         H8ue/g4TSHeh3c0MaDmQ4l3udqwVaSDLcXIrY7jmauATbsZIN05kPEmKB7emwYVeKer2
         fji2dLLkqnYSvfW0JckZ5qG6NmecBL3oaKrFBjVwL08GyYsjku8S+ptRTCd77QmrXSXH
         Aml+1f2LT8cips0bAXgfexedgA0L7DMHvs/i6P8LhYDNA147ce4kt3dKeDF/oCMoR4Yg
         2KigBzx3X76I//nLrjfuXKIFNob7tlyx13C9SV+l3a1Znbg7whHgfiK++NV/edodJL1I
         8j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575856; x=1764180656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SII8EDUHp2G/+OVTXEL27EbwiX9iF0Ts0kDDhJtrOWA=;
        b=xTuQeKV5cs0UpJoHMmz1wqCIYaEWjt5mnPsBxzA2+imiChmh7/AqFohOBy5bKUUzzz
         +Y/DBMkgVH8oJuD96gGmsslBKskJ2wZCb7myQz9avn1IwDZ882Oh6DuqzO9Y1xghRy78
         NbO0gKokHkSWln+iBgrVOa45Y+ZkWCAzhL1poMUpI7mHrKqCteJa/ZcF669E9phq/fhp
         JpyI4uO0O2kSqEM8k9jffKyXB6DtPFVYBAjd1c2LSEyJ3PZOBuvDwiv/WnPndOW3WLga
         Tt28k4LySqtRlaAcVWpCWdRlt8QhrgXs5q5/CjowCJFWBkqimWjrKFcluSRdfJ15D+4s
         oVpw==
X-Forwarded-Encrypted: i=1; AJvYcCUqlbQ75OENTvPGbay/2Sf2bzwWRZo1QyqhOBnc37nY0+6c9bSnGnBJ+Bw3O9NWcnyW1YEe7h04F2zAE2jB@vger.kernel.org
X-Gm-Message-State: AOJu0YwKihD9HRSIUP+OM7ExVYe4/GF0C6cHtOKH4Jj8g9/7osNuwy1Y
	RA0lRrntWICLSNyd2AWX4D0FogJ9hKzSzaKmywW0piRafHjz881Y8hhdNhsxeZPDd1DkvSvEHg3
	RFlgiY5XlnlXQnOKyA+4C0IRwlashwdc=
X-Gm-Gg: ASbGncsV7uQzTUCGdmisv7W/3mBSBh45RwvgLHOwZNWMa/20ZT3HG02lSHCP2NFKccD
	WL2b+pKb/nt9xrFSnCtQCnOwNMxXWHyqGnc29Ju965x+cq1cf5ZLZoiSKDVJOtRwiPK/lkPa1pA
	y213QuRjLBwr/QUvhb/OwOanHRNkybD4eLyTp6GwkW1AGUFxwF1E5URvACEFu0cWo4asJ2O1pTX
	p+ugWOeg7iMfwmUTxW1kSZo+ems7bAIvIDErQEtAYQanaLu8cD+9MB21q2gkxnbJ120PX2OeLuq
	cTMg
X-Google-Smtp-Source: AGHT+IFIO4Xe9wKXnOcVT3DU13l52de62L2yDReQzjfoYC1jcEnTnBq3VrB7J6S5gPrdD9CdmKRPesZtawCXyQdxQYQ=
X-Received: by 2002:a05:6512:4022:b0:594:773e:7631 with SMTP id
 2adb3069b0e04-5963c6dd6e1mr1101799e87.7.1763575855485; Wed, 19 Nov 2025
 10:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com> <aR08JNZt4e8DNFwb@casper.infradead.org>
In-Reply-To: <aR08JNZt4e8DNFwb@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 19 Nov 2025 10:10:40 -0800
X-Gm-Features: AWmQ_bkchx1op7cbPXIrb-slssoN0OZ3wvM0rMxxQFL3NjhXB4SrtBxI8-gYhl4
Message-ID: <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:40=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 11, 2025 at 11:36:56AM -0800, Joanne Koong wrote:
> > Use loff_t instead of u64 for file positions and offsets to be
> > consistent with kernel VFS conventions. Both are 64-bit types. loff_t i=
s
> > signed for historical reasons but this has no practical effect.
>
> generic/303       run fstests generic/303 at 2025-11-19 03:27:51
> XFS: Assertion failed: imap.br_startblock !=3D DELAYSTARTBLOCK, file: fs/=
xfs/xfs_reflink.c, line: 1569
> ------------[ cut here ]------------
> kernel BUG at fs/xfs/xfs_message.c:102!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 8 UID: 0 PID: 2422 Comm: cp Not tainted 6.18.0-rc1-ktest-00035-gb944=
88503277 #169 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:assfail+0x3c/0x46
> Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 e8 e=
4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0b 5d=
 c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
> RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
> RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
> RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
> RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
> R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
> R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
> FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  xfs_reflink_remap_blocks+0x259/0x450
>  xfs_file_remap_range+0xe9/0x3d0
>  vfs_clone_file_range+0xde/0x460
>  ioctl_file_clone+0x50/0xc0
>  __x64_sys_ioctl+0x619/0x9d0
>  ? do_sys_openat2+0x99/0xd0
>  x64_sys_call+0xed0/0x1da0
>  do_syscall_64+0x6a/0x2e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fc4cd34d37b
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 4=
4 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0=
 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:00007ffeb4734050 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc4cd34d37b
> RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> RBP: 00007ffeb4734490 R08: 00007ffeb4734660 R09: 0000000000000002
> R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000008000 R15: 0000000000000002
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:assfail+0x3c/0x46
> Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 e8 e=
4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0b 5d=
 c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
> RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
> RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
> RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
> RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
> R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
> R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
> FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception ]---
>

First off, it's becoming clear to me that I didn't test this patchset
adequately enough. I had run xfstests on fuse but didn't run it on
XFS. My apologies for that, I should have done that and caught these
bugs myself, and will certainly do so next time.

For this test failure, it's because the change from u64 to loff_t is
overflowing loff_t on xfs. The failure is coming from this line change
in particular:

-static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_sta=
rt,
- u64 range_end)
+static unsigned iomap_find_dirty_range(struct folio *folio, loff_t
*range_start,
+ loff_t range_end)

which is called when writing back the folio (in iomap_writeback_folio()).

I added some printks and it's overflowing because we are trying to
write back a 4096-byte folio starting at position 9223372036854771712
(2^63 - 4096) in the file which results in an overflowed end_pos of
9223372036854775808 (2^63) when calculating folio_pos + folio_size.

I'm assuming XFS uses these large folio positions as a sentinel/marker
and that it's not actually a folio at position 9223372036854771712,
but either way, this patch doesn't seem viable with how XFS currently
works and I think it needs to get dropped.

I'm going to run the rest of the xfstests suite on XFS for this
patchset series to verify there are no other issues.

Thanks,
Joanne

