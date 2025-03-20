Return-Path: <linux-fsdevel+bounces-44512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB40A69FCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 07:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AA5189D803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987771E231D;
	Thu, 20 Mar 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="sRRPdfzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zdq5L2XQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520FA1DED78;
	Thu, 20 Mar 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452007; cv=none; b=XgNh9r8KZShCZSpHKxG7O1KOqwGgb9T0zFwLJYihB14LTqeTYLi0d7XFUZo6AOMN9uNZLXYQ7VDhPpUou5y4HdvKSs1ckqKNdr2n4XGPlzPXZBsUkxtznnSoEbTFuLXWY7P0D7xphSBpofjwc0Kwhn/leWGpR84z95C2Khi6IN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452007; c=relaxed/simple;
	bh=i/qrXHIphOpxKYs4HEUU1NvE+Q2atosoNhaiJnQKV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC2XVux0EM7M0XAtJiCcVzVhu+EW+Bn7D7+wV7mC3mkBhC6NranmXH3IA+1rPX8ryj01nA9AVPzd38muLqt1bslugfXdGJoAv6sTtnNwGygcr30PQmPitIhVkSJno1sx/gQRhIGyIFzLkoIvvbP4hCUanE/X5Gutne7vvwD23L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=sRRPdfzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zdq5L2XQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CA491382D3A;
	Thu, 20 Mar 2025 02:26:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Mar 2025 02:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742452004;
	 x=1742538404; bh=TiiPAq9/peILLm7Tqz0wfLhXOd9gXnWtTa59gXAGZQM=; b=
	sRRPdfzyNHpIaTJlb2gjkaYzwwE+dllnmFkRsrQXN1Zx856aIVvpzzeHZ9jDEmIb
	mddoHw/mQh5scMMFWxpIWpZG8gVHmTwqaPbgdMyp1YXV2Mykoj9CQD0xEU3v/X6Q
	aO3Oho/twsutx/QaDthx2OT7OI/lG/pxNr8AMh/LhcvI3hmYrQM97VBE1/C6988x
	+90f1DHLCc6lxDviRwNK5xK1avcC2rB6kvV+OlzP3KHyagqgTQA+yIY3TKIeSPkj
	BIlG5r/m99dsjrYxxwH8ZxQv2xaB6rhVuGSlPDaWvv/2mJTTueM8UG7Ne0EBX/3q
	l7OdGvH1BT4LGSCzdGhY9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742452004; x=1742538404; bh=TiiPAq9/peILLm7Tqz0wfLhXOd9gXnWtTa5
	9gXAGZQM=; b=zdq5L2XQr0tAdCU8BQVAk9otAlg7XxhJK6qMv/vynqfC8DRoRa4
	w+/qjell4POMfw0nsD7BRgzL/bd4asxguyDYpREVM7ot8mPDJYmTr7IYjOnxM5L/
	6Eqe5o/EJczD5yh/1wnuUoj+CjNzCGvZzAxEYIRwW+69ixFRLAbxmqix19amBIPR
	bKHMvKbgRnv/pHEQ75JzzrvA023o9gJtRidszMiOZWJcGdsp/BdvUboEVZmRX11E
	n5V05KokINOsqsHs2rKn9eWNe/DqFd+21SrdCaUIcEURFaO5khh0zrPSS55PP6XQ
	IaymYAsDwU19hQSyoSnrtT/PxxlFARoZFEA==
X-ME-Sender: <xms:I7XbZ6cmU5eviRFlZLCx37Kr5QO_97_06dxfcPq4qESGiHQ25A4QaQ>
    <xme:I7XbZ0ObC9_HRu5FXjDzgk8c_Q7iGxOn7X3pc_GifH3Ye5ip1cAC3uDLvPBigEHRa
    vCmKmySylqM-EQ>
X-ME-Received: <xmr:I7XbZ7ilk5gKyX2fah1tuoc23Xzm7oAVnwMxRff_gO7_o5LqMCqArWoQ1cW9gzbvX9pk9AtnLd1OwC2A5s2crvRGblftBfVTsfQL-0cBDMpZ2h5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghmihcuofgrrhhivgcu
    qfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffejgeejgeffkeelveeu
    leeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepth
    ihthhsohesmhhithdrvgguuhdprhgtphhtthhopegurghvihgusehfrhhomhhorhgsihht
    rdgtohhmpdhrtghpthhtoheptghvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehkvghnthdrohhvvghrshhtrh
    gvvghtsehlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqsggtrggthhgvfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggt
    uhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:I7XbZ39LRDgh8yWyMhfz-p2vtd-EreU8VFIwo0ul6Ki7LL-Sr9OmfA>
    <xmx:I7XbZ2sDQEh83UXkYyQcwkTJ3h97lhhgGDL8WKKwKcdZUZyrd4UXAA>
    <xmx:I7XbZ-Ey3rcwFQWD3UiwuBDi-xVD6uy1jPuzuQz18qCfnBLcIGb0eg>
    <xmx:I7XbZ1NhW2MdY37eW-9-EgzFlSbESVW8rcs0fcLnMoZavv7CF2S4Cg>
    <xmx:JLXbZ-G_Whi04b_A3fnYZgf13Ovn-YcGv3rRmpU4bpMu-2gMtO9swNTv>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 02:26:42 -0400 (EDT)
Date: Thu, 20 Mar 2025 02:26:41 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
	gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z9u1L_2o71uEiU4g@itl-email>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <20250318221128.GA1040959@mit.edu>
 <Z9sCcbZ7sdBgbX77@itl-email>
 <20250319212517.GB1079074@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="914y8n7uuSe1zz1m"
Content-Disposition: inline
In-Reply-To: <20250319212517.GB1079074@mit.edu>


--914y8n7uuSe1zz1m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Mar 2025 02:26:41 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
	gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts

On Wed, Mar 19, 2025 at 05:25:17PM -0400, Theodore Ts'o wrote:
> On Wed, Mar 19, 2025 at 01:44:13PM -0400, Demi Marie Obenour wrote:
> > > Note that this won't help if you have a malicious hardware that
> > > *pretends* to be a USB storage device, but which doens't behave a like
> > > a honest storage device.  For example, reading a particular sector
> > > with one data at time T, and a different data at time T+X, with no
> > > intervening writes.  There is no real defense to this attack, since
> > > there is no way that you can authentiate the external storage device;
> > > you could have a registry of USB vendor and model id's, but a device
> > > can always lie about its id numbers.
> >=20
> > This attack can be defended against by sandboxing the filesystem driver
> > and copying files to trusted storage before using them.  You can
> > authenticate devices based on what port they are plugged into, and Qubes
> > OS is working on exactly that.
>=20
> Copying files to trusted storge is not sufficient.  The problem is
> that an untrustworthy storage device can still play games with
> metadata blocks.  If you are willing to copy the entire storage device
> to trustworthy storage, and then run fsck on the file system, and then
> mount it, then *sure* that would help.  But if the storage device is
> very large or very slow, this might not be practical.

Copying flles is not sufficient on its own.  You need to _also_ sandbox
the file system driver, which defeats the attack you mentioned above:
the attacker can compromise the VM running the file system, but that
doesn't give the attacker anything particularly useful.

> > > Like everything else, security and usability and performance and costs
> > > are all engineering tradeoffs....
> >
> > Is the tradeoff fundamental, or is it a consequence of Linux being a
> > monolithic kernel?  If Linux were a microkernel and every filesystem
> > driver ran as a userspace process with no access to anything but the
> > device it is accessing, then there would be no tradeoff when it comes to
> > filesystems: a compromised filesystem driver would have no more access
> > than the device itself would, so compromising a filesystem driver would
> > be of much less value to an attacker.  There is still the problem that
> > plug and play is incompatible with not trusting devices to identify
> > themselves, but that's a different concern.
>=20
> Microkernels have historically been a performance disaster.  Yes, you
> can invest a *vast* amount of effort into trying to make a microkernel
> OS more performant, but in the meantime, the competing monolithic
> kernel will have gotten even faster, or added more features, leaving
> the microkernel in the dust.

The L4 family of microkernels, and especially seL4, show that
microkernels do not need to be slow.  I do agree that making a
microkernel-based OS fast is hard, but on the other hand, running an
entire Linux VM just to host a single application isn't exactly an
efficient use of resources either.  The latter is what systems like Kata
containers wind up doing.

> The effort needed to create a new file system from scratch, taking it
> all the way from the initial design, implementation, testing and
> performance tuning, and making it something customers are comfortable
> depending on it for enterprise workloads is between 50 and 100
> engineer years.  This estimate came from looking at the development
> effort needed for various file systems implemented on monolithic
> kernels, including Digital's Advfs (part of Digital Unix and OSF/1),
> IBM's AIX, and Sun's ZFS, as well as GPFS from IBM (although that was
> a cluster file sytem, and the effort estimated from my talking to the
> engineering managers and tech leads was around 200 PY's.)
>=20
> I'm not sure how much harder it will be to make a performant file
> system which is suitable for enterprise workloads from a performance,
> feature, and stability perspective, *and* to make it secure against
> storage devices which are outside the TCB, *and* to make it work on a
> microkernel.  But I'm going to guess it would inflate these effort
> estimates by at least 50%, if not more.

My understanding is that "Secure against storage devices which are
outside the TCB" mostly requires 2 things:

1. Either a programming language in which memory safety vulnerabilities
   are difficult to introduce by accident, or a sandbox that ensures
   that a compromised file system driver cannot do more than cause file
   system operations to return wrong results.

2. A way to kill a file system that is caught in an infinite loop, is
   eating too much memory, or is otherwise the victim of a denial of
   service attack without crashing the whole system.  This is not needed
   if denial of service attacks are outside of your threat model.

I'm not asking you (or anyone else) to write a filesystem driver that
has no bugs in the face of arbitrarily corrupted input.  I _expect_ that
there will be bugs in this case.  Right now, Linux kernel file systems
are written in C and run in the kernel, which means that a bug can
easily result in a complete system compromise.

> Of course, if we're just witing a super simple file system that is
> suitable for backups and file transfers, but not much else, that would
> probably take much less efort.  But if we need to support file
> exchange with storge devices with NTFS or HFS, thos aren't simple file
> sytes.  So the VM sandbox approach might still be the better way to go.

Certainly the VM sandbox is the simplest approach in the short term.

P.S.: For all that I may disagree with you on a lot of things, I am very
grateful for all the work you have put into making ext4 as solid a
filesystem as it is, as well as for your other innovations (like
creating /dev/{u,}random).
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--914y8n7uuSe1zz1m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmfbtSsACgkQszaHOrMp
8lObFxAAnDVLiENKt8gZ5RINPL9FGb1qerXz+ypGp/05dHmaCikRhlWvxAQSHimR
kmgZk0n4AQMJaR+CE7+8zibBNHgQw/FVb8chetQdux01KP3UIeYC8+xZZ7RKOX41
ThlNB/+0aRhrXuOFW4YSh4m/WOkCCMhe394pnwA+PGRJa9891VCXeqTCopd9TaiG
jjqHpZOTXXM3WAnepYoZnF70XEnLekLmhAZ6vI+j7goWhrNQRAioxlcLecMqWZls
NjNKUXwHvGzbw82IQqZsXV56ykHwrgGmd/EEiHfB7TwOaM0dA/PLr8zoX3b6N6U/
PyI+IYfsJXNlYovD4WLIngX0ur6u5kJtEVh+PwfU9l1eIhjIZprxsxTK+zeqTvB7
8kgoK96HreCqGQKuKH1ZMbIKuw8VipiVq7o+tkCRGlLShQ/ueUUb2FHyzo8n/Rxe
SJT1fxx0fc/v4g8XKI2ly/aZe08/DHPXlUFaFFVn8XKYDp4pJK2u+ePKaV4bWcAa
JVeF5Ps2eBHzT7wBvNqIfmSRjOhrtg/cGSaUPgUNuEOxtcF8HIB/Q5bOCUs5jN/3
Ojhe0JRcPM5PQvwBM37V/vGcYRKtLyahcEOYOdGAAVTvLjLD4fXxjDnVfSSb/5eZ
NtEilvwcivFkDerSQFLSMYq3p4oGUdmBNUaHUoZKmhsJ1N4wOvA=
=XQld
-----END PGP SIGNATURE-----

--914y8n7uuSe1zz1m--

