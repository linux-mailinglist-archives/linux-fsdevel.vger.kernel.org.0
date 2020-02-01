Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C639D14F6EC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 07:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgBAG2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 01:28:04 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:18638 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgBAG2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 01:28:04 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 488kfn3DgHzQk03;
        Sat,  1 Feb 2020 07:28:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 23aY_owvYlBV; Sat,  1 Feb 2020 07:27:56 +0100 (CET)
Date:   Sat, 1 Feb 2020 17:27:44 +1100
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
Message-ID: <20200201062744.fehlhq3jtetfcxuw@yavin.dot.cyphar.com>
References: <20200131002750.257358-1-zwisler@google.com>
 <20200131004558.GA6699@bombadil.infradead.org>
 <20200131015134.5ovxakcavk2x4diz@yavin.dot.cyphar.com>
 <20200131212021.GA108613@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wimogbxgdozmpthq"
Content-Disposition: inline
In-Reply-To: <20200131212021.GA108613@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wimogbxgdozmpthq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-31, Ross Zwisler <zwisler@google.com> wrote:
> On Fri, Jan 31, 2020 at 12:51:34PM +1100, Aleksa Sarai wrote:
> > On 2020-01-30, Matthew Wilcox <willy@infradead.org> wrote:
> > > On Thu, Jan 30, 2020 at 05:27:50PM -0700, Ross Zwisler wrote:
> > > > For mounts that have the new "nosymfollow" option, don't follow
> > > > symlinks when resolving paths. The new option is similar in spirit =
to
> > > > the existing "nodev", "noexec", and "nosuid" options. Various BSD
> > > > variants have been supporting the "nosymfollow" mount option for a
> > > > long time with equivalent implementations.
> > > >=20
> > > > Note that symlinks may still be created on file systems mounted with
> > > > the "nosymfollow" option present. readlink() remains functional, so
> > > > user space code that is aware of symlinks can still choose to follow
> > > > them explicitly.
> > > >=20
> > > > Setting the "nosymfollow" mount option helps prevent privileged
> > > > writers from modifying files unintentionally in case there is an
> > > > unexpected link along the accessed path. The "nosymfollow" option is
> > > > thus useful as a defensive measure for systems that need to deal wi=
th
> > > > untrusted file systems in privileged contexts.
> > >=20
> > > The openat2 series was just merged yesterday which includes a
> > > LOOKUP_NO_SYMLINKS option.  Is this enough for your needs, or do you
> > > need the mount option?
> >=20
> > I have discussed a theoretical "noxdev" mount option (which is
> > effectively LOOKUP_NO_XDEV) with Howells (added to Cc) in the past, and
> > the main argument for having a mount option is that you can apply the
> > protection to older programs without having to rewrite them to use
> > openat2(2).
>=20
> Ah, yep, this is exactly what we're trying to achieve with the "nosymfoll=
ow"
> mount option: protect existing programs from malicious filesystems without
> having to modify those programs.
>=20
> The types of attacks we are concerned about are pretty well summarized in=
 this
> LWN article from over a decade ago:
>=20
> https://lwn.net/Articles/250468/
>=20
> And searching around (I just Googled "symlink exploit") it's pretty easy =
to
> find related security blogs and CVEs.
>=20
> The noxdev mount option seems interesting, bug I don't fully understand y=
et
> how it would work.  With the openat2() syscall it's clear which things ne=
ed to
> be part of the same mount: the dfd (or CWD in the case of AT_FDCWD) and t=
he
> filename you're opening.  How would this work for the noxdev mount option=
 and
> the legacy open(2) syscall, for example?  Would you just always compare
> 'pathname' with the current working directory?  Examine 'pathname' and ma=
ke
> sure that if any filesystems in that path have 'noxdev' set, you never
> traverse out of them?  Something else?

The idea is that "noxdev" would be "sticky" (or if you prefer, like a
glue trap). As soon as you walk into a mountpoint that has "noxdev", you
cannot cross any subsequent mountpoint boundaries (a-la LOOKUP_NO_XDEV).

> If noxdev would involve a pathname traversal to make sure you don't ever =
leave
> mounts with noxdev set, I think this could potentially cover the use case=
s I'm
> worried about.  This would restrict symlink traversal to files within the=
 same
> filesystem, and would restrict traversal to both normal and bind mounts f=
rom
> within the restricted filesystem, correct?

Yes, but it would have to block all mountpoint crossings including
bind-mounts, because the obvious way of checking for mountpoint
crossings (vfsmount comparisons) results in bind-mounts being seen as
different mounts. This is how LOOKUP_NO_XDEV works. Would this be a
show-stopped for ChromeOS?

I personally find "noxdev" to be a semantically clearer statement of
intention ("I don't want any lookup that reaches this mount-point to
leave") than "nosymfollow" (though to be fair, this is closer in
semantics to the other "no*" mount flags). But after looking at [1] and
thinking about it for a bit, I don't really have a problem with either
solution.

The only problem is that "noxdev" would probably need to be settable on
bind-mounts, and from [2] it looks like the new mount API struggles with
configuring bind-mounts.

> > However, the underlying argument for "noxdev" was that you could use it
> > to constrain something like "tar -xf" inside a mountpoint (which could
> > -- in principle -- be a bind-mount). I'm not so sure that "nosymfollow"
> > has similar "obviously useful" applications (though I'd be happy to be
> > proven wrong).
>=20
> In ChromeOS we use the LSM referenced in my patch to provide a blanket
> enforcement that symlinks aren't traversed at all on user-supplied
> filesystems, which are considered untrusted.  I'd essentially like to bui=
ld on
> the protections offered by LOOKUP_NO_SYMLINKS and extend that protection =
to
> all accesses to user-supplied filesystems.

Yeah, after writing my mail I took a look at [1] and I agree that having
a solution which helps older programs would be helpful. With openat2 and
libpathrs[3] I'm hoping to lead the charge on a "rewrite userspace"
effort, but waiting around for that to be complete probably isn't a
workable solution. ;)

[1]: https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-des=
ign-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-=
traversal
[2]: https://lwn.net/Articles/809125/
[3]: https://github.com/openSUSE/libpathrs

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--wimogbxgdozmpthq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXjUaXgAKCRCdlLljIbnQ
EltFAQD2Ty11Fy+2kbUzE7CVrlD1V9YfmHIFj5vjMa4D/m1qBAEA08J+gbnEeZTW
+xn3HMUWaUU9MrU5+LeOhxf6NgpN0AE=
=FE6j
-----END PGP SIGNATURE-----

--wimogbxgdozmpthq--
