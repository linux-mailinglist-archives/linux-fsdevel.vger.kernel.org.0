Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD171EB202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFAXKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 19:10:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:55966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgFAXKk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:10:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCB3CAE9D;
        Mon,  1 Jun 2020 23:10:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     yangerkun <yangerkun@huawei.com>, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, neilb@suse.com
Date:   Tue, 02 Jun 2020 09:10:31 +1000
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] locks: add locks_move_blocks in posix_lock_inode
In-Reply-To: <20200601091616.34137-1-yangerkun@huawei.com>
References: <20200601091616.34137-1-yangerkun@huawei.com>
Message-ID: <877dwq757c.fsf@notabene.neil.brown.name>
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

On Mon, Jun 01 2020, yangerkun wrote:

> We forget to call locks_move_blocks in posix_lock_inode when try to
> process same owner and different types.
>

This patch is not necessary.
The caller of posix_lock_inode() must calls locks_delete_block() on
'request', and that will remove all blocked request and retry them.

So calling locks_move_blocks() here is at most an optimization.  Maybe
it is a useful one.

What led you to suggesting this patch?  Were you just examining the
code, or was there some problem that you were trying to solve?

Thanks,
NeilBrown


> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/locks.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/locks.c b/fs/locks.c
> index b8a31c1c4fff..36bd2c221786 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1282,6 +1282,7 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
>  				if (!new_fl)
>  					goto out;
>  				locks_copy_lock(new_fl, request);
> +				locks_move_blocks(new_fl, request);
>  				request =3D new_fl;
>  				new_fl =3D NULL;
>  				locks_insert_lock_ctx(request, &fl->fl_list);
> --=20
> 2.21.3

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7ViucACgkQOeye3VZi
gbng0g//WtmhUjIdqgrHREgsiy9mjpEvQ1Ua730jTlSnkxNNTUrCmqjgn+JwecEa
AfW58U5OROu8i2oOA5/cFVfuVr3GgSzM2IWJKT6z7yj4VRJ0PYrNNlxUDQz+ObCg
8HojpjV7NJ+9KEkwJDZwByAeReS6t4XwnY7lvMYaCYu0Amw2i2+qW4Xpzh5kAshd
7SRycudZCA9g92dJHWt5oMd0tQmxTFGNBZ13ti4ThTKD3w+AN1t7/uSHmtno7dtf
ITq931WAu4DqXPJmgIG2p2ZqD4t99TknB9/8053lnTmrIyTCFHfo4dzcQjLjJC3J
oFW+A7sC+IDm+YbcQL4XbcLvC4DIo5MTLNNxb5+Cz5WnHGLJJVFBWM+f/Z8xXCJa
qq4I/teAYyzk0y6D6XS/9Zfgc0XtK4s6n6CwkRI3OeBvutmomDUbOiL4my+FmnCR
KA7Sxyeu4UqUYf6bsTQtgek/s4PQ3mH5fy6da9YCh8R9jrA+YfYJQZx7y61iWqmK
rfzfaEnvQQXDGGWncxLfNSb2Tr5scSrJE+oyhvhu+l02d2wspg09JMoa0uqd5a15
Fey1ZVFYsF5YilFrzlptZOxIZ3bGUqiYiRAaKeXoJLzqMHPEfa7gLAd5Z2EcDpcX
OZGf02rMZUw6ausnBa4O7141WbI2XQ3su+DLfr+cjw9DFi1HYLU=
=8TRf
-----END PGP SIGNATURE-----
--=-=-=--
