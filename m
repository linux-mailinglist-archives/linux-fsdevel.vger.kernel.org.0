Return-Path: <linux-fsdevel+bounces-32522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55369A922F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9699C283857
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40751FDFA7;
	Mon, 21 Oct 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="cUpfxR2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4519923C;
	Mon, 21 Oct 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546722; cv=none; b=MSEXzFhJMBmiLD6H4VHmCkjqWyqc6emIlYTirOJ5YndmSl+xf5HxmD+UHSESySN7hlDhF6aGh1SvZ4IeJQng9oYNR1ekJzlzAvfgAZsuH/htB3PvA70MA8s3yn0VZwHurRnAfiLAJWX+5Lp00gejZw+SCQ+mwELtyNPzHuJe8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546722; c=relaxed/simple;
	bh=e6H7BJ8xXPnGZ+uUcEghzfdEbPT6Ekjaxhj6LTCvoZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtSD5AWipbrMebQM2AveAzL/gKy7s5hkbQe9rr7FJpzr6JPMeH8G9Yr5r+TSlDHjFkWWT6WXYqozPh49pb/zmt3NUkGQywXYQK29m7sLQdgykfWbluz46Umo/TmUqtBymGeewyAW/2hh3MNrI2kg9YdNOMC9thPse8xp8Oq089U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=cUpfxR2C; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XXTFm1WmPz9slC;
	Mon, 21 Oct 2024 23:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1729546716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVSaT45wEivXgjgRUfp0rCYvBpcYPPMEBNfUMCsLBuc=;
	b=cUpfxR2CIJD/Pdq3wpAhz1dV5x5eZiwBnrNERO/+tXg1E9EjOhZCbK+1/gVavC517BhCNn
	dT/ertIwyt7CNDVWAqqHfb7eEZ4eAH9+wSSpJ9i09LtTzGYrX9LFOMFdOCVH4k65qSNqQV
	LZpxQp7n9ADOvADKc44r1DDRsKU4YtWCyYkqtL9CGpPrZMYWkzKzjKtslUYz6d4aJYG+r/
	upkbmNFoMdB15cWO6Bbpe5uAAnpTRyqQZQlXgLYVmmUrbCVy2I3We+nSdPOknp2gRSy3or
	oxOxIg9Z9u751ZQbSvlEYuZwfO7InA8k8qohGeA4d9Br/xaJrun3kYwZpOyzFw==
Date: Tue, 22 Oct 2024 08:38:17 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Subject: Re: (subset) [PATCH RFC v3 00/10] extensible syscalls: CHECK_FIELDS
 to allow for easier feature detection
Message-ID: <20241021.213312-daft.handset.rotten.piers-MlL0KIs8tUv7@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
 <20241021-kraut-fundgrube-cf1648e59df4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3tktjkpfqy324lb"
Content-Disposition: inline
In-Reply-To: <20241021-kraut-fundgrube-cf1648e59df4@brauner>


--h3tktjkpfqy324lb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-21, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, 10 Oct 2024 07:40:33 +1100, Aleksa Sarai wrote:
> > This is something that I've been thinking about for a while. We had a
> > discussion at LPC 2020 about this[1] but the proposals suggested there
> > never materialised.
> >=20
> > In short, it is quite difficult for userspace to detect the feature
> > capability of syscalls at runtime. This is something a lot of programs
> > want to do, but they are forced to create elaborate scenarios to try to
> > figure out if a feature is supported without causing damage to the
> > system. For the vast majority of cases, each individual feature also
> > needs to be tested individually (because syscall results are
> > all-or-nothing), so testing even a single syscall's feature set can
> > easily inflate the startup time of programs.
> >=20
> > [...]
>=20
> I think the copy_struct_to_user() is useful especially now that we'll gain
> another user with pidfd_info.

Once we start extending pidfd_info, it might be necessary to add some
more helpers to make it easier to figure out what bits to set in the
returned request mask.

> ---
>=20
> Applied to the vfs.usercopy branch of the vfs/vfs.git tree.
> Patches in the vfs.usercopy branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.usercopy
>=20
> [01/10] uaccess: add copy_struct_to_user helper
>         https://git.kernel.org/vfs/vfs/c/424a55a4a908
> [02/10] sched_getattr: port to copy_struct_to_user
>         https://git.kernel.org/vfs/vfs/c/112cca098a70

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--h3tktjkpfqy324lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZxbJyQAKCRAol/rSt+lE
b7sIAP0YX2wV7+qLsSDGBl/CJbBHWSDrGDfjYyfFqZgccsLn/QD+NAnYjMcT4lYG
3CverJItao92YWo6NMR5TRTzVaVSBgw=
=UAUt
-----END PGP SIGNATURE-----

--h3tktjkpfqy324lb--

