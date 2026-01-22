Return-Path: <linux-fsdevel+bounces-75143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ0RFftzcmlpkwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:01:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7246CD6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B187300729F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD338A736;
	Thu, 22 Jan 2026 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8NbMbCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B438B7AC;
	Thu, 22 Jan 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108299; cv=none; b=Wgyyb4S+82Ez61+tEskQxH+m6ombY6i/NLu2hZ4nugemoqE4aznMABBQNZZidZdE7JtESj616N4Fexa3GBcye/QVF5Uwyu3ZvWhTXK4uhIRGe0OWxaOIQAvoehQlJdCvEoGl6jjRviZUjF1zHpNR1mUVTZl2s7WNVCK1QR8QMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108299; c=relaxed/simple;
	bh=fsHYCsz0AqK20kV+evW892XImnLexNX1R1Ca1+lHDZI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LyWr2hXK21QTRvdfaE4rD600W+WhhYEOmyDZcrvvzqYwaSx2OIi46wntLxIc7kXW3huLx535CE9ch2fLDhSW1qS36gduH0HYfZk3lOUUnfNfCeLuekyaYm8n1YE5Na17Fn4s9sjDeHiC++24dy0atIw8XDFXMd2Ver3ZUhJG9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8NbMbCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5771CC116D0;
	Thu, 22 Jan 2026 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108297;
	bh=fsHYCsz0AqK20kV+evW892XImnLexNX1R1Ca1+lHDZI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=P8NbMbCPa1ZzZBEzJG5VKtjzkc5ovVh7S9bkpB6CF1v10Dazp1nZZ4sAOm4UU52iI
	 agAWmAkqiBphb8g1+WipA0CT2VRcQzzg7lQEwu/kxSKHWW66AVy7aa8yn1Kjg4LXte
	 N7l3TPW7uMlfq9ynfCYwD2IQZROgp7Y7dfQKKqFibw5Pbn2tySiN0WjCscTA9hs4d6
	 Mg2GU0X+1GNdhYBTVwmQjS+kbtZPBIFH0NuhjJMwqHwjswxSldatmexB9v0liPyVok
	 xmLzEj3WZWc6XLOA0gI5bKZ32i3QsbFyK1a6fws87c5HmgnOtjXp6wTblupMQAkxeS
	 cK9zRWqjvo8zQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6944CF40069;
	Thu, 22 Jan 2026 13:58:16 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 13:58:16 -0500
X-ME-Sender: <xms:SHNyaX1Ry1kpKKU-n0AM5WslogkXnhHPiS_BcOOcliDwMmJodndo4g>
    <xme:SHNyaQ7Ukkd2ch__zCqgYBqkQSSQfL96Q0xonDDcUsUQKOVpPC7yA0w6jZCRIPSLk
    konLyalt6RQB6kVvEJPzcTDP95cq5cPSR4C7iEqIzYygLMaS9dRuJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtph
    htthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SHNyae9YxjA0PDhp-hGgC4s-iPGRHvFUF7rB76UChDZnVmMJU1U1FA>
    <xmx:SHNyaagC4PM5jC-nOhEIq4fqzNqQUDZKME--TPbtwF03nq7E2qp69A>
    <xmx:SHNyafZK9QNa5RKqR27o9L2kv7lNPzD5_WNZypt41hW5Liv99noPZg>
    <xmx:SHNyaf8rQLJL6tVlKRbBKL-hN4I7pP72VPgc1r7ZBr5HxP0Zos1SZw>
    <xmx:SHNyaRNseIRZGqP-Klt6EPje6jJbhZgmxggXzeeObeG5hO_dnf66rrL_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 42DAA780075; Thu, 22 Jan 2026 13:58:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQfmcLLK3ACR
Date: Thu, 22 Jan 2026 13:57:53 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <7bfa1642-d0b1-41aa-9709-86bb51669464@app.fastmail.com>
In-Reply-To: <29da00c72005812ca83954e8f2af91248b5bffe4.camel@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <7202a379d564fc1be6d2bfbf4da85c40418d9b07.1769026777.git.bcodding@hammerspace.com>
 <801018d9115ea8abb214eaa74d5000c6f7f758a4.camel@kernel.org>
 <0597653E-1984-4D2B-9A47-9BAE3A8E7A8B@hammerspace.com>
 <29da00c72005812ca83954e8f2af91248b5bffe4.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] NFSD/export: Add sign_fh export option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid,hammerspace.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75143-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B7246CD6A
X-Rspamd-Action: no action



On Thu, Jan 22, 2026, at 11:50 AM, Jeff Layton wrote:
> On Thu, 2026-01-22 at 11:31 -0500, Benjamin Coddington wrote:
>> On 22 Jan 2026, at 11:02, Jeff Layton wrote:
>> 
>> > On Wed, 2026-01-21 at 15:24 -0500, Benjamin Coddington wrote:
>> > > In order to signal that filehandles on this export should be signed, add a
>> > > "sign_fh" export option.  Filehandle signing can help the server defend
>> > > against certain filehandle guessing attacks.
>> > > 
>> > > Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
>> > > NFSD uses this signal to append a MAC onto filehandles for that export.
>> > > 
>> > > While we're in here, tidy a few stray expflags to more closely align to the
>> > > export flag order.
>> > > 
>> > > Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
>> > > Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> > > ---
>> > >  fs/nfsd/export.c                 | 5 +++--
>> > >  include/uapi/linux/nfsd/export.h | 4 ++--
>> > >  2 files changed, 5 insertions(+), 4 deletions(-)
>> > > 
>> > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> > > index 2a1499f2ad19..19c7a91c5373 100644
>> > > --- a/fs/nfsd/export.c
>> > > +++ b/fs/nfsd/export.c
>> > > @@ -1349,13 +1349,14 @@ static struct flags {
>> > >  	{ NFSEXP_ASYNC, {"async", "sync"}},
>> > >  	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
>> > >  	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
>> > > +	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>> > > +	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
>> > >  	{ NFSEXP_NOHIDE, {"nohide", ""}},
>> > > -	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>> > >  	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
>> > >  	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
>> > > +	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>> > >  	{ NFSEXP_V4ROOT, {"v4root", ""}},
>> > >  	{ NFSEXP_PNFS, {"pnfs", ""}},
>> > > -	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>> > >  	{ 0, {"", ""}}
>> > >  };
>> > > 
>> > > diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
>> > > index a73ca3703abb..de647cf166c3 100644
>> > > --- a/include/uapi/linux/nfsd/export.h
>> > > +++ b/include/uapi/linux/nfsd/export.h
>> > > @@ -34,7 +34,7 @@
>> > >  #define NFSEXP_GATHERED_WRITES	0x0020
>> > >  #define NFSEXP_NOREADDIRPLUS    0x0040
>> > >  #define NFSEXP_SECURITY_LABEL	0x0080
>> > > -/* 0x100 currently unused */
>> > > +#define NFSEXP_SIGN_FH		0x0100
>> > >  #define NFSEXP_NOHIDE		0x0200
>> > >  #define NFSEXP_NOSUBTREECHECK	0x0400
>> > >  #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
>> > > @@ -55,7 +55,7 @@
>> > >  #define NFSEXP_PNFS		0x20000
>> > > 
>> > >  /* All flags that we claim to support.  (Note we don't support NOACL.) */
>> > > -#define NFSEXP_ALLFLAGS		0x3FEFF
>> > > +#define NFSEXP_ALLFLAGS		0x3FFFF
>> > > 
>> > >  /* The flags that may vary depending on security flavor: */
>> > >  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>> > 
>> > One thing that needs to be understood and documented is how things will
>> > behave when this flag changes. For instance:
>> > 
>> > Support we start with sign_fh enabled, and client gets a signed
>> > filehandle. The server then reboots and the export options change such
>> > that sign_fh is disabled. What happens when the client tries to present
>> > that fh to the server? Does it ignore the signature (since sign_fh is
>> > now disabled), or does it reject the filehandle because it's not
>> > expecting a signature?
>> 
>> That's great question - right now it will first look up the export, see that
>> NFSEXP_SIGN_FH is not set, then bypass verifying (and truncating) the MAC
>> from the end of the filehadle before sending the filehandle off to exportfs
>> - the end result will be will be -ESTALE.
>> 
>> Would it be a good idea to allow the server to see that the filehandle has
>> FH_AT_MAC set, and just trim off the MAC without verifying it?  That would
>> allow the signed fh to still function on that export.
>> 
>> Might need to audit the cases where fh_match() is used in that case, or make
>> fh_match() signed-aware.  I'm less familiar with those cases, but I can look
>> into them.
>> 
>
> No, I think -ESTALE is fine in this situation.

I agree that NFS[34]ERR_STALE is the correct server response when
a client presents a file handle that does not pass the configured
security policy (ie, unsigned when NFSD wants signed, signed when
NFSD doesn't, or MAC that does not match the FH).


> I don't think we need to
> go to any great lengths to make this scenario actually work. We just
> need to understand what happens if it does, and make sure that it's
> documented.

The documentation for "changing from signed to unsigned and back"
goes along with what happens when the fh_key needs to change, I
would think.

And, IMHO we also want to craft some pynfs tests to ensure that
these cases work as we expect, and to ensure that we capture all
of the cases that need to be checked (including the cases involving
transitioning from sign_fh to not sign_fh and vice versa).

Basically, exploring the corner cases to look for regressions.

I've had good luck constructing such unit tests with Claude Code,
fwiw.


-- 
Chuck Lever

