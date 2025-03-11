Return-Path: <linux-fsdevel+bounces-43737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B862A5D078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE741743D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1C264618;
	Tue, 11 Mar 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="BZi98jxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6vfl1PVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F226461D;
	Tue, 11 Mar 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723853; cv=none; b=l+jN6cTnpHvGes52hsOIFTr8+qzhMlyZ0YgzSZtyILUL4CiafSINUBUxYZl3t6puUUcCEwJ6q6x272JDsYi+1rKVrnPZtcdhySn+Wuvin/x+YwXP/HuGUrPQngVnMv31yrM68AE+JRB50qYE3IOG5wKFnBnoKmHK959iJKQQ73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723853; c=relaxed/simple;
	bh=2MU0gOYAL/ai1oWU9O2tTiuHC/o/Cc/YKJUuJ8iS1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru8Mql8adWun7BI8HBYF0B733F+6y990fEFUrlGv0VmxtKqcvBWUXrkyPF0JoQrWSngzIIG3bgpKaY/scyUxnHbxGL19CBs+5vFMHK3iaXfCoNn4/QaP73Bvwj6oXo1I1XmUyeT8jESgac0jdR2ZSKvDL0GBtSyArH/gkT2C/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=BZi98jxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6vfl1PVv; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A6C19114017B;
	Tue, 11 Mar 2025 16:10:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 11 Mar 2025 16:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741723849;
	 x=1741810249; bh=dn6QEOnD/tFlEnChhXNqBB9U+ce/1qeKFhAwsK9Uy24=; b=
	BZi98jxfQtouISgnCnqrOtpQ8ZP0B7BLAWsjSefJEnd28c+1pMDGjSS4KnOGRfUS
	keIegsc8bFfmaupCVT8zNI7QfAVzHhLUYre0z06SL/SWIFWKWeSUCEKSrCOBYGa+
	/zhNVURO7IEF/YH/hgQPOM16Lhtzr2fPK4zguCa0zXp+Ilt3nR5r7b0hXDJGXIiK
	6dBUPbh1DMdONAWg4b9odPr+OoAqgj5zuiB/lV5MCuxqCISaG2dLa+3wu9C12xQj
	vLP9F2yWSvtIJqAlZZJIQsvNNIEmCx4KbER3cunE74XHGIOuMgrOwTgk5FDjDlXw
	Zd94rKl2GAMGtPzSnfY8Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741723849; x=1741810249; bh=dn6QEOnD/tFlEnChhXNqBB9U+ce/1qeKFhA
	wsK9Uy24=; b=6vfl1PVvhTz2fdi7T1Lf+MWdKU8z+ZxzIcWez9NHo8ogGHbbW55
	JJGP1m2xRcS/EWWyyFYfkxfHix9DfPq1/amZ0QOuu8FqzvuAzR3ZDRzHGA2FM7vq
	VWzHNXo6InlQ7ytyTB5PVa0Ozveo00fAB0OkWESafNNCaWvyWyfaJwhl9GOvCnA6
	UJ33yxBpZtk9tYinRYnR2PODx23xsJjzWp704A4uic++GGxXjHxNqL2k3SZeAGS4
	k0qKerJPE5Ym4JWDoUfuHDKrEoOSP00jgym+C1B5nb590Imf6+DRU4WB6uKU/5lp
	b0qiO3XZuu1yDlyRmrF0Lg1KdoK9vq967wg==
X-ME-Sender: <xms:yZjQZ_XmFq0oPFW2vk5kLzLA6iNx12Zs56KqtJMhMbSAZzGpwO9SCw>
    <xme:yZjQZ3mQEu4HjMGGxq3KqvU2ESIlqmgE8vyfkXwWHq3NDSiviPyQbJkGy_bKOR2Cs
    cTkWcsXT2J-GUg>
X-ME-Received: <xmr:yZjQZ7aRoCBuMWnxwEW2KDu9XVYX2oOARsk0Qm6vtVX-tLtIn1HOaAaTjsMUdJPk7mu1kv7To_rhyuYYjwA5Tj1XRLPBKdJSyWlhKdEc0u_nvt4t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefudeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:yZjQZ6X68pOFZIQqyS43YVNuJzbP3wFDAI0HyFLViWWjbuExNl8Y4w>
    <xmx:yZjQZ5m6BK60oH1rgDCHa2CLAAK6zKGS5YU3D4KYhTh8zvgDvgU3LA>
    <xmx:yZjQZ3eFm4sIYtHSbZdHvX1VhrfoOI56PwVYbyaJPmtzGaYk0yyEUQ>
    <xmx:yZjQZzFPctnw2opqxmdsOVFnDSe3KePKbfA_PYmhz2YXP-DIMrX5wg>
    <xmx:yZjQZyclY7bNXpxll-i3mHhy8SOtoFVJyUpLGm-4vUGRnNV4XMKoXnao>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 16:10:48 -0400 (EDT)
Date: Tue, 11 Mar 2025 16:10:42 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Dave Chinner <david@fromorbit.com>
Cc: cve@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <Z9CYzjpQUH8Bn4AL@itl-email>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hn1Vze6VEWfM0U7H"
Content-Disposition: inline
In-Reply-To: <Z8_Q4nOR5X3iZq3j@dread.disaster.area>


--Hn1Vze6VEWfM0U7H
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Mar 2025 16:10:42 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Dave Chinner <david@fromorbit.com>
Cc: cve@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts

On Tue, Mar 11, 2025 at 04:57:54PM +1100, Dave Chinner wrote:
> On Mon, Mar 10, 2025 at 10:19:57PM -0400, Demi Marie Obenour wrote:
> > People have stuff to get done.  If you disallow unprivileged filesystem
> > mounts, they will just use sudo (or equivalent) instead.
>=20
> I am not advocating that we disallow mounting of untrusted devices.
>=20
> > The problem is
> > not that users are mounting untrusted filesystems.  The problem is that
> > mounting untrusted filesystems is unsafe.
>=20
> > Making untrusted filesystems safe to mount is the only solution that
> > lets users do what they actually need to do. That means either actually
> > fixing the filesystem code,
>=20
> Yes, and the point I keep making is that we cannot provide that
> guarantee from the kernel for existing filesystems. We cannot detect
> all possible malicous tampering situations without cryptogrpahically
> secure verification, and we can't generate full trust from nothing.

Why is it not possible to provide that guarantee?  I'm not concerned
about infinite loops or deadlocks.  Is there a reason it is not possible
to prevent memory corruption?

> The typical desktop policy of "probe and automount any device that
> is plugged in" prevents the user from examining the device to
> determine if it contains what it is supposed to contain.  The user
> is not given any opportunity to device if trust is warranted before
> the kernel filesystem parser running in ring 0 is exposed to the
> malicious image.
>=20
> That's the fundamental policy problem we need to address: the user
> and/or admin is not in control of their own security because
> application developers and/or distro maintainers have decided they
> should not have a choice.
>=20
> In this situation, the choice of what to do *must* fall to the user,
> but the argument for "filesystem corruption is a CVE-worthy bug" is
> that the choice has been taken away from the user. That's what I'm
> saying needs to change - the choice needs to be returned to the
> user...

I am 100% in favor of not automounting filesystems without user
interaction, but that only means that an exploit will require user
interaction.  Users need to get things done, and if their task requires
them to a not-fully-trusted filesystem image, then that is what they
will do, and they will typically do it in the most obvious way possible.
That most obvious way needs to be a safe way, and it needs to have good
enough performance that users don't go around looking for an unsafe way.

> > or running it in a sufficiently tight
> > sandbox that vulnerabilities in it are of too low importance to matter.
> > libguestfs+FUSE is the most obvious way to do this, but the performance
> > might not be enough for distros to turn it on.
>=20
> Yes, I have advocated for that to be used for desktop mounts in the
> past. Similarly, I have also advocated for liblinux + FUSE to be
> used so that the kernel filesystem code is used but run from a
> userspace context where the kernel cannot be compromised.
>=20
> I have also advocated for user removable devices to be encrypted by
> default. The act of the user unlocking the device automatically
> marks it as trusted because undetectable malicious tampering is
> highly unlikely.

That is definitely a good idea.

> I have also advocated for a device registry that records removable
> device signatures and whether the user trusted them or not so that
> they only need to be prompted once for any given removable device
> they use.
>=20
> There are *many* potential user-friendly solutions to the problem,
> but they -all- lie in the domain of userspace applications and/or
> policies. This is *not* a problem more or better code in the kernel
> can solve.

It is certainly possible to make a memory safe implementation of amy
filesystem.  If the current implementation can't prevent memory
corruption if a malicious filesystem is mounted, that is a
characteristic of the implementation.

> Kees and Co keep telling us we should be making changes that make it
> harder (or compeltely prevent) entire classes of vulnerabilities
> from being exploited. Yet every time we suggest that a more secure
> policy should be applied to automounting filesystems to prevent
> system compromise on device hotplug, nobody seems to be willing to
> put security first.

Not automounting filesystems on hotplug is a _part_ of the solution.
It cannot be the _entire_ solution.  Users sometimes need to be able to
interact with untrusted filesystem images with a reasonable speed.

> > For ext4 and F2FS, if there is a vulnerability that can be exploited by
> > a malicious filesystem image, it is a verified boot bypass for Chrome OS
> > and Android, respectively. Verified boot is a security boundary for
> > both of them,
>=20
> How does one maliciously corrupt the root filesystem on an Android
> phone? How many security boundaries have to be violated before
> an attacker can directly modify the physical storage underlying the
> read-only system partition?
>=20
> Again, if the attacker has device modification capability, why
> would they bother trying to perform a complex filesystem
> corruption attack during boot when they can simply modify what
> runs on startup?
>=20
> And is this a real attack vector that Android must defend against,
> why isn't that device and filesystem image cryptographically signed
> and verified at boot time to prevent such attacks? That will prevent
> the entire class of malicious tampering exploits completely without
> having to care about undiscovered filesystem bugs - that's a much
> more robust solution from a verified boot and system security
> perspective...

On both Android and ChromeOS, the root filesystem is a dm-verity volume,
and the Merkle tree hash is either signed or is part of the signed
kernel image.  The signed kernel image is itself verified by the
bootloader.  Therefore, the root filesystem cannot be tampered with.

However, the root filesystem is not the only filesystem image that must
be mounted.  There is also a writable data volume, and that _cannot_ be
signed because it contains user data.  It is encrypted, but part of the
threat model for both Android and ChromeOS is an attacker who has gained
root or even kernel code execution and wants to retain their access
across device reboots.  They can't tamper with the kernel or root
filesystem, and privileged userspace treats the data on the writable
filesystem as untrusted.  However, the attacker can replace the writable
filesystem image with anything they want, so the if they can craft an
image that gains kernel code execution the next time the system boots,
they have successfully obtained persistance.

Also, at least Google Pixels support updating the OS via the bootloader.
The bootloader checks that the image was signed by the OS vendor
(generally, but not always, Google), and I believe it also checks for
downgrade attacks.  However, this means of updating the OS doesn't
wipe user data.  This means that if an attacker has gained code
execution with root or even kernel privileges, updating the OS to a
version that has patched the vulnerability the attacker used will revoke
their access.  The same is true if the attacker used USB for their
exploit and the reboot happens after the user has unplugged the USB
device.

Furthermore, on UEFI systems the EFI System Partition cannot be
cryptographically protected as the firmware does not support this.

> > so just forward syzbot reports to their respective
> > security teams and let them do the jobs they are paid to do.
>=20
> Security teams don't fix "syzbot bugs"; they are typically the
> people that run syzbot instances. It's the developers who then
> have to triage and fix the issues that are found, so that's who the
> bug reports should go to (and do). And just because syzbot finds an
> issue, that doesn't make it a security issue - all it is is another
> bug found by another automated test suite that needs fixing.

Browser vendors consider many kinds of memory unsafety problems to be
exploitable until and unless proven otherwise.  My understanding is that
experience has proven them to be correct in this regard.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--Hn1Vze6VEWfM0U7H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmfQmMsACgkQszaHOrMp
8lPrig/+Og5RxJBoq0Y6y0OklxfT6sQYX65AxmdYbIzuL/mLpKpdwlIQWQtAa/Gw
teeqI+W7PJEU4NXoWMuJkbZ0llDbsmaQMuaJ7nVQ5jW9IQDYImQl9fvaNmRqSEDZ
0PVJ9jUNN+DdczL3XrOMi/Ky+okUtJd/PqAWeV9P6MVTxei7dDcJYxybas3m79NA
kJu1o1BmJQiyOffe3opNT53foASN6PjsJObHzy8Z5F7CmVc+kkr4JLKYht7ri4Vu
dhfkgot/6mQBZfM5Cc+/hBu0TQEgQ7SKE5EZAzStuQNuFTvvS5tdUYaxFVcqDRhN
qK4vg4T/fTO8Ex7nXIlBK5jrlx5t9xemzTjOzJnhK2sy3SEtdpwLA1Gwz3G1c9Dt
KOTT0LBxUr0lRqmr/pmNt5LAaVkzFnuQLCr77cIrQoXmQ9fQpH/QRt0HawtEsFFx
mW1uni2weXdjq662ThnMRwqJjSZ+Jz6CBEgUy+EDhonv5PVosj1ZTjIVcEeBXHy+
gYxlt9x6xoyNR6yOkYnTU4BEKErJK/5B+H4rpM9F6OhAwIWiT1q9Mt8TbOZrUpRJ
EiLnx2Kse98Yl1p9CfQQeW5Ede4kCPsL76V7JCZ1PSkSBYu1+xthJv6PHO+HtszL
7tAvaML25fyQvdx8l1WImskc1tewv3HVNHPisMYKv7OJcKgak4Q=
=dfMM
-----END PGP SIGNATURE-----

--Hn1Vze6VEWfM0U7H--

