Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA848C61D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiALOeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiALOef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:34:35 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB36C06173F;
        Wed, 12 Jan 2022 06:34:35 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4JYqnz5Cl6zQjXy;
        Wed, 12 Jan 2022 15:34:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Thu, 13 Jan 2022 01:34:19 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ptikhomirov@virtuozzo.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220112143419.rgxumbts2jjb4aig@senku>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5pumzmarjtdhuhq2"
Content-Disposition: inline
In-Reply-To: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5pumzmarjtdhuhq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
> If you have an opened O_PATH file, currently there is no way to re-open
> it with other flags with openat/openat2. As a workaround it is possible
> to open it via /proc/self/fd/<X>, however
> 1) You need to ensure that /proc exists
> 2) You cannot use O_NOFOLLOW flag

There is also another issue -- you can mount on top of magic-links so if
you're a container runtime that has been tricked into creating bad
mounts of top of /proc/ subdirectories there's no way of detecting that
this has happened. (Though I think in the long-term we will need to
make it possible for unprivileged users to create a procfs mountfd if
they have hidepid=3D4,subset=3Dpids set -- there are loads of things
containers need to touch in procfs which can be overmounted in malicious
ways.)

> Both problems may look insignificant, but they are sensitive for CRIU.
> First of all, procfs may not be mounted in the namespace where we are
> restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
> file with this flag during restore.
>=20
> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> struct open_how and changes getname() call to getname_flags() to avoid
> ENOENT for empty filenames.

This is something I've wanted to implement for a while, but from memory
we need to add some other protections in place before enabling this.

The main one is disallowing re-opening of a path when it was originally
opened with a different set of modes. [1] is the patch I originally
wrote as part of the openat2(2) (but I dropped it since I wasn't sure
whether it might break some systems in subtle ways -- though according
to my testing there wasn't an issue on any of my machines).

I'd can try to revive that patchset if you'd like. Being able to re-open
paths without going through procfs is something I've wanted to finish up
for a while, so thanks for sending this patch. :D

[1]: https://lore.kernel.org/lkml/20190930183316.10190-2-cyphar@cyphar.com/

> Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
> ---
>=20
> Why does even CRIU needs to reopen O_PATH files?
> Long story short: to support restoring opened files that are overmounted
> with single file bindmounts.
> In-depth explanation: when restoring mount tree, before doing mount()
> call, CRIU opens mountpoint with O_PATH and saves this fd for later use
> for each mount. If we need to restore overmounted file, we look at the
> mount which overmounts file mount and use its saved mountpoint fd in
> openat(<saved_fd>, <relative_path>, flags).
> If we need to open an overmounted mountpoint directory itself, we can use
> openat(<saved_fd>, ".", flags). However, if we have a bindmount, its
> mountpoint is a regular file. Therefore to open it we need to be able to
> reopen O_PATH descriptor. As I mentioned above, procfs workaround is
> possible but imposes several restrictions. Not to mention a hussle with
> /proc.
>=20
> Important note: the algorithm above relies on Virtozzo CRIU "mount-v2"
> engine, which is currently being prepared for mainstream CRIU.
> This patch ensures that CRIU will support all kinds of overmounted files.
>=20
>  fs/open.c                    | 4 +++-
>  include/linux/fcntl.h        | 2 +-
>  include/uapi/linux/openat2.h | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/open.c b/fs/open.c
> index f732fb9..cfde988 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1131,6 +1131,8 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  			return -EAGAIN;
>  		lookup_flags |=3D LOOKUP_CACHED;
>  	}
> +	if (how->resolve & RESOLVE_EMPTY_PATH)
> +		lookup_flags |=3D LOOKUP_EMPTY;
> =20
>  	op->lookup_flags =3D lookup_flags;
>  	return 0;
> @@ -1203,7 +1205,7 @@ static long do_sys_openat2(int dfd, const char __us=
er *filename,
>  	if (fd)
>  		return fd;
> =20
> -	tmp =3D getname(filename);
> +	tmp =3D getname_flags(filename, op.lookup_flags, 0);
>  	if (IS_ERR(tmp))
>  		return PTR_ERR(tmp);
> =20
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79..eabc7a8 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -15,7 +15,7 @@
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> -	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_CACHED)
> +	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_CACHED | RESOLVE_EMPTY_PAT=
H)
> =20
>  /* List of all open_how "versions". */
>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> index a5feb76..a42cf88 100644
> --- a/include/uapi/linux/openat2.h
> +++ b/include/uapi/linux/openat2.h
> @@ -39,5 +39,7 @@ struct open_how {
>  					completed through cached lookup. May
>  					return -EAGAIN if that's not
>  					possible. */
> +#define RESOLVE_EMPTY_PATH	0x40 /* If pathname is an empty string, open
> +					the file referred by dirfd */
> =20
>  #endif /* _UAPI_LINUX_OPENAT2_H */
> --=20
> 1.8.3.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--5pumzmarjtdhuhq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYd7m6AAKCRCdlLljIbnQ
EijbAP9taRXH0Rx3FrDRUx7b/y2/91yAXet5lfqjgudLJs2y+QD+POd5BcVXjPm1
cUAx8p6QLoA5J3XoCbw2xFwGsDRa4wY=
=h9MR
-----END PGP SIGNATURE-----

--5pumzmarjtdhuhq2--
