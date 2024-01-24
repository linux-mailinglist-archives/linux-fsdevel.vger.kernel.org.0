Return-Path: <linux-fsdevel+bounces-8804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2683B24B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7AF2891A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDF132C25;
	Wed, 24 Jan 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=linderud.pw header.i=@linderud.pw header.b="PCUxxJ9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linderud.pw (linderud.dev [163.172.10.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30E130E5D;
	Wed, 24 Jan 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.10.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124562; cv=none; b=a0/9OoWUDo9fzCMGRtvWHRkSweh38qr1pLVa9vkVQmA0cnsKxxuKRWSAaP1TxaX69T9mculP49sz/OOmyRsj6RpYtKVYTUI7mM5ylGtva8NbhtVTggmPqd5ghPAZgcwxFgtk1YrQ1LMTU+zwjctJ2Eo7VBNLKGv/ta5wRqmsejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124562; c=relaxed/simple;
	bh=PLdpff5lHb3OurKoocknItk5GWLlhjyoy1iI7SoSF5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVqXPSonJB9zj7oXVew4NYuPKlphKIuHQi6hl783wICT867qZHvstCmkmQIthsRREvr8RycwxhvgHiO3q8C+CvoxPmUKp4rFtJXIa3uctP0ebuRWY4jERCtj62YDyFyC0lOVdZbXcRck/1MA2OaLSaJPCIzj4iq02gh8025PF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linderud.pw; spf=pass smtp.mailfrom=linderud.pw; dkim=pass (4096-bit key) header.d=linderud.pw header.i=@linderud.pw header.b=PCUxxJ9M; arc=none smtp.client-ip=163.172.10.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linderud.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linderud.pw
Received: from linderud.pw (localhost [127.0.0.1])
	by linderud.pw (Postfix) with ESMTP id 0BFB1C0179;
	Wed, 24 Jan 2024 20:23:19 +0100 (CET)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
	s=linderud; t=1706124198;
	bh=PLdpff5lHb3OurKoocknItk5GWLlhjyoy1iI7SoSF5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PCUxxJ9M3sYJHZH8cdNLoOPOGf+edlwYJJkh8/PvQHKI8BH7/b6U4aP+YICNBvA2c
	 KgnF4jCJkUWLKSplseTyxSmYntnW5nOJEuZ/AgB5zVXddHoRh8K4lKrN2h4nrVwe8h
	 3OG+L1ePieo5blPRIDOXUnzCnh0VutOvZplxxVODnv36LzZlFPapelUwFd1U/0zgVp
	 egBGZZQQszz+VDqtFKPl0RgUsAIYMAKS9sK6N/KnH0IPgAONFGoUCEDshda2MRZbsY
	 kX/hkAJuEMHb3GZ7FvokNuKSKEZG64LC2hyy+/xFhWDM9P2op8PzCu+sGAFgQUvH0N
	 dBcYV0cvoKL+wKIUwevaEAaJBQzYa8V1xE3PU64iqDJIBa/a5XwF/fCCfaTTeBe2oi
	 4ZtrbICd+O6CRCn0z2WxVwqXO7ykTklGBe6DDwHixQpYKJIXyJswL4J1owR+itzHht
	 XIRhy2uDGVwHue+Z80lIoQkRToDy9mVP4LRAiJzzSn3ooUiEYQ+WEpkDd02aTZ88ZW
	 YCbw8deg6GUDaMYG1XMy+sO+wMpUj5UowWLelGxSaQuQCX4ak1fRppUztcYSvdYgoH
	 LBN9alS6bQ/q8tpP7ZssP2AqwQqT4J6tlzAjPmQ5IHEO1gFJcXvucA2MXgv1Mkznhr
	 RJovy9QMJJ6W7JId12lIAR9A=
Received: from localhost (unknown [178.232.143.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: morten)
	by linderud.pw (Postfix) with ESMTPSA id C37A0C0141;
	Wed, 24 Jan 2024 20:23:18 +0100 (CET)
Date: Wed, 24 Jan 2024 20:23:17 +0100
From: Morten Linderud <morten@linderud.pw>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, Dave Chinner <dchinner@redhat.com>, 
	David Howells <dhowells@redhat.com>, Ariel Miculas <amiculas@cisco.com>, 
	Paul McKenney <paulmck@kernel.org>
Subject: Re: Re: [LSF/MM TOPIC] Rust
Message-ID: <pwlz3kkc675kekykoeh3bljoc6sxjlrwrwegfuprv45xsjhcfw@hm2rgmgzczur>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <ZbAO8REoMbxWjozR@casper.infradead.org>
 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
 <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uew6wjptwuw6lx7e"
Content-Disposition: inline
In-Reply-To: <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>


--uew6wjptwuw6lx7e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 01:50:55PM -0500, Kent Overstreet wrote:
>
> We can and should have our own review process when pulling in new
> dependencies, but we shouldn't otherwise be making it difficult to use
> crates.io dependencies just for the sake of it.

One aspect I find overlooked is that downstream distros largely devendor Ru=
st
dependencies from packages. Fedora and Debian comes to mind. Which means th=
at
when Rust in the kernel is something that is turned on by downstream they w=
ould
need to deal with these vendored dependencies.

Is the intent here that `cargo` is pulling down dependencies from cargo.io =
or is
it vendored as part of the source-tree but managed by cargo?

Alternatively, is the dependencies included in the tarball?

The kernel being self-contained is also quite a nice property, and I'm not =
sure
if breaking this property because of cargo is a good enough reason? If you =
don't
vendor it as part of the source-tree then the kernel build will require an
network connection to build.

There is also the security handling aspect of depending on cargo.io as any
security issues in these dependencies would need to trigger kernel releases=
 to
ensure they are patched.

I don't have any solutions, but I think there are a issues that needs to be
dealt with when considering pulling down external dependencies.

--=20
Morten Linderud
PGP: 9C02FF419FECBE16

--uew6wjptwuw6lx7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEwQA0ZnZjToDJQPuenAL/QZ/svhYFAmWxY6EACgkQnAL/QZ/s
vhZjqg//XTabq0wo2kn8gv25d9o+8vsL0CZZ53rxxqx3t5xnMUlWcSXDPO2oZ2N+
rcl1DQSFFgITEJF2kx7W2yH+yqk8+Qt0kyWwCEgwhX32kT7ELV8xm6NTATP4vt4w
1tUJQLbPryFg7FS/aqFZlyoLSoQGzmpEKQ6LoCQWlXJSif3pxwqK59WIf5MUxj84
QUol9Euhh8xOL4SbXz+2oTfH1g8gCkxA+s628bIYUFnxX4uRyf7eAPAiSuW3xpIZ
VuICNhmE6JVLOk0oLwGbEae58axbP2BKQoEK5xIGiUdx+pzAU+HMkJXVJ7EcdMU+
I3Ko6pqwnES1uZPewkwRMiuqoAO+OJwDQGrNDe3Mz619XBJKK+IE3iAr9b4FXe8O
FPxJlGLKenn/VKc6YUOU9Gic4LirHhKtxHAqijwlngo15VPPQyk98kEWT8tsIJnt
oLu9sov95NsbN04g22K6Mc+BGD+epL5sCQJlstIB3YhU1UH4JST+eT1igHvrhcHu
80sB2tkPG273JxhCygjXwaWbs4znPP+g0yvST6RuWniNB4aMCFSld6lwbifuJBi7
uwO/dLbMRH8v5xiixgsjxWb9JfWTw7GspQl293OJEcR3f5+AGOV7nStAWCoVXjse
7xxHbsWzDCzm5rGVfZqS7fcYaxdMgrUnxQZp7Og6DYbskF32fIY=
=j4Ec
-----END PGP SIGNATURE-----

--uew6wjptwuw6lx7e--

