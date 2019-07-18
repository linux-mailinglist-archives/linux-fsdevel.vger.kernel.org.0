Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38956C6AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 05:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbfGRDSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 23:18:31 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:39012 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389508AbfGRDSa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:18:30 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id F35D54FE71;
        Thu, 18 Jul 2019 05:18:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id nZ38r1RPFd3K; Thu, 18 Jul 2019 05:18:14 +0200 (CEST)
Date:   Thu, 18 Jul 2019 13:17:29 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190718031729.scehpjydhuxgxqjy@yavin>
References: <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
 <20190712150026.GO17978@ZenIV.linux.org.uk>
 <20190713024153.GA3817@ZenIV.linux.org.uk>
 <20190714070029.m53etvm3y4etidxt@yavin>
 <20190714143623.GR17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4aw3kgjubxi6rqg"
Content-Disposition: inline
In-Reply-To: <20190714143623.GR17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--z4aw3kgjubxi6rqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-14, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Jul 14, 2019 at 05:00:29PM +1000, Aleksa Sarai wrote:
> > The basic property being guaranteed by LOOKUP_IN_ROOT is that it will
> > not result in resolution of a path component which was not inside the
> > root of the dirfd tree at some point during resolution (and that all
> > absolute symlink and ".." resolution will be done relative to the
> > dirfd). This may smell slightly of chroot(2), because unfortunately it
> > is a similar concept -- the reason for this is to allow for a more
> > efficient way to safely resolve paths inside a rootfs than spawning a
> > separate process to then pass back the fd to the caller.
>=20
> IDGI...  If attacker can modify your subtree, you have already lost -
> after all, they can make anything appear inside that tree just before
> your syscall is made and bring it back out immediately afterwards.
> And if they can't, what is the race you are trying to protect against?
> Confused...

I'll be honest, this code mostly exists because Jann Horn said that it
was necessary in order for this interface to be safe against those kinds
of attacks. Though, it's also entirely possible I just am
mis-remembering the attack scenario he described when I posted v1 of
this series last year.

The use-case I need this functionality for (as do other container
runtimes) is one where you are trying to safely interact with a
directory tree that is a (malicious) container's root filesystem -- so
the container won't be able to move the directory tree root, nor can
they move things outside the rootfs into it (or the reverse). Users
dealing with FTP, web, or file servers probably have similar
requirements.

There is an obvious race condition if you allow the attacker to move the
root (I give an example and test-case of it in the last patch in the
series), and given that it is fairly trivial to defend against I don't
see the downside in including it? But it's obviously your call -- and
maybe Jann Horn can explain the reasoning behind this much better than I
can.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--z4aw3kgjubxi6rqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXS/kxgAKCRCdlLljIbnQ
Eo0/AQD7a5jDbww9O+NZeirpVja2r3Y2CFcg1rTXSOeRjy321gEAoJhiO3HmSR50
nG/Ogapy7jTKDSyCcC7BfUZDZSz67go=
=wzlY
-----END PGP SIGNATURE-----

--z4aw3kgjubxi6rqg--
