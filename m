Return-Path: <linux-fsdevel+bounces-49935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5978AC5C6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D3217BC07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F92139D8;
	Tue, 27 May 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="uo+1sIR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FA1FB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382575; cv=none; b=D0k7J4eDWDf5HdckAcEpUh+DEuSnu+TfQqgQjcVaKcFcJ7dbWtwe2gGc9HCy/LAF6whJOSSVQ3EwNoke90nA1UNBuits7338i5LN7bCVCftQ/LxxwjCgZFUSNx8gTI6X3od5ZkARQcuZh4qhaW5hey71pytrOkq8nJPSL6Q6Z9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382575; c=relaxed/simple;
	bh=HfPftjVcgI42dalYCg1FEsml86xfHZjOH0et0lZpTfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JhfwyOlsGhxITR84fDmMnEFhdZNb+kJtMXhP8oZ4sCgRdfr+ZcwsYHKLTECsk9a1J1KGpaAxv5uTRBgKd2+K/JRRG92zMZBdTj+ATor0VdEeo7MiNlWgSybw/M7jahl2xMOwULgUbAKtgOMxDREHLuNE4z6p0PmZkUwfqH0u9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=uo+1sIR7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-231e8553248so29802735ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1748382572; x=1748987372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfPftjVcgI42dalYCg1FEsml86xfHZjOH0et0lZpTfA=;
        b=uo+1sIR7rpy8JR/eYpfCJljCCAxjooygTjp2wPiY0lzPipWc+D1Rghrxb6FGqtvOqO
         KVmgyAB60aHI47NXttFkF3+VPQpbNH3yO6NXoDIAnoBx197zfvGIcf8fjvn70GTHzMuy
         v5PXjlp3QiK0Qd/MW6BZ9qXpybwZZVnroyHCsScWADH4D2xUOCdYUrW5A69+EIVSoSB7
         77Bc6QKhnLsZfG10anFfyUtg1r7c92oZ3XIN3Pu3wLp9nmjNoQuzqpBy8NNJL/v4C4OP
         WH35ep9akTDSNkQSn1OYkKYkXlvKaVl+bIOeU9YE8CuROQlZcZ4nX90zyV3dyXFGfrSA
         qcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382572; x=1748987372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfPftjVcgI42dalYCg1FEsml86xfHZjOH0et0lZpTfA=;
        b=XOVID9simMJn92rI2qhlaqZlc4WtSirbkz8iiT3vpGP+Bx5l0z6l/ioks5gCFBO7ls
         nj68D2jnix9MCz+FtKMzaokRbfSYP7YfnMUboUlz+3bLpK309SF4BUNhoAkruBZdU2UJ
         D35AEQ5bsgtFhSy5VhNBIZOtmigc8Y5HnqTRBrZVhZqX/b7V+SOHfHqkwqEBK0N4pJY/
         LIt9O1T704EPn4IJEOmBMk2BpAVtFs0IQxaJsxh0yhw/1836jLxH7reFewyYbt+PWvOL
         NxDNofAAmLFF6prYVisqgmD42IIFViDr5Zq4Rgrc/6cmOjBqgzrHVFDU6YQPxefkmNhb
         ADJQ==
X-Gm-Message-State: AOJu0YyyR0E95ZvgDMkMReQMXVfY3bmCaSwvbjzxA1mX2Fw7ZBh30TPJ
	aLr4vq7bGmquH9udBo2/freWjn37kHeoqorf+fC4YsrvAWpK300ytUQGgYwceATgQGo=
X-Gm-Gg: ASbGncu3YpTJ3lOrPn+68mIYcSOdDnuKLLvQl7nb4flcmrIrbjScdLBtzwyqGalmoDC
	DmGfK3YANc8sL1f2+nrPtwLyYwvKB7YP43mUOkrzXQOuEJsMFFUiRlUkhom1/ERZMiuYRxMKbx5
	UfSaT9q+i+JPRzxVInQPEKsRIfu9ayftw1szNL7UrmWYovSfc4SrCory8dEkbT0fn3Q/+qOWu7n
	pKHM5AAqGt3DlyzEemP7e6w8PRkgfUynC3p7vYq3g0tRWeqCdV5YOgaUAQlvqIIOjDqXbUc6rPp
	keRoknXsuurALK6JFj0AUWTyPRAVlYAiO77XbGQWyfNusPr3ZhbpCisA+UKH+3GKNGgeKktAsrd
	tmp7gHvjYPgbQu2WBplW3ZT4=
X-Google-Smtp-Source: AGHT+IEI57uhxgiCsGn/cvwidX55zKyJNXlN3YwwHOsfL874zvLVP+ews9urZpq8pgsnQu36X5v3nQ==
X-Received: by 2002:a17:902:da8b:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-234c8f61f13mr5853135ad.52.1748382572139;
        Tue, 27 May 2025 14:49:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:dc04:52d5:a995:1c97? ([2600:1700:6476:1430:dc04:52d5:a995:1c97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc24e8e6sm529285ad.217.2025.05.27.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:49:31 -0700 (PDT)
Message-ID: <13f85ee0265f7a41ef99f151c9a4185f9d9ab0a0.camel@dubeyko.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= [PATCH] hfsplus: remove
 mutex_lock check in hfsplus_free_extents
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?=E6=9D=8E=E6=89=AC=E9=9F=AC?= <frank.li@vivo.com>, 
 "glaubitz@physik.fu-berlin.de"	 <glaubitz@physik.fu-berlin.de>, Andrew
 Morton <akpm@linux-foundation.org>,  "Ernesto A."
 =?ISO-8859-1?Q?Fern=E1ndez?=	 <ernesto.mnd.fernandez@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, 
 "syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"
	 <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>, 
	Slava.Dubeyko@ibm.com
Date: Tue, 27 May 2025 14:49:30 -0700
In-Reply-To: <SEZPR06MB5269FA31FE21CD9799DA17ABE89AA@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250511110856.543944-1-frank.li@vivo.com>
	 <58e07322349210ea1c7bf0a23278087724e95dfd.camel@dubeyko.com>
	 <SEZPR06MB5269FA31FE21CD9799DA17ABE89AA@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-05-25 at 15:03 +0000, =E6=9D=8E=E6=89=AC=E9=9F=AC wrote:
> Hi Slava,
>=20
> > Which particular xfstests' test-case(s) triggers the issue? Do we
> > have the easy reproducing path of it? How can I check the fix,
> > finally?
>=20
> generic/013 triggers the issue. Here is the reproducing path.
>=20

Great! Could you please add generic/013 issues analysis in the patch
comment? I mean the dmesg output here.=20

> [Origin]
>=20
> We got fsck error, reason is the same as [1].
>=20
> [1]
> https://lore.kernel.org/all/20250430001211.1912533-1-slava@dubeyko.com/
>=20

Mentioning [1] could be confusing because it was HFS related fix. But
we are discussion HFS+ here.

> root@ubuntu:/home/ubuntu/xfstests-dev# ./check generic/013
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfsplus
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 ubuntu 6.15.0-rc4-=
00055-g71bfd66b8583-
> dirty #421 SMP PREEMPT_DYNAMIC Fri May 23 18:30:10 CST 2025
> MKFS_OPTIONS=C2=A0 -- /dev/nvme1n1
> MOUNT_OPTIONS -- /dev/nvme1n1 /mnt/scratch
>=20
> generic/013 35s ... [=C2=A0 380.286618] hfsplus: xattr exists yet
> [=C2=A0 382.410297] hfsplus: xattr exists yet
> [=C2=A0 383.872844] hfsplus: cannot replace xattr
> [=C2=A0 385.802529] hfsplus: cannot replace xattr
> [=C2=A0 393.125897] hfsplus: xattr exists yet
> [=C2=A0 396.222921] hfsplus: cannot replace xattr
> [=C2=A0 399.084012] hfsplus: cannot replace xattr
> [=C2=A0 403.233816] hfsplus: cannot replace xattr
> _check_generic_filesystem: filesystem on /dev/nvme0n1 is inconsistent
> (see /home/ubuntu/xfstests-dev/results//generic/013.full for details)
> _check_dmesg: something found in dmesg (see /home/ubuntu/xfstests-
> dev/results//generic/013.dmesg)
>=20
> Ran: generic/013
> Failures: generic/013
> Failed 1 of 1 tests
>=20
> [w/ bnode patch]
>=20
> The fsck error is related to the node not being cleared, which may be
> related to the implementation of the fsck tool.=20
> We can continue to discuss this in the previous email. For this, we
> can ignore it and continue the analysis based on the bnode patch.

Let's discuss this issue in independent thread. I assume you would like
to share the patch with the fix. Do you mean that
hfs_bnode_need_zeroout() works not completely correct? Because, I had
impression that HFS+ makes clearing of deleted nodes.

>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 079ea80534f7..f2424acd3636 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -633,7 +633,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (test_bit(HFS_BNODE_DELETED, &node->flags)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_bnod=
e_unhash(node);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unl=
ock(&tree->hash_lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hfs_bnode_=
need_zeroout(tree))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hfs_bnode_need_zeroout(tr=
ee))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_bnode_clear(node, 0, tree-
> >node_size);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_bmap=
_free(node);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_bnod=
e_free(node);
>=20
> After apply bnode patch. We got error from dmesg, which warn at
> fs/hfsplus/extents.c:346.
>=20
> root@ubuntu:/home/ubuntu/xfstests-dev# ./check generic/013
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfsplus
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 ubuntu 6.15.0-rc4-=
00055-g71bfd66b8583-
> dirty #422 SMP PREEMPT_DYNAMIC Sun May 25 22:37:55 CST 2025
> MKFS_OPTIONS=C2=A0 -- /dev/nvme1n1
> MOUNT_OPTIONS -- /dev/nvme1n1 /mnt/scratch
>=20
> generic/013 35s ... [=C2=A0 236.356697] hfsplus: xattr exists yet
> [=C2=A0 238.288269] hfsplus: xattr exists yet
> [=C2=A0 240.673488] hfsplus: cannot replace xattr
> [=C2=A0 242.133163] hfsplus: xattr exists yet
> [=C2=A0 242.172538] hfsplus: xattr exists yet
> [=C2=A0 243.702797] hfsplus: xattr exists yet
> [=C2=A0 245.943067] hfsplus: xattr exists yet
> [=C2=A0 249.502186] hfsplus: cannot replace xattr
> [=C2=A0 252.544517] hfsplus: xattr exists yet
> [=C2=A0 253.538462] hfsplus: cannot replace xattr
> [=C2=A0 263.456784] hfsplus: cannot replace xattr
> _check_dmesg: something found in dmesg (see /home/ubuntu/xfstests-
> dev/results//generic/013.dmesg)
>=20
> Ran: generic/013
> Failures: generic/013
> Failed 1 of 1 tests
>=20
> # demsg
> [=C2=A0 225.975852] run fstests generic/013 at 2025-05-25 14:42:11
> [=C2=A0 231.718234] ------------[ cut here ]------------
> [=C2=A0 231.718677] WARNING: CPU: 3 PID: 1091 at fs/hfsplus/extents.c:346
> hfsplus_free_extents+0xfc/0x110
> [=C2=A0 231.719117] Modules linked in:
> [=C2=A0 231.719895] CPU: 3 UID: 0 PID: 1091 Comm: fsstress Not tainted
> 6.15.0-rc4-00055-g71bfd66b8583-dirty #422 PREEMPT(voluntary)
> [=C2=A0 231.719996] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
,
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [=C2=A0 231.720170] RIP: 0010:hfsplus_free_extents+0xfc/0x110
> [=C2=A0 231.720383] Code: 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 c7 c7
> 4d 62 46 b2 e8 b5 58 cf ff eb 95 48 c7 c7 4d 62 46 b2 e8 a7 58 cf ff
> eb cd 90 <0f> 0b 90 e9 30 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 90 90 90
> [=C2=A0 231.720492] RSP: 0018:ffffaaa9813bbd28 EFLAGS: 00000202
> [=C2=A0 231.720563] RAX: ffff995582666701 RBX: 00000000000000ed RCX:
> 00000000000001b5
> [=C2=A0 231.720592] RDX: 00000000000000ed RSI: ffff9955818e8ad8 RDI:
> ffff995588c80048
> [=C2=A0 231.720617] RBP: ffff9955818e8ad8 R08: 0000000000000002 R09:
> ffffaaa9813bbcda
> [=C2=A0 231.720641] R10: ffff995585cfdb90 R11: 0000000000000002 R12:
> 0000000000000000
> [=C2=A0 231.720672] R13: 00000000000001b5 R14: 00000000000000c8 R15:
> ffff995587f40800
> [=C2=A0 231.720778] FS:=C2=A0 00007f81e3bd8740(0000) GS:ffff99564ac46000(=
0000)
> knlGS:0000000000000000
> [=C2=A0 231.720813] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 231.720838] CR2: 00005634430a6108 CR3: 00000000147d5000 CR4:
> 00000000000006f0
> [=C2=A0 231.720960] Call Trace:
> [=C2=A0 231.721831]=C2=A0 <TASK>
> [=C2=A0 231.722111]=C2=A0 hfsplus_file_truncate+0x2b6/0x3e0
> [=C2=A0 231.722222]=C2=A0 hfsplus_delete_inode+0x54/0x70
> [=C2=A0 231.722325]=C2=A0 hfsplus_unlink+0x17f/0x1c0
> [=C2=A0 231.722384]=C2=A0 ? security_inode_permission+0x23/0x40
> [=C2=A0 231.722415]=C2=A0 vfs_unlink+0x110/0x2b0
> [=C2=A0 231.722442]=C2=A0 do_unlinkat+0x251/0x2c0
> [=C2=A0 231.722471]=C2=A0 __x64_sys_unlink+0x1c/0x30
> [=C2=A0 231.722491]=C2=A0 do_syscall_64+0x9e/0x190
> [=C2=A0 231.722551]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [=C2=A0 231.722726] RIP: 0033:0x7f81e3cf740b
> [=C2=A0 231.723023] Code: 30 ff ff ff e9 74 fd ff ff e8 a1 ba 01 00 90 f3
> 0f 1e fa b8 5f 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 57 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 d9 69 0e
> 00 f7 d8
> [=C2=A0 231.723047] RSP: 002b:00007ffe97ed66b8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000057
> [=C2=A0 231.723089] RAX: ffffffffffffffda RBX: 0000000000000035 RCX:
> 00007f81e3cf740b
> [=C2=A0 231.723104] RDX: 0000000000000000 RSI: 00007ffe97ed6690 RDI:
> 00005634430875c0
> [=C2=A0 231.723116] RBP: 00007ffe97ed6830 R08: 000000000000ffff R09:
> 0000000000000000
> [=C2=A0 231.723128] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007ffe97ed66d0
> [=C2=A0 231.723141] R13: 8f5c28f5c28f5c29 R14: 00007ffe97ed68a0 R15:
> 000056341fe3c7c0
> [=C2=A0 231.723219]=C2=A0 </TASK>
> [=C2=A0 231.723427] ---[ end trace 0000000000000000 ]---
> [=C2=A0 233.296305] ------------[ cut here ]------------
>=20
> [w/ bnode &this patch]
>=20
> Test pass without any error.
>=20
> root@ubuntu:/home/ubuntu/xfstests-dev# ./check generic/013
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfsplus
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 ubuntu 6.15.0-rc4-=
00055-g71bfd66b8583-
> dirty #423 SMP PREEMPT_DYNAMIC Sun May 25 22:54:51 CST 2025
> MKFS_OPTIONS=C2=A0 -- /dev/nvme1n1
> MOUNT_OPTIONS -- /dev/nvme1n1 /mnt/scratch
>=20
> generic/013 35s ... [=C2=A0 106.018643] hfsplus: xattr exists yet
> [=C2=A0 110.155138] hfsplus: cannot replace xattr
> [=C2=A0 112.061738] hfsplus: cannot replace xattr
> [=C2=A0 113.215120] hfsplus: cannot replace xattr
> [=C2=A0 118.308974] hfsplus: xattr exists yet
> [=C2=A0 133.279630] hfsplus: cannot replace xattr
> [=C2=A0 134.581764] hfsplus: cannot replace xattr
> [=C2=A0 135.557120] hfsplus: xattr exists yet
> =C2=A046s
> Ran: generic/013
> Passed all 1 tests
>=20
> > I don't think that I follow the point. The two mutexes are namely
> > the basis for potential deadlocks. Currently, I am not sure that we
> > are fixing the issue. Probably, we are trying to hide the symptoms
> > of the real issue without the clear understanding what is going
> > wrong. I would like to hear the explanation how the issue is
> > happening and why the warning removal can help here.
>=20
> I don't know if the above description is clear enough. Actually, this
> warning is not helpful at all.=20
> The comment above this warning also describes one of the easy
> triggering situations, which can easily trigger and cause
> xfstest&syzbot to report errors.
>=20

I see your point. We need accurately explain here that several threads
could try to lock the shared extents tree. And warning can be triggered
in one thread when another thread has locked the tree. This is the
wrong behavior of the code and we need to remove the warning.

Could you please rework the patch comment by means of adding precise
explanation of this? =20

> > I am not sure that it's the good idea to remove any warning
> > because, probably, we could not understand the real reason of the
> > issue and we simply trying to hind the symptoms of something more
> > serious.
> >=20
> > Current explanation doesn't sound reasonably well to me. I am not
> > convinced yet that it is proper fix and we see the reason of the
> > issue.
> > I would like to hear more clear justification that we have to
> > remove this check.
>=20
> If there is indeed an exception or you can point out the problem,
> then we should fix it. Otherwise, in my opinion, this warning has no
> purpose and should be removed.

We have a lot of problems in the code and good warnings make sense. The
intentions of this warning was to prevent wrong using of locks. But it
was missed that multiple threads can try to lock the shared extents
tree. So, yes, it makes sense to remove this particular warning but,
potentially, we still could have issues in the code. However, we need
to explain why this warning works in wrong way in really precise
manner. :)

Thanks,
Slava.


