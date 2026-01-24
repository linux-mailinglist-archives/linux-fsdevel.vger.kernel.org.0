Return-Path: <linux-fsdevel+bounces-75372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MBbKT5TdWnoDwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 00:18:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63D7F31F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 00:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A6CB300232F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021C3EBF1E;
	Sat, 24 Jan 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="e4ADTE8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uA5h6+F3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA093EBF0F;
	Sat, 24 Jan 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769296699; cv=none; b=M7bSCphc+eU8XqlqzXoeQKPD79qlIi4H1/pEiUqe3H8mO3bA2g3J1jYLCiKXlD+9wWgS66W516YFmKNgFogj5U5oBHffO8b26ZbtY1VYX0pIxGneLzbDeFquRzwoG2uEmyESyGad3JsaOl+1IEV1HVlcOSKJUNKYzWAoe/kHt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769296699; c=relaxed/simple;
	bh=i8OsbdyKtcll/njri3UTpAsTQir7hURPr/vDqojjjqc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HiLHfp7xAO+2sWKPo5ydrotO5I28hy3gjF0H3l2EnfjMpJ7idxZ721Fs+DmiqrtP6SH/SRSRGCRW6KBx5WaUyFXd1xhvqwKdazAeg6GbfGbqfNMeLhlsvce6jK3WJSc4SHjfX/2HBDuR4+6et29VH6c6H2LlfCcu9sJcVmlXrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=e4ADTE8v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uA5h6+F3; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 44CD5EC00A7;
	Sat, 24 Jan 2026 18:18:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 24 Jan 2026 18:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769296695; x=1769383095; bh=HdvH5cYB6GHhiJjgs5/Tl5SVn3GjJV0xZEU
	rIuZ3i3E=; b=e4ADTE8vDsWh+tK7cPIqMCsl/2Lyw+LA1CsBG2MUWgJmDKCdKoq
	E2XYeqhlx3RGkwaJKnvb9LbBCxUHbZGGqP0HNW9FgjcdzWx2B8C2nPnqnNi6ZPra
	TPxXcNF3I1FIPP984CxPy4vuiVR78P8IihYLC6APxWQJH5j1oAVBXu3HH/cS/b4E
	oXo5qKYmou1XI6TE9O5GlC9Qqr560my65CzKkHbgbLRhfplh/+LsrryXJuAVZe5q
	esfAksAq0YrtKW6+SpPRlHsuutg1N0E46R3wraQj1i4r3WGrfkXSac36M4Eizw0A
	G2eQv+75Hwj1XYWAUldpnCwo7Yt97OHDJQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769296695; x=
	1769383095; bh=HdvH5cYB6GHhiJjgs5/Tl5SVn3GjJV0xZEUrIuZ3i3E=; b=u
	A5h6+F3Hk1T1ovSFtkP/5LOtpcfdWQ2sUn+ahZZaT5Eh3FHw/NLy7Ji+Pb4HqRpr
	07aUDaF5dc82Vvx7oOOUxfQe95+3xallWhM5ed/UL8Xbmn/mpOtvcb+yg7S7b0YB
	QUWMjoQSZKpoKn8PmEThhaQVc2h+JsnPvWovNAnDevDZ07hWVipNKUtnTFBsnhJX
	o8YPSOZ8lCeFbnLENCDTIx3x0mcJERbfEQGhBpSzZPivO7VhgFqzW/XFAfggvgUd
	QHglBLM/UEzvpaoKpVRJq6tBns3hSJDIctfHFJPtnezVUvCXgn4scQjHn4IxX2ER
	WWKmVkdQz0mTE6pJsIuVg==
X-ME-Sender: <xms:NlN1aW1HsBLMkUCXmfFFs-PKmV-zTpeMnhOHyxECRYsemNoHkk7L3Q>
    <xme:NlN1afHOuIxNxLHCRf2-0ZM6FFqDh016SgGtLoQZhrksuqiklUdohgdzWZI_LpDFO
    Yy36E0-H0O29pIQo_OS5SudMrnSX0Dn6Zaj3CMAhQCZ3co8>
X-ME-Received: <xmr:NlN1aZsLiUxhX81sqUikQL3xK4OgjxRrchxNlcgarC4oQj254M0hk-2iRcQQRR9rP-Y90XztJxeiYDhMFeyxs9NBnA3V2t0WFUko3oWIPvxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:NlN1aapDHZaEdcErbYN8MfHTZf_xuh-80ZvJKhi_y2iUUHy7azwIuQ>
    <xmx:NlN1aYVNc4u0j1YdqAHsv8tYjxhZqgUz1a2WPmBGqyBkBftKK1GgOw>
    <xmx:NlN1aa0F0iZdDvWRCdndBLeRDn49S_2R-uKdShJJQzAqxTKvsxs-4Q>
    <xmx:NlN1aVscUHGHkPR5rQEedMJMhd2ogtOIG2NArDHSkEZcJG45HBX7Ng>
    <xmx:N1N1aeJLLj3v9pzqdP_mn9msRrkRmrdDvjd5vBuSgpHV0AQYe-exyKnf>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 18:18:11 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH/RFC] nfsd: rate limit requests that result in -ESTALE from
 the filesystem
In-reply-to: <8c17ec4e60f491a70f596142a9fa5540be12165e.camel@kernel.org>
References: <>, <8c17ec4e60f491a70f596142a9fa5540be12165e.camel@kernel.org>
Date: Sun, 25 Jan 2026 10:18:07 +1100
Message-id: <176929668770.16766.6469926015285664614@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75372-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,hammerspace.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA63D7F31F
X-Rspamd-Action: no action

On Sat, 24 Jan 2026, Jeff Layton wrote:
> On Sat, 2026-01-24 at 13:04 +1100, NeilBrown wrote:
> > On Sat, 24 Jan 2026, Jeff Layton wrote:
> > > On Sat, 2026-01-24 at 10:09 +1100, NeilBrown wrote:
> > > > This is an idea for an alternate approach to address the problem that
> > > > Ben is trying to address by signing file handles.
> > > >=20
> > > > The reasons I think an alternate is worth considering are:
> > > >=20
> > > >  - Ben's approach requires some configuration, though not much.
> > > >    This approach requires zero configuration which is always better.
> > > >=20
> > > >  - Ben's approach adds a siphash calculation or two to (almost) every
> > > >    NFS request.  This may not be a great cost but it is still some ti=
me
> > > >    and some power.  Less is more.
> > > >=20
> > > > Filehandles already contain 32 bits of randomness.  Rather than adding
> > > > another 64 bits as Ben's patch does, this patch increase the time it
> > > > take to test all possible values for those 32 bits to make it an
> > > > impractical attack.
> > > >=20
> > > > Comments welcome.
> > > >=20
> > > > Thanks,
> > > > NeilBrown
> > > >=20
> > > >=20
> > > >=20
> > > > From: NeilBrown <neil@brown.name>
> > > > Subject: [PATCH] nfsd: rate limit requests that result in -ESTALE fro=
m the
> > > >  filesystem
> > > >=20
> > > > NFS file handles typically contain a 32 bit generation number which is
> > > > randomly generated by the filesystem when the inode (or inode number)=
 is
> > > > allocated.  This makes it hard to guess correct file handles.  Hard b=
ut
> > > > not impossible on a low latency network with a high speed server.
> > > >=20
> > > > The NFS server will reject a request to access the file associated wi=
th
> > > > a filehandle if the user credential given is now allowed the access t=
he
> > > > file, but it is not able to check if the user (or client) should be
> > > > allowed to even know that filehandle.  This would require knowing all
> > > > the paths to a given file, all the credential that the client has acc=
ess
> > > > to, when whether some combination of those credential can complete a
> > > > walk down any of the paths.
> > > >=20
> > > > So the NFS server currently depends on the client to "do the right
> > > > thing".
> > > >=20
> > > > In some circumstances the client may not be sufficiently trusted, and
> > > > path-based access controls may be an important part of the access
> > > > management strategy.  In these cases the protection provided by nfsd =
may
> > > > not be sufficient.
> > > >=20
> > > > The only known attack methodology is to guess the inode number of a f=
ile
> > > > of interest, then iterate over all possible generation numbers.  This
> > > > would be expected to achieve success (if the inode number is valid) i=
n,
> > > > on average, 2^31 guesses.  At one per microsecond this is less than o=
ne
> > > > hour.  At one per 10 microseconds this is less than one day.
> > > >=20
> > > > When presented with an incorrect guess the filesystem with report an
> > > > error to nfsd, either NULL or ERR_PTR(-ESTALE).  This patch causes nf=
sd
> > > > to detect those errors and insert a 15ms delay.  It also take a lock =
so
> > > > that all such delays are serialised.  This increases the expected time
> > > > to success to 1 year.
> > > >=20
> > > > Normally NFSERR_STALE errors are rare and are no on a fast path.
> > > > Normal accesses which use a filehandle which has become stale will now
> > > > incur a 15msec does which is likely to be unnoticeable.  An attack wi=
ll
> > > > notice an intolerable delay.
> > > >=20
> > > > Possible this code could detect if there are ever a large number of
> > > > requests over an extended time and then take more firm action.
> > > >=20
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > ---
> > > >  fs/nfsd/netns.h  |  2 ++
> > > >  fs/nfsd/nfsctl.c |  1 +
> > > >  fs/nfsd/nfsfh.c  | 15 +++++++++++++++
> > > >  3 files changed, 18 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > index 9fa600602658..f7229d1f9d86 100644
> > > > --- a/fs/nfsd/netns.h
> > > > +++ b/fs/nfsd/netns.h
> > > > @@ -219,6 +219,8 @@ struct nfsd_net {
> > > >  	/* last time an admin-revoke happened for NFSv4.0 */
> > > >  	time64_t		nfs40_last_revoke;
> > > > =20
> > > > +	struct mutex		estale_rate_limit_mutex;
> > > > +
> > > >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > > >  	/* Local clients to be invalidated when net is shut down */
> > > >  	spinlock_t              local_clients_lock;
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index 7587c64bf26d..55d25d9b414f 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -2198,6 +2198,7 @@ static __net_init int nfsd_net_init(struct net =
*net)
> > > >  	nfsd4_init_leases_net(nn);
> > > >  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> > > >  	seqlock_init(&nn->writeverf_lock);
> > > > +	mutex_init(&nn->estale_rate_limit_mutex);
> > > >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > > >  	spin_lock_init(&nn->local_clients_lock);
> > > >  	INIT_LIST_HEAD(&nn->local_clients);
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index ed85dd43da18..7032f65fe21a 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -244,6 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst =
*rqstp, struct net *net,
> > > >  						data_left, fileid_type, 0,
> > > >  						nfsd_acceptable, exp);
> > > >  		if (IS_ERR_OR_NULL(dentry)) {
> > > > +			struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > > +
> > > >  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> > > >  					dentry ?  PTR_ERR(dentry) : -ESTALE);
> > > >  			switch (PTR_ERR(dentry)) {
> > > > @@ -252,6 +254,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst=
 *rqstp, struct net *net,
> > > >  				break;
> > > >  			default:
> > > >  				dentry =3D ERR_PTR(-ESTALE);
> > > > +				/* We limit ESTALE returns to 1 every
> > > > +				 * 15 milliseconds (across all threads) to
> > > > +				 * prevent a client from guessing the
> > > > +				 * correct (32 bit) generation number
> > > > +				 * for an given inode in significantly
> > > > +				 * less than 1 year.  This ensures clients
> > > > +				 * can only access files for which they
> > > > +				 * are allowed to access a path from the
> > > > +				 * exported root.
> > > > +				 */
> > > > +				mutex_lock(&nn->estale_rate_limit_mutex);
> > > > +				msleep(15);
> > > > +				mutex_unlock(&nn->estale_rate_limit_mutex);
> > >=20
> > > Hmm...maybe a mutex_trylock and if it fails do an immediate -EAGAIN
> > > return (which hopefully becomes NFSERR3_JUKEBOX or NFS4ERR_DELAY)? This
> > > could be a way to DoS the server, otherwise.
> >=20
> > Returning NFS4ERR_DELAY immediately instead of NFS4ERR_STALE gives
> > the attacking client nearly identical information.  It would not resend
> > the request that reported NFS4ERR_DELAY.
> >=20
>=20
> Ok, good point.
>=20
> It does occur to me that we're not concerned so much with ESTALE errors
> globally, as seeing a lot of them that refer to the same inode. It
> would be nice if we could track this on a per-inode basis, and only
> serialize and delay ESTALE errors for the same inode.

We could do that if we changed ->fh_to_dentry so that in case of a
gen-number mismatch it could return the dentry but flag the error.
Then we could lock the inode while waiting 15ms.
I don't think that is justified up front, but if we took this approach
and it proved to be problematic, we could explore this as a later
improvement.

>=20
> > Triggering a DoS is part of the point - it both defeats the attack and
> > makes the attack obvious.  If an attack is going to be obvious it will
> > likely be caught so the potential attacker is unlikely to try.
> >=20
> > A client with authority to make requests can already generate a high
> > rate of high cost request without waiting for replies and so potentially
> > DoS the server.  Remember that we aren't aiming to protect against
> > completely unauthorised client, but only clients which do have some
> > authority.
> >=20
>=20
> It sounds like we need to accompany this with a warning or something to
> alert that an authorized client is triggering a lot of ESTALE errors.

Agreed.  I didn't want to spend much time on that side at first until
there was some buy-in. =20
I imagine that if there are two consecutive longish periods each of
which have more than a large number of ESTALE, we report a warning, and
if there are more of them, we disable the export that is causing them.

Maybe we keep count per svc_export and when the count reaches 1,000,000
we record a timestamp.
We keep the last few timestamps and just before recording a new one, if
the second newest is less than 2 days, we warn.  If the 4th newest is
less than 4 days (???) we disable the svc_export.

Something like that though I haven't given a lot of thought to the
precise details.

>=20
>=20
> > >=20
> > > >  			}
> > > >  		}
> > > >  	}
> > >=20
> > >=20
> > > FWIW, I don't necessarily see this as a replacement for Ben's work, but
> > > it might be a nice complement.
> >=20
> > If you knew that an attack couldn't succeed, why would you bother
> > setting sign_fh ?
> >=20
>=20
> I think this may potentially give us a way to assign different
> filehandles to different clients.
>=20
> Once we tack on the signature, there is (seemingly) no reason that
> every client must get the same filehandle. If we were to factor in
> (e.g.) the long-form clientid when generating the hash, then we'd have
> a v4 fh that could only be used by a single client.

For v3 we cannot know the client because a client might have multiple IP
addresses.

For v4 we could use the clientid as you say but I suspect inter-server
copies might hit problems as the client passes its filehandle to one
server and it passes it on the another.  However do the client pass on a
clientid as well??  In that case we might be able to make it work.

>=20
> Then, even if you were to guess a filehandle (or gain it via other
> means) it still wouldn't do you a lot of good without being able to
> spoof the connection from the client too.
>=20

I do like the idea of per-client filehandles if it can be made to work.

Thanks,
NeilBrown



> I'm not sure what we'd factor in for v3 though.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


