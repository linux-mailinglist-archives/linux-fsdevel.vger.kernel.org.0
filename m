Return-Path: <linux-fsdevel+bounces-77422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hy5N2TplGmSIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:19:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4115167E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6193018089
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB0313E39;
	Tue, 17 Feb 2026 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NiCaIJEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qYDdxUQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C99139D;
	Tue, 17 Feb 2026 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366743; cv=none; b=dMUwWPj7Vz5uwExKKczPFKNkpodw63/b2Qb6uHKpp7gmTX7gKTQ+5Ez2b7umVWuaq1nbKVeJYyPHFczn7TTBDdodcO1GnNoQ5IH1g22HsPO9WLdimdWwatMv/TLE3ZwoLUsjKi2LwGiwjGAHeBOyA8DYJ6mcMmQi4pckD9LpEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366743; c=relaxed/simple;
	bh=lm7iwONb7FGSy3u3bCtG88NlrAlCB411P2BG0uMcprw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W3A1VO3yESl10M0WCX1f+aCbRC+j99hOe8J1dS8JK+RueGG0Zw7armWHY7lcs0Qe/89DxgUjQlieZpAdR1a6Tz4Ytci6urLjv77tst5qXWsvmwFNLihFkScPQTRCljyhvHycNW2x/qSO36UMg9F37Fpk9mqgyQD9kIFZJ5u7bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NiCaIJEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qYDdxUQy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E30BE7A0123;
	Tue, 17 Feb 2026 17:19:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 17:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771366740; x=1771453140; bh=u2H8p40L5wckMyaw3R8Ixd82jhqlRVZNb3Y
	AhJWKOws=; b=NiCaIJEnlbCLt8nh4j6+Kw2IEztZVFT0EFbp4f9SqrJOTe3GQh8
	1EfSL3oGgUo5XTxevqzHCM9SA+C8J8Q1mvY3ZIODzHuvJ5KT4v8OkbCp3GN2L4SB
	d90Tk8znyZBwZS+al/+1sGFyHGcY6Jn4JKFK6R4s2k45llS39gpWwkBijPzGYbNV
	2iqYe0Eo3q9e8moxC5qk0mVLjGXCS3sulO7TmFQzwOGvrU1O2e80BZVaJxIvum6P
	3wer/21B1atwr3PKAhU44YK+nuww0JaV3jdhPGa20VkD6GMxy1Zl3GvAUMcj03U/
	J6Y/BFVi4c+JdIoYmo1eNWBbJV0Gi5FPrhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771366740; x=
	1771453140; bh=u2H8p40L5wckMyaw3R8Ixd82jhqlRVZNb3YAhJWKOws=; b=q
	YDdxUQy+djCLT5zGJrpSxXYmrF2I8MGajtH65H5EuQBeZ71jMbYsoXotP4gl23ze
	WKuZr3xNIpgqUOfxp166xNmEGF55u49YKx5g8a7H4wiq171EIhfqguxw/aWExWcT
	aARxohu0vGlJONI+gmDVKL3cIoTVTYfVn2gyojnMS17ma8fDaxy9ciMp73DtXHRZ
	Rpvro6RLvYI/JK2X/I8Nq80QMNddtJxA/+WZmJrLLuiGZnjtktlPF/gZ/oU/WIRy
	XNdLcNOqEiB3rfGdRTlOVEhvq4fFDN7Nh9sBFiJIZuGIi2gkBgSNMX/Og6OE8MAq
	KXciUfLu6dqauRnAXkhXA==
X-ME-Sender: <xms:VOmUaQSN27c3M1uLt7h55EQ-LUBK8dvVC6mvtlslbX-pOq6vMstIoA>
    <xme:VOmUaeNYfhK2gD4SartlmVPL0Y8pboCMSGE7EnJLwgXuzhdVpdRNw_4BiJ-O2ng_R
    72DnuAu1_i9QstHwykvEOeeUpmdfuZyphs3WhNXxooqT6jRSg>
X-ME-Received: <xmr:VOmUaejG8vcnvIPQoC5zQl2DHCpQLfg4L8KVdFnZVkFGGejHLGWgLCmsLUm0BrDE6252If2J91eCEtF7aRPwpb78mAFNJ3MJ9WoRGebZAD0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurheptgfgggfhvfevufgjfhffkfhr
    sehtqhertddttdejnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnh
    hmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffhfffkeegjeejtdffueekjeff
    feeljedtvdekveduuddtudeiieeuhefhheehnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmh
    grihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehshiiisghothdotdgvrgehuddtkegrudhfhehfsgegfhgttgdvugeksehshiii
    khgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepghhfshdvsehlihhsthhsrdhlihhnuhigrdguvghv
    pdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    ihiihkrghllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:VOmUabkHv7bDWpfhyBUTtYItEuy2is3QSqzBhJECUEfpk1rLHVoVoA>
    <xmx:VOmUaai4eHDdZ-LS1Ct9qts6r1RPheeabcYkgqyDcTrKL-VIplxRKQ>
    <xmx:VOmUaeGQonTpUMlWXH5vYOG-hFbDn5Z5a8_tqqc6U8Ntn1bIvEb49A>
    <xmx:VOmUacut68CqZQ9WfiLDH0UhG9PKxh2jkDcq0HSJMImIatTy6u--9w>
    <xmx:VOmUaTDdLq5RBzoTLHHWuRnpyxRvDui6RqAy_SPTRJ0FEkVz_wQoeQwB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 17:18:57 -0500 (EST)
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
In-reply-to: <177131956603.8396.12634282713089317@noble.neil.brown.name>
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com>, <>,
 <20260217-fanshop-akteur-af571819f78b@brauner>,
 <177131956603.8396.12634282713089317@noble.neil.brown.name>
Date: Wed, 18 Feb 2026 09:18:53 +1100
Message-id: <177136673378.8396.7219915415554001211@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77422-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel,0ea5108a1f5fb4fcc2d8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 65E4115167E
X-Rspamd-Action: no action

On Tue, 17 Feb 2026, NeilBrown wrote:
> On Tue, 17 Feb 2026, Christian Brauner wrote:
> > On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> > > Hello,
> > >=20
> > > syzbot found the following issue on:
> > >=20
> > > HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://gi=
t.k..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15331c02580=
000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac00553de86=
d6bf0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ea5108a1f5fb=
4fcc2d8
> > > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e=
25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D146b295a5=
80000
> > >=20
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71e9c/vmli=
nux-0f2acd31.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b18643058ceb=
/bzImage-0f2acd31.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/bbfed090=
77d3/mount_1.gz
> > >   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=3D10=
6b295a580000)
> > >=20
> > > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
> >=20
> > Neil, is this something you have time to look into?
>=20
> The reproducer appears to mount a gfs2 filesystem and mkdir 3
> directories:
>   ./file1
>   ./file1/file4
>   ./file1/file4/file7
>=20
> and somewhere in there it crashes because vfs_mkdir() returns a
> non-error dentry for which ->d_parent->d_inode is not locked and
> end_creating_path() tries to up_write().
>=20
> Presumably either ->d_parent has changed or the inode was unlocked?
>=20
> gfs2_mkdir() never returns a dentry, so it must be returning NULL.
>=20
> It's weird - but that is no surprise.
>=20
> I'll try building a kernel myself and see if the reproducer still fires.
> if so some printk tracing my reveal something.

Unfortunately that didn't work out.
Using the provided vmlinux and root image and repro, and a syzkaller I
compiled from current git, I cannot trigger the crash.

I'll have another look at the code but I don't hold out a lot of hope.

NeilBrown

