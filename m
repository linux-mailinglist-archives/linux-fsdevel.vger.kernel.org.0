Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB81569C6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBIJNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 04:13:01 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:47324 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgBIJNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 04:13:01 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48FjxR4HyFzKmMG;
        Sun,  9 Feb 2020 10:12:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id nwUnxkLyPZYA; Sun,  9 Feb 2020 10:12:56 +0100 (CET)
Date:   Sun, 9 Feb 2020 20:12:36 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ross Zwisler <zwisler@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add a "nosymfollow" mount option.
Message-ID: <20200209091236.bmozkgo6jvfiakei@yavin>
References: <20200131002750.257358-1-zwisler@google.com>
 <20200131004558.GA6699@bombadil.infradead.org>
 <20200131015134.5ovxakcavk2x4diz@yavin.dot.cyphar.com>
 <20200131212021.GA108613@google.com>
 <20200201062744.fehlhq3jtetfcxuw@yavin.dot.cyphar.com>
 <20200203221556.GA210383@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w2fwkytlxy5l6uyv"
Content-Disposition: inline
In-Reply-To: <20200203221556.GA210383@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--w2fwkytlxy5l6uyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-03, Ross Zwisler <zwisler@google.com> wrote:
> On Sat, Feb 01, 2020 at 05:27:44PM +1100, Aleksa Sarai wrote:
> > On 2020-01-31, Ross Zwisler <zwisler@google.com> wrote:
> > > On Fri, Jan 31, 2020 at 12:51:34PM +1100, Aleksa Sarai wrote:
> > > If noxdev would involve a pathname traversal to make sure you don't e=
ver leave
> > > mounts with noxdev set, I think this could potentially cover the use =
cases I'm
> > > worried about.  This would restrict symlink traversal to files within=
 the same
> > > filesystem, and would restrict traversal to both normal and bind moun=
ts from
> > > within the restricted filesystem, correct?
> >=20
> > Yes, but it would have to block all mountpoint crossings including
> > bind-mounts, because the obvious way of checking for mountpoint
> > crossings (vfsmount comparisons) results in bind-mounts being seen as
> > different mounts. This is how LOOKUP_NO_XDEV works. Would this be a
> > show-stopped for ChromeOS?
> >
> > I personally find "noxdev" to be a semantically clearer statement of
> > intention ("I don't want any lookup that reaches this mount-point to
> > leave") than "nosymfollow" (though to be fair, this is closer in
> > semantics to the other "no*" mount flags). But after looking at [1] and
> > thinking about it for a bit, I don't really have a problem with either
> > solution.
>=20
> For ChromeOS we want to protect data both on user-provided filesystems (i=
=2Ee.
> USB attached drives and the like) as well as on our "stateful" partition.=
 =20
>=20
> The noxdev mount option would resolve our concerns for user-provided
> filesystems, but I don't think that we would be able to use it for statef=
ul
> because symlinks on stateful that point elsewhere within stable are still=
 a
> security risk.  There is more explanation on why this is the case in [1].
> Thank you for linking to that, by the way.
>=20
> I think our security concerns around both use cases, user-provided filesy=
stems
> and the stateful partition, can be resolved in ChromeOS with the nosymfol=
low
> mount flag.  Based on that, my current preference is for the 'nosymfollow'
> mount flag.

Fair enough. I can work on and send "noxdev" separately -- I only
brought it up because the attack scenarios (and connection to openat2)
are both fairly similar.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--w2fwkytlxy5l6uyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXj/NAQAKCRCdlLljIbnQ
EtbUAP9JDuq/b7ffYaKS3Gp4bRaEE8IupMekUzpB87ycOwm45gEAh5As6Y7p7XbA
OK6Tp8HF2Vlyq1K17ogTsFV793JOtAM=
=PPVH
-----END PGP SIGNATURE-----

--w2fwkytlxy5l6uyv--
