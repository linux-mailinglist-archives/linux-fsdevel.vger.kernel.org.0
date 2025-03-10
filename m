Return-Path: <linux-fsdevel+bounces-43671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EFCA5A670
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 22:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3295F172718
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871871E503D;
	Mon, 10 Mar 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Si6ncgHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926001D514E;
	Mon, 10 Mar 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643378; cv=none; b=Cx32Op6jm8hRbcQ8i7w4DLkD9BVKGqVVQW6QPFPkuY/zQkYwZ3+OxPmLbUowlenXRd0T5bLKYo/kM4hR2in7MfJn/eYwi8zEBb4GaX0Z0eXkShdafEfyOQtAdPNwZg1w2jkU3BuwxSZ7PBNtEU0LhroLh8Po901+8wim0It9h/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643378; c=relaxed/simple;
	bh=G7HqDO37lUXULG2y+fNmLelOaxDfYSlHZcqZR5aYrCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gG6eTyiqFk3yeHBg2P20s/KCPd+eK1CGhbvTtLuee1h8KCYumzpWV0DAxJbH/qZO9ea5/nJWzRupfEzZu/1dtQUTCnxkbMk6zvdCoiME1UjM7USWvPrEOcRDkeRqKBTIEPcpH0UR7wchre76I/PiLnJuWk36EyXJ2SUwU4rU+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Si6ncgHZ; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1741643374;
	bh=G7HqDO37lUXULG2y+fNmLelOaxDfYSlHZcqZR5aYrCI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Si6ncgHZ4LmdrVk6QKXruIeQ6BmBSXSopF5FVMD0QhIGd3N0yPRLOGKcQ3Ahds4qz
	 3p2lSfOBrbGWKEF/nFHzBXkXRR1XJSGkzm/XpNX8/+FNwYu7BgYA/UXB9YDCtcUR+M
	 W4W2WIAFIV9TtsCEa3rDkKADaVzP8u8j3IZwDR8w=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 071C61C00E9;
	Mon, 10 Mar 2025 17:49:33 -0400 (EDT)
Message-ID: <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
Subject: Re: apparmor NULL pointer dereference on resume [efivarfs]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ryan Lee <ryan.lee@canonical.com>, Malte =?ISO-8859-1?Q?Schr=F6der?=
	 <malte.schroeder@tnxip.de>
Cc: linux-security-module@vger.kernel.org, apparmor
 <apparmor@lists.ubuntu.com>,  linux-efi@vger.kernel.org, John Johansen
 <john.johansen@canonical.com>,  "jk@ozlabs.org" <jk@ozlabs.org>,
 ardb@kernel.org, linux-fsdevel@vger.kernel.org
Date: Mon, 10 Mar 2025 17:49:33 -0400
In-Reply-To: <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
References: <e54e6a2f-1178-4980-b771-4d9bafc2aa47@tnxip.de>
	 <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
	 <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de>
	 <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 12:57 -0700, Ryan Lee wrote:
> On Wed, Mar 5, 2025 at 1:47=E2=80=AFPM Malte Schr=C3=B6der
> <malte.schroeder@tnxip.de> wrote:
> >=20
> > On 05/03/2025 20:22, Ryan Lee wrote:
> > > On Wed, Mar 5, 2025 at 11:11=E2=80=AFAM Malte Schr=C3=B6der
> > > <malte.schroeder@tnxip.de> wrote:
> > > > Hi,
> > > >=20
> > > > I hope this is the right place to report this. Since 6.14-rc1
> > > > ff. resume
> > > > from hibernate does not work anymore. Now I finally managed to
> > > > get dmesg
> > > > from when this happens (Console is frozen, but managed to login
> > > > via
> > > > network). If I read that trace correctly there seems to be some
> > > > interaction with apparmor. I retried with apparmor disabled and
> > > > the
> > > > issue didn't trigger.
> > > Also CC'ing the AppArmor-specific mailing list in this reply.
> > >=20
> > > > I am happy to provide more data if required.
> > > Could you try to reproduce this NULL pointer dereference with a
> > > clean
> > > kernel with debug info (that I'd be able to access the source
> > > code of)
> > > and send a symbolized stacktrace processed with
> > > scripts/decode_stacktrace.sh?
> >=20
> > Sure. Result using plain v6.14-rc5:
> >=20
> > [=C2=A0 142.014428] BUG: kernel NULL pointer dereference, address:
> > 0000000000000018
> > [=C2=A0 142.014429] #PF: supervisor read access in kernel mode
> > [=C2=A0 142.014431] #PF: error_code(0x0000) - not-present page
> > [=C2=A0 142.014432] PGD 0 P4D 0
> > [=C2=A0 142.014433] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [=C2=A0 142.014436] CPU: 4 UID: 0 PID: 6833 Comm: systemd-sleep Not
> > tainted
> > 6.14.0-rc5 #1
> > [=C2=A0 142.014437] Hardware name: To Be Filled By O.E.M. X570
> > Extreme4/X570
> > Extreme4, BIOS P5.60 01/18/2024
> > [=C2=A0 142.014439] RIP: 0010:apparmor_file_open
> > (./include/linux/mount.h:78
> > (discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
> > security/apparmor/lsm.c:483 (discriminator 2))
> > [ 142.014442] Code: c5 00 08 00 00 0f 85 4b 01 00 00 4c 89 e9 31 c0
> > f6
> > c1 02 0f 85 fd 00 00 00 48 8b 87 88 00 00 00 4c 8d b7 88 00 00 00
> > 48 89
> > fd <48> 8b 40 18 48 8b 4f 70 0f b7 11 48 89 c7 66 89 54 24 04 48 8b
> > 51
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 c5 00 08=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (bad)
> > =C2=A0=C2=A0 3:=C2=A0=C2=A0=C2=A0 00 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 add=C2=A0=C2=A0=C2=A0 %al,(%rax)
> > =C2=A0=C2=A0 5:=C2=A0=C2=A0=C2=A0 0f 85 4b 01 00 00=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 jne=C2=A0=C2=A0=C2=A0 0x156
> > =C2=A0=C2=A0 b:=C2=A0=C2=A0=C2=A0 4c 89 e9=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=
=C2=A0=C2=A0=C2=A0 %r13,%rcx
> > =C2=A0=C2=A0 e:=C2=A0=C2=A0=C2=A0 31 c0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %eax,%eax
> > =C2=A0 10:=C2=A0=C2=A0=C2=A0 f6 c1 02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test=C2=A0=
=C2=A0 $0x2,%cl
> > =C2=A0 13:=C2=A0=C2=A0=C2=A0 0f 85 fd 00 00 00=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 jne=C2=A0=C2=A0=C2=A0 0x116
> > =C2=A0 19:=C2=A0=C2=A0=C2=A0 48 8b 87 88 00 00 00=C2=A0=C2=A0=C2=A0=C2=
=A0 mov=C2=A0=C2=A0=C2=A0 0x88(%rdi),%rax
> > =C2=A0 20:=C2=A0=C2=A0=C2=A0 4c 8d b7 88 00 00 00=C2=A0=C2=A0=C2=A0=C2=
=A0 lea=C2=A0=C2=A0=C2=A0 0x88(%rdi),%r14
> > =C2=A0 27:=C2=A0=C2=A0=C2=A0 48 89 fd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=
=C2=A0=C2=A0 %rdi,%rbp
> > =C2=A0 2a:*=C2=A0=C2=A0=C2=A0 48 8b 40 18=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x18=
(%rax),%rax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <-
> > -
> > trapping instruction
> > =C2=A0 2e:=C2=A0=C2=A0=C2=A0 48 8b 4f 70=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x70=
(%rdi),%rcx
> > =C2=A0 32:=C2=A0=C2=A0=C2=A0 0f b7 11=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 movzwl (%rc=
x),%edx
> > =C2=A0 35:=C2=A0=C2=A0=C2=A0 48 89 c7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=
=C2=A0=C2=A0 %rax,%rdi
> > =C2=A0 38:=C2=A0=C2=A0=C2=A0 66 89 54 24 04=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %dx,0x4(%rsp)
> > =C2=A0 3d:=C2=A0=C2=A0=C2=A0 48=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rex.W
> > =C2=A0 3e:=C2=A0=C2=A0=C2=A0 8b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .byte 0x8b
> > =C2=A0 3f:=C2=A0=C2=A0=C2=A0 51=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 push=C2=A0=C2=A0 %rcx
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 48 8b 40 18=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=
=A0 0x18(%rax),%rax
> > =C2=A0=C2=A0 4:=C2=A0=C2=A0=C2=A0 48 8b 4f 70=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=
=A0 0x70(%rdi),%rcx
> > =C2=A0=C2=A0 8:=C2=A0=C2=A0=C2=A0 0f b7 11=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 movzw=
l (%rcx),%edx
> > =C2=A0=C2=A0 b:=C2=A0=C2=A0=C2=A0 48 89 c7=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=
=C2=A0=C2=A0=C2=A0 %rax,%rdi
> > =C2=A0=C2=A0 e:=C2=A0=C2=A0=C2=A0 66 89 54 24 04=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %dx,0x4(%rsp)
> > =C2=A0 13:=C2=A0=C2=A0=C2=A0 48=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rex.W
> > =C2=A0 14:=C2=A0=C2=A0=C2=A0 8b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .byte 0x8b
> > =C2=A0 15:=C2=A0=C2=A0=C2=A0 51=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 push=C2=A0=C2=A0 %rcx
> > [=C2=A0 142.014443] RSP: 0018:ffffb9ef7189bc50 EFLAGS: 00010246
> > [=C2=A0 142.014445] RAX: 0000000000000000 RBX: ffff95eb5e555b00 RCX:
> > 0000000000000300
> > [=C2=A0 142.014446] RDX: ffff95f838227538 RSI: 00000000002ba677 RDI:
> > ffff95e992be2a00
> > [=C2=A0 142.014447] RBP: ffff95e992be2a00 R08: ffff95f838227520 R09:
> > 0000000000000002
> > [=C2=A0 142.014447] R10: ffff95ea72241d00 R11: 0000000000000001 R12:
> > 0000000000000010
> > [=C2=A0 142.014448] R13: 0000000000000300 R14: ffff95e992be2a88 R15:
> > ffff95e95a6034e0
> > [=C2=A0 142.014449] FS:=C2=A0 00007f74ab6cf880(0000)
> > GS:ffff95f838200000(0000)
> > knlGS:0000000000000000
> > [=C2=A0 142.014450] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > [=C2=A0 142.014451] CR2: 0000000000000018 CR3: 00000002473b6000 CR4:
> > 0000000000f50ef0
> > [=C2=A0 142.014452] PKRU: 55555554
> > [=C2=A0 142.014453] Call Trace:
> > [=C2=A0 142.014454]=C2=A0 <TASK>
> > [=C2=A0 142.014456] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > [=C2=A0 142.014459] ? page_fault_oops (arch/x86/mm/fault.c:710)
> > [=C2=A0 142.014460] ? __lock_acquire (kernel/locking/lockdep.c:?
> > kernel/locking/lockdep.c:5174)
> > [=C2=A0 142.014462] ? local_lock_acquire
> > (./include/linux/local_lock_internal.h:29 (discriminator 1))
> > [=C2=A0 142.014465] ? do_user_addr_fault (arch/x86/mm/fault.c:?)
> > [=C2=A0 142.014467] ? exc_page_fault
> > (./arch/x86/include/asm/irqflags.h:37
> > ./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488
> > arch/x86/mm/fault.c:1538)
> > [=C2=A0 142.014468] ? asm_exc_page_fault
> > (./arch/x86/include/asm/idtentry.h:623)
> > [=C2=A0 142.014471] ? apparmor_file_open (./include/linux/mount.h:78
> > (discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
> > security/apparmor/lsm.c:483 (discriminator 2))
> > [=C2=A0 142.014472] security_file_open (security/security.c:?)
> > [=C2=A0 142.014474] do_dentry_open (fs/open.c:934)
> > [=C2=A0 142.014476] kernel_file_open (fs/open.c:1201)
> > [=C2=A0 142.014477] efivarfs_pm_notify (fs/efivarfs/super.c:505)
>=20
> I traced the NULL dereference down to efivarfs_pm_notify creating a
> struct path with a NULL .mnt pointer which is then passed into
> kernel_file_open, which then invokes the LSM file_open security hook,
> where AppArmor is not expecting a path that has a NULL .mnt pointer.
> The code in question was introduced in b5d1e6ee761a (efivarfs: add
> variable resync after hibernation).
>=20
> I have sent in a patch to the AppArmor mailing list at
> https://lists.ubuntu.com/archives/apparmor/2025-March/013545.html
> which should give improved diagnostics for this case happening again.
> My understanding is that path .mnt pointers generally should not be
> NULL, but I do not know what an appropriate (non-NULL) value for that
> pointer should be, as I am not familiar with the efivarfs subsystem.

The problem comes down to the superblock functions not being able to
get the struct vfsmount for the superblock (because it isn't even
allocated until after they've all been called).  The assumption I was
operating under was that provided I added O_NOATIME to prevent the
parent directory being updated, passing in a NULL mnt for the purposes
of iterating the directory dentry was safe.  What apparmour is trying
to do is look up the idmap for the mount point to do one of its checks.

There are two ways of fixing this that I can think of.  One would be
exporting a function that lets me dig the vfsmount out of s_mounts and
use that (it's well hidden in the internals of fs/mount.h, so I suspect
this might not be very acceptable) or to get mnt_idmap to return
&nop_mnt_idmap if the passed in mnt is NULL.  I'd lean towards the
latter, but I'm cc'ing fsdevel to see what others think.

Regards,

James


