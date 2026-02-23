Return-Path: <linux-fsdevel+bounces-77881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCgML1Wmm2kc4QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:59:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 333721710A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 269253024CA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032B27A133;
	Mon, 23 Feb 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WS36JgZL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YemWHJ7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1A26C385;
	Mon, 23 Feb 2026 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771808319; cv=none; b=BMow0rEE18O2xLaVo/2twiNVtmYCY6jgeWfAmmpSg9SFD72bq1IxrTeQWCPhhoiZrti2ANihUWmyTEWl3+oY3g/9IwsVgXe/2SU3X93MnvNEARswgxxl9voL9g/DsRa+TfXfOalrJKy5gCG5w3A8ouz1nnkcJeRhBTYXmjZjVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771808319; c=relaxed/simple;
	bh=VnIDXUeiqvEUVdn8NpXa5Ku9jPLSZoxCCB4i6Y+z0Fw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JdlexesLDrcijc6c1s3Ptw8bjzzZ3vUIMfuYMDjMpwTg0Fyp8bucpZJp8N+sC2qp1WaJDpIDld1nfcJ+xguPThO4jzOLVawGGdfAME/wWP6U1jtAmhPaesU0NRdKdNfxqAyCdd+ROqHgUz+eax80be/sOAelqSsrneYHwZaWIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WS36JgZL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YemWHJ7X; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id D387C138079F;
	Sun, 22 Feb 2026 19:58:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 22 Feb 2026 19:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771808316; x=1771815516; bh=DklJ7QaNzY60ouXBE3vQgD59/j0C7qR0HGo
	OpNRhNRE=; b=WS36JgZLzCNCvf7u83w8D1akUAwRHAGGPZOPYLwmAZtetVSEavh
	/M8aA+bnpsZY3MbOFx8Qk5u1xQW+1yTsGXfBEKmrLRLH7f44vPC5vuhAkwtLxWLd
	ViECmvy6XA+2YpMaEIWyIBI00/zRX1X0+4fqINg0ILv+ZLW4BPPAy7gOBT63f8kk
	vFUwZ33xzHDc9t+iBbt/IVLp9cYJ8hz3ux69CqjJD551O81BEB44sXpDf6fYZPRf
	C7+/KaZHPsZYkb7buH6/xLG61Bf2DfMo+ZM0A8XMGSzpYGyxeI9qdEn3W/AHOfiM
	XAoPgJ4BwUxA8xm5n0JfFaw+LIIdQaNST9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771808316; x=
	1771815516; bh=DklJ7QaNzY60ouXBE3vQgD59/j0C7qR0HGoOpNRhNRE=; b=Y
	emWHJ7X4KG9K7xx4srB5xchCIFGHRAKQswO67rUymDVKOY9IKyx0v+LnZXNSMER0
	j7iNxVaXpR/KLl1G1b4CCsUmBbghyYjBCAveRRz+qghTzfKL1VA5Oov7I7Xop/7n
	PweHe/k6XO1hS8xOnYMe2RcbZqorao//4m6zemr7Ik+mfLRaLt4Lajl0cdE6YKmS
	IDyoDz7a18U5Pf6jijhrpmAELV8HbFiHqX4cAsx9o1qO3rQZanDLhrlK6d3feWO3
	lGO7alOYhyqdifL71CIa6FJ/e+WROUJW827+jVrTjd1uGkmRT+Rx7QjtaC10uAXl
	RQ/m74qWowKUroX3xz6jA==
X-ME-Sender: <xms:OqabaQs3xGjeOu7AXcUNleF5_Y8iRBzijPW_ZaeUkYQqeg9Emhqolw>
    <xme:OqabaZD4NPOosHvf41NHVUW3Z3awp9auUwVA_XupvQ5p3vVninFP4qmPAMXIiDS58
    TLwJuL0gQcRPfbjhsZaAlRwRFZzUkQHJJl0Rtvser53x7FoRw>
X-ME-Received: <xmr:OqababzRmffLRzqdvW2p80u8-uEnrmftH0zXIK9cBSm0y9V4lswgcCUqslNuPjtI5T84LYpY1RfNF9WhgYlJ6BbqKcNswQO5ogy4UiWsiGAy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OqabaYIojgLIp2j8qPFkfsns7llliXUf95aJkPdy-HRC_hWJtOfffw>
    <xmx:O6abaS4c8DrJ0klm8azSCh0JAdPfi6zGgDwVJTJgUElF-nSPAf4FrA>
    <xmx:O6abaXkjmLxkwBpheH-MiJTvcuS5e8O8wfGIHRHvVW80qHpe6ZgQXQ>
    <xmx:O6abacIpejrj6FmGLnsy0_hswmNu0CibhEG46r9c4nUZCK0MVZXjhA>
    <xmx:PKabaVUBny8QxSSIbfK1LvZkUX2fxVVzGlpN_ICcTX_0cB6WcVMy3PoG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 19:58:29 -0500 (EST)
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
 <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-6-neilb@ownmail.net>,
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>,
 <177171292163.8396.10671162503209732019@noble.neil.brown.name>,
 <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
Date: Mon, 23 Feb 2026 11:58:26 +1100
Message-id: <177180830631.8396.10805264856218061422@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77881-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:email,ownmail.net:dkim,brown.name:replyto,brown.name:email,noble.neil.brown.name:mid,paul-moore.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 333721710A3
X-Rspamd-Action: no action

On Mon, 23 Feb 2026, Paul Moore wrote:
> On Sat, Feb 21, 2026 at 5:28 PM NeilBrown <neilb@ownmail.net> wrote:
> > On Sat, 21 Feb 2026, Paul Moore wrote:
> > > On Wed, Feb 4, 2026 at 12:08 AM NeilBrown <neilb@ownmail.net> wrote:
> > > >
> > > > From: NeilBrown <neil@brown.name>
> > > >
> > > > Instead of explicitly locking the parent and performing a lookup in
> > > > selinux, use simple_start_creating(), and then use
> > > > simple_done_creating() to unlock.
> > > >
> > > > This extends the region that the directory is locked for, and also
> > > > performs a lookup.
> > > > The lock extension is of no real consequence.
> > > > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > > > d_make_persistent() is called the dentry will already be hashed.
> > > > d_make_persistent() handles this case.
> > > >
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > ---
> > > >  security/selinux/selinuxfs.c | 15 +++++++--------
> > > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > >
> > > Unless I'm missing something, there is no reason why I couldn't take
> > > just this patch into the SELinux tree once the merge window closes,
> > > yes?
> >
> > Yes - but ...
> >
> > Once this series lands (hopefully soon - I will resend after -rc1 is
> > out) I have another batch which depends on the new start_creating etc
> > API being used everywhere ...
> 
> Okay, thanks for letting me know.  I was curious about something like
> that based on the cover letter, but the timing wasn't clear.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thank!

NeilBrown

