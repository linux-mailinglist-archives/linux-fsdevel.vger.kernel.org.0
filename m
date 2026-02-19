Return-Path: <linux-fsdevel+bounces-77743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO9eKZqEl2mUzgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:46:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDDE162ED6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E61F30214E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAEE326938;
	Thu, 19 Feb 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="I0cnulyW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYF/8y9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA9E15539A;
	Thu, 19 Feb 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537549; cv=none; b=lgoeULTN1JTP+FXJP2papq8eS6TPsWBKopW15xncpiOkYQM+qaASIsgT3xFOmcxYLhXn2lGUeQwLdXnv4JIXwOwgIm8HRYHxvZd26NOWnHMFKrGXTRWtg6Ml4Mqs+uHVOoBMMFqUuhRecHb9Yk2L6uDNzEQSQ1bGXQYGlVYg0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537549; c=relaxed/simple;
	bh=ly3qBAXwjEhv+qeI0w00JXn+ZbeKzuvxdcn+WjKFB0w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BRh0VnTupoiNf8XJnwpID56zTyFKGN1mCvjaJJaqj4G+QZZd4kfzoK4VPr0MKDIfU7aZn5gZQ8NQmRfTkFWVFmqL7gp3zXs2hCmsQSGo3uVI4YZWiAsG8YqrBbtLuLyw6tpZ+pgra+eNWYcBtmd3+x7AaEruqwL+NPfo58k9N1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=I0cnulyW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYF/8y9Z; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA21F14000F3;
	Thu, 19 Feb 2026 16:45:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Feb 2026 16:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771537546; x=1771623946; bh=lM6k202zrI0eU9oty7kDeQMYg4/NxTHQwl4
	SflOk00U=; b=I0cnulyWNAZIF6IrlT4b4m4yRr/BYmbXLIsroJtCztSOJi3XGky
	fGlj22M2hnJMxpr3B3fU8UOWFsd8h3D8h8H/zwYNg0059YuENYmxoqK4gmAmyB9Y
	PQ35ZudKFk7KZUVgSlXCiztmjVXKoMH9b0xJJuu7rYZKLfoBUQ4o4VSx+bsXY/Ra
	oPZa2XGsPTqRX+xnbOd4tsiF3pTR6s/tv9/uQ84FOyRIFgYsh1kkcjbFHRGJYFPc
	XaHJ2TqpKjE4A3A1JUZCYsA061GdbzeJZMdR2WcFYI8ciO6Siv4GVfVHgqGztYnw
	QqWkW2GNX2OpXILDGVAd85cIHa1USArvong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771537546; x=
	1771623946; bh=lM6k202zrI0eU9oty7kDeQMYg4/NxTHQwl4SflOk00U=; b=D
	YF/8y9ZN616sV7XznnjNFyTVFYK1WIS9L39eM4bFbUTNXUJmcroIN6N3v5AtJIsb
	BkJ2O5JJfwYhrYuoXNLISVUxxdd/7rf3DqMZFlN7c3hcVb5oDc2HxHNgQnn+ik/8
	rBJQk5WzpzBzDJhORg1it+nVhbCNAK41HOhCAEdwQ5Q4jSvie94L3ZcpqkWC+Qog
	jomZG+UXZ3pJJuwmJc378lMRVcGWMHrCkkmJ/cznSg8Mn5k3RnufGloZV6zYpwAi
	VTmmhYzhBwunvCsK9XNcOqLuK6yrJJDeWKeRDjK32uQMkJF3nZIClk5piQZKxd5M
	J/VMw/Or9t8GyTUPFKm2w==
X-ME-Sender: <xms:ioSXaSxYEujFP8A-yLDa9UO9hFBTw1RR_nxavO9d7CIoHM7qGAEudw>
    <xme:ioSXaUSKmZTuoxuhEr9ss6vHJPumjE0PFk2lJdezEI3CfzW1ApjlgxG6Elz4b0Hys
    dhYLfF04YUuRG-iqDMhm4Qfzwm2NNIj2ncUQ7Me2sGgEC_fqg>
X-ME-Received: <xmr:ioSXafJfCTr7Y2BhdkGK-kCOFSD6N2OKc8NXTSStxBtP4xQrEWbmtHfNp_BVi5HDjfduDKWVy6QmGi0ext0hRw7AAQwjHUw8MbE3ugEiXI-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurheptgfgggfhvfevufgjfhffkfhr
    sehtqhertddttdejnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnh
    hmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffhfffkeegjeejtdffueekjeff
    feeljedtvdekveduuddtudeiieeuhefhheehnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmh
    grihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehshiiisghothdotdgvrgehuddtkegrudhfhehfsgegfhgttgdvugeksehshiii
    khgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtoheprghgrhhuvghnsggrsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehgfhhsvdeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    gsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshiiikhgrlhhlvghr
    qdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgtohhm
X-ME-Proxy: <xmx:ioSXabVWuzMljQtrK0f7VEYQp-msGrknKv_j6yvZjdZGXBZEaE4c3Q>
    <xmx:ioSXaTRLAcXaoKX9RMm9F_Ly48T5KO3nblbExThquf47UME5j1PniA>
    <xmx:ioSXaTBDhtlFnGVVFjSvBewbborAa_8KJKvNhsfJzOYVpXcX7cQL4g>
    <xmx:ioSXaSL_FcZ0l55PDLvqfnE9bPc5hwNDCyiNerEYNv9pZASi5ubnVg>
    <xmx:ioSXaYyhpsFOG_2284PyGcEsd7EKQeqAdu18mxifedb_BfbfkpIN4NnI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 16:45:43 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Cc: "syzbot" <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>,
 gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
In-reply-to: <20260219-kitzeln-vielmehr-22b6ce51bf5a@brauner>
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com>, <>,
 <20260217-fanshop-akteur-af571819f78b@brauner>,
 <177131956603.8396.12634282713089317@noble.neil.brown.name>,
 <177136673378.8396.7219915415554001211@noble.neil.brown.name>,
 <20260219-kitzeln-vielmehr-22b6ce51bf5a@brauner>
Date: Fri, 20 Feb 2026 08:45:40 +1100
Message-id: <177153754005.8396.8777398743501764194@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77743-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,syzkaller.appspot.com:url,storage.googleapis.com:url];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,0ea5108a1f5fb4fcc2d8];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: EBDDE162ED6
X-Rspamd-Action: no action


[gfs2 maintainer an list added  - Hi Andreas!]

On Thu, 19 Feb 2026, Christian Brauner wrote:
> On Wed, Feb 18, 2026 at 09:18:53AM +1100, NeilBrown wrote:
> > On Tue, 17 Feb 2026, NeilBrown wrote:
> > > On Tue, 17 Feb 2026, Christian Brauner wrote:
> > > > On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> > > > > Hello,
> > > > >=20
> > > > > syzbot found the following issue on:
> > > > >=20
> > > > > HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git:=
//git.k..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15331c0=
2580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac00553=
de86d6bf0
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ea5108a1=
f5fb4fcc2d8
> > > > > compiler:       Debian clang version 21.1.8 (++20251221033036+2078d=
a43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D146b2=
95a580000
> > > > >=20
> > > > > Downloadable assets:
> > > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71e9c/=
vmlinux-0f2acd31.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/b1864305=
8ceb/bzImage-0f2acd31.xz
> > > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/bbfe=
d09077d3/mount_1.gz
> > > > >   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=
=3D106b295a580000)
> > > > >=20
> > > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > > Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
> > > >=20
> > > > Neil, is this something you have time to look into?
> > >=20
> > > The reproducer appears to mount a gfs2 filesystem and mkdir 3
> > > directories:
> > >   ./file1
> > >   ./file1/file4
> > >   ./file1/file4/file7
> > >=20
> > > and somewhere in there it crashes because vfs_mkdir() returns a
> > > non-error dentry for which ->d_parent->d_inode is not locked and
> > > end_creating_path() tries to up_write().
> > >=20
> > > Presumably either ->d_parent has changed or the inode was unlocked?
> > >=20
> > > gfs2_mkdir() never returns a dentry, so it must be returning NULL.
> > >=20
> > > It's weird - but that is no surprise.
> > >=20
> > > I'll try building a kernel myself and see if the reproducer still fires.
> > > if so some printk tracing my reveal something.
> >=20
> > Unfortunately that didn't work out.
> > Using the provided vmlinux and root image and repro, and a syzkaller I
> > compiled from current git, I cannot trigger the crash.
> >=20
> > I'll have another look at the code but I don't hold out a lot of hope.
>=20
> There's at least a proper C repro now.
>=20

Yes - and with the new C repro I can trigger the bug.

The problem is in gfs2.  gfs2_create_inode() calls d_instantiate()
before unlock_new_inode().  This is bad.  d_instantiate_new() should be
used, which makes sure the two things happen in the correct order.

Key to understanding the problem is knowing that unlock_new_inode()
calls lockdep_annotate_inode_mutex_key() which (potentially) calls=20
  init_rwsem(&inode->i_rwsem);

So if anyone has locked the inode before unlock_new_inode() is called,
the lock is lost when i_rwsem is reinitialised.

The reproducer calls mkdir("a") and mkdir("a/b") concurrently from
separate threads.  The second mkdir() often fails (I assume) because "a"
cannot be found.  But if that second mkdir() runs just after gfs2 has
called d_instantiate(), then the lookup of "a" will succeed and so the
inode will be locked ready for mkdir..  Then the mkdir("a") completes
calling unlock_new_inode() which reinitialised i_rwsem.  When
mkdir("a/b") comes to lock the parent, it finds that it isn't locked any
more.

There is non-trivial code between the d_instantiate() call and the
unlock_new_inode() call which I do not understand.  So I will not
propose a patch.  I don't know if that code should be after
d_instantiate_new(), or before it.

So I'll leave that to Andreas.

Thanks,
NeilBrown

