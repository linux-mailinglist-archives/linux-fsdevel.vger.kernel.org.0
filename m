Return-Path: <linux-fsdevel+bounces-29668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013F97BFC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377EC282335
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030231C9DFA;
	Wed, 18 Sep 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="evW3ipSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7161ACE0F;
	Wed, 18 Sep 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681059; cv=none; b=rBxQU9EjI2IkBNUqlkUTjJOwrkj1AkG1aX/Gx5uYWmrjIllLRFiPTYgSvO0QVaYWMniJJkpsrQ+bdnmuu0pkm0t1D+56dUK7eqoRze3vdQoJYLSyMEi6UPkq8hdjdk25GYn6puHJQNaHA1B4joOQIaK0qngfMGZYPMfFEA1aXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681059; c=relaxed/simple;
	bh=x6a9qKFLvX/aGnfBYKfM9DQiX8cWjFgFDnY2gUiCamY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsbVpLKA5BFEYEpkirwd9ZShvc0lBsACd1gj3yvpfHx2misjQjbXklIXdfVsCSvX3iXrmQ0nyGPstSA4FSHpJnAFY0CSxL18r1cM9MlgEhKLo+mqoZ8XM/1F+aR3jB1Ihw4U0TSLm6nOKOwjKlA2Tujq7Qy4nhzV4O1qPeD9e7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=evW3ipSI; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726681049;
	bh=HiN283smGOusDIKumV2o/43vk/NIxFGIxKHKPXdYaS4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=evW3ipSIshhP18SYOD/PzCxn9xJEBdY4s9ZKEdTHemE8ALoBC/UTlN/EpIpgz07JO
	 brdgtdNkElqxK5kaW0tWvO9Tt2I35ztnwJuXbRrJ8J7OE6zKCpQ06Z83C7D90RfKkM
	 w/tsvI8tKx/HPw5M35zkfTiP874Mh/11hpkjI81o=
Received: from [IPv6:240e:358:1198:0:dc73:854d:832e:2] (unknown [IPv6:240e:358:1198:0:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 26AFF66F17;
	Wed, 18 Sep 2024 13:37:21 -0400 (EDT)
Message-ID: <f6ecd24e0fdb1327dad41f41c3ac31477ca00c9f.camel@xry111.site>
Subject: Re: [PATCH 0/3] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
From: Xi Ruoyao <xry111@xry111.site>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	shankerwangmiao@gmail.com
Cc: stable@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, Christian
 Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>,  Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho	 <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo	 <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org
Date: Thu, 19 Sep 2024 01:37:17 +0800
In-Reply-To: <2024091801-segment-lurk-e67b@gregkh>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
	 <2024091801-segment-lurk-e67b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-18 at 19:33 +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 18, 2024 at 10:01:18PM +0800, Miao Wang via B4 Relay wrote:
> > Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
> > ...)") added support for passing in NULL when AT_EMPTY_PATH is given,
> > improving performance when statx is used for fetching stat informantion
> > from a given fd, which is especially important for 32-bit platforms.
> > This commit also improved the performance when an empty string is given
> > by short-circuiting the handling of such paths.
> >=20
> > This series is based on the commits in the Linus=E2=80=99 tree. Sligth
> > modifications are applied to the context of the patches for cleanly
> > applying.
> >=20
> > Tested-by: Xi Ruoyao <xry111@xry111.site>
> > Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>=20
> This really looks like a brand new feature wanting to be backported, so
> why does it qualify under the stable kernel rules as fixing something?
>=20
> I am willing to take some kinds of "fixes performance issues" new
> features when the subsystem maintainers agree and ask for it, but that
> doesn't seem to be the case here, and so without their approval and
> agreement that this is relevant, we can't accept them.

Unfortunately the performance issue fix and the new feature are in the
same commit.  Is it acceptable to separate out the performance fix part
for stable?  (Basically remove "if (!path) return true;" from the 1st
patch.)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

