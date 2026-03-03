Return-Path: <linux-fsdevel+bounces-79284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MPSK4BRp2nKggAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 22:24:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 604DF1F777E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 22:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 008303034E0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7C390C8A;
	Tue,  3 Mar 2026 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fJK3idTS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiZUuooE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CA396597;
	Tue,  3 Mar 2026 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573033; cv=none; b=MGFdf0bVtiw10gwjvvsBDUKbUf6XUqzd1vWEW4QCdQg+g+CZOcQ96UbEGSe5QbYiaX4+44F0R1Nfx2bVtlIXRt72wZYIBK6HnIzeyFxfR7BdK0wR/d14rDQ4H9UCMQVOaDQfVD8zp+8NGl5qP16uFMPM5xNhEQWpourWV7/RA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573033; c=relaxed/simple;
	bh=xfW6fsnRniONL54r0ihLspoMEPzdzpvtv0QJIqoz2Qw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PIKRH0CuCHwRkiZ9fXzY6nvGItiVxxcYtqe7wPlk+dXynJHyjj+qeKFECYu2RHFEQIXPFCH2dUGJPH34NJMGBSF8NpK0ibs/rzNbCIb+YalXNvwTD9ybRLkYU1nMq1gbR/u0seHd4HSVQV8UXW0xK7aqz8sX4rTpL+QfyV77UJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fJK3idTS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiZUuooE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 972991D00111;
	Tue,  3 Mar 2026 16:23:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 16:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772573030; x=1772659430; bh=XDRXvAfioJDWlNLJQmB05klfAKXr35KOURD
	9zhXLP0k=; b=fJK3idTSFHvwcA3wzQcj5K/KhdDYljbMXdVpEAhEJZm62MDRe3B
	A6lL+EORBzejg8aiEMRx8MaR+tlR5Br4+1VmLUisR+Fsqh1yREUu2k7Qbw7xGcDT
	pl9HFR+70rBDaDS5KkQMppjhVdIx5i0dAUXD2VtcEEvVXzRWqXh17JZ6esa/5UN1
	UiuO2nslkywscL/a1dxzhIfkmAKS4M7cxtY38Z5DE3v/JkZCRolXvvvazabHMKbq
	eiBmpsRZvnS/TM8WrJsqo8fpnZXRFrzszd+uqYErIjvmCj5IiEEBtyiXP7W+/okj
	IWajqdtmvL0myXgTCIm4V62RfIarObkLzJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772573030; x=
	1772659430; bh=XDRXvAfioJDWlNLJQmB05klfAKXr35KOURD9zhXLP0k=; b=H
	iZUuooElt/CsKVGGr5U2pTuQVpm59tEsREJGF6US8eWGX6rbk+1qOWAi/PVkszqH
	q9qJClKbeGwSIxluWXk8C1+lyIbxv24WvdLxvwh83uX3yDW40u0iN9b7oHBesYjq
	P6TsXq+TIRvlD4ACiqP4h03nMyLZ4dQi+FvMiFvqRifp6bnnsHugqip13q/F63Qs
	nKCmeJyjlTsWaKyKdCYBGAe7ft0tgYcrpghGYA4+9/22oXlz0V/lbk7JKCDn5pAZ
	1VAd1iYKfi86dXFvYFvSMu9LlwW4SAlxWiUDKv4MyVwhPnb+G02ZEAvshyOGrJck
	jnUcDkhGInv8NeJemIZQg==
X-ME-Sender: <xms:ZlGnaa7v3oYacqFnJIcngaZUetqgW4v1k0AdQeBe7FYhtz-QI3qahQ>
    <xme:ZlGnaSLnIvN0AIvI9c49T3eJ2801s8KRm0fWs_3OfspK8dlCaGm_h6JWCw0JSIZLx
    eAHDF-2LaGTVwgwbS1rgR7E82C9LM66H964HcDB2KQwLqs57w>
X-ME-Received: <xmr:ZlGnaSw5K2jbfZnAcBu2YHR4y5VS1EhE1ivP-5R_ojycszV3GcvUv0et8Zf0THPr4X9zvhBBDereHaeTSro0juS8XEV_WJggRDSGoaoyaZcx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopehjrggtkhesshhushgvrdgtohhmpdhrtghp
    thhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZlGnaaKyOQNkpZZZFIgrEcOOZ5uFXegcjkiianqFRfldnfexszKBrw>
    <xmx:ZlGnaRW2MS-Q5_UUN8PavhwogHWwK2Ravf7pA5YrRkmt5AQdw2LQJA>
    <xmx:ZlGnadbPTpDtncj07T0HRk05gUpL5QrkWkO2nUnePhfGXOMnkk7xeQ>
    <xmx:ZlGnaYz74TW_CvQ5IknzXl9RFzMFUSgGQvLEQPm7niajqaY8jKuPFw>
    <xmx:ZlGnaQMdTbRHqAFmumjW6CIVWcQfknKWBRUxa-L4mPtm5Oqw9PIStGoK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 16:23:46 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <fa27c3a4-ec29-4d0e-a8c5-56c4635c9e3c@oracle.com>
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
 <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>,
 <177248378665.7472.10406837112182319577@noble.neil.brown.name>,
 <fa27c3a4-ec29-4d0e-a8c5-56c4635c9e3c@oracle.com>
Date: Wed, 04 Mar 2026 08:23:42 +1100
Message-id: <177257302207.7472.9288506237444156916@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 604DF1F777E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79284-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026, Chuck Lever wrote:
> On 3/2/26 3:36 PM, NeilBrown wrote:
> > On Tue, 03 Mar 2026, Chuck Lever wrote:
> >> On 3/2/26 8:57 AM, Chuck Lever wrote:
> >>> On 3/1/26 11:09 PM, NeilBrown wrote:
> >>>> On Mon, 02 Mar 2026, Chuck Lever wrote:
> >>>>>
> >>>>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> >>>>>> On Sun, Mar 1, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kernel.org> =
wrote:
> >>>>>>> Perhaps that description nails down too much implementation detail,
> >>>>>>> and it might be stale. A broader description is this user story:
> >>>>>>>
> >>>>>>> "As a system administrator, I'd like to be able to unexport an NFSD
> >>>>>>
> >>>>>> Doesn't "unexporting" involve communicating to nfsd?
> >>>>>> Meaning calling to svc_export_put() to path_put() the
> >>>>>> share root path?
> >>>>>>
> >>>>>>> share that is being accessed by NFSv4 clients, and then unmount it,
> >>>>>>> reliably (for example, via automation). Currently the umount step
> >>>>>>> hangs if there are still outstanding delegations granted to the NFS=
v4
> >>>>>>> clients."
> >>>>>>
> >>>>>> Can't svc_export_put() be the trigger for nfsd to release all resour=
ces
> >>>>>> associated with this share?
> >>>>>
> >>>>> Currently unexport does not revoke NFSv4 state. So, that would
> >>>>> be a user-visible behavior change. I suggested that approach a
> >>>>> few months ago to linux-nfs@ and there was push-back.
> >>>>>
> >>>>
> >>>> Could we add a "-F" or similar flag to "exportfs -u" which implements =
the
> >>>> desired semantic?  i.e.  asking nfsd to release all locks and close all
> >>>> state on the filesystem.
> >>>
> >>> That meets my needs, but should be passed by the linux-nfs@ review
> >>> committee.
> >>
> >> Discussed with the reporter. -F addresses the automation requirement,
> >> but users still expect "exportfs -u" to work the same way for NFSv3 and
> >> NFSv4: "unexport" followed by "unmount" always works.
> >>
> >> I am not remembering clearly why the linux-nfs folks though that NFSv4
> >> delegations should stay in place after unexport. In my view, unexport
> >> should be a security boundary, stopping access to the files on the
> >> export.
> >=20
> > At the time when the API was growing, delegations were barely an
> > unhatched idea.
> >=20
> > unexport may be a security boundary, but it is not so obvious that it is
> > a state boundary.
> >=20
> > The kernel is not directly involved in whether something is exported or
> > not.  That is under the control of mountd/exportfs.  The kernel keeps a
> > cache of info from there.  So if you want to impose a state boundary, it
> > really should involved mountd/exportfs.
> >=20
> > There was once this idea floating around that policy didn't belong in
> > the kernel.
>=20
> I consider enabling unmount after unexport more "mechanism" than
> "policy", but not so much that I'm about to get religious about it. It
> appears that the expedient path forward would be teaching exportfs to do
> an "unlock filesystem" after it finishes unexporting, and leaving the
> kernel untouched.
>=20
> The question now is whether exportfs should grow a command-line option
> to modulate this behavior:
>=20
> - Some users consider the current situation as a regression -- unmount
>   after unexport used to work seamlessly with NFSv3; still does; but not
>   with NFSv4.

They are of course welcome to keep using NFSv3 (and to not lock files) :-)

>=20
> - Some users might consider changing the current unexport behavior as
>   introducing a regression -- they rely on NFSv4 state continuing to
>   exist after unexport. That behavior isn't documented anywhere, I
>   suspect.
>=20
> Thus I'm not sure exactly what change to exportfs is most appropriate.

I think any purging of the cache should happen at unexport time, not
transparently when unmount is attempted as I think the ordering
semantics there are complex.

And as the kernel doesn't know when something has been unexported, it
must be exportfs which initiates the cache purge.

So the only interesting question I can see is:
  do we mount "purge on unexport" the default, or do we require an
  explicit request (-F)?
A complexity here is that a given filesystem can be exported to
different clients with different options, and different subtrees can be
exported. If the cache-flush were to be the default, it would need to be
on the last export of any path to the filesystem.  This would need to
include implicit exports via crossmnt.  I think this would be hard to
specify and document well.

So I think an explicit "flush cache" exportfs action is simplest and
best.
Possibly:
   exportfs -F /some/path
would unexport all exports which reference the same mountpoint, then
would tell the kernel to drop all cached data for that mount.

Thanks,
NeilBrown

