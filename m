Return-Path: <linux-fsdevel+bounces-28269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFD968BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B9CB229DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4D1A3041;
	Mon,  2 Sep 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="cNNUa0S3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27221A3023;
	Mon,  2 Sep 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293328; cv=none; b=CNy9z/tA1r3kJcJS6m28Yxm9qQG257u0TJNugY3e1TwF29S7Q8aQ/7A0eJ8omVFpP/GypbbvNVRq2TZlGCYfwXNI1bYF3WRptEv0hG/OQ/2OESBx/jCRENzmqkz9vSEm+FG2IKxVSSYYW4K8i9K9QMwXZhu/X2NmgXtyghsSZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293328; c=relaxed/simple;
	bh=udCLYS03vFzY0pDP0VXNCARsSZDvZr7IQUhpJq1Ey+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onEpcdftinpaHWC3P4qCUBC+xIZNIgJx8GfFplOR+2F3I6qeYpx1xMCHMPoJw5K/w50qZfeJyR9mKFo24qMRD1p8xLWyq1k0q7dxyDTA4cW7H9GJuWiXhfaZidooy+NXF/xq69mtlkKKWkSknwZ4lJ8Sqv//mhXtPHne9fRlEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=cNNUa0S3; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WyDFj5pVYz9t1t;
	Mon,  2 Sep 2024 18:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725293321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnehve9VjMnII0s4fDhfCcbW2zyjJe5jdh+Zfgbp8WE=;
	b=cNNUa0S3Iq182pJH+ahbE5zzdZTntjXR7caJZLh8wQQK2pMWA6nS8n0jBn0sakWP6e24vw
	kMyOlQqR1AxWzazQMHSjUF9doKKXWRwz+IPz2sGzN7DGBIJeXXfdFWb08AQ258ZuzGVxSu
	LXj+t+WneeeH68MNhgSIWKr6buPAbu1oOas4jIHbs3z0YfK2pWm7Qq2XTxwRSrSOmJguNE
	MsJF+6bK8BpckmA6qEi0k+NY/ft5i1QVgD4PPuwH0jflDz5he3FpP1GP9xto7ln1lyc6OH
	XSKAzWs8jgM0FzNrXYZFk7E1i0JDtXbXUSB+OU3vohpz0STXzPCQx2Oqly+/7g==
Date: Tue, 3 Sep 2024 02:08:26 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, shuah <shuah@kernel.org>, 
	Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] openat2: explicitly return -E2BIG for (usize >
 PAGE_SIZE)
Message-ID: <20240902.160305-cuddly.doc.quaint.provider-RsRaXpw78cll@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
 <20240902-extensible-structs-check_fields-v1-3-545e93ede2f2@cyphar.com>
 <63193b87-7057-4ad0-aef2-fdb5d15138c3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3itig22h2tekijst"
Content-Disposition: inline
In-Reply-To: <63193b87-7057-4ad0-aef2-fdb5d15138c3@app.fastmail.com>
X-Rspamd-Queue-Id: 4WyDFj5pVYz9t1t


--3itig22h2tekijst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Sep 2, 2024, at 07:06, Aleksa Sarai wrote:
> > While we do currently return -EFAULT in this case, it seems prudent to
> > follow the behaviour of other syscalls like clone3. It seems quite
> > unlikely that anyone depends on this error code being EFAULT, but we can
> > always revert this if it turns out to be an issue.
>=20
> Right, it's probably a good idea to have a limit there rather than
> having a busy loop with a user-provided length when the only bound is
> the available virtual memory.
>=20
> >  	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
> >  		return -EINVAL;
> > +	if (unlikely(usize > PAGE_SIZE))
> > +		return -E2BIG;
> >=20
>=20
> Is PAGE_SIZE significant here? If there is a need to enforce a limit,
> I would expect this to be the same regardless of kernel configuration,
> since the structure layout is also independent of the configuration.

PAGE_SIZE is what clone3, perf_event_open, sched_setattr, bpf, etc all
use. The idea was that PAGE_SIZE is the absolute limit of any reasonable
extensible structure size because we are never going to have argument
structures that are larger than a page (I think this was discussed in
the original copy_struct_from_user() patchset thread in late 2019, but I
can't find the reference at the moment.)

I simply forgot to add this when I first submitted openat2, the original
intention was to just match the other syscalls.

> Where is the current -EFAULT for users passing more than a page?
> I only see it for reads beyond the VMA, but not e.g. when checking
> terabytes of zero pages from an anonymous mapping.

I meant that we in practice return -EFAULT if you pass a really large
size (because you end up running off the end of mapped memory). There is
no explicit -EFAULT for large sizes, which is exactly the problem. :P

>=20
>     Arnd

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3itig22h2tekijst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtXi+gAKCRAol/rSt+lE
b/CVAP4/UIPzUm7VHMdeZy4qfDO8V7V0ojxi/W5gHbAzDDpC9AEA+OOBAKvxJ0NQ
ghIM9lErOJb+9JyKInzhgYT3v5S9KQ4=
=pzTi
-----END PGP SIGNATURE-----

--3itig22h2tekijst--

