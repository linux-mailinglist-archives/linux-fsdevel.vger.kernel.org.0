Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1615254C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBEDp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 22:45:27 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:26580 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgBEDp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:45:27 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48C6sJ5VnPzQl97;
        Wed,  5 Feb 2020 04:45:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id jzTnhcMhNmm9; Wed,  5 Feb 2020 04:45:21 +0100 (CET)
Date:   Wed, 5 Feb 2020 14:45:00 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ross Zwisler <zwisler@chromium.org>,
        Raul Rangel <rrangel@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
Message-ID: <20200205034500.x3omkziqwu3g5gpx@yavin>
References: <20200204215014.257377-1-zwisler@google.com>
 <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
 <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
 <20200205032110.GR8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cims4dzb2cjilfys"
Content-Disposition: inline
In-Reply-To: <20200205032110.GR8731@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cims4dzb2cjilfys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-04, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Feb 04, 2020 at 04:49:48PM -0700, Ross Zwisler wrote:
> > On Tue, Feb 4, 2020 at 3:11 PM Ross Zwisler <zwisler@chromium.org> wrot=
e:
> > > On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > > > > --- a/include/uapi/linux/mount.h
> > > > > +++ b/include/uapi/linux/mount.h
> > > > > @@ -34,6 +34,7 @@
> > > > >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> > > > >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> > > > >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times =
lazily */
> > > > > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> > > > Doesn't this conflict with MS_SUBMOUNT below?
> > > > >
> > > > >  /* These sb flags are internal to the kernel */
> > > > >  #define MS_SUBMOUNT     (1<<26)
> > >
> > > Yep.  Thanks for the catch, v6 on it's way.
> >=20
> > It actually looks like most of the flags which are internal to the
> > kernel are actually unused (MS_SUBMOUNT, MS_NOREMOTELOCK, MS_NOSEC,
> > MS_BORN and MS_ACTIVE).  Several are unused completely, and the rest
> > are just part of the AA_MS_IGNORE_MASK which masks them off in the
> > apparmor LSM, but I'm pretty sure they couldn't have been set anyway.
> >=20
> > I'll just take over (1<<26) for MS_NOSYMFOLLOW, and remove the rest in
> > a second patch.
> >=20
> > If someone thinks these flags are actually used by something and I'm
> > just missing it, please let me know.
>=20
> Afraid you did miss it ...
>=20
> /*
>  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
>  * represented in both.
>  */
> ...
> #define SB_SUBMOUNT     (1<<26)
>=20
> It's not entirely clear to me why they need to be the same, but I haven't
> been paying close attention to the separation of superblock and mount
> flags, so someone else can probably explain the why of it.

I could be wrong, but I believe this is historic and originates from the
kernel setting certain flags internally (similar to the whole O_* flag,
"internal" O_* flag, and FMODE_NOTIFY mixup).

Also, one of the arguments for the new mount API was that we'd run out
MS_* bits so it's possible that you have to enable this new mount option
in the new mount API only. (Though Howells is the right person to talk
to on this point.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cims4dzb2cjilfys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXjo6OQAKCRCdlLljIbnQ
ElG7AQCJBIyk342KmYvS4G0NXRtiMxMWYkPsDE1cJSq8ZHMSAAEAsY1+Gaw3srD+
cjfrtIlThKqAxyfkH2TZTgPG+4+k/QE=
=abwl
-----END PGP SIGNATURE-----

--cims4dzb2cjilfys--
