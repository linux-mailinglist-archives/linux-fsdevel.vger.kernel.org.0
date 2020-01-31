Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F420314E6E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 02:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgAaBvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 20:51:54 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:63440 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgAaBvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 20:51:54 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4880Zb4HwvzKmbG;
        Fri, 31 Jan 2020 02:51:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id MWeK3efgu-qD; Fri, 31 Jan 2020 02:51:47 +0100 (CET)
Date:   Fri, 31 Jan 2020 12:51:34 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add a "nosymfollow" mount option.
Message-ID: <20200131015134.5ovxakcavk2x4diz@yavin.dot.cyphar.com>
References: <20200131002750.257358-1-zwisler@google.com>
 <20200131004558.GA6699@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a2ekpxn36mkkxtgo"
Content-Disposition: inline
In-Reply-To: <20200131004558.GA6699@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--a2ekpxn36mkkxtgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-30, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Jan 30, 2020 at 05:27:50PM -0700, Ross Zwisler wrote:
> > For mounts that have the new "nosymfollow" option, don't follow
> > symlinks when resolving paths. The new option is similar in spirit to
> > the existing "nodev", "noexec", and "nosuid" options. Various BSD
> > variants have been supporting the "nosymfollow" mount option for a
> > long time with equivalent implementations.
> >=20
> > Note that symlinks may still be created on file systems mounted with
> > the "nosymfollow" option present. readlink() remains functional, so
> > user space code that is aware of symlinks can still choose to follow
> > them explicitly.
> >=20
> > Setting the "nosymfollow" mount option helps prevent privileged
> > writers from modifying files unintentionally in case there is an
> > unexpected link along the accessed path. The "nosymfollow" option is
> > thus useful as a defensive measure for systems that need to deal with
> > untrusted file systems in privileged contexts.
>=20
> The openat2 series was just merged yesterday which includes a
> LOOKUP_NO_SYMLINKS option.  Is this enough for your needs, or do you
> need the mount option?

I have discussed a theoretical "noxdev" mount option (which is
effectively LOOKUP_NO_XDEV) with Howells (added to Cc) in the past, and
the main argument for having a mount option is that you can apply the
protection to older programs without having to rewrite them to use
openat2(2).

However, the underlying argument for "noxdev" was that you could use it
to constrain something like "tar -xf" inside a mountpoint (which could
-- in principle -- be a bind-mount). I'm not so sure that "nosymfollow"
has similar "obviously useful" applications (though I'd be happy to be
proven wrong).

If FreeBSD also has "nosymfollow", are there many applications where it
is used over O_BENEATH (and how many would be serviced by
LOOKUP_NO_SYMLINKS)?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--a2ekpxn36mkkxtgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXjOIIwAKCRCdlLljIbnQ
EnRJAP4uFywWOb6ReIzsqzsKt7+dBNFkydGZSn1Mh5kVnCOLDwD+KBQlXVWnVeCC
e9GY+E9f+wfO76G+HUmfdcIieDBmaw0=
=nzA6
-----END PGP SIGNATURE-----

--a2ekpxn36mkkxtgo--
