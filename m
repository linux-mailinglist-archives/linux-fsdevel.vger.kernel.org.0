Return-Path: <linux-fsdevel+bounces-58802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA056B31968
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EB91D00CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919842FF15E;
	Fri, 22 Aug 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="I3zETg6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297A2D97BB;
	Fri, 22 Aug 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869138; cv=none; b=trsnDJjNd+ZQednYSaHa+9pn59ZN/cgwqY/+rDPe4LgGd9uASrLUhxMzhu5Rv6KkKkrgey7DIVni0WspKIT13XM/P8nYt+/06Uq7TAvh8UhkdqF8GeovfHUCBMYdL0Om3m6rfLqVlzO73LoM72bDDRjE+UBspyZRWARVUMy4vjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869138; c=relaxed/simple;
	bh=4PITLW052mM/0cTmEK1pA04kvx4snzr0G0rUt4eAAeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoY+j5O43HoDbFre+4ruVI+pXNOV6qAM6wKHvJX81/YQ4O3GiOwiPv224aKcLxynQdhrpTAynHTvP93n59yIZXuTwO/AuXbqtKX2dxTFPAt4HjRWEiad88gLqQdknYatDNSfadJsJnM80ROEkvTjfSAeqXwznP704EmZPS3St7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=I3zETg6d; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c7gsy4jskz9tWT;
	Fri, 22 Aug 2025 15:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755869126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PITLW052mM/0cTmEK1pA04kvx4snzr0G0rUt4eAAeA=;
	b=I3zETg6dE36v3QvGTZ3phKvzINWZlRKxEzPAs7CFP1An8HwSYV2kTCd8itbvhNqikX7vEk
	3KtKU9dg7Uf9E4qUJN14JMgWtxAdZfccmQzvbnO3DTXFKaFAlCkAG9qg1u9kdLmIXjkJ28
	tSz/v97+0NM5GNQldHJwrCVCj70wqkbXzDcHxfAq767C9uPAznFr0uiSjU2dGAZPAtfZBC
	bKyjtANVWfFvJzM/Nc+5IwK8gpHBlYC4H0/XxLePVeIF+JOvaOZ+FlIYF8i18KE8xDVziT
	OEyAs7UzBoXMSajx60azDdDu2qU83QWM/iAaxLIVVgLrKdjWsFsUu3ChEJEBeA==
Date: Fri, 22 Aug 2025 23:25:11 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Rob Landley <rob@landley.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Lichen Liu <lichliu@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, weilongchen@huawei.com, 
	linux-api@vger.kernel.org, zohar@linux.ibm.com, stefanb@linux.ibm.com, 
	initramfs@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
Message-ID: <2025-08-22-witty-worthy-wink-sitcom-T5L8wA@cyphar.com>
References: <20250815121459.3391223-1-lichliu@redhat.com>
 <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
 <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rvitifl7wogvg7j"
Content-Disposition: inline
In-Reply-To: <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>


--6rvitifl7wogvg7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
MIME-Version: 1.0

On 2025-08-21, Rob Landley <rob@landley.net> wrote:
> P.S. It's a pity lkml.iu.edu and spinics.net are both down right now, but
> after vger.kernel.org deleted all reference to them I can't say I'm
> surprised. Neither lkml.org nor lore.kernel.org have an obvious threaded
> interface allowing you to find stuff without a keyword search, and

I'm not sure what issue you're gesturing to exactly, but if you have the
Message-ID you can link to it directly with
<https://lore.kernel.org/lkml/$MESSAGE_ID>. For instance, this email
will be available at
<https://lore.kernel.org/lkml/2025-08-22-witty-worthy-wink-sitcom-T5L8wA@cy=
phar.com>.

To be honest, I much prefer that to lkml.org's completely opaque
mappings based on arrival order and date (and in my experience it seems
to miss messages). The same goes for lkml.iu.edu, spinics and gmane.

One of the biggest losses when gmane disappeared was that all of the
URLs that referenced it were rendered unusable because the mapping from
their numbering to Message-IDs was not maintained. If lkml.org goes down
10 years from now, every reference to it will also be unusable, but
lore.kernel.org addresses will still be usable even if it goes down (you
can even search your local archives for the mails).

(It would be nice if more people spent a bit of time configuring their
Message-ID generation to be more friendly for this usecase -- mutt
changed their default Message-ID generation to be completely random
characters a few years ago, which made Message-IDs less recognisable
until folks adjusted their configs. Gmail is even worse, obviously.)

Also, lore.kernel.org has threading on the main page and on individual
thread pages? Maybe I don't understand what you're referring to?

> lore.kernel.org somehow manages not to list "linux-kernel" in its top lev=
el
> list of "inboxes" at all. The wagons are circled pretty tightly...

No it's definitely there, it's just labeled as "lkml" (they're sorted by
latest message timestamp so LKML will usually be near the top).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--6rvitifl7wogvg7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKhvtxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+QSwD7BO+PtnsXEDae0r97BHM6
PkIHOEXbXJqq1URgT+54x98A+wSeZX6FvxMSF0Ghiw07nuOnRO3d0pW2Lpww9iVW
T0UE
=YHVJ
-----END PGP SIGNATURE-----

--6rvitifl7wogvg7j--

