Return-Path: <linux-fsdevel+bounces-48811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07961AB4CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5270819E42B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263B1F09B6;
	Tue, 13 May 2025 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scm7ESZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421072D7BF;
	Tue, 13 May 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121826; cv=none; b=YvwngdpSqmWBU89b5+0leqSheM4Efwf4qpy9HSyWgaetbAIbvs4qrQjrH7/ZcYIT4c8WgvBxdtias8T3nJh/qcKrZ3yP9RZ5yqndrw4Bcn8f4wzMJ9j1eKE5dupxVYrTOLchu90rQz1Oy5z6VsQjbHDuBEcCEa1UmizN9Lxel58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121826; c=relaxed/simple;
	bh=3eJWzTh8RQPPZqSzUIOgAER3ng2OBNfm7iT2iwjU8Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXQEIza4rycV/Z+y4/zeWtpYkF6YG533zzlcRoZFWpc4MoJruUGGrNURqDiGughbrkeiY7T7nAmNPx1hbyCX0jOBRMQQB2nxqBISfq/I9u+vEOUo7nBpWwFHvplcCcwLkrM9Tf0FUjv+64SsgKunqae3V8Nxnyy9jDN3AEkwAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scm7ESZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9F4C4CEE4;
	Tue, 13 May 2025 07:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121824;
	bh=3eJWzTh8RQPPZqSzUIOgAER3ng2OBNfm7iT2iwjU8Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scm7ESZPqGKRICUMPr0ebRK/9FLzyDjTKcWLva5L6oU2ggz0+sB3iI801PyQcK0mK
	 /meQaHzbsmhKsoIVhHX0/F589L34t+QE+xYW1QE+p/3pRDzJlwBK2K6pgZBj0zw1WI
	 BTAB7Bd2vGF90fKutKOszz3KrrlkuBZHxZvDL4ZIxCCMTi6t/rGi+xyj8xoYqfOWv2
	 JPFj88qlpmVDUpYAfGItnUsoBm3zhWlI4m+rGq7IzeoTqOwA1v/w/COBIuv7bA+/Ov
	 1IDRsWZyjHwVUl1c3hVguVXcxHW15fdcdUIQYHp5qFwFtEoTbP2X2Qugmer+edJHt+
	 2heXJWzcGhAMw==
Date: Tue, 13 May 2025 09:37:00 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 01/12] module: Move modprobe_path and modules_disabled
 ctl_tables into the module subsys
Message-ID: <3mco5hjj2lefeyyoy2wcm63fl3wh2qvac57puktpqpwx7vpunf@63vk55fgiikt>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
 <aB4oyFBMH4PKjJn0@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ormwqfkrprpiilub"
Content-Disposition: inline
In-Reply-To: <aB4oyFBMH4PKjJn0@bombadil.infradead.org>


--ormwqfkrprpiilub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 09:09:44AM -0700, Luis Chamberlain wrote:
> On Fri, May 09, 2025 at 02:54:05PM +0200, Joel Granados wrote:
> > diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
> > index 25f25381251281a390b273cd8a734c92b960113a..5701629adc27b4bb5080db7=
5f0e69f9f55e9d2ad 100644
> > --- a/kernel/module/kmod.c
> > +++ b/kernel/module/kmod.c
> > @@ -60,7 +60,7 @@ static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD=
_CONCURRENT);
> >  /*
> >  	modprobe_path is set via /proc/sys.
> >  */
> > -char modprobe_path[KMOD_PATH_LEN] =3D CONFIG_MODPROBE_PATH;
> > +static char modprobe_path[KMOD_PATH_LEN] =3D CONFIG_MODPROBE_PATH;
> > =20
> >  static void free_modprobe_argv(struct subprocess_info *info)
> >  {
> > @@ -177,3 +177,33 @@ int __request_module(bool wait, const char *fmt, .=
=2E.)
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(__request_module);
> > +
> > +#ifdef CONFIG_MODULES
>=20
> kernel/Makefile:
>=20
> obj-$(CONFIG_MODULES) +=3D module/
>=20
> And so you can drop this ifdef.
Done. Modified in my version, but will not bother to send a V2 for this.
>=20
> Other than that:
>=20
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>=20
>   Luis
>=20

--=20

Joel Granados

--ormwqfkrprpiilub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmgi9psACgkQupfNUreW
QU8bzwv9GHn9q80K4WLodwErjZKnXswr6KwUEI0c9eHsdmFPBt2RjTo06HJtguMb
0kvfMFNn2PAooIe37ym5MHSod9+xcOVLlQY/8A2ClIf9NBaPsWMIkkyM+KhWcO8i
0E8Nfni6EKPbAAurHklbRft1cnpRSz2FM5yc8USBLQSDjY8lHDGUBYRiKLeiuZdu
BD2oTfxU1HKKvv+k4IAonAsRc5fX9WKeVCcJqRBRx3iI7zsqyArktttxXuDgSf9e
Sny9c88uZGwsqdFolhgmv0HZF+/94DZobqzW0FS3Vs3N2CPPi0NsqRDnC62U8cDx
ez/K2w4byBXR85L7MG6DWLFy5nyCFrNPzIuKQdVrqDvBVfAfJUIZWdT18OskOJsC
AocFglwyj5U28DU6J6oRfGwouGeKsn5f9GhQOjRoVQGsXZ7LUVJ/vAmXtNOBr8w6
fcJDSP+sr2iphL7RnV35xdEz+sAAhulDj8ka3odtUmKoJC6P0UWf4qIAQpT7HAud
ZENwtTtF
=LNIR
-----END PGP SIGNATURE-----

--ormwqfkrprpiilub--

