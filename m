Return-Path: <linux-fsdevel+bounces-76513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFj1Kl5OhWn5/gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:13:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11FF9288
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D6D83023506
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF86251795;
	Fri,  6 Feb 2026 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gnx2XQOX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5qpou8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A901238D54;
	Fri,  6 Feb 2026 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344006; cv=none; b=EPUNV8cqKqAGU3aDv9Fv1zMsRN7uBERviTHaeufMw3Sk80g6WCJ5MabEH+XqGVuX2gGwTFrmY8vjnxwEPzF8AHy/ETZdBiBRzaRgtRokl1mwMc8tdjQKl4sjqRoAq17eITbq3d9urxo9S/olbsQeydczbQoYW+0iwkh6d63KSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344006; c=relaxed/simple;
	bh=o8vroWr2BcKgsRmuliVXOCemTQ+rVnlHXdmXNHMd83w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=twJMVAHHWpm7N1gIabo9dWXLVhUlODVRLrv1HlSJSpp4txN1zKVG1S7yQLUtni+v6zJP0BJXw3ruweM3vZ0UeLKKSj11CZWihRwFnfJl+vK2qAXXb5Q9IsPM38weoil7tRSLQxFcMxJ2AKoV1AlAVwwc15AQW5DE6bd8va04C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gnx2XQOX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5qpou8z; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 9F2031380A31;
	Thu,  5 Feb 2026 21:13:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 21:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1770344005; x=1770351205; bh=Der/iBPz0bTAQUrlq6AggVf+YeGtgy0yYRy
	VCtjT39s=; b=gnx2XQOXx3FWpUVdJtFMUJc0wa/drpccuhBehgg6EDAAdpuB7WN
	P7tbOc2DW2OmsOy1yLdrH0G3FUdlcqaVtqhn/I4SyHOUNUEwa5ItaTdvTW3kG/vz
	gsJ8vQJT5k5rAGnicKq7gfF0psrYi/t7emVgJCs12citQ3qC32hg1inln0NFyfGR
	EQyiDaljWjjrKsj8JVIxL3W6ABLwPwo681gX3DIkhPVbUqR1I48vEO44037tlklc
	PTls3r2Ifdo4VYOMVmVzp9GT6nN5miqiF6MRzexJVQ0Gzxn7uz7a3oEZL+ueRa4x
	lLsJDXFYypQ502WLzNd0th0zu6b3BMEX6tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770344005; x=
	1770351205; bh=Der/iBPz0bTAQUrlq6AggVf+YeGtgy0yYRyVCtjT39s=; b=a
	5qpou8za+to0Pc5x5+DqWPyj2/p6RAlzAeQrnp+DiZ6Xii8WXUa/73culdncsa8u
	CrCe1x+xZ9ZlBYyKP74s/fdhkpziwSoPjPkKzGJnR36hdAB7mKW8d4t0j5GrDoa9
	aO6f4gZsYnSKx2H6tYshBDal90FLo+PaBrHHkEBFwnRoN96b7B5lxXM4B487H9b7
	8/y2rHogNRwbyjjmz9N9i0B43CcG+sD9T+ObV2GWZxkL9tBA6DMqDha/x+c9fLj3
	v7qnVU4hY6pCUjipvsxWbYv/1aHnIO/0ByrO68NAuSbPy9rSAU9Z04PL3kiEl9k7
	VPBsG77erltlEtN1/x/zQ==
X-ME-Sender: <xms:RE6FaeKNVFsteuxAUkvtyFuCENf7kE9iXUBEReSZUnY--ClX0rxTYw>
    <xme:RE6FaRsc42jKTPIvbiDFp3QDAR7RWAFR3sJcfBTFokh9MniNs3qp9__kf2-oMTE4G
    mIv4n09q8J_2fTnLoYexaIrBWSdjtp7Hn8ofLD8vShz0NRjoqk>
X-ME-Received: <xmr:RE6FaevV0dRzkEv2wFyjw3sZHxjl4D4IPZmRjjd8IbEVTWu_oRIpperSAVDtO54iGhVrFTd9kQp35ulk2cztl3XYiOVYpY6Ky4Ds5MsBrp1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
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
X-ME-Proxy: <xmx:RE6FaYUqfiTVjjc7uwD6Khuvzq1MbTs-uagr7sQG5pRzMrabxb3N9w>
    <xmx:RE6FaXWps8SOb03BNmdBtieIicQx0iChTDZxTPLB5iUe8ssHFqk0fw>
    <xmx:RE6FabQUPeUtbog8Fjomd9qRAGywmOmFd2-rhHdJ-UfbrEtzF9T6aA>
    <xmx:RE6FaeHh00XhYvRBT-OUwFZOuUYaUwQrvjdY5duX25DzeUveJeJNLA>
    <xmx:RU6FaXNgedOJkBgZWdDwnTA47kNbV-41uUKDbG4vGUQlusLf99f3Le7f>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 21:13:18 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject:
 Re: [PATCH 03/13] libfs: change simple_done_creating() to use end_creating()
In-reply-to: <8d907c67ccab1db0e7bcabe0c34c66722a2970e2.camel@kernel.org>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-4-neilb@ownmail.net>,
 <8d907c67ccab1db0e7bcabe0c34c66722a2970e2.camel@kernel.org>
Date: Fri, 06 Feb 2026 13:13:16 +1100
Message-id: <177034399605.16766.3111281029834170576@noble.neil.brown.name>
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
	TAGGED_FROM(0.00)[bounces-76513-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,noble.neil.brown.name:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2C11FF9288
X-Rspamd-Action: no action

On Thu, 05 Feb 2026, Jeff Layton wrote:
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > simple_done_creating() and end_creating() are identical.
> > So change the former to use the latter.  This further centralises
> > unlocking of directories.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/libfs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index f1860dff86f2..db18b53fc189 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -2318,7 +2318,6 @@ EXPORT_SYMBOL(simple_start_creating);
> >  /* parent must have been held exclusive since simple_start_creating() */
> >  void simple_done_creating(struct dentry *child)
> >  {
> > -	inode_unlock(child->d_parent->d_inode);
> > -	dput(child);
> > +	end_creating(child);
> >  }
> >  EXPORT_SYMBOL(simple_done_creating);
> 
> nit: seems like it would be better to turn this into a static inline

True ... but then it could have been a static inline anyway.
I'd rather not change it without good reason, or knowing what it was
written that way.

Al: do you have an opinion on this?

Thanks,
NeilBrown

