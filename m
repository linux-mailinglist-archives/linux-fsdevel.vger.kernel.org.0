Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0AA19A56E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 08:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgDAGge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 02:36:34 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:21874 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgDAGge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:36:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48sc0w1R4KzKmY1;
        Wed,  1 Apr 2020 08:36:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id js2ytioAFpyE; Wed,  1 Apr 2020 08:36:28 +0200 (CEST)
Date:   Wed, 1 Apr 2020 17:36:20 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/1] mnt: add support for non-rootfs initramfs
Message-ID: <20200401063620.catm73fbp5n4wv5r@yavin.dot.cyphar.com>
References: <20200331124017.2252-1-ignat@cloudflare.com>
 <20200331124017.2252-2-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dattthwtdkziyn66"
Content-Disposition: inline
In-Reply-To: <20200331124017.2252-2-ignat@cloudflare.com>
X-Rspamd-Queue-Id: E475A1768
X-Rspamd-Score: -5.72 / 15.00 / 200.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--dattthwtdkziyn66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-31, Ignat Korchagin <ignat@cloudflare.com> wrote:
> The main need for this is to support container runtimes on stateless Linux
> system (pivot_root system call from initramfs).
>=20
> Normally, the task of initramfs is to mount and switch to a "real" root
> filesystem. However, on stateless systems (booting over the network) it i=
s just
> convenient to have your "real" filesystem as initramfs from the start.
>=20
> This, however, breaks different container runtimes, because they usually =
use
> pivot_root system call after creating their mount namespace. But pivot_ro=
ot does
> not work from initramfs, because initramfs runs form rootfs, which is the=
 root
> of the mount tree and can't be unmounted.
>=20
> One workaround is to do:
>=20
>   mount --bind / /
>=20
> However, that defeats one of the purposes of using pivot_root in the clon=
ed
> containers: get rid of host root filesystem, should the code somehow esca=
pes the
> chroot.
>=20
> There is a way to solve this problem from userspace, but it is much more
> cumbersome:
>   * either have to create a multilayered archive for initramfs, where the=
 outer
>     layer creates a tmpfs filesystem and unpacks the inner layer, switche=
s root
>     and does not forget to properly cleanup the old rootfs
>   * or we need to use keepinitrd kernel cmdline option, unpack initramfs =
to
>     rootfs, run a script to create our target tmpfs root, unpack the same
>     initramfs there, switch root to it and again properly cleanup the old=
 root,
>     thus unpacking the same archive twice and also wasting memory, because
>     the kernel stores compressed initramfs image indefinitely.
>=20
> With this change we can ask the kernel (by specifying nonroot_initramfs k=
ernel
> cmdline option) to create a "leaf" tmpfs mount for us and switch root to =
it
> before the initramfs handling code, so initramfs gets unpacked directly i=
nto
> the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
>=20
> This also bring the behaviour in line with the older style initrd, where =
the
> initrd is located on some leaf filesystem in the mount tree and rootfs re=
maining
> empty.
>=20
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

I know this is a bit of a stretch, but I thought I'd ask -- is it
possible to solve the problem with pivot_root(2) without requiring this
workaround (and an additional cmdline option)?

=46rom the container runtime side of things, most runtimes do support
working on initramfs but it requires disabling pivot_root(2) support (in
the runc world this is --no-pivot-root). We would love to be able to
remove support for disabling pivot_root(2) because lots of projects have
been shipping with pivot_root(2) disabled (such as minikube until
recently[1]) -- which opens such systems to quite a few breakout and
other troubling exploits (obviously they also ship without using user
namespaces *sigh*).

But requiring a new cmdline option might dissuade people from switching.
If there was a way to fix the underlying restriction on pivot_root(2),
I'd be much happier with that as a solution.

Thanks.

[1]: https://github.com/kubernetes/minikube/issues/3512

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--dattthwtdkziyn66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXoQ2YQAKCRCdlLljIbnQ
EsqbAQCzUVRv7mGop3mil8yPbso8Byb9FxHHrFiZIzynSJ0YugEAprVnPJR6YVzR
vi42pvRVA97JTxScX4X7vqSNi3ClxQQ=
=ZNXA
-----END PGP SIGNATURE-----

--dattthwtdkziyn66--
