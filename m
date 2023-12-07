Return-Path: <linux-fsdevel+bounces-5138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57608085A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A29B208C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C337D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:35:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211B4170B
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 01:23:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBAbg-0003XX-GY; Thu, 07 Dec 2023 10:23:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBAbg-00E9kr-0i; Thu, 07 Dec 2023 10:23:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBAbf-00Fpqh-Nz; Thu, 07 Dec 2023 10:23:43 +0100
Date: Thu, 7 Dec 2023 10:23:43 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH] chardev: Simplify usage of try_module_get()
Message-ID: <20231207092343.6yu42ou7eeyptbpl@pengutronix.de>
References: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
 <20231016224311.GI800259@ZenIV>
 <20231017091353.6fhpmrcx66jj2jls@pengutronix.de>
 <20231017095413.GP800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ehmnxzbbwm6pq4d"
Content-Disposition: inline
In-Reply-To: <20231017095413.GP800259@ZenIV>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org


--6ehmnxzbbwm6pq4d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 10:54:13AM +0100, Al Viro wrote:
> On Tue, Oct 17, 2023 at 11:13:53AM +0200, Uwe Kleine-K=F6nig wrote:
>=20
> > I don't understand what you intend to say here. What is "that"? Are you
> > talking about
> >=20
> > 	owner && !try_module_get(owner)
> >=20
> > vs
> >=20
> > 	!try_module_get(owner)
> >=20
> > or the following line with kobject_get_unless_zero? Do you doubt the
> > validity of my patch, or is it about something try_module_get()
> > could/should do more than it currently does?
>=20
> I'm saying that it would be a good idea to turn try_module_get() into
> an inline in all cases, including the CONFIG_MODULE_UNLOAD one.
> Turning it into something like !module || __try_module_get(module),
> with the latter being out of line.  With that done, your patch would be
> entirely unobjectionable...

I looked into that suggestion, and I don't like it.

There are three definitions for try_module_get() (slightly simplified):

 - CONFIG_MODULES=3Dy && CONFIG_MODULE_UNLOAD=3Dy

 	return !module || (module_is_live(module) && atomic_inc_not_zero(&module-=
>refcnt) !=3D 0);

 - CONFIG_MODULES=3Dy && CONFIG_MODULE_UNLOAD=3Dn

   	return !module || module_is_live(module);

 - CONFIG_MODULES=3Dn

 	return true;

So splitting all three into

	!module || __try_module_get(module)

adds an unnecessary check for the CONFIG_MODULES=3Dn case. And only
consolidating the CONFIG_MODULES=3Dy case would allow to go a bit further
and do:

	#ifdef CONFIG_MODULES

	# ifdef CONFIG_MODULE_UNLOAD=3Dy

	/* maybe make this an non-inline */
	static inline bool module_incr_refcnt(struct module)
	{
		return atomic_inc_not_zero(&module->refcnt) !=3D 0;
	}

	# else /* ifdef CONFIG_MODULE_UNLOAD=3Dy */

	# define module_incr_refcnt(module) true

	# endif /* ifdef CONFIG_MODULE_UNLOAD=3Dy / else */

	static inline bool try_module_get(struct module *module)
	{
		if (!module)
			return true;

		return module_is_live(module) && module_incr_refcnt(module);
	}

	#else

	static inline bool try_module_get(struct module *module)
	{
		return true;
	}

	#endif

I'm not convinced this is easier ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6ehmnxzbbwm6pq4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVxjx4ACgkQj4D7WH0S
/k4u2wf/eJIixHN3DVl4ZtOIqTHPHXoyVfWq+bDhCdiry2Z/ogObIRpE+AfQ4uwE
LRccrI1/k10v30MbqOI4LwPs/kJdAk8BBhQJ9wz+Si3eqdXHDdGM6Cs7rxk3xQNJ
+sSz9JYjl5bWjibIYWZfYoVnUs0CB4fMBHVIACGsYfkv9xDQKRKeFTm9YhNy6oMo
9uHcmCnh4zJaZWqlbPM/cEXKIIz7e7fQG24AhDtxtX7M9T2+/OC02xP5syIvtAf8
x8TBD3MKDbNgiJPzZo315Ovpwu4ye9S1dk3p096Yd5zfYT1KAPk19fUY6nHF76Tr
Z1yw3nCtbruLbL5UbGJsYwgK00gdZQ==
=UaKJ
-----END PGP SIGNATURE-----

--6ehmnxzbbwm6pq4d--

