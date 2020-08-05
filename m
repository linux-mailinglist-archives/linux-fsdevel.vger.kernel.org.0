Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB023C412
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 05:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHEDsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 23:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEDsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:48:21 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C058C06174A;
        Tue,  4 Aug 2020 20:48:21 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4BLyJb1zSNzKmR9;
        Wed,  5 Aug 2020 05:48:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id E-94TVlXGldS; Wed,  5 Aug 2020 05:48:10 +0200 (CEST)
Date:   Wed, 5 Aug 2020 13:47:58 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     viro@zeniv.linux.org.uk, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, jmorris@namei.org, kaleshsingh@google.com,
        dancol@dancol.org, surenb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nnk@google.com, jeffv@google.com, calin@google.com,
        kernel-team@android.com, yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
Message-ID: <20200805034758.lrobunwdcqtknsvz@yavin.dot.cyphar.com>
References: <20200804203155.2181099-1-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jx4te5hbjl6sds64"
Content-Disposition: inline
In-Reply-To: <20200804203155.2181099-1-lokeshgidra@google.com>
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -7.10 / 15.00 / 15.00
X-Rspamd-Queue-Id: F24341768
X-Rspamd-UID: 5729ac
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jx4te5hbjl6sds64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-04, Lokesh Gidra <lokeshgidra@google.com> wrote:
> when get_unused_fd_flags returns error, ctx will be freed by
> userfaultfd's release function, which is indirectly called by fput().
> Also, if anon_inode_getfile_secure() returns an error, then
> userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
>=20
> Also, the O_CLOEXEC was inadvertently added to the call to
> get_unused_fd_flags() [1].

I disagree that it is "wrong" to do O_CLOEXEC-by-default (after all,
it's trivial to disable O_CLOEXEC, but it's non-trivial to enable it on
an existing file descriptor because it's possible for another thread to
exec() before you set the flag). Several new syscalls and fd-returning
facilities are O_CLOEXEC-by-default now (the most obvious being pidfds
and seccomp notifier fds).

At the very least there should be a new flag added that sets O_CLOEXEC.

> Adding Al Viro's suggested-by, based on [2].
>=20
> [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dan=
col.org/
> [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org=
=2Euk/
>=20
> Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/userfaultfd.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index ae859161908f..e15eb8fdc083 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2042,24 +2042,18 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
>  		NULL);
>  	if (IS_ERR(file)) {
> -		fd =3D PTR_ERR(file);
> -		goto out;
> +		userfaultfd_ctx_put(ctx);
> +		return PTR_ERR(file);
>  	}
> =20
> -	fd =3D get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> +	fd =3D get_unused_fd_flags(O_RDONLY);
>  	if (fd < 0) {
>  		fput(file);
> -		goto out;
> +		return fd;
>  	}
> =20
>  	ctx->owner =3D file_inode(file);
>  	fd_install(fd, file);
> -
> -out:
> -	if (fd < 0) {
> -		mmdrop(ctx->mm);
> -		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> -	}
>  	return fd;
>  }
> =20
> --=20
> 2.28.0.163.g6104cc2f0b6-goog
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jx4te5hbjl6sds64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXyor6wAKCRCdlLljIbnQ
EvlBAP9yT6247DlCIs/Tflt7TprvwpvnjAbnWJ/71XH7JGf3EgEA0OLS0YoSm9zV
dHgGAW0D6J8tKTslxFA785dqofjTKQ4=
=l25V
-----END PGP SIGNATURE-----

--jx4te5hbjl6sds64--
