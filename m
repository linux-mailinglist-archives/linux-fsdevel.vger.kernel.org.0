Return-Path: <linux-fsdevel+bounces-77348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDeWEOQxlGkNAgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:16:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B158A14A458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2882F30234CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13D30171C;
	Tue, 17 Feb 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MEVJLmrx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpYq6GbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CD29E110;
	Tue, 17 Feb 2026 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319776; cv=none; b=fS9gu/WmiUukFD5rw6vtN5ZR/1+NitD5u5k3FV8nl/3TEmXx3Hfwsv+ufKRJ8GEIpU3UTk4ExEiR4dzQhanHJLElTD1TVq6uwQfY/ViJWyaj8Spp9BM7FFUATNgxPvh57UFFqCnCK/kBTnEbL/mi7jWg4fwn4wYFN+QqcdJ3fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319776; c=relaxed/simple;
	bh=dWH4ByV+lmGKjtEtsFvxEN5atKL3uwiQbt4YKFq0/OA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=agx1QOAB6+zmSJM1Wvl8rKw68NF0l7XVZQLyVOqu17s57w/KwqAjddd4WR55HJJF7IvHGvQwZ1kPyHywJtC3n46makSV5RLQQaulgSLQ4bDoJsH3u5IqRn2ptScWrbCwDldlW4uK1rs4nNVeiLjnF7psH5XjuK+XDt90iaWR9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MEVJLmrx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpYq6GbV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA4507A0050;
	Tue, 17 Feb 2026 04:12:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 04:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771319573; x=1771405973; bh=SN6PPtxT5bKlWoOxjGYR/7GIyFgG1DzqiFD
	SjPXDV+4=; b=MEVJLmrxakegr/Dx4kencZ/ab+dhFkVEnefDGD7o8QFVgSWx5gC
	VgXeCFj2Ug+9NlQPT5PXrnf+hWkFherPpp6LjJIFbGaJq76PdbGpfhm59bv2pqaU
	8zvXhcG4Wm9jePjMGtwR86sxConeg9FckmzaS6Sq35cTiTiB0YwfYtTfBv974VnJ
	COUymubg6+FaZ+P3VETiLCF5uLUbomp8Ho8RCslOnOsUnucKGGph5wp2y5wmaDhS
	DTIju69CEtjDxktXWgyvNlG2BKD9NBvM/xURWSoSokyiSqD2fHWXJmHfrPqbMoTM
	p8wWii18nt/CNPyIc9dALHoiGnBOcgzqRZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771319573; x=
	1771405973; bh=SN6PPtxT5bKlWoOxjGYR/7GIyFgG1DzqiFDSjPXDV+4=; b=L
	pYq6GbV0in3Zx5AcPs68cXEfItnAGQX9k0pSJwY2qat+8OmFFEU+BjcsuDfgsAPD
	De4EMeBX4UC/vVMTGneoHX7/IlGN2shiyVMfRGfQ1A96TB95lbNmmAXuTdUszXSu
	HccDV+K2n0FBMEt5l8W/+vfNSvFGdsuLa5l9X2lIImwiITNi4KKLFpsLOTuHqlYc
	9wQKCmuunycfSYXyNtGkG/UCHq6yQ0BQObY0XnlNk2ERH8fBvGcxlQN6aAFjp9Bc
	kjHivllaQfRcv66o01MvDmeuEYBqOxoaSRCVlTnsLQgAUGS9QrA2XdLz1h0Y7Ceh
	dAY3PNTHhuz3HwD7PYY4g==
X-ME-Sender: <xms:FDGUaWLlqFIjETHowbqO6brhtbDnpdjcjjHEkaDKAWKKue3_W9ZOiw>
    <xme:FDGUaels-XNaeB9B-K4aEfhCM6mhhplhxImb-UQUXNvDOq3eW_jDMGxFaVzz-DASD
    u3VXqkNk9D33i6qljw8xXgAUaCrEf7m9WKHgT9skLdgqPK-gw>
X-ME-Received: <xmr:FDGUaXax37aM3iQet1gwTfBvGB_XjcGDu_5wPlBinbZPGzF_XmcNFgdIlMoIwVRkEsYcr5PVtQCr_MiiYC7JuVCfoTx8yGseq8pCWZy3qoMO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurheptgfgggfhvfevufgjfhffkfhr
    sehtqhertddttdejnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnh
    hmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheplefhuddtfffhleegvdeitdetgeeu
    udetkeegkeeutdevhfegkeffveeuieetgeejnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdrtghomhdpghhoohdrghhl
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvih
    hlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshihiigsohhtoddtvggrhedutdekrgdufhehfhgsgehftggt
    vdgukeesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtphhtth
    hopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehgfhhsvdeslhhishhtshdrlhhi
    nhhugidruggvvhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehshiiikhgrlhhlvghrqdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgt
    ohhm
X-ME-Proxy: <xmx:FDGUaS96Qjtq5ZmCyLG2XcmxtGfxmF6bQlgyX0rNEyzKeAnpB66vEg>
    <xmx:FDGUaeZ4Ds6-Z1ItnIf6Mv2j6bzvtBZd6twknyBiY9LJLl4ub7J2PQ>
    <xmx:FDGUaUcfRdVkV_rRHOpczvKIg-7qvts0zA5B5VyJ7A0HN4KXpdfG3w>
    <xmx:FDGUaTnzGaxGh-CPhPq2xWEr3DebL0VIMMWL0-IZ6MSE3mI46XjRwg>
    <xmx:FTGUaQ5eBfEwuBK1ErOtbx0PiAEFumjWaFAGZcGZWVEUmgRhaGbj-lxp>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:12:50 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "syzbot" <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>,
 gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
In-reply-to: <20260217-fanshop-akteur-af571819f78b@brauner>
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com>,
 <20260217-fanshop-akteur-af571819f78b@brauner>
Date: Tue, 17 Feb 2026 20:12:46 +1100
Message-id: <177131956603.8396.12634282713089317@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77348-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REDIRECTOR_URL(0.00)[goo.gl];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,0ea5108a1f5fb4fcc2d8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B158A14A458
X-Rspamd-Action: no action

On Tue, 17 Feb 2026, Christian Brauner wrote:
> On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://git.=
k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15331c02580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac00553de86d6=
bf0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ea5108a1f5fb4f=
cc2d8
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D146b295a580=
000
> >=20
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71e9c/vmlinu=
x-0f2acd31.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b18643058ceb/b=
zImage-0f2acd31.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/bbfed09077=
d3/mount_1.gz
> >   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=3D106b=
295a580000)
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> > Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
>=20
> Neil, is this something you have time to look into?

The reproducer appears to mount a gfs2 filesystem and mkdir 3
directories:
  ./file1
  ./file1/file4
  ./file1/file4/file7

and somewhere in there it crashes because vfs_mkdir() returns a
non-error dentry for which ->d_parent->d_inode is not locked and
end_creating_path() tries to up_write().

Presumably either ->d_parent has changed or the inode was unlocked?

gfs2_mkdir() never returns a dentry, so it must be returning NULL.

It's weird - but that is no surprise.

I'll try building a kernel myself and see if the reproducer still fires.
if so some printk tracing my reveal something.

NeilBrown


>=20
> >=20
> > ------------[ cut here ]------------
> > DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) !=3D current) && !rwsem_test_oflag=
s(sem, RWSEM_NONSPINNABLE)): count =3D 0x0, magic =3D 0xffff88804a18c9b8, own=
er =3D 0x0, curr 0xffff888000ec2480, list empty
> > WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c=
:1380 [inline], CPU#0: syz.0.53/5774
> > WARNING: kernel/locking/rwsem.c:1381 at up_write+0x2d6/0x410 kernel/locki=
ng/rwsem.c:1643, CPU#0: syz.0.53/5774
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5774 Comm: syz.0.53 Not tainted syzkaller #0 PREEMPT(f=
ull)=20
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> > RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
> > RIP: 0010:up_write+0x388/0x410 kernel/locking/rwsem.c:1643
> > Code: cc 8b 49 c7 c2 c0 eb cc 8b 4c 0f 44 d0 48 8b 7c 24 08 48 c7 c6 20 e=
e cc 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 10 41 52 <67> 48 0f b9 3a 4=
8 83 c4 08 e8 ea 60 0a 03 e9 67 fd ff ff 48 c7 c1
> > RSP: 0000:ffffc90006407d80 EFLAGS: 00010246
> > RAX: ffffffff8bcceba0 RBX: ffff88804a18c9b8 RCX: ffff88804a18c9b8
> > RDX: 0000000000000000 RSI: ffffffff8bccee20 RDI: ffffffff9014bf50
> > RBP: ffff88804a18ca10 R08: 0000000000000000 R09: ffff888000ec2480
> > R10: ffffffff8bcceba0 R11: ffffed1009431939 R12: 0000000000000000
> > R13: dffffc0000000000 R14: ffff88804a18c9b8 R15: 1ffff11009431938
> > FS:  00007f9e11bfe6c0(0000) GS:ffff88808ca62000(0000) knlGS:0000000000000=
000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000c000d54e20 CR3: 0000000041f2c000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  inode_unlock include/linux/fs.h:1038 [inline]
> >  end_dirop fs/namei.c:2947 [inline]
> >  end_creating include/linux/namei.h:126 [inline]
> >  end_creating_path fs/namei.c:4962 [inline]
> >  filename_mkdirat+0x305/0x510 fs/namei.c:5271
> >  __do_sys_mkdirat fs/namei.c:5287 [inline]
> >  __se_sys_mkdirat+0x35/0x150 fs/namei.c:5284
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f9e10d9bf79
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f9e11bfe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
> > RAX: ffffffffffffffda RBX: 00007f9e11016090 RCX: 00007f9e10d9bf79
> > RDX: 00000000000001c0 RSI: 0000200000000140 RDI: ffffffffffffff9c
> > RBP: 00007f9e10e327e0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f9e11016128 R14: 00007f9e11016090 R15: 00007ffffd54f8b8
> >  </TASK>
> > ----------------
> > Code disassembly (best guess), 2 bytes skipped:
> >    0:	49 c7 c2 c0 eb cc 8b 	mov    $0xffffffff8bccebc0,%r10
> >    7:	4c 0f 44 d0          	cmove  %rax,%r10
> >    b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
> >   10:	48 c7 c6 20 ee cc 8b 	mov    $0xffffffff8bccee20,%rsi
> >   17:	48 8b 14 24          	mov    (%rsp),%rdx
> >   1b:	4c 89 f1             	mov    %r14,%rcx
> >   1e:	4d 89 e0             	mov    %r12,%r8
> >   21:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
> >   26:	41 52                	push   %r10
> > * 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
> >   2d:	48 83 c4 08          	add    $0x8,%rsp
> >   31:	e8 ea 60 0a 03       	call   0x30a6120
> >   36:	e9 67 fd ff ff       	jmp    0xfffffda2
> >   3b:	48                   	rex.W
> >   3c:	c7                   	.byte 0xc7
> >   3d:	c1                   	.byte 0xc1
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >=20
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >=20
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >=20
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >=20
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >=20
> > If you want to undo deduplication, reply with:
> > #syz undup
>=20


