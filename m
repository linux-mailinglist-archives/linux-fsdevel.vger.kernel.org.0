Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C31498B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 05:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgAZEOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 23:14:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:43448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgAZEOt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 23:14:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A41ACAC5C;
        Sun, 26 Jan 2020 04:14:47 +0000 (UTC)
Date:   Sun, 26 Jan 2020 15:14:39 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200126041439.liwfmb4h74zmhi76@yavin.dot.cyphar.com>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
 <20200126040325.5eimmm7hli5qcqrr@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hqgjtbxoii2e4zog"
Content-Disposition: inline
In-Reply-To: <20200126040325.5eimmm7hli5qcqrr@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hqgjtbxoii2e4zog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-01-24, Sargun Dhillon <sargun@sargun.me> wrote:
> >  static long seccomp_notify_recv(struct seccomp_filter *filter,
> >  				void __user *buf)
> >  {
> >  	struct seccomp_knotif *knotif =3D NULL, *cur;
> >  	struct seccomp_notif unotif;
> > +	struct task_struct *group_leader;
> > +	bool send_pidfd;
> >  	ssize_t ret;
> > =20
> > +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
> > +		return -EFAULT;
> >  	/* Verify that we're not given garbage to keep struct extensible. */
> > -	ret =3D check_zeroed_user(buf, sizeof(unotif));
> > -	if (ret < 0)
> > -		return ret;
> > -	if (!ret)
> > +	if (unotif.id ||
> > +	    unotif.pid ||
> > +	    memchr_inv(&unotif.data, 0, sizeof(unotif.data)) ||
> > +	    unotif.pidfd)
> > +		return -EINVAL;
>=20
> IMHO this check is more confusing than the original check_zeroed_user().
> Something like the following is simpler and less prone to forgetting to
> add a new field in the future:
>=20
> 	if (memchr_inv(&unotif, 0, sizeof(unotif)))
> 		return -EINVAL;

Also the check in the patch doesn't ensure that any unnamed padding is
zeroed -- memchr_inv(&unotif, 0, sizeof(unotif)) does.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--hqgjtbxoii2e4zog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl4tEiwACgkQnhiqJn3b
jbTteQ/+JshgPkAMJKFvNtMDmJpL7P7c3yj6E3WmLPyOsxvBYndxxt2T8/NGEkps
dyUtBVjqguB9yUDaHUw5K7Ac86pAlyjG+gQVO0tk3LKA649QJoa05hLw6ix0Eg4E
W9CkIDesL5daNxCn5Qm6fhB8/KTK2ex4JAQEhLX6wyx2/q+5J0i+ZDdDVhMlQC4N
XZ+s8p3O6j+sEtA7W1cO7Xq+GWqwOtH772Cy4BT1s6hIIpkBS05VXtN6rzwKj15D
8QkXyfBhHk1p6C92tr/N0RHZ2k5Im2ySDGGg9G6BVOSoUAIPvUyjRlPIj6gSXsuN
0HvC4olEAD/9ZQQIoPtfSGYpvG9y/tndpAGKMDZjfKmg/IGFHrfTLAUPPvOYCSox
elV4e8mfwRu2oOZaYwBRasWc7NNUdYwetOkaRwnMiMoxSMHCBK1JBkhwjVoohAsM
C84aTpwyJcqCx+HB8drVI28eZp1+ukA/aDdxSW4l6gUSkfwxrkIEMOEFSlwQfrH3
5R3uYw6FTZL2Pcs6TN1W2oVawF7BYkQnvpvG8iHaflgkICajnMpWrcJT6l+IdkQq
dmtwaJKc/ExzVmlNzwyVD4nKg00Du1am5Fithn6eRZWj9GY5pMhz6qh9xZJgA03J
KOtokDIAmVO+C1CieF4aj394NbS4gYm0u9aXgyv0yG6060jcaXw=
=TQFh
-----END PGP SIGNATURE-----

--hqgjtbxoii2e4zog--
