Return-Path: <linux-fsdevel+bounces-46503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D2A8A4C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADBC189DE83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6C29B798;
	Tue, 15 Apr 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="lj6B1/tS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B782260C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736328; cv=none; b=RlLYx8Zw14lFvFUeHzwxyFENazWMlk8y74XkzcARh2bHhT7AwvnxeZBk+dy/FPmYL6gJ7wNu5cecAvUuksRRwjFokca3R1jzwRJ8Z9D4T45TPryV6+WrjhoRqSWrOSeNQx1adc4cBpGpYTdzWcghbTh67ShLH0ofLsQG+17SwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736328; c=relaxed/simple;
	bh=PwOYin/M89oJCAmOFawBNjPUKiaJAkazAKO3lsCdr1A=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Ii9dAtNXRV/kDCxzmlkgd15iMnlNN7I3DKbE072Z+U8eHZP8eCL7BvOegs1Mbuf4y2VIXq4ycr7N5GWMn8kyXGcdrNcDUPkB962n5sd/hmetUx83FfnZj8Gn+v+kyI134TM/6g6F+5IGkXIGOKbfsoVJ+HH6DiyN/NY7oTeBeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=lj6B1/tS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so5141134a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1744736325; x=1745341125; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4N0GbCfLHO59eB1QCB5kpwpQjnRZnji86liGp99znY=;
        b=lj6B1/tSKzTZ1gAKJj9Rw+TImBIzeDTtJQkG2ZLw4rrUEbr/sZeFizRZYX0YKkJDEF
         MpKdDC+8WA+2dEiOcojS7ORwDsahiSwDc4TsDfDscwLZzVselJnCGhcThOwD+WSCQnAj
         nhsQpGQcPwJWOLGYrkkAdMBQX02SHep4ixvgGU4vef99W6UtWZlZ4cjDsS/IKQ2Hq/9E
         ufQAzyBkbYGDRJ5Mf7qZlSMbmAKUhoLusPwKl+8/umg6j9pNl7tc8OfobwJtR6QSErHt
         1KTobwPp1Yd291ZkthceQ36FV0ZyR/BnKFnhZ0BAYnLsZarRUA75qc8eTlELRPfntfOZ
         Hmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744736325; x=1745341125;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4N0GbCfLHO59eB1QCB5kpwpQjnRZnji86liGp99znY=;
        b=HVio6Gu7CZNsUSOAsLWqDOG7xvQfUzVYtJVa4akGcnDs8E7+/12lTiREXIe9UTpj8H
         M29tz+oy7RRYtFePVWQ16tchky/eeOUQzTRE0SNmgZ8I/R68uGA6kBHU9cfc9v3otehR
         ssN7RT91p/byoIo7PDjXJeNvQKKXaSuIl48tgonY8WUOAB7dVzkZmM71bb4weHB7Hk58
         qLQgLC+LZJwoUSTl0JYdBiE6Oow6XbgMDH/1hTIhEEoDiIUPOX/fBgH3hZ2rYhYK3qnl
         KHkYcPPESIpFuMXoX5EuM6LCdXI0/me0H6ppb1rwMbtbH4AV19+Jbqh7N4Xs/NXOehpI
         ieNw==
X-Forwarded-Encrypted: i=1; AJvYcCUSpSGr4eqW4jlfGyjJ0QVldidDWnAs9935rHF7saI8FY+BNadI18uDVql5fNUsglloo7N3IVgfFRIjHAxg@vger.kernel.org
X-Gm-Message-State: AOJu0YxqN8vhMnqidhpp2khQXGYxY7mD+GJ+ylvKtZMm6rsq1T1XCL1E
	T4nt+XF3Q22ox82JOgJA6rghUh0UOKSsxbYj1z5j5Q7B5Fbtef2MeAuFHSJVI7g=
X-Gm-Gg: ASbGncvG83ozvi/jIWxTsD7b3P3MFm1jS0s44WVpHf2g1RRzuy8UDKzW2ghgvBmzaZ8
	JHiIeqOrWAAPkz5vEhXY38etHP7fUXmBoY8CarwaKvO4uQlyestDGY2z5IMp1RSTKWGZrXkbFtD
	52lPsTInY5HKfID4uoky/KidjnuXl68in12W49xFKhdrEg3SyG0sUkVrTceLc2XWnl6+aNEPd7X
	1MPzYpKUnA81cymYMhzsXa84sjAOGbUgO9lFUTaCfCPMuZXsiGBEIVX9jDgsC1y5Yx+r7B2Vnt2
	c+dbsbMJcNvC0dWmcHR8NT1FmzR9CMd8oJ5CJXW+blsKsyIvLW4FFPTonAPfRbmOnBR/O/jcL4P
	KnfAJvKx1vVpNog==
X-Google-Smtp-Source: AGHT+IHWLBcMK2aikj4+V5lXXYsh4Y7jhcTSssSkuGmWzzsbfiWGA8LrTh3jgyZvi0NTVXjpRbFkIw==
X-Received: by 2002:a17:90b:57e8:b0:2ee:ab29:1a63 with SMTP id 98e67ed59e1d1-30823624894mr22531834a91.3.1744736325209;
        Tue, 15 Apr 2025 09:58:45 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1717c3sm13575842a91.30.2025.04.15.09.58.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Apr 2025 09:58:44 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <B1333FB3-D44F-407F-AD02-A2A93BB1E53B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BCC47921-4CA5-490E-973D-1DCFA8BB70C3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: inline: fix len overflow in
 ext4_prepare_inline_data
Date: Tue, 15 Apr 2025 10:58:38 -0600
In-Reply-To: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Tao Ma <boyu.mt@taobao.com>,
 Jan Kara <jack@suse.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-dev@igalia.com,
 syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com,
 stable@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_BCC47921-4CA5-490E-973D-1DCFA8BB70C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 15, 2025, at 8:53 AM, Thadeu Lima de Souza Cascardo =
<cascardo@igalia.com> wrote:
>=20
> When running the following code on an ext4 filesystem with inline_data
> feature enabled, it will lead to the bug below.
>=20
>        fd =3D open("file1", O_RDWR | O_CREAT | O_TRUNC, 0666);
>        ftruncate(fd, 30);
>        pwrite(fd, "a", 1, (1UL << 40) + 5UL);
>=20
> That happens because write_begin will succeed as when
> ext4_generic_write_inline_data calls ext4_prepare_inline_data, pos + =
len
> will be truncated, leading to ext4_prepare_inline_data parameter to be =
6
> instead of 0x10000000006.
>=20
> Then, later when write_end is called, we hit:
>=20
>        BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
>=20
> at ext4_write_inline_data.
>=20
> Fix it by using a loff_t type for the len parameter in
> ext4_prepare_inline_data instead of an unsigned int.

Thanks for the patch. Looks good.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> [   44.545164] ------------[ cut here ]------------
> [   44.545530] kernel BUG at fs/ext4/inline.c:240!
> [   44.545834] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   44.546172] CPU: 3 UID: 0 PID: 343 Comm: test Not tainted =
6.15.0-rc2-00003-g9080916f4863 #45 PREEMPT(full)  =
112853fcebfdb93254270a7959841d2c6aa2c8bb
> [   44.546523] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   44.546523] RIP: 0010:ext4_write_inline_data+0xfe/0x100
> [   44.546523] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e =
41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc =
0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 =
49
> [   44.546523] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
> [   44.546523] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: =
0000010000000006
> [   44.546523] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: =
ffff9329c158e738
> [   44.546523] RBP: 0000000000000001 R08: 0000000000000001 R09: =
0000000000000000
> [   44.546523] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: =
0000006210000000
> [   44.546523] R13: fffffc7e4015e700 R14: 0000010000000005 R15: =
ffff9329c158e738
> [   44.546523] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) =
knlGS:0000000000000000
> [   44.546523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.546523] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: =
0000000000770eb0
> [   44.546523] PKRU: 55555554
> [   44.546523] Call Trace:
> [   44.546523]  <TASK>
> [   44.546523]  ext4_write_inline_data_end+0x126/0x2d0
> [   44.546523]  generic_perform_write+0x17e/0x270
> [   44.546523]  ext4_buffered_write_iter+0xc8/0x170
> [   44.546523]  vfs_write+0x2be/0x3e0
> [   44.546523]  __x64_sys_pwrite64+0x6d/0xc0
> [   44.546523]  do_syscall_64+0x6a/0xf0
> [   44.546523]  ? __wake_up+0x89/0xb0
> [   44.546523]  ? xas_find+0x72/0x1c0
> [   44.546523]  ? next_uptodate_folio+0x317/0x330
> [   44.546523]  ? set_pte_range+0x1a6/0x270
> [   44.546523]  ? filemap_map_pages+0x6ee/0x840
> [   44.546523]  ? ext4_setattr+0x2fa/0x750
> [   44.546523]  ? do_pte_missing+0x128/0xf70
> [   44.546523]  ? security_inode_post_setattr+0x3e/0xd0
> [   44.546523]  ? ___pte_offset_map+0x19/0x100
> [   44.546523]  ? handle_mm_fault+0x721/0xa10
> [   44.546523]  ? do_user_addr_fault+0x197/0x730
> [   44.546523]  ? do_syscall_64+0x76/0xf0
> [   44.546523]  ? arch_exit_to_user_mode_prepare+0x1e/0x60
> [   44.546523]  ? irqentry_exit_to_user_mode+0x79/0x90
> [   44.546523]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [   44.546523] RIP: 0033:0x7f42999c6687
> [   44.546523] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 =
00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 =
0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff =
ff
> [   44.546523] RSP: 002b:00007ffeae4a7930 EFLAGS: 00000202 ORIG_RAX: =
0000000000000012
> [   44.546523] RAX: ffffffffffffffda RBX: 00007f4299934740 RCX: =
00007f42999c6687
> [   44.546523] RDX: 0000000000000001 RSI: 000055ea6149200f RDI: =
0000000000000003
> [   44.546523] RBP: 00007ffeae4a79a0 R08: 0000000000000000 R09: =
0000000000000000
> [   44.546523] R10: 0000010000000005 R11: 0000000000000202 R12: =
0000000000000000
> [   44.546523] R13: 00007ffeae4a7ac8 R14: 00007f4299b86000 R15: =
000055ea61493dd8
> [   44.546523]  </TASK>
> [   44.546523] Modules linked in:
> [   44.568501] ---[ end trace 0000000000000000 ]---
> [   44.568889] RIP: 0010:ext4_write_inline_data+0xfe/0x100
> [   44.569328] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e =
41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc =
0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 =
49
> [   44.570931] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
> [   44.571356] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: =
0000010000000006
> [   44.571959] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: =
ffff9329c158e738
> [   44.572571] RBP: 0000000000000001 R08: 0000000000000001 R09: =
0000000000000000
> [   44.573148] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: =
0000006210000000
> [   44.573748] R13: fffffc7e4015e700 R14: 0000010000000005 R15: =
ffff9329c158e738
> [   44.574335] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) =
knlGS:0000000000000000
> [   44.575027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.575520] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: =
0000000000770eb0
> [   44.576112] PKRU: 55555554
> [   44.576338] Kernel panic - not syncing: Fatal exception
> [   44.576517] Kernel Offset: 0x1a600000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>=20
> Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfe2a25dae02a207717a0
> Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: stable@vger.kernel.org
> ---
> fs/ext4/inline.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index =
2c9b762925c72f2ff5a402b02500370bc1eb0eb1..e5e6bf0d338b965a885fb99581f9ed5e=
51c5257c 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -397,7 +397,7 @@ static int ext4_update_inline_data(handle_t =
*handle, struct inode *inode,
> }
>=20
> static int ext4_prepare_inline_data(handle_t *handle, struct inode =
*inode,
> -				    unsigned int len)
> +				    loff_t len)
> {
> 	int ret, size, no_expand;
> 	struct ext4_inode_info *ei =3D EXT4_I(inode);
>=20
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20250415-ext4-prepare-inline-overflow-8db0e747cb16
>=20
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>=20


Cheers, Andreas






--Apple-Mail=_BCC47921-4CA5-490E-973D-1DCFA8BB70C3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmf+kD4ACgkQcqXauRfM
H+BgTw/7BfgemHBt7vu6OuQBunmjB1Aa7t+RzuO4FDwCbFAPgpjlM6jbt2QH1a4w
xOhOnGI7EFBlk5eCM0UTHNKNUYgFzJsXcb+oeE3MsyxVqWNLpK2wbt7hvLs9B70L
PZxzAL41zfLVs26PrnEZqkqdGKw+70QkRcFTBr5r08bdoOL5W3BTcgbPa/MG/vPm
5CeTZS/zvtW/7k+tSCeEkngKi/1GwHCdGsKFMdODWbt79HYOvtHzs3CToWjBUp43
N8WcpIswAjaFFKdWipYOcispwCoVEIOf/wbp+M1B4G/HIfvkrPe7f9IXfRnggtbH
tCxjWjGANJciRjBbDcUXWBP+iKEO8Ktp+qhihNY5L+RrCAKNHW2aVJA9XtoXw6bk
ODErmXLSByTsrZJ4NUuIYbv0+aIwmdlvov94jYOu1snQK2Kkh2Gg+1RArO9LXxe9
czW5EFlGCFnpi7NVU2it2IQ1+roTnZPPOJG+mTFt/2Wynn9MH4zZihAAnerXvi16
fycpifTXKXggDdaw3D/XUAW7OwSJB4zLWWa9jFys+oZi4Kqy2Ov3TbvfI8zTTrjg
uc3UfOi0qdo67KvASOUuOLc9w4H/wEG+tR17/NfF5GJ+U71IPg5OB12VS5/ZWbCZ
rK0rSVuX+d7ERfQdY2jttJEbHnu0K724CmQYowq1CQtEIvA2Hu8=
=6gMn
-----END PGP SIGNATURE-----

--Apple-Mail=_BCC47921-4CA5-490E-973D-1DCFA8BB70C3--

