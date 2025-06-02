Return-Path: <linux-fsdevel+bounces-50312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB92ACABDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB0E17B562
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D401E3DD6;
	Mon,  2 Jun 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LL4KOSte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA831E0E0B
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857689; cv=none; b=HwAPJwQQBWOEo718WlkM3mmU+aOfclkKDBNGuv3PVZoigbJVM8Z9d8kL/7KJZXnz9kyW1Dn3n10rzcIxoxMdz5jyPnFVKwy2edEAwUJLcsJSoV2iG8rkoW5PGIL/rqKBu/m8wQDQFH45Lu0oua8B8KliS8XZugVdV1C70W5CuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857689; c=relaxed/simple;
	bh=v/rV3m8ZRm4D5g8rC9X6s5kobrr12acOleagIIj2MNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uO9KBDQ7iUhzHEutnNl9gyktlAzSqyhKNWjZXbwpo3c6eeX1gM6gnLzKIt5ujYA/35m+LAF7Rv3vTno9z3OTln9E4fhUXVq8tQAaOmaAVSYgbZLO4V2X9bmIIhk5bu9sEoGTfCRowxUAX5RFLjBIVoMYgshGS0pM3LBvwpChbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LL4KOSte; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y6uR0/S9zE1PT1vRSZclObK2vETTJjphG0i/20n/AbU=; b=LL4KOStesa+m/EvSswuMy9wypS
	GsvB5yj6RK67BrlYHn+pXS8QjyjrXEPXjn9nqENh6/KrksH93TdqzqVY/bIloLVSNCdrNPideQ5P0
	Hh63Lw7RJMgez2fjQf7ZKB/a3x04PiTPpZ3zuRCsocvbaahqyeT3EVUTrop1z2AIPtoGsO2P2r8Ez
	WafgyF7ufybFbtbc69Z6h8wtwxzXBfcIyxQhkZJrVSmEmirvbMAp+28mDngjLBo6qtb+bdp8FUwe0
	18+npfnnr4o2nOlVSVSw0Xx2dp2ytYBylYx3SzMQI103rTqEZc20eXXcBJhMLXxcTFjb2e0ym2Lsa
	LuoAxHbg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uM1ly-00GEJk-4m; Mon, 02 Jun 2025 11:48:02 +0200
From: Luis Henriques <luis@igalia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  Jeff Layton <jlayton@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Alexander Viro <viro@zeniv.linux.org.uk>,  Amir
 Goldstein <amir73il@gmail.com>,  Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
In-Reply-To: <20250207-daten-mahlzeit-99d2079864fb@brauner> (Christian
	Brauner's message of "Fri, 7 Feb 2025 15:10:33 +0100")
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
Date: Mon, 02 Jun 2025 10:47:56 +0100
Message-ID: <87msaqcw4z.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Feb 07 2025, Christian Brauner wrote:

> Before 2011 there was no meaningful synchronization between
> read/readdir/write/seek. Only in commit
> ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> synchronization was added for SEEK_CUR by taking f_lock around
> vfs_setpos().
>
> Then in 2014 full synchronization between read/readdir/write/seek was
> added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> for directories. At that point taking f_lock became unnecessary for such
> files.
>
> So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> acquired f_pos_lock if necessary.

I'm seeing the splat below with current master.  It's unlikely to be
related with this patch, but with recent overlayfs changes.  I'm just
dropping it here before looking, as maybe it has already been reported.

Cheers,
--=20
Lu=C3=ADs

[  133.133745] ------------[ cut here ]------------
[  133.133855] WARNING: CPU: 6 PID: 246 at fs/file.c:1201 file_seek_cur_nee=
ds_f_lock+0x4a/0x60
[  133.133940] Modules linked in: virtiofs fuse
[  133.134009] CPU: 6 UID: 1000 PID: 246 Comm: ld Not tainted 6.15.0+ #124 =
PREEMPT(full)=20
[  133.134110] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  133.134235] RIP: 0010:file_seek_cur_needs_f_lock+0x4a/0x60
[  133.134286] Code: 00 48 ba fe ff ff ff ff ff ff bf 48 83 e8 01 48 39 c2 =
73 06 b8 01 00 00 00 c3 48 81 c7 90 00 00 00 e8 da 0e db ff 84 c0 75 ea <0f=
> 0b b8 01 00 00 00 c3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00
[  133.134471] RSP: 0018:ffffc90000e67ea0 EFLAGS: 00010246
[  133.134526] RAX: 0000000000000000 RBX: fffffffffffffc01 RCX: 7ffffffffff=
fffff
[  133.134683] RDX: bffffffffffffffe RSI: fffffffffffffc01 RDI: ffff888101b=
d1e90
[  133.135430] RBP: ffff888101bd1e00 R08: 00000000002a3988 R09: 00000000000=
00000
[  133.136172] R10: ffffc90000e67ed0 R11: 0000000000000000 R12: 7ffffffffff=
fffff
[  133.136351] R13: ffff888101bd1e00 R14: ffff888105d823c0 R15: 00000000000=
00001
[  133.136433] FS:  00007fd7880d2b28(0000) GS:ffff8884ad411000(0000) knlGS:=
0000000000000000
[  133.136516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.136586] CR2: 0000559b3af3a520 CR3: 0000000103cb1000 CR4: 00000000007=
50eb0
[  133.136667] PKRU: 55555554
[  133.136694] Call Trace:
[  133.136720]  <TASK>
[  133.136747]  generic_file_llseek_size+0x93/0x120
[  133.136802]  ovl_llseek+0x86/0xf0
[  133.136844]  ksys_lseek+0x39/0x90
[  133.136884]  do_syscall_64+0x73/0x2c0
[  133.136932]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  133.136994] RIP: 0033:0x7fd788098262
[  133.137034] Code: 48 63 d2 48 63 ff 4d 63 c0 b8 09 01 00 00 0f 05 48 89 =
c7 e8 8a 80 fd ff 48 83 c4 08 c3 48 63 ff 48 63 d2 b8 08 00 00 00 0f 05 <48=
> 89 c7 e9 70 80 fd ff 8d 47 27 53 89 fb 83 f8 4e 76 27 b8 ec ff
[  133.137223] RSP: 002b:00007fffffaf82c8 EFLAGS: 00000283 ORIG_RAX: 000000=
0000000008
[  133.137302] RAX: ffffffffffffffda RBX: 00007fd787ba1010 RCX: 00007fd7880=
98262
[  133.137385] RDX: 0000000000000001 RSI: fffffffffffffc01 RDI: 00000000000=
0000f
[  133.137465] RBP: 0000000000000000 R08: 0000000000000064 R09: 00007fd787c=
3c6a0
[  133.137545] R10: 000000000000000e R11: 0000000000000283 R12: 00007fffffa=
fa694
[  133.137625] R13: 0000000000000039 R14: 0000000000000038 R15: 00007fffffa=
faa79
[  133.137708]  </TASK>
[  133.137736] irq event stamp: 1034649
[  133.137776] hardirqs last  enabled at (1034657): [<ffffffff8133c642>] __=
up_console_sem+0x52/0x60
[  133.137872] hardirqs last disabled at (1034664): [<ffffffff8133c627>] __=
up_console_sem+0x37/0x60
[  133.137966] softirqs last  enabled at (1012640): [<ffffffff812c4884>] ir=
q_exit_rcu+0x74/0x110
[  133.138064] softirqs last disabled at (1012633): [<ffffffff812c4884>] ir=
q_exit_rcu+0x74/0x110
[  133.138161] ---[ end trace 0000000000000000 ]---

