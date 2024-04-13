Return-Path: <linux-fsdevel+bounces-16863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7738A3D05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 16:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A945B215B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E962446BA;
	Sat, 13 Apr 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0b1WjH7d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGTnmWCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE51DDF1;
	Sat, 13 Apr 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713019406; cv=none; b=b1AV9WOjGDqAsyiSYqJeGWy6oEp4/Xb1Cu60d0mKGAUqWQb0A+CX7acdpDK9DJ9lQbVTpAgJ92B3+Q4t87IaQeP+oUfHJ1tGp+IUeLXSnP4yyK++f3mtHD207liJAstyepCDbMi07rex6Ibc1tR/bCdBbGrrckvEQAqUmtciwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713019406; c=relaxed/simple;
	bh=F3WSVlUVeB9L++bk4Ow6JCLg2bFHCz7po4reWSuVgdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTc/b6uf5MdDkKUZvH8GbWguY1+VDGvkckr4qN6tZ6aMS8g4Ll+fwkwpcgHVjGxyfWuQCI/EOtuCZ3yfT95ohE3f2cVD5wT+xmIMyrn3kp31VPU3UdvmjiLKZrvVohPYcYzeu0J/kn2rPZcUh69QTWseMpDrw2ZiSMDkmAt7v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0b1WjH7d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGTnmWCA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Apr 2024 16:43:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713019401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94QYgK1moV3EtlUcP69QNbkfRF65WDHcbcu3aXuhzMA=;
	b=0b1WjH7dMokMw4gA5sphaavop2jbUouwWon4BETiEJ3Auh4mkbDA6CaWbyUNg2HXh5x6sV
	ONFBFVjW0E764jN462mFwDfHi2QRFkYfyeIHxJcy3VbT1aBnTVP5C58iksUwVE6rUrLEKJ
	5MlqE2iqe6pljzIGKfUbctAoWA2M34tOOrMm3oVsdNYvuv4Pxq5J39z0MKV5uCYzKKqh3U
	80jVJeaID7Ii+A4CUhy9Q4fzgdYP/hww5l96idQt9myulM92AIR61c34rdO2vrrS2KQlcV
	/KP8sifRsZXoC18ILZxYH35jCImumZRAwqv918IPuYpQQPJGbQyHNSiefxQk3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713019401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94QYgK1moV3EtlUcP69QNbkfRF65WDHcbcu3aXuhzMA=;
	b=TGTnmWCAiCLkdCMHYZVFT8OBvD3zVHceh/mgLEaqFERDP2BwWHD5eEVTI9rdWYMR4gvfxq
	35B6dGXcXkTn8uDA==
From: Nam Cao <namcao@linutronix.de>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, "Theodore
 Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240413164318.7260c5ef@namcao>
In-Reply-To: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-12 Bj=C3=B6rn T=C3=B6pel wrote:
> Hi!
>=20
> I've been looking at an EXT4 splat on riscv32, that LKFT found [1]:
>=20
>   | EXT4-fs (vda): mounted filesystem 13697a42-d10e-4a9e-8e56-cb9083be92f=
9 ro with ordered data mode. Quota mode: disabled.
>   | VFS: Mounted root (ext4 filesystem) readonly on device 254:0.
>   | Unable to handle kernel NULL pointer dereference at virtual address 0=
0000006
>   | Oops [#1]
>   | Modules linked in:
>   | CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0 #41
>   | Hardware name: riscv-virtio,qemu (DT)
>   | epc : ext4_search_dir+0x52/0xe4
>   |  ra : __ext4_find_entry+0x1d6/0x578
>   | epc : c035b60e ra : c035b876 sp : c253fc10
>   |  gp : c21a7380 tp : c25c8000 t0 : 44c0657f
>   |  t1 : 0000000c t2 : 1de5b089 s0 : c253fc50
>   |  s1 : 00000000 a0 : fffffffc a1 : fffff000
>   |  a2 : 00000000 a3 : c29c04f8 a4 : c253fd00
>   |  a5 : 00000000 a6 : c253fcfc a7 : fffffff3
>   |  s2 : 00001000 s3 : 00000000 s4 : 00001000
>   |  s5 : c29c04f8 s6 : c292db40 s7 : c253fcfc
>   |  s8 : fffffff7 s9 : c253fd00 s10: fffff000
>   |  s11: c292db40 t3 : 00000007 t4 : 5e8b4525
>   |  t5 : 00000000 t6 : 00000000
>   | status: 00000120 badaddr: 00000006 cause: 0000000d
>   | [<c035b60e>] ext4_search_dir+0x52/0xe4
>   | [<c035b876>] __ext4_find_entry+0x1d6/0x578
>   | [<c035bcaa>] ext4_lookup+0x92/0x200
>   | [<c0295c14>] __lookup_slow+0x8e/0x142
>   | [<c029943a>] walk_component+0x104/0x174
>   | [<c0299f18>] path_lookupat+0x78/0x182
>   | [<c029b24c>] filename_lookup+0x96/0x158
>   | [<c029b346>] kern_path+0x38/0x56
>   | [<c0c1bee4>] init_mount+0x46/0x96
>   | [<c0c2ae1c>] devtmpfs_mount+0x44/0x7a
>   | [<c0c01c26>] prepare_namespace+0x226/0x27c
>   | [<c0c01130>] kernel_init_freeable+0x27e/0x2a0
>   | [<c0b78402>] kernel_init+0x2a/0x158
>   | [<c0b82bf2>] ret_from_fork+0xe/0x20
>   | Code: 84ae a809 d303 0044 949a 0f63 0603 991a fd63 0584 (c603) 0064=20
>   | ---[ end trace 0000000000000000 ]---
>   | Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000=
000b
>=20
> This was not present in 6.7. Bisection wasn't really helpful (to me at
> least); I got it down to commit c604110e662a ("Merge tag 'vfs-6.8.misc'
> of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs"), and when I
> revert the commits in the vfs merge the splat went away, but I *really*
> struggle to see how those are related...
>=20
> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and at
> some point the address wraps to zero, and boom. I doubt that 0xfffff000
> is a sane address.

I have zero knowledge about file system, but I think it's an integer
overflow problem. The calculation of "dlimit" overflow and dlimit wraps
around, this leads to wrong comparison later on.

I guess that explains why your bisect and Conor's bisect results are
strange: the bug has been here for quite some time, but it only appears
when "dlimit" happens to overflow.

It can be fixed by re-arrange the comparisons a bit. Can you give the
below patch a try?

Best regards,
Nam

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 05b647e6bc19..71b88b33b676 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1532,15 +1532,13 @@ int ext4_search_dir(struct buffer_head *bh, char *s=
earch_buf, int buf_size,
 		    unsigned int offset, struct ext4_dir_entry_2 **res_dir)
 {
 	struct ext4_dir_entry_2 * de;
-	char * dlimit;
 	int de_len;
=20
 	de =3D (struct ext4_dir_entry_2 *)search_buf;
-	dlimit =3D search_buf + buf_size;
-	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
+	while ((char *) de - search_buf < buf_size - EXT4_BASE_DIR_LEN) {
 		/* this code is executed quadratically often */
 		/* do minimal checking `by hand' */
-		if (de->name + de->name_len <=3D dlimit &&
+		if (de->name + de->name_len - search_buf <=3D buf_size &&
 		    ext4_match(dir, fname, de)) {
 			/* found a match - just to be sure, do
 			 * a full check */

