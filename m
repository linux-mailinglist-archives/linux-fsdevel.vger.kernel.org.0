Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDDCA19D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfH2MQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:16:09 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:28272 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfH2MQI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:16:08 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2ACB4A1069;
        Thu, 29 Aug 2019 14:16:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id WXJzDwa0kR9t; Thu, 29 Aug 2019 14:15:51 +0200 (CEST)
Date:   Thu, 29 Aug 2019 22:15:27 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
Message-ID: <20190829121527.u2uvdyeatme5cgkb@yavin>
References: <20190820033406.29796-1-cyphar@cyphar.com>
 <20190820033406.29796-8-cyphar@cyphar.com>
 <CAKOZuesfxRBJe314rkTKXtjXdz6ki3uAUBYVbu5Q2rd3=ADphQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ys4y6f5eyfdosi3x"
Content-Disposition: inline
In-Reply-To: <CAKOZuesfxRBJe314rkTKXtjXdz6ki3uAUBYVbu5Q2rd3=ADphQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ys4y6f5eyfdosi3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-24, Daniel Colascione <dancol@google.com> wrote:
> On Mon, Aug 19, 2019 at 8:37 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > The most obvious syscall to add support for the new LOOKUP_* scoping
> > flags would be openat(2). However, there are a few reasons why this is
> > not the best course of action:
> >
> >  * The new LOOKUP_* flags are intended to be security features, and
> >    openat(2) will silently ignore all unknown flags. This means that
> >    users would need to avoid foot-gunning themselves constantly when
> >    using this interface if it were part of openat(2). This can be fixed
> >    by having userspace libraries handle this for users[1], but should be
> >    avoided if possible.
> >
> >  * Resolution scoping feels like a different operation to the existing
> >    O_* flags. And since openat(2) has limited flag space, it seems to be
> >    quite wasteful to clutter it with 5 flags that are all
> >    resolution-related. Arguably O_NOFOLLOW is also a resolution flag but
> >    its entire purpose is to error out if you encounter a trailing
> >    symlink -- not to scope resolution.
> >
> >  * Other systems would be able to reimplement this syscall allowing for
> >    cross-OS standardisation rather than being hidden amongst O_* flags
> >    which may result in it not being used by all the parties that might
> >    want to use it (file servers, web servers, container runtimes, etc).
> >
> >  * It gives us the opportunity to iterate on the O_PATH interface. In
> >    particular, the new @how->upgrade_mask field for fd re-opening is
> >    only possible because we have a clean slate without needing to re-use
> >    the ACC_MODE flag design nor the existing openat(2) @mode semantics.
> >
> > To this end, we introduce the openat2(2) syscall. It provides all of the
> > features of openat(2) through the @how->flags argument, but also
> > also provides a new @how->resolve argument which exposes RESOLVE_* flags
> > that map to our new LOOKUP_* flags. It also eliminates the long-standing
> > ugliness of variadic-open(2) by embedding it in a struct.
> >
> > In order to allow for userspace to lock down their usage of file
> > descriptor re-opening, openat2(2) has the ability for users to disallow
> > certain re-opening modes through @how->upgrade_mask. At the moment,
> > there is no UPGRADE_NOEXEC. The open_how struct is padded to 64 bytes
> > for future extensions (all of the reserved bits must be zeroed).
>=20
> Why pad the structure when new functionality (perhaps accommodated via
> a larger structure) could be signaled by passing a new flag? Adding
> reserved fields to a structure with a size embedded in the ABI makes a
> lot of sense --- e.g., pthread_mutex_t can't grow. But this structure
> can grow, so the reservation seems needless to me.

Quite a few folks have said that ->reserved is either unnecessary or
too big. I will be changing this, though I am not clear what the best
way of extending the structure is. If anyone has a strong opinion on
this (or an alternative to the ones listed below), please chime in. I
don't have any really strong attachment to this aspect of the API.

There appear to be a few ways we can do it (that all have precedence
with other syscalls):

 1. Use O_* flags to indicate extensions.
 2. A separate "version" field that is incremented when we change.
 3. Add a size_t argument to openat2(2).
 4. Reserve space (as in this patchset).

(My personal preference would be (3), followed closely by (2).)

The main problem with (1) is that it pollutes the open(2) and openat(2)
syscalls with new O_* flags, which is probably not a good API decision
(syscall flags are already "bad" enough, let's not throw a bunch of
no-ops into the mix).

(2) is mostly fine except for a slight issue of ergonomics (glibc would
have to auto-fill the version field or make wrappers in order to make it
easier to use sanely). But this does have the benefit that we could
re-arrange fields (not that this is something we'd want to do anyway).

Both (1) and (2) have the problem that the "struct version" is inside
the struct so we'd need to copy_from_user() twice. This isn't the end of
the world, it just feels a bit less clean than is ideal. (3) fixes that
problem, at the cost of making the API slightly more cumbersome to use
directly (though again glibc could wrap that away).

And the downsides of (4) are pretty well discussed already.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ys4y6f5eyfdosi3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXWfB2wAKCRCdlLljIbnQ
EljcAQC+BitddeHjv2a9yspU0gLaZB6nn8UBahZIqiE8+4xUoAEAuibGdlSM4ag8
ZYal7PGiNelUZH1S6GPHj1bvVNNGOQ0=
=OczH
-----END PGP SIGNATURE-----

--ys4y6f5eyfdosi3x--
