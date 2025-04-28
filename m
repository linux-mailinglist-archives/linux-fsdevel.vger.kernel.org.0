Return-Path: <linux-fsdevel+bounces-47494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A036FA9EA71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9864176D13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E82255239;
	Mon, 28 Apr 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDN6BQB+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0T9amF7B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDN6BQB+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0T9amF7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732EF2010F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828064; cv=none; b=S1YXKDtPjcjPpvXimfs6uqZXJ9Yl1lczlpiBy8psynwc8TytgABPqfDG9etOpfAHN+w1CAtvYh5eF6U1ygWL6y2vluTYrbfkV1DuydS51GYd19Th69ehRjcEUS5MzBf9pUodMZr/mlx2Cr/wgYfF2WZJpE+TypZlsjpFrgUYfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828064; c=relaxed/simple;
	bh=Wbgt7P86afR5QH53FyEwBRz7tO2LbGXfCh4wlwH8XEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvBSmq24OIOCuuaucFeTQguFpGfkrvPlWlWFGIo6bdRSyKWuSkC0dmFW0b4cn0OEtYDHGXBTZ8DC/fK1oPHyCkmf4jb7OSHQTtflWCucGOICFFT8ggnD2lO8J9jUbngYcR2o3MZJIWlIcwqwmjwqzUVs4eHqTvXbcNk0Ej25fDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDN6BQB+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0T9amF7B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDN6BQB+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0T9amF7B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D06C1F391;
	Mon, 28 Apr 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745828054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Boy9wSupGc+8OBtCDLq1fvDnl4kqnx2cQ4DCW9hO+gE=;
	b=TDN6BQB+esynh8MFpFuEDaq9SgU2tOolGCqMdSV8jbu4euFUS9keMzFBTEqVAZKlNQ5bMF
	sYGFveupRtLxLqQE7p/hSW5Llx/fV93CEv19l9abQX7oZzP+iLpR/rov9J7Nr5GhuZyvt1
	Eh72Z8G6YR+yjrH97pmMfDCXkHoDC28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745828054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Boy9wSupGc+8OBtCDLq1fvDnl4kqnx2cQ4DCW9hO+gE=;
	b=0T9amF7BWeU5GHy8MSn4Rxhepm+QehuFBTFYyeFROQv2mtHoUMO6V84OPyzty+Zlb+NGW3
	8F1kYsBJMpQh7oCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745828054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Boy9wSupGc+8OBtCDLq1fvDnl4kqnx2cQ4DCW9hO+gE=;
	b=TDN6BQB+esynh8MFpFuEDaq9SgU2tOolGCqMdSV8jbu4euFUS9keMzFBTEqVAZKlNQ5bMF
	sYGFveupRtLxLqQE7p/hSW5Llx/fV93CEv19l9abQX7oZzP+iLpR/rov9J7Nr5GhuZyvt1
	Eh72Z8G6YR+yjrH97pmMfDCXkHoDC28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745828054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Boy9wSupGc+8OBtCDLq1fvDnl4kqnx2cQ4DCW9hO+gE=;
	b=0T9amF7BWeU5GHy8MSn4Rxhepm+QehuFBTFYyeFROQv2mtHoUMO6V84OPyzty+Zlb+NGW3
	8F1kYsBJMpQh7oCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8911336F;
	Mon, 28 Apr 2025 08:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V2QZH9Y4D2itewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Apr 2025 08:14:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20B47A07B2; Mon, 28 Apr 2025 10:14:10 +0200 (CEST)
Date: Mon, 28 Apr 2025 10:14:10 +0200
From: Jan Kara <jack@suse.cz>
To: Liebes Wang <wanghaichi0403@gmail.com>
Cc: Jan Kara <jack@suse.cz>, ojaswin@linux.ibm.com, 
	Theodore Ts'o <tytso@mit.edu>, yi.zhang@huawei.com, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: kernel BUG in zero_user_segments
Message-ID: <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 25-04-25 15:29:41, Liebes Wang wrote:
> Dear Linux maintainers and reviewers:
> We are reporting a Linux kernel bug titled **kernel BUG in
> zero_user_segments**, discovered using a modified version of Syzkaller.
>=20
> This bug seems to be duplicated as
> https://syzkaller.appspot.com/bug?extid=3D78eeb671facb19832e95, but the t=
est
> case is much smaller, which may be helpful for analyzing the bug.
>=20
> Linux version: 9d7a0577c9db35c4cc52db90bc415ea248446472
>=20
> The bisection log shows the first introduced commit is
> 982bf37da09d078570650b691d9084f43805a5de
> commit 982bf37da09d078570650b691d9084f43805a5de
> Author: Zhang Yi <yi.zhang@huawei.com>
> Date:   Fri Dec 20 09:16:31 2024 +0800
>=20
>     ext4: refactor ext4_punch_hole()
>=20
>     The current implementation of ext4_punch_hole() contains complex
>     position calculations and stale error tags. To improve the code's
>     clarity and maintainability, it is essential to clean up the code and
>     improve its readability, this can be achieved by: a) simplifying and
>     renaming variables; b) eliminating unnecessary position calculations;
>     c) writing back all data in data=3Djournal mode, and drop page cache =
=66rom
>     the original offset to the end, rather than using aligned blocks,
>     d) renaming the stale error tags.
>=20
>     Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>     Link:
> https://patch.msgid.link/20241220011637.1157197-5-yi.zhang@huaweicloud.com
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>

So there's something suspicious about this report. The stacktrace shows
we've crashed in punch hole code (call from ioctl_preallocate()) but the
reproducer actually never calls this. Anyway, the reported stack trace ends
with truncate_inode_partial_folio() -> folio_zero_range() ->
zero_user_segments(). The assertion that's failing is:

BUG_ON(end1 > page_size(page) || end2 > page_size(page));

Now it seems that this assertion can indeed easily trigger when we have
a large folio because truncate_inode_partial_folio() is called to zero out
tail of the whole folio which can certainly be more than a page. Matthew,
am I missing something (I guess I am because otherwise I'd expect we'd be
crashing left and right) or is the folio conversion on this path indeed
broken?

								Honza

>=20
> The test case, kernel config and full bisection log are attached.
>=20
> The report is (The full report is attached):
> EXT4-fs (loop7): mounted filesystem 00000000-0000-0000-0000-000000000000
> r/w without journal. Quota mode: writeback.
> EXT4-fs warning (device loop7): ext4_block_to_path:105: block 2147483648 >
> max in inode 15
> ------------[ cut here ]------------
> kernel BUG at ./include/linux/highmem.h:275!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 6795 Comm: syz.7.479 Not tainted
> 6.15.0-rc3-g9d7a0577c9db #1 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:zero_user_segments.constprop.0+0x10c/0x290
> include/linux/highmem.h:275
> Code: 0f b6 4b 40 ba 00 10 00 00 48 d3 e2 49 89 d7 e8 ba d5 e2 ff 4c 89 fe
> 4c 89 ef e8 3f d0 e2 ff 4d 39 fd 76 08 e8 a5 d5 e2 ff 90 <0f> 0b e8 9d d5
> e2 ff be 08 00 00 00 48 89 df e8 a0 9c 1d 00 48 89
> RSP: 0018:ffff8881235ff678 EFLAGS: 00010216
> RAX: 000000000000025d RBX: ffffea00056071c0 RCX: ffffc90002e0b000
> RDX: 0000000000080000 RSI: ffffffff818f7b0b RDI: 0000000000000006
> RBP: 000000000040b000 R08: 0000000000000000 R09: fffff94000ac0e38
> R10: 0000000000001000 R11: 0000000000000000 R12: 0000000000000005
> R13: 000000000040b000 R14: 0000000000000000 R15: 0000000000001000
> FS:  00007fecef19d700(0000) GS:ffff888543948000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5e38b40008 CR3: 000000013ebaa001 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  folio_zero_range include/linux/highmem.h:647 [inline]
>  truncate_inode_partial_folio+0x6da/0xbd0 mm/truncate.c:219
>  truncate_inode_pages_range+0x3fc/0xcc0 mm/truncate.c:387
>  ext4_truncate_page_cache_block_range+0xb3/0x5c0 fs/ext4/inode.c:3974
>  ext4_punch_hole+0x2cd/0xec0 fs/ext4/inode.c:4049
>  ext4_fallocate+0x128d/0x32c0 fs/ext4/extents.c:4766
>  vfs_fallocate+0x3ed/0xd70 fs/open.c:338
>  ioctl_preallocate+0x190/0x200 fs/ioctl.c:290
>  file_ioctl fs/ioctl.c:333 [inline]
>  do_vfs_ioctl+0x149c/0x1850 fs/ioctl.c:885
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl fs/ioctl.c:892 [inline]
>  __x64_sys_ioctl+0x11f/0x200 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc1/0x1d0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

> syz_mount_image$ext4(&(0x7f0000000400)=3D'ext4\x00', &(0x7f00000001c0)=3D=
'./file0\x00', 0x0, &(0x7f0000000280)=3D{[{@journal_ioprio}, {@mb_optimize_=
scan}, {@data_err_ignore}, {@grpquota}, {@barrier}]}, 0x1, 0x3cb, &(0x7f000=
00026c0)=3D"$eJzs3M9rHFUcAPDvTH61aXUjeBC9LAgaELPZpFoFRQUFD55sLx48LLtpLW4aab=
ZgSw4VPHnVf0AE79V/QBDFmzdvgmBFKRRJe/K0Mrsz6ZrsxsTduEn6+cBj35uZzXvfndnhO5OdF=
8ADqxwRr0bEREQsRUQpX57mJW50S7bdvc2NelaSaLfP/ZlEEhF3Nzfqxd9K8tdTeWM+jUg/jnji=
xs5+169df7/WbK5cyduV1uoHlfVr15+9tFq7uHJx5XL1hRefX1o+Wz1zdmSx3vz53PKv377+w1e=
/PfXTj+2Xv8jGezpf1xvHqJSjvPWZbPfcqDsbs+lxDwAAgD1J89x/spP/l2KiU+sqRWVjrIMDAA=
AARqL9Sv4KAAAAHGOJa38AAAA45orfAdzd3KgXZYw/R/jf3XktIua68RfPN3fXTMaJfJupA3y+t=
RwRJ95uvJOVOKDnkAEAen2T5T+L/fK/NB7r2W4my1Mi4uSI+y9va+/Mf9LbI+7yH7L876WeuW3u=
9cSfm5vIWw91UsWp5MKl5spiRDwcEfMxNZO1q7v0cWvmk5lB63rzv6xk/Re5YD6O25Pb3t2otWr=
DxNzrzkcRj0/2iz/Zyn+TiJgdoo8v/7p5ddC6f4//YLU/j3i67/6/P3NPsvv8RJXO8VApjoqdbq=
3+8u6g/scdf7b/Z3ePfy7pna9pff99/L54frVT6XPy+K/H/3RyvlMvrss+rLVaV6oR08lbO5cv3=
X9v0S62z+Kff7L/9784/yX5nFan83PAfn339XufDlp3GPZ/Y1/7f/+VN978fojvf7b/z3Rq8/mS=
vZz/9jrAYT47AAAAOCrSzn2NJF3YqqfpwkL3fsejMZs219Zbz1xYu3q50b3/MRdTaXGnq9RzP7T=
a/Tf6VntpW3s5Ih6JiM9KJzvthfpaszHu4AEAAOABcWrA9X/mj9K4RwcAAACMzNy4BwAAAAAcON=
f/AAAAcKwNM6+fymGv1ONQDEPlCFbGfWYCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAA42v4OAAD///tZxK0=3D")
> quotactl_fd$Q_SETINFO(0xffffffffffffffff, 0x2, 0x0, &(0x7f0000000080)=3D{=
0x80000000000002, 0x80000000005, 0x1, 0x6})
> r0 =3D openat(0xffffffffffffff9c, &(0x7f0000000040)=3D'./file1\x00', 0x42=
, 0x1ff)
> ioctl$EXT4_IOC_CHECKPOINT(r0, 0x40305829, &(0x7f0000000080)=3D0x5)
> r1 =3D openat(0xffffffffffffff9c, &(0x7f0000000040)=3D'./file1\x00', 0x42=
, 0x1ff)
> ioctl$EXT4_IOC_CHECKPOINT(r1, 0x40305829, &(0x7f0000000080)=3D0x5)





--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR

