Return-Path: <linux-fsdevel+bounces-44449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FBA692B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AE5480448
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8D221734;
	Wed, 19 Mar 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="I0P8fEZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXasLh0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798A21D596;
	Wed, 19 Mar 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396170; cv=none; b=U2l8hGZnLtLCDhbI5W9LPX2f7RK9pzoY2k25AXk6Jno4fCtIqK2eTdRSarpI2OzJBDDDznit1aYOsMBCB6AGKzJi8OEiew5p+5gOfVduXGrb5VhdhF7fMM2JB3KKmNULqXp23l/ZyDZygzDlTroVyiDR1tObvIY/FiofsU88ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396170; c=relaxed/simple;
	bh=fJ3F0yiZWpnOp2Nq8Bm3nwRNQRkQKyKmPX7nnAGXLv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R24cyh3zyfOK6IIU2BJGjX0jPZq9E4x02js05Z97FOZOg6VLGpOXrY5/da5WpY0cAZZCYzWmmFY2jntUu02kcVpdxfM6kYf4p/DbEwrWttehrmenS4esLBQTiqMxI1SNJ+k8vjL82Yn86vrJPA8uenSvXH7KaFYToSWf7Ph+Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=I0P8fEZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXasLh0C; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CEC7C2540234;
	Wed, 19 Mar 2025 10:56:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742396163;
	 x=1742482563; bh=6YtNAy6HBfsyucG2rvA4CF+wsGauxsNRU9FKvC0/25E=; b=
	I0P8fEZ7Te6/fmNHSvma2ma4o3KZl7xibq7+WBYcevRbRMqWYXQH+SLBOe2mPVIB
	nrtvAufJI4WjVrJJ/pjMY3lb2v2bwlQ1iI/kqpTMGvXB2B/fY5Did42fTCdlZBGZ
	dExdWLr2ujBT2Zq7/MtEAiSRyFcKyobGTCydjaVWz5MtWT41gAcV2X/grmNWuy0o
	p3Fy9QgMfN3ghOUgZVV4pDE+LgXcdd4cSMIB3XJXiRjN5+UiOopBxPY7E3NTAkY7
	/V3KUEPxNDkLxrhAQL01s4P5qk+g7lvwQOrFVwCQUUiF/GaVGmDBGDECOnfZeXNR
	zX7esmNwD/nZR2fB2lRqjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742396163; x=1742482563; bh=6YtNAy6HBfsyucG2rvA4CF+wsGauxsNRU9F
	KvC0/25E=; b=wXasLh0C6wlK8Db10HpqaXvAZpHubQmGV6opRrkLP1H75vnKChi
	0GG7l2jQI7fwSBQ8VNoJMSNdb6KNm1PrjR3VVoZ+AD6K7M37lUgKGKQSZWM002bw
	kQhdP+1uCX48Fgpx0254MyM8nIcVxH2GoqGaZG8OW6E87ik9MVdLjY1iPJ4mppnc
	SnEWIU/KBECMCeh7bnDvLTc+bWATvxc1Mrl6bwrH+C6NB0UO+5aqu1Zuffppx0CI
	T2JOL5rGn96zHHnF+ShRGNG97gcnFnCojasQdsXuvFNjL86u4MspQYVFOJFgKLv9
	9bnYhD8K9Ow/rSCZTDzF8z7enOrCD5I4yZA==
X-ME-Sender: <xms:A9vaZ7RnSNY02nEqV1hyrQOySEmJsob6Iyx-XVn8-lsjY7T8t-W8og>
    <xme:A9vaZ8z75UMAMWlpnYOiiEdBORXWQ-MDUMIuzBLq1R2c3EJeJIW-2oEGF8ydPETJl
    xvgZue4XP2ZEuc>
X-ME-Received: <xmr:A9vaZw3WlYjSFGNuPoawng7kBIsf59frkYCpUsioIpYbvcgzqAAU_fhAfdTA8Lbge5sqm4fMv6r9UVOYNjjslHdwhnr22c4yOp45iXimelU5X78k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghmihcuofgrrhhivgcu
    qfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffejgeejgeffkeelveeu
    leeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopegtvhgvsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgtphhtthhope
    hlihhnuhigqdgstggrtghhvghfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvght
X-ME-Proxy: <xmx:A9vaZ7A9-6RclAM5pIHAvhRBh5ExBrhP_2-wmjR0OFxpgoFz9thkcQ>
    <xmx:A9vaZ0go6bICdLT_Mm7qKXyEtM6ZLApvB-zHv_lV_yNPO6rAR6i9lQ>
    <xmx:A9vaZ_pyvbpGcS4o_NrRF2lKc_i_p9hDHrYch1oXASrdrIsaKIz1vw>
    <xmx:A9vaZ_ghDPW_Hc6jOWrmcUbajlRJNmDNL-qcl3xgKelXZtN2IRUUNA>
    <xmx:A9vaZ5ZcihA2eqyE0NqXT1reBPLXNYAHL0WzUrUx8JC0PKUaBYvWixpL>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 10:56:02 -0400 (EDT)
Date: Wed, 19 Mar 2025 10:55:39 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Dave Chinner <david@fromorbit.com>
Cc: cve@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z9rbDdLr0ai-UFE_@itl-email>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <Z9kC7MKTGS_RB-2Q@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gJn/WH0kaLCMp1ft"
Content-Disposition: inline
In-Reply-To: <Z9kC7MKTGS_RB-2Q@dread.disaster.area>


--gJn/WH0kaLCMp1ft
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2025 10:55:39 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Dave Chinner <david@fromorbit.com>
Cc: cve@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts

On Tue, Mar 18, 2025 at 04:21:48PM +1100, Dave Chinner wrote:
> On Tue, Mar 11, 2025 at 04:10:42PM -0400, Demi Marie Obenour wrote:
> > On Tue, Mar 11, 2025 at 04:57:54PM +1100, Dave Chinner wrote:
> > > On Mon, Mar 10, 2025 at 10:19:57PM -0400, Demi Marie Obenour wrote:
> > > > People have stuff to get done.  If you disallow unprivileged filesy=
stem
> > > > mounts, they will just use sudo (or equivalent) instead.
> > >=20
> > > I am not advocating that we disallow mounting of untrusted devices.
> > >=20
> > > > The problem is
> > > > not that users are mounting untrusted filesystems.  The problem is =
that
> > > > mounting untrusted filesystems is unsafe.
> > >=20
> > > > Making untrusted filesystems safe to mount is the only solution that
> > > > lets users do what they actually need to do. That means either actu=
ally
> > > > fixing the filesystem code,
> > >=20
> > > Yes, and the point I keep making is that we cannot provide that
> > > guarantee from the kernel for existing filesystems. We cannot detect
> > > all possible malicous tampering situations without cryptogrpahically
> > > secure verification, and we can't generate full trust from nothing.
> >=20
> > Why is it not possible to provide that guarantee?  I'm not concerned
> > about infinite loops or deadlocks.  Is there a reason it is not possible
> > to prevent memory corruption?
>=20
> You're asking me to prove that the on-disk filesystem format parsing
> implementation is 100% provably correct. Not only that, you're
> wanting me to say that journal replay copying incomplete,
> unverifiable structure fragments over the top of existing disk
> structures is 100% provably correct.
>=20
> I am the person whole architected the existing metadata validation
> infrastructure that XFS uses, and so I know it's limitations in
> intimate detail. It is, by far, the closest thing we have to
> complete runtime metadata validation in any Linux filesystem
> (except maybe bcachefs), but it is nowhere near able to detect and
> prevent 100% of potential structure corruptions.
>=20
> It is *far from trivial* to validate all the weird corner cases that
> exist in the on-disk format that have evolved over the last 3
> decades. For the first 15 years of development, almost zero thought
> was given to runtime validation of the on-disk format. People even
> fought against introducing it at all. And despite this, we still
> have to support the on-disk functionality those old, difficult to
> validate, persistent structures describe.
>=20
> [ And then there's some other random memory corruption bug in the
> code, and all bets are off... ]
>=20
> IOWs, no filesystem developer is ever going to give you a guarantee
> that a filesystem implementation is free from memory corruption bugs
> unless they've designed and implemented from the ground up to be
> 100% safe from such issues. No such filesystem exists in the kernel,
> and it will probably be years away before anything may exist to fill
> that gap.

That makes sense. =20

> > > The typical desktop policy of "probe and automount any device that
> > > is plugged in" prevents the user from examining the device to
> > > determine if it contains what it is supposed to contain.  The user
> > > is not given any opportunity to device if trust is warranted before
> > > the kernel filesystem parser running in ring 0 is exposed to the
> > > malicious image.
> > >=20
> > > That's the fundamental policy problem we need to address: the user
> > > and/or admin is not in control of their own security because
> > > application developers and/or distro maintainers have decided they
> > > should not have a choice.
> > >=20
> > > In this situation, the choice of what to do *must* fall to the user,
> > > but the argument for "filesystem corruption is a CVE-worthy bug" is
> > > that the choice has been taken away from the user. That's what I'm
> > > saying needs to change - the choice needs to be returned to the
> > > user...
> >=20
> > I am 100% in favor of not automounting filesystems without user
> > interaction, but that only means that an exploit will require user
> > interaction.  Users need to get things done, and if their task requires
> > them to a not-fully-trusted filesystem image, then that is what they
> > will do, and they will typically do it in the most obvious way possible.
> > That most obvious way needs to be a safe way, and it needs to have good
> > enough performance that users don't go around looking for an unsafe way.
>=20
> Well, yes, that is obvious, and not a point of contention at all,
> as is evidenced by the list of solutions to this problem I outlined.

What kind of performance do the existing solutions (libguestfs, lklfuse)
have?

> > > > or running it in a sufficiently tight
> > > > sandbox that vulnerabilities in it are of too low importance to mat=
ter.
> > > > libguestfs+FUSE is the most obvious way to do this, but the perform=
ance
> > > > might not be enough for distros to turn it on.
> > >=20
> > > Yes, I have advocated for that to be used for desktop mounts in the
> > > past. Similarly, I have also advocated for liblinux + FUSE to be
> > > used so that the kernel filesystem code is used but run from a
> > > userspace context where the kernel cannot be compromised.
> > >=20
> > > I have also advocated for user removable devices to be encrypted by
> > > default. The act of the user unlocking the device automatically
> > > marks it as trusted because undetectable malicious tampering is
> > > highly unlikely.
> >=20
> > That is definitely a good idea.
> >=20
> > > I have also advocated for a device registry that records removable
> > > device signatures and whether the user trusted them or not so that
> > > they only need to be prompted once for any given removable device
> > > they use.
> > >=20
> > > There are *many* potential user-friendly solutions to the problem,
> > > but they -all- lie in the domain of userspace applications and/or
> > > policies. This is *not* a problem more or better code in the kernel
> > > can solve.
> >=20
> > It is certainly possible to make a memory safe implementation of amy
> > filesystem.
>=20
> Spoken like a True Expert.

I am saying this in the sense of "it is possible to make a memory safe
implementation of *anything*, unless that thing exposes a memory unsafe
API.".  It's a generic statement about programs in general.  It does not
imply that doing so is practical.

> > If the current implementation can't prevent memory
> > corruption if a malicious filesystem is mounted, that is a
> > characteristic of the implementation.
>=20
> Ah, now I see what you are trying to do. You're building a strawman
> around memory corruption that you can use the argument "we need to
> reimplement everything in Rust" to knock down.
>=20
> Sorry, not playing that game.

There are other options, like "run the filesystem in a tightly sandboxed
userspace process, especially compiled through WebAssembly".  The
difficulty is making them sufficiently performant for distributions to
actually use them.

> > However, the root filesystem is not the only filesystem image that must
> > be mounted.  There is also a writable data volume, and that _cannot_ be
> > signed because it contains user data.  It is encrypted, but part of the
> > threat model for both Android and ChromeOS is an attacker who has gained
> > root or even kernel code execution and wants to retain their access
> > across device reboots. They can't tamper with the kernel or root
> > filesystem, and privileged userspace treats the data on the writable
> > filesystem as untrusted.  However, the attacker can replace the writable
> > filesystem image with anything they want,
>=20
> And therein lies the attack a fielsystem implementation can't defend
> against: the attacker can rewrite the unencrypted block device to
> contain anything they want, and that will then pass verification on
> the next boot. Perhaps that's the class of storage attack you should
> seek to prevent, not try to slap bandaids over trust model
> violations or insinuate the only solution is to rewrite complex
> subsystems in Rust....

The Chrome OS and Android threat models require that they remain secure
no matter what the contents of the unsigned block device actually are,
even if they are completely malicious.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--gJn/WH0kaLCMp1ft
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmfa2vMACgkQszaHOrMp
8lOcpA//UMgEPqZkVnreLSPBSJyFUb1QUNe7uIl5vUbwNEjrTXdonIfAaBRg2jIv
j7/nRxdbUDCQG0gZc9Gd8mWnZlZVi2lrjcYMzyUEfPV/eX+dGyB03xmUTWgPRiqU
NMgnGAcLNHy647kXfzHoP2F/B3Wt8+MRK4rSMKZH7PnwyoyVR8xAd2BrMRRyUYb+
uBKDhl7n2Knf+OzS9N/ZUdy6ABlkqetszR1OP6a8hOaKnG/He/Z1hZyIZSTWd3xH
sW2mQEoXXtUJyHQUs72/PLfWeuDs/m2q6cABtX/JGDtH013WY06m9OUGLgDGkVt3
3rtnxBmEnf09pWyOsvoDDD7mFaVogFb5c9f4jWyo7IBtGSAykmFXUh3pLfS6GJfk
ccUZDhDQs4Ro9G+IBa9JmV9/avqxVSMPeuX/Wm2DCNfPbjyUV6Q3CVWlhffXs77d
K7c5Rpkc4yeYUkEGiZDlbCYcJcMcSqEgZq/FqO+OkG7kpKwPwXgl/DZ8/e4mB77R
EC470TjjJHYGlrsdwVF9eB3b0Fc8x0gow5BJOA01qcFAVy6gQPcKjA3ejbGCu2xW
TrQEQGiWw4LuqJTQ7v9v2VnZn61Zy4GkIiPBH2iE+V6uTfuuRmT8X/FH3IhFovPB
DQIdXvu16oy7CLmmU2Sd4CEwrRpUB/YEeCqOehK4nSiGVgz4WnQ=
=JTKC
-----END PGP SIGNATURE-----

--gJn/WH0kaLCMp1ft--

