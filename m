Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C332B4ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450185AbhCCFbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhCCCks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:40:48 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F52C0617A7;
        Tue,  2 Mar 2021 18:39:59 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Dqyrp44dBzQl8j;
        Wed,  3 Mar 2021 03:39:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id fFKjKRbta97Q; Wed,  3 Mar 2021 03:39:50 +0100 (CET)
Date:   Wed, 3 Mar 2021 13:39:41 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Drew DeVault <sir@cmpwn.com>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210303023941.j2x6crqoiris73xx@yavin.dot.cyphar.com>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
 <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
 <CAOQ4uxgbt5fdx=5_QKJZm1y7hZn5-84NkBzcLWjHL3eAzdML0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3lj6aomxgfnwchmd"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgbt5fdx=5_QKJZm1y7hZn5-84NkBzcLWjHL3eAzdML0Q@mail.gmail.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.09 / 15.00 / 15.00
X-Rspamd-Queue-Id: 27D31183D
X-Rspamd-UID: 21333c
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3lj6aomxgfnwchmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-02, Amir Goldstein <amir73il@gmail.com> wrote:
> On Sun, Feb 28, 2021 at 4:02 PM Drew DeVault <sir@cmpwn.com> wrote:
> >
> > On Sat Feb 27, 2021 at 11:03 PM EST, Matthew Wilcox wrote:
> > > > 1. Program A creates a directory
> > > > 2. Program A is pre-empted
> > > > 3. Program B deletes the directory
> > > > 4. Program A creates a file in that directory
> > > > 5. RIP
> > >
> > > umm ... program B deletes the directory. program A opens it in order =
to
> > > use openat(). program A gets ENOENT and exits, confused. that's the
> > > race you're removing here -- and it seems fairly insignificant to me.
> >
> > Yes, that is the race being eliminated here. Instead of this, program A
> > has an fd which holds a reference to the directory, so it just works. A
> > race is a race. It's an oversight in the API.
>=20
> I think you mixed in confusion with "program B deletes the directory".
> That will result, as Matthew wrote in ENOENT because that dir is now
> IS_DEADDIR().
>=20
> I think I understand what you mean with the oversight in the API, but
> the use case should involve mkdtemp(3) - make it more like tmpfile(3).
> Not that *I* can think of the races this can solve, but I am pretty sure
> that people with security background will be able to rationalize this.
>=20
> You start your pitch by ruling out the option of openat2() with
> O_CREAT | O_DIRECTORY, because you have strong emotions
> against it (loathe).
> I personally do not share this feeling with you, because:
> 1. The syscall is already used to open directories as well as files

Al NACKed doing it as part of open[1]. My understanding is that the main
two reasons for that were:

 1. open() and mkdir() have different semantics for resolving paths. For
	instance, open(O_CREAT) will create a file at the target of dangling
	symlink but mkdir() will not allow that. I believe there's also some
	funky trailing-"/" handling with mkdirat() as well.

 2. Adding more multiplexers is bad. openat2(2)

I think (1) alone is a strong enough justification, since I don't think
there's precedent for having two different path lookup semantics in the
same VFS syscall.

> 2. The whole idea of openat2() is that you can add new behaviors
>     with new open_how flags, so no existing app will be surprised from
>     behavior change of  O_CREAT | O_DIRECTORY combination.

While it is true that you *could* do this with openat2(), the intention
of openat2() was to allow us to add new arguments openat() if those
arguments make sense within the context of an "open" operation.

(An example would be the opath_mask stuff which I included in the
original series, and am working on re-sending -- that is an additional
argument for O_PATH, and is still clearly linked to opening something.)

[1]: https://lore.kernel.org/linux-fsdevel/20200313182844.GO23230@ZenIV.lin=
ux.org.uk/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3lj6aomxgfnwchmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYD726QAKCRCdlLljIbnQ
EpcPAQDcjJcO8so/I9gE2av0gVFRECVeqWFkqgav7lCOhCHqGgD/XiCbuv/4+Cwc
Q3kcUk6qnmb7l/bLr/QWxzR6VdCVJQg=
=XW6T
-----END PGP SIGNATURE-----

--3lj6aomxgfnwchmd--
