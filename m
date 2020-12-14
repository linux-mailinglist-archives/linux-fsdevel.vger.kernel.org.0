Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B182DA2EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgLNWBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:01:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:60320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgLNWBT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:01:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F6F3AC7F;
        Mon, 14 Dec 2020 22:00:36 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeffrey Layton <jlayton@poochiereds.net>
Date:   Tue, 15 Dec 2020 09:00:28 +1100
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 1/2] errseq: split the SEEN flag into two new flags
In-Reply-To: <20201214133714.GA13412@tleilax.poochiereds.net>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-2-jlayton@kernel.org>
 <87ft49jn37.fsf@notabene.neil.brown.name>
 <20201214133714.GA13412@tleilax.poochiereds.net>
Message-ID: <87blewjber.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14 2020, Jeffrey Layton wrote:

> On Mon, Dec 14, 2020 at 10:35:56AM +1100, NeilBrown wrote:
>> On Sun, Dec 13 2020, Jeff Layton wrote:
>>=20
>> > Overlayfs's volatile mounts want to be able to sample an error for
>> > their own purposes, without preventing a later opener from potentially
>> > seeing the error.
>> >
>> > The original reason for the SEEN flag was to make it so that we didn't
>> > need to increment the counter if nothing had observed the latest value
>> > and the error was the same. Eventually, a regression was reported in
>> > the errseq_t conversion, and we fixed that by using the SEEN flag to
>> > also mean that the error had been reported to userland at least once
>> > somewhere.
>> >
>> > Those are two different states, however. If we instead take a second
>> > flag bit from the counter, we can track these two things separately,
>> > and accomodate the overlayfs volatile mount use-case.
>> >
>> > Add a new MUSTINC flag that indicates that the counter must be
>> > incremented the next time an error is set, and rework the errseq
>> > functions to set and clear that flag whenever the SEEN bit is set or
>> > cleared.
>> >
>> > Test only for the MUSTINC bit when deciding whether to increment the
>> > counter and only for the SEEN bit when deciding what to return in
>> > errseq_sample.
>> >
>> > Add a new errseq_peek function to allow for the overlayfs use-case.
>> > This just grabs the latest counter and sets the MUSTINC bit, leaving
>> > the SEEN bit untouched.
>> >
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  include/linux/errseq.h |  2 ++
>> >  lib/errseq.c           | 64 ++++++++++++++++++++++++++++++++++--------
>> >  2 files changed, 55 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/include/linux/errseq.h b/include/linux/errseq.h
>> > index fc2777770768..6d4b9bc629ac 100644
>> > --- a/include/linux/errseq.h
>> > +++ b/include/linux/errseq.h
>> > @@ -9,6 +9,8 @@ typedef u32	errseq_t;
>> >=20=20
>> >  errseq_t errseq_set(errseq_t *eseq, int err);
>> >  errseq_t errseq_sample(errseq_t *eseq);
>> > +errseq_t errseq_peek(errseq_t *eseq);
>> > +errseq_t errseq_sample_advance(errseq_t *eseq);
>> >  int errseq_check(errseq_t *eseq, errseq_t since);
>> >  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
>> >  #endif
>> > diff --git a/lib/errseq.c b/lib/errseq.c
>> > index 81f9e33aa7e7..5cc830f0361b 100644
>> > --- a/lib/errseq.c
>> > +++ b/lib/errseq.c
>> > @@ -38,8 +38,11 @@
>> >  /* This bit is used as a flag to indicate whether the value has been =
seen */
>> >  #define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
>>=20
>> Would this look nicer using the BIT() macro?
>>=20
>>   #define ERRSEQ_SEEN		BIT(ERRSEQ_SHIFT)
>>=20
>> >=20=20
>> > +/* This bit indicates that value must be incremented even when error =
is same */
>> > +#define ERRSEQ_MUSTINC		(1 << (ERRSEQ_SHIFT + 1))
>>=20
>>  #define ERRSEQ_MUSTINC		BIT(ERRSEQ_SHIFT+1)
>>=20
>> or if you don't like the BIT macro (not everyone does), then maybe
>>=20
>>  #define ERR_SEQ_MUSTINC	(ERRSEQ_SEEN << 1 )
>>=20
>> ??
>>=20
>> > +
>> >  /* The lowest bit of the counter */
>> > -#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
>> > +#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 2))
>>=20
>> Ditto.
>>=20
>
> Yes, I can make that change. The BIT macro is much easier to read.
>
>> >=20=20
>> >  /**
>> >   * errseq_set - set a errseq_t for later reporting
>> > @@ -77,11 +80,11 @@ errseq_t errseq_set(errseq_t *eseq, int err)
>> >  	for (;;) {
>> >  		errseq_t new;
>> >=20=20
>> > -		/* Clear out error bits and set new error */
>> > -		new =3D (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
>> > +		/* Clear out flag bits and set new error */
>> > +		new =3D (old & ~(MAX_ERRNO|ERRSEQ_SEEN|ERRSEQ_MUSTINC)) | -err;
>>=20
>> This is starting to look clumsy (or maybe, this already looked clumsy,
>> but now that is hard to ignore).
>>=20
>> 		new =3D (old & (ERRSEQ_CTR_INC - 1)) | -err
>>=20
>
> I think you mean:
>
> 		new =3D (old & ~(ERRSEQ_CTR_INC - 1)) | -err;
>
> Maybe I can add a new ERRSEQ_CTR_MASK value though which makes it more
> evident.

Sounds good.

>
>> Also this assumes MAX_ERRNO is a mask, which it is .. today.
>>=20
>> 	BUILD_BUG_ON(MAX_ERRNO & (MAX_ERRNO + 1));
>> ??
>>=20
>
> We already have this in errseq_set:
>
>         BUILD_BUG_ON_NOT_POWER_OF_2(MAX_ERRNO + 1);

Oh good - I didn't see.

>
>> >=20=20
>> > -		/* Only increment if someone has looked at it */
>> > -		if (old & ERRSEQ_SEEN)
>> > +		/* Only increment if we have to */
>> > +		if (old & ERRSEQ_MUSTINC)
>> >  			new +=3D ERRSEQ_CTR_INC;
>> >=20=20
>> >  		/* If there would be no change, then call it done */
>> > @@ -122,14 +125,50 @@ EXPORT_SYMBOL(errseq_set);
>> >  errseq_t errseq_sample(errseq_t *eseq)
>> >  {
>> >  	errseq_t old =3D READ_ONCE(*eseq);
>> > +	errseq_t new =3D old;
>> >=20=20
>> > -	/* If nobody has seen this error yet, then we can be the first. */
>> > -	if (!(old & ERRSEQ_SEEN))
>> > -		old =3D 0;
>> > -	return old;
>> > +	/*
>> > +	 * For the common case of no errors ever having been set, we can skip
>> > +	 * marking the SEEN|MUSTINC bits. Once an error has been set, the va=
lue
>> > +	 * will never go back to zero.
>> > +	 */
>> > +	if (old !=3D 0) {
>> > +		new |=3D ERRSEQ_SEEN|ERRSEQ_MUSTINC;
>>=20
>> You lose me here.  Why is ERRSEQ_SEEN being set, where it wasn't before?
>>=20
>> The ERRSEQ_SEEN flag not means precisely "The error has been reported to
>> userspace".
>> This operations isn't used to report errors - that is errseq_check().
>>=20
>> I'm not saying the code it wrong - I really cannot tell.
>> I'm just saying that I cannot see why it might be right.
>>=20
>
> I think you're right. We should not be setting SEEN here, but we do
> need to set MUSTINC if it's not already set. I'll fix (and re-test).

Thanks.  Though it isn't clear to me why MUSTINC needs to be set there,
so if you could make that clear, it would help me.

Also, the two flags seem similar in how they are handled, only tracking
different states, but their names don't reflect that.
I imagine changing "SEEN" to "MUST_REPORT" or similar, so both flags are
"MUST_XXX".
Only I think we would then need to invert "SEEN" - as it currently means
"MUSTN'T_REPORT" .. approximately.

Or maybe we could replace MUST_INC by DID_INC, so it says what has been
done, rather than what must be done.

Or maybe not.  Certainly it would be useful to have a clear picture of
how the two flags are similar, and how they are different.

Thanks,
NeilBrown


>
> Thanks for the review!
>
>>=20
>>=20
>>=20
>> > +		if (old !=3D new)
>> > +			cmpxchg(eseq, old, new);
>> > +		if (!(old & ERRSEQ_SEEN))
>> > +			return 0;
>> > +	}
>> > +	return new;
>> >  }
>> >  EXPORT_SYMBOL(errseq_sample);
>> >=20=20
>> > +/**
>> > + * errseq_peek - Grab current errseq_t value, but don't mark it SEEN
>> > + * @eseq: Pointer to errseq_t to be sampled.
>> > + *
>> > + * In some cases, we need to be able to sample the errseq_t, but we'r=
e not
>> > + * in a situation where we can report the value to userland. Use this
>> > + * function to do that. This ensures that later errors will be record=
ed,
>> > + * and that any current errors are reported at least once.
>> > + *
>> > + * Context: Any context.
>> > + * Return: The current errseq value.
>> > + */
>> > +errseq_t errseq_peek(errseq_t *eseq)
>> > +{
>> > +	errseq_t old =3D READ_ONCE(*eseq);
>> > +	errseq_t new =3D old;
>> > +
>> > +	if (old !=3D 0) {
>> > +		new |=3D ERRSEQ_MUSTINC;
>> > +		if (old !=3D new)
>> > +			cmpxchg(eseq, old, new);
>> > +	}
>> > +	return new;
>> > +}
>> > +EXPORT_SYMBOL(errseq_peek);
>> > +
>> >  /**
>> >   * errseq_check() - Has an error occurred since a particular sample p=
oint?
>> >   * @eseq: Pointer to errseq_t value to be checked.
>> > @@ -143,7 +182,10 @@ EXPORT_SYMBOL(errseq_sample);
>> >   */
>> >  int errseq_check(errseq_t *eseq, errseq_t since)
>> >  {
>> > -	errseq_t cur =3D READ_ONCE(*eseq);
>> > +	errseq_t cur =3D READ_ONCE(*eseq) & ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
>> > +
>> > +	/* Clear the flag bits for comparison */
>> > +	since &=3D ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
>> >=20=20
>> >  	if (likely(cur =3D=3D since))
>> >  		return 0;
>> > @@ -195,7 +237,7 @@ int errseq_check_and_advance(errseq_t *eseq, errse=
q_t *since)
>> >  		 * can advance "since" and return an error based on what we
>> >  		 * have.
>> >  		 */
>> > -		new =3D old | ERRSEQ_SEEN;
>> > +		new =3D old | ERRSEQ_SEEN | ERRSEQ_MUSTINC;
>> >  		if (new !=3D old)
>> >  			cmpxchg(eseq, old, new);
>> >  		*since =3D new;
>> > --=20
>> > 2.29.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/X4H0OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblY/BAAn3wG+V2cWFkfYgIOIdl18e1CMFl6Qto40SX3
18j3aqGVJnCDSjpAdFm/MbH4NyopPxn1oqiUorxjmrPUYKnXGrMI/Nnpp8NnoWsF
9QAkqwG77t1ooWQSXEKx9/62cADKNE9HiHeG7j7t9lhLgxAL/fhlQ1RMHnIsP1MX
hooI3QehF9plg3oI9mH3Vv/uiy82/lwAP4ot7jtKt3oOW/2uRkG7Dcvc0FHnq4+i
XjitzCfxiP8FKe7HiTpPeB1EpS7ChBFMjg4LBav78yDelgJ1xla7HN0ew6oI13pX
BqQXhEw6HPw9hgCY7DWLJExdM4+BwqxV4cj1ggZHKxkyXKZp11Tak03Nz2fPDYVU
uQLf/6QIhesmssJcS7+TEvQNN1yP82D14+zUiPqL2jjRq9s2a7KmgmIKYcPMjOgb
rUO9Jz9A0wMJfNcyz6Y1umB+RaoL2TCLgfwzNG70Lnvlp3VO0dj5LJWn2aDptNER
rpnIYI583eUvs8DQobhpfYAS/ZLcI1/RxwyfBmb400tYyk5mOY3Bqj/UToyoHG7+
eqk4NlxaJZgGJDIHYVHDjO5Ht5XY9EGWEiPXdf+l7oC6jcb7wQN0KGoP0UuhdQiO
uULiGjTNJ1k9Ro+1u+D2KbSWMKbtvD9kKBn5ev40+1e3OsSioJy6GZywVc6zEGnO
91RYAoo=
=05SE
-----END PGP SIGNATURE-----
--=-=-=--
