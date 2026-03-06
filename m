Return-Path: <linux-fsdevel+bounces-79668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFBQGm5Dq2nJbgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 22:13:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A00227C3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69A8A301DD0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF34481FB4;
	Fri,  6 Mar 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HlxTIAze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ta2Ad3ig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD0377029;
	Fri,  6 Mar 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831584; cv=none; b=XFnUoSWXPP6kRf5qKtlTyzjCEQTi7AelXL3KiIFeVG1SpxpwL+A34cRVQU78YnFdNBOX5dR92AVyRvn62896TdBAo8SHif4QRaIoLJAHf3VwaCmfXwav05SJ6OM2uDpt0I6RWJKzMxVzC2WX1M6rBX7hjYYGbHpD3mlJX69H9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831584; c=relaxed/simple;
	bh=kjmPUaFdMQaOpT6T4pJliZ8LP9HIoceT2uUfixiPc3o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=shUYbSHEOmZaN1kznJyVT2vnHxZa3fsU5/m6T95SiD2Fn7kq0q4l9+ILnIJeJlxahlpChtscmObA2ehBfR0u1V5I5QqZ04yF6dfFnWsEiBwt5Cbg0mjj5f21jp15C/ZgmwviFjxyaq+PWvgiGfXTqWjH1NVXJyy5oVV8/AA/T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HlxTIAze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ta2Ad3ig; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 079EF1380802;
	Fri,  6 Mar 2026 16:13:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Mar 2026 16:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772831582; x=1772838782; bh=SUz8M1egzctlh1WXyoTdVp/oTcO7/zgWIgK
	98brzsm4=; b=HlxTIAzeLS2uNNVP+RhNxfBe+oZpDrCU4n70ZiojrnYqFeFbIM7
	uAz2lCKYh1dAymJFvhnBTsBgyEt+dmuY41WMv8rp7n0lDXIt+7r4NxFcn/tPz833
	QG0yH8lHIFYL3mhBfIAy72GQlEO33gH0pjqlR2D8mgBti69354Pp7B73Vmw7XWa4
	Zp3LdOKao48M2COj5V5ffdNHBKxXnvMUZvcgMdb/c6nZkA8hDiwy9DnqsJnoIf9a
	HgRT5JB6VIqIUWVEMIJblkbADV7CLltVMf0e22zae31NU0zlq6RsTdMH1XEszwMK
	3rcPPF2t0dgeYbG4mxDdStPempiEi0PLn5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772831582; x=
	1772838782; bh=SUz8M1egzctlh1WXyoTdVp/oTcO7/zgWIgK98brzsm4=; b=T
	a2Ad3ig3nQaJ45wPtCUpa0DzgXbM3NSNcxG/j9dA2aOzd1ybn6RvWA3lhj6rdaK2
	ilp9E6GRTPZDvfarKILUN341YIMkCy5f2ASgf49qPW1Uw7YVoF6GtOjW7tTOr0sl
	us7U4Ekty5uwdZAcvFe0uW8FT0EX8dqJgmhvgjOusmrlz9RVpzOL8vB8QuJTzi13
	bDBlokf2tdXv9RCgVUvSz33n8s1N489VTANDALSXFaT1amXae1LMlh17bhePcsSV
	Vq2/x9zwasamvDKfLWEWq97XQPXuZUJfYv1bICYbcCLlJqpgwKYCpSy1NgFLoMma
	y2zapZ3xdmM7S+DTAS8GQ==
X-ME-Sender: <xms:XUOraZKmAHFhOFLXtoq1DnCXSe4kN_oyU5asJsD7r8s_WLkFo5yLtg>
    <xme:XUOraZFfsKsS5Bm-1qYg7nTzBwR__oF37VwH6npkTm08xdxkcSrEbzrDvJpbEB8i7
    2ztHcrpTcfe-f4DImJcbPTyRoYb8eqMyqcazsUQWIrmGlP3Zg>
X-ME-Received: <xmr:XUOraaM2XrAU1gJY5t1PIsX89jcVHFJfEXO_Ok2AbUIhVYVbw_bctxxLSQH8UBSb6Qzje2l_AcE3nQ4pDhuO_XKgOjpMqFxfx0_KrO6tJKxt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:XUOraT_GU-eRpH9KjbQUxaeFH3Ik-X2YnIknIPEpYLe3LAAFu5cuMg>
    <xmx:XUOraX5VpPUBfROPEJ8o3FBE6KmlXfSQKgogNn2tecZhXCtQc5cxEA>
    <xmx:XUOraYWsOE9k6kp7pvWeY0jS8GZtsY7Dxvg3Yw3BK7Mbj8qd82IZvg>
    <xmx:XUOradIYrlYpCmTlBrPeFiMRjUCjvZcXllQ0Dos_cDuzwpR0fIUA1Q>
    <xmx:XkOraXAuoiNIIXbw0nIirtgzAtoSS2j1NQ5_WUd18Tl9iwt-WLLSABX7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:12:55 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Subject: Re: [PATCH v3 05/15] Apparmor: Use simple_start_creating() /
 simple_done_creating()
In-reply-to: <20260306-fastnacht-kernig-3b350bd2fab0@brauner>
References: <20260224222542.3458677-1-neilb@ownmail.net>,
 <20260224222542.3458677-6-neilb@ownmail.net>,
 <20260306-fastnacht-kernig-3b350bd2fab0@brauner>
Date: Sat, 07 Mar 2026 08:12:50 +1100
Message-id: <177283157032.7472.10017547355182129224@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 65A00227C3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79668-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,kernel.org,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,noble.neil.brown.name:mid,messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 06 Mar 2026, Christian Brauner wrote:
> On Wed, Feb 25, 2026 at 09:16:50AM +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > Instead of explicitly locking the parent and performing a look up in
> > apparmor, use simple_start_creating(), and then simple_done_creating()
> > to unlock and drop the dentry.
> > 
> > This removes the need to check for an existing entry (as
> > simple_start_creating() acts like an exclusive create and can return
> > -EEXIST), simplifies error paths, and keeps dir locking code
> > centralised.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> 
> Fwiw, I think this fixes a reference count leak:
> 
> The old aafs_create returned dentries with refcount=2 (one from
> lookup_noperm, one from dget in __aafs_setup_d_inode). The cleanup path
> aafs_remove puts one reference leaving one reference that didn't get
> cleaned up.
> 
> After your changes this is now correct as simple_done_creating() puts
> the lookup reference.
> 

Yes, I think you are correct.  I remember reviewing how ->dents was used
to confirm that the new refcounting was correct.  I didn't notice at the
time that the old was wrong.

Thanks,
NeilBrown

