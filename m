Return-Path: <linux-fsdevel+bounces-79056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMqBM2gCpmmfIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:34:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8651E354C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B4D32F1B8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B133D564D;
	Mon,  2 Mar 2026 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BOndl8DO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CXpN20C6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4937CCF4;
	Mon,  2 Mar 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484410; cv=none; b=ZaMscxE3CjkXtkS5kd5mMARtcV/TDDJ83461XEwMPbic8zvKgaRLz8d1yNVWc1jvpmhYLLltAT17dW28gH8TIRK3iNiPP0IdxyEqQ9m5VrDO5iz/I0xoU1sgmnUt/yY8W2fL7T1K7CSyO5z1na/zNl771M9XrUAHzQ9/fRrGLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484410; c=relaxed/simple;
	bh=x0qPybL/LxkOQVOOa2E86jCuh+ahweYusd6vq1ywJzo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SNkskkHcKdvMdETdA1K5XlBQQHcvGBkDQ/pdbsvVc7oyqjE9TgH7jYYU3vFoSkxb88SIevF5eSx8KJHPLQTSh0ERqRqWa+5PBHx9AMOsYeJ+tJQV05/7EdV0SQVPO2+GS2UV+sIqkKnWGnQgutzaT210i+p61MkwOim1TgXXJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BOndl8DO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CXpN20C6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06F0214001A3;
	Mon,  2 Mar 2026 15:46:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 15:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772484408; x=1772570808; bh=kzX7ZmpHhZoxkrFfkWrZXc+YW8Cjim4Ntfa
	vQbkFiHE=; b=BOndl8DOvLrNtxd0qFX7hqjLM8mC+l11Khv94csulUDMD6O+CMB
	Mb4u7bOru9gjQ+o0GX1n5D+Mlz/EJ0AHL2Av8myT1ZKD3xOqaeOMgr7PR1shUitZ
	4gvnDgzAwag798/IHYA7Zl69pYzVbsI1JxPcwF1ByeZaS57cM6D3O6HDTXKb1Yc8
	U4DKSIdxmBB4/jASohBeI35OQAvG+bKXB7zxt01VPhhG0UtZ+Pqh5eGO6OWvuvqB
	atVE0rM4k1ZrXj0l/2D2z/9P+gQEBFFznweQBtH7OACMp32GdVPWQcu2Wlw6H0eZ
	WNRrnT0cLIEoox4fn7lifR5T2bzbnt35fQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772484408; x=
	1772570808; bh=kzX7ZmpHhZoxkrFfkWrZXc+YW8Cjim4NtfavQbkFiHE=; b=C
	XpN20C6i6MfcJhZ6+XkmizwS5xyGM+q+liwXmg9eMvrO5xjyT1JhZcu1jqD1PXU7
	uu0RQrm/F7pMI/ipCntLKk/7LPmnFqQkpIhXXmoBHqXrZDI/sbE47YeJT4Lb4uAx
	Hoz7Zv5L+VWLpPHzNpf6pw3IeiUlc1B5wjmI1NSz7TkR4OYiAqrATyv1Ee4w7jq/
	sfrjjhHkJBhVxlOgmQTgCUyyIdvsnRo4VkuzdjV2fF4gaBMDyx7he0kQXprwFOkW
	NFjDT22hbXDaRjbCcyBqktlyLppOS3EBU1xmd7jkgo6drZLCTusAjnMfw8cuKYRT
	4MreUM3/JKYbeC1Lb2ATw==
X-ME-Sender: <xms:N_elab2NgJmAOB4NysHrKrQW_eiYbxrG784ftxzglHIlYqPBzOPcCg>
    <xme:N_elabpk_p2HN9jINHRNrqt4etX9Z0cn-NySa8Lg9tPWB9pxCUVsTxS90RBcWETRs
    4sVWDHaaJmeYk9YVlTMBa5KXlLjejWd9H69MplFvy7U_Kb8fA>
X-ME-Received: <xmr:N_elabKV0kGpGVyk8s_GVkvblgsiyx2dnHvgNE3pKoOEU5cUrOlEtr4GMi-mKckCqUyTD2wrKeePNRxDw8l5P_I3uIwiCI4MLQRQiLX8q_m9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopehjrggtkhesshhushgvrdgtohhmpdhrtghp
    thhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N_elaXR6PsAth3LEc-TdT-QXnut1Kerf31Ut5hi-yXDBbJggdhws8g>
    <xmx:N_elaTNpJ0GnsOnXzMxfwQf3kGD5t6VNYeBHOz84WCdJ50V4q0ikgA>
    <xmx:N_elaUUbuq2SvtY_HTmqhZD4ZpsZmzU3KiFG4QPhQ09wm-l8qVgHzQ>
    <xmx:N_elaei7SaOdP6fm78C8TWVTQWYI1yrobeLHBgRVT9Iz3BABCLSRsw>
    <xmx:OPelaR_QwVDT-vGTOqH_ymetI5YqCIr2Un-HAcu5WrMILQUmKUWzpvAE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 15:46:44 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jan Kara" <jack@suse.cz>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <cel@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
In-reply-to: <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
References: <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>,
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>,
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>,
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>,
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>,
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>,
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>,
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>,
 <3r5imygq5ah4khza5fsbgam6ss6ohla24p4ikmbpfpjoj4qmns@f6bw344w4axz>,
 <74db1cb73ef8571e2e38187b668a83d28e19933b.camel@kernel.org>,
 <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
Date: Tue, 03 Mar 2026 07:46:42 +1100
Message-id: <177248440227.7472.10468707970508358030@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 1B8651E354C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79056-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,brown.name:replyto,noble.neil.brown.name:mid,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026, Jan Kara wrote:
> On Mon 02-03-26 12:10:52, Jeff Layton wrote:
> > On Mon, 2026-03-02 at 16:26 +0100, Jan Kara wrote:
> > > On Mon 02-03-26 08:57:28, Chuck Lever wrote:
> > > > On 3/1/26 11:09 PM, NeilBrown wrote:
> > > > > On Mon, 02 Mar 2026, Chuck Lever wrote:
> > > > > > On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> > > > > > > On Sun, Mar 1, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kernel.=
org> wrote:
> > > > > > > > Perhaps that description nails down too much implementation d=
etail,
> > > > > > > > and it might be stale. A broader description is this user sto=
ry:
> > > > > > > >=20
> > > > > > > > "As a system administrator, I'd like to be able to unexport a=
n NFSD
> > > > > > >=20
> > > > > > > Doesn't "unexporting" involve communicating to nfsd?
> > > > > > > Meaning calling to svc_export_put() to path_put() the
> > > > > > > share root path?
> > > > > > >=20
> > > > > > > > share that is being accessed by NFSv4 clients, and then unmou=
nt it,
> > > > > > > > reliably (for example, via automation). Currently the umount =
step
> > > > > > > > hangs if there are still outstanding delegations granted to t=
he NFSv4
> > > > > > > > clients."
> > > > > > >=20
> > > > > > > Can't svc_export_put() be the trigger for nfsd to release all r=
esources
> > > > > > > associated with this share?
> > > > > >=20
> > > > > > Currently unexport does not revoke NFSv4 state. So, that would
> > > > > > be a user-visible behavior change. I suggested that approach a
> > > > > > few months ago to linux-nfs@ and there was push-back.
> > > > > >=20
> > > > >=20
> > > > > Could we add a "-F" or similar flag to "exportfs -u" which implemen=
ts the
> > > > > desired semantic?  i.e.  asking nfsd to release all locks and close=
 all
> > > > > state on the filesystem.
> > > >=20
> > > > That meets my needs, but should be passed by the linux-nfs@ review
> > > > committee.
> > > >=20
> > > > -F could probably just use the existing "unlock filesystem" API
> > > > after it does the unexport.
> > >=20
> > > If this option flies, then I guess it is the most sensible variant. If =
it
> > > doesn't work for some reason, then something like ->umount_begin sb
> > > callback could be twisted (may possibly need some extension) to provide
> > > the needed notification? At least in my naive understanding it was crea=
ted
> > > for usecases like this...
> > >=20
> > > 								Honza
> >=20
> > umount_begin is a superblock op that only occurs when MNT_FORCE is set.
> > In this case though, we really want something that calls back into
> > nfsd, rather than to the fs being unmounted.
>=20
> I see OK.
>=20
> > You could just wire up a bunch of umount_begin() operations but that
> > seems rather nasty. Maybe you could add some sort of callback that nfsd
> > could register that runs just before umount_begin does?
>=20
> Thinking about this more - Chuck was also writing about the problem of
> needing to shutdown the state only when this is the last unmount of a
> superblock but until we grab namespace_lock(), that's impossible to tell in
> a race-free manner? And how about lazy unmounts? There it would seem to be
> extra hard to determine when NFS needs to drop it's delegations since you
> need to figure out whether all file references are NFS internal only? It
> all seems like a notification from VFS isn't the right place to solve this
> issue...

It isn't clear to me that "last unmount" is the correct target.

The nfsd file cache (which I think is the main focus here - it holds
delegated files etc) caches files.  i.e.  "struct file *".  This
identifies a dentry on a vfsmount.
I think it could be appropriate to drop nfsd state when the vfsmount is
being considered for unmount - including lazy unmount - whether the
superblock has other mounts or not.

An unmount attempt should fail if the vfsmount is still in use,
including in use in the the nfsd export table.  And if it is going to
fail, then we don't want to drop nfsd state.  But if it would succeed
after nfsd state was dropped - then and only then do we want to drop
nfsd state.

I think it would be messy to get this dependency correct.

i.e.  I think that guessing, in the kernel, what the user wants is
problematic.  I think giving the user the tools to say exactly what they
want is best.

NeilBrown


>=20
> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=20


