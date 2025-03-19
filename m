Return-Path: <linux-fsdevel+bounces-44467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99ACA696C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B12D881F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CA202979;
	Wed, 19 Mar 2025 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="0yoPHxvN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9SNzGNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1B1DE4FF;
	Wed, 19 Mar 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406250; cv=none; b=kFhCWWc5Nil38jOZqgXIx2hmnVVRFih2/Xh1TsSP6yX5lwSYzCI9qwMVDzbqDruSoaPXZIusntuknQX/8dYcvQ+yKDQ+X6IBkxqwDXrXM2AnmjFoVtRBWuGf/i7RlG1iIGxXpv5JYS+S5zfnWdg1Js2/etpdPKS7XsQPbh5fiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406250; c=relaxed/simple;
	bh=JzT5hud3FFKMKtIDoWSnB5zcQti65fif8taowP7NhhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Exp9pJ2+K0MYFVB2XFuuMvgw6UMNEk+ZqtFMFfs4ks23BDGezNIGNSoJ2PkCZfA6idpm/Smaj8vjcB6ZzMQ8bI8mtGzMAJPuctMZb2cdXOEO6/ph6h/fz6MpH6SlpRdAtEPdKuP90S+MV8jsexmuYkwSrC6FOU0Zhne/kw2pYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=0yoPHxvN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9SNzGNu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4936225400A2;
	Wed, 19 Mar 2025 13:44:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 19 Mar 2025 13:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742406247;
	 x=1742492647; bh=zB6ZRf3c6pO2URHszAPQbA4dx5JJIaII0NuZzQVfRT8=; b=
	0yoPHxvNt9J+ZYv8OZtgjw+2LBmA1iDC68J255warXN4Nb5VD8DuJvy/gSRYP50V
	SyWxORt7jNq1oeZ5fuv0pA3HIPy+w0+1zQpvqL/TjI6xhSuVgW+5lwT9GyGsW2ZX
	djMLTX8b3xSf/ipGaU/wVW5ygQ++t9gNhA0oUI3L5wteStkatuE1OvWAO6hqrcpA
	EgRtyh3DVTnaMxJqk0tOwriSawRKE7D9Fodv6TqhR7YLUfjX5Azfr7/csc30kqBc
	koOR06UEvAZ3xZiI96lbp2KmI96wROX9nR0BXhTFx4/DU1h2E90zmnQTx924q1cW
	0NA/LrF6xCpElZHpk7NDlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742406247; x=1742492647; bh=zB6ZRf3c6pO2URHszAPQbA4dx5JJIaII0Nu
	ZzQVfRT8=; b=l9SNzGNujw9TSoY/Dx51bW/6TAfp7YMH8eVl4jyrjEXW3N9QXJA
	r78++2smGi/Gk9285gZpLViWGa170wP65R3AcNtGNNYjkJaKoMBWcMxQtgWJTxue
	lwUAzO8fhmroAwS5tFnIfP1hJuCEIfSh3TR5WW9sA3AB6StOEP+3YjYWM/qiGTqO
	tcmzof79CdLa5fsQQLhRyzzGN335HzewDWkZWw6iCrverCPUwoTKaksMwuXU2+Ig
	XnZW3WnsypJhvNh8tmKu4Delwa77PKksmtKCiAlkJaF0QTvvxLypzyXIUotDATCl
	E3daIJLGGCDBTscEKXgp6VBLlDfHkauLIJA==
X-ME-Sender: <xms:ZgLbZ_U9kcqVyj-eZ3gbp17gtL9zAVftclnLXM5-a87sBjN_aQMB9A>
    <xme:ZgLbZ3mbU5nunjthERAZ7WXlxKk2QbYabI1FpCFMo1Dxm6DQKlkjIHBCMdykUVreR
    OjMcJlSm66CXoE>
X-ME-Received: <xmr:ZgLbZ7ZANJ9x6HpLrfBD0nd3L2g3DbbT8v_6uPrtSujtcUpwyxJpPzspSKjbBXmk5sMH-lHuW1djCiYmfvGVEr6P173PXU8p3qx-DjwN1O4jeCXq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ZgLbZ6V9DnyhkC5uWLbiUoFBFsCyKJM_aabPn3T1mxAEwUrUMBxVrA>
    <xmx:ZgLbZ5mBbf34iM4hKx7UbEadSEWIK9eeT-LKgt2xOD4BFomATO6Hcg>
    <xmx:ZgLbZ3dAAvJcWGHU2Acx4vTTUQ0PFIx0apT8brlGVeawtaEJXwrOVw>
    <xmx:ZgLbZzHuMSP6Txrq58rs97a-F-Uz6yUjHGCaf654enKtVxz6mm0acQ>
    <xmx:ZwLbZ_delYsivibNlruuGnukXMaIWxPi9vjRoItCZ0UqdO8GwbJBtxHY>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 13:44:06 -0400 (EDT)
Date: Wed, 19 Mar 2025 13:44:13 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
	gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z9sCcbZ7sdBgbX77@itl-email>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <20250318221128.GA1040959@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6SHvia9fKGYi0QHp"
Content-Disposition: inline
In-Reply-To: <20250318221128.GA1040959@mit.edu>


--6SHvia9fKGYi0QHp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Mar 2025 13:44:13 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
	gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts

On Tue, Mar 18, 2025 at 06:11:28PM -0400, Theodore Ts'o wrote:
> On Tue, Mar 11, 2025 at 04:10:42PM -0400, Demi Marie Obenour wrote:
> >=20
> > Why is it not possible to provide that guarantee?  I'm not concerned
> > about infinite loops or deadlocks.  Is there a reason it is not possible
> > to prevent memory corruption?
>=20
> Companies and users are willing to pay to improve performance for file
> systems.  q(For example, we have been working for Cloud services that
> are interested in improving the performance of their first party
> database products using the fact with cloud emulated block devices, we
> can guarantee that 16k write won't be torn, and this can resul;t in
> significant database performance.)
>=20
> However, I have *yet* to see any company willing to invest in
> hardening file systems against maliciously modified file system
> images.  We can debate how much it might cost it to harden a file
> system, but given how much companies are willing to pay --- zero ---
> it's mostly an academic question.

Google _ought_ to be willing to pay for ext4 and f2fs.  Have you asked
ChromeOS and Android security about this?  Exploits involving malicious
filesystem images are in scope for their bug bounty programs.

> In addition, if someone made a file system which is guaranteed to be
> safe, but it had massive performance regressions relative other file
> systems --- it's unclear how many users or system administrators would
> use it.  And we've seen that --- there are known mitigations for CPU
> cache attacks which are so expensive, that companies or end users have
> chosen not to enable them.  Yes, there are some security folks who
> believe that security is the most important thing, uber alles.
> Unfortunately, those people tend not to be the ones writing the checks
> or authorizing hiring budgets.
>=20
> That being said, if someone asked me if it was best way to invest
> software development dollars --- I'd say no.  Don't get me wrong, if
> someone were to give me some minions tasked to harden ext4, I know how
> I could keep them busy and productive.  But a more cost effective way
> of addressing the "untrusted file sytem problem" would be:
>=20
> (a) Run a forced fsck to check the file system for inconsistency
> before letting the file system be mounted.
>=20
> (b) Mount the file system in a virtual machine, and then make it
> available to the host using something like 9pfs.  9pfs is very simple
> file system which is easy to validate, and it's a strategy used by
> gVisor's file system gopher.
>=20
> These two approaches are complementary, with (a) being easier, and (b)
> probably a bit more robust from a security perspective, but it a bit
> more work --- with both providing a layered approach.

Definitely a good idea.

> > > In this situation, the choice of what to do *must* fall to the user,
> > > but the argument for "filesystem corruption is a CVE-worthy bug" is
> > > that the choice has been taken away from the user. That's what I'm
> > > saying needs to change - the choice needs to be returned to the
> > > user...
>=20
> Users can alwayus do stupid things.  For example, they could download
> a random binary from the web, then execute it.  We've seen very
> popular software which is instaled via "curl <URL> | bash".  Should we
> therefore call bash be a CVE-vulnerability?
>=20
> Realistically, this is probably a far bigger vulnerability if we're
> talking about stupid user tricks.  ("But.... but... but... users need
> to be able to install software" --- we can't stop them from piping the
> output of curl into bash.)  Which is another reason why I don't really
> blame the VP's that are making funding decisions; it's not clear that
> the ROI of funding file system security hardening is the best way to
> spend a company's dollars.  Remember, Zuckerburg has been quoted as
> saying that he's laying off engineers so his company can buy more
> GPU's, we know that funding is not infinite.  Every company is making
> ROI decisions; you might not agree with the decisions, but trust me,
> they're making them.
>=20
> But if some company would like to invest software engineering effort
> in addition features or perform security hardening --- they should
> contact me, and I'd be happy to chat.  We have weekly ext4 video
> conference calls, and I'm happy to collaborate with companies have a
> business interest in seeing some feature get pursued.  There *have*
> been some that are security related --- fscrypt and fsverity were both
> implemented for ext4 first, in support of Android and ChromeOS's
> security use cases.  But in practice this has been the exception, and
> not the rule.

Android and ChromeOS do _not_ allow you to run curl <URL> | bash, at
least outside of a VM.

> > Not automounting filesystems on hotplug is a _part_ of the solution.
> > It cannot be the _entire_ solution.  Users sometimes need to be able to
> > interact with untrusted filesystem images with a reasonable speed.
>=20
> Running fsck on a file system *before* automounting file systems would
> be a pretty decent start towards a solution.  Is it perfect?  No.  But
> it would provide a huge amount of protection.
>=20
> Note that this won't help if you have a malicious hardware that
> *pretends* to be a USB storage device, but which doens't behave a like
> a honest storage device.  For example, reading a particular sector
> with one data at time T, and a different data at time T+X, with no
> intervening writes.  There is no real defense to this attack, since
> there is no way that you can authentiate the external storage device;
> you could have a registry of USB vendor and model id's, but a device
> can always lie about its id numbers.

This attack can be defended against by sandboxing the filesystem driver
and copying files to trusted storage before using them.  You can
authenticate devices based on what port they are plugged into, and Qubes
OS is working on exactly that.

> If you are worried about this kind of attack, the only thing you can
> do is to prevent external USB devices from being attached.  This *is*
> something that you can do with Chrome and Android enterprise security
> policies, and, I've talked to a bank's senior I/T leader that chose to
> put epoxy in their desktop, to mitigate aginst a whole *class* of USB
> security attacks.

Or you can disable your firmware's USB stack and ensure that USB devices
are only attached to virtual machines.  Dasharo allows the former, and
Qubes OS allows the latter.

(Disclaimer: I work on Qubes OS).

> Like everything else, security and usability and performance and costs
> are all engineering tradeoffs.  So what works for one use case and
> threat model won't be optimal for another, just as fscrypt works well
> for Android and ChromeOS, but it doesn't necessarily work well for
> other use cases (where I might recommed dm-crypt instead).

Is the tradeoff fundamental, or is it a consequence of Linux being a
monolithic kernel?  If Linux were a microkernel and every filesystem
driver ran as a userspace process with no access to anything but the
device it is accessing, then there would be no tradeoff when it comes to
filesystems: a compromised filesystem driver would have no more access
than the device itself would, so compromising a filesystem driver would
be of much less value to an attacker.  There is still the problem that
plug and play is incompatible with not trusting devices to identify
themselves, but that's a different concern.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--6SHvia9fKGYi0QHp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmfbAm4ACgkQszaHOrMp
8lPcUg//fmUmchrAVJ0yMUnR1YT5Qc+IL6H4fOXOzaY5AwGFfsMFgZQZEOuodF8O
ym8pSj9l9hDpQbLUDKn6xWr3zEncy2508ve+jggoEvxasi04QMhYnze20v2+Bpjj
rMK8/6Qdsyp3KfndxB5Bf1O1FX2CpYOK6OJIkXLfVrwrw3R6Un0KKjTF5D4F59BT
+WioHos6YyWWe8l5jk/5e/Ko5LD/GCJUxaUXcyExqfvsi6vcUyNed4HS70Vyqtv3
/lzX02fRNGt97pOp0SteqIDSlu7viRXP6oe0ss8qFl2Tt2fkRoZUBCs7itNYGR0g
Q33w0/aCs+VYZo3B4KlveTpxTkRgrXpnluO/TZzEJpRCvwqmRgrM5CVupBLzpM/V
K9sgBV9Zr002/kjnGBdCLsVp/FSeyxj0/MkQf/i4dIM4lfIvAChPXxVBZYJdlcT3
xYwsDGMpK54dn2MNwrvBVMLkaWnDcXaSdkKx6cITJncWRdG+Y2JBHj9kIqNOPSQT
AartmqGbueUbIty3gGsnJzUEWxlksg4Q7Kk5icKA+g+aHbfGrDHwA8ntmEYqhoKP
M2F7dAHKov2Q5V+e+gIx3AIR1n+wVvdmdgtjlwysFNPLo763eb0ME3e900ttkqn0
lPzc0lEgXIxSF/JZ1N0acibydBgcU9SvzNC4jyFl5bV0S9Vaj7U=
=thIz
-----END PGP SIGNATURE-----

--6SHvia9fKGYi0QHp--

