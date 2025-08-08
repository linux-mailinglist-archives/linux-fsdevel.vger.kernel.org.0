Return-Path: <linux-fsdevel+bounces-57077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24238B1E925
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204673B420E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B827D77D;
	Fri,  8 Aug 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="MwKw2/MN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705320ED;
	Fri,  8 Aug 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659637; cv=none; b=jeRMG1tPOEHYLg3QrYh3ORakqPDghQT1NzgNhFAT1+yr6Pc5sod8AZ/v2t5e6V66vCOJk9tYFDMkM2xrZEnbOeFvuOVVCoVpBtgnwwg4pl/Jul2CQc1hd7fTZtELaHRb79eCxccJ1sHDvc6guCkyNR77bnSa7jfgHBWoV8QTsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659637; c=relaxed/simple;
	bh=n2kz0PDmt6ySR11T9g1wOWoTTyWGTuf9XiYZXhELFWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ4R8ZS9qt9SweQr9zagEsPY0bLehxFmWkzEV7TnONmTvqSIdQ8KQov0KQAQF1+l1EKA3WORr5nlowzJ0YcCXQxnIT084mML1XO30QY3u6reR7qIqcwJMRLGtF6PnA7ONZzWPMMJH9ies0wW/GSjXjxh0J122LiXOgd1vQkwkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=MwKw2/MN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bz4ZR4Hwlz9t1l;
	Fri,  8 Aug 2025 15:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754659631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2kz0PDmt6ySR11T9g1wOWoTTyWGTuf9XiYZXhELFWU=;
	b=MwKw2/MNyxLlmN8COwj+D9kstKwgCgYHRxc+tdNeZJf8g9/fycG3zM9eH+bA5T5u/5BjNs
	WRgKZTGABVtwByYQx7LlVdSUP4hS9mjdOo7GKzGngproU53Z4FRtMYat+RdO1wNWTadOcj
	3GM6jt1spGuCeYBAvlrkPDNZUoA6m8WtI+v4wTAqZWd7Yrrc2htCMJbFEWlN0QxkfDdBYX
	BcmNLml30zAy8EkVBlYqm0iFtFwFzKPp2HfIaiXmFk4YnrfL8XPyeSCC4S80SzQnlH0Ydn
	CtI1100YKIj2i9iqG81pu2obhoBMLOHy1vR7Jh8o4UU7U1yHfE+X1qsO1+S4zg==
Date: Fri, 8 Aug 2025 23:26:56 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 08/11] open_tree.2: document 'new' mount api
Message-ID: <2025-08-08.1754659362-feral-upset-odds-relish-frSs5D@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-8-558a27b8068c@cyphar.com>
 <19889ab0576.e4d2f37341528.6111844101094013469@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvkhbalo6bzxjws3"
Content-Disposition: inline
In-Reply-To: <19889ab0576.e4d2f37341528.6111844101094013469@zohomail.com>


--bvkhbalo6bzxjws3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 08/11] open_tree.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
> In "man open_tree":
>=20
> > As with "*at()" system calls, fspick() uses the dirfd argument in conju=
nction
>=20
> You meant "open_tree"
>=20
> > If flags does not contain OPEN_TREE_CLONE, open_tree() returns
> > a file descriptor that is exactly equivalent to one produced by open(2).
>=20
> Please, change "by open(2)" to "by openat(2) with O_PATH" (and other simi=
lar places).

I think the more common pattern in man-pages is to prefer to refer to
open(2) unless you are explicitly talking about openat(2) features (like
passing a dirfd). If it's just "a file descriptor with O_PATH" then most
man-pages I've seen reference open(2) even if they were written
post-openat(2).

Though in this case, since we are talking about open_tree(2) as an open
operation that takes a dirfd, you're right that openat(2) might be
better.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--bvkhbalo6bzxjws3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJX7IAAKCRAol/rSt+lE
bwBcAP9cN20ZuPe0MC2Cwv+PN1I/0VaLonAep0j3nYX/mM0IdQD5AZwu+JMVvyEC
PU6StZuE1rQmIoC09xUR17m2Jr6KMgw=
=25J6
-----END PGP SIGNATURE-----

--bvkhbalo6bzxjws3--

