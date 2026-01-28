Return-Path: <linux-fsdevel+bounces-75686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YERPL3OCeWmexQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:28:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743659CAE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C1B303BA7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FBF32E6BD;
	Wed, 28 Jan 2026 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hTIh/Cbh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLeAki4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FA2528FD;
	Wed, 28 Jan 2026 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570874; cv=none; b=aQoM+cQ8FhYSJQDiUCWs9i061L8/38t5RuMUEkRm8Z85DE4y+IgSEdiyrDfszKF8cudsBGR1GO4n5afrv7gvxeD3lwdK4Wbh3zTiTs0BsJOV28sLe9PUradJL34lr6fzGOaNQ1wwyM3P5tWvXIjvPw7oGXNXf8UNGJsfcfYpFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570874; c=relaxed/simple;
	bh=V+XR6VP76w4DKm8upOwlgkXGNXhfrPYtWw9JnOBXAoI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tb0a4UnNXDWKiXXg3xxWy/V6XiPwPJObunfEJTqpFg9WDI8cwYNiWiezZpULNk7sIuofeALWXurMQa7mZwxXzCDCqrZdlZiyZ7RFa4ELBNegwrNG+x1iZ+vC5xzjz9h+q4z0a8WqD3P3KshVvI1rcEvqP3HT7uYkgkhMVCm1YM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hTIh/Cbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GLeAki4f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 158611D00114;
	Tue, 27 Jan 2026 22:27:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Jan 2026 22:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769570870; x=1769657270; bh=qE6lXM8pKpo5gk3fRGouZrIVMYH4pyBU1RO
	8HA3fqxY=; b=hTIh/CbhrKWNX51u3eM4w3zaJ4Jm2JWle/2TynxSGTBDSJcygkf
	M4Fc1RS5duLdygaPdS6Me5De1Zx8SSvF+9bfK0Ux8FsLSmn+TbD9+mijO0tTjjL9
	arUprazSHeXUZUHtg4PSuhaEqVpH7I0X5/fTZgOccvN75WhwzQEwtPXiqOLJQQ8G
	IXE1A/gnEqBQE9uS+ruyQpYTR9QqihAkDPobn+LBteXi7eL2HxnJFx+2YU6XCCVd
	+DC6GhJio1raKsdtAjGP7ch748nNtl4Ldo+4ne3b3cmXar1Sriyxz4pqjswaJ3UR
	kTsnTmjI5/O+hw68UnXDfXZqwF0ieGyWtvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769570870; x=
	1769657270; bh=qE6lXM8pKpo5gk3fRGouZrIVMYH4pyBU1RO8HA3fqxY=; b=G
	LeAki4fsr1ppvnrCWDHi1tXKQ0lbPr3CuZVocliBIeZuyzmYP2BEAyNbf+OesjxK
	TmcGkAzCeRY5gtuKCt4Tj23I9AgqwdoQF27j17L6aasF5MHGkexZ/IVF+X46sHWt
	t5e2YF//GhIlwgodpCMwTfNV+lZtAaE/EHi7jx8DfE+5SHm5UaYgkYiLyyJsnjcV
	/c9N4lnx8q/kCk2GrfuWWKnzz4exbST8A+4NlqePZqyM0VIuRoGvwQEO2g/WSW5k
	2J6EYkWDp+e2WM9mV8uhcsJxKwEcCELDcwXfzQOvVRDbu2w0+oNVFG56AZvVraik
	FYtzMsaEMMLLjLVsyJn1A==
X-ME-Sender: <xms:NoJ5afOAedzHoIZxratogQjsIEntBXGy9sJUivmQ9tDsHvyxvo9kgg>
    <xme:NoJ5aV0Mf5p05eueMEQcyuyB_SXs5H8IGROOjulpqtPAcK6nqz7gP9VlmJkrWAYzh
    th54x0s1ctS5SiGfJwPdffBpfrIHC6QZaqdYe11rngJpoLHCJE>
X-ME-Received: <xmr:NoJ5abTsusg0ymKuDc09UGnQE62iXW8YY0Xn2E6HPqJpGRQQWN3sgw5zupMMn0dQs3DhLNL0oa24QRil0rPVTWAD2jhguvpsWt-oZYsXmihM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghnnhgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NoJ5aYnrYXOlCxJeAwxZz6RKAw2dHBdh24egVZFD0F_N-BdlhZw8YA>
    <xmx:NoJ5acOY69JrQctcgNEai3ka4h55hxWUXHCMiUdR3_sTlxPaAk-oVA>
    <xmx:NoJ5aUh6AZpo3H2wpK2ToOGJfUGOl1sRzXobQCJkjh0R6IdzsXA41A>
    <xmx:NoJ5aShXaFfrBrG0CnD-GeTcuMcjB9cZxwT56VIqt4S-eMwLXOVFYQ>
    <xmx:NoJ5acydHdeS9Icdp1a-N218Kpfihs4UB01ia4j_OvWaYP3y3AHdDKuG>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 22:27:47 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH/RFC] nfsd: rate limit requests that result in -ESTALE from
 the filesystem
In-reply-to: <7d973130-d4a4-4f84-a7c0-a896e17339e1@app.fastmail.com>
References: <176920977124.16766.1785815212991547773@noble.neil.brown.name>,
 <7d973130-d4a4-4f84-a7c0-a896e17339e1@app.fastmail.com>
Date: Wed, 28 Jan 2026 14:27:42 +1100
Message-id: <176957086265.16766.1100004904619725538@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75686-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,hammerspace.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:dkim,messagingengine.com:dkim,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: 743659CAE4
X-Rspamd-Action: no action

On Mon, 26 Jan 2026, Chuck Lever wrote:
> On Fri, Jan 23, 2026, at 6:09 PM, NeilBrown wrote:
> 
> > From: NeilBrown <neil@brown.name>
> > Subject: [PATCH] nfsd: rate limit requests that result in -ESTALE from the
> >  filesystem
> >
> > NFS file handles typically contain a 32 bit generation number which is
> > randomly generated by the filesystem when the inode (or inode number) is
> > allocated.  This makes it hard to guess correct file handles.  Hard but
> > not impossible on a low latency network with a high speed server.
> 
> Is this claim accurate for commonly-exported filesystems? Looking
> at the kernel sources:
> 
>   - btrfs sets i_generation = trans->transid (a sequential counter
>     starting from 1, incremented per transaction)
>   - ext2 uses sbi->s_next_generation++ (sequential counter seeded
>     randomly at mount)
>   - ocfs2 uses osb->s_next_generation++ (sequential counter)
> 
> For btrfs in particular, the generation number contains zero bits of
> randomness. An attacker who can estimate the filesystem age or
> transaction count can predict valid generation numbers with high
> probability. Does the "1 year" security estimate hold for btrfs
> exports, or is that filesystem effectively unprotected by this
> mitigation?

Thanks for exploring this.  I had only checked ext4 and xfs and thought
I saw a pattern.
btrfs is certainly a weakness here - though it could be "fixed" I expect.

> 
> 
> > Filehandles already contain 32 bits of randomness.
> 
> This appears true for ext4, f2fs, XFS v3+, and tmpfs (which use
> get_random_u32()), but not for btrfs, ext2, or ocfs2 as noted above.
> 
> Additionally, NFS re-exports (fs/nfs/export.c) use no generation number
> at all. The nfs_encode_fh() function embeds the backing server's
> filehandle verbatim rather than generating a local generation number.
> Protection depends entirely on what the backing NFS server uses. If
> someone re-exports a btrfs-backed NFS mount, the sequential transaction
> IDs on the backing server provide minimal protection.

I think we would have to expect the backing server to provide any
protection that it needs.  It is better placed than an intermediate
server, not matter what sort of protection we choose.

> 
> We can't legitimately extend your cryptanalysis to non-Linux servers
> that back re-exported NFS mounts.
> 
> 
> > The only known attack methodology is to guess the inode number of a file
> > of interest, then iterate over all possible generation numbers.
> 
> Is generation number brute-forcing the optimal attack? Inode numbers
> are typically sequential and the valid range is much smaller than 2^32.
> Could an attacker first enumerate valid inode numbers (which also
> triggers ESTALE and the rate limit), then brute-force the generation
> for interesting inodes? The rate limit slows both phases equally, but
> inode enumeration requires far fewer guesses.

How would they enumeration valid inode numbers?  and how would
"interesting" inode numbers be determined?

The fact that an attacking client cannot know what inode numbers would
be interesting would, I think, add a few bits to the guessing required.
It could certainly guess something about what sort of numbers to try, as
the assumption is that it *does* have access to some files.  So it
wouldn't make the search *much* harder, but would increase it from a
year to a decade.

> 
> 
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 9fa600602658..f7229d1f9d86 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -219,6 +219,8 @@ struct nfsd_net {
> >  	/* last time an admin-revoke happened for NFSv4.0 */
> >  	time64_t		nfs40_last_revoke;
> > 
> > +	struct mutex		estale_rate_limit_mutex;
> > +
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  	/* Local clients to be invalidated when net is shut down */
> >  	spinlock_t              local_clients_lock;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 7587c64bf26d..55d25d9b414f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -2198,6 +2198,7 @@ static __net_init int nfsd_net_init(struct net 
> > *net)
> >  	nfsd4_init_leases_net(nn);
> >  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> >  	seqlock_init(&nn->writeverf_lock);
> > +	mutex_init(&nn->estale_rate_limit_mutex);
> >  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >  	spin_lock_init(&nn->local_clients_lock);
> >  	INIT_LIST_HEAD(&nn->local_clients);
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index ed85dd43da18..7032f65fe21a 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -244,6 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> > *rqstp, struct net *net,
> >  						data_left, fileid_type, 0,
> >  						nfsd_acceptable, exp);
> >  		if (IS_ERR_OR_NULL(dentry)) {
> > +			struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > +
> >  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> >  					dentry ?  PTR_ERR(dentry) : -ESTALE);
> >  			switch (PTR_ERR(dentry)) {
> > @@ -252,6 +254,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> > *rqstp, struct net *net,
> >  				break;
> >  			default:
> >  				dentry = ERR_PTR(-ESTALE);
> > +				/* We limit ESTALE returns to 1 every
> > +				 * 15 milliseconds (across all threads) to
> > +				 * prevent a client from guessing the
> > +				 * correct (32 bit) generation number
> > +				 * for an given inode in significantly
> > +				 * less than 1 year.  This ensures clients
> > +				 * can only access files for which they
> > +				 * are allowed to access a path from the
> > +				 * exported root.
> > +				 */
> > +				mutex_lock(&nn->estale_rate_limit_mutex);
> > +				msleep(15);
> > +				mutex_unlock(&nn->estale_rate_limit_mutex);
> 
> The global mutex serializes all ESTALE errors across all nfsd threads
> in the network namespace. The impact on legitimate workloads must be
> carefully considered.
> 
> For example, during file deletion or migration, multiple clients may
> encounter genuinely stale file handles simultaneously. With N
> concurrent ESTALE errors, the total delay becomes N * 15ms as each
> thread waits for the mutex. With 100 concurrent stale handle accesses,
> this adds 1.5 seconds of accumulated latency.

Deleting a file that clients might be using is always problematic.  This
certainly does make it more problematic.  1.5 seconds isn't good, but
for an unusual event it shouldn't be a big problem.

> 
> Additionally, an attacker does not need to successfully guess file
> handles to cause harm. Simply sending requests with invalid file
> handles at a modest rate (e.g., 10/sec) can monopolize 15% of the
> mutex time, slowing all legitimate ESTALE processing on the server.

Remember that that attacker already has access to the server and is
permitted to send access some files.  Causing "some harm" is a risk you
have to take when you give anyone any access to your server.
The goal here isn't to prevent any harm, it is to prevent access to
sensitive data.

> 
> Would per-client rate limiting (e.g., a token bucket per client IP)
> avoid penalizing legitimate operations while still throttling attacks?

Per svc_export or per client-IP would be OK.  An attacker with access to
multiple IP addresses could find a gen number is less than 1 year, but
with added added attack detection it would still be impractical I think.

> 
> Or, as Jeff suggested, narrowing the blast radius to per-inode
> limiting?

per-inode requires help from each fs - not impossible but awkward.
And if 100 client are all accessing the one inode which is removed, you
still get the 1.5 second delay for that inode.

> 
> Lastly, we've spilled a large number of electrons trying to remove
> needless delays of nfsd threads (eg, waiting synchronously for NFS
> clients to respond to NFSv4 callbacks) because a malicious client
> can use this delay as a timing attack to determine the (maximum)
> number of available nfsd threads and simply keep them all busy,
> preventing the server from doing useful work.
> 

Again, this is client which is allowed to access at least one export.
Such a client can problem figure out how many threads you have running
already.

> 
> >  			}
> >  		}
> >  	}
> 
> I think given the gaps in covering exports of first-tier file
> systems such as btrfs, the unknowns in protecting re-exported
> NFS mounts, and the increase in the surface of timing attacks,
> this approach needs significant refinement before I would feel
> comfortable with it.

Thanks a lot for the thoughtful review.

In terms of defence-in-depth I think this is still a good approach.
Maybe I'll resubmit with some fine tuning and better explanations.  I
see how time works out.

Thanks,
NeilBrown


