Return-Path: <linux-fsdevel+bounces-77867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBynIbgxmmkYZgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 23:29:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ECD16E227
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D2430363B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A4836606E;
	Sat, 21 Feb 2026 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dXKMwkzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MW+TZctE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37F246BC5;
	Sat, 21 Feb 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771712936; cv=none; b=qf0eCFyHas/GE0db9raGDfoNPkGROS6ymYTqIePwYed/JZSvaYLfB2R37eC2VcTabzZEjB6LEEHhI8+kEoOlNCuZJWP6VPb8299xdY31nTbT5WGrlwkYETblOc0YuUdCmhZtE8+5l3KQ+wEEGATYrmtWG0nQWsYCkycmU9cEq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771712936; c=relaxed/simple;
	bh=VmoxDVAEk5VXcBT9Zk5C9BENYgHbrkKa+9YXbPNT3FQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aQ2RMkg/c7FSLrvLwqB7lOHYAphN4w1rZMF2hwyzOaeCZWHh6MMaNkauaPDz0iW+RqRkOdiipi55gMZoDFYpB7f5M/2syASwH5beL1EQznSFuy2RIoig/dwUDYNhpn8h750cWBoQDBWLzUElAkPwKMaR0vXYzFWn9sczSZ6SmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dXKMwkzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MW+TZctE; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 3048B1300B3C;
	Sat, 21 Feb 2026 17:28:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 21 Feb 2026 17:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771712930; x=1771720130; bh=u3IlZMQ9LJJjVeIG+OSF9uldPDxrJqlL/6T
	gOp7A6+M=; b=dXKMwkzgQvxdsO2+qDRd6JurM9O9n4YdVnuSxRcxiuHonOiWZku
	FN7bhs97x56nqC9Y/S+8JqD/7Z8hlvaZXOyYgCHOcFyqug+rIFqmetWCflqclEBX
	U3HKWGPO5h32qy3xhXThzfQv5Qmvjk6sqQ+l2bYFmOzkaHZseVOmMnA9GUYHvI5u
	dyLtpcEDbuy4rYC6EVLJUsFP6wKBC/unpIOYnIm809wqjJaMeOlBNZQ7ZLdyeXSJ
	zJVmPn4At3FpSqhrlnTbNumO+HI91+IPb8Ui65SSUPz4XAXz3srUrhFyIFXkftjB
	V13ML1s5ViszfmYutdJ3cdB/gMvqPZHi1+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771712930; x=
	1771720130; bh=u3IlZMQ9LJJjVeIG+OSF9uldPDxrJqlL/6TgOp7A6+M=; b=M
	W+TZctEkN64dRsKnUJ2lljeCcZA4454y4+Irt1eRk/5VOjqCZsAHyuTLGuN0j4oz
	RcWblC+Ipj0ocCW/fTrtDQe6nq3uxKn87vMUc0K0sQm3zyJQJb2srNnidc29149z
	1PsDnHmx1yay8c+cAf1zDvPxQfH1qO0Dxl4lIxeW5silcgAuDwW5ap/V/MhJmgtk
	LL8Q7nWAYhFOEPjoV9/eRAdNg2q/FCLoc5qdawWaTj0gr/Ju48lXLuOtgF3e0WCl
	yXzRsJnqT7BKx5Gclt/4NAYlR2bMeFWL+d0Qxfgugrv2cxEhOfXqleO/AYs8PoIA
	V5QD5ACw97tmr+ygXvQoQ==
X-ME-Sender: <xms:oTGaafTZIgFHrwcqEwX0OWhBiyLoiJ7dh8xpTjlhz4aVlN8Lifs3gw>
    <xme:oTGaacWrqRZ151uqCE_3yKT7CzRx7-cpPPsr0nje5pxFMek-3d3N1u3UCJR2JXj5Z
    VqoJaAKyhmwGiy2Qw_yOJCKxytL1944pcSZQPcOYlPLanr7lw>
X-ME-Received: <xmr:oTGaaU29JxR2PccULCpDzVvNImiuBdIko2ImjSRi3u1tEZkku4wBZzbrg6PUMXFkWs2eoVfDh9PrXfG2LUhKU37w2GZxxzKchJJERpDvIc4y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdfhgfehkeekiedtleefhefhkeevvdegfffhgfduffeiveelffehlefhfeehveetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:oTGaaT-7S5TVfbgkA8pNolMe7t1LSNSmFnMs810TBs_8phCNTbtsfg>
    <xmx:oTGaaadkucZtu9j60AveUDWw1P1FsB1XpKkjA4cAbMhsgWu1zJ8hPg>
    <xmx:oTGaaf609NUb58_R29zQiJvEZktz-GpoZRxvyTKJ7AZOdVpdq9KhQQ>
    <xmx:oTGaaWOdPa7ew4My6ZRBV7ztWMi1j-Vg8G-HHDF9COUMqv_h8H1j6g>
    <xmx:ojGaaZZXxAWMUvbEvJlBxCZvbsP49ApNcz7t6xV9_SRXC0fKsuJNSiW3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 17:28:43 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Paul Moore" <paul@paul-moore.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() /
 simple_done_creating()
In-reply-to:
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-6-neilb@ownmail.net>,
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
Date: Sun, 22 Feb 2026 09:28:41 +1100
Message-id: <177171292163.8396.10671162503209732019@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77867-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:email,ownmail.net:dkim,messagingengine.com:dkim,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: E6ECD16E227
X-Rspamd-Action: no action

On Sat, 21 Feb 2026, Paul Moore wrote:
> On Wed, Feb 4, 2026 at 12:08 AM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > Instead of explicitly locking the parent and performing a lookup in
> > selinux, use simple_start_creating(), and then use
> > simple_done_creating() to unlock.
> >
> > This extends the region that the directory is locked for, and also
> > performs a lookup.
> > The lock extension is of no real consequence.
> > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > d_make_persistent() is called the dentry will already be hashed.
> > d_make_persistent() handles this case.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  security/selinux/selinuxfs.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> Unless I'm missing something, there is no reason why I couldn't take
> just this patch into the SELinux tree once the merge window closes,
> yes?

Yes - but ...

Once this series lands (hopefully soon - I will resend after -rc1 is
out) I have another batch which depends on the new start_creating etc
API being used everywhere.  So for Christian to be able to apply that,
he will need to pull in this patch from the SELinux tree.

So if you could apply just this patch to some branch and merge that
branch with your other work however works best for you, and make the
branch available, then I think Christian will be happy to merge that
with whatever vfs branch he includes my work in, and all should be good.

Thanks
NeilBrown


> 
> -- 
> paul-moore.com
> 


