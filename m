Return-Path: <linux-fsdevel+bounces-73181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E52C5D1083C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 04:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A77E03028F49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 03:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562D30BF58;
	Mon, 12 Jan 2026 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="yE2qRAxy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQS8tkQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257472F851;
	Mon, 12 Jan 2026 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190311; cv=none; b=Aispupl6amhBAUVGrU2YBFSgSNXvfYTQXfCDSrNDKBMWWfhKm8YnJ0aZT45L/A+UtGyfYcQrWGlzR2xXKzt6zkJzrIGneNzCvtlfhiS1DoSxxlbYVk0L6gR+qBxUQHMGKG1+DJRUM97iWDkqFaYs7YEUIKSkInrowOniPjOtfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190311; c=relaxed/simple;
	bh=eSkP027A1CCZjKFrE44UVJhZV0eJTTGVCqVcoue31pc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aDuDyHdMzZbkZwC5K5Fsmn5SMQsYdbbtZ86gtqTl4aNnyBhC27Xnf86o13sYraHQoyZz9AbH1fQQ9OMo4gN0NROfmQ12uDWiHh0KoZd/hJXCLdsIokUDstSLKSKmP3TVnoR8zsNK0S3PJoY52ZPnQhCur4k+L60NPMVrAU/yW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=yE2qRAxy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQS8tkQx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ADDA1D0000F;
	Sun, 11 Jan 2026 22:58:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 11 Jan 2026 22:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768190308; x=1768276708; bh=rVbcl5E1HGbQVYM50ojbKUlDG1mnYcIslVP
	mwifZKQ4=; b=yE2qRAxyQhD2fTuQsrQx0RQy0eYgjDHxRP4cS8vb4zJGnRtSD8B
	RFZjV8/rV+kh+EVLott/H81RKr8KdkgCHzjgnzhFymGLHPmZDflITLDDnIh7LzfV
	3u8juEjQDz/MHVPZ84G5YPuxWa41iAeds+a+oL7BjKBzOzYWQQ6mWabyHSVQkfe0
	lRCQN20rrLjTR1jZryMXVXpBYc2WV59PLWstqWkpnQRnA/wYUkyTjqxgl1BJY5kt
	rhB37GJiEjeEMY1UIn7JNpEg6x07UO1CM8oaiQk4jkrGp/kvwnAHwPeQjgbIN8Oy
	E+ft9UXY66d6ElZ2NBOEXiVAjiDvNo2fWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768190308; x=
	1768276708; bh=rVbcl5E1HGbQVYM50ojbKUlDG1mnYcIslVPmwifZKQ4=; b=T
	QS8tkQxe4EhReuP6PWXwt4teChuXgQF5jvHsSFpiDBLNBIVzeSpp+lcwPz/WzN/H
	PmnStP9q/Bk+xFynAK9kY3vCu+alUangeybgBb4YS2TeMJlyyX0xfvis6Mnxdfeq
	ZAxU3nYca/XsRq3VKjkwtg12z5Dak9WL/CTtvcFhcTTshNe9UwCOFSwVwnCyUoYl
	bzZtpQVrHsEPgGG3VuRBKrO1Dy2r6UwoDCvQwnBm8T28nIo38Ug1orHtja8wG0/n
	3JDRefoXUlp4kazdmbyB7T6+u881vWT1IWB0kr5UI1lp3kZyCR2GKYoGVduEZW/A
	4CBwvmcdutCN7lb7bBbnA==
X-ME-Sender: <xms:YnFkadqiU9RBhxrPwXY-RS1JyM1aGZZriRofaRkYEuiWRYsRRBvyIQ>
    <xme:YnFkaZuSMQsF-DlklWD4bmXjOPiLSLMieTIoS4_VT-NO31sxdaiRc68PQhPKb85gc
    Chop1N7pkApvXZJp9XpT39pyGGLxATNh41RxH8PBxnd1aDE9To>
X-ME-Received: <xmr:YnFkaaEJkVJQYca4t_lA6XDvtI18s7vLOvRgjLXhAx3pnJF9A8i-O3lduDOtBXFqWyhyJFU1EeraNlBkhJFmiCtMWZ2II0ytg7U2ZmhHoL3h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeigeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugieslhgvvghmhhhuih
    hsrdhinhhfohdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsvghrnhgusegsshgsvghrnhgurdgtohhm
X-ME-Proxy: <xmx:YnFkaaa6PIPQCWt425tYNtECjiXYjj2JkIbTnbNbkqKlMYwNHw8FdQ>
    <xmx:YnFkaaVaIQkskhcK-aXm1KtpQsgGq7iZ4mlgjigZ3TFMbRV-ceu5sQ>
    <xmx:YnFkaQn0qPUKLGQUbPgC5lHqHNt-0bCIQsVIbqy0A6pvuP-Rj8iLEA>
    <xmx:YnFkaVCMulJmOZmReVFc3gvwcU28Bazv-B5wPepbTKa9dO48-YIONQ>
    <xmx:ZHFkaX8QFyqBhxzyMMKGSgbjWHImt4F6cHduvWsBqu-A2Hz8FfnVU5As>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 22:58:24 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Bernd Schubert" <bernd@bsbernd.com>
Cc: "Thorsten Leemhuis" <linux@leemhuis.info>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Linux kernel regressions list" <regressions@lists.linux.dev>,
 "LKML" <linux-kernel@vger.kernel.org>,
 "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [REGRESSION] fuse: xdg-document-portal gets stuck and causes
 suspend to fail in mainline
In-reply-to: <ff46166e-6795-4cab-bfef-d0724200bc62@bsbernd.com>
References: <7d4ac21f-491f-4f0a-bc50-7601cd1140ca@leemhuis.info>,
 <ff46166e-6795-4cab-bfef-d0724200bc62@bsbernd.com>
Date: Mon, 12 Jan 2026 14:58:20 +1100
Message-id: <176819030053.16766.15730807505551833487@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 12 Jan 2026, Bernd Schubert wrote:
>=20
> On 1/11/26 12:37, Thorsten Leemhuis wrote:
> > Lo! I can reliably get xdg-document-portal stuck on latest -mainline
> > (and -next, too; 6.18.4. works fine) trough the Signal flatpak, which
> > then causes suspend to fail:
> >=20
> > """
> >> [  194.439381] PM: suspend entry (s2idle)
> >> [  194.454708] Filesystems sync: 0.015 seconds
> >> [  194.696767] Freezing user space processes
> >> [  214.700978] Freezing user space processes failed after 20.004 seconds=
 (1 tasks refusing to freeze, wq_busy=3D0):
> >> [  214.701143] task:xdg-document-po state:D stack:0     pid:2651  tgid:2=
651  ppid:1939   task_flags:0x400000 flags:0x00080002
> >> [  214.701151] Call Trace:
> >> [  214.701154]  <TASK>
> >> [  214.701167]  __schedule+0x2b8/0x5e0
> >> [  214.701181]  schedule+0x27/0x80
> >> [  214.701188]  request_wait_answer+0xce/0x260 [fuse]
> >> [  214.701202]  ? __pfx_autoremove_wake_function+0x10/0x10
> >> [  214.701212]  __fuse_simple_request+0x120/0x340 [fuse]
> >> [  214.701219]  fuse_lookup_name+0xc3/0x210 [fuse]
> >> [  214.701235]  fuse_lookup+0x99/0x1c0 [fuse]
> >> [  214.701242]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701247]  ? fuse_dentry_init+0x23/0x50 [fuse]
> >> [  214.701257]  lookup_one_qstr_excl+0xa8/0xf0
>=20
> Introduced by c9ba789dad15 ("VFS: introduce start_creating_noperm() and
> start_removing_noperm()")?
>=20
> Why is the new code doing a lookup on an entry that is about to be
> invalidated?
>=20
>=20
> In order to handle this at least one fuse server process needs to be
> available, but for this specific case the lookup still doesn't make sense.
>=20
> We could do something like this
>=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4b6b3d2758ff..7edbace7eddc 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1599,6 +1599,15 @@ int fuse_reverse_inval_entry(struct fuse_conn
> *fc, u64 parent_nodeid,
>         if (!dir)
>                 goto put_parent;
>=20
> +       /* Check dcache first - if not cached, nothing to invalidate */
> +       name->hash =3D full_name_hash(dir, name->name, name->len);
> +       entry =3D d_lookup(dir, name);
> +       if (!entry) {
> +               err =3D 0;
> +               dput(dir);
> +               goto put_parent;
> +       }
> +
>         entry =3D start_removing_noperm(dir, name);
>         dput(dir);
>         if (IS_ERR(entry))
>=20
>=20
> But let's assume the dentry exists - start_removing_noperm() will now
> trigger a revalidate and get the same issue. From my point of view the
> above commit should be reverted for fuse.
>=20
>=20
> >> [  214.701264]  start_removing_noperm+0x59/0x80
> >> [  214.701268]  ? d_find_alias+0x82/0xd0
> >> [  214.701273]  fuse_reverse_inval_entry+0x7d/0x1f0 [fuse]
> >> [  214.701280]  ? fuse_copy_do+0x5f/0xa0 [fuse]
> >> [  214.701287]  fuse_notify+0x4a1/0x750 [fuse]
> >> [  214.701295]  ? iov_iter_get_pages2+0x1d/0x40
> >> [  214.701301]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701305]  fuse_dev_do_write+0x2e4/0x440 [fuse]
> >> [  214.701313]  fuse_dev_write+0x6b/0xa0 [fuse]
> >> [  214.701320]  do_iter_readv_writev+0x161/0x260
> >> [  214.701327]  vfs_writev+0x168/0x3c0
> >> [  214.701334]  ? ksys_write+0xcd/0xf0
> >> [  214.701338]  ? do_writev+0x7f/0x110
> >> [  214.701341]  do_writev+0x7f/0x110
> >> [  214.701344]  do_syscall_64+0x7e/0x6b0
> >> [  214.701350]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701352]  ? __handle_mm_fault+0x445/0x690
> >> [  214.701359]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701363]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701365]  ? count_memcg_events+0xd6/0x210
> >> [  214.701371]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701373]  ? handle_mm_fault+0x212/0x340
> >> [  214.701377]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701379]  ? do_user_addr_fault+0x2b4/0x7b0
> >> [  214.701387]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701389]  ? irqentry_exit+0x6d/0x540
> >> [  214.701393]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> [  214.701395]  ? exc_page_fault+0x7e/0x1a0
> >> [  214.701398]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  214.701402] RIP: 0033:0x7f3c144f9982
> >> [  214.701467] RSP: 002b:00007fff80e2f388 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000014
> >> [  214.701470] RAX: ffffffffffffffda RBX: 00007f3bec000cf0 RCX: 00007f3c=
144f9982
> >> [  214.701472] RDX: 0000000000000003 RSI: 00007fff80e2f460 RDI: 00000000=
00000007
> >> [  214.701474] RBP: 00007fff80e2f3b0 R08: 0000000000000000 R09: 00000000=
00000000
> >> [  214.701475] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
> >> [  214.701477] R13: 00007f3bec000cf0 R14: 00007f3c14bb8280 R15: 00007f3b=
e8001200
> >> [  214.701481]  </TASK>
> > """
> >=20
> > Killing the mentioned process using "kill -9" doesn't help. I can
> > reliably trigger this in -mainline and -next using the Signal flatpak on
> > Fedora 43 by trying to send a picture (which gets xdg-document-portal
> > involved). It works the first time, but trying again won't and will
> > cause Signal to get stuck for a few seconds. Works fine in 6.18.4.
> >=20
> > Is this maybe known already or does anybody have an idea what's wrong?
> > If not I guess I'll have to bisect this.
> >=20
> > Ciao, Thorsten
> >=20
> > #regzbot introduced: v6.18..
> > #regzbot title: fuse: xdg-document-portal gets stuck and causes suspend
> > to fail
> >=20
> >=20
>=20
> Thanks,
> Bernd
>=20

I post a fix

  https://lore.kernel.org/all/176454037897.634289.3566631742434963788@noble.n=
eil.brown.name/

a while ago.  There was some talk in that thread of reverting the
breaking change instead.  I seems nothing happened.

Christian: should I resend my patch?

Thanks,
NeilBrown

