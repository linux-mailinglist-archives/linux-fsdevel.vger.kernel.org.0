Return-Path: <linux-fsdevel+bounces-79302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN1LAWmEp2mgiAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:01:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB41F90BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D7CE3061231
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E12FA0C6;
	Wed,  4 Mar 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Rhc7dbfC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OPhmSIDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C331C28E;
	Wed,  4 Mar 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586080; cv=none; b=rDezrN03Y7WdyGWPYJMuTpkHrXIBZXZEN0iEFcjZfCnarPO7WCr3XeYFccQ/9xLAq2L1ddcgzhH4SQrK8Xp23U9KZ/d7sd2b3S1TEgzEAjqCyPjqPYciLskydwUT3ybn3cjyvoJSj9Y2fVm+eOQukNIyR6oJgI5joPn4wIOb5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586080; c=relaxed/simple;
	bh=VftUGl+vdX3LWiUsrbmEdPwIaUcSx1R2HH5fp6HKejc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qs9KOecckEvbFVZg8d1ss4URZhbpFU+3JhV5iIpD4PRgAV7skykrhxvz4zWoHW678H14ijfcJZTDsU9/Z+2sJDRQZSbbGByp41qndOm6UXSoQYbU7wDMrhF1MFnggQyzlz63UnlRYpPG6DQIfziKeBL5TEkk6/X5OwPUXS0RXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Rhc7dbfC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OPhmSIDb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D62211400041;
	Tue,  3 Mar 2026 20:01:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 03 Mar 2026 20:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772586076; x=1772672476; bh=YyzfG1Oi6PZWpFXsdC2PDwZ9z/4hI+fhfoC
	gPqIsJ2I=; b=Rhc7dbfC++TGE1IjY8Ph4Zc18fHgOY1yYvSEjSrAubwkHI8mdLh
	6HzkaDxLURbOICAUeMAkRhrvLiZhA4Gv7tvSomTTsQqFykuOrvN3ZqvawM71erwZ
	QXBN4DkrO7Kkxj8eQKddnEKoHj/PO8pNJtPovd0Hxu91dxmqCk+dFvkU12k4trFI
	wIyiTb+4gcuZsRIcOAOyKnfebZybPCzkGWoTV3n5eGUveHxahYFm5cZuHEsyFwJn
	deL0qEeZeG6LJ5wkuTyHu5GvKWY4jZdFxv5dO3lD8ABeqVR8HKEJClPwjovFZsK2
	MT47CBoFDh7DJ+2pEgPJEaOMGNCu/xpbf1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772586076; x=
	1772672476; bh=YyzfG1Oi6PZWpFXsdC2PDwZ9z/4hI+fhfoCgPqIsJ2I=; b=O
	PhmSIDbmXJz9ECy+VKlpc8OtGmfx2iHepBpV1Ecfn7xwU3HLscr3cmqHQJtpMCAB
	MH2IgyyJswnr8+4DBXo5v3DcGyvTmqfCPwwFDxwPlKuoQ1Txu9O496/CJDxZEfa0
	b7sUnjncT1Wgskx2KqjWlel4e6CZ3/+KSC5nkB+kKmDKZiN2KPRsTfRtlVfrb3cz
	8KJAr6Pyl/rLYSLPpxqjZiU/FfCTHrOiijqxewbT38AAtfd5VIqi+0fk4xSG++Q3
	JvQiKD7zwEwgYZsvhsCVRTPQJMvJli6Ca7nUF3xyNhmNO4BzcbjmVktTvrcYufw5
	/GhDPgTgMPK2ko2+q8sCA==
X-ME-Sender: <xms:XISnaSoE9bKA_SP4DfBoyacs5TI-0XqA709A4HmLo4MgJ_TbS7p0jA>
    <xme:XISnae4HQfkSnlLzvf_NyK290VmWxtZvaeErJFt9Tos86cPrhR__wh-uNhFZm4ciP
    sal0L7zZ0aNg-_U3raKUDpYc_31MRfmFGng-_Ihdt4N1LSOPw>
X-ME-Received: <xmr:XISnaQh4hjgnfh3cuwAkGmJSYECoDWUIdLSPQyk_3AJN3-6a4nsXYzmY_JXUbDXXAmex6FsWy-mBn6T3qVAJD4hOOdhdQ5GgyoT-KUpQjJd_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvuddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XISnaU4eXW-D5ulrgh2Aaa1yoZol_hEcStLyIZI_VzWGrqmkgCd3pQ>
    <xmx:XISnaVEWk3fVmhDIbiYPB5ttTXp9uRbvfFqt7-1m4BWd-vJ6_2Sdfg>
    <xmx:XISnaWKxip3bUORPAgIRWl1ed_OYZeD_29Z7lXojHvssQC29ZcV93w>
    <xmx:XISnaSjMFPpyZmYFhsgXpHxQF14m4_ufj2sUrJy1IfgUdy2gYEblFQ>
    <xmx:XISnaW8iDnjfhgWCsJSMCtlZx79SYhVRaydVgctvxiLXRIZCoGwNYOJE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 20:01:12 -0500 (EST)
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
In-reply-to: <5a4775b2-fb04-4297-b9b3-ca0690130094@oracle.com>
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
 <fa27c3a4-ec29-4d0e-a8c5-56c4635c9e3c@oracle.com>,
 <177257302207.7472.9288506237444156916@noble.neil.brown.name>,
 <5a4775b2-fb04-4297-b9b3-ca0690130094@oracle.com>
Date: Wed, 04 Mar 2026 12:01:08 +1100
Message-id: <177258606803.7472.15755048075773688085@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 60EB41F90BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79302-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026, Chuck Lever wrote:
> On 3/3/26 4:23 PM, NeilBrown wrote:
> > On Wed, 04 Mar 2026, Chuck Lever wrote:
> >> On 3/2/26 3:36 PM, NeilBrown wrote:
> >>> On Tue, 03 Mar 2026, Chuck Lever wrote:
> >>>> On 3/2/26 8:57 AM, Chuck Lever wrote:
> >>>>> On 3/1/26 11:09 PM, NeilBrown wrote:
> >>>>>> On Mon, 02 Mar 2026, Chuck Lever wrote:
> >>>>>>>
> >>>>>>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> >>>>>>>> On Sun, Mar 1, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kernel.org=
> wrote:
> >>>>>>>>> Perhaps that description nails down too much implementation detai=
l,
> >>>>>>>>> and it might be stale. A broader description is this user story:
> >>>>>>>>>
> >>>>>>>>> "As a system administrator, I'd like to be able to unexport an NF=
SD
> >>>>>>>>
> >>>>>>>> Doesn't "unexporting" involve communicating to nfsd?
> >>>>>>>> Meaning calling to svc_export_put() to path_put() the
> >>>>>>>> share root path?
> >>>>>>>>
> >>>>>>>>> share that is being accessed by NFSv4 clients, and then unmount i=
t,
> >>>>>>>>> reliably (for example, via automation). Currently the umount step
> >>>>>>>>> hangs if there are still outstanding delegations granted to the N=
FSv4
> >>>>>>>>> clients."
> >>>>>>>>
> >>>>>>>> Can't svc_export_put() be the trigger for nfsd to release all reso=
urces
> >>>>>>>> associated with this share?
> >>>>>>>
> >>>>>>> Currently unexport does not revoke NFSv4 state. So, that would
> >>>>>>> be a user-visible behavior change. I suggested that approach a
> >>>>>>> few months ago to linux-nfs@ and there was push-back.
> >>>>>>>
> >>>>>>
> >>>>>> Could we add a "-F" or similar flag to "exportfs -u" which implement=
s the
> >>>>>> desired semantic?  i.e.  asking nfsd to release all locks and close =
all
> >>>>>> state on the filesystem.
> >>>>>
> >>>>> That meets my needs, but should be passed by the linux-nfs@ review
> >>>>> committee.
> >>>>
> >>>> Discussed with the reporter. -F addresses the automation requirement,
> >>>> but users still expect "exportfs -u" to work the same way for NFSv3 and
> >>>> NFSv4: "unexport" followed by "unmount" always works.
> >>>>
> >>>> I am not remembering clearly why the linux-nfs folks though that NFSv4
> >>>> delegations should stay in place after unexport. In my view, unexport
> >>>> should be a security boundary, stopping access to the files on the
> >>>> export.
> >>>
> >>> At the time when the API was growing, delegations were barely an
> >>> unhatched idea.
> >>>
> >>> unexport may be a security boundary, but it is not so obvious that it is
> >>> a state boundary.
> >>>
> >>> The kernel is not directly involved in whether something is exported or
> >>> not.  That is under the control of mountd/exportfs.  The kernel keeps a
> >>> cache of info from there.  So if you want to impose a state boundary, it
> >>> really should involved mountd/exportfs.
> >>>
> >>> There was once this idea floating around that policy didn't belong in
> >>> the kernel.
> >>
> >> I consider enabling unmount after unexport more "mechanism" than
> >> "policy", but not so much that I'm about to get religious about it. It
> >> appears that the expedient path forward would be teaching exportfs to do
> >> an "unlock filesystem" after it finishes unexporting, and leaving the
> >> kernel untouched.
> >>
> >> The question now is whether exportfs should grow a command-line option
> >> to modulate this behavior:
> >>
> >> - Some users consider the current situation as a regression -- unmount
> >>   after unexport used to work seamlessly with NFSv3; still does; but not
> >>   with NFSv4.
> >=20
> > They are of course welcome to keep using NFSv3 (and to not lock files) :-)
>=20
> >> - Some users might consider changing the current unexport behavior as
> >>   introducing a regression -- they rely on NFSv4 state continuing to
> >>   exist after unexport. That behavior isn't documented anywhere, I
> >>   suspect.
> >>
> >> Thus I'm not sure exactly what change to exportfs is most appropriate.
> >=20
> > I think any purging of the cache should happen at unexport time, not
> > transparently when unmount is attempted as I think the ordering
> > semantics there are complex.
> >=20
> > And as the kernel doesn't know when something has been unexported, it
> > must be exportfs which initiates the cache purge.
> >=20
> > So the only interesting question I can see is:
> >   do we mount "purge on unexport" the default, or do we require an
> >   explicit request (-F)?
>=20
> Yes, that's what I was trying to say above.
>=20
>=20
> > A complexity here is that a given filesystem can be exported to
> > different clients with different options, and different subtrees can be
> > exported. If the cache-flush were to be the default, it would need to be
> > on the last export of any path to the filesystem.  This would need to
> > include implicit exports via crossmnt.  I think this would be hard to
> > specify and document well.
>=20
> Is there nothing we can do to engineer the exportfs command to remove
> some of this complexity?

An argument could certainly be made that the exportfs command attempts
to be too general and consequently is too vague, and that a better
interface could be defined that was more opinionated and less flexible,
and so was easier to use without risk of complexity.

But that would be a different tool.
The complexity I see is not in the implementation, which could be
re-engineers, but in the design/behaviour which cannot without
user-visible change.

>=20
>=20
> > So I think an explicit "flush cache" exportfs action is simplest and
> > best.
> > Possibly:
> >    exportfs -F /some/path
> > would unexport all exports which reference the same mountpoint, then
> > would tell the kernel to drop all cached data for that mount.
>=20
> I passed along your original "-F" suggestion to the original reporter a
> few days ago, and it was not met with universal glee and a huzzah.
>=20
> Although "-F" can be added to automation easily enough, their
> preference, based on their own users' experience, is that the fix should
> not require changes in user behavior.

I think their preference, while understandable, is naive.
They are doing something that is not documented as supported, is not
actually supported, and has always had the possibility of failure.
They have switched from v3 to v4 (possibly following a default) and now the
failure is more likely...
Maybe the best fix without changes in user behaviour is to switch the
default back to v3....

NeilBrown


>=20
>=20
> --=20
> Chuck Lever
>=20


