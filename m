Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2094E2D9131
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 00:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgLMXgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 18:36:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:48482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgLMXgr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:36:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2D36AC7F;
        Sun, 13 Dec 2020 23:36:04 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 14 Dec 2020 10:35:56 +1100
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 1/2] errseq: split the SEEN flag into two new flags
In-Reply-To: <20201213132713.66864-2-jlayton@kernel.org>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-2-jlayton@kernel.org>
Message-ID: <87ft49jn37.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 13 2020, Jeff Layton wrote:

> Overlayfs's volatile mounts want to be able to sample an error for
> their own purposes, without preventing a later opener from potentially
> seeing the error.
>
> The original reason for the SEEN flag was to make it so that we didn't
> need to increment the counter if nothing had observed the latest value
> and the error was the same. Eventually, a regression was reported in
> the errseq_t conversion, and we fixed that by using the SEEN flag to
> also mean that the error had been reported to userland at least once
> somewhere.
>
> Those are two different states, however. If we instead take a second
> flag bit from the counter, we can track these two things separately,
> and accomodate the overlayfs volatile mount use-case.
>
> Add a new MUSTINC flag that indicates that the counter must be
> incremented the next time an error is set, and rework the errseq
> functions to set and clear that flag whenever the SEEN bit is set or
> cleared.
>
> Test only for the MUSTINC bit when deciding whether to increment the
> counter and only for the SEEN bit when deciding what to return in
> errseq_sample.
>
> Add a new errseq_peek function to allow for the overlayfs use-case.
> This just grabs the latest counter and sets the MUSTINC bit, leaving
> the SEEN bit untouched.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/errseq.h |  2 ++
>  lib/errseq.c           | 64 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 55 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/errseq.h b/include/linux/errseq.h
> index fc2777770768..6d4b9bc629ac 100644
> --- a/include/linux/errseq.h
> +++ b/include/linux/errseq.h
> @@ -9,6 +9,8 @@ typedef u32	errseq_t;
>=20=20
>  errseq_t errseq_set(errseq_t *eseq, int err);
>  errseq_t errseq_sample(errseq_t *eseq);
> +errseq_t errseq_peek(errseq_t *eseq);
> +errseq_t errseq_sample_advance(errseq_t *eseq);
>  int errseq_check(errseq_t *eseq, errseq_t since);
>  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
>  #endif
> diff --git a/lib/errseq.c b/lib/errseq.c
> index 81f9e33aa7e7..5cc830f0361b 100644
> --- a/lib/errseq.c
> +++ b/lib/errseq.c
> @@ -38,8 +38,11 @@
>  /* This bit is used as a flag to indicate whether the value has been see=
n */
>  #define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)

Would this look nicer using the BIT() macro?

  #define ERRSEQ_SEEN		BIT(ERRSEQ_SHIFT)

>=20=20
> +/* This bit indicates that value must be incremented even when error is =
same */
> +#define ERRSEQ_MUSTINC		(1 << (ERRSEQ_SHIFT + 1))

 #define ERRSEQ_MUSTINC		BIT(ERRSEQ_SHIFT+1)

or if you don't like the BIT macro (not everyone does), then maybe

 #define ERR_SEQ_MUSTINC	(ERRSEQ_SEEN << 1 )

??

> +
>  /* The lowest bit of the counter */
> -#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
> +#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 2))

Ditto.

>=20=20
>  /**
>   * errseq_set - set a errseq_t for later reporting
> @@ -77,11 +80,11 @@ errseq_t errseq_set(errseq_t *eseq, int err)
>  	for (;;) {
>  		errseq_t new;
>=20=20
> -		/* Clear out error bits and set new error */
> -		new =3D (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
> +		/* Clear out flag bits and set new error */
> +		new =3D (old & ~(MAX_ERRNO|ERRSEQ_SEEN|ERRSEQ_MUSTINC)) | -err;

This is starting to look clumsy (or maybe, this already looked clumsy,
but now that is hard to ignore).

		new =3D (old & (ERRSEQ_CTR_INC - 1)) | -err

Also this assumes MAX_ERRNO is a mask, which it is .. today.

	BUILD_BUG_ON(MAX_ERRNO & (MAX_ERRNO + 1));
??

>=20=20
> -		/* Only increment if someone has looked at it */
> -		if (old & ERRSEQ_SEEN)
> +		/* Only increment if we have to */
> +		if (old & ERRSEQ_MUSTINC)
>  			new +=3D ERRSEQ_CTR_INC;
>=20=20
>  		/* If there would be no change, then call it done */
> @@ -122,14 +125,50 @@ EXPORT_SYMBOL(errseq_set);
>  errseq_t errseq_sample(errseq_t *eseq)
>  {
>  	errseq_t old =3D READ_ONCE(*eseq);
> +	errseq_t new =3D old;
>=20=20
> -	/* If nobody has seen this error yet, then we can be the first. */
> -	if (!(old & ERRSEQ_SEEN))
> -		old =3D 0;
> -	return old;
> +	/*
> +	 * For the common case of no errors ever having been set, we can skip
> +	 * marking the SEEN|MUSTINC bits. Once an error has been set, the value
> +	 * will never go back to zero.
> +	 */
> +	if (old !=3D 0) {
> +		new |=3D ERRSEQ_SEEN|ERRSEQ_MUSTINC;

You lose me here.  Why is ERRSEQ_SEEN being set, where it wasn't before?

The ERRSEQ_SEEN flag not means precisely "The error has been reported to
userspace".
This operations isn't used to report errors - that is errseq_check().

I'm not saying the code it wrong - I really cannot tell.
I'm just saying that I cannot see why it might be right.

Thanks,
NeilBrown



> +		if (old !=3D new)
> +			cmpxchg(eseq, old, new);
> +		if (!(old & ERRSEQ_SEEN))
> +			return 0;
> +	}
> +	return new;
>  }
>  EXPORT_SYMBOL(errseq_sample);
>=20=20
> +/**
> + * errseq_peek - Grab current errseq_t value, but don't mark it SEEN
> + * @eseq: Pointer to errseq_t to be sampled.
> + *
> + * In some cases, we need to be able to sample the errseq_t, but we're n=
ot
> + * in a situation where we can report the value to userland. Use this
> + * function to do that. This ensures that later errors will be recorded,
> + * and that any current errors are reported at least once.
> + *
> + * Context: Any context.
> + * Return: The current errseq value.
> + */
> +errseq_t errseq_peek(errseq_t *eseq)
> +{
> +	errseq_t old =3D READ_ONCE(*eseq);
> +	errseq_t new =3D old;
> +
> +	if (old !=3D 0) {
> +		new |=3D ERRSEQ_MUSTINC;
> +		if (old !=3D new)
> +			cmpxchg(eseq, old, new);
> +	}
> +	return new;
> +}
> +EXPORT_SYMBOL(errseq_peek);
> +
>  /**
>   * errseq_check() - Has an error occurred since a particular sample poin=
t?
>   * @eseq: Pointer to errseq_t value to be checked.
> @@ -143,7 +182,10 @@ EXPORT_SYMBOL(errseq_sample);
>   */
>  int errseq_check(errseq_t *eseq, errseq_t since)
>  {
> -	errseq_t cur =3D READ_ONCE(*eseq);
> +	errseq_t cur =3D READ_ONCE(*eseq) & ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
> +
> +	/* Clear the flag bits for comparison */
> +	since &=3D ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
>=20=20
>  	if (likely(cur =3D=3D since))
>  		return 0;
> @@ -195,7 +237,7 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t=
 *since)
>  		 * can advance "since" and return an error based on what we
>  		 * have.
>  		 */
> -		new =3D old | ERRSEQ_SEEN;
> +		new =3D old | ERRSEQ_SEEN | ERRSEQ_MUSTINC;
>  		if (new !=3D old)
>  			cmpxchg(eseq, old, new);
>  		*since =3D new;
> --=20
> 2.29.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/WpV0OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbm0kxAAvo6dSY4yu42bPdQHDJ+GSIjJe+tYo1N09lSk
55bMqzQg57mwW2Xe9HklF4p4aiC3E8TEc4fz0c6tkSGv8fZOkVvk55zEYAgr2yc3
8So/dlW6Ltd8JMSM3HJYb2KVs16GwcyHa37Z1Fh01fxEOHBHEQ8/pMgXDQuQYV7v
kNjjHqlRe0loKcBQNdX2pzk/cUyrinsMQkJrpWIJWF+Q8b7U5dtF7djaHJsEuA5U
u5AeOnk+CSn4Ykg/U/nmOI929Rqoi5+0gjl7jWP+vlAyQa1WhuuqA001IKuwk1aG
MfTB8YSdQTCNl3eUDUZTiOY5qbScF5EdQsZ8YFXLd8eLi7Jk6qNxBPOfb6ZWPqJd
A8BINxIrZD1w9j6pqzkcNVfRG1KrC/zjJTCAGwuPuhJkZ6LzG+Ah0Cho08J38Bvi
XRyJbwtykoeEuNVVtMRvTT9c2lZVND1zl8qjDxH+T9WVJ/xecgS4ZrTLzb+U5x8Z
sV/VGytIGclsk7CaObisQd3ygG5p3v1+w0ZL9yQ+Wux8i1JRdqdDclsKOkhwHHTi
xOvlNaLJBWJS3ovaAfzVhXb7wfWByv3VBof41xIJl4oVXSfz9D5Vg3Vjul3jX/QQ
P1jmXDjYdZmS4rmWuuPmAGyFw+8PhY2B1fLNwKDVyOMV+RQ058m3rHOy8KfgCjho
AMP22cc=
=vzKJ
-----END PGP SIGNATURE-----
--=-=-=--
