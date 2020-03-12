Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF2183BDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 23:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCLWEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 18:04:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgCLWEO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:04:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CFC0AD10;
        Thu, 12 Mar 2020 22:04:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org
Date:   Fri, 13 Mar 2020 09:04:01 +1100
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 3/4] docs: admin-guide: document the kernel.modprobe sysctl
In-Reply-To: <20200312202552.241885-4-ebiggers@kernel.org>
References: <20200312202552.241885-1-ebiggers@kernel.org> <20200312202552.241885-4-ebiggers@kernel.org>
Message-ID: <87lfo5telq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12 2020, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
>
> Document the kernel.modprobe sysctl in the same place that all the other
> kernel.* sysctls are documented.  Make sure to mention how to use this
> sysctl to completely disable module autoloading, and how this sysctl
> relates to CONFIG_STATIC_USERMODEHELPER.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 25 ++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index def074807cee9..454f3402ed321 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -49,7 +49,7 @@ show up in /proc/sys/kernel:
>  - kexec_load_disabled
>  - kptr_restrict
>  - l2cr                        [ PPC only ]
> -- modprobe                    =3D=3D> Documentation/debugging-modules.txt
> +- modprobe
>  - modules_disabled
>  - msg_next_id		      [ sysv ipc ]
>  - msgmax
> @@ -444,6 +444,29 @@ l2cr: (PPC only)
>  This flag controls the L2 cache of G3 processor boards. If
>  0, the cache is disabled. Enabled if nonzero.
>=20=20
> +modprobe:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The path to the usermode helper for autoloading kernel modules, by
> +default "/sbin/modprobe".  This binary is executed when the kernel
> +requests a module.  For example, if userspace passes an unknown
> +filesystem type "foo" to mount(), then the kernel will automatically
> +request the module "fs-foo.ko" by executing this usermode helper.

I don't think it is right to add the ".ko" there.  The string "fs-foo"
is what is passed to the named executable, and it make well end up
loading "bar.ko", depending what aliases are set up.
I would probably write  '... request the module named 'fs-foo" by executing=
..'
(The "name" for a module can come from the file that stores it, and
alias inside it, or configuration in modprobe.d).

Thanks,
NeilBrown


> +This usermode helper should insert the needed module into the kernel.
> +
> +This sysctl only affects module autoloading.  It has no effect on the
> +ability to explicitly insert modules.
> +
> +If this sysctl is set to the empty string, then module autoloading is
> +completely disabled.  The kernel will not try to execute a usermode
> +helper at all, nor will it call the kernel_module_request LSM hook.
> +
> +If CONFIG_STATIC_USERMODEHELPER=3Dy is set in the kernel configuration,
> +then the configured static usermode helper overrides this sysctl,
> +except that the empty string is still accepted to completely disable
> +module autoloading as described above.
> +
> +Also see Documentation/debugging-modules.txt.
>=20=20
>  modules_disabled:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --=20
> 2.25.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5qsdIACgkQOeye3VZi
gbn66xAAoMNNHX1PULvhsHSbkF3UGaE7PJY1e+MKP/fPDfQivfsYuhR4s89O4Cw7
/DFNbtCBNmGLnb6I1CDP9LDTFT18HxuSojFxnr1DvEImeDL/YNcvPk2EtkPbd6f/
Mcm9zW4yvv1QvKmHnw+ukncp4M1J/KBVMMXJzFXAhWmOi9oFqYLMzKgNlroNqe2P
bn4Q1mJ4fRWnkModSNQJcqGXy46rmsc/ef2J6IYTsZGMNI0xig1zgT3FJNjQMCt6
Nga0sI9wPWlT9rsKRNBdmb6TJ6vUMqEpOZ3SHKgqnZPF6k5K7sayWbTnKnnbbblI
flRf8QC302BfEkMumI3n3JZrXvU24kE7O+o7cSGFUBiQX759/KETGVJOKqQ0ZOc2
IheqvM4U1+1XOfnLVRX2+hbMN6b3IxPX1+U0kV5KCZxU3526MNIxDqbi8XnjK/QS
s2OM60IUR0mAwZRFoKt0ca54eRuFhsG+fA9EWw7FuQy5tOMPJ0c9KY+PRY9P8OmU
CfrmU7NzTzXZgkcieVn9oBy27U7n3yttCfrzoIM2jTfNWJHlX3Eg0yzZR1+lDLeU
QiR36E8E/UT+S8ELBITSj5kMJ3+hWubsCzWRNwP6ZXqkjMnaPFyx7Sl3H/tehDiq
qjhSV7vh9sT5XAuOQgngCh6s2/C5m28g3Mm6YKC1D/zRXnSvl7E=
=4QNp
-----END PGP SIGNATURE-----
--=-=-=--
