Return-Path: <linux-fsdevel+bounces-79012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD2TFYr+pWlQIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:18:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F51E24DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8FD9310343C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C273039EF09;
	Mon,  2 Mar 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="L7QnXmiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVWxKl3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A347F2D9;
	Mon,  2 Mar 2026 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483795; cv=none; b=iWLMQ6t2hvL7YG1KEzI8pxM3hWvzYvQb1GxGz7L0rQg4NeMYBnulTvfEXdi0WrAXSwtJ5WCyWGCrOjVUTL6L1suwxPijiC/rF2kEZw0CxCmY6HzNIQvU4EcYLt5Zf3l9sOkPb0Bje6eutzQ8ozI4FdpY+XYn4JVDB7ozyPjXcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483795; c=relaxed/simple;
	bh=J7/2BNuAN4/DWqzrCu2kELA+yh2SM2uMKF+SP0x+Nd8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=A/zU8nrlDMytZvajpL0zB7cPgN+CXv92/nfryfDxbNY/qfhudadW7CY93xk72mmP/r+2NVX/Rb6koDPZztImWE7CP+mwV0ECPlknCIBphg2qNbXKZmfZffAtdWA7zmSUmLKILVpWci5UejW2pX4sOa2FONSbQiCs2tAThMEptUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=L7QnXmiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVWxKl3F; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FE7414001A4;
	Mon,  2 Mar 2026 15:36:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 15:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772483793; x=1772570193; bh=fRNC5aXwSlKt2ngGY9zMRfijNZ//ln2/jzE
	uxRtWesg=; b=L7QnXmiMfrU9iCeZwBpoqaGs15Mr0pnz4ubzb7J3UijrTZTzSbL
	+GMTOeHPWzHeGOjbG4zSvshOKROyoekUX3B4x7rJiYrKwsxZrXmgWHAXMERe5e2p
	FHDnohUVy7z0AnPkaKiz5CzRLaudyae7/fQqfQDuqi8+3E/QTNBGV+q50vOxmLKD
	DjqZCH7YB4tS02o8V1aeefG16K8+xtjYXMTCVuuOdrz4QBV+uJJ+zAyPSaoZ9WnZ
	sXi8qfnXN02kFZaKtn7sOiCmzbywiJyju5x/SblANP9OEcuPdmKgWu3Mg6ci36Ga
	YaI81OITZCxmg4H6PiM7Xbe3zQo3HExf0cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772483793; x=
	1772570193; bh=fRNC5aXwSlKt2ngGY9zMRfijNZ//ln2/jzEuxRtWesg=; b=V
	VWxKl3F3Y/p0YSoA3x5j2Lnqj0XEcutigr21Ik5lEbb1PYMrzBwKnHxgrS/QCk2j
	BggdAkHRO8QhvwqYOnqBp762RPtdE7oh1P0BdARSTDcQMRaYDyjebFB/aElPmgTf
	xuS9+WponEXMG7FtYyeUM+OIXHfrr9neyKbo3zTekmLczMC8jDXmQRpsnze/U3R/
	0nLZPvZcqCk5CE4AtxzdS3IGu1CSB63/xYaTi3f2TFGGV1lBEC10O/yTazn7oXLA
	IhS0XfHHrBXn4zvqBc39NPKoanQbuLxHe5vpm99fMaEjQzcu7BqM6A/0MOCpNytL
	B+wy3F6rbagMbxxBbefYg==
X-ME-Sender: <xms:0fSlaQ8RzPey8qqLQtuW98q06TMdWFyQHna4H3S2Fuvv0lrRy3kkIQ>
    <xme:0fSlaW9Dg_fDmwzSMivsa1uVjyLD671jw-g-dfPDRHUs3QZjBunNn_GWiYT14sgKJ
    iCbPFlWigWhNK4WOYgNtR1hAORy-EJu_IhAIis0Vtr7Vyshni0>
X-ME-Received: <xmr:0fSlafWzG7WeTcQwNB7wz86y56vBmH21fBpvFar80SXz2d-fz_KLOMAOsw65QSHVUQ-MfzuYnVLoFVhKzC4KdN2sUShI5K4ltZoIpV0oeF0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdfhgfehkeekiedtleefhefhkeevvdegfffhgfduffeiveelffehlefhfeehveetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopehjrggtkhesshhushgvrdgtohhmpdhrtghp
    thhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0fSlaTeQOlPrJkhFc-EVZ1U6z-_eT_Cj9qluDLQOsIfWVWdEiwk-fQ>
    <xmx:0fSlaYbs_4EKvLeUNjmdq_q9Kf5MXt39gHpP6D7Im7M7iTSgveHaSA>
    <xmx:0fSlafODMUU8PK-8Y7ZMUxVlk5Z7SkrD5awhy9WxsCDWGhW3bIEKbw>
    <xmx:0fSlaeW59hgAhbujlaWfyM2HDiZ99peOAHRxUK7kPqMx4sB-UgG0jQ>
    <xmx:0fSladsB9UWBiiLY5kmRKpgrkD2D8glyTX4CAKM6FFR8sZsA-dazCLEo>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 15:36:29 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
In-reply-to: <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>
References: <20260224163908.44060-1-cel@kernel.org>,
 <20260224163908.44060-2-cel@kernel.org>,
 <20260226-alimente-kunst-fb9eae636deb@brauner>,
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>,
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>,
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>,
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>,
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>,
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>,
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>,
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>,
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>,
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>,
 <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>
Date: Tue, 03 Mar 2026 07:36:26 +1100
Message-id: <177248378665.7472.10406837112182319577@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: DD7F51E24DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79012-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[ownmail.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026, Chuck Lever wrote:
> On 3/2/26 8:57 AM, Chuck Lever wrote:
> > On 3/1/26 11:09 PM, NeilBrown wrote:
> >> On Mon, 02 Mar 2026, Chuck Lever wrote:
> >>>
> >>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> >>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
> >>>>> Perhaps that description nails down too much implementation detail,
> >>>>> and it might be stale. A broader description is this user story:
> >>>>>
> >>>>> "As a system administrator, I'd like to be able to unexport an NFSD
> >>>>
> >>>> Doesn't "unexporting" involve communicating to nfsd?
> >>>> Meaning calling to svc_export_put() to path_put() the
> >>>> share root path?
> >>>>
> >>>>> share that is being accessed by NFSv4 clients, and then unmount it,
> >>>>> reliably (for example, via automation). Currently the umount step
> >>>>> hangs if there are still outstanding delegations granted to the NFSv4
> >>>>> clients."
> >>>>
> >>>> Can't svc_export_put() be the trigger for nfsd to release all resources
> >>>> associated with this share?
> >>>
> >>> Currently unexport does not revoke NFSv4 state. So, that would
> >>> be a user-visible behavior change. I suggested that approach a
> >>> few months ago to linux-nfs@ and there was push-back.
> >>>
> >>
> >> Could we add a "-F" or similar flag to "exportfs -u" which implements the
> >> desired semantic?  i.e.  asking nfsd to release all locks and close all
> >> state on the filesystem.
> > 
> > That meets my needs, but should be passed by the linux-nfs@ review
> > committee.
> 
> Discussed with the reporter. -F addresses the automation requirement,
> but users still expect "exportfs -u" to work the same way for NFSv3 and
> NFSv4: "unexport" followed by "unmount" always works.
> 
> I am not remembering clearly why the linux-nfs folks though that NFSv4
> delegations should stay in place after unexport. In my view, unexport
> should be a security boundary, stopping access to the files on the
> export.

At the time when the API was growing, delegations were barely an
unhatched idea.

unexport may be a security boundary, but it is not so obvious that it is
a state boundary.

The kernel is not directly involved in whether something is exported or
not.  That is under the control of mountd/exportfs.  The kernel keeps a
cache of info from there.  So if you want to impose a state boundary, it
really should involved mountd/exportfs.

There was once this idea floating around that policy didn't belong in
the kernel.

NeilBrown

> 
> But during a warm server reboot, do we want that behavior?
> 
> 
> > -F could probably just use the existing "unlock filesystem" API
> > after it does the unexport.
> 
> -- 
> Chuck Lever
> 


